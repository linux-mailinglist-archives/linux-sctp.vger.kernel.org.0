Return-Path: <linux-sctp+bounces-67-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0B8A3176
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Apr 2024 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A6228286E
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Apr 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AE6147C90;
	Fri, 12 Apr 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJsHa854"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF6145FF7;
	Fri, 12 Apr 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933327; cv=none; b=pSXPm+EGl8QbPeWMobr/dUQmD/OAGlcXAW98eQH5irlqgYWOrl+nDHMoQsKs03nsbPvpJQazp+qhEMdnICSK2Tht3iWdi96SyttUL4fVrSxVGul+f3ZQqh+u6nB+6F9JT4mTVPEseEyxDHY9py0LHUsBs22fds24eCuVEOqVCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933327; c=relaxed/simple;
	bh=kabtR8KWJp1tD7U7DLovE/0TfamXboAHVXoNqhGqQ/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyisDEnUSyGg3wky6oQ3e2ab/90foMhiuokU8+UTqqQ/WRfirbmVO5JbiY2zsl9DwibNwzDW0ayrqC+Tgmu2CWivoEVCtZP5f+FcO4gyTjGzHuJ2uwWBn1xJnF6anjMQ4Jl7QjByUE1WFcnhREmKy8s2+1yD2qfZbRuU/I2XjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJsHa854; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 685E9C4AF18;
	Fri, 12 Apr 2024 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933326;
	bh=kabtR8KWJp1tD7U7DLovE/0TfamXboAHVXoNqhGqQ/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OJsHa854rZOdPPGu329O3QmWgIpDjvADmkoZUrVKVS2dTNwGs7T7HmX/8M+PYsVCa
	 Hq7BBvG+ZcqUYlzTuV8oa3YDZY7Di60ugMfVUDDztMWLDZrh3Y64ZtQmEUyQN+RV/c
	 DJoEBAHXBJzFtA+GckwBp6nC22d71YUfnj8TEo6D3YZtIYw3uTRAf5zHzEnWibrjK5
	 hvP9P0GJTRq1hbcO8GVSZzAMNtyFkWJER/c2wRonlAXpOLUaVom1f8gbKs2SqwKkgg
	 yPGx2mTbg5lfYHN+3traEX9uz87oeAv4bbnP/HqEYZjmm9D4DyVQVXF9tLSpyBU3Gs
	 Hr9PY/0Xks3Yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B936C4345F;
	Fri, 12 Apr 2024 14:48:46 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 12 Apr 2024 16:48:32 +0200
Subject: [PATCH v3 4/4] ax.25: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-jag-sysctl_remset_net-v3-4-11187d13c211@samsung.com>
References: <20240412-jag-sysctl_remset_net-v3-0-11187d13c211@samsung.com>
In-Reply-To: <20240412-jag-sysctl_remset_net-v3-0-11187d13c211@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3615;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=CsYowwLbkJaYf30UOT/yoW/0LONY7umz9p0pFyf5n0w=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYZScxgWqGgs+HWHWKs1qufcsukehfTFkxB4
 qfcLlXm7S21V4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmGUnMAAoJELqXzVK3
 lkFPyIYMAJKeHHeh4RoOTaX1NdP5ohrHbpZVGSiik49E67/0ZPgzvWovZ7wB4Imi076PjZu4bKj
 AW6SArlLiGXRpxRP8lsFLWi8JSxw7/cpw1LABPA/4GMJBEMdOuJidHVg/2HsRjoALLBpHgvp+pZ
 /xtrYavCFZ/+FRq1c4aO6NIIP/2rYJGT9vtCr4ec4V822hrgs9adA5JapsW4m0D7E8a1G72iOA5
 4aD6ApucM/2+2VmxWx3sz2eg+rkXJBOOdNjqm6UdJDdVw3qz3ZPl6odHuM5WcF+2lPxLEbSGF9c
 k86yuwPNW3t7Vdka4VYc0CdWp2tS9Flt6z00h0vuHHCz6t8jDPvIAGRrRVNIMtKXOaPxaFt7V/P
 9v/LxFQlQeLS4cAqXZtkUrbXUIe5gV5p0/EwN7393eVg16kZpbMJL31ogZ37+42SheKZa2PFu6W
 ljhF0aXKJhFf7Bt6kP53Fo8OSAj7QMj7JQitj2FIDPZhD+rd20eL9WJNB0Q+bG98xOExHQQV4t8
 Kc=
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

Avoid a buffer overflow when traversing the ctl_table by ensuring that
AX25_MAX_VALUES is the same as the size of ax25_param_table. This is
done with a BUILD_BUG_ON where ax25_param_table is defined and a
CONFIG_AX25_DAMA_SLAVE guard in the unnamed enum definition as well as
in the ax25_dev_device_up and ax25_ds_set_timer functions.

The overflow happened when the sentinel was removed from
ax25_param_table. The sentinel's data element was changed when
CONFIG_AX25_DAMA_SLAVE was undefined. This had no adverse effects as it
still stopped on the sentinel's null procname but needed to be addressed
once the sentinel was removed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/net/ax25.h         | 2 ++
 net/ax25/ax25_dev.c        | 3 +++
 net/ax25/ax25_ds_timer.c   | 4 ++++
 net/ax25/sysctl_net_ax25.c | 3 +--
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index 0d939e5aee4e..eb9cee8252c8 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -139,7 +139,9 @@ enum {
 	AX25_VALUES_N2,		/* Default N2 value */
 	AX25_VALUES_PACLEN,	/* AX.25 MTU */
 	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave, DAMA Master */
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	AX25_VALUES_DS_TIMEOUT,	/* DAMA Slave timeout */
+#endif
 	AX25_MAX_VALUES		/* THIS MUST REMAIN THE LAST ENTRY OF THIS LIST */
 };
 
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index c5462486dbca..af547e185a94 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -78,7 +78,10 @@ void ax25_dev_device_up(struct net_device *dev)
 	ax25_dev->values[AX25_VALUES_N2]        = AX25_DEF_N2;
 	ax25_dev->values[AX25_VALUES_PACLEN]	= AX25_DEF_PACLEN;
 	ax25_dev->values[AX25_VALUES_PROTOCOL]  = AX25_DEF_PROTOCOL;
+
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	ax25_dev->values[AX25_VALUES_DS_TIMEOUT]= AX25_DEF_DS_TIMEOUT;
+#endif
 
 #if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
 	ax25_ds_setup_timer(ax25_dev);
diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
index c4f8adbf8144..8f385d2a7628 100644
--- a/net/ax25/ax25_ds_timer.c
+++ b/net/ax25/ax25_ds_timer.c
@@ -49,12 +49,16 @@ void ax25_ds_del_timer(ax25_dev *ax25_dev)
 
 void ax25_ds_set_timer(ax25_dev *ax25_dev)
 {
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	if (ax25_dev == NULL)		/* paranoia */
 		return;
 
 	ax25_dev->dama.slave_timeout =
 		msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
 	mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
+#else
+	return;
+#endif
 }
 
 /*
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index db66e11e7fe8..fb9966926e90 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -141,8 +141,6 @@ static const struct ctl_table ax25_param_table[] = {
 		.extra2		= &max_ds_timeout
 	},
 #endif
-
-	{ }	/* that's all, folks! */
 };
 
 int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
@@ -155,6 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 	if (!table)
 		return -ENOMEM;
 
+	BUILD_BUG_ON(AX25_MAX_VALUES != ARRAY_SIZE(ax25_param_table));
 	for (k = 0; k < AX25_MAX_VALUES; k++)
 		table[k].data = &ax25_dev->values[k];
 

-- 
2.43.0



