Return-Path: <linux-sctp+bounces-108-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300E8B35BC
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 12:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2802851AB
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF0145FFC;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7SE+UKu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A1144D2C;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128431; cv=none; b=GIg5Rv8STdlUFtfel6uUbPegesGpiHrK8zqI2djZLhSPJ7iyi66P5JAFYNPzWS9O5IOjAeGC9i02IePobmRoq3Ex2lx+dzYYD58sbAeNvCrRv7fgizjHffHidxalgzErKDX3hn705jJHK2x873bOp/CY6/IPw9ehsJ6ZjWmYZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128431; c=relaxed/simple;
	bh=wI15hI2kAJDu/Q8ruVpgWztbx7Cn9f+WAAD5UfCnh8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVyol3iamVlHnWBUlu99JXX383lwjtiJI9pQejYudZGSg955EvCR4u8Ql9+xfxzha5vrdbBHz8kKqEQXdA+TVHl1tX0qEskZqBEKW8hf5yIMUB0+zKZdfPYnQqn6MCLttzhI8cAGLehxH5DytLdd6jKV54xk++oH5AMS7lDqcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7SE+UKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E2F8C4AF4D;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128431;
	bh=wI15hI2kAJDu/Q8ruVpgWztbx7Cn9f+WAAD5UfCnh8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z7SE+UKuBvBVKigT7/ethtVRiJF9xh2fd4LoITV+vidTViQXSYZHzuCL8mjT43cGt
	 825ooTiKSDy0aUaqOnrQut095KkuswCIveIExe3LyjGcNSThqY+Nwmdo0IHLI40CQM
	 rZ78/DvXw5nad+VJ3OV1NbiMBe09wretrkux1FJ4wxID5QuwQctZPESwoWyW038iFt
	 AhboVrfyR5o093+UFBqxC62wUNKq2KqIiX3bqBQs+6M7vAo6xESOIOhHYBUz/OPWIo
	 xX2tPRuisn6DF+A+uQU9rYXpNwI0otcf2BKwuVFpvP16QgjQtE7NzYHe1ERVQzT6Ub
	 PO41ZXi25JgsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A19C4345F;
	Fri, 26 Apr 2024 10:47:10 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Apr 2024 12:46:56 +0200
Subject: [PATCH v5 4/8] net: sunrpc: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-jag-sysctl_remset_net-v5-4-e3b12f6111a6@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=+biVqN1iqVbz7GiRtsWHsBFe0+suBXyB5W6axoxTyHM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYrhirRMJ3CpA96PxSH/s+88A5K1qjt01MiI
 OdVzv3F59SIhokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmK4YqAAoJELqXzVK3
 lkFPeBML/R1KAtXk0L7PJ+GM7bKprya/ElnHKKTyPDEWLIGgc8++pjbuN3QvnNIWMLFoNqI54cj
 +0ywDpiAdqlLoswTj97wi7irvzwwl1XP+dYMWprB1/yWOOjktGi3Mym1OIHbi0rd5f1cAQWWhAA
 p6i84g658xcvt1YsL5lx0HowrgreKrM8zxwYZexCnz9H+ql/YlGbjLcdwI0xG5ex/EzCpSsiFG0
 KWyYaIM2JNqkQGwnhouFdgC9BVT6y9qnCymEq39NOZ9HWw/gcPi54D782W04l4agToMa7xWfgfQ
 zgYImVRMwI4s2onUMK/skx2N2KymvrPyPcnaV05fAfTkG9bU/uScsKlxrot5pq1XPvL9YkH2amd
 xoNDXazHt/6w/HpmLFquSGOIJhRNZhh6ujG297cdAI4ohYRmRJtFzdAwDbvy3DCH7mM9na+JwSc
 Vf1aTrIsBxnGs5+AHrs7poKpMKu00sjzfCgVFAUGUdDfaH9P7ugQrhM/kqofI8FnTYXo7hcmhO8
 IU=
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

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/sunrpc/sysctl.c             | 1 -
 net/sunrpc/xprtrdma/svc_rdma.c  | 1 -
 net/sunrpc/xprtrdma/transport.c | 1 -
 net/sunrpc/xprtsock.c           | 1 -
 4 files changed, 4 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 93941ab12549..5f3170a1c9bb 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -160,7 +160,6 @@ static struct ctl_table debug_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_xprt,
 	},
-	{ }
 };
 
 void
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f86970733eb0..474f7a98fe9e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -209,7 +209,6 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.extra1		= &zero,
 		.extra2		= &zero,
 	},
-	{ },
 };
 
 static void svc_rdma_proc_cleanup(void)
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 29b0562d62e7..9a8ce5df83ca 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -137,7 +137,6 @@ static struct ctl_table xr_tunables_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ },
 };
 
 #endif
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bb9b747d58a1..f62f7b65455b 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -160,7 +160,6 @@ static struct ctl_table xs_tunables_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ },
 };
 
 /*

-- 
2.43.0



