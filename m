Return-Path: <linux-sctp+bounces-1322-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bk7sBrg4UWriAwMAu9opvQ
	(envelope-from <linux-sctp+bounces-1322-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 20:23:52 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2173D552
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 20:23:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="TV/7UsOl";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1322-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1322-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F8993005673
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 18:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B69377EAC;
	Fri, 10 Jul 2026 18:23:47 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA52376A15
	for <linux-sctp@vger.kernel.org>; Fri, 10 Jul 2026 18:23:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707827; cv=none; b=Nydfsb7ChRFe5v5HN4D8SSOZH1Jq08hJsMaKmsedQmwwmB5aoF+G2sWxDggRJGxw1xSNLhRLho4iuWbSXtk9t6k+oe1Wh7eR/kcRI5cNNIFuGtfqmF6Pean2hN/gk9/jv5asOoDMANuocUPebCLFv7qWLyZX1g7fktJNtieqM5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707827; c=relaxed/simple;
	bh=OwrnCwQOhMDuGnx9pE7dZOEyMC8AyvBKRK+CfPd0rpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iorp/oEd5rYNfwCDTUZNUgSUiQc8ffDLqzH86SnB7t7lH2rV2FYlfOcNd5G/LZEH7bjJD4qAb6bbShlfDRx4fOKF1oNyb2q7tA7j/7FPZCVUDzD+M9utMxWTf8N7Nv8u0qZgPSehwFRPKq2tEu7Ie/sTm0nymHxpndaPkA4HJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV/7UsOl; arc=none smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c05dcdf49so12759651cf.0
        for <linux-sctp@vger.kernel.org>; Fri, 10 Jul 2026 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707825; x=1784312625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=TV/7UsOl7jbzTkFJyVsrev6F4HxcjMyz1QyZ9mh4igcuem6Y/kkMgn03E+A7EdCBbD
         4zXw5BhLOkPSDBpB5CXlPRx3SrtQs9ODHAdcpHmFgaA8aFOgMPkwRSpm8f9IKQFmOn6O
         HEXizeyUHHRRGBMw98CXqdb2mFOWA5bpZHjGr+YTXAjTfaq5ktJoRlEswxzRiX05Rvgt
         KUDe76/WQp3+LBOd4+tFtTbf76VUYOzgQ68YEYWc8TLweXbZzmSwEihGD/OesqOSWDUA
         H1Ex4M6OfHc9Q6GHo4+gDFmvxPiMod2EA49FqSpyo7JjwHgJRU6gAWG7bc5nfynbGLUl
         bfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707825; x=1784312625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FH0W5s30/m3phVMwbdnAjH+UYTF+M+YW+Mbz2wNV4c=;
        b=o2DK0M0MxwUIKKaqtFhlrsUPUuHGERAX0QZxHq1so85w81wNdod7vfG8EyMG4ouxLi
         Dhf6tTOo1kve0975XS5cLTWpz7GwLdbNtfgJFmkYVdEVUOEcsLc/IbWjbI1ilCY9Vzao
         aaE0vp72D4b8sq/mbs92OMvhsUk+V/2LWfqAFNLIYbCAxaLlLiZI2qXZC0qfazcuujRk
         bghDIzqaQ0CcdVIpGgoPy1r1tBmVoeXKLLUBJZRZvITHMYGvcuSAXuNyMNK1cLywhhvr
         0OhiCdRjM99qZUCz/H7mZd5o7GeNjDMTp80np5jxav1D6O9+gY6WZ7g0ygXh2f1Qouzb
         wyKg==
X-Forwarded-Encrypted: i=1; AHgh+RoenX2gpxX8Jf7MW24I1b4ZK8q1/e6PxQ9RtpolNdKIB/FbzmSFcL/WbvBvhdmvyn0cCM8aCfKRhZRq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4019mJoJ8mw04fE1u/Xij3/dqAEmbtlQKTqP7GGErpN5pKWWY
	wBh6AAhFAvvLvYZiXA4FLJNcKEhim2AbvhAwvtTQxzPZ3fKw7Um5zuQX
X-Gm-Gg: AfdE7cmr7hoJ/TmaNi7ioJunXrsIQZPs8VwnXIv/7W2uqvNW/3YXYRh0kekbiQPBSVb
	wqJfwKT1TfBD0mHmB+iR26510PG1W+HISId9oXQhSPN1geMIRFVGg/E3ZPTqP/1Fp4Xt/EGngcl
	LtPpBnZuMB5Sz9YjKh6mqsmm7vPCA3RALQpfX1h6xj2fy3aDinJSMqfIKzh2+Id4g047iOr6Z2c
	M0RM73jhR9u5YkqgS1iqDWodL3MSkYSgXY0aSIAUxRROToLdwJqS3byx4F0wRDPyfa8GFZ7uqSn
	S8w7/nchH/x+vg6JNKF+e6wcnMont9Xe8xTXvQ9F6KeEmO56kzdf1K5mFeB3WfyHix1CJI4dO++
	KqoBds5JGi2JpWmtSi5zuW5tW6F5ZUso2Xg0TwAMfO69dftdGCkIhKnGzR09ToeLX5P4r3vCI7q
	yEhVjmGgekdMbdFA3CWoumAfRP78hadlSZGFScGfn7K3b7ydzwKR3MHczlc1QqOppXHNEHjGb4N
	tm5VzO6FkBTeVTR0XWMyAF+bEWIWmMciWkEX5Z4udIMlu0Sg1I1OII=
X-Received: by 2002:a05:622a:10a:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-51cbf12b97amr688881cf.20.1783707825087;
        Fri, 10 Jul 2026 11:23:45 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cbd8efab4sm2932851cf.1.2026.07.10.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:23:44 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: fix addr_wq_timer race in sctp_free_addr_wq()
Date: Fri, 10 Jul 2026 14:23:43 -0400
Message-ID: <5dc95f295bdb5c3f60e880dd9aa5112dc5c071cc.1783707823.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1322-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7C2173D552

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


