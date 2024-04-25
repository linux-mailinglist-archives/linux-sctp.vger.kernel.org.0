Return-Path: <linux-sctp+bounces-98-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B176E8B2110
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 14:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58E01C22550
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 12:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCBC12DD88;
	Thu, 25 Apr 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBAzO72Q"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6F12C488;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046620; cv=none; b=kiSwKMZ99PDMjTmgqqjyFYdi3AK6fucGcCqlRbl7Nygl1WnY3zsP4tkN7EugGrFKe8XiBOD0Fpu9+tbA8BtWHDpJJBlmGJffsuSoJfsBkD4VR3vis5BfSyv4T8IGeCykGaQZWvhnwbYJ1x17I8lk2RCT/Th8ToSF20yP9jgBux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046620; c=relaxed/simple;
	bh=MLLgeQP7IMlxSSyHDKz7Xc2vb7hwc9bWb8kATLJW89U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIuRLeiKkoNqahvAwyj23O70eZim2JJbWUgadrlnNDZiYYUOhGyGGBM5WFK7z+NX8tZOxB0qNPP0JxUfk/GAKAHK1bgdGMcfqPawfhOyOoZMVcJAYd0xx2DJT6cOBxmTDnliNlGGc2wUaLVqxAfpqhKAeO7s+Y/FsonQjNbdXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBAzO72Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00EF7C4AF52;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714046620;
	bh=MLLgeQP7IMlxSSyHDKz7Xc2vb7hwc9bWb8kATLJW89U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EBAzO72QqwNcZdyGKB1wE38LFdw7MTZNWQlFc2UEAhy/nUSfnpLFeGpWtsPeCE/0S
	 x71eImGQak+WqyC09gZdSnJWdlFJYm1T4IpYvbtcOHdmcovOFHuP8ND40r3Juace/v
	 2qQe0Ah8QSZzSBDSPem/dwFGp6OtXLX5xTmQMPZxhOKjtTxlG9sSUUQ3mj7jTmH88n
	 eVx64JF6QiLAicl0Q4SjlSZFk+xFTFz9gpRmokPcNBqTJ8zxXa2o6kBa73v43e6PCP
	 Q6nneY8NsWe509a9mL956trAcBTFIdOfoxQzBe0eJZQdE0jBHoQbAHTvM9RfHnpRVy
	 0SPsWzYtVZ+Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8782C19F4F;
	Thu, 25 Apr 2024 12:03:39 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 25 Apr 2024 14:03:03 +0200
Subject: [PATCH v4 5/8] net: Remove ctl_table sentinel elements from
 several networking subsystems
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-jag-sysctl_remset_net-v4-5-9e82f985777d@samsung.com>
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
In-Reply-To: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
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
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYqRpfWsURjRi/6gTs5qfncwRROGUCpsBdEJ
 ZU24y0JOgy/uYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmKkaXAAoJELqXzVK3
 lkFPz1oL/iWbCeAmgciRXvMP50TVbCzQGMrBMN7BNlGcu/cunW/FJCLY4Lp+NGDBD3KjNznOdoN
 nh2ygkmGfpAVxQ8yd4oDH+gexrkn+RXJ41Lg01lfSI1cvsAkyN1pgbYhH+TWztEhy6figVpp/nt
 BpngMNDQU/VnFBQgacApZGw3qYj14jRuitEQiz1F5y1rvqLEfNwIqzWra76HHJ4XhLWNEu8sQbG
 Md0Sx+32E6gRI5Jq6AOqR85XUcnxmDFahW0c0xKjpcMNW7rvh8cLuw10r7Zr3p+rxVZSGgsMKi+
 NW1mJN562gydVglaYsnot8XISVOlFsNz/iyWReC27N4HY92bXT4GCOdvXoLcmwS9FkCPv+O234y
 /5acYH3mmuYCB6Dm26y6pe1PSa+q9RT4y952Pu2o2mPS/2C/8CXKi4zkEE/BkRA/cV/KN5PAfBg
 x1KzAiYqshxJbIUzyuQQ0Cl80XZGHDcCa+mbP2H3ZsK3UobGjYzdXI8j7Xs+EKSWcat873j4Ql5
 kM=
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



