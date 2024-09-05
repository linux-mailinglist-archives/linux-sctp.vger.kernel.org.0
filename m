Return-Path: <linux-sctp+bounces-234-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A390F96E063
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA471C24A6F
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC71A256C;
	Thu,  5 Sep 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MPW00m8r"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FB1A073B;
	Thu,  5 Sep 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555245; cv=fail; b=KbQq64sSjaCAFMZJl+AtUH3Yk9LSudlFnCauhbenAEMi+/OClgi/oc0QB3UWNfrYrHQp0OUqnhKE1d5ivUWLVh0WSG5DXbx/t9hzBvgUG9chrLclf1vye88rEoFNrefQv8Y4/sVcjzFKJbqP3UlxAFugYOJw8NfE99os1+1SAnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555245; c=relaxed/simple;
	bh=VwYctOglwmFLNG9v5O6UKWkMuHV03hOUEfduGN25f/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMwwpltGFlvgUBhcRInIHgPhqyGRnvmUP/VYJbnkWVO32AWafGWIzeg4IAERkL93aTsiJfADX43jpJqa46jBGOSrRQeblkZvvoZkZAR36xWUQ4UgoAgKm4xLp5QKfCkyYsh3w2Tw1OUthwTwz6b5ym4CTFCS6Qh5QUFzjueUog0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MPW00m8r; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4zvUikUkSVNpM6eLuxY4CFx/yHxFG8LGxLQZeHTPoUPCCIzR4EzWkjCHyRKmobV4izCRuWVVTX/exDvbT+G3Ol4n8Qj4nWBkg2BO3wHiRkcdEwNTJKBVCf7knXfsyoLA7+CRwp//Iv+JuBD4SskHZCbA3I2MzWQVCfyKd1Rsya/pQfRH+dadto10BfT+4AOAG6mbdwxWqvvIPpnXLFcbXI3MxYpMdZRD/ZprqJ62hcnM9m8I/mqHsyBHin+6WkVqd3Aa4KenNc0kzithl7khnPR5s5MSKV2m3zo2n7kFsO1TnfQ7bxNKHQOwLfvDiUoKaKDlVFFbA786N3lxYwlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njjOpOpkG5eoLceLFWeINxDNWm9lX+aWBjHaOpMJGp8=;
 b=MmvAUi5gEyC08tPw+5cLbO4Ng7KYaG4uNUjtdjQt4t99HQXdmNv6+EGzkBDN6SKYZ/Vn+N0nTwv8Bbhocl7pd09eOhez+EFXRlcBdzKuYmW7I3sCJuBZkSHQwvW3LPWm1JQP8yzoQGBuWLkkaO1RpkXTxaTzfYWH6IEkmln47kS7dFCBJwkKmBBN6XoEbrtdot8IsflxX+DxxDKNWpUPMo8/UJKf4loZK8RmwIHShDIXLBaoTiLNSgMK0+sgpJtFnHm5LRS2VhKCPef+ScvFXwZQzWfDKAR4QIujJgzcxDKx2Y0IgqiliiSnsmkJjVd6Fbg4lkSuzGXn56nJVLduSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njjOpOpkG5eoLceLFWeINxDNWm9lX+aWBjHaOpMJGp8=;
 b=MPW00m8re6zSmsYnlJifv295/a07IgdqSNuVowzDtJVZp6pYN6MlN63+SSEkCyQ+I9dE2IjhOdiBZhWPO1F/na7hM/sKwOCy7zZj2pxU8LZoLNcqgej9WkgOudY0YAtphaINE7pdQYVE82I4Pt95WnXVTMLzGnhqI7fz8Vry+yncEsncou/1gd1MeuSR3dvFr3EufhCcF2WJIjaFIH0qJEQ1lfz3+xTg8eDTDgOM2TZx+yHumYhEIeMFEAsa+r+/Rd6rD5fZzBYfByx1N8ZhUci2Yr/VCQn0+IaZ8i4/Xb2m9euxwtCu/mgL2mAr03b5rpyAYCw2v2JU1jPcAbWsoA==
Received: from CH0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:610:cd::23)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 16:53:58 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::a7) by CH0PR03CA0108.outlook.office365.com
 (2603:10b6:610:cd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:43 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:36 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 08/12] ipv4: netfilter: Unmask upper DSCP bits in ip_route_me_harder()
