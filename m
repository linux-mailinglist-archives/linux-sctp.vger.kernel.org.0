Return-Path: <linux-sctp+bounces-577-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33EAD7C1F
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Jun 2025 22:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24A43AA88E
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Jun 2025 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6342D8772;
	Thu, 12 Jun 2025 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YmaWLax9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89B2D6634;
	Thu, 12 Jun 2025 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759174; cv=fail; b=r/9XcEty2YLAOVzwMR2VYh3U4yUbM5fNi2sazAqvYXLMCMTgacSrJ24FkvEZs7WpcNPLlVTnUrHvPvJzeCEg9zYaZLrp5IlggaYTa6Dr4bHYk0B+xp+lbdYD3dCwXLOGiTNKSm3R4G7pxbsAEkS171wQ9FOp5zxZs4CEEU2S+TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759174; c=relaxed/simple;
	bh=Gbx92xz9v7McEyEhFmZwuacaG2lgjs407vYpNXG7Yxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdedxYNN7OOE1+Bqp0x3AQ5Ew7v0YxT28T3GcZXyqSdNTFppgRHUAAge6bfnX+Qat8uQ52HFTQe1fPIENXHvmvAuhjkeDd8rB53wW91CWNijJ0xNxQS0ir4b5F6FXhV9P5tMKhNvZA9JXiGeaucNxnK0//DDs7EPihRCeEaRsNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YmaWLax9; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMXgbRNWiCiUilmi999mHnjsvpZQjjGaMdY/jMWh+NtrHb9TKkvhBAEgM1NjdQ8iCize219/QvyQ2RYy/G6ZhRNfFfiPQNUjoJ5WebxDf2qOBMWeWRNIpjaCdTuYdBNoHYafOrNI8V1g7iyoxf3ktJAkG7GnEf5MKpVBaVH2uTEDAUvynxYuJP7xJoCRXA7h+R9z0hkmiShfOD8joLdoFDPGqojIarSadz2UNPXdTlV8BexIIF7GIomUMCiy/2IAWBy1ef0mP84rZhwfamTrLol5aGPkkIcLQpz/01PjrxMoq16sLIOb5SLgNvrsiiAiflyQbXRfYtuaOIFCmY2GwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rqVshfJn0nINHr9InWhwk8gEXi5cPmrL5gvbfObtUw=;
 b=VB4XiGZQ/oOO/pXFZU6T20YmgEISMMQZyFJKBDJx9ItPPZF8FWrszXi7fT+3IWFzGSPjooVMPY9sZJfkCwtEO1UbYPxr6sNj9tSWfuwe//WVY7GaERfXPQpBwyBjb0mm2TvG2HJ+XbdyvhziHKcO2N36buUj+Wdu0P3EkDwbf68q3XARB7yWC4P4Fv6r57NQaKb33VDXFhakPQzVbQcOTQXjhNLJyT8hCImYZC/eXnWgaEsCl6EfFkzolMXQfp/xy8XeObu+QEWe7mwOVi9TbEMI/i8MePXWIJjRTIZTQBxNWU+9tQu3QUuldUZ54MSTkrI0NzsbG4w6Tqm6Pctk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rqVshfJn0nINHr9InWhwk8gEXi5cPmrL5gvbfObtUw=;
 b=YmaWLax9RVDEoSkQ8fdD2w/eWSoQfi5FrITIkzKCm4S+ItHEQ3EijhN6k4rtBnSy57b3wEoo6kXAWWjDLMQw0U4gvuT49/MtvvwIgK833lTj1IuKlOwcJDD/WONeURn878N3sjiEW3HKxAqxEBWWgo7J6izzsTzYFZUT/bn6CCmeAiAi2CSvNtfX8n7eLITbxQrwsste0rQ5QOgFDJaDcb/f94kmQdmDpX0sJ4UCIIkPDj/XMRVbcUkKIM4i60i4H9B2yqCVAceE1Cdrr7OILag9CEji6g0VqvbT8PAbz0jCsTUWOE6ZhsgOx4qP8BQdLspSFFJUFU7Jphv5K5V4/Q==
