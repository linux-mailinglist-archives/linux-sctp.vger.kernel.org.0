Return-Path: <linux-sctp+bounces-581-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A3ADBD1D
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Jun 2025 00:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A36718922F1
	for <lists+linux-sctp@lfdr.de>; Mon, 16 Jun 2025 22:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738521A454;
	Mon, 16 Jun 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VW2ote7x"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2111CBA;
	Mon, 16 Jun 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113918; cv=fail; b=BpC1lboo1xxNU1qQsfLb5lRSOG5aVfTbR2c1r062WxkNnXvS/UjlDkBkRqBdIicLlYgvwXug2qXKgUmaltD8/qtg9f2Zjyj5HCPsq4KggTh8hztavQB/uCI2AH5v9aBJ//o3OqedazhwI2qxVTMtj3S5rDIktdKsoHFa8apuePA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113918; c=relaxed/simple;
	bh=1I0FxOz/Lu3j5+DfNU6p26OZa6lSJVgAezyYpInRxUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY1x5THSWaHGa2vs3biSfLD1CCBVQNJtbndspIW160UhqgpjK+Wki0Vr/sxHXSwKlbp9ouHrJYb1emJ7Phz0ixl6v8ckO9aQ/a9Y/yr6TwQfIwbKIFRmeqBCSgd9EkOW5SOeiHuxalpOcryUgyC6t8OwVR8BO6I1IzXh9tnYI6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VW2ote7x; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib3sONdHhRTHmy57hA2nOO47WIvD8LSoXsSBAeAqzQUGULW+oAyAbQe/y2/hBtZlma205tNB9z/hwRw/Cf1yjJOabzoLaxuW/7CKOnmT6MUifUdJCGBSH1nfoOdchB6P3wbpGgA0CC3PTDz9DBogDcvTANv/O+LHusrfdiETUysVu+OcnTWcjEQnVR/QgC4iHquaGaFMYcuQ3XTq0jAJXP5HXq8/uelLLavRQLb523Ykkp2x3FydYjwH5XICTFyPoNscjvo1bIYoYFUiL1cfZRBzLUxDMMroWIaxFVEfC7nn9y6jl3FZIp5mtePuIEQ0oBonyvopdMqKUV157c6IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tncj5mtc7TKNUZVgU9K5603jRMuApQ0Vz0TCXVxNwDc=;
 b=QaDjBk7pVIUn28Yc29Ebf/IeUJg0kFPg69F3JOsf+w1FlhRX1pVWGJGsxq/DpesxISPJGDiNrq2EPRA90iy+A43KF/MazrElvcri3TEmK7LCxxuf6S8vzcaW6ApN0OjnAA+R6mrzKKXLfWpNyiAnEptwuCDAmY5sI/O8o1F3hxKnrfOxMp5j7LoQKaQeJZUqPWcPZ09tqbexH6nrrTeaIYOzuKp3W+1Ut9uLAeXubBd0xJp3q3eA6xtRLF7oGLUZaU4BfN+YsemBO5FGn8Swv2khoYln6GGxw0yBjd+8CfEXvM4/iqca/OXxmlV6c0o1/s38uixCa/Jke504pKnE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tncj5mtc7TKNUZVgU9K5603jRMuApQ0Vz0TCXVxNwDc=;
 b=VW2ote7xLyYKyEXCvK+ZWVW0EFeuyUjDy1ZVc4T2GSG6qObeTifIhhjopkd9BzENklBHjTsxnx8D/zV7kj7iJ1io2/aAsSFEz6UCBfZqWPhSXxBGDOmeZfah+f+zWEy4C2HGcc2FIxxvSKY2c1KKTj1Tjpw9C05Wg1U8UXaN4WlVdxsJEHeKwdWoOfcl+z6Ad1GGFEl//t24QVUMXN0nDz4PY6zcWasQvqRcU9kYUc2dOh19+6SfyNPTjG1Mc95sjLrJo75IKmzAb1yzZJswNScmtTymDSOdX5buWQXqnRkw0yVFzaQXyh52KkMRiXKbYk9yrorx4z64pNxLo7acqQ==
