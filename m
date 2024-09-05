Return-Path: <linux-sctp+bounces-237-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7396E074
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49F4B210E8
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2A1A2C05;
	Thu,  5 Sep 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VP3H8gJk"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464319FA8E;
	Thu,  5 Sep 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555262; cv=fail; b=clGfdFou66+yDImLusYYNIK4AhXrlEVpwkA9yNLbQlAZ7ftNRiZelTYO1NMBRiePP5m2cvh2Feh+B+COn/zOhJs8y3VgznXCLktUK4qHj0oLr7euEFS+QduTucfU7zI/QhbqMsO41552TD5dXDxCZ72TAEZ3NEWBQ3xap+Wo8U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555262; c=relaxed/simple;
	bh=HcOmb6W+1vJBdhsUj7dSq3U0L9zuxpAMalyFHtoAzeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4Ai3Cq9C0zuqPJLLL+r6zIHa17inPcB8MsgVKsi9tH6Euv3mzjGmdFLrzlZ/AiXa28GyPWixsQqO6hVuF8C+lrmpmrDRzwe5JK2z1B+WySR1AO9TPo/eTX0HbiqdxTEfuBQLZ47sWXnUbxWFqucAbWp48wWtQZMKPE19gwt//g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VP3H8gJk; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ka2DMeqKjdSMrn1ms7UC7V+ES9BEERGwk+RLCgdwGmIP0RxoQzadDfTBNGBVxXQSPC2wPH5ISWL3jkk0EVQa8I1Y7n9ZZT1Lckm+5oOzM6OH/SI4W/kFln3GjfdEMgvjG6hMuJScAl/0+TZ9izWsUEEGZLVi8pDQeFLM30tVVRXSCNdY/3qzuASN/IzVRa7SFB7aTIYLCM9s6E8tmWcC+04qT2gZ1vCaRxFf+Jc+JjyvX8eOnesPvSND5iDbPIw5+gIEvFM4Bhf3+HkaMRTcuNEBMl06REiAPsEqXrLIY+ZsK+hya5C+uwlvq8/JUbDjf1OeRiiLXDT3EpZYzVNlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU1i9+eBNnGg490a+zDafnELUmYGEDBe5qbyA68dFno=;
 b=aq5vrMZCK8B0n0VLyEzAhL5d9rm+heqTiio8Yr5s7ewXI+KGlvWzOJp8K5EH+u7zpi1uOph5gjkmFPLvBj4VkXLfp20Wpmm8+1I36sjQNl9PfbbeFx5B7MEms6FDTASjmeanl0n1ynXd/PWtl4zngzif2haWLix6TJAtYpzB0eu3BeuniDbws2pwxHoo8EXKyQsU7kR7jxiiVSfIg97rWL+cszDcHPkUMyIqw1Xs1oHsszk3oUa9Uumfak4MEpkClXhX+c9SK0TvKNM2we6SSiBsu6P0uEllmbqtn2TyiN8NIIH0QSiLbyJVbPg9b7xVA3yCYoNjnSCBPRl+dSecGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU1i9+eBNnGg490a+zDafnELUmYGEDBe5qbyA68dFno=;
 b=VP3H8gJkSxLfYlXIceToPt8ye7sE5g23YK1H3CDdIJ3NNEhBcAqn5k1mSjXgJNsDdZT9J027Sy96WnIzuuFt7sJnMbBHlHV57cgtKpGeBNYnGfBueYwqbV573X02jvqCKDAMHG7h/RH777YChZfg5IR5Fj1on4RCf/CD152zlhsuTNC3njF9tfo0P2GB5lXgmlQ92LsqGWT9lw1++748Y4LKBgYPLvH7avbvJmYNFqdQe0O+6PFB2W6MwYB+jeeNBzNVG5Y1dPO5dIPYDTmqvChYu9jZAKjEb2BhnK87+zNIkeWwX45U+cEUSAiLJpHAZpiff7yv62lDWJz7N2Ms9g==
Received: from CH0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:610:cd::28)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 16:54:17 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::35) by CH0PR03CA0113.outlook.office365.com
 (2603:10b6:610:cd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 16:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:54:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:54:02 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:56 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 11/12] ipv4: udp_tunnel: Unmask upper DSCP bits in udp_tunnel_dst_lookup()
