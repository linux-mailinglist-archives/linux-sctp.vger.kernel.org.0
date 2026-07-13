Return-Path: <linux-sctp+bounces-1328-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id INE1O2THVGp4SwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1328-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 13:09:24 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478BA74A28F
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 13:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ZQ6yw0ee;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1328-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1328-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC1F53032F5F
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D38381EB2;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20C3769FE;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940874; cv=none; b=Ooj1zFrROtFYzUYpEF3OXsT4b4pwDTL6xpy2xIlkoRPXPhJ3CoruzmWv1uBHINjdflB8e8w+9k0g7N59WYuIofSqaZbtKhYNhTnSTT2/utd8zUsti+TfOUTA3Q3xvBplrz7P1iyxcAIgxJGsV8Res9uIJyaWsbujrtXyAJQ1JKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940874; c=relaxed/simple;
	bh=v0+MG609dZTjGEN7kUhnpd5ADiTo5bAurAa1W9JmYKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPPgvYqybT5rjR1JgPW7JNaYfhXS+tFHW4wSVahxgmDpuJmxuuxcQPV21YLk3EPdqI19oniOB57TY0OI5/AaIhuqW7M69jXoaJGtZRwJNZhCZlb0ZAPJ6+q1iZFsLx81Uu/AthQDINlEb+hlGoYtXi0nvm5hyDm4XwnG+thDQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ6yw0ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3BACC2BCFA;
	Mon, 13 Jul 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783940873;
	bh=v0+MG609dZTjGEN7kUhnpd5ADiTo5bAurAa1W9JmYKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZQ6yw0eeoHmWjLiNBiFZuU2WDWuyxUstyByICxagzKh+teIDgseiWHJ3F1nrGXpeD
	 +GYhYDXrrx2NhCqp5p6AIY1xqnNrSFD26tJi4POSJ187ulOWlmSmj673y8YN9X4Hef
	 yu/vcyA5rv9Rxn0Ri41GO4jTyT46hck58VXvc8QS8oQYjoyzMsYy2QHYKkQcsfKRqt
	 K8CCld7X1KIgOM/PQqvRW2QWZ4ctiGub+W3DN7uGiQcSeXq3EtNBYcbW2ah03ZLTw8
	 tg7mrEy4uQg4l03jxMPl6AKytLkf3DQOVtVeBSZGEP0DuWHQemeqD7cZVh8XMEyLuZ
	 LGnrpIIvYDEbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C7C44501;
	Mon, 13 Jul 2026 11:07:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Jul 2026 13:07:44 +0200
Subject: [PATCH RFC net-next v3 3/3] net: Const qualify network templated
 ctl_tables Arrays
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-jag-net_const_qualify-v3-3-7289fe9eaea6@kernel.org>
References: <20260713-jag-net_const_qualify-v3-0-7289fe9eaea6@kernel.org>
In-Reply-To: <20260713-jag-net_const_qualify-v3-0-7289fe9eaea6@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13709;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=v0+MG609dZTjGEN7kUhnpd5ADiTo5bAurAa1W9JmYKs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpUxwc5IEmEUrK0ky3OGnOlyhZX0IuZs9fuC
 HlMAC2ruSOzdYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqVMcHAAoJELqXzVK3
 lkFPcOEL/3gh1ZlNROJQUz2bR/chdON08U8HaJt8WsCxMwDE+poTeX1IiTwASupaM837S7At5q/
 ww9PmHIH91IhAhEDjy0UX+SZVg9i/5rrB120OE1+ca7pAIMYzLCM8fBMCK0Kjk+pL1gyGNnbFmp
 fcz9NIcMD1g1kSqJWoHobyul+LwhO/1SqFCxTajeI7GnivboWXkRsK+47f8fhqiPBNGI9aNg2tE
 xCUdKxDZ9lUcfzlX8svdSbZo3UVOtGTiUASgC0t5jQ8BJqbJsTHpoaVYHf+bZ0SirlouhDJxgNC
 4uDTllGBaI11paF4zrXNsPkvx59yTsMAxQPUwFjrfOp7QnhLBEaKPL8lXR2GTVIdgjrLB6dn1Ga
 rUb4ybILLIUkvjX0Bem18RanSK8/hNPGPzC17VUiq12g5TenibITX2nHRTZnPVV+4w4nZwlBR5M
 YIffm/BmHkZ09wGAdoV24djw5Ixf4gAPA7u+SrCmbg8mCKApvs4He/5dRqFHBKPtDqLMwH4WFJ6
 bw=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1328-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,netfilter.org,strlen.de,nwl.cc,gmail.com,secunet.com,gondor.apana.org.au,linux.alibaba.com,linux.ibm.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:kuniyu@google.com,m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-sctp@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:virtualization@lists.linux.dev,m:joel.granados@kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joel.granados@kernel.org,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joel.granados@kernel.org,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 478BA74A28F

