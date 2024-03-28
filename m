Return-Path: <linux-sctp+bounces-56-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702E890381
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A044DB22B32
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF0131753;
	Thu, 28 Mar 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwoB0QZV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97F1304BF;
	Thu, 28 Mar 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640440; cv=none; b=f5gCWPre52hlj4LMzMRpihsfNSy/xEB+q6l5mQ6p2OJBVcYn8YSqY+t7cfo/jU0oEOPwQZDgNCekBpI9+CfLBvO5SoTxHWnXQ9hGDZS9AcOeNpaqLQyjeSM1lyfhl0GK/8sjuQPYB4fMNAYx8SaZakKRDLvUR2zQISki9tbwU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640440; c=relaxed/simple;
	bh=nUlKXcXbpiwl4TjgmWHkIBUZInnNECY1Y38Or1u8KAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hDFN1VhJuaRMYan8ZIZ2D/MSxvFeiUKoNXXK01X/zjrEpwo+sUam4ZiHAK4F3A3G3nnthY6oCsMtytgZ1NX+yxkji19ZRPK+UxgFtqXQqxxlFgcMo1e7mEBuk0U4v4uzi6xOOPLzJztbg0HGaxiQ+6mH9e7MLdWfoKQiAhbWRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwoB0QZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6DD8C3277D;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640439;
	bh=nUlKXcXbpiwl4TjgmWHkIBUZInnNECY1Y38Or1u8KAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nwoB0QZVzndis7CIHjOjgiOMQ0rBSAbcs/dBPN3eXrR9+dj68TxMLnyT9OicpOwCS
	 D8J4ihPNkKNi2xLgLv6Xbf1D3Ab07/3rhSayK/+hMe0uXFHk7rP3EwHSeYkv0Tlczh
	 4Z5H3CLrnTqoi+DAw3PVtnWFG6TPcnE8pdY4XO25hoDBaidK7Bv2z7z0NkoclD7d+u
	 wupshjNEp+vup4NMdIq1TqFm5YocmObuT+0SHqLD6fufKcH4tHUOWID1BofpoVzFSz
	 r2+tWVj2gMt6jcXwYQ5jvWUNi0KzFblQh9lN8vRHfe/bje5R0dqIcO3eeFX6/o3BkR
	 oSSFy+625lEfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB2C54E67;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:40:05 +0100
Subject: [PATCH v2 4/4] ax.25: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remset_net-v2-4-52c9fad9a1af@samsung.com>
References: <20240328-jag-sysctl_remset_net-v2-0-52c9fad9a1af@samsung.com>
In-Reply-To: <20240328-jag-sysctl_remset_net-v2-0-52c9fad9a1af@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=8B/rrWAL/Wpety1Z6TfAfT8YMsH+ZTrcc2Fe5CJkM6Q=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFj3UWFMJwECpzMsKOabEHFZ29RUM3Lbkr1
 /uDHBI3u+wM6IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBY91AAoJELqXzVK3
 lkFPxUEL/R/Sp5cRTbTCRDejAzJFEfyWjCXt59NTj6GRoOzv6BqOQTUEgIe4qnlu3vvL3yhgl+F
 tyoQn8JAI5uQEcMzt1QuuaMx9u6qR/ar3Ghya5nYFICCPkeJhZs9dJuJ5nGByrsj8xNl6YIrnf3
 WoPtg1nYm6EKFljogLHRRkvXFybbFNkim3DUIuTNXLOeATFcI7GTWLUqz/pxI23k+ME7VuwikEh
 FU3SdZNXOhrM7WgN9TsQjZZBHmYd2fuJ3w3Seut5m4oLliJSW2SQ9vadfExyGai2tLDv0Ez7n/9
 w0z+nxH7ARBPeLJ9gn7WzG3NOHeGQxiJXJUo+xvxSJWuE48bkhBjQXEUxretS+xVh5CQ7dtYaM+
 mTZhjJUyqjIjJF1XXAZEgRApfuW3gS6oTTgQiRs404iWNxpTXUlnyz62wrhOGTs65xC0WpXfTtZ
 4xxHauzePSibHy4AEKRf5i2gsSWP8y7s6PZfzt3QkicmxXlwhR3Vs9DstbypRLUMVTnFRydkHi6
 Io=
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

When we remove the sentinel from ax25_param_table a buffer overflow
shows its ugly head. The sentinel's data element used to be changed when
CONFIG_AX25_DAMA_SLAVE was not defined. This did not have any adverse
effects as we still stopped on the sentinel because of its null
procname. But now that we do not have the sentinel element, we are
careful to check ax25_param_table's size.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ax25/sysctl_net_ax25.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index db66e11e7fe8..e55be8817a1e 100644
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
@@ -155,7 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 	if (!table)
 		return -ENOMEM;
 
-	for (k = 0; k < AX25_MAX_VALUES; k++)
+	for (k = 0; k < AX25_MAX_VALUES && k < ARRAY_SIZE(ax25_param_table); k++)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);

-- 
2.43.0



