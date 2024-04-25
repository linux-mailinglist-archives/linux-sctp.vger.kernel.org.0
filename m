Return-Path: <linux-sctp+bounces-96-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301B8B212C
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EBB1C21AAA
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49312D1EC;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovPYDCpu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DB12C477;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046620; cv=none; b=jyUtlCihSEVmRff3BkKvACGaQ4XO/boGP7NgtoA18vobCEw1Q0W8IOwR9pKQe7IUYmWf/EVpSWrxlVQf7skqKmu4lVGEzGSI0BxHG09ctVeBqv7vIPTnNgJVKEwWDV1CEfiFBxx2J5b0pP7Sun2oJBYyuF7jtR15EBKCnkgnlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046620; c=relaxed/simple;
	bh=wI15hI2kAJDu/Q8ruVpgWztbx7Cn9f+WAAD5UfCnh8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1tsG+ev6sMRw4QoU/FvOxc2g6mloksZlWk5fMjayYrJm/pUg1Ix8lezUPWAwkMASZ4rbUWpIhfTwkz20WvXQ73Gs0IwJBJl6ak0OReDuNFiECszK+L3MCyCYgX4Ia3fEG/sj1E2/leKSGJHmRN2HyK8833Z/s25/s/YX6GiNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovPYDCpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E04B9C4AF11;
	Thu, 25 Apr 2024 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714046619;
	bh=wI15hI2kAJDu/Q8ruVpgWztbx7Cn9f+WAAD5UfCnh8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ovPYDCpug86AlKoYJj+lQUZskX0b4K1m7U0vLPCM47gOSJHaGEb+40hGHry2kebAT
	 iqcSPlDoyBPmAnurqi2dMR/nBNr/BFqhqP3OmF5XAj7zYRe9td0zdSSEbTpI9wMuGY
	 CgRgeX77JrMYUkoJZfeKyURMWshscy4EDj2M+9/nMYrkP/wZ25RhgjxX+etd+S6VDJ
	 VBxj3C+vXWCcia8BaPNCwz6jkR3pkmnlKUZ5T/U9ACaF6qBYMLdcQNVmnmorSEKUE3
	 uEekD9iqzHmM+oSnKafCfKaEFF3PfEeBaM2zpA1PNtMKIiOh327IIgn6ZFA3+sfXan
	 Q97mxLrHaJnIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE565C10F15;
	Thu, 25 Apr 2024 12:03:39 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 25 Apr 2024 14:03:02 +0200
Subject: [PATCH v4 4/8] net: sunrpc: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-jag-sysctl_remset_net-v4-4-9e82f985777d@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=+biVqN1iqVbz7GiRtsWHsBFe0+suBXyB5W6axoxTyHM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYqRpbequ4NIsR/bxBT9dcxCpjHDxrSg54TL
 /74GgP1BCiVUYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmKkaWAAoJELqXzVK3
 lkFPOvUL/0ZMKS8MWwEessfditRQKjZI7CmCw6ZKhzKcfNwobR9a7D3mGQ7E9g/N+4URRUeAN85
 NjvYeJzjm/IDNmz1uSveJah3JzmadzN5LsVLVB3aJWNF/NCGUC0LkZxFabVilJoNddvwC4JZMzq
 m6kd6onfN5277YDNAYCpuULoS7+JYIDejauYWpqMDB1xXMrW/rdaSzG13SOCuOGyPhOd1YXOKIo
 JEuJZw3o0RPyxSrPMtLkpFeaYuh1OFyRDDPu8MV8N6tClVZdJ0VWm2whUC3zlYp0szjIYYqlkHR
 +alR1hH8QcO1Xmc5O8aPRyxpwMm5DbEnudm/xix2uqBt9AcajBjDceQnvMkhqd0wNPGVAcgSybg
 RNtO2TFs12WEcKv1c1nVur0vBXM/e1hyu1SH9aOwscmGDcdPKy4F6Pqv1cdcmx08jYPmX38qc45
 RmCUfzKFi7evqOkP3Ynnau6Lob8IqHjcfY0gySkSk3Y92jR68fHX1rR4CS8fiOVNyDWMbn+P2n7
 /Y=
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



