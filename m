Return-Path: <linux-sctp+bounces-136-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334AB8B87CB
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDBB21763
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75353E1B;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmwLOLdM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A93C502AD;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555809; cv=none; b=XmXtl9mCMUDOaYsrGLE8ScEo3OpLaMXUbEnQagfEEGmcg+sdDhnQt46+V4GIO6WwE3001waHs8V/70HwOerlBEOg7B4hNjqVgJicyz8nxYSpeGHLVUR91ovik9np0Qe/IxnCYhEMbea89+YbNrxYTp4GKzewqxu6hvwCk1bMAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555809; c=relaxed/simple;
	bh=Io7cqvw2wLY14Au1JnEZZZkw8IbmLHJMLMbiZk8NxGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9TuqgpbK8pJ+a1y15Ca6JTPDzrMzbCSHhBoxu1UWSI5yLqdxYhcDQsD8pMsjSjxd4UVD07gFN/KUljNZIoRMtrSteUsM8PMzTzsmKltgoJ+S3mn43olhr+IZq1AgLwDtvlgIkhISnqgN5Edjh4dMayG5lk1ZLoJMEcwP1eJX0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmwLOLdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9771C4AF48;
	Wed,  1 May 2024 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714555808;
	bh=Io7cqvw2wLY14Au1JnEZZZkw8IbmLHJMLMbiZk8NxGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nmwLOLdM/43Q4/nVG+HikJ1Dz92LLGLKmDDfkt4S+m3YQlGllTlmR7JM0Hhlnb4+t
	 o1wlIE/2bESaeb5WavD7TXC3ZDKM6E0lmHYqYq+ZueXUsnuUlDYSsTfFYZX/oPvC3W
	 Uf+avKY+vXf3EcD7B7Elqt8woVuZysvO4gdmi1brWz5GvsPaXODEPRlijnc6rZiwKg
	 95hbqpEcX8jeFD3MSnrA9JdDgiXve4GRcqEaxHGseKsajyebevCWjwjluSvlq6Di1C
	 WB//T3FBfo2xLorwxFTG6KHfR0tncXXBU9xq/kcSz7SZDDAZATs8KBRdU4WnK2a3MH
	 fY3sxfWOVhxsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79BC25B5F;
	Wed,  1 May 2024 09:30:08 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Wed, 01 May 2024 11:29:26 +0200
Subject: [PATCH net-next v6 2/8] net: ipv{6,4}: Remove the now superfluous
 sentinel elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-jag-sysctl_remset_net-v6-2-370b702b6b4a@samsung.com>
References: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
In-Reply-To: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, 
 Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=11538;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=so4CCtG8CcTsQ33TGct1GP2XFfZl6zTNK4d7wqdatx8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYyC5v3qxv5+bTRmq1upj62AlfqPqgc3fp4O
 aGsTSxNqJphOIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmMgubAAoJELqXzVK3
 lkFPG4UL/RqVWXPLCXUqf+qOCMrQtDz75OaErCGz5378pHr2W/aRTGssW1TCQLQXeMvmAiobZB9
 N/C+r+fvYdsb7TbFSqfYRRq+my7CLrl3FjT3K5AH3+mM1WWjGqT6spSfULAuOEI5yCfI1RnhqBq
 tdafN0x4aMK0oOjvLqhmH/+hkj0kg/C4LntzX4cHxjkK4pUZmnWnB+lY3FWty5Hi6jOVL9hOMkG
 7knXnXFqbmEez/6XvJ39oYps+zv34srLL5x46IPM7QT+TPGhXAm5uc0hf/wCqm+Waks6FmE8FOR
 Wt2ksqtwCYELJTW0HLJM9YOeQ8NcU8pXXUH9sc+OFqgZShSddlxSZAz4RrYIID/dtaJBOn5yyYh
 +h9QwpLpDid8zop/2tCThLcw+U665n1AwTVasXwcjUpZ7Bdl8tivZQ7pqaAoGcWs0hCKBNgOIjL
 MuFFqLv2ittGg/RlqtVsiD3mmkenY2Fc6KeuI6z6JW0+iHNx5G4v5G+vRbV2iLyl4xf0Ub8I5t6
 +8=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

* Remove sentinel element from ctl_table structs.
* Remove the zeroing out of an array element (to make it look like a
  sentinel) in sysctl_route_net_init And ipv6_route_sysctl_init.
  This is not longer needed and is safe after commit c899710fe7f9
  ("networking: Update to register_net_sysctl_sz") added the array size
  to the ctl_table registration.
