Return-Path: <linux-sctp+bounces-236-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6496E06D
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ABF1F26526
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C91A286D;
	Thu,  5 Sep 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kq2ay+tR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE441A072F;
	Thu,  5 Sep 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555254; cv=fail; b=dz+Btj7gUBjFwLZzZXh+qyzT3F3xDwAPcd2kQ8a5EKr41JBl8cqt4g7KL+BqH2NY/L/DvKBkrTv1sHR7tel24r/Pl3HPyA97F5nKL9VvwN+ZdIhIyeg+Gl+wrdfkt9zxLRtfhjzoOF0hj2og46ZSUtmHYSP7o5TJ4nw/l7iazQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555254; c=relaxed/simple;
	bh=o5CfKTfCwI+dFG19TWMj5qSFwWObZ0tCAFPmJVLf4t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqZ9j58zuTVIQn1mYfxeVg1sPevRaGvSBQ5fBRqv2b48kfBXF5ftcwwZqnKGWFvbYFrRpC13S2kbgcVd7vdkx9P5z8Oyo8l4FvsgrtYZ3ss/RgrngyG2thPIbPvobZ0SrJw5279ryJvR8CX5EWvYFAUAj9xfe815VtqSQyHBV4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kq2ay+tR; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj/vXDWR2+dSNNcxV2f/o4PnPQQ5Vz8TMBwD+u3Gowbf8nBSxE02XYhEpqQzqpBQvDR1cRg4YDmVo3JmHoXDTgS4P/bHquzHyFJYEeFoEow+3i08BGvS2bkHg8mtkR220nVOVyKeNA81U3djSWwiOjDifZ3siZFo1JF7cy6YlAm6lFik2K5WxWz9fhXOhWAl61WfBI4gfhPuw2KQt5hpSK0rEP5tewQzyK5qVJhEFiF7MgPc/CNEHOZSQl0BzuWHyFm3K0zAWlq7VfqqQ40Vu4I/Rt8C9ph/Bo2cOiOwxnmJfxHJol2bHIh6CBqlQ3q9xxiO9jzRKTejJe3M+If7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/l9LxCWEVqHtiP1Vmr6TBlDr6K36C8/G4CEYV+Ulug=;
 b=oMTwWpP/GrmtpIvnTh6rrBDOVxw3VUFGgj2ukvNfe9Bqo6vbzZGnDlqOx0zxPBy7GZahU3+WLdlmdDgTpVIHAzac88F4VoppX4o0G4o6KIG8X4xwM1nOTUH61QYJYAsidZY9mdntEN/cpLJUvyFzNQpQX5r9yz1Um+r1RM81qMK9v/dPme3kZpikQNZBReTOoftUDqounWPKwBrsNwK3So8QUo7rbreLBF9/MHYU65j61xwQho9YVkLg7LgsN0Z25fmvBh/XPuvLgE4+BWF1Yo7NlIAg+F733NcrX1GLxhfzOkEshMceduVJByhs8Y6N3IsGD08D4xrzUh7lRA7y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/l9LxCWEVqHtiP1Vmr6TBlDr6K36C8/G4CEYV+Ulug=;
 b=Kq2ay+tRpHkj8E0KNJ5+SybXqE52wQrxZ9/9HINb8tWK3JpAq0boa/gNqYSV1TNRFZuOc9YMwLobEsZnQwKO1zgd3/gZnppX+G9tPde2VHzmWhlBPzFDQdrFC0rtZjVBYFW0rSBD+kEW5u9tK+DQ6xWg2dByl8M1LZdOzAgLaru3liHCAubxMuei8GrykpXknDn2do44YMaAk2hfpTLeKZnyEgfGR4NySaI0k1pruzfTa6MHeE6hmdo072b8IYhnqhuXH1Ea3E+IGhBPfxGATZzZxPlehxuS1FDMK84MnjSVVZy8JLkOcqPvyn+wwJ0FF52vAIydix9J+y3qcObV1Q==
Received: from BN0PR04CA0152.namprd04.prod.outlook.com (2603:10b6:408:eb::7)
 by PH8PR12MB6796.namprd12.prod.outlook.com (2603:10b6:510:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 16:54:09 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::5a) by BN0PR04CA0152.outlook.office365.com
 (2603:10b6:408:eb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 16:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:54:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:56 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:50 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 10/12] netfilter: nf_dup4: Unmask upper DSCP bits in nf_dup_ipv4_route()
