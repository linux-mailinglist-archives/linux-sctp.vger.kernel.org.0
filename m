Return-Path: <linux-sctp+bounces-315-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF7A06056
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4986118886F3
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223491FE45C;
	Wed,  8 Jan 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCFD0GKG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA11FE454;
	Wed,  8 Jan 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350556; cv=none; b=gPxvllgRzzjRkcqWjIXjsHRU1Z3Rj5g1W+1RA/8BZk55k+baoXwitsbgFuqIjVGm2UkdVPQGCxcwmKm2Ph1uqS2b1hYBgvm1RAc9rVi3GM25neLDvcYLE1feftMyvUNeyZcZekc7lsIkqwsgnH8om3h3Ez10/ThPGyyoIO8cq1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350556; c=relaxed/simple;
	bh=6UzWyJD5k/BZPXrLXm62UJznPkVz16sX1azoNHjlPRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2CvX1/HLf1lmDrLl9hwAtK9xP0esP7zkTzw2vQ0gJZn2eNB1AMCy3CPZfeHSWZPIGMZtWMPC7tFOHCWeXoR+GqVQEfUe++zg/P1NPoNc2B08PyNo3a04ZvdlvFiSGjUyJ0Bc/jffZeukWbWIgnDx+5yA/Dd6AGzshqX8j1cjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCFD0GKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52193C4CEE0;
	Wed,  8 Jan 2025 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350555;
	bh=6UzWyJD5k/BZPXrLXm62UJznPkVz16sX1azoNHjlPRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TCFD0GKGpQBqKBoeYZA6miC+mu2aq73PDaKOCZjJth0ZikHkjSJDZvpFewT5H9c5S
	 8qT7BAgjGA2IaDy5pxygjx3wYZWmqeK38Uv+l+mvbRiXsTQ9AbTdvifLdJZnNtqDSJ
	 +jdnJ8gA6q+MtBv4VJnFIMcjkP89E7AtMQzCOaKCsgMX9kKfoEECVhgPIL1S2DhttN
	 5nMacj0+39+FWpiOoWXMFupRK7PT2Zr3EuvuF15XnOwO3qFjc3Nl1iA0rEFaWGY/YB
	 KB2xOpixtbQOhsTdrP8YhDs2wyfK7Mg69rBJxmnJxhKALksB13bbVEvGmxlbaw1fHU
	 7RKBbFBmUZMRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:37 +0100
Subject: [PATCH net 9/9] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-9-5df34b2083e8@kernel.org>
References: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
In-Reply-To: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>, 
 Neil Horman <nhorman@tuxdriver.com>, wangweidong <wangweidong1@huawei.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Vlad Yasevich <vyasevic@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Sowmini Varadhan <sowmini.varadhan@oracle.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Joel Granados <joel.granados@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6UzWyJD5k/BZPXrLXm62UJznPkVz16sX1azoNHjlPRY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjsigDTWjvabNfWuiC8vV+Sr7cw/S773XtG
 iutmd/3sLSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c9l0EACooxxFewKnetGy8rXlXDUsrRWWtWLgJDUUjg9nUQE/mSJf5BYxjHeesoggO+kYmd9l2WE
 3TIIf8+yBwbG+eXhv+cAusbArYMFWgAmaa4vfS+D2YkqlqXZM9DxuqmCX9cGfyUiyZECtmAsFmE
 5mLbQv2rCUyfQBf3HAn47Z4QViRUZEBFaFjbdNBQ4bmvB5EjxepiPJe5UuAZURzsety9E8J5wxX
 ZyqjTypLrHVY8L1HEs6YTC789QwlaQGYpy6TKr8c1ddeIvDUtom9d+7v7tJ2Jo0YxKtLFUoQRHS
 LjGrFCNl/+UaZcVHrk496VNoyULJ9G9F/mZRjQvgX3765oOMFWZ54LMdsXYbZnSkIxGkhJHxml1
 pYjEaTewczrL/3v+/XbNFj/pliE1NsZiXYSp3b4ASbqPBaglD/yZGksaw2z2cSajApxgZxPayoD
 h/NcUQH3PrQLpB+5hcZcP11MQ/FlYeUf1TgILJ/Ae4legY1GCVNo3OWjd7/tzKh5Nq3d0wU3M+A
 rBKqIEVuU5q26LC4sgdSQNTFDErq3JBO5gsobQDUl84xeYXrtkfIahCRfFuj4t4qW2Sl5sYFRwF
 3JcrTUfc5MnGOvX/ncuJ2ZiU2fGeIAg9FcoOn2YV6FBgRenlZdYsp0cjrMcxLadM61VRhf+sLyZ
 wBv58USMlMmb/fg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The per-netns structure can be obtained from the table->data using
container_of(), then the 'net' one can be retrieved from the listen
socket (if available).

Fixes: c6a58ffed536 ("RDS: TCP: Add sysctl tunables for sndbuf/rcvbuf on rds-tcp socket")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/rds/tcp.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 351ac1747224a3a1c8b0e297ba53cdbbcbc55401..0581c53e6517043ad6c2ad4207b26ab169989ed8 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -61,8 +61,10 @@ static atomic_t rds_tcp_unloading = ATOMIC_INIT(0);
 
 static struct kmem_cache *rds_tcp_conn_slab;
 
-static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
-				 void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos);
 
 static int rds_tcp_min_sndbuf = SOCK_MIN_SNDBUF;
 static int rds_tcp_min_rcvbuf = SOCK_MIN_RCVBUF;
@@ -74,7 +76,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		/* data is per-net pointer */
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = rds_tcp_skbuf_handler,
+		.proc_handler   = rds_tcp_sndbuf_handler,
 		.extra1		= &rds_tcp_min_sndbuf,
 	},
 #define	RDS_TCP_RCVBUF	1
@@ -83,7 +85,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		/* data is per-net pointer */
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = rds_tcp_skbuf_handler,
+		.proc_handler   = rds_tcp_rcvbuf_handler,
 		.extra1		= &rds_tcp_min_rcvbuf,
 	},
 };
@@ -682,10 +684,10 @@ static void rds_tcp_sysctl_reset(struct net *net)
 	spin_unlock_irq(&rds_tcp_conn_lock);
 }
 
-static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
+static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
+				 const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *fpos)
 {
-	struct net *net = current->nsproxy->net_ns;
 	int err;
 
 	err = proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
@@ -694,11 +696,34 @@ static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
 			*(int *)(ctl->extra1));
 		return err;
 	}
-	if (write)
+
+	if (write && rtn->rds_tcp_listen_sock && rtn->rds_tcp_listen_sock->sk) {
+		struct net *net = sock_net(rtn->rds_tcp_listen_sock->sk);
+
 		rds_tcp_sysctl_reset(net);
+	}
+
 	return 0;
 }
 
+static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos)
+{
+	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
+					       sndbuf_size);
+
+	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
+}
+
+static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos)
+{
+	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
+					       rcvbuf_size);
+
+	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
+}
+
 static void rds_tcp_exit(void)
 {
 	rds_tcp_set_unloading();

-- 
2.47.1