Received: from SN6PR05CA0015.namprd05.prod.outlook.com (2603:10b6:805:de::28)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:45:12 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::25) by SN6PR05CA0015.outlook.office365.com
 (2603:10b6:805:de::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Mon,
 16 Jun 2025 22:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:01 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:44:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Antonio Quartulli
	<antonio@openvpn.net>, Pablo Neira Ayuso <pablo@netfilter.org>,
	<osmocom-net-gprs@lists.osmocom.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Taehee Yoo <ap420073@gmail.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	<wireguard@lists.zx2c4.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next v3 01/15] net: ipv4: Add a flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()
Date: Tue, 17 Jun 2025 00:44:09 +0200
Message-ID: <89c9daf9f2dc088b6b92ccebcc929f51742de91f.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 01949420-7e7d-4075-9b73-08ddad2773e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TrJLsiSFg1dgy8OMZOkqc+2tUp0rt1PZ01zwgTjXoV2ASQr6LpRkJ37eysmp?=
 =?us-ascii?Q?n2LvZx1W4nMCKOBPyGLowG5f0LITjaf6joRhQaP3EH4FxsHcDFFuODaD9PqJ?=
 =?us-ascii?Q?Aa2Rxz9X8YF4FZhZXU+oopvEIc85Zvp+Ei4fylSpELaKZAFm177PhiNFTm2k?=
 =?us-ascii?Q?XNN2/TFz+Zi7ZidCqSq9NtipuEVEflLvHLYzAM15GVKyKav3dOj7Pw+f67iQ?=
 =?us-ascii?Q?qz9PCIocHC68r5w7lOCWTSkGV9fAFfwpdtyGn32OwzHLTgCfdrdsNQsDiG0T?=
 =?us-ascii?Q?+Y4s9oVgMmqgcHfSJ6yopHO37QKn5jx83wxG9giY/r2F2kZJ2Y6BC5vpQ/K4?=
 =?us-ascii?Q?SMIW0OZ22jpytL9yeuFBGxO0cthif5kGMcN2sxooKfXJbxUR8UeemFQ51qW0?=
 =?us-ascii?Q?+Vfr0WD4SbjMLjBmaqk9LdwQyi+sSU9ZL9BisAg7rRgL4sdYv/hJ5SXTxRuX?=
 =?us-ascii?Q?+4CuFlgZ0ab0h4JMcAqMluZ7/1cD1lNV7bi4uWiLIyAOOqM+gSTpGBgZUDuL?=
 =?us-ascii?Q?MMiSpQHIt+/18vz0DvwkxoH8hViGi1IOp1naNU5GB2UlZ01KxL9agG6gHPOO?=
 =?us-ascii?Q?Em8YZP6AjGBDo8jgAPb5rlUpiWw1NUY1+zcdTVzYpTS7T/VZNA8C9hh0YX1m?=
 =?us-ascii?Q?dQ799k7/X8eNM/hNbNvTAR4GsE2hSfHXSQx4YzJut6oDZPH3yRdzZIGiwHko?=
 =?us-ascii?Q?XWRxpROo4bgS0lVKlgfdXEzoS8IRI8e9w6Rv6DAmNZKuIwSGkeyuVZKNEe87?=
 =?us-ascii?Q?bdECIs+JkXv8Q6IcaMRLdPhw5ORGh8HTjd2PKKNYq7nFL8MydzETbvW2scEO?=
 =?us-ascii?Q?XUnTm5aMjzweqZxosnRfgsRiJMDVW/4shVPvAK2iRJWjGEteUgihcjWlxyIO?=
 =?us-ascii?Q?JDG9HPOcmEroqwvPWJjS1tz0mqTTpwSqCn9BV20CINRaFTBpLRVLhFhz40G1?=
 =?us-ascii?Q?QtIZrrFE95jQMVEElUd0/rpC19o0WEmCuOzhkwvjw+Sl6cN/l5ANWVDUT4WG?=
 =?us-ascii?Q?u2LBhBvQZl5J1COjHPQr7e9UYhNJA6ivjG9K5jaxTcfdgWdOOWC60//1f39E?=
 =?us-ascii?Q?OELgn1fzokjgHWz3n5lrdk2uLCDPAZw6JJGJIsrtq0jRFFm8rn0YKSpbgfyX?=
 =?us-ascii?Q?rxR1AYf1a6/mcDBjTmr+iRJMj7ceK6vnYf7yu+twv3PqK4pUD/vV2puuRnLv?=
 =?us-ascii?Q?2+yg1edQ3uRCp5LoM6KRM6kYXNxJUmgFuu4u5V13Z1Jo87oH3glmhIJNbUnK?=
 =?us-ascii?Q?FX5ARfXLo6oq73XxYgj+tHp5puInSMNT22SSpyJEHYwY6sI5m84iLtdnMoSi?=
 =?us-ascii?Q?wAnCcj+mkatHVJYaogxAP0peVdkjN5Yi58g9/NnCIR8r9yLZ5pAv+CmiHL8c?=
 =?us-ascii?Q?wAoN/JbWsmkLGZizaXsUbVu2c+DtHqG75klyE6GlepORcbp04sPKa99GQb8P?=
 =?us-ascii?Q?A+KUH9GgCxXxEXsLVQpmDnj66gjIz5k06DzLKtkyAp75EmD8ZK2MHfH9guov?=
 =?us-ascii?Q?ks3d60wDA4sB3gp3hog9AMNCDPmrD8GxEu/4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:11.4992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01949420-7e7d-4075-9b73-08ddad2773e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

