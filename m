Return-Path: <linux-sctp+bounces-582-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AAAADBD22
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Jun 2025 00:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3D8173A67
	for <lists+linux-sctp@lfdr.de>; Mon, 16 Jun 2025 22:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608321A454;
	Mon, 16 Jun 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IARwvklp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E042223DE9;
	Mon, 16 Jun 2025 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113953; cv=fail; b=rSAbcD5MgmNZVZzZHObqfrTugzceUY60j6toYWqAfkIbzS5l2196YnLW6T999jEgX9LHXSM9GCEjIKMy5zWL5TS9DMCZ5DnKXRKz7RPMry+itdkud5JFDQJ/CNzIh7AL/+5XE8NFOfmUhtl++nhltkYp0Xa5ugqk8xPKwi0o3D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113953; c=relaxed/simple;
	bh=ryKS9A/5E072wgvK19zDweq5fy+FbMhmXRA1UqS+0Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nah6avz7/HEaf3AHqV6CiawjYThVSCfyUqxQQa8a3Zv+kOLmJyGUqhJuUlRlOq7SvDiKlgXT32xpyYP1UWHK5/na7qsgTvzOoHKqfnaRk4IMDIbl+FB5LkbDkASditDRzdasnS88c81/OCIs/Y2gNnPI1v7jmbiCanHbUK9/qYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IARwvklp; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep+RyNsew+2BzaDixNv7tDahcDbsxJT9LFzMKgCbQ0LCPXoWUrZkmfoNjXYrFLi0MWhwInBxM16qGWCVpIn0jDmEO/IxewLuzsrqojcPh1lXUXJc43yw/Um7aqmp3nVaT1+lQHjsIMLbVUzWvBEccb/aYwfohME1XYTR2Sdm4sR9PmjTQ+A/P2gyc4ogVcLtXAU3zZaMeCkA/v1E2/o+phjFYcIiLo9ZZHMSvNgTYOWxl55/6eeaVXGxFFxQzSovc0vyD8IMktghGq7T3KwSHkSX7oeiohKlzeMdeenRg6dyFdiWNPdHy2koXeL9UGhEfWZ6Y7pepG3XNIp7KaHoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpL9/E7EZtpVCJe8EQzHWtaBQHClm4LFb4f8yS3708Q=;
 b=hM+6q8btSMpMC7SeRtiE9S309NDxSWLdLJiy+GijJAjc160qw+IxC/r8BQ/VDE8GO2yijuzF2lEPVvbpTXQMYMWP+eFkxu5RIofpMPz620PmGPfRy5vPDfv/5QeqTkLJUWIfd7SBeEJeE0fTnOUvtN08jupeupx1qoOJRg4jku45rfQmikTyy2oQqO+tZJjneTiYR0IQ7S9WAS4ZgzCVOxIAiZrAUh0P6STSkwUz79HikcTKwiuQlQnB/qLhjepmz8vrPpC9bMhZUCtV3/xMYAbOCsUHCwTkj9bp9AGr0q9CJtF4kobUTtaWPK8plmq+jzEpd9/mYIgomglkI+Tp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpL9/E7EZtpVCJe8EQzHWtaBQHClm4LFb4f8yS3708Q=;
 b=IARwvklp8Wi5pTGbZujd0SmIZcXrNiyoP7RD2I6B/b/n7pLyguU8sP3z26/ZQ1ioorY/BAeUSs708ena5VmrgfEl7/81yEGgU734ZT2cQPBA2O6yAtmmfswujfFBNBpUXenQt0+1oCDOPIZPXHkpRuB16XJuBHH78dv5xZcCue3dFUe05OqEylqSJ2jx73JhEyUnVhfdVxBK4xL6Uj4HI+K5k6L0/sgkuKQQYyD+0q3NgJCaSVKQRRlRxsi0V9fP7HqrnrHa6T4gbdvcEjx6UZzIUOCAv9GrnWOhHCjbqQSIY4el29v8I97Fuyb2/Wgn4ercbp7Xo+yGPzdboacEBg==
Received: from CY5PR15CA0245.namprd15.prod.outlook.com (2603:10b6:930:66::11)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:45:46 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::1c) by CY5PR15CA0245.outlook.office365.com
 (2603:10b6:930:66::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 22:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:27 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next v3 05/15] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Tue, 17 Jun 2025 00:44:13 +0200
