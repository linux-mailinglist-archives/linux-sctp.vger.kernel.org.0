Return-Path: <linux-sctp+bounces-574-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB229AD2810
	for <lists+linux-sctp@lfdr.de>; Mon,  9 Jun 2025 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D37B3B0F61
	for <lists+linux-sctp@lfdr.de>; Mon,  9 Jun 2025 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10621FF26;
	Mon,  9 Jun 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b012vXMI"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F78F40;
	Mon,  9 Jun 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502297; cv=fail; b=h/GBmIjRSTAephf3/Vr35lkVFlahkcTI4rLLFZo7zJRaPzRR5mLGj9Qq8CfOLdg24mr4M9I2MaKgkK+48veL9Bw22/rO7nPAoiBuGqCzmfTQ+rWfPmrATBbwasMIxR4yKWt9U8d1+0hPFLM/ufWxIOWhroxgomj5X2RyEWMxRu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502297; c=relaxed/simple;
	bh=F9ioFfzwVNM41vH6tLvj2VaCdAJqnWY2pApzkIwgZrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWRw4GTGXMXvnOr+3QuiAixJ/IF0C90RJZD32sQmGi3Z6EhUkrHhIZHfkxBpt9pnPZ5NhUfcnEzuna0oS63hzhopTH86M3kQqrEHVP0GwZtLJq7tfDt7OCBisfXfDXHBcOjcC89mXBMVQEss+zevEAXVL7bGXXEXt9S2jdSTCa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b012vXMI; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DimyojrYij5TBt+VIaPpYC94dLl/QMb5ZlKJcmAx8l9GcXzchDnHvii9P9Nd8iJMAfQ9ASWeTTdaP2ugNFZ9FEWqxzW/rA+O7LCfaOJPnXgMQErbTISG1BOswCd7HWm8sd2jFudQWcmwZHKJIOJVzpKPyprLJCwZ3pTYNyT/L151tnyztN4l+C/Q08+zI8Ql+tH0s9ckf4pSj1PneK1weaGQCBcLjlof34kGLS9XmhtbTaBs77ozoz4qVWD6XZDC9h4ukh9n7h/ltvv1XT/LOIw5wZgLKdS9f7IHfD4Bloo5zANv8jceLzw3dXCYn7wisMmnoFkaeAPGInw6/QWfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HRGDcwRTrU52HtaZVZW5CQ7c5voF1TApYELQ1CCkGk=;
 b=HUW377eBU2MK0EdWz11JD6fQ/izCx5KnVjSM1j2cNEYDh+/aiJulWQFsEGox+e5hHyxyVvyIvgB8k5mcYzLu7qPRCac6E5cT/cbG1TxdN7XAFrQcvIetrlSxrTJ3FGkvpOsRXhT53YOmOMFhtwIfczIm81ivLY2ptx6llW5HVoCxr9Zz3q4fJTaufRU8h/srCxM8J5lkZDea3JVyCI85jucWkESZZQh2xPxvGtHt8rg6fJ+BuuxW6m1rex5IhB5uZZ+S1yVINjAJXtni7qU9tCKuy0iTVyvCbHmWGTnX6pa/eDhudqFMXwTwuv3du5vv9bfkJZgma+lgDrUPQnA7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HRGDcwRTrU52HtaZVZW5CQ7c5voF1TApYELQ1CCkGk=;
 b=b012vXMIx+pqfSVUxkGZ8YL6+80UpRN2sCCklEeceT8ZF9s0Czg/pt4boHprezgqyn1OYoti5OTwToejtU/ts71vpKNcnFWQuJHDLT3/ZOSMdawNuOAVSFF4zVnWHDq9555RTWgAua7VOTSdTjR9dnArYcWcayynpY5iRE/pefJ+dEiSvh09CsA58XeHBSz+/6cL/FHUdeVScEZJ6yFMzAQS5s5EcRWt3av3egYC4j5DwznWVUud6Io/sc7MVI6ggY+uUSs5svIek/QK3i7e/krNiHHaJO+T7zFEvUp0ybE/tIYzHJNWIeVRmC/VetkH62nZFH+w52YEJlNupPg3xg==
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 20:51:32 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::e8) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Mon,
 9 Jun 2025 20:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 20:51:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:18 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Pablo Neira Ayuso
	<pablo@netfilter.org>, <osmocom-net-gprs@lists.osmocom.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Taehee Yoo <ap420073@gmail.com>, Antonio Quartulli
	<antonio@openvpn.net>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	<wireguard@lists.zx2c4.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next 01/14] net: ipv4: Add a flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()
