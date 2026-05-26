Return-Path: <linux-sctp+bounces-1211-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M0IJXdyFWpbVAcAu9opvQ
	(envelope-from <linux-sctp+bounces-1211-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 26 May 2026 12:14:15 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054A5D4014
	for <lists+linux-sctp@lfdr.de>; Tue, 26 May 2026 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E0230036DF
	for <lists+linux-sctp@lfdr.de>; Tue, 26 May 2026 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A153D9051;
	Tue, 26 May 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJvDyjDM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5433AA9D1
	for <linux-sctp@vger.kernel.org>; Tue, 26 May 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790113; cv=none; b=BWPEOlIwx7Cd2D64+Y4N8A9HJ46N5NCYBPNmFhij4Kj+baXwn6s6gCmAHI3PshbTOjSVqBADpIbfotDIR/IEtUxLy+4kNxV8euQF04Sd9ZuZLa12GBPr2qmj8/JMna5S15wSKnupMon5U8f7J7pnutN3K0xg/VDNvRk9upNc7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790113; c=relaxed/simple;
	bh=8JwjeKZVaCntrKAP75csUwWF1GR9z5p9Aj3+IYZ9JKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMvxuYkNk/if6efRa/ULwsP1WvjjYbAiKvRT6iRSJlmbP+mWR0Be9NrNp8BhiYw2nLu/WUeRL0wItvwAOpj5om/WdMQ8ruN2cXKB1qLTAEfXtWqIQ+54Zv+0n1m45rMORFksVeR/ltW0uCxD/z7Wcp7Uf2pnLe10tRsHsIheEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJvDyjDM; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-369002b26f4so5939064a91.3
        for <linux-sctp@vger.kernel.org>; Tue, 26 May 2026 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790111; x=1780394911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl4wPPXh4KR5+kQ81v17qjTdxEHq3gUQeGIpmR+SCMM=;
        b=TJvDyjDMrbBZCldGbREVnrKs3wBuRKTIl2XHnGAsBy8gLLeCTjBb865ixcsa1mz5im
         bhvlGQhPsogQqmhE2o+oFPDnz4on77dx7v5e0Pd3VY0pfTiA1pXmetoo3l65sOhAT9a4
         IoGvEtKxgDuHc/5kAP/ClkDjyiGG5YHHLCbx35Khy4owjroTnA54W/vyVgGv4UHE0Xb8
         1B1sURJ0DKTS2MnhTo1HEQz8VXt840lm2TBAZD5i/fZYiLcilFLHJn6qH1ME5JHCtCgF
         UxVIJMHwQ1BVIapj/Ex0FKdp79n6oKo+L4SSGxBoormNvFXETaRjWCK3XBrX2zjOiQ53
         X1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790111; x=1780394911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl4wPPXh4KR5+kQ81v17qjTdxEHq3gUQeGIpmR+SCMM=;
        b=Ev9wNblj5d3JH2G96oifeXgUBzOFqxzszhkfUdFcQjsDPd4BfXqbyb4D2/733e9Sf5
         f6z7ofjoQGRvpxifY1+TjnTcvm5ARM6Ag9VcAn1wa1+68VbpF55kxSY0l4dV3ySr8ul4
         XFbL00UFShZJgZ4OCeTj+ExuAc4R6xa6UWHwLSbj3rP2lC6UfZrX9Bni65h4B+8Ren7l
         xYCQ85xGohLPcfQoN/SZkocMvl7iZrllK2TG//dhFtM5r7tNu3+VmG+UhFBF2vqqwyFH
         iNhaWQwP21eiu0Sar3UPSnc9OVGYSm7HD5AL+cArU9aY1K+FfgxXb8SZjLxVVFoGcOLA
         rqyw==
X-Gm-Message-State: AOJu0YylqQigRVGwLhIN3YR/c2Ml6D0P95I0JIhF5J7BPq2GdCpNj/9W
	Po8B55c4qkrJi7ATTfmgMk/2FDAk4yKpvb9wwKxsmKYa2y2Fs/fgNjwwpC1C/lMny91azfLa
X-Gm-Gg: Acq92OGb3gHJ0MHJi7C0nQh0p+5wWwECS1+URQQEu1zwRZnkDggJRCvd46ToQhdtJVs
	7eBuZiACFE7c1oygw8bwDHysJJujS+G5mKtRTh73Viq4qiNT8WfsGXSNqZY1wAeRwHnsQn4XoE6
	J+ksL7OSLoazhUbQzF5PV31vUCrWk6TfzGXyypkC5ndyJZyKW4+30F994KDrgBzYlwlVBn90Dc4
	0pmqf1yac6G8admX/R1K7+Za9J7sDHEi6huDgyLk23nk2bgQVAqsb5Kol26gOy07cIEWXWXnGZT
	dfDhq7Y5k1VR/vGoPIYvqkFR6Jlay2hiZkPfCokLx/AP54ketPa7Idao2F1PZ8u24/b3RDZCRwG
	A4qJlrHd685uzSNcglSagxl00SxoEq9WRTTnkJcc6wA1qj1tftP3DVnn18uRvK7g4PWOboXKMQO
	3whhbNC6WCMscPM8vcKMIJndvEGnBFE3qpP1ajyHGQ4/Irw6WY2ynSmMgRFW42F21ghhYbeQ6SW
	By2vXul1Q==
X-Received: by 2002:a17:90b:50d0:b0:369:f48a:f24b with SMTP id 98e67ed59e1d1-36a674b6931mr17263380a91.0.1779790111303;
        Tue, 26 May 2026 03:08:31 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202a337fsm9939976a12.8.2026.05.26.03.08.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:08:30 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] sctp: fix race between sctp_wait_for_connect and peeloff
Date: Tue, 26 May 2026 18:08:25 +0800
Message-ID: <20260526100825.16057-1-kipreyyy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1211-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2054A5D4014
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