* Remove extra sentinel element in the declaration of devinet_vars.
* Removed the "-1" in __devinet_sysctl_register, sysctl_route_net_init,
  ipv6_sysctl_net_init and ipv4_sysctl_init_net that adjusted for having
  an extra empty element when looping over ctl_table arrays
* Replace the for loop stop condition in __addrconf_sysctl_register that
  tests for procname == NULL with one that depends on array size
* Removing the unprivileged user check in ipv6_route_sysctl_init is
  safe as it is replaced by calling ipv6_route_sysctl_table_size;
  introduced in commit c899710fe7f9 ("networking: Update to
  register_net_sysctl_sz")
* Use a table_size variable to keep the value of ARRAY_SIZE

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ipv4/devinet.c         | 5 ++---
 net/ipv4/ip_fragment.c     | 2 --
 net/ipv4/route.c           | 8 ++------
 net/ipv4/sysctl_net_ipv4.c | 7 +++----
 net/ipv4/xfrm4_policy.c    | 1 -
 net/ipv6/addrconf.c        | 8 +++-----
 net/ipv6/icmp.c            | 1 -
 net/ipv6/reassembly.c      | 2 --
 net/ipv6/route.c           | 5 -----
 net/ipv6/sysctl_net_ipv6.c | 8 +++-----
 net/ipv6/xfrm6_policy.c    | 1 -
 11 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 364dbf0cd9bf..a612c57b61c5 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2520,7 +2520,7 @@ static int ipv4_doint_and_flush(struct ctl_table *ctl, int write,
 
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table devinet_vars[__IPV4_DEVCONF_MAX];
+	struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
 } devinet_sysctl = {
 	.devinet_vars = {
 		DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
@@ -2583,7 +2583,7 @@ static int __devinet_sysctl_register(struct net *net, char *dev_name,
 	if (!t)
 		goto out;
 
-	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
+	for (i = 0; i < ARRAY_SIZE(t->devinet_vars); i++) {
 		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
 		t->devinet_vars[i].extra1 = p;
 		t->devinet_vars[i].extra2 = net;
@@ -2657,7 +2657,6 @@ static struct ctl_table ctl_forward_entry[] = {
 		.extra1		= &ipv4_devconf,
 		.extra2		= &init_net,
 	},
-	{ },
 };
 #endif
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 534b98a0744a..08e2c92e25ab 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -580,7 +580,6 @@ static struct ctl_table ip4_frags_ns_ctl_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &dist_min,
 	},
-	{ }
 };
 
 /* secret interval has been deprecated */
@@ -593,7 +592,6 @@ static struct ctl_table ip4_frags_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 
 static int __net_init ip4_frags_ns_ctl_register(struct net *net)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 0fd9a3d7ac4a..5fd54103174f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3496,7 +3496,6 @@ static struct ctl_table ipv4_route_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 static const char ipv4_route_flush_procname[] = "flush";
@@ -3530,7 +3529,6 @@ static struct ctl_table ipv4_route_netns_table[] = {
 		.mode       = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ },
 };
 
 static __net_init int sysctl_route_net_init(struct net *net)
@@ -3548,16 +3546,14 @@ static __net_init int sysctl_route_net_init(struct net *net)
 
 		/* Don't export non-whitelisted sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns) {
-			if (tbl[0].procname != ipv4_route_flush_procname) {
-				tbl[0].procname = NULL;
+			if (tbl[0].procname != ipv4_route_flush_procname)
 				table_size = 0;
-			}
 		}
 
 		/* Update the variables to point into the current struct net
 		 * except for the first element flush
 		 */
-		for (i = 1; i < ARRAY_SIZE(ipv4_route_netns_table) - 1; i++)
+		for (i = 1; i < table_size; i++)
 			tbl[i].data += (void *)net - (void *)&init_net;
 	}
 	tbl[0].extra1 = net;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ce5d19978a26..162a0a3b6ba5 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -575,7 +575,6 @@ static struct ctl_table ipv4_table[] = {
 		.extra1		= &sysctl_fib_sync_mem_min,
 		.extra2		= &sysctl_fib_sync_mem_max,
 	},