Date: Mon, 9 Jun 2025 22:50:17 +0200
Message-ID: <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: bddcd4d8-4792-47cc-70b0-08dda7976a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u59uX32OxHuDAgUmljRegFa2jVlZh6BIHlxSFfYtiwWNMGHSVIW4hQW2Q6dY?=
 =?us-ascii?Q?OYJHgpuGmuQlrpxAuWVL0W2MHC2a0a+3RdIpq3x3xNqDQlqPOnqej9GIrStU?=
 =?us-ascii?Q?mB6ZoCN/NT6UD6GSV/z5L8TzijdwDBGl/6Xax7AH52LEeHOqmgQ0PTEwACY6?=
 =?us-ascii?Q?gUZN7dKQX+12SmpjnB+ujX2+AE1MEXlH4dgZ/8PlxdYtdldyxHVpbV97V8f2?=
 =?us-ascii?Q?wRISSUP+I/bgcXSRyImgumdx8y84LeXty3q3lpGF0JCLxFb51+C3NGJ1HcSQ?=
 =?us-ascii?Q?Z92rE18hdtnqbDeeWPbdy2d7b8Kudwxa3oCgvsfpV4y2CW3+StXLPo8shhMv?=
 =?us-ascii?Q?1jz8DWSnTu1AVivDRqc4t4tvq7wuzYjH1ZSmcX5a5xMRoq3XHJIl3IoqsXsY?=
 =?us-ascii?Q?/SC7zxkv/e+PrgDRh4YFkRtTdbMf9RODpFIGdZz+PfSgOtD3/0xmKNm9c18P?=
 =?us-ascii?Q?Yk2loDzilE4WXSpDJVxKLkQr2BsRVCSv5Wyd4VMNx4rK51zyShtr3TGhOPfG?=
 =?us-ascii?Q?OP9qJBV4Tw1p/2dqthzzY8XbL30n8vyMNKZpDQimisww5XDxI+nuGNqFDs6w?=
 =?us-ascii?Q?zZgllbJp6/CRRZB0XmjdnYcTZ19TbAVW2PndY0HsHzodzjdfkQwoNmdbpzQ5?=
 =?us-ascii?Q?pH1coNLE1TFF+2qZw0xNB5RsAi2DijhQl+y0iCPGWzGFSLg3Ix20wEp4P2Tb?=
 =?us-ascii?Q?fZ/2CHxkvVOlWrArus8N50cAsH1MLz7JmE2L8gFSyWdOwVhaBP3+KjXazC2V?=
 =?us-ascii?Q?dk8hDLQtyWrLJldDJFUDtjwlooHqjb/rrpKMrfWj1mSOlRZFIvg9frLovqQ0?=
 =?us-ascii?Q?yIK/3KtWMqkMrQ4K7TASOEGa7940tBKOekL9Th7KgA68Do8Ch9xdZbpWom5Y?=
 =?us-ascii?Q?cD4Pk4LTOjbJX7wiMHVRL7h9nM0O3cYkSiXXjyL96tadRvfWjZ97nK2xeGBg?=
 =?us-ascii?Q?rKSH1s5tWnk1vyhOoPLYSO1j61dXd8m11gWH7J51hMV5PHnXs5x2QjYMWRyz?=
 =?us-ascii?Q?Nv2W3RapnEizdloNwY62U4YfeKPDDVZ55lV2jmN9BNn0vtD6X9pl7/zrZeoR?=
 =?us-ascii?Q?JGr4M3CfggOOCQkMKrLE76a4zYJGBTdns1VSr4+2K2HaeaMQ/SHKAFCW4mAN?=
 =?us-ascii?Q?P25YIBaKQdJT0M+sZ6Ionky9uDRlo5Mi1OXNhpNoY7aVTmDyIUliEXwJlIb6?=
 =?us-ascii?Q?2sNrio+eg/j+qNmk8m/8auymBLSQHTXZyTHhcVUC2BH0PstzWDGRJxF4O5NV?=
 =?us-ascii?Q?aFW4H/n/XJRIcLDAJnT9KlMh7IxSAT54/LCZ1PtMEUCiO1Se2zCtE+TzAtXZ?=
 =?us-ascii?Q?OfdWJMXLNimfoWxpIIPf5ioRoHd57BZkW1ULwvXa9PU2/sqP7zpSPpMSdZ05?=
 =?us-ascii?Q?6nkdjV1dN7/1bX9TehL/OvHYTlxkuNapE8XMIYJDbwX01ojVOqUvkrJ63QEi?=
 =?us-ascii?Q?7cJQulZcOo8be6dZkJvCnoIsoxjpmbPmEEAT2xIwddwz+x1168znJfjDT71/?=
 =?us-ascii?Q?C/Qd3ERuM9D1Y751NCOHRdxmdF7gkIiyh7CZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:51:31.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bddcd4d8-4792-47cc-70b0-08dda7976a00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

iptunnel_xmit() erases the contents of the SKB control block. In order to
be able to set particular IPCB flags on the SKB, add a corresponding
parameter, and propagate it to udp_tunnel_xmit_skb() as well.

In one of the following patches, VXLAN driver will use this facility to
mark packets as subject to IP multicast routing.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
index 734a0b3242a9..d0f719531499 100644
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
index a56d7239b127..d7a5d8873a1b 100644
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
index 8c3b80c4d40b..bfbb73e359f5 100644
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


