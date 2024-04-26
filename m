Return-Path: <linux-sctp+bounces-106-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7788B359D
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B3D1C2172D
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F3145325;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8JiRZCa"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35752143C4D;
	Fri, 26 Apr 2024 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128431; cv=none; b=dwRN8sHXMEd5RODT3RADrC6EEcOkhE1p5Bis8lt/dwuQiSrqZHJjx0p/mo0uURorPv0aNXEKPiWzYMS0wvxp1Ukw6oZzHPPeKG99UKWhOq9TVyZDLl9zperIeyL+4JR09fDur+7cPEqpIGx+mm6MOu5hJFSrNV9UcP50/a4Raa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128431; c=relaxed/simple;
	bh=YZ6DEJBVvljVIbhNU6e6jwmBQyGXRRuf7Jp8FhA0VRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIamcDFcrslPr4+iW6/71K4tc4r8kxacmB/OteC/PYwZSSFOrNukXDz8FyMuJfubjlRzjhZqpmAfvXftv/CCvdonD85h8y10bdoaSHun6uBvunShICVhN0YnZzJF/aQv1bT36X7Pk995YBcHQMb7aO6eArxYXyMveL8h2TOYMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8JiRZCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBF10C4AF07;
	Fri, 26 Apr 2024 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128430;
	bh=YZ6DEJBVvljVIbhNU6e6jwmBQyGXRRuf7Jp8FhA0VRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T8JiRZCa4arq/VkQcgTiBvoe/Spc0SWBJnylxt8VtpSTnb2gJng8rRiToXnF7QSuF
	 PbgvJO3BFs+9NxpzBtHj+k8IXw7XoBlbFeV9CsU1mdqQeimyPt3lrwumvOSaofJSaJ
	 59rVk3/EwhPw8UFsjRI6jh5GwbphzqN6dEkkFVqmtZWQdVrr97VJSStNGf8FMuwKbP
	 eCUegbDYk9eZpy/SCAd8MG4WSJD/S1a87f5AyeNzB6SSwY56YLxmMohjxIF9XjFZHF
	 bvhqb2hmLgoVSCFhoJxcoh+tN/ldNVAZvZRMmNsuiYkMbzQWNf1wSV+fCAg0U1ocgY
	 amFR/fM0AEgaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2AC4345F;
	Fri, 26 Apr 2024 10:47:10 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Apr 2024 12:46:53 +0200
Subject: [PATCH v5 1/8] net: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-jag-sysctl_remset_net-v5-1-e3b12f6111a6@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8013;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=iqBR4LN8wpuw1ds7vI8wqz00riFw9zUncKTSa21CztI=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYrhihA6lMt+IAZ1Mm8dT7Ou8OAph0dvGtFh
 pJex2IuQsax+IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmK4YoAAoJELqXzVK3
 lkFP7wIMAJa8lbxTgRDJ6jIF2RLjX7z5smkai666wiltJ9MXTnHT75POTUCiiMiBsUuJfp4KJWh
 vTC7HR7qN5kfB1B/XiGzBT8VN/2YOrMZVWgGz3OAV/FNBrTxGfYoMM8/jXsizIQE+EWiYNiiZmi
 zmq+cCCls+eKCeHCO+MdYMJZtq3ZpYtoF8HlFwJJIrhtv37yunQjG/VqNiTZrGuEfVmXt+p0McG
 t6lp7g5wBKED690nQXBMcuTz9SwQyXSFY5ZujN3tkeXkWi3rxzeokVIoCBBrHwS3WAk8NYb+xAo
 zD2fzVCt9HlDTFeTC18v0ULtC96d1JXKsvlHBw+BWZ8ncvKunAKZRwXNhtZ3NesVp6jdgt7G1EH
 0As94n/KLfgoREwqop7/pGTMupRDi5UXyHE0UsyOHcBkA3fN0eoFvXVsBMLPkisan4HOD6Zpgg+
 XEakBqHw5rWn2OKDt2R85wWwLhKFV/o255lEU7PLhSr6rFe17+MuOJUj3e/JsKg/9Mq4lI4maS5
 Yc=
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
  sentinel) in neigh_sysctl_register and lowpan_frags_ns_sysctl_register
  This is not longer needed and is safe after commit c899710fe7f9
  ("networking: Update to register_net_sysctl_sz") added the array size
  to the ctl_table registration.
* Replace the for loop stop condition in sysctl_core_net_init that tests
  for procname == NULL with one that depends on array size
* Removed the "-1" in mpls_net_init that adjusted for having an extra
  empty element when looping over ctl_table arrays
* Use a table_size variable to keep the value of ARRAY_SIZE

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/core/neighbour.c                |  5 +----
 net/core/sysctl_net_core.c          | 12 +++++-------
 net/dccp/sysctl.c                   |  2 --
 net/ieee802154/6lowpan/reassembly.c |  6 +-----
 net/mpls/af_mpls.c                  | 12 ++++++------
 net/unix/sysctl_net_unix.c          |  1 -
 6 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3..b0327402b3e6 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3728,7 +3728,7 @@ static int neigh_proc_base_reachable_time(struct ctl_table *ctl, int write,
 
 static struct neigh_sysctl_table {
 	struct ctl_table_header *sysctl_header;
-	struct ctl_table neigh_vars[NEIGH_VAR_MAX + 1];
+	struct ctl_table neigh_vars[NEIGH_VAR_MAX];
 } neigh_sysctl_template __read_mostly = {
 	.neigh_vars = {
 		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_PROBES, "mcast_solicit"),
@@ -3779,7 +3779,6 @@ static struct neigh_sysctl_table {
 			.extra2		= SYSCTL_INT_MAX,
 			.proc_handler	= proc_dointvec_minmax,
 		},
-		{},
 	},
 };
 
