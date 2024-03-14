Return-Path: <linux-sctp+bounces-36-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A5687C39A
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Mar 2024 20:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7E22830B3
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Mar 2024 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4A763EA;
	Thu, 14 Mar 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRlRGpey"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747C7602C;
	Thu, 14 Mar 2024 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444059; cv=none; b=Yt1HvvLPEWuV+easdbPgpI04fPUCQv5uPueSHpNEfigqnFsMb2L/QI+q7slhqa+yPZmn+ybF23O2mh0RKANyTXGE0C/QvLMY6/CfDFOo9UwKED9wOY0y/5qu8Z9IonRRDIbU9zDftt4XHdZOqTq25iOOuirE8oZJIrff4JIYB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444059; c=relaxed/simple;
	bh=gH3b/5A7IYQsiYNt2bdQmHSGeO/sQMIwqfeaWs5xuNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6S9F+oxmVrhdmAkzXB+IIABgLRrTxF1wM9nIf6lCVle5QPgC3GeWGIKem5u2qZ34WHeGNXUEC8Kb8fBeOtnBzMSuXPLbQU5Aulo/umescAgyraYx64MqvLbW/pJ62/giA9VPGAke68gYdwsFJxC6bDyVNmKkG0cb1fDrOnxzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRlRGpey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00EA5C4166A;
	Thu, 14 Mar 2024 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710444059;
	bh=gH3b/5A7IYQsiYNt2bdQmHSGeO/sQMIwqfeaWs5xuNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZRlRGpey5qcW288aIwBTzKDt6XrvAwsgxLYc0oFUsG//OqwKLEQAQFi7Eb6tQaEoM
	 Wu0JPg+hiyy45jwe3FjQ85gNZ/sQT+cgY2WfhvGGWpBqxuHob0HTlJ5zKJFT3OhSSm
	 gWxLXua4j1BK4HMUj8jXkcbVPDZut3cziYQc4a2hlCqmdJ5iD20Q9LrXhwVOlTj5GM
	 Lh11DERA9KI3k8qkhKnyJBhIhJPxZ3sMNKs5E/T+w/g0sd/wxivDA4fElSQ6bSWp+X
	 5V9cRmc7HpHbeen6d9ByvK0xRMcNMvqfw8nDIE5tTQ/oJapjdpiNs4ceQDh11pZVOa
	 dLomDp1xJDlyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E373EC54E60;
	Thu, 14 Mar 2024 19:20:58 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 14 Mar 2024 20:20:44 +0100
Subject: [PATCH 4/4] ax.25: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-jag-sysctl_remset_net-v1-4-aa26b44d29d9@samsung.com>
References: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
In-Reply-To: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ejJiyRhNOC9Xg5jx2v5IBc5vVgg4IABN6nfDRl2m3bQ=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBl804YOT/y4oh7cSp7OlPw2zS5Tl/S3d+XSL1dZ
 qcQXL+fOt2JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZfNOGAAKCRC6l81St5ZB
 T7kQC/wK2/wTeTZeTM0MnPlpRdOOBc8cyUMgjDVKpxvMyRI8yAICvkYuT5X3I/JIAiSTlnoPRNs
 T8czt4a9El8kn3rzJrUnWqslVgijCjQNu75mhVIl5h2Hx0DeyF7xXzvxP9a7qpRBsrxGFsJOzlr
 xIV+BECnckb1ymuqG9Nx5TcTYFUef2eHx6R1NahoOJ2eaJkT8NbMr+4d+IxeEVNv1KCngJcTLhn
 j2ODJJt9OJ/W5k8gAyqvJZWLCnlIAPZIYzhOEGBu3D7BYhmVa/L2Ea74K76U054rZeBIbg4Xt5R
 IKEbNBeLmErLYVin2F8ZzAgSWEbtolh545+BB7/t6fTEkwctvzvj3d5+JqxdaTvb2lKfRReRxEJ
 h7dTo0Ikttkj4V+cjftwKAmFSNVE4NYWhCGfwn1M+onp2ZzZzdn79m3lY7nJW4z4KsIXo+z5ghP
 LzdpG1ie5IRBI09mzaVoxDs4mkjlmc8NlDUaMqjjP1vM1VYLgMKXI9Jn1NE4Y1Ws1QRok=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

When we remove the sentinel from ax25_param_table a buffer overflow
shows its ugly head. The sentinel's data element used to be changed when
CONFIG_AX25_DAMA_SLAVE was not defined. This did not have any adverse
effects as we still stopped on the sentinel because of its null
procname. But now that we do not have the sentinel element, we are
careful to check ax25_param_table's size.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ax25/sysctl_net_ax25.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index db66e11e7fe8..2ee375a6a69c 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -141,8 +141,7 @@ static const struct ctl_table ax25_param_table[] = {
 		.extra2		= &max_ds_timeout
 	},
 #endif
-
-	{ }	/* that's all, folks! */
+/* that's all, folks! */
 };
 
 int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
@@ -155,7 +154,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 	if (!table)
 		return -ENOMEM;
 
-	for (k = 0; k < AX25_MAX_VALUES; k++)
+	for (k = 0; k < AX25_MAX_VALUES && k < ARRAY_SIZE(ax25_param_table); k++)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);

-- 
2.43.0


