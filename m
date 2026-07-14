Return-Path: <linux-sctp+bounces-1339-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pgP2FMCTVWpTqQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1339-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 03:41:20 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0F57501DB
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 03:41:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=ZZgEUw9x;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1339-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1339-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83304301A107
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98973363089;
	Tue, 14 Jul 2026 01:41:05 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBC304972;
	Tue, 14 Jul 2026 01:41:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993265; cv=none; b=U0XcLGB3mh+oq18CSuRkJIH2Gou9mVnLq7ryqesR/ugxbKS+KmI9bz1JG31p1Hu+rdpc/FBOwAWpJE5k3rRaAWyw1cv/XIUhsHDqV4LkcoFXkVOB0ez/4lHlsBiQe2i/AV22X2AEYIiqfnEvFwqRQIqjng6wjNKTlALWZAAxan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993265; c=relaxed/simple;
	bh=mrmOnBPX+/83ewbidMnCH8jF8o9o30h9dv3WC3R685A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DneoaAHjzyBIK++CdPeak1px2yK556NCpuj+w772hf3ZY7qL6SEYRyK3SzD6Xe4AjYMyxEmnQSUPlmJe0OD3Yt9pyGBOlJGLRn4vLCr4dGT2X2nKadZRHdYKfTk1z6069vQxapDBNLCkNEax0MYMjSDWSFdd0fwriBH7wAhIY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZZgEUw9x; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E0C9ro2070439;
	Tue, 14 Jul 2026 01:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FiLFfUTXRiuzfTTpV
	4bzgYu8rHhky63Q1CvzyN+MV7s=; b=ZZgEUw9xtzgjYqqbjyklYV4GKqIB3ADX7
	C/cn1z5bsJ0SUFAnlvQbARQI/lCGTN1SUQ8BTmFp2Ntdlx8b1xXX6hS7CM4BDncS
	ZoogfhYs58JFusw622Be1vt9D68GQkZCD/nKqU126H/DDxc8Cr2qLIHgArR3eQve
	deRAgBibXSi4kQcdB38axJfGM41/JJQqeauuPNpkLhKuqlXB1G4A7umCPEiw8h4e
	BDF/ykSc4WZ3/ka9h4Jx4/tATIyNI0VGKmEtrT7oEL0fthaveDCe+BS/4n2lUlif
	mKS9EelipwbnHvYqpKxxNRZgM09EcDfBJ0XydWZS0qlRwQQ48c/JQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv3345pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 01:40:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E1Z1Jx003043;
	Tue, 14 Jul 2026 01:40:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q0k7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 01:40:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E1ef1242467600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 01:40:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2489520043;
	Tue, 14 Jul 2026 01:40:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E99FA20040;
	Tue, 14 Jul 2026 01:40:32 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.39.30.210])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 01:40:32 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        David S Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        D Wythe <alibuda@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Jon Maloy <jmaloy@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
        linux-sctp@vger.kernel.org, Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Willem de Bruijn <willemb@google.com>, Xin Long <lucien.xin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: [PATCH 2/2] net/sock: Propagate WF_SYNC only when requested
Date: Tue, 14 Jul 2026 07:09:43 +0530
Message-ID: <20260714013940.4068189-6-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714013940.4068189-4-srikar@linux.ibm.com>
References: <20260714013940.4068189-4-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxMCBTYWx0ZWRfX8hagMd7GaB00
 wUXsMXaWOhnFvqJKA5b5bhdmhxxdcfV6R7QvzwhsrjIu3x/f/sSsNsu1z9IAGRP8XVLO50NNuPb
 Q3WOuOirmo6RHzruASRtI9cXlF8dKf8=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a55939e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Rvf68rD1d7SEEqb_LvEA:9