iptunnel_xmit() erases the contents of the SKB control block. In order to
be able to set particular IPCB flags on the SKB, add a corresponding
parameter, and propagate it to udp_tunnel_xmit_skb() as well.

In one of the following patches, VXLAN driver will use this facility to
mark packets as subject to IP multicast routing.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Antonio Quartulli <antonio@openvpn.net>
---

Notes:
CC: Pablo Neira Ayuso <pablo@netfilter.org>
CC: osmocom-net-gprs@lists.osmocom.org
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Taehee Yoo <ap420073@gmail.com>
CC: Antonio Quartulli <antonio@openvpn.net>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: wireguard@lists.zx2c4.com
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: linux-sctp@vger.kernel.org
CC: Jon Maloy <jmaloy@redhat.com>
CC: tipc-discussion@lists.sourceforge.net

 drivers/net/amt.c              |  9 ++++++---
 drivers/net/bareudp.c          |  4 ++--
 drivers/net/geneve.c           |  4 ++--
 drivers/net/gtp.c              | 10 ++++++----
 drivers/net/ovpn/udp.c         |  2 +-
 drivers/net/vxlan/vxlan_core.c |  2 +-
 drivers/net/wireguard/socket.c |  2 +-
 include/net/ip_tunnels.h       |  2 +-
 include/net/udp_tunnel.h       |  2 +-
 net/ipv4/ip_tunnel.c           |  4 ++--
 net/ipv4/ip_tunnel_core.c      |  4 +++-
 net/ipv4/udp_tunnel_core.c     |  5 +++--
 net/ipv6/sit.c                 |  2 +-
 net/sctp/protocol.c            |  3 ++-
 net/tipc/udp_media.c           |  2 +-
 15 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index fb130fde68c0..ed86537b2f61 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1046,7 +1046,8 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 			    amt->gw_port,
 			    amt->relay_port,
 			    false,
-			    false);
+			    false,
+			    0);
 	amt_update_gw_status(amt, AMT_STATUS_SENT_UPDATE, true);
 	return false;
 }
@@ -1103,7 +1104,8 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    amt->relay_port,
 			    tunnel->source_port,
 			    false,
-			    false);
+			    false,
+			    0);
 }
 
 static bool amt_send_membership_query(struct amt_dev *amt,
@@ -1161,7 +1163,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 			    amt->relay_port,
 			    tunnel->source_port,
 			    false,
-			    false);
+			    false,
+			    0);
 	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index a9dffdcac805..5e613080d3f8 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -362,8 +362,8 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	udp_tunnel_xmit_skb(rt, sock->sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, bareudp->port,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
-			    !test_bit(IP_TUNNEL_CSUM_BIT,
-				      info->key.tun_flags));
+			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
+			    0);
 	return 0;
 
 free_dst:
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index ffc15a432689..c668e8b00ed2 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -921,8 +921,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	udp_tunnel_xmit_skb(rt, gs4->sock->sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, geneve->cfg.info.key.tp_dst,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
-			    !test_bit(IP_TUNNEL_CSUM_BIT,
-				      info->key.tun_flags));
+			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
+			    0);
 	return 0;
 }
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index d4dec741c7f4..14584793fe4e 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -446,7 +446,8 @@ static int gtp0_send_echo_resp_ip(struct gtp_dev *gtp, struct sk_buff *skb)
 			    htons(GTP0_PORT), htons(GTP0_PORT),
 			    !net_eq(sock_net(gtp->sk1u),
 				    dev_net(gtp->dev)),
