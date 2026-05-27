Return-Path: <linux-sctp+bounces-1214-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFtcOe5jFmpamAcAu9opvQ
	(envelope-from <linux-sctp+bounces-1214-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 05:24:30 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE55DEDC8
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 05:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 312B2300BC4D
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA136728C;
	Wed, 27 May 2026 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeKOklq/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2934B682
	for <linux-sctp@vger.kernel.org>; Wed, 27 May 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852264; cv=none; b=nKr6WKuQRmO66u4Oe8vwVsxVOawDWztOq4YTnWie2bl5CldoT7ZhdMXgcvkIbN/maNw/ntW4Sl+Vj+0Ty0x3Vhl4d0WsVEdIIDXSbSq8mODScYtCh8DIlslbkN+wnQic7AEI7Zvk9zmx15ajf6Mw0ZnriaD2tOpij9zTvaqf7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852264; c=relaxed/simple;
	bh=8JwjeKZVaCntrKAP75csUwWF1GR9z5p9Aj3+IYZ9JKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ohDA3n4ijuYKFqpB2lJ7hb5bBB7fJupfD8KCIeujZamRxG0wMvobjfqrvQl+5KWNHBxEOySCIAbUQXugxQAkwlXIeZQS//AuxokdGE4+A403EG75Mrp050v0nM/kwbJidIo/y+G7q+2wZLBG4gdESnS1Y2/ICSsCXV0/1Cz585k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeKOklq/; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso5125056b3a.0
        for <linux-sctp@vger.kernel.org>; Tue, 26 May 2026 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779852263; x=1780457063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl4wPPXh4KR5+kQ81v17qjTdxEHq3gUQeGIpmR+SCMM=;
        b=jeKOklq/zus7+dRDDWPRhTN3eeSG7AFXo4HE7s2qSPnjQPtNVKQL1rBibEHrcajMdp
         Eb9T3LYv63H61o1W9McDa+pW+UpQJsn6DuPcOcSzlvMpenfHZ0QKwbSOkvOxNs4LiCdS
         puBSwH7wbNhnnuqkUIgrLHm6WIDKazm/0QiPjyF4emeb8tWnceQbocz8NujtChJrIzvL
         6+rynMwOo8FOBEXxs0VNmDqwJEobjYeJLsdyNCpp/ah/Qv/yOvLPBgy3HAlPkN3i4SGc
         SDSTzP8Je9vb1sg4P8K13n6O589DMYgOjFo1RbA5OKJILJMExO6LpAO82UNnRJLKp5rs
         KEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779852263; x=1780457063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl4wPPXh4KR5+kQ81v17qjTdxEHq3gUQeGIpmR+SCMM=;
        b=WzKAgOgxfDsCEXNkTSIv/QQD0WoU6fLO1rKHH1D1YX0kuBFn4uaLmDp4dLkc+oKc6j
         h8gtkPsKVTWtDErKlrB4lCsL50ptmnfIT1TfuN42sh9NqGPOdT5r1OFqRlsB4wvGhGor
         OyXQRP+7LBaNPJ5Gd32M0Cjo/IczbsyoF3f0wN2v6YH63V8kNvGAW1qqhLkkRlOAzdds
         rNCEGbuou25aBsRTIeTeb0qwBx98pSB0gNChcP7j2zh4vhV4uwTyj0ebS8TbDljvMzF3
         +Q5EIsVw52OZ/Khk5fczUM71FTT9qR4G1VKSwBozsx5+kp9mrKKqxnaTJ4t1uGI5v2IA
         B8Ew==
X-Gm-Message-State: AOJu0YzPWpyDgbIktLZXcC0E9QF2rJdJScL0salABZ+i9T9JxRu9ZTBX
	XNEe7LV6eKxwjsONSVblqc51xX857TWVzHYYcbY+7DcpdWmCh36BcXeu
X-Gm-Gg: Acq92OGJfd0vADwu8+0ZL6tlsvjlQELm+2KpeGkBljH4TUu8Ng8+9iKurPX/p7bD1z4
	Sy+GUpcEIrfgZNiPOne92PjqC3vBYvTIFOhdEbSdFoO7kUeDoLrauH82fFHF32ayDqEpd+vPcx7
	1VjAbFrhg3OgJtREzQcd2/ghUgxTA9Huog+1Fgd8ps9EJzFAEnaJJFFRAI4LMR0Vv5vyWT+R6hB
	ibsx5XoZdLrnTeI7T8LnlXv698zYOnnZ8MDoupFBCGDPCrMpNXjioLuKNlL5zvFNUc4Knyi/ubp
	eNWzBsbxMZvHyrT+bnOiwfE3fYZ9pnV3pjgTIxUBN0e4vBWratzUBvebVVNVZGifKDd8G44kOfG
	g8FLX8J51A3kxbZSjKYXAXN0o5m04xLGZDI93pvtN3BzViZ+IMjcCiYF42C7VCCKYNDML5NrpWg
	jLwvf0XrTBtms5LMNHFGmCV3lfylaOCw0BEJxNsAYZyB6F74H23H7NyVT1rJOs
X-Received: by 2002:a05:6a00:3923:b0:82f:ac48:8342 with SMTP id d2e1a72fcca58-8415f4066camr20956495b3a.24.1779852262723;
        Tue, 26 May 2026 20:24:22 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eae464sm779763b3a.20.2026.05.26.20.24.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 20:24:22 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] sctp: fix race between sctp_wait_for_connect and peeloff
Date: Wed, 27 May 2026 11:24:11 +0800
Message-ID: <20260527032411.60959-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-1214-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBAE55DEDC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_wait_for_connect() drops and re-acquires the socket lock while
waiting for the association to reach ESTABLISHED state. During this
window, another thread can peeloff the association to a new socket via
getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
re-acquiring the old socket lock, sctp_wait_for_connect() returns
success without noticing the migration — the caller then accesses
the association under the wrong lock in sctp_datamsg_from_user().

Add the same sk != asoc->base.sk check that sctp_wait_for_sndbuf()
already has, returning an error if the association was migrated while
we slept.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/sctp/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1d2568bb6bc2..66e12fb0c646 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9403,6 +9403,8 @@ static int sctp_wait_for_connect(struct sctp_association *asoc, long *timeo_p)
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
+		if (sk != asoc->base.sk)
+			goto do_error;
 
 		*timeo_p = current_timeo;
 	}
-- 
2.50.1 (Apple Git-155)


