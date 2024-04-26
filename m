Return-Path: <linux-sctp+bounces-111-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF928B35D6
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 12:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F06A1C21CA6
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53391146D62;
	Fri, 26 Apr 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNp1oTgw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F2145340;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128431; cv=none; b=RjmMuNHPB+npLU9dqIUiA51DctP+UZSKyMOd7HppGKbBSV6Ku0Hs2eOJXLnXegqDqfVEWM44ECYNeGDaw5AHzoc820K2r6k2q6VTwxVvLcvOKGfmxEnD4Mr3tAiwZSoiiRz9VLsqSkumSe+k/Lt4Y5jWf8qlyMa08vo23qRlm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128431; c=relaxed/simple;
	bh=uXOWxke90nQNYr0WBMLQq1S/VTP5GVY/K8ko9jpt5Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AsFowJsZ7dKu8HLDzJeqkswNS/3aXxuI24Evq6pAGSN1XAWc4t/c86b6cosFpu9CONfmkhepmeTM6O2PnqD6z+MXIWeBPOhsR694wZ3//HcyDF0zi5VEe7BRGgVrs0t5D/f7zMX/Yr8McpXfRUEFjfTnpMwFo8AaaftWNtZznkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNp1oTgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CEA8C32782;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128431;
	bh=uXOWxke90nQNYr0WBMLQq1S/VTP5GVY/K8ko9jpt5Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TNp1oTgw9QK44460Lz7tD3JO/gkOQ6Bf3V+NWUBF963pSsGr3ByI9hj3vLcwkTeNc
	 2/4dFnXzAW+cRiSjeOFVLuLT2fDpMMQjTYAWlsAB9zlrM2+2cbwUxNfkaWqc7VZ+Wp
	 wOSkcJdo4EjTp0swB/nag+c3hAqklkJ/zEInYmnJRkf4DuIAolF2Xx2FZcPyNCw6C8
	 K3wDEgw0Oo+Doj3xHYw53NvqIPEerwOR68+xLiPp6MGV02pfHHPlPDVMMG2DSXQluj
	 FFjoKOXXPA01hkXKHTMgbn6K94+bFYxpIzEqeU021BYiMpiHi3tb4MCYfAnVDfH2PT
	 9usSD+9oJe5Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD17C4345F;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Apr 2024 12:46:58 +0200
Subject: [PATCH v5 6/8] netfilter: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-jag-sysctl_remset_net-v5-6-e3b12f6111a6@samsung.com>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
In-Reply-To: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6266;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=8f/Dg8d3/rC6e0dRD7zz4wfwGN+n8oo3AOmfFngwe40=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYrhit74j+niBAfojXF9WQ6AK2cUjyKaOVdS
 WBvnrEv0dPtrIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmK4YrAAoJELqXzVK3
 lkFPepkL/35fNbVS7khytepmadlBk7EeuGSrorFRVeYOl8eAKIfbFytyp28V9YopThUz5yuqxSi
 3L6wuJuOkSPyW5GVF/OZcMp3CdHLs1m9iEUK+1pH+wGWHQ06QiFCtSAxrfdA5jk4ziG7L3tdYDA
 R1JpcLbJkpgQyZin/1F7/ybNDPyZrzvvou5nWzFr4job1o2W4uozCRW+coAFJYkOjQrleyQ6la6
 ekPnXOw95UAnXeKNY3EjBQUKFhqM+r39LFmQ5KlMMpCyDJBwQhW7AdMc3F45YUw0Fq3vT8LRlZc
 RK0NOrwj5VXv1QHbxFDkGNONpjpdfazz7d4Q26/5TlQz+wYksWHR5a8gqjbwCZjK/qtPBqPBU6S
 eCZ7rcbBmSIhF4kTKRf8OxPpRcQ4H8Fzcrz/P3F0xv0t3Ezk62OS0zdR5HSbL14V6UUFAUN/6e7
 i4fnZGNiyN0XHvQrUF8heJRfnhYNc3t45qF2i4F4iLRSr+uyG6Rqr1mEsndS8DVCQCo4AIrEN06
 s4=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

* Remove sentinel elements from ctl_table structs
* Remove instances where an array element is zeroed out to make it look
  like a sentinel. This is not longer needed and is safe after commit
  c899710fe7f9 ("networking: Update to register_net_sysctl_sz") added
  the array size to the ctl_table registration