-			    false);
+			    false,
+			    0);
 
 	return 0;
 }
@@ -704,7 +705,8 @@ static int gtp1u_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 			    htons(GTP1U_PORT), htons(GTP1U_PORT),
 			    !net_eq(sock_net(gtp->sk1u),
 				    dev_net(gtp->dev)),
-			    false);
+			    false,
+			    0);
 	return 0;
 }
 
@@ -1304,7 +1306,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				    pktinfo.gtph_port, pktinfo.gtph_port,
 				    !net_eq(sock_net(pktinfo.pctx->sk),
 					    dev_net(dev)),
-				    false);
+				    false, 0);
 		break;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2405,7 +2407,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    port, port,
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
-			    false);
+			    false, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index bff00946eae2..d866e6bfda70 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -199,7 +199,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 transmit:
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
-			    fl.fl4_dport, false, sk->sk_no_check_tx);
+			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
 	ret = 0;
 err:
 	local_bh_enable();
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 97792de896b7..1cc18acd242d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2522,7 +2522,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
-				    src_port, dst_port, xnet, !udp_sum);
+				    src_port, dst_port, xnet, !udp_sum, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0414d7a6ce74..88e685667bc0 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -84,7 +84,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	skb->ignore_df = 1;
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
-			    fl.fl4_dport, false, false);
+			    fl.fl4_dport, false, false, 0);
 	goto out;
 
 err:
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 0c3d571a04a1..8cf1380f3656 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -603,7 +603,7 @@ static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 
 void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		   __be32 src, __be32 dst, u8 proto,
-		   u8 tos, u8 ttl, __be16 df, bool xnet);
+		   u8 tos, u8 ttl, __be16 df, bool xnet, u16 ipcb_flags);
 struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 					     gfp_t flags);
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 2df3b8344eb5..28102c8fd8a8 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -150,7 +150,7 @@ static inline void udp_tunnel_drop_rx_info(struct net_device *dev)
 void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
 			 __be16 df, __be16 src_port, __be16 dst_port,
-			 bool xnet, bool nocheck);
+			 bool xnet, bool nocheck, u16 ipcb_flags);
 
 int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 678b8f96e3e9..aaeb5d16f0c9 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -668,7 +668,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	ip_tunnel_adj_headroom(dev, headroom);
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
-		      df, !net_eq(tunnel->net, dev_net(dev)));
+		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
@@ -857,7 +857,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
-		      df, !net_eq(tunnel->net, dev_net(dev)));
+		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index f65d2f727381..cc9915543637 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -49,7 +49,8 @@ EXPORT_SYMBOL(ip6tun_encaps);
 
 void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		   __be32 src, __be32 dst, __u8 proto,
-		   __u8 tos, __u8 ttl, __be16 df, bool xnet)
+		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
+		   u16 ipcb_flags)
 {
 	int pkt_len = skb->len - skb_inner_network_offset(skb);
 	struct net *net = dev_net(rt->dst.dev);
@@ -62,6 +63,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	skb_clear_hash_if_not_l4(skb);
 	skb_dst_set(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+	IPCB(skb)->flags = ipcb_flags;
 
 	/* Push down and install the IP header. */
 	skb_push(skb, sizeof(struct iphdr));
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 2326548997d3..9efd62505916 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -169,7 +169,7 @@ EXPORT_SYMBOL_GPL(udp_tunnel_notify_del_rx_port);
 void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
 			 __be16 df, __be16 src_port, __be16 dst_port,
-			 bool xnet, bool nocheck)
+			 bool xnet, bool nocheck, u16 ipcb_flags)
 {
 	struct udphdr *uh;
 
@@ -185,7 +185,8 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
 
-	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet);
+	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
+		      ipcb_flags);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a72dbca9e8fc..12496ba1b7d4 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1035,7 +1035,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
-		      df, !net_eq(tunnel->net, dev_net(dev)));
+		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index f402f90eb6b6..a5ccada55f2b 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1103,7 +1103,8 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
-			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
+			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
+			    0);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 108a4cc2e001..87e8c1e6d550 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -197,7 +197,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		ttl = ip4_dst_hoplimit(&rt->dst);
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
-				    dst->port, false, true);
+				    dst->port, false, true, 0);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
-- 
2.49.0