X-Proofpoint-GUID: TDULG0YunRxJsHlituCLTfHoopCPv2fo
X-Proofpoint-ORIG-GUID: rB9sLpci97OBbF2jFt8x0fWeeYOR6yP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxMCBTYWx0ZWRfX4XGGJAnsQkO4
 H4GySG1yXoNCcsYpN8XxE8JTYyCoC4+rrNYufJUEpgUjEEiXB/jd/gRrvyCMOz9korOQnTakvCG
 ix4Q+lLLkPlI2U2Inb+Kmpu/iG8Nef0HnwDzVaOoU8t/6CqCodYB31SE02OcwhK8HPaxBgLbxBD
 E4KVHkONYD+3YnTR/3Vw/kEzCHuFU9oyglUT3wy2TKrFTC9i9g6V6/szsq2Df0S2Ge52lIMaDrK
 kB3Xcqz60N6ABXcpgCcDUM5ykdqSm8+z5zrE2ula1T5JcarVP1egfnL+th1DtBaJlDym1hCXHpd
 dinRAFQNVkvo2wvc6Ig6N3eGDWYj9vEwFpXhU2EjWX456zdsBF8S1xbnMVBEZJUcbNtz3qoJB4t
 rbFZPOjefz33l8MXT6wAvvm5IvJOUPUTbkLdqkLx0aYjnom4RILG+WtY7D1YFd4CYjQNL1ro2Qs
 xikjDtK63vJEfNHjKQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140010
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1339-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,arm.com,linux.alibaba.com,google.com,redhat.com,vger.kernel.org,linux.ibm.com,gmail.com,linaro.org,goodmis.org,suse.de,amd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:mingo@kernel.org,m:peterz@infradead.org,m:dietmar.eggemann@arm.com,m:dust.li@linux.alibaba.com,m:alibuda@linux.alibaba.com,m:edumazet@google.com,m:kuba@kernel.org,m:jmaloy@redhat.com,m:kuniyu@google.com,m:linux-sctp@vger.kernel.org,m:mjambigi@linux.ibm.com,m:marcelo.leitner@gmail.com,m:pabeni@redhat.com,m:sidraya@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:wenjia@linux.ibm.com,m:willemb@google.com,m:lucien.xin@gmail.com,m:sshegde@linux.ibm.com,m:vincent.guittot@linaro.org,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:srikar@linux.ibm.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[srikar@linux.ibm.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srikar@linux.ibm.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF0F57501DB

Use SOCK_SYNC_WAKEUP to select between synchronous and asynchronous wakeup
wakeup APIs. This avoids propagating WF_SYNC when no blocking waiter is
expected. All wakeup locations in networking code that currently issue
synchronous poll-style wakeups unconditionally are updated.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 net/core/sock.c    | 31 ++++++++++++++++++++++++-------
 net/sctp/socket.c  | 10 ++++++++--
 net/smc/af_smc.c   |  4 ++--
 net/smc/smc_rx.c   | 10 ++++++++--
 net/tipc/socket.c  | 22 +++++++++++++++++-----
 net/unix/af_unix.c | 26 ++++++++++++++++++--------
 6 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 8a59bfaa8096..a214e883b14b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3652,9 +3652,15 @@ void sock_def_readable(struct sock *sk)
 
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
-	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
+	if (skwq_has_sleeper(wq)) {
+		if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+			wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
+						EPOLLRDNORM | EPOLLRDBAND);
+		} else {
+			wake_up_interruptible_poll(&wq->wait, EPOLLIN | EPOLLPRI |
 						EPOLLRDNORM | EPOLLRDBAND);
+		}
+	}
 	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
 }
@@ -3670,9 +3676,15 @@ static void sock_def_write_space(struct sock *sk)
 	 */
 	if (sock_writeable(sk)) {
 		wq = rcu_dereference(sk->sk_wq);
-		if (skwq_has_sleeper(wq))
-			wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
+		if (skwq_has_sleeper(wq)) {
+			if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+				wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
+			} else {
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
 						EPOLLWRNORM | EPOLLWRBAND);
+			}
+		}
 
 		/* Should agree with poll, otherwise some programs break */
 		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
@@ -3695,10 +3707,15 @@ static void sock_def_write_space_wfree(struct sock *sk, int wmem_alloc)
 
 		/* rely on refcount_sub from sock_wfree() */
 		smp_mb__after_atomic();
-		if (wq && waitqueue_active(&wq->wait))
-			wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
+		if (wq && waitqueue_active(&wq->wait)) {
+			if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+				wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
 						EPOLLWRNORM | EPOLLWRBAND);