Add duplication helpers in the cases where the ctl_table array elements
are modified after duplication. Helpers return a ctl_table as const
pointer allowing the const qualification of the static global ctl_table
array.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 net/core/sysctl_net_core.c        | 38 +++++++++++++++++----------
 net/ipv4/sysctl_net_ipv4.c        | 54 +++++++++++++++++++++++----------------
 net/ipv4/xfrm4_policy.c           | 22 ++++++++++++----
 net/ipv6/xfrm6_policy.c           | 22 ++++++++++++----
 net/netfilter/nf_hooks_lwtunnel.c |  4 +--
 net/smc/smc_sysctl.c              | 26 ++++++++++++++-----
 net/unix/sysctl_net_unix.c        | 21 +++++++++++----
 net/vmw_vsock/af_vsock.c          | 25 +++++++++++++-----
 8 files changed, 146 insertions(+), 66 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12393ba926ebf5a2dd4ea73ef03ee8..eb35da3556f4aa00cecd4582ab94e339d2518506 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -678,7 +678,7 @@ static struct ctl_table net_core_table[] = {
 	},
 };
 
-static struct ctl_table netns_core_table[] = {
+static const struct ctl_table netns_core_table[] = {
 #if IS_ENABLED(CONFIG_RPS)
 	{
 		.procname	= "rps_default_mask",
@@ -787,26 +787,38 @@ static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
 }
 __setup("fb_tunnels=", fb_tunnels_only_for_init_net_sysctl_setup);
 
-static __net_init int sysctl_core_net_init(struct net *net)
+static const struct ctl_table *netns_core_table_dup(struct net *net)
 {
 	size_t table_size = ARRAY_SIZE(netns_core_table);
 	struct ctl_table *tbl;
+	int i;
+
+	tbl = kmemdup(netns_core_table, sizeof(netns_core_table), GFP_KERNEL);
+	if (!tbl)
+		return NULL;
+
+	for (i = 0; i < table_size; ++i) {
+		if (tbl[i].data == &sysctl_wmem_max)
+			break;
+
+		tbl[i].data += (char *)net - (char *)&init_net;
+	}
+	for (; i < table_size; ++i)
+		tbl[i].mode &= ~0222;
+
+	return tbl;
+}
+
+static __net_init int sysctl_core_net_init(struct net *net)
+{
+	size_t table_size = ARRAY_SIZE(netns_core_table);
+	const struct ctl_table *tbl;
 
 	tbl = netns_core_table;
 	if (!net_eq(net, &init_net)) {
-		int i;
-		tbl = kmemdup(tbl, sizeof(netns_core_table), GFP_KERNEL);
+		tbl = netns_core_table_dup(net);
 		if (tbl == NULL)
 			goto err_dup;
-
-		for (i = 0; i < table_size; ++i) {
-			if (tbl[i].data == &sysctl_wmem_max)
-				break;
-
-			tbl[i].data += (char *)net - (char *)&init_net;
-		}
-		for (; i < table_size; ++i)
-			tbl[i].mode &= ~0222;
 	}
 
 	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl, table_size);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ca1180dba1dea9ce72028ba49b7f953da343336b..2f0363bca2a88d68276670cfce6fb04398f82bc5 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -624,7 +624,7 @@ static struct ctl_table ipv4_table[] = {
 	},
 };
 
-static struct ctl_table ipv4_net_table[] = {
+static const struct ctl_table ipv4_net_table[] = {
 	{
 		.procname	= "tcp_max_tw_buckets",
 		.data		= &init_net.ipv4.tcp_death_row.sysctl_max_tw_buckets,
@@ -1654,35 +1654,45 @@ static struct ctl_table ipv4_net_table[] = {
 	},
 };
 
-static __net_init int ipv4_sysctl_init_net(struct net *net)
+static const struct ctl_table *ipv4_net_table_dup(struct net *net)
 {
 	size_t table_size = ARRAY_SIZE(ipv4_net_table);
 	struct ctl_table *table;
+	int i;
+
+	table = kmemdup(ipv4_net_table, sizeof(ipv4_net_table), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	for (i = 0; i < table_size; i++) {
+		if (table[i].data) {
+			/* Update the variables to point into
+			 * the current struct net
+			 */
+			table[i].data += (void *)net - (void *)&init_net;
+		} else {
+			/* Entries without data pointer are global;
+			 * Make them read-only in non-init_net ns
+			 */
+			table[i].mode &= ~0222;
+		}
+		if (table[i].extra2 >= (void *)&init_net.ipv4 &&
+		    table[i].extra2 < (void *)(&init_net.ipv4 + 1))
+			table[i].extra2 += (void *)net - (void *)&init_net;
+	}
+	return table;
+}
+
+static __net_init int ipv4_sysctl_init_net(struct net *net)
+{
+	size_t table_size = ARRAY_SIZE(ipv4_net_table);
+	const struct ctl_table *table;
 
 	table = ipv4_net_table;
 	if (!net_eq(net, &init_net)) {
-		int i;
-
-		table = kmemdup(table, sizeof(ipv4_net_table), GFP_KERNEL);
+		table = ipv4_net_table_dup(net);
 		if (!table)
 			goto err_alloc;
-
-		for (i = 0; i < table_size; i++) {
-			if (table[i].data) {
-				/* Update the variables to point into
-				 * the current struct net
-				 */
-				table[i].data += (void *)net - (void *)&init_net;
-			} else {
-				/* Entries without data pointer are global;
-				 * Make them read-only in non-init_net ns
-				 */
-				table[i].mode &= ~0222;
-			}
-			if (table[i].extra2 >= (void *)&init_net.ipv4 &&
-			    table[i].extra2 < (void *)(&init_net.ipv4 + 1))
-				table[i].extra2 += (void *)net - (void *)&init_net;
-		}
 	}
 
 	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 58faf1ddd2b151e4569bb6351029718dac37521b..ab7a01029d490416d36482f7a3189f83d6670f42 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -141,7 +141,7 @@ static const struct xfrm_policy_afinfo xfrm4_policy_afinfo = {
 };
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table xfrm4_policy_table[] = {
+static const struct ctl_table xfrm4_policy_table[] = {
 	{
 		.procname       = "xfrm4_gc_thresh",
 		.data           = &init_net.xfrm.xfrm4_dst_ops.gc_thresh,
@@ -151,18 +151,30 @@ static struct ctl_table xfrm4_policy_table[] = {
 	},
 };
 
-static __net_init int xfrm4_net_sysctl_init(struct net *net)
+static const struct ctl_table *xfrm4_policy_table_dup(struct net *net)
 {
 	struct ctl_table *table;
+
+	table = kmemdup(xfrm4_policy_table, sizeof(xfrm4_policy_table),
+			GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
+
+	return table;
+}
+
+static __net_init int xfrm4_net_sysctl_init(struct net *net)
+{
+	const struct ctl_table *table;
 	struct ctl_table_header *hdr;
 
 	table = xfrm4_policy_table;
 	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(xfrm4_policy_table), GFP_KERNEL);
+		table = xfrm4_policy_table_dup(net);
 		if (!table)
 			goto err_alloc;
-
-		table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
 	}
 
 	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 125ea9a5b8a082052380b7fd7ed7123f5247d7cc..1e0385b62cde3f6d23382f92bbad5d7fdd09f1ef 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -186,7 +186,7 @@ static void xfrm6_policy_fini(void)
 }
 
 #ifdef CONFIG_SYSCTL
-static struct ctl_table xfrm6_policy_table[] = {
+static const struct ctl_table xfrm6_policy_table[] = {
 	{
 		.procname       = "xfrm6_gc_thresh",
 		.data		= &init_net.xfrm.xfrm6_dst_ops.gc_thresh,
@@ -196,18 +196,30 @@ static struct ctl_table xfrm6_policy_table[] = {
 	},
 };
 
-static int __net_init xfrm6_net_sysctl_init(struct net *net)
+static const struct ctl_table *xfrm6_policy_table_dup(struct net *net)
 {
 	struct ctl_table *table;
+
+	table = kmemdup(xfrm6_policy_table, sizeof(xfrm6_policy_table),
+			GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
+
+	return table;
+}
+
+static int __net_init xfrm6_net_sysctl_init(struct net *net)
+{
+	const struct ctl_table *table;
 	struct ctl_table_header *hdr;
 
 	table = xfrm6_policy_table;
 	if (!net_eq(net, &init_net)) {
-		table = kmemdup(table, sizeof(xfrm6_policy_table), GFP_KERNEL);
+		table = xfrm6_policy_table_dup(net);
 		if (!table)
 			goto err_alloc;
-
-		table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
 	}
 
 	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
diff --git a/net/netfilter/nf_hooks_lwtunnel.c b/net/netfilter/nf_hooks_lwtunnel.c
index 2d890dd04ff89041e6aec3741f24cdd7bc47d1fe..4e1eef1ba0f1559ca35f024723af551c6c9e7d35 100644
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -54,7 +54,7 @@ int nf_hooks_lwtunnel_sysctl_handler(const struct ctl_table *table, int write,
 }
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_sysctl_handler);
 
-static struct ctl_table nf_lwtunnel_sysctl_table[] = {
+static const struct ctl_table nf_lwtunnel_sysctl_table[] = {
 	{
 		.procname	= "nf_hooks_lwtunnel",
 		.data		= NULL,
@@ -66,8 +66,8 @@ static struct ctl_table nf_lwtunnel_sysctl_table[] = {
 
 static int __net_init nf_lwtunnel_net_init(struct net *net)
 {
+	const struct ctl_table *table;
 	struct ctl_table_header *hdr;
-	struct ctl_table *table;
 
 	table = nf_lwtunnel_sysctl_table;
 	if (!net_eq(net, &init_net)) {
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index b1efed5462435b1a6f2f59584a4cf47f5f6e1981..09dad48337f6164f5765fa793412bdebf47e61ca 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -97,7 +97,7 @@ static int proc_smc_hs_ctrl(const struct ctl_table *ctl, int write,
 }
 #endif /* CONFIG_SMC_HS_CTRL_BPF */
 
-static struct ctl_table smc_table[] = {
+static const struct ctl_table smc_table[] = {
 	{
 		.procname       = "autocorking_size",
 		.data           = &init_net.smc.sysctl_autocorking_size,
@@ -195,14 +195,29 @@ static struct ctl_table smc_table[] = {
 #endif /* CONFIG_SMC_HS_CTRL_BPF */
 };
 
-int __net_init smc_sysctl_net_init(struct net *net)
+static const struct ctl_table *smc_table_dup(struct net *net)
 {
 	size_t table_size = ARRAY_SIZE(smc_table);
 	struct ctl_table *table;
+	int i;
+
+	table = kmemdup(smc_table, sizeof(smc_table), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	for (i = 0; i < table_size; i++)
+		table[i].data += (void *)net - (void *)&init_net;
+
+	return table;
+}
+
+int __net_init smc_sysctl_net_init(struct net *net)
+{
+	size_t table_size = ARRAY_SIZE(smc_table);
+	const struct ctl_table *table;
 
 	table = smc_table;
 	if (!net_eq(net, &init_net)) {
-		int i;
 #if IS_ENABLED(CONFIG_SMC_HS_CTRL_BPF)
 		struct smc_hs_ctrl *ctrl;
 
@@ -214,12 +229,9 @@ int __net_init smc_sysctl_net_init(struct net *net)
 		rcu_read_unlock();
 #endif /* CONFIG_SMC_HS_CTRL_BPF */
 
-		table = kmemdup(table, sizeof(smc_table), GFP_KERNEL);
+		table = smc_table_dup(net);
 		if (!table)
 			goto err_alloc;
-
-		for (i = 0; i < table_size; i++)
-			table[i].data += (void *)net - (void *)&init_net;
 	}
 
 	net->smc.smc_hdr = register_net_sysctl_sz(net, "net/smc", table,
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index e02ed6e3955c06b60cf4afb02656df8956f075ba..47660d5726bbd7d812762f4feffa9a0a42499d7d 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -13,7 +13,7 @@
 
 #include "af_unix.h"
 
-static struct ctl_table unix_table[] = {
+static const struct ctl_table unix_table[] = {
 	{
 		.procname	= "max_dgram_qlen",
 		.data		= &init_net.unx.sysctl_max_dgram_qlen,
@@ -23,18 +23,29 @@ static struct ctl_table unix_table[] = {
 	},
 };
 
-int __net_init unix_sysctl_register(struct net *net)
+static const struct ctl_table *unix_table_dup(struct net *net)
 {
 	struct ctl_table *table;
 
+	table = kmemdup(unix_table, sizeof(unix_table), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table[0].data = &net->unx.sysctl_max_dgram_qlen;
+
+	return table;
+}
+
+int __net_init unix_sysctl_register(struct net *net)
+{
+	const struct ctl_table *table;
+
 	if (net_eq(net, &init_net)) {
 		table = unix_table;
 	} else {
-		table = kmemdup(unix_table, sizeof(unix_table), GFP_KERNEL);
+		table = unix_table_dup(net);
 		if (!table)
 			goto err_alloc;
-
-		table[0].data = &net->unx.sysctl_max_dgram_qlen;
 	}
 
 	net->unx.ctl = register_net_sysctl_sz(net, "net/unix", table,
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467994428f1a590f559b78d8c17f6ba60..caebef73ea58d2b6043ca3fe3b6872f92fbe9fa6 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2899,7 +2899,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	return 0;
 }
 
-static struct ctl_table vsock_table[] = {
+static const struct ctl_table vsock_table[] = {
 	{
 		.procname	= "ns_mode",
 		.data		= &init_net.vsock.mode,
@@ -2925,20 +2925,31 @@ static struct ctl_table vsock_table[] = {
 	},
 };
 
-static int __net_init vsock_sysctl_register(struct net *net)
+static const struct ctl_table *vsock_table_dup(struct net *net)
 {
 	struct ctl_table *table;
 
+	table = kmemdup(vsock_table, sizeof(vsock_table), GFP_KERNEL);
+	if (!table)
+		return NULL;
+
+	table[0].data = &net->vsock.mode;
+	table[1].data = &net->vsock.child_ns_mode;
+	table[2].data = &net->vsock.g2h_fallback;
+
+	return table;
+}
+
+static int __net_init vsock_sysctl_register(struct net *net)
+{
+	const struct ctl_table *table;
+
 	if (net_eq(net, &init_net)) {
 		table = vsock_table;
 	} else {
-		table = kmemdup(vsock_table, sizeof(vsock_table), GFP_KERNEL);
+		table = vsock_table_dup(net);
 		if (!table)
 			goto err_alloc;
-
-		table[0].data = &net->vsock.mode;
-		table[1].data = &net->vsock.child_ns_mode;
-		table[2].data = &net->vsock.g2h_fallback;
 	}
 
 	net->vsock.sysctl_hdr = register_net_sysctl_sz(net, "net/vsock", table,

-- 
2.50.1



