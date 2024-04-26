Return-Path: <linux-sctp+bounces-112-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35468B35EC
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 12:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32C2830F3
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947C147C9E;
	Fri, 26 Apr 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltCPGgXe"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AECD144D34;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128431; cv=none; b=AqAbYmPk0b2f/7Wzls0WzZZ1JAWi/l61OwlJmv4eqKehc4HO+PYj4KF+p8matgLLARgqDmtPfkZQza6CtXhfec1mxSVjogyW97a+QJenD4kx7wrOqcaEqdRU5gBW0SsFLAXViKh342z1Iyp+Lvm2il7nt3OANOGIOoo9/ZR3f9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128431; c=relaxed/simple;
	bh=MLLgeQP7IMlxSSyHDKz7Xc2vb7hwc9bWb8kATLJW89U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=az7r85szahNc48Uz+jxT4GxnK6X5JhTt8g0X8FluvZjjZwIG1L+DBeMIAPd3W69J1X9YkH7+rnUDrtZK5uLKsmELzI1EsABTmEE9rezVHxcqnLFD2Ve2CKBTr9GOVphVORrACtU/jM+wQ8WzqiK51PV3AOa+8U1ObQBhU8bSYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltCPGgXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34DEDC4DDE3;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128431;
	bh=MLLgeQP7IMlxSSyHDKz7Xc2vb7hwc9bWb8kATLJW89U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ltCPGgXexeaskdCZL1injktHYjqKtpP1dM5kXi+Sj4ZbiFJSVS/LDTicpnmZ2DwqG
	 eKAStgJQv7fTnaPOH4kv5JhjH2wZsoVRqrZnaM742NQPcCQKbP8sPG7mc2SLjCRHbL
	 DJBhwstjhzGBUUARDuUwti4I7gLjZ4r5Ic9KrFea1UkKc1ogfscNGKdlosVpRo9M7b
	 WyLJkxzOX3Mi4A9xfoSm6KNy/M0/4Q4e/FJ01nVeci8xXHiRJcoRLls2bO1W8mzL9v
	 sGHOEc9sdqN6pdIjshlX9Ak50rBZ90jPM1FYwq6VfO+As/egBoYHS3uvMUUB/eEQJ6
	 DIqrvhLgnq/xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2194BC04FFE;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Apr 2024 12:46:57 +0200
Subject: [PATCH v5 5/8] net: Remove ctl_table sentinel elements from
 several networking subsystems
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-jag-sysctl_remset_net-v5-5-e3b12f6111a6@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7509;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ECJVmDZTABLmCLI3IvBjvSf32Movt48DJVWRJRYYOH8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYrhiql7S6kKE2G3ICFDQaZ+9LtVfFtRHW7/
 MzEzHLiYiTX2IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmK4YqAAoJELqXzVK3
 lkFPPdoL/3i4qlgimmYoLLp1AnkLLP+/jPZbcfd6GZ7UUVxajap9ogymYWg07/JwMTzzaI4V2uh
 j3VU030STUYTo0rzOB9GhTXr0P/PqShDcdAfkdqBdb9nZ0lcK+PyK+K0ESThoLlQulXES2zVrYU
 ew+w5Q0MThpdIQIshSG0xFRtddjLZLtjg6WDL8yrLz/SoMAWRpkiIDAKseXRl8nBr/77k+aeBOV
 69Zh/CFTtTUFElaVG3ZGHW6Qco39IfYXuTJC6EV6zT4966mHxFSRqcKhAP3RZOKbDaa1W6I2wOd
 RL0YL/XAXgaDbs3RAXKAqVJozp8DNE1dj3HnwRA69vlwNA4w/shzjiv6Da+dXsinbYoka7aiOYW
 /7Y4GGqRhp9fT+wfaHJt1xz0mCSqAWv4WUhHhjQ1MvLwDPB6HUbO/ebX4iH5C0S1JU9k3jXHcTS
 E+7oVDxMrb7KBuM0PXRxCFJ8hWGM6wVluyfRZRVn42vXF6LtpFxHD30V/fyC4SAksNxhb3/nkM6
 GI=
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

To avoid lots of small commits, this commit brings together network
changes from (as they appear in MAINTAINERS) LLC, MPTCP, NETROM NETWORK
LAYER, PHONET PROTOCOL, ROSE NETWORK LAYER, RXRPC SOCKETS, SCTP
PROTOCOL, SHARED MEMORY COMMUNICATIONS (SMC), TIPC NETWORK LAYER and
NETWORKING [IPSEC]

* Remove sentinel element from ctl_table structs.
* Replace empty array registration with the register_net_sysctl_sz call
  in llc_sysctl_init
* Replace the for loop stop condition that tests for procname == NULL
  with one that depends on array size in sctp_sysctl_net_register
* Remove instances where an array element is zeroed out to make it look
  like a sentinel in xfrm_sysctl_init. This is not longer needed and is
  safe after commit c899710fe7f9 ("networking: Update to
  register_net_sysctl_sz") added the array size to the ctl_table
  registration
* Use a table_size variable to keep the value of ARRAY_SIZE

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/llc/sysctl_net_llc.c       |  8 ++------
 net/mptcp/ctrl.c               |  1 -
 net/netrom/sysctl_net_netrom.c |  1 -
 net/phonet/sysctl.c            |  1 -
 net/rose/sysctl_net_rose.c     |  1 -
 net/rxrpc/sysctl.c             |  1 -
 net/sctp/sysctl.c              | 10 +++-------
 net/smc/smc_sysctl.c           |  1 -
 net/tipc/sysctl.c              |  1 -
 net/xfrm/xfrm_sysctl.c         |  5 +----
 10 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
index 8443a6d841b0..72e101135f8c 100644
--- a/net/llc/sysctl_net_llc.c
+++ b/net/llc/sysctl_net_llc.c
@@ -44,11 +44,6 @@ static struct ctl_table llc2_timeout_table[] = {
 		.mode		= 0644,
 		.proc_handler   = proc_dointvec_jiffies,
 	},
-	{ },
-};
-
-static struct ctl_table llc_station_table[] = {
-	{ },
 };
 
 static struct ctl_table_header *llc2_timeout_header;
