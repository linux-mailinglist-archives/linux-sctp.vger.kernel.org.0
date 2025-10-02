Return-Path: <linux-sctp+bounces-626-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B35BB36A4
	for <lists+linux-sctp@lfdr.de>; Thu, 02 Oct 2025 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D4D323EFF
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Oct 2025 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990472FFDFB;
	Thu,  2 Oct 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsUIbsoN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFA2EA74D
	for <linux-sctp@vger.kernel.org>; Thu,  2 Oct 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396495; cv=none; b=RwbqV067Kazyems+2eTdJeeJ3UDYv/FBGKTfIYEzMT4bpMIo1cEGc31gt69cbWmczso7YLDue/MMvaoohlWZ64zNIpL98XcPmf7nT5OAJSlAszrtGf6cNs66R6Vr6Js+26xuta8Eys1eLx9IpToZtuQHKgkgLjM969jBFWF9hOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396495; c=relaxed/simple;
	bh=siG1bgYonAEUTQ2s8Ux8Lu0beD0iJQSpmvEU3NcNK3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxGn1EadEHqDDsfG4UkGyraWRI/O4PtUSwmtc/3t9/+Cfvx6bADERMoECmTk/bOE+U8Gpn/Qrk1wkv3gnelfe9RTQQVst0RJInwn8SqBjygECzRs8cAjG0RR/dpbVZO+iiy4JhFQQj4D4ATduzBdKBHksH9368ray8bOdNfVb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsUIbsoN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57992ba129eso1037427e87.3
        for <linux-sctp@vger.kernel.org>; Thu, 02 Oct 2025 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396492; x=1760001292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSM6CM5P15ezEZnt0ve39/mjKYvov3ryn3t/1wlMyQk=;
        b=fsUIbsoNTfjlJbuyLjKLE8zfqVBn7HLAH2HxmR8m2ZYR62jezqgXFgm7EXvQL6h8GG
         Q0SiyOnqGP86GBDy+LjUimDYiul6PtHaA+m0vrHXxJJ44R5ugVcaw+mDQwFCUcgdXOUf
         NjZzQXzdAHT98PNP2mG3avIWxGExCasOoJwCXboycJ+ZgUmUPfw9KdOlvAzVw0Qv3mQV
         Cwx/a4/h05AFU1+UUVe4zylZDfu6Ptw0liLtnE3uOKejOGsihp7581jRqMHH2/Ov6gkM
         safgfZ0aLGwB1HnciSnw0+ItWQas3vP4uqThMdLGhlpLFmFcX04dgIhjDj5AP5JF2RpJ
         9HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396492; x=1760001292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSM6CM5P15ezEZnt0ve39/mjKYvov3ryn3t/1wlMyQk=;
        b=AJhMXs4I/Z2x+EUy61fGKBDr0aW3VlqKdk8YEfYurGhzjVV7LGjd8o8X7k2LFyY5Q5
         HOMXVT5USx9KUcKIcPh0yNwm3KCm4vBREVlihdAvKC1KK/IrHsVwsPFvQ1op+RSvoBtL
         8G5ZAknUTSPSgEAfdzw6UIS+0FSXKM6OraPpyMeJTYtgOsUMrchRzLx9OuRde92aH+v3
         PiKfnvxQ/uwFLzOwb65Tp+XCKSBPPqhAXBWytl2O1gbG/mqyp2NezSrdav1i1UPLEqtH
         BPB6WyH9LYJgaFLgwARpvO1VW6RRabGDraRYoG0ZmR3Isquf7zwkzH+/NXTmaqv9RHRz
         QDYg==
X-Forwarded-Encrypted: i=1; AJvYcCXRVQjyN3U6J3s03H3t8HX6rmDSVx6G/UeJydMJH/pEkjIcN3wOHPD8MZ08OguH1ik/65aQi2iCnnyl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyej2BPxtHnSSDoFT66vXAKySwYtLMzmItGz7Ek5oIv3JFBD8cR
	fZudrbB6lJ77tvgvm9R0RRtV1+jtWFBnXXWHmZsMd8qsghT7ql+VE+Qf1tgWRSkN2qY=
X-Gm-Gg: ASbGncs4IWMtlQop2fmIOhs+E6zYbQjSHsidPNSJjxS/9bkd4vrwC0rhZSrwr8R/8XE
	e3kBQQElHxefNC+IZivm/hbc3qFgflv7sDTZQ7XeSaPhCCrVjgtD9deKFuGQIesOP/8cN0OPiCN
	ljCwEtJdd8ayyf5T4C/TmfLdPaUaYqr3nKeaoHagsak0uDPN3bdTRTHqqFrcBUWIu+exgL+tqE1
	RdocfCYV/e5nuAJJt0Y3n6dQAdWFUxjzbt86UIwIwGXhOVG1MEGdvWcVl/vefeNS59NAwb0NBQf
	QRZY++iDcybC2g16zeXj991gWsIr6icHAqRJ2JZwq1nkaWcZQm0oswjD7c37SdLKQ5l6Ge/b1Ht
	OTB69EAs8ZpzxqDTMiYWxJQgnMxG6/JaDQoIaidnfvfcd0m/9mgYxO5ancd3SgD1AEpJiZeOt1j
	cVWvX2g8g0jOPJGhXYqFjScqSIYat8n/TksFqL/5rCZ974gztNLiA=
X-Google-Smtp-Source: AGHT+IGWYt7Zzu4cL1+wVfYqBSH7iBbYGrSdD+ADAvQhIvYKCsdF8o+ver4QC9QADVpDHqDv4CErAA==
X-Received: by 2002:a05:6512:3d9e:b0:55f:71d2:e5be with SMTP id 2adb3069b0e04-58af9f4ea35mr2108491e87.52.1759396491883;
        Thu, 02 Oct 2025 02:14:51 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e4a5sm650494e87.93.2025.10.02.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:14:51 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
Date: Thu,  2 Oct 2025 12:14:47 +0300
Message-ID: <20251002091448.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

If new_asoc->peer.adaptation_ind=0 and sctp_ulpevent_make_authkey=0 
and sctp_ulpevent_make_authkey() returns 0, then the variable 
ai_ev remains zero and the zero will be dereferenced 
in the sctp_ulpevent_free() function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..056544e1ca15 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.43.0