Received: from CH2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:610:4c::25)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.36; Thu, 12 Jun
 2025 20:12:49 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::ff) by CH2PR10CA0015.outlook.office365.com
 (2603:10b6:610:4c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 20:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:12:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:12:35 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:12:24 -0700
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
Subject: [PATCH net-next v2 01/14] net: ipv4: Add a flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()
Date: Thu, 12 Jun 2025 22:10:35 +0200
Message-ID: <93258d0156bab6c2d8c7c6e1a43d23e13e9830ec.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f64a987-4a18-4a6f-0611-08dda9ed806a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8PITHcsm6VIUI77OTN/frQJjyhd2Wvz+/+TiC/XlD//CQ6UrelcTaO0hIXyD?=
 =?us-ascii?Q?y0G34Bd/mFo9jv47imqRITWZOL5vJ26u1wzpSVeUpZbEQzkIlKAja3xc5xpj?=
 =?us-ascii?Q?AHgCUFPyIvS8iGsQl58/MLVR+Y7ZU064sfgZ75uqHFot+5Pnx0Bg1Qygyco5?=
 =?us-ascii?Q?HTJNVQJDgCdEwoVyNcRN+v2C+TCoyyajPa038BaLDK1v8/yZjhzWJaWXZ+6v?=
 =?us-ascii?Q?4MachjJdKR4T7IdqOLPGZ6a17IkI/Q+ap6K2e1mdLRHSsRiI8YpPP5nDEm6a?=
 =?us-ascii?Q?ryzufbzZi5mdroh3CMmjBS4vk7jtOOPrSqWfn4jIQ+KN9aSU7xwdLTSt2dUb?=
 =?us-ascii?Q?csy0dY+A0Opf55FTrrx4zUFE0unAMRuiMThct0tv3lyO2I46Gl31jK+cNeGS?=
 =?us-ascii?Q?fykfOJSo8uDva/zRss1qeOUp3EjWUGy7tAr9JqINpWwT+LnxDJdzRg1FDKk3?=
 =?us-ascii?Q?44JXc3vwtQyTI6q6FJnw9nwS5DBmHj+Ou0BdZ7JpZ7vUXeJShUffyd6BKR2x?=
 =?us-ascii?Q?lYdXm38wGH0/+6ywNwWUcR0qQISxFI5sSuU7KZUyzF77YTfFRywdUEOlpE2U?=
 =?us-ascii?Q?yxo6yVcM6SseEtc+IWvdkdn1Y/es/NTOFEeXuSrviUCQuVjxbM4tFcyvwsig?=
 =?us-ascii?Q?mdZMLZnDSd7sKNkzaz2D0V1toYO4GwcIl0Q4ve4LS/iu3m9vjqZY77IxctUN?=
 =?us-ascii?Q?STNPZIPrJbeSY6BZGsWvyGl/5Y0mUqycHAsKsQDNAucWvC9Q2P5Cd16lRxz8?=
 =?us-ascii?Q?qOs4Rxmf11Bbeumobd7Ncd+kwi2D5mFk206m+p+osGjo8Zgq76GN3m+OS4Vz?=
 =?us-ascii?Q?5PDpE5OiCd9D1WgAdSUVyttWFhXxqZZ2TCh9ycBBR7yZxxJ0PMuSYaCb9E0o?=
 =?us-ascii?Q?4+MMRW0nAVih7L8de16/9gO5Q0gaHhNQ6uJ51pHMsbbIaIWI2lnNRgXtCeTL?=
 =?us-ascii?Q?9JgZRPDH4x4VfPDi8xsf+b50PrTFhWfofM/8mQgB2ZU6xF5me/fYplzGFw6u?=
 =?us-ascii?Q?REewRIYjjvgU4WksFArzBEZrz9BCKAgJJz4z41i9O0UgLcptIUeUITb6Nwej?=
 =?us-ascii?Q?RsF0PUj78ndSuIRbLeeGXdHKoOWVHV5L0gCdw8d05cYX/vTM9QCBPWoTjfre?=
 =?us-ascii?Q?ir+A2CnCnU/roDoKCXcNQWq83aNkg6Ch/rC5IzmlFuuChWZoHi80FhDG7PIj?=
 =?us-ascii?Q?c9ANJgW2rV41QxDRdnBU+gGSSvfCiimXI3Y9XFgxPfQikGtu1QbiIaiHVqwL?=
 =?us-ascii?Q?Vy7kTb/+lH6lblBwfc4rTX1CdvcVlK0Xd1qiAFwH48offhqJGdqJ9kucbfx6?=
 =?us-ascii?Q?O9gQVN9di7QOWkL5fvQN6iLRKf/ypYLqXdiuUn2PN32olm6Le8YeiYmsOea5?=
 =?us-ascii?Q?bd8VVrWnLdBgH3aVBYAVcZinFkwJinxIIaxu+YjUkX+JPYzXbNLgwjRLxjql?=
 =?us-ascii?Q?bw7sUHNeElcyq8gUjvqCnii75up7ADjHoCkGKs6zrGByJbTIPMUfOboiZnAX?=
 =?us-ascii?Q?jg1toXltRD4tXqb7HPy8qSY8O8agX/aegNH9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:12:48.1645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f64a987-4a18-4a6f-0611-08dda9ed806a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

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