@@ -56,8 +51,9 @@ static struct ctl_table_header *llc_station_header;
 
 int __init llc_sysctl_init(void)
 {
+	struct ctl_table empty[1] = {};
 	llc2_timeout_header = register_net_sysctl(&init_net, "net/llc/llc2/timeout", llc2_timeout_table);
-	llc_station_header = register_net_sysctl(&init_net, "net/llc/station", llc_station_table);
+	llc_station_header = register_net_sysctl_sz(&init_net, "net/llc/station", empty, 0);
 
 	if (!llc2_timeout_header || !llc_station_header) {
 		llc_sysctl_exit();
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 13fe0748dde8..8bf7c26a0878 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -156,7 +156,6 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dointvec_jiffies,
 	},
-	{}
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
diff --git a/net/netrom/sysctl_net_netrom.c b/net/netrom/sysctl_net_netrom.c
index 79fb2d3f477b..7dc0fa628f2e 100644
--- a/net/netrom/sysctl_net_netrom.c
+++ b/net/netrom/sysctl_net_netrom.c
@@ -140,7 +140,6 @@ static struct ctl_table nr_table[] = {
 		.extra1		= &min_reset,
 		.extra2		= &max_reset
 	},
-	{ }
 };
 
 int __init nr_register_sysctl(void)
diff --git a/net/phonet/sysctl.c b/net/phonet/sysctl.c
index 0d0bf41381c2..82fc22467a09 100644
--- a/net/phonet/sysctl.c
+++ b/net/phonet/sysctl.c
@@ -81,7 +81,6 @@ static struct ctl_table phonet_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_local_port_range,
 	},
-	{ }
 };
 
 int __init phonet_sysctl_init(void)
diff --git a/net/rose/sysctl_net_rose.c b/net/rose/sysctl_net_rose.c
index d391d7758f52..d801315b7083 100644
--- a/net/rose/sysctl_net_rose.c
+++ b/net/rose/sysctl_net_rose.c
@@ -112,7 +112,6 @@ static struct ctl_table rose_table[] = {
 		.extra1		= &min_window,
 		.extra2		= &max_window
 	},
-	{ }
 };
 
 void __init rose_register_sysctl(void)
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index c9bedd0e2d86..9bf9a1f6e4cb 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -127,7 +127,6 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 		.extra1		= (void *)SYSCTL_ONE,
 		.extra2		= (void *)&four,
 	},
-	{ }
 };
 
 int __init rxrpc_sysctl_init(void)
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index f65d6f92afcb..c00087e01351 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -80,8 +80,6 @@ static struct ctl_table sctp_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-
-	{ /* sentinel */ }
 };
 
 /* The following index defines are used in sctp_sysctl_net_register().
@@ -384,8 +382,6 @@ static struct ctl_table sctp_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &pf_expose_max,
 	},
-
-	{ /* sentinel */ }
 };
 
 static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
@@ -597,6 +593,7 @@ static int proc_sctp_do_probe_interval(struct ctl_table *ctl, int write,
 
 int sctp_sysctl_net_register(struct net *net)
 {
+	size_t table_size = ARRAY_SIZE(sctp_net_table);
 	struct ctl_table *table;
 	int i;
 
@@ -604,7 +601,7 @@ int sctp_sysctl_net_register(struct net *net)
 	if (!table)
 		return -ENOMEM;
 
-	for (i = 0; table[i].data; i++)
+	for (i = 0; i < table_size; i++)
 		table[i].data += (char *)(&net->sctp) - (char *)&init_net.sctp;
 
 	table[SCTP_RTO_MIN_IDX].extra2 = &net->sctp.rto_max;
@@ -613,8 +610,7 @@ int sctp_sysctl_net_register(struct net *net)
 	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
 
 	net->sctp.sysctl_header = register_net_sysctl_sz(net, "net/sctp",
-							 table,
-							 ARRAY_SIZE(sctp_net_table));
+							 table, table_size);
 	if (net->sctp.sysctl_header == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index a5946d1b9d60..bd0b7e2f8824 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -90,7 +90,6 @@ static struct ctl_table smc_table[] = {
 		.extra1		= &conns_per_lgr_min,
 		.extra2		= &conns_per_lgr_max,
 	},
-	{  }
 };
 
 int __net_init smc_sysctl_net_init(struct net *net)
diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index 9fb65c988f7f..30d2e06e3d8c 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -91,7 +91,6 @@ static struct ctl_table tipc_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
-	{}
 };
 
 int tipc_register_sysctl(void)
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 7fdeafc838a7..b0f542805e6e 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -38,7 +38,6 @@ static struct ctl_table xfrm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-	{}
 };
 
 int __net_init xfrm_sysctl_init(struct net *net)
@@ -57,10 +56,8 @@ int __net_init xfrm_sysctl_init(struct net *net)
 	table[3].data = &net->xfrm.sysctl_acq_expires;
 
 	/* Don't export sysctls to unprivileged users */
-	if (net->user_ns != &init_user_ns) {
-		table[0].procname = NULL;
+	if (net->user_ns != &init_user_ns)
 		table_size = 0;
-	}
 
 	net->xfrm.sysctl_hdr = register_net_sysctl_sz(net, "net/core", table,
 						      table_size);

-- 
2.43.0



