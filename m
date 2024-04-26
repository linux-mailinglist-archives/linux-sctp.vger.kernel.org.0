Return-Path: <linux-sctp+bounces-107-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E68B35B4
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 12:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579B51F224E2
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E3145B21;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L81ooAJc"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB3144D26;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128431; cv=none; b=qlze/LuArT209EuyEsDafyiUGl3mG915TtyJIH5k27EALR1b/p6Y2wfcpldZv4qtsXSCY1gYHsjBpWiCW3l3JM740xGx6vyljjkMHhtf4tTlnXFDTiQik24D+KtDPmGkiIhpr+sUCcU9OLZa4l9fWYil+2fBqgiOnuXYUhug+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128431; c=relaxed/simple;
	bh=OaWenH2ecs+TvT40FvZfeCOsMkIprLb3i+uRB7TGjxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozx9oLacVRhFfqgJU2wLnwTGdIOxuha3tUtRstRDlZ4V2HnK/MNQlU82+DhsANF248gSduMAnP3tNaRqI+7uWaOED++HUzxXsemtdXlRTDK0cF26e3svYzhaQCxtdX3r8Rvm3Z3TIG3Axcfc33B/iTAIChDhOJb2QtjX7sP8eS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L81ooAJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E519EC4AF13;
	Fri, 26 Apr 2024 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128430;
	bh=OaWenH2ecs+TvT40FvZfeCOsMkIprLb3i+uRB7TGjxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L81ooAJczZ6l+I9P1nO9tRSraH/Xl/LHT8jqPr1kG8Ntk4NV3vuKefx6pZVi8hpxa
	 pGDUyEo94r5a/iSiuHrNt1fwPX37y9BKPjDx9l4Q62s36axvKzzS6kH2WEuaNt38Sm
	 DbILGltKVRBdNaMtPYhif6Bbfj4u0mlrWmAptnyF2c8WnMKBSKseBEIpXCRB49RiuZ
	 yuipi7ezjjPh5ITfMYNVRvH++qoVsHiwSg1hX1m1TWNN8788OBPL9ZoJ5mBGtnoKlV
	 wBLOtI3E0kTXhisG012vUs7MXhKplbpxwZJC6yS59Pebl+9R/MMkDJCxnWRVVYyJNr
	 7kgFZm27u2Mdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2365C04FFE;
	Fri, 26 Apr 2024 10:47:10 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Apr 2024 12:46:55 +0200
Subject: [PATCH v5 3/8] net: rds: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-jag-sysctl_remset_net-v5-3-e3b12f6111a6@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Yhw5Yxzxk2wGoyQtTfioNjf4XA/aQJR8HoqakSkFmW8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYrhilhsDLKMciOakZ2hp+OF9Gcz8PYw79X5
 2enJ+JxfEEqeIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmK4YpAAoJELqXzVK3
 lkFPkfwL/Ai+Yo+GmKvgTo+Umr4alxLieJctsBpAOAdVaHgF75wTSgdW3xdYq69M3kxafgvUUmH
 FwnSiNd/Aro4onzDt8NlrzX3kpInHsv3kXiDRDDNDrC4Vc+aS2Ne8vTuKy4U5o/CX9j+LAff7qH
 H3yeRFXZikV04jEmRG8i6fo9p0gKrBEhpANzcb2DjtzXzZ3XH58k9fEYXmnBYtTFv5CLOF4QQV5
 VMD3WmZU5ydWNVnLZmAfsfqs+gAUvJBwoTjgn9qoeP64T1FSMYOIyk93QUWIFwc79qiNNMot677
 MANECcoUwPtZqVGLDom62wBNi+i98/TYbxKJD4mvEYzXKZ3ResSvNPoRwOp3DVB6lacwExbz/xe
 iCj6kwdmEG04UFyW7P+J1rcJgHZ1Y0GdWJtoIZLtcnd2LIrFl781UKZaGUiQfTlfk1Q44S/iikk
 tlYuokWms1BEMwASp/t4FBi8LJ5b/Gnq5xlD6gn5lsGjW/cRNHQm5DFU5x9jxRl48wkyqVS/WJ5
 4M=
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
 net/rds/ib_sysctl.c | 1 -
 net/rds/sysctl.c    | 1 -
 net/rds/tcp.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index e4e41b3afce7..2af678e71e3c 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -103,7 +103,6 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 void rds_ib_sysctl_exit(void)
diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index e381bbcd9cc1..025f518a4349 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -89,7 +89,6 @@ static struct ctl_table rds_sysctl_rds_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 void rds_sysctl_exit(void)
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2dba7505b414..d8111ac83bb6 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -86,7 +86,6 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		.proc_handler   = rds_tcp_skbuf_handler,
 		.extra1		= &rds_tcp_min_rcvbuf,
 	},
-	{ }
 };
 
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc)

-- 
2.43.0