Date: Thu, 5 Sep 2024 19:51:38 +0300
Message-ID: <20240905165140.3105140-11-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|PH8PR12MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc48fc6-a8bd-42a3-7ede-08dccdcb5c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlUOGcrlGoG2Aivlt7IJlA2uMbKBJzp26f0t9FakFt9NHFK6BR/9VVRc6MS8?=
 =?us-ascii?Q?zjCgQY8zgGqNbTygkYlip7FApmIMrTTx3FuMlc+oHkFKKfwgatedCruohxIB?=
 =?us-ascii?Q?xWJ9jbRC+kMyWZukTkXZ+TWUiP0tE3dG2JYegm2lo/5uMA39NPsxjgxM9W3S?=
 =?us-ascii?Q?K2dAmx3rsciuqvGGKJ3pVtcL1UbvwIfkLTwhdkoxnq2V/3vRq44Fa7Xv5k/Y?=
 =?us-ascii?Q?AaGy2jK7va9jAEsI39Juxl8xvqyUGeuLn1mP+ZVjaQKz/IrVsZZqMJf21W31?=
 =?us-ascii?Q?//ZVrj6p6eSC46ziO1fndhbzLvxcMrPu6oImPoJB+wgkBCOqC3vanuLAooUT?=
 =?us-ascii?Q?PDAgOfwbtC18iqLrTHklRnXNuVlueoRyK1SkKPgtDDxHyzt66+3Z6RRK/lqj?=
 =?us-ascii?Q?xLkYIN7QesXjX3kbr6PzsCJ7hR4Dql31EufmLXhlfIIzhSAFzD9HxGDktXeD?=
 =?us-ascii?Q?wLHTVR20inMrRqrEucK0SMZGjBngQZ4MJ1S9uW12rc0tAlsw9U1f6jXrZauZ?=
 =?us-ascii?Q?ynb5vI+vvGOApVSIGm8OVw+XIgRs3falD8R3f5HDmKav+QlxhwvS5h/B3V65?=
 =?us-ascii?Q?XNYw7VIOAVQqugOaLNrgnuRoC5jgMoLJH0g1KfY/t/wFvMkdf0geMNndr76V?=
 =?us-ascii?Q?9eJ5XpN9VQDjGfuRv+j8wECJHAQK/l84gRSav92v6NYjXIZ0FrO+ErIjXVNV?=
 =?us-ascii?Q?pExWEpr4Qyiud9tujwKUd8v7kuzB3pkQihNvoukjUtB85HGu7rC/F4tDuxiu?=
 =?us-ascii?Q?tJNsZ9E6T2u2Ay0oSVMqRpTiea85Uv/mGEvYGdKcMSGYIV/TXEpGgl+SoCy+?=
 =?us-ascii?Q?R7wDcm1FxoeqFVAZiIXNl1lyuUgIdIek8gPSq4MhPxXvMWU5AW7sNRMzA6P5?=
 =?us-ascii?Q?USq+6LlGKvS2A1qJMIlCPye4Zbh00gUlJMI3owlsjp/LlPN+5hnX7pnxkQRp?=
 =?us-ascii?Q?qGUtMntXDzRxncmxT7Uc3c3I0e+Ts7N3fvVh1HPhQLvlYazVH9elyXUfmG7F?=
 =?us-ascii?Q?tad1RqxOT0Bf7GKpksxRRMkEsdCzc+Q+hWU4fyLAlzZkCQZy/2Sxjoi+btFz?=
 =?us-ascii?Q?Mbs0B0vOT5u7ToT2S8bA4GVjd6xg5e+rpsPD/TNGNanQi39u0JauF7BTSgCd?=
 =?us-ascii?Q?9uEF7D9XvqqrIqlXyefooRqGWbPGhE4xBEqyiJ8ecgkxEDI+Hxljd1BRBL55?=
 =?us-ascii?Q?WSfwI/b1AKZB70+o3SWYlgMIhK4mt8tbhdnPPblpRYJ2++EHxTOMym9jfKll?=
 =?us-ascii?Q?W5qhBH/h7tpyUFC/ZhyvW+aZnnAUAtCVGFF/ewYYBnlf/uKJwLLM5yv5r+55?=
 =?us-ascii?Q?XaapCQEorp9hCx9eJwT5DZAS+1I+eroLSAPxUpYhEP38FToUkC6Oabe0wzf4?=
 =?us-ascii?Q?IDDTvkHOPHIcr/oELvVLbccRoQgDg17XqROzZercWbDVmbSPR231Hmk9DAtl?=
 =?us-ascii?Q?nYG4NA5DRngkf7kNNsCHlTFFNWvQsKqI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:54:08.7885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc48fc6-a8bd-42a3-7ede-08dccdcb5c5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6796

Unmask the upper DSCP bits when calling ip_route_output_key() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/netfilter/nf_dup_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 6cc5743c553a..f4aed0789d69 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -15,6 +15,7 @@
 #include <net/icmp.h>
 #include <net/ip.h>
 #include <net/route.h>
+#include <net/inet_dscp.h>
 #include <net/netfilter/ipv4/nf_dup_ipv4.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <net/netfilter/nf_conntrack.h>
@@ -32,7 +33,7 @@ static bool nf_dup_ipv4_route(struct net *net, struct sk_buff *skb,
 		fl4.flowi4_oif = oif;
 
 	fl4.daddr = gw->s_addr;
-	fl4.flowi4_tos = RT_TOS(iph->tos);
+	fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = FLOWI_FLAG_KNOWN_NH;
 	rt = ip_route_output_key(net, &fl4);
-- 
2.46.0


