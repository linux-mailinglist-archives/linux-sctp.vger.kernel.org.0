Return-Path: <linux-sctp+bounces-230-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FDA96E051
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EFEB21F57
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D11A0AF1;
	Thu,  5 Sep 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQwuq4Ul"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3031A08C6;
	Thu,  5 Sep 2024 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555216; cv=fail; b=k0iFaMOLbZkWuKE/5iRjS5FuQAb+fn3D+Huh4Hflq7gxXc5BGUOEuhZvZJ2/o2Ay9Li5/UAQuixpoE1B/txnQ5zsQ4EeP6fVK/KGOKtAF+tNxz3pVAVQULffshwjiXH3BZAnTQe9EvsugvSwovv4VzYt0SpKRQegJ+LRrhzMoC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555216; c=relaxed/simple;
	bh=10VfzemEXni6Lu4wwgFefyGgZoovD9nM03xAdksIzMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RioHonmiBEzSfPKCRkb6cTszWXANr+WcYdpMsN4zrN4qE2Gyv6704ZQBvKUm7CD0CRo9pFmWLNB0bJm3XfY4ffBsieIIBTUxF6E5Cz0euiombBjVet4qLreYrAeei8JOP0irOYnurA61kk17wIuOK/OTLPAKPtBb5L/yzS12hns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQwuq4Ul; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPICT5Fe+Yfz/UQFYEAkFM0dkY8L3JBDqOau4zzY3Wlz2YI4kHPjYnboLfXACmMI3yP/sTB8WpsG7VYOkZvd8jxZzTdDi9PPLj4Z5LkGCUsUkydrMCAP+/uzJJ0YKjsalc5Fk91rEc7PCBqdD6hHERDT0DjD2gqDVtd0OaBRCiGSoQm0l2Q61QITpjP9N4ubjrMoq/efGK6DWv3NDazv3jzONz+dcMfwxBa+SBOfd4c6KGtUScx2SkWDNubgOXTBxqLMmr7a0YKdoXnzB2IkpHvlfv/XqjjuBRFBnJCYjnA9LUF5qlZo5oMoM54gYDU7NCbmP2Om5QFXdaZFGF3x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG1K1yIEqj32PZ8N+v5bIctZRsy5NFoDTpYH7Pj7+ow=;
 b=RH3+2Ua7KYAPsJnR8oaDaO9jjZnm89CM24OJrUn7rlopVBGv15IJ3Tzp4Nj37ppej5GF38tvD9c1NNMQRwSO9zsw7FEy2Ijf0BEfTELDLFiHUYf0BnPFwyBg5himDbqi9n9WPHHvhMRH2JWJLhl7Wdn7xYZpjwfZLVZnFuQr7KU+CLzqjl1EB9ABJBRlFxc2QdjdhPntbfdEVqUmp3GvwT+jmdnt8VGs5r5oOHL85NXkSr9xsZX+Z93FnokUctCNOXCb0Zfbvut7hnj645kybSDQq3gGofK8XLNdVu/lyOZ95AsWyEsh1+GJ9ahlF6mEnd3NgAMyv3Wu/7mSZzgKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG1K1yIEqj32PZ8N+v5bIctZRsy5NFoDTpYH7Pj7+ow=;
 b=mQwuq4UlQxVXixHvw1n0VNbeJl13Q3qT7fa18PIVQbMofMqb2sz//gdxW54iAO5/Z+6R6H3ngk6E3vtOVulInpAJPTXRd33gmyQXsqAveT0H0bbvrFZ4J7g9BM2dwmKsYi26HPwsSKlQEilPITwxK4ycxdI45AR+ry3b3hgxrBKsM916jSZMUQShClOz80JPU2BmnuChIqj3WQ96/WczPBXAtxWV2LRG6vBE0FU3M0eUcbMSR19J/yRQEhLsvY5byCOdJ9/RFRNVxX9by1qhIpFII02y1TXND/pTqo9P3ILeVEVL5YWqydJfz6IDYfLD9wvBTbltFjC6wC89dJGBwA==
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 16:53:29 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::d1) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:14 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:07 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 04/12] ipv4: icmp: Unmask upper DSCP bits in icmp_reply()
Date: Thu, 5 Sep 2024 19:51:32 +0300
Message-ID: <20240905165140.3105140-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c05749-e054-4ea7-bffb-08dccdcb44f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QZ/18Gj7fIZ3AG6Kcy55NFgrNj8xj+ur3DwNNohvkRDN1lfDIU/NZ4Ty3ag?=
 =?us-ascii?Q?tVEFpWeHyjJxweKo9ihQD2aM8tUGdaKQ+QVLSzgeyTgxhcMKtd7zSlqDoNqO?=
 =?us-ascii?Q?HCqh/tnLVBxUIybCF6aWu3CATcQrafXNJfK+X9OICBXWBUbqu2UTOQnbtf0T?=
 =?us-ascii?Q?CQ2W6IgcesGWKfhhXj9PrHcalnwpLVyBIcY5jTp0SLxpsRD9lTjzEb4fKg6X?=
 =?us-ascii?Q?xJwrk35aMZI8SKO+KvQUnAiO4E9Ju12S9hWZiW1lNXsOlfpESBmc2YhZyo5m?=
 =?us-ascii?Q?1Vv9ACGnqXMl7Z+BrWpd+wkb8CO0NTI17S2IYGlIHtBWWIkbiVtLrZS2+542?=
 =?us-ascii?Q?8HKR48FvWUtTTyWYvGYv7p4XTbn7GVjt7xectHmWuaN8f/vwFNgOjDf7KYvT?=
 =?us-ascii?Q?XspLswEYf0oCCg5y8iTft3sXLFn0qBnmtZGcmCfgch2YgvpagadljEW7quc7?=
 =?us-ascii?Q?iEq3aqGwAl79veITV+MMXKO2KRfJTaDe8Bd8aO0r7bj0TluV6dzfgFlUjBhX?=
 =?us-ascii?Q?yj2drnUbzcsjm50jUkS8P4hQ1VhdXT5gWbu9X3dKaCwizb7E34HLoBZp4yB5?=
 =?us-ascii?Q?R2AOjQMAZmMs0UtiNmROfNx2QCrPcTCWnGU0XbiOPGJ1g2qxvBpiTIX0sw4H?=
 =?us-ascii?Q?wwKGUPzV8FRV6cSTznnymnpo7AA8xuR5kPY3O6ytFsC+8qR4HLWUY8Pjp9UG?=
 =?us-ascii?Q?XXYAPtPEqt0v7v7X0ubaINhDQUINvDeWc9+OExuPlnAe4vxPoOUvKOoThGIi?=
 =?us-ascii?Q?59b+f2xhfr6tj4KQxNVu4bcHrB3CPmJbRTwCweUFQ+tNzv3ZETRClMcstCEn?=
 =?us-ascii?Q?hS0f+7tT6Ptx4vAYYM9K4Gj/78MF1uPPar4aDavghELZqEhESiPbuGjVL0us?=
 =?us-ascii?Q?LFcPi5WyaABSiNsk9MgYuK7ZVEWKTvtw7s4bagMPmFjlDYSaToab8hfE2Id+?=
 =?us-ascii?Q?iZ8Hd7nTCSNxqy/Gt468CrDoRK9Ieop7nI2UKiZJCs/3Qq3Wixpw1WtBD9Xr?=
 =?us-ascii?Q?hUqAg1/cYhVrOtdJ8yRSqc+AuRQxvKzjfcJ9sLmSKLadlo4/tx4eL+piKbEE?=
 =?us-ascii?Q?JJmRK4Fk9JBxG4RMdbwQtL0iMmRNpIwc4aCtSXZCVpgc8O4Gg4KbKB/4knqu?=
 =?us-ascii?Q?OFjsUHgLWlXGuIGM0l4o21jM9SH1v34PHgw38MZVg3luWw7z/ul5G5L/qhN+?=
 =?us-ascii?Q?MAzoObO4uKQKDA7f1zkiglRXAt4ma7gzEQd3D8oxe0CyAaeetypitX7PPlL5?=
 =?us-ascii?Q?jMtYPSPWvWzPaMfoewet/2NvGb1SgUwPIEc63j3nSwfbl7W4v+8jG8UIKyiV?=
 =?us-ascii?Q?QfYiyIlDO08ST12QD0vM64DinJsXJ0WItWv3q3EXA+/LVaUamJ7FIDJpHu3F?=
 =?us-ascii?Q?8kiR01KmvbOr7jtB7hDD8FGqhbfcCuBFmSiyBOLkI7k9ag2v58maknCXiWn6?=
 =?us-ascii?Q?SUKY3tp8erhQK1LB30HOvMjJZCeBFGmg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:29.7256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c05749-e054-4ea7-bffb-08dccdcb44f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

Unmask the upper DSCP bits when calling ip_route_output_key() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/icmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index d2463b6e390e..e1384e7331d8 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -445,7 +445,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	fl4.saddr = saddr;
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = sock_net_uid(net, NULL);
-	fl4.flowi4_tos = RT_TOS(ip_hdr(skb)->tos);
+	fl4.flowi4_tos = ip_hdr(skb)->tos & INET_DSCP_MASK;
 	fl4.flowi4_proto = IPPROTO_ICMP;
 	fl4.flowi4_oif = l3mdev_master_ifindex(skb->dev);
 	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
-- 
2.46.0