Date: Thu, 5 Sep 2024 19:51:39 +0300
Message-ID: <20240905165140.3105140-12-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905165140.3105140-1-idosch@nvidia.com>
References: <20240905165140.3105140-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e92934-ad96-4d98-06bd-08dccdcb6129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?olPkyE3/Bc5Z+NwuRaospLzF8acVT6HT3N/3hjN8ejt6XXgndfN8HUmftJz7?=
 =?us-ascii?Q?hvWa4xjQgIxxDb9dvuu5l8QoGI8wwogrXPJGLsw9eogmmjgaek44CQUnxWGD?=
 =?us-ascii?Q?gHDqvRblW5APs5IYG+1U6AWsp3o+PExlyKjQhbGHgDeCnvKN9XE8VR+XfFbL?=
 =?us-ascii?Q?4GOePt9vYGhzP7ZMKJaLQyZTnxZz1TGTOl8uaEBVZs8kFOfgZpN0O0Q55BCP?=
 =?us-ascii?Q?N2hfoh+3NIFaOrjH6ortLlXlEucnCqVWXpHGbUiPY2GgHcOX+32/CaLyFgfI?=
 =?us-ascii?Q?OBXYlOwUFNFAdEOWXAPlFOp99YzGCNxFi1oQZxj5znik7mlFs4TbrFkXuF9X?=
 =?us-ascii?Q?61+QduyFkJm2msHODv34PPf1q83iaoQWtOLAsw9sOCxJGEKHSNjpPex8nX8q?=
 =?us-ascii?Q?7JQYwx/ri98ADpeVaIhU570GBBxdkXqCqRo3ec6xatQ14hHrmaJpdcFewak4?=
 =?us-ascii?Q?1/0bMZQGahSXSFW1VkeLCJ3oJlP60Cy4yDOcenrN77KlobYit+2B73Csar/P?=
 =?us-ascii?Q?xQe08RKf9bSek9+NThcQ8IjzHyECBkwsQBO+otasnL/A1uVcXN+spQE5oN9b?=
 =?us-ascii?Q?OA/hHNzHZvqjVI0q4NnrdSq9J31JceOU35wJF5KsUi/FsOdT4gYXMegBmSyp?=
 =?us-ascii?Q?KK1uHJ0R4H/lPeQiyUbv38rYHk/Dvo53NzOCZxFYhqvbKQSK3JJySgfMdpU6?=
 =?us-ascii?Q?rdjxoAQ3bKVEYd6HJKOJlKozsr6+99fdwt6qgm3txXHubnFJvCIK8EfTSLUa?=
 =?us-ascii?Q?KKwdhayVHk6u1RI3/Nz0HJU7FpdxEsXG9v6UI/bil8mYKlfaEEZzcUHfeECG?=
 =?us-ascii?Q?bP4LRdWLj+oR+k7BpVZWUV/hkorYtm11YFSTYEYf5PHLUd9Pdrr49MR0ABwk?=
 =?us-ascii?Q?HsFJE6oIpbtamPvAfeBhRu9+VmqiyzRCnWmWfXRlV1lSdjuocX10Yi78Uldd?=
 =?us-ascii?Q?j+C5wMjfo7dvEB59Qy3dVb0GkvV9yO4n9MwuiyOxSokTMshm5wYjGyfnA/RT?=
 =?us-ascii?Q?F5z0d73wC58LVy6xLVS2WmM0lwaIvrUn3lyW6+/Gc3rOEbdwzMZX7up1/N2D?=
 =?us-ascii?Q?amcrklSizWvlD6nO29WhN0Q7GFdaHzD+Z7gmEZTs3qupCHZ9nDxN8XxhIp7Q?=
 =?us-ascii?Q?ArJ/F7PXxuZ8kp5VjxyVD+UWsqwZcL3B9nPKO4S/AvousQvU/XiZRK8wbe6m?=
 =?us-ascii?Q?6F1lzZ1+pEk6JwQ3lcWhwpq/k61eZxeLXj8krIUwr++khDN8Fx3kQtKxqYIP?=
 =?us-ascii?Q?RG7deYQaC5iz+9HbuKvF1iB7021kLsPTQvQiTfCTVnv/ISt/gjYyZfdklPiC?=
 =?us-ascii?Q?DakeucMwI60sS6otyB2rnAyzqwDL0mMrJImX5OPr+LzEP6M/MTwswhzjfF6T?=
 =?us-ascii?Q?JG7LlzHE9VYT5jhM5QVaQrLl/VtrHzUEn+0BniIzKDmkehOH8XZcEQT4Bzpm?=
 =?us-ascii?Q?OjM8nfMe3xTrkMEKY2WDfz0fUMlwjuLp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:54:17.0339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e92934-ad96-4d98-06bd-08dccdcb6129
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

Unmask the upper DSCP bits when calling ip_route_output_key() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Note that callers of udp_tunnel_dst_lookup() pass the entire DS field in
the 'tos' argument.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/udp_tunnel_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index e4e0fa869fa4..619a53eb672d 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -6,6 +6,7 @@
 #include <net/dst_metadata.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
+#include <net/inet_dscp.h>
 
 int udp_sock_create4(struct net *net, struct udp_port_cfg *cfg,
 		     struct socket **sockp)
@@ -232,7 +233,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	fl4.saddr = key->u.ipv4.src;
 	fl4.fl4_dport = dport;
 	fl4.fl4_sport = sport;
-	fl4.flowi4_tos = RT_TOS(tos);
+	fl4.flowi4_tos = tos & INET_DSCP_MASK;
 	fl4.flowi4_flags = key->flow_flags;
 
 	rt = ip_route_output_key(net, &fl4);
-- 
2.46.0