@@ -3807,8 +3806,6 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 	if (dev) {
 		dev_name_source = dev->name;
 		/* Terminate the table early */
-		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
-		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
 		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS + 1;
 	} else {
 		struct neigh_table *tbl = p->tbl;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 6973dda3abda..a84690b13bb9 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -660,7 +660,6 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
-	{ }
 };
 
 static struct ctl_table netns_core_table[] = {
@@ -697,7 +696,6 @@ static struct ctl_table netns_core_table[] = {
 		.extra2		= SYSCTL_ONE,
 		.proc_handler	= proc_dou8vec_minmax,
 	},
-	{ }
 };
 
 static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
@@ -715,7 +713,8 @@ __setup("fb_tunnels=", fb_tunnels_only_for_init_net_sysctl_setup);
 
 static __net_init int sysctl_core_net_init(struct net *net)
 {
-	struct ctl_table *tbl, *tmp;
+	size_t table_size = ARRAY_SIZE(netns_core_table);
+	struct ctl_table *tbl;
 
 	tbl = netns_core_table;
 	if (!net_eq(net, &init_net)) {
@@ -723,12 +722,11 @@ static __net_init int sysctl_core_net_init(struct net *net)
 		if (tbl == NULL)
 			goto err_dup;
 
-		for (tmp = tbl; tmp->procname; tmp++)
-			tmp->data += (char *)net - (char *)&init_net;
+		for (int i = 0; i < table_size; ++i)
+			(tbl + i)->data += (char *)net - (char *)&init_net;
 	}
 
-	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl,
-						      ARRAY_SIZE(netns_core_table));
+	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl, table_size);
 	if (net->core.sysctl_hdr == NULL)
 		goto err_reg;
 
diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index ee8d4f5afa72..3fc474d6e57d 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -90,8 +90,6 @@ static struct ctl_table dccp_default_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_ms_jiffies,
 	},
-
-	{ }
 };
 
 static struct ctl_table_header *dccp_table_header;
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 6dd960ec558c..09b18ee6df00 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -338,7 +338,6 @@ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 
 /* secret interval has been deprecated */
@@ -351,7 +350,6 @@ static struct ctl_table lowpan_frags_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ }
 };
 
 static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
@@ -370,10 +368,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 			goto err_alloc;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns) {
-			table[0].procname = NULL;
+		if (net->user_ns != &init_user_ns)
 			table_size = 0;
-		}
 	}
 
 	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 6dab883a08dd..ecc849678e7b 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1393,13 +1393,13 @@ static const struct ctl_table mpls_dev_table[] = {
 		.proc_handler	= mpls_conf_proc,
 		.data		= MPLS_PERDEV_SYSCTL_OFFSET(input_enabled),
 	},
-	{ }
 };
 
 static int mpls_dev_sysctl_register(struct net_device *dev,
 				    struct mpls_dev *mdev)
 {
 	char path[sizeof("net/mpls/conf/") + IFNAMSIZ];
+	size_t table_size = ARRAY_SIZE(mpls_dev_table);
 	struct net *net = dev_net(dev);
 	struct ctl_table *table;
 	int i;
@@ -1411,7 +1411,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 	/* Table data contains only offsets relative to the base of
 	 * the mdev at this point, so make them absolute.
 	 */
-	for (i = 0; i < ARRAY_SIZE(mpls_dev_table); i++) {
+	for (i = 0; i < table_size; i++) {
 		table[i].data = (char *)mdev + (uintptr_t)table[i].data;
 		table[i].extra1 = mdev;
 		table[i].extra2 = net;
@@ -1419,8 +1419,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
-	mdev->sysctl = register_net_sysctl_sz(net, path, table,
-					      ARRAY_SIZE(mpls_dev_table));
+	mdev->sysctl = register_net_sysctl_sz(net, path, table, table_size);
 	if (!mdev->sysctl)
 		goto free;
 
@@ -2674,6 +2673,7 @@ static const struct ctl_table mpls_table[] = {
 
 static int mpls_net_init(struct net *net)
 {
+	size_t table_size = ARRAY_SIZE(mpls_table);
 	struct ctl_table *table;
 	int i;
 
@@ -2689,11 +2689,11 @@ static int mpls_net_init(struct net *net)
 	/* Table data contains only offsets relative to the base of
 	 * the mdev at this point, so make them absolute.
 	 */
-	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
+	for (i = 0; i < table_size; i++)
 		table[i].data = (char *)net + (uintptr_t)table[i].data;
 
 	net->mpls.ctl = register_net_sysctl_sz(net, "net/mpls", table,
-					       ARRAY_SIZE(mpls_table));
+					       table_size);
 	if (net->mpls.ctl == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 3e84b31c355a..ae45d4cfac39 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -19,7 +19,6 @@ static struct ctl_table unix_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec
 	},
-	{ }
 };
 
 int __net_init unix_sysctl_register(struct net *net)

-- 
2.43.0