-
+			} else {
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
+			}
+		}
 		/* Should agree with poll, otherwise some programs break */
 		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..9cb3432f065a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9348,9 +9348,15 @@ void sctp_data_ready(struct sock *sk)
 
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
-	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN |
+	if (skwq_has_sleeper(wq)) {
+		if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+			wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN |
+					EPOLLRDNORM | EPOLLRDBAND);
+		} else {
+			wake_up_interruptible_poll(&wq->wait, EPOLLIN |
 						EPOLLRDNORM | EPOLLRDBAND);
+		}
+	}
 	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	rcu_read_unlock();
 }
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b5db69073e20..1a6ea2e30769 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -819,10 +819,10 @@ static void smc_fback_wakeup_waitqueue(struct smc_sock *smc, void *key)
 		wake_up_interruptible_all(&wq->wait);
 	} else {
 		flags = key_to_poll(key);
-		if (flags & (EPOLLIN | EPOLLOUT))
+		if (flags & (EPOLLIN | EPOLLOUT) && sock_flag(&smc->sk, SOCK_SYNC_WAKEUP))
 			/* sk_data_ready or sk_write_space */
 			wake_up_interruptible_sync_poll(&wq->wait, flags);
-		else if (flags & EPOLLERR)
+		else
 			/* sk_error_report */
 			wake_up_interruptible_poll(&wq->wait, flags);
 	}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index c1d9b923938d..4e288a2364d2 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -39,9 +39,15 @@ static void smc_rx_wake_up(struct sock *sk)
 	/* called already in smc_listen_work() */
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
-	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
+	if (skwq_has_sleeper(wq)) {
+		if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+			wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
 						EPOLLRDNORM | EPOLLRDBAND);
+		} else {
+			wake_up_interruptible_poll(&wq->wait, EPOLLIN | EPOLLPRI |
+						EPOLLRDNORM | EPOLLRDBAND);
+		}
+	}
 	sk_wake_async_rcu(sk, SOCK_WAKE_WAITD, POLL_IN);
 	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
 	    (sk->sk_state == SMC_CLOSED))
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..9fa83a89882c 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2116,9 +2116,15 @@ static void tipc_write_space(struct sock *sk)
 
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
-	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
+	if (skwq_has_sleeper(wq)) {
+		if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+			wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
 						EPOLLWRNORM | EPOLLWRBAND);
+		} else {
+			wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
+		}
+	}
 	rcu_read_unlock();
 }
 
@@ -2134,9 +2140,15 @@ static void tipc_data_ready(struct sock *sk)
 
 	rcu_read_lock();
 	wq = rcu_dereference(sk->sk_wq);
-	if (skwq_has_sleeper(wq))
-		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN |
-						EPOLLRDNORM | EPOLLRDBAND);
+	if (skwq_has_sleeper(wq)) {
+		if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+			wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN |
+							EPOLLRDNORM | EPOLLRDBAND);
+		} else {
+			wake_up_interruptible_poll(&wq->wait, EPOLLIN |
+							EPOLLRDNORM | EPOLLRDBAND);
+		}
+	}
 	rcu_read_unlock();
 }
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..15ebcc2d9d58 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -601,9 +601,15 @@ static void unix_write_space(struct sock *sk)
 	rcu_read_lock();
 	if (unix_writable(sk, READ_ONCE(sk->sk_state))) {
 		wq = rcu_dereference(sk->sk_wq);
-		if (skwq_has_sleeper(wq))
-			wake_up_interruptible_sync_poll(&wq->wait,
-				EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
+		if (skwq_has_sleeper(wq)) {
+			if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+				wake_up_interruptible_sync_poll(&wq->wait,
+					EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
+			} else {
+				wake_up_interruptible_poll(&wq->wait,
+					EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
+			}
+		}
 		sk_wake_async_rcu(sk, SOCK_WAKE_SPACE, POLL_OUT);
 	}
 	rcu_read_unlock();
@@ -2603,11 +2609,15 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 		goto out;
 	}
 
-	if (wq_has_sleeper(&u->peer_wait))
-		wake_up_interruptible_sync_poll(&u->peer_wait,
-						EPOLLOUT | EPOLLWRNORM |
-						EPOLLWRBAND);
-
+	if (wq_has_sleeper(&u->peer_wait)) {
+		if (sock_flag(sk, SOCK_SYNC_WAKEUP)) {
+			wake_up_interruptible_sync_poll(&u->peer_wait,
+						EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
+		} else {
+			wake_up_interruptible_poll(&u->peer_wait,
+						EPOLLOUT | EPOLLWRNORM | EPOLLWRBAND);
+		}
+	}
 	if (msg->msg_name) {
 		unix_copy_addr(msg, skb->sk);
 
-- 
2.52.0