-	{ }
 };
 
 static struct ctl_table ipv4_net_table[] = {
@@ -1502,11 +1501,11 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
-	{ }
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
 {
+	size_t table_size = ARRAY_SIZE(ipv4_net_table);
 	struct ctl_table *table;
 
 	table = ipv4_net_table;
@@ -1517,7 +1516,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 		if (!table)
 			goto err_alloc;
 
-		for (i = 0; i < ARRAY_SIZE(ipv4_net_table) - 1; i++) {
+		for (i = 0; i < table_size; i++) {
 			if (table[i].data) {
 				/* Update the variables to point into
 				 * the current struct net
@@ -1533,7 +1532,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 	}
 
 	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
-						    ARRAY_SIZE(ipv4_net_table));
+						    table_size);
 	if (!net->ipv4.ipv4_hdr)
 		goto err_reg;
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index fccbbd3e1a4b..0294fef577fa 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -152,7 +152,6 @@ static struct ctl_table xfrm4_policy_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 static __net_init int xfrm4_net_sysctl_init(struct net *net)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9aa0900abfa1..5c424a0e7232 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7184,14 +7184,12 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-	{
-		/* sentinel */
-	}
 };
 
 static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 		struct inet6_dev *idev, struct ipv6_devconf *p)
 {
+	size_t table_size = ARRAY_SIZE(addrconf_sysctl);
 	int i, ifindex;
 	struct ctl_table *table;
 	char path[sizeof("net/ipv6/conf/") + IFNAMSIZ];
@@ -7200,7 +7198,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 	if (!table)
 		goto out;
 
-	for (i = 0; table[i].data; i++) {
+	for (i = 0; i < table_size; i++) {
 		table[i].data += (char *)p - (char *)&ipv6_devconf;
 		/* If one of these is already set, then it is not safe to
 		 * overwrite either of them: this makes proc_dointvec_minmax
@@ -7215,7 +7213,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 	snprintf(path, sizeof(path), "net/ipv6/conf/%s", dev_name);
 
 	p->sysctl_header = register_net_sysctl_sz(net, path, table,
-						  ARRAY_SIZE(addrconf_sysctl));
+						  table_size);
 	if (!p->sysctl_header)
 		goto free;
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index d285c1f6f1a6..7b31674644ef 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1206,7 +1206,6 @@ static struct ctl_table ipv6_icmp_table_template[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{ },
 };
 
 struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index ee95cdcc8747..439f93512b0a 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -436,7 +436,6 @@ static struct ctl_table ip6_frags_ns_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 
 /* secret interval has been deprecated */
@@ -449,7 +448,6 @@ static struct ctl_table ip6_frags_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 
 static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3e0b2cb20fd2..c43b0616742e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6428,7 +6428,6 @@ static struct ctl_table ipv6_route_table_template[] = {
 		.extra1		=	SYSCTL_ZERO,
 		.extra2		=	SYSCTL_ONE,
 	},
-	{ }
 };
 
 struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
@@ -6452,10 +6451,6 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
 		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
 		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
 		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			table[1].procname = NULL;
 	}
 
 	return table;
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 75de55f907b0..c060285ff47f 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -213,7 +213,6 @@ static struct ctl_table ipv6_table_template[] = {
 		.proc_handler	= proc_doulongvec_minmax,
 		.extra2		= &ioam6_id_wide_max,
 	},
-	{ }
 };
 
 static struct ctl_table ipv6_rotable[] = {
@@ -248,11 +247,11 @@ static struct ctl_table ipv6_rotable[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif /* CONFIG_NETLABEL */
-	{ }
 };
 
 static int __net_init ipv6_sysctl_net_init(struct net *net)
 {
+	size_t table_size = ARRAY_SIZE(ipv6_table_template);
 	struct ctl_table *ipv6_table;
 	struct ctl_table *ipv6_route_table;
 	struct ctl_table *ipv6_icmp_table;
@@ -264,7 +263,7 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 	if (!ipv6_table)
 		goto out;
 	/* Update the variables to point into the current struct net */
-	for (i = 0; i < ARRAY_SIZE(ipv6_table_template) - 1; i++)
+	for (i = 0; i < table_size; i++)
 		ipv6_table[i].data += (void *)net - (void *)&init_net;
 
 	ipv6_route_table = ipv6_route_sysctl_init(net);
@@ -276,8 +275,7 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 		goto out_ipv6_route_table;
 
 	net->ipv6.sysctl.hdr = register_net_sysctl_sz(net, "net/ipv6",
-						      ipv6_table,
-						      ARRAY_SIZE(ipv6_table_template));
+						      ipv6_table, table_size);
 	if (!net->ipv6.sysctl.hdr)
 		goto out_ipv6_icmp_table;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 7924e08ee142..cc885d3aa9e5 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -184,7 +184,6 @@ static struct ctl_table xfrm6_policy_table[] = {
 		.mode		= 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 static int __net_init xfrm6_net_sysctl_init(struct net *net)

-- 
2.43.0



