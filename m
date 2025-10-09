Return-Path: <linux-sctp+bounces-631-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A0BCA618
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Oct 2025 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06AA19E70CB
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Oct 2025 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901E24166C;
	Thu,  9 Oct 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcjPQAnr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C723BF8F
	for <linux-sctp@vger.kernel.org>; Thu,  9 Oct 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031187; cv=none; b=J3LvEcsm4EgMDngRxLQPvvYxfLItEH8iEBy6CGiMUQCWOhBVGhl9U1/WHaSv20OGXd2+oBCNuxMsi7tz6q6U+XM37WdZU1vLpvo+adGH4HVaFsCP1K6LpEyn1x5TE4zZlGtqmoca5s7Xu2WmS+rV4qDg73tBSsypnwUJTXXVVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031187; c=relaxed/simple;
	bh=9vAUJTKDsrddX0ECgsQNxyK2CN2AgssZKpAoBZkq1Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nfcuq3d2YbS2b2dwiqxKN0OZ25HSEf1rpdTUoIsnnME4VXViTfbdG1BSZ8f3sO8GwQJkA158u1ishBdXnZ5TnOSeyJWTPFieC8CahZRlCA6tbdXK1FSbRmiQoiDLtgcVfEmiFEYXAtnPfoUHQVmfLi9t9XO9GrRaQzvru3swRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcjPQAnr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-374d1db213cso13359241fa.0
        for <linux-sctp@vger.kernel.org>; Thu, 09 Oct 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760031183; x=1760635983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLxztCZhFqGeufXzkuXXus/JxbN+hE9UN/bbCDJgNrI=;
        b=VcjPQAnrGgVLeBRfC+uuXGk9pbzHCz+TJp+w3cYNpnU0m8UPJy6bEP8hXrxK2eIM/q
         iCzmNuIjzPH/NF3o987LmRNMcmPBiwhaeWtF6rYhzZK+TMltB59RykpDq3+MJ6AsyiCb
         mfa6J0Jqx7t9SLw8elKeYanX6DmmM64op0Isq71miJrarJPwitzOxZ9ns5FyN+A2wmID
         7iisjgbsvW4XK6na7u0YUt/ET4Lhpmr63SmF89zbwle2su0ylDTnQvfqIqvbp2SvlxUH
         R0j0rVJ8FuirNgR3EhUfnaTvOYVzpNMLnxq87Z1CLxZJvgsWlKXMWWFL4TAAp/RC7weK
         iSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031183; x=1760635983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLxztCZhFqGeufXzkuXXus/JxbN+hE9UN/bbCDJgNrI=;
        b=Cv1ggkjBW6vmQYyhworgdyJCzAEc1KvjNaCqY8eQv8Oxu1JDW4Kwn0t3mM5xxgEF0L
         i/VmnmGu9j3wr+6GQ8iwaEIYGWlPrOX0Gqp8O6HD/tiLoqhUYfx7A5lgJjdK27pzzKa8
         CqzD2C3ErGqbDX+bQ8b4qE7+zdzGtwKZZIC2YOmoSHOnJTUgQcJahZYmZ1XgciPp3Cwf
         AfaX715y3DbZ477BlSWAG1MqSBsN2t0aeEQ/au0j8U5oWRp14AiGioPo3qO57FwxKMzZ
         eRUZpReC9bVPqsncZpK1Wgxui3IIqZzBPQbSigjt+F3e2j2pEU0bwXmfbLGq6XKgwxK/
         eWQA==
X-Forwarded-Encrypted: i=1; AJvYcCUhd+Q85IhsMO5EdfQ2icDmRoOsEF5jh4tyXChSO3jARHAJHIvDeFlwurmA1yM2FEf+/Wlf080+8bCU@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0m0qq7PXMFZPg0tFh5E7EH6oT4S4hiaTVhKF4oZ1ICI4QRbm
	AEQZMnb2QEIMDN/uxKhdfiJsArbsjVHq0rtLDXfT1ZRVmRqjZvbSyawM
X-Gm-Gg: ASbGnctqYPRgkIELWB52SDHa4uzjcK3b/CNOWpngVJwO8F5T/hu55V+ZT44Hy87wQ6a
	PPyqI0aWiXoFHLAtv9K2EcACNBtWM68a2hZznnhnVVJ4oec4xckjqUh4+TeYFPJTYua7xPB/dGF
	RSCiNgqY9c5qaqOB0bNUMU+6SP+93vCvgphrFajvSdcwBKsB2wse6nMLlEGRLw2xW5TS/EYayAn
	jJ2RMTylCfjOSk4uu8sZxqDh0aQZCQWU1NkHR3xAweZI7fGvyJRfqqL6Iq+8wS4p2AZ2FQkXKQb
	x3lfhpJLyzMq8WpbxZOzEUNcK2qK04feJmA5F2H10lK67G3JlpngXR1evSBaaei16amR2xgm2mW
	126kwxGAjjtN3qdfNucvv0X1gpLpHWPYBbo0SL47BmTNv7mrTTTrIIStkKjSOM4P/QdWAAehSaw
	==
X-Google-Smtp-Source: AGHT+IEvKuMOdYtRvPFBMg7RxLA8EnqpMsXl9d+MHkhe21lfjfclec1AQfTv2w3cGrLhXn53i9/gXA==
X-Received: by 2002:a05:651c:982:b0:362:95d5:3858 with SMTP id 38308e7fff4ca-37609cf837cmr25479361fa.3.1760031182940;
        Thu, 09 Oct 2025 10:33:02 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577c1bsm26239e87.106.2025.10.09.10.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:33:02 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] sctp: fix null derefer in sctp_sf_do_5_1D_ce()
Date: Thu,  9 Oct 2025 20:32:49 +0300
Message-Id: <20251009173248.11881-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check of new_asoc->peer.adaptation_ind can fail,
leaving ai_ev unitilialized. In that case, the code
can jump to the nomem_authdev label and later call
sctp_ulpevent_free() with a null  ai_ev pointer.
Leading to potential null dereference.

Add check of ai_ev pointer before call of
sctp_ulpevent_free function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d787..93cac73472c7 100644
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
2.34.1

I already have sent this patch from another email, but
he wasnt applicable since company mail server corrupt
it.

