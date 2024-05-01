Return-Path: <linux-sctp+bounces-137-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C758B87E8
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FAB1F23795
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414A55E5C;
	Wed,  1 May 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1R+JrGK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736E5337A;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555809; cv=none; b=izCyZe1Y0t56joaLaJfLhV/+GjRALnGOzC/P2pFJ8NYHHontZ/d8NhKHhPokVGnu8ssQ3RKkc9LHYuGllpBu/MhnjY64oAP8fb1XJpkLPpfeG+xC/hdn9tcmK/VHTbF3bQxLLPoEIkkaRRGvzZSm5KB4O4uQnt6iCq2fbW8uNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555809; c=relaxed/simple;
	bh=Hs4CIMiIZGeHllcXeU3RbbJDyQqAa0uq80Ks2Jnm8Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohKmORNSLeVZyYH6uEqR908UC9nbl61NJmVfCF4Qef8cQkuJfInD06eeFkHka+DBwSIGrkyZBJTZP+Ezk3uY+NHZyjHpMiz1FYi2rIzXIU5B5KTFV0kwfLz5FJZsMNibjXVrBeSBAQRFHgYxGp/5Sr5Rvct2scnBGIG9xlXPU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1R+JrGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06955C4DDE0;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714555809;
	bh=Hs4CIMiIZGeHllcXeU3RbbJDyQqAa0uq80Ks2Jnm8Zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s1R+JrGKcwREYm8VUjdXTK4yT9o2yp/IXXY6DqRuu0C09GsGSMb/Fi2RhnipOUDnh
	 zliWw/O+iWEQX7v6/yZMCG9jHLgZ609DCQWUIRKddMtODVgQwFyQHZMbOCDBJztbwI
	 GG1zatCBi2ZGcffTe6fYPjZinI0nOe5awWha5Mj20h3MbtejiLEPWfbOZNSjN8B5YP
	 CUBvtpVyGqnNhbrqItCxIoJdLI0GaSyOKejjg5CIz1tYqXTy1rBDy+ijxGpA/dq2kP
	 8vT3bxo18eHz7vZGXPWkmsazz9QYe0cgbI3jKi/k8rV/MeuKypIGxLOg5WCjtbbYZM
	 w0lDcQTw4i5KA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F31C10F1A;
	Wed,  1 May 2024 09:30:08 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Wed, 01 May 2024 11:29:30 +0200
Subject: [PATCH net-next v6 6/8] netfilter: Remove the now superfluous
 sentinel elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-jag-sysctl_remset_net-v6-6-370b702b6b4a@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6266;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ZJU6TElM2+XH6ApPP4RnXAcOUWTyuK0uc9QoTXYFVbM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYyC53UikyWmcEj8hR1r5Hdd77UD0AtCiMha
 K+mSTGGxtc7FokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmMgudAAoJELqXzVK3
 lkFPAcoMAJFCT6wfgfaGfvbjg32xufgBVD2qVMrA4NBy/Tt9cmtSV4clxRehcuGt3daaJCyMigN
 0qkXp7dnwl8+4PzD3RgpjavEs/Nj5mMMHIR3lMAvQd7JtIhRonDJKnG5znHFFF4HO8zm4nDyKtm
 yGtCdPO3/65Hj5ByFJtUhhLUWXwELtg/l+N8q/owAqDeoidBL2OvC33kg+rdGB7KKjLDa9UJ4EW
 tayeawL8anhCxhJi2H3X8Vh4WyMydKsMQ7+0yULkqL/2IarI4jL9hp5eH6DE71UJWG4t9DmgIEw
 6w5xlOoBUKF6TEWV26aRcZ2UvlYTXVVMfAcgLuZ9RAoTXo0djN7bwx5jMWTWW8indBHXqjaPXEY
 YLFvUuU6PyT4hLUsYGIBeStxSpnLLUbKD6IKg6mn3Yme+G41f/kEUsMwxvvnnATuFrNdu1NVZ0t
 6Rd4i1WWs62uvarEFyGIzd1khtpNX14l6BlREVnfgPVmoBIsczGd8ZaxbujHCOqUaPs4IZ77zB6
 Y8=
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
index 7948a9e7542c..bf30c50b5689 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1226,7 +1226,6 @@ static struct ctl_table brnf_table[] = {
 		.mode		= 0644,
 		.proc_handler	= brnf_sysctl_call_tables,
 	},
-	{ }
 };
 
 static inline void br_netfilter_sysctl_default(struct brnf_net *brnf)
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index ce8c14d8aff5..5e1b50c6a44d 100644
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
index bb9dea676ec1..74112e9c5dab 100644
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
index efedd2f13ac7..769fd7680fac 100644
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