* Remove the need for having __NF_SYSCTL_CT_LAST_SYSCTL as the
  sysctl array size is now in NF_SYSCTL_CT_LAST_SYSCTL
* Remove extra element in ctl_table arrays declarations

Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/bridge/br_netfilter_hooks.c         | 1 -
 net/ipv6/netfilter/nf_conntrack_reasm.c | 1 -
 net/netfilter/ipvs/ip_vs_ctl.c          | 5 +----
 net/netfilter/ipvs/ip_vs_lblc.c         | 5 +----
 net/netfilter/ipvs/ip_vs_lblcr.c        | 5 +----
 net/netfilter/nf_conntrack_standalone.c | 6 +-----
 net/netfilter/nf_log.c                  | 3 +--
 7 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 35e10c5a766d..d31f57ffe985 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1219,7 +1219,6 @@ static struct ctl_table brnf_table[] = {
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
-	{ }
 };
 
 static inline void br_netfilter_sysctl_default(struct brnf_net *brnf)
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 1a51a44571c3..8531750ec081 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -62,7 +62,6 @@ static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
-	{ }
 };
 
 static int nf_ct_frag6_sysctl_register(struct net *net)
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..50b5dbe40eb8 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2263,7 +2263,6 @@ static struct ctl_table vs_vars[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{ }
 };
 
 #endif
@@ -4286,10 +4285,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns) {
-			tbl[0].procname = NULL;
+		if (net->user_ns != &init_user_ns)
 			ctl_table_size = 0;
-		}
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 8ceec7a2fa8f..2423513d701d 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -123,7 +123,6 @@ static struct ctl_table vs_vars_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 #endif
 
@@ -563,10 +562,8 @@ static int __net_init __ip_vs_lblc_init(struct net *net)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns) {
-			ipvs->lblc_ctl_table[0].procname = NULL;
+		if (net->user_ns != &init_user_ns)
 			vars_table_size = 0;
-		}
 
 	} else
 		ipvs->lblc_ctl_table = vs_vars_table;
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 0fb64707213f..cdb1d4bf6761 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -294,7 +294,6 @@ static struct ctl_table vs_vars_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 #endif
 
@@ -749,10 +748,8 @@ static int __net_init __ip_vs_lblcr_init(struct net *net)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns) {
-			ipvs->lblcr_ctl_table[0].procname = NULL;
+		if (net->user_ns != &init_user_ns)
 			vars_table_size = 0;
-		}
 	} else
 		ipvs->lblcr_ctl_table = vs_vars_table;
 	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 0ee98ce5b816..2f226cfb32d0 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -616,11 +616,9 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_LWTUNNEL,
 #endif
 
-	__NF_SYSCTL_CT_LAST_SYSCTL,
+	NF_SYSCTL_CT_LAST_SYSCTL,
 };
 
-#define NF_SYSCTL_CT_LAST_SYSCTL (__NF_SYSCTL_CT_LAST_SYSCTL + 1)
-
 static struct ctl_table nf_ct_sysctl_table[] = {
 	[NF_SYSCTL_CT_MAX] = {
 		.procname	= "nf_conntrack_max",
@@ -957,7 +955,6 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.proc_handler	= nf_hooks_lwtunnel_sysctl_handler,
 	},
 #endif
-	{}
 };
 
 static struct ctl_table nf_ct_netfilter_table[] = {
@@ -968,7 +965,6 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 static void nf_conntrack_standalone_init_tcp_sysctl(struct net *net,
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 370f8231385c..d42ba733496b 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -395,7 +395,7 @@ static const struct seq_operations nflog_seq_ops = {
 
 #ifdef CONFIG_SYSCTL
 static char nf_log_sysctl_fnames[NFPROTO_NUMPROTO-NFPROTO_UNSPEC][3];
-static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO+1];
+static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO];
 static struct ctl_table_header *nf_log_sysctl_fhdr;
 
 static struct ctl_table nf_log_sysctl_ftable[] = {
@@ -406,7 +406,6 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 static int nf_log_proc_dostring(struct ctl_table *table, int write,

-- 
2.43.0



