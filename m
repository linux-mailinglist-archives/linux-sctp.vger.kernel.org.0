Return-Path: <linux-sctp+bounces-141-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3118B87DE
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DE61C22660
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3884D34;
	Wed,  1 May 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4cYy4xU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851A535B5;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714555809; cv=none; b=BnUS8MWbTaBW5oLLqdo+W1WqcOOLnJ/dIWZGldPM5qrNPROISCt/LcVbUrVz+ygzCTmd4lyUZc3yYIFrBDD8m1zw41/iacgoPFGPNuksL13yuqQhI+LkzZKl/q7BOe4jKcBX9BKLNfi1k3Iu/q/bNOTtUNRwykk7sWFTKjRYYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714555809; c=relaxed/simple;
	bh=v0M3YCkk3i8pT+R0MAJlk6prIN46v5xrc2mwK2DMRnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6lDIWBPsTOG4PtYTWNDMGVqj2o3IuD5PnCJcnut4CAo23ucYKP8V6ucLO7g6WsrEZaAP15x28DzyRTaTN1BoCZtvewkOYHvxKU0mpoxOOr5hfgwrxo8JagJtQl2eKNSWBCsTz3sPa/AFCGpsTQdxCiQ6ug5JCldkxS4ZpzIgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4cYy4xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FFA9C4DDEB;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714555809;
	bh=v0M3YCkk3i8pT+R0MAJlk6prIN46v5xrc2mwK2DMRnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j4cYy4xUD4t0qK4ckTjMAp39TVeCcQ8v6WCb9R6DgPYksWOqjNGum/D+ymVF5uBm5
	 JTevMH/7MP2yGDdb4IfEVCPWqdcTngzSWsJvDOVI8vfhJ3GxCQOg7/44ZYm5qTgZ5Q
	 iJu78MGm79Duu0CHteZxRaEjdmPqtKO5xePMGCtxv3Wrs6/8Z73Ic61NryUOXSuRzO
	 5iO21qo66wh/Ml2G59GoiRe0ReGAu5C03DXzic/O9JDp/cvBiZVb7MQqpWNmiWq3YF
	 VHeOX27FgOQaAaL8OdqJYhiRrkmipKMTRRlgc0RothSuK6g2i/qTVK5+Wj/rD9HvvV
	 04abRHWin7aSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BAEC25B74;
	Wed,  1 May 2024 09:30:09 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Wed, 01 May 2024 11:29:31 +0200
Subject: [PATCH net-next v6 7/8] appletalk: Remove the now superfluous
 sentinel elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-jag-sysctl_remset_net-v6-7-370b702b6b4a@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=7ZWigRPsHTDXgTA/blt/ZK1/GcOosAKMfp6DXoN0Jik=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYyC50rDVzv8XnEzc3bJ0EO9+fcM1DNRBCWd
 j0k2Xdf5ptmH4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmMgudAAoJELqXzVK3
 lkFP9aEL/inEPds1ohPYdMYT70TJaCCgWjQLcyspY3Lmz+Ci/F9i6n6dpMbonovT7/uRLKx4QLl
 CoRdzI3ggiqskhT3HJL+fafr3tKbFWsKgtrAykc+/wVf0bMPv0ukTLtBS0J/A7Lz8vA+mYn3+uQ
 Hgn0wIVewKhzUx+ZE/j8QqOZTCb1M7SXWvACbQY2+pLWwOR7up6/5yn/r4PTV3mFBIYEP660iEl
 7wa4wb/3Y8doZkY4h7XqEXLWPTUL7i6N4H831Vk6WkiwmEKbyslKHBPyzI2FRu00+lDDce5pGnj
 SIfh+MgbL7dL2Y8tWrXtmqqJkXXRg4cYjeUeJcT9LJF9r3dUITL0U7BBk0nEsyUffsFXzOweefP
 M1j4YIJFP0+hl3gYw77q6rr7NnaPGp4WPiMlu+jTKFfhYFqmitEg5t/F5LoaAdqPE/glC/sMCCu
 flGBnkXz2OF4POxZGiHL4eQAzOXUAMjw0wnZ4I5y4qgSS6DvsMsF3YdeQel+IMtts2vSnOsZYV8
 cQ=
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

Remove sentinel from atalk_table ctl_table array.

Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/appletalk/sysctl_net_atalk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index d945b7c0176d..7aebfe903242 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -40,7 +40,6 @@ static struct ctl_table atalk_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ },
 };
 
 static struct ctl_table_header *atalk_table_header;

-- 
2.43.0



