Return-Path: <linux-sctp+bounces-1302-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XYCyK/y5QmoMAQoAu9opvQ
	(envelope-from <linux-sctp+bounces-1302-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 20:31:24 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 113626DE110
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 20:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pRY9IU+V;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1302-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1302-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF21B301224F
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA52392820;
	Mon, 29 Jun 2026 18:31:18 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E035DA63
	for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 18:31:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757878; cv=none; b=NBjQe/LEOO7mMullyi96zKjbL497UuYqSDkNnOErG17C4gJ+Ga/fHZQzoCA69xhAOgCEF4LEblHYUrQMdNjPmZ48z2pgQwjipsyio6mM0vie9d/+8gAjEtutaeBeGWffEFuOIOsyUOnNTX4zBLtAwHQQzJw94lTOJCLwqzIsoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757878; c=relaxed/simple;
	bh=OwrnCwQOhMDuGnx9pE7dZOEyMC8AyvBKRK+CfPd0rpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXl6upKbJ/OMUNtEC6Y+Kb6dAHNdCp/kHNGNgzqTVjcOfpDF5ZYn52Ace7Hk0q28PJP0qWUl1lpskDQDbQsUfrvPikg7dd2k5CpQVo1TxMWVCfD90aDYhjgM3Zy3njS14pJsyQvLgD+paJqCB0QcvYsaRvtKi13fFtXNWSoS4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRY9IU+V; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92c7a0a7059so210771285a.0
        for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757876; x=1783362676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=pRY9IU+VXgXW33L2qO4qarnzXzzBggJAlVEc9qvuVZZd3s1mnc10zY8JeuMxzOWu/9
         r/L/z0VjC5Ytsi58o+ScRQHBdxzhb9HR7HY50vjls1drH2UrWzLcGtr3Up4YM6yiljgY
         BAocPwv7+9m4dhqZVcG59Qz375e21DPUy6c4uuEKZysqgnp89JsPxM5ctjniMullrSO5
         CSOOwjkcYU90sgFOrhTphRQi3Gyscl0K8Xco3REO0KY1mhE9TE1CchQs5K08ebgKT5ni
         64T3yWxbVgzpVcO81unSlDtUU6Ztc71g+uY5vQ8kLAh9E+VjfDeFP//w4HR7WbMQ6Un2
         0V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757876; x=1783362676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=neHE5SEBqolUWFbeqal3+UeaEJaeLMq9i6piG6kIyUkm5jZlmGKf1xjONgevx1MRHS
         vBiuz7klbIFzyyAuYac7+OthN7oq5rHjf2pk0IX5s/irVEGkFEX6K6enAaoo17qh1Z8w
         elC9t7kEQRI+JEufRFOKAN3wLIwcZh4YdI3q+1+BucSA/N5/A5ekG9FPTHMr1vRLNMDv
         9LPF555NoFfP+iJaf37gfzfPcfChrEPqGNL9KhWrWsGn6Ndyj9zfJU9Nova7yU75+KE2
         KjpiCHy3CTgb2c5Si+T2PgUoihLfY8hpg/nWcwWuIt+oKgOv+eimAVKPNAMCaPADgOp1
         W/rw==
X-Forwarded-Encrypted: i=1; AFNElJ8k5ZeFf9I+CoDLSNaSth1WWqyt8U0XolwXoWeKNf3lvFU1bcrOWQd2zG0DqRaEbZ6No498nhcyZH9H@vger.kernel.org
X-Gm-Message-State: AOJu0YzvvBLgRBwT+OrzSNCNfV37EEXMsTlB+tLkI8MYFTLBYzM+zfdQ
	mMb7Sogqwkx+vLi4XUoAPR6jSeAZg4wS/zQphK+ADRa7oJvsnpu/r9rx
X-Gm-Gg: AfdE7cnhGhGXZY+yizrAe3jFV1yfLNZZNGUAzrr1ikQbuRJjeZG4GjMNFrJ10huGKD9
	/T0obK1/St743bB1DvpMSwaY97qKQAi4oLV7C3g5G9DZhP3Ql8mYp7Q6zwg0VOxz2Bzbw83arpr
	FPe2nynDwVqN5N95zbD4RFF4f3PcDwW4Hp6L+J7Vxlc5oL1wjY+FrrnF8jabxi150AIm4pNr61Q
	bWLl1Cb2UrXbVb72X5te3xBMwXF65nePFt9hspSMx0a5VYB4HlUy5fT6NtcT6gcLkVhN64haEUo
	T8ccwhts2rnJN5zcEFLo/63sZB46c+DxPSWxXHo8OGONZxa1y+CkZ2RUcUhGR4MfT6GDgv9LdHz
	6AO7iym8gPuAjg/ahJVd/Zz+OMtZzTUYJTbvYD1LbHf1YuclGFzo4dSb5CiAqzfuK9nrTuhjvK8
	gPPJo1pxAd5//yIUQmNiit1XEjw3VUJBmT5btuiZWubmSCGi2pVGByqypZwxoSQPqvyVpQnYw8r
	D8DUH8XTXtUgl79BwtoEg2RSuKK4fhNRoI2H/WSxl3MH5xr893Y5mM=
X-Received: by 2002:a05:620a:1d01:b0:92b:67e6:8ab1 with SMTP id af79cd13be357-92e627dac3emr118120985a.59.1782757875730;
        Mon, 29 Jun 2026 11:31:15 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62388e43sm46547485a.46.2026.06.29.11.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:31:15 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH net] sctp: fix addr_wq_timer race in sctp_free_addr_wq()
Date: Mon, 29 Jun 2026 14:31:14 -0400
Message-ID: <5dc95f295bdb5c3f60e880dd9aa5112dc5c071cc.1782757874.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,xmission.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1302-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:ebiederm@xmission.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 113626DE110

sctp_free_addr_wq() previously removed addr_wq_timer using timer_delete()
while holding addr_wq_lock. However, timer_delete() does not guarantee that
a currently running timer handler has completed.

This allows a race with sctp_addr_wq_timeout_handler(), where the handler
may still run after addr_waitq has been freed, acquire addr_wq_lock, and
access freed memory, leading to a use-after-free.

Fix this by calling timer_shutdown_sync() before taking addr_wq_lock.  This
guarantees that any in-flight timer handler has finished and prevents the
timer from being re-armed during teardown, making subsequent cleanup safe.

Fixes: 4db67e808640 ("sctp: Make the address lists per network namespace")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 587b0017a67d..cf335494bffe 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -663,8 +663,9 @@ static void sctp_free_addr_wq(struct net *net)
 	struct sctp_sockaddr_entry *addrw;
 	struct sctp_sockaddr_entry *temp;
 
+	timer_shutdown_sync(&net->sctp.addr_wq_timer);
+
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	timer_delete(&net->sctp.addr_wq_timer);
 	list_for_each_entry_safe(addrw, temp, &net->sctp.addr_waitq, list) {
 		list_del(&addrw->list);
 		kfree(addrw);
-- 
2.47.1