Date: Thu, 5 Sep 2024 19:51:36 +0300
Message-ID: <20240905165140.3105140-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2a0998-5aac-4eb0-26a7-08dccdcb5641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTdhoi1PT3XG9bFS/uNGf0ykbBDm5IZ52N9MwS5JTseehkFiSkkRU8mc8Pdb?=
 =?us-ascii?Q?zXmB/ettvHbKtxKhwTt8lgWw6bPyZWnosZSPnZVtR7D1OYUKZzArbSugtK16?=
 =?us-ascii?Q?1c6WOkU9PGUBcZ2whKH7lKsBNTo3qOtxpToKEkh0seoflWhZzr20/ym6H4QP?=
 =?us-ascii?Q?840StFtYO7ICkehDo7j2symsThti+3CadwCuT09kAEu172LPZ8QvnWkYK1AX?=
 =?us-ascii?Q?Bmh6MNGQWL/Kj2O83APaZNikdLYpH+cYi5GCrz2cWZCWqReTSIQ5xv6Iw6sS?=
 =?us-ascii?Q?wrAktoKz6TvboNSQqEOo1YyHwYH3bETzvnv65bTUyGOnR0IuXK6LoiUjz45/?=
 =?us-ascii?Q?kDa30RoZgqfeBYiR1j32P24IW2IrzRpMhUKsGJq160CXZggeNdVkfnQjnEJK?=
 =?us-ascii?Q?mGw73En1x2ZCg8kmU3k2rIny419ZNVWMI/0tMva8xNeC/g3+xi0x0cDOsQLw?=
 =?us-ascii?Q?hYaG9wh0/TbbB+FNSDLINopjut4f5qmYj3sqa/zGMwyzWPQiaAQhRRXZE0Mv?=
 =?us-ascii?Q?ZGXAyKiYN9esxjn75tyzq9sl+GmJ6xnAHgsSQ+ajewT2kjXvCAN8bOuAMMFc?=
 =?us-ascii?Q?myTEGbvg4BK+l2GUDtfqd4zFHj+QVuPsdjVap+e/QCx6cWN8jZbpBnkZLkkq?=
 =?us-ascii?Q?VaJO01d7NNtYkshPPCzaqomcKrsxr9ybQuQlNDbBtagrgrenVVywM127FoH4?=
 =?us-ascii?Q?Rx5sC33mOfMlXBLwNFNY5wfLtcwU6sacg80usdV0FxGqgMgxAL9Yjez5rfc4?=
 =?us-ascii?Q?CxpTT6/QF2SMOAmnvqUG5riG9JZm9BdxDTaG0RJ/vsq+EWCF2t78lVucDUEY?=
 =?us-ascii?Q?bNFqG2q1nWsDbhOmpggpoF0W/oprLi8UG3CZtHm1DtjoZvu+z3deyktAAIbA?=
 =?us-ascii?Q?0uFBOSVAtMCURIHUpOAxKTS+Ug1ZSsDLOwXtBY13IfO06/DH4ePoJNJLjBva?=
 =?us-ascii?Q?as0sH4oV0JgdFnoZdzASYCcL8lHol+INxjn2FhHxjytR28BZvtmfUxoJFRsd?=
 =?us-ascii?Q?NTdOHxufrtLJ977MLOoS2lAERY8eFRQjCfZJ26zTmXEI1fpX9oqg5HU4/nAg?=
 =?us-ascii?Q?ukUrouzaH35/skm2FURT6HYSe8LaLXdfKkaWSB6Lln/VWI9fkEg6RJ0AzkcR?=
 =?us-ascii?Q?5gq0ststJI48XmIOjverz6qajlhkX/2oP+GMqZSqk29Dpe41RCgs61B34lEJ?=
 =?us-ascii?Q?vOgK9SGH+PyVoJ1oaOMo9bQ9EtZizLFPuOKR8f7PMU8JxtPyysj1c3ZtNp5W?=
 =?us-ascii?Q?6Sp+pu+8KXRrpKPcZb3i8uOFbnpZH48L1MUtmHPZpEMB/EvZMZpgJ6ZxD/1o?=
 =?us-ascii?Q?pTztojPLqtsuf53l/V7fts2o9eqL/C8rIm7etHGyNd1bQwslx8LDTKI5IRSy?=
 =?us-ascii?Q?IoSS1obpXCJwqBYtF2YRhhcUB5XfMJV27+PEnkfDyyxrVQ+iPb18cdDO6lwa?=
 =?us-ascii?Q?VCKbvJ1gPPmAAHE7V/eUCnDFNR7DPeKl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:58.7214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2a0998-5aac-4eb0-26a7-08dccdcb5641
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

Unmask the upper DSCP bits when calling ip_route_output_key() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/netfilter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index 591a2737808e..e0aab66cd925 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -14,6 +14,7 @@
 #include <net/route.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
+#include <net/inet_dscp.h>
 #include <net/netfilter/nf_queue.h>
 
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
@@ -43,7 +44,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 	 */
 	fl4.daddr = iph->daddr;
 	fl4.saddr = saddr;
-	fl4.flowi4_tos = RT_TOS(iph->tos);
+	fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
 	fl4.flowi4_oif = sk ? sk->sk_bound_dev_if : 0;
 	fl4.flowi4_l3mdev = l3mdev_master_ifindex(dev);
 	fl4.flowi4_mark = skb->mark;
-- 
2.46.0