Message-ID: <7facacf9d8ca3ca9391a4aee88160913671b868d.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3655835f-8399-4aa8-e34c-08ddad27885f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/vwK3wnhiKUtZwtzScGZMAxXPqH4sCzCeewkgzTDC77eu/dVNhwuEcdfyuF?=
 =?us-ascii?Q?6t8eF4d++f6apTlFSeGJBv7ut7sDvIjfDUHiBelSCVj13V7n7rCXZ14TbH0M?=
 =?us-ascii?Q?9IhYU5sWAkyKCQnQxfAwwOB8zGsCSTCTH0/LD3cvs5ddDNKM8n01WCvAT3Hk?=
 =?us-ascii?Q?4z9uI3APeaNPa2r1DNMtv2U2VPqUdocIHpEu9AI/9NlhxifkP4aIpQZFQZwT?=
 =?us-ascii?Q?eAXjK1DcfEN0WlJIVSofz7GYlvwAbN2ZOrsErQ2A+H6I99R/Z0fpsR8Ocabz?=
 =?us-ascii?Q?xfq4zpoO5ecEsMoIixeXWCsdqM2VGXUU0oDb9kCOO4lfzAyiJEfb9Xp8cUa7?=
 =?us-ascii?Q?djCRO9BG7s+eawEskwsMdgypYYBhfJyLKYdQgDSlUqZ7OqQgZJy9fQrmtgyO?=
 =?us-ascii?Q?n0IQ2GPBs7qS/ukyc0bAtgPQD9nO3T6PugRH8Um5WzgO9QVFyk+33qZ6XEEp?=
 =?us-ascii?Q?cZ+cUeJaIb31jX91eJVja+LKuX9QolpMFf/jDZFEI8AhhQPZJf4bzG5kpP2O?=
 =?us-ascii?Q?VHoaFu+KM24gpHMgyyex2YNcQb69MtBUxav4quf1yTBw8VtqCozaIcYq7YhI?=
 =?us-ascii?Q?txphy7rnPUyqW+HrsWZuIsDd/80iIUAzm7kNdwYc7R7dDGEvCQVl/7GtQtND?=
 =?us-ascii?Q?Xubxoppc3mVsMtryAmFRN13gF1qiKy9Dz1Qognf37Qx/AZArO/nsVk9TmehW?=
 =?us-ascii?Q?5cWs2M7xQZhx4p6ISz1qnsM8ezOHArl/2NktJicgPhNV229lgaXSS6H6xy/2?=
 =?us-ascii?Q?zSLmf7nRvGWUIMr8rDOCeMHOoX0Qj+NyMwxGV5eEE7lW9i0sT+7KiBf7Uxud?=
 =?us-ascii?Q?qlQ21NLRfmlhve0d3WmbruI2ukw9VeX2724mZFzYPBpNQV5W2qOVSHR2p2WM?=
 =?us-ascii?Q?B6tFBc8aRtLhj3k2Ux5yOagSL5wgwvLGgwS9JSyL7M8iN7U3+33IgdqKtaXB?=
 =?us-ascii?Q?l7ADLG684uxWzDEcCGbKOh2mHPn52zArRjkMBZr/s7vagYpHivhyGpRp25yq?=
 =?us-ascii?Q?/8PmCl8Qml/ysFi+Vf+dIgU2gaA9EInGdaUY9E0339lVXcqgT2D48JfknKH+?=
 =?us-ascii?Q?NWopbAESlb0/mqtfrNYl6rvANG5btPTWUSa/shgzArHOkTEfGsK4tA9pHnc1?=
 =?us-ascii?Q?tG3g5wyt1bRRldJb5rBXD0s3rbvo600yOAF+XaVS9UFkg106ebu9bzYG91Zv?=
 =?us-ascii?Q?BUi21WaLraDePdYyyeHXlUXJVccGOkzJXXZCfLmKJ3CpNYMftlSA9gW5YIgy?=
 =?us-ascii?Q?x0k2DHbwhS/weM4hP00E11+O3nSjg2v/XAFCKP23cd2Q1nZaPiGTz1Bz71FB?=
 =?us-ascii?Q?C2XiZl1DDIP8GciDmwc6613Myw90JzrzxHzUl6kF3WEyEEi+/M7V0hy+8O2W?=
 =?us-ascii?Q?cKrKYCCUVWtF/nGz01UnOwG3A135UOcsJJhSsemTdBbcaotRtgku/zC3Vvmn?=
 =?us-ascii?Q?qXrmvamRnIAUK5zVUVpiFH7OQpq1cQ1DNFhP6Ij+r9xXmYaV2PlDSMlnQaW+?=
 =?us-ascii?Q?YKA9znRI0/9dl2vLzN5FTtqZBbA95/RYrGo8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:45.8839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3655835f-8399-4aa8-e34c-08ddad27885f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837

The function always returns zero, thus the return value does not carry any
signal. Just make it void.

Most callers already ignore the return value. However:

- Refold arguments of the call from sctp_v6_xmit() so that they fit into
  the 80-column limit.

- tipc_udp_xmit() initializes err from the return value, but that should
  already be always zero at that point. So there's no practical change, but
  elision of the assignment prompts a couple more tweaks to clean up the
  function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: linux-sctp@vger.kernel.org
CC: Jon Maloy <jmaloy@redhat.com>
CC: tipc-discussion@lists.sourceforge.net

 include/net/udp_tunnel.h  | 14 +++++++-------
 net/ipv6/ip6_udp_tunnel.c | 15 +++++++--------
 net/sctp/ipv6.c           |  7 ++++---
 net/tipc/udp_media.c      | 10 +++++-----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 28102c8fd8a8..0b01f6ade20d 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -152,13 +152,13 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck, u16 ipcb_flags);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck);
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck);
 
 void udp_tunnel_sock_release(struct socket *sock);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..21681718b7bb 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,13 +74,13 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck)
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -109,7 +109,6 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->saddr	  = *saddr;
 
 	ip6tunnel_xmit(sk, skb, dev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index a9ed2ccab1bd..d1ecf7454827 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,10 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	return udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr,
-				    &fl6->daddr, tclass, ip6_dst_hoplimit(dst),
-				    label, sctp_sk(sk)->udp_port, t->encap_port, false);
+	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+			     tclass, ip6_dst_hoplimit(dst), label,
+			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	return 0;
 }
 
 /* Returns the dst cache entry for the given source and destination ip
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 87e8c1e6d550..414713fcd8c5 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -172,7 +172,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			 struct udp_media_addr *dst, struct dst_cache *cache)
 {
 	struct dst_entry *ndst;
-	int ttl, err = 0;
+	int ttl, err;
 
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
@@ -217,13 +217,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		err = udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
-					   &src->ipv6, &dst->ipv6, 0, ttl, 0,
-					   src->port, dst->port, false);
+		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
+				     src->port, dst->port, false);
 #endif
 	}
 	local_bh_enable();
-	return err;
+	return 0;
 
 tx_error:
 	local_bh_enable();
-- 
2.49.0


