Return-Path: <linux-sctp+bounces-226-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80896E03B
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687F91F25B54
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA251A0709;
	Thu,  5 Sep 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XpKUHETi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16354C2FD;
	Thu,  5 Sep 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555193; cv=fail; b=r3IEYhvjhd54TqauOnx9dopOhNiho9zllJcxD7wv9rHVdGFglczC5B4lRAnbUUxpIPaPhPrcGmQEs/fgPcTGJ+ZDGDReBiMaxqWkOwcBnBgl0ueoHYwd57ab1nHI/oBJ54Y5yvljCqPhvGFdsDhf+OjOBVxl+mhAp46XgkcEibA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555193; c=relaxed/simple;
	bh=kiMlZ9RWtMuldHNRBCPRQqoOwU3hb+OtntrXXKysTZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYvBD+Wsep9TA1Cz7POSFeBjN5EDLASESQPc9y2YN7HEqOKKHtXcu5YKxmYSZZES3hsirSeUJxFWrnXmvHBclOct6uadnLH8LuzNpO/GKUmQg8autKPvYXPz1NVhcqLleCQ5YAe6RRbov13a6J5VNUX+AImxhfyqmgwEjVXqOX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XpKUHETi; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4b8IFAQH2hWv2x+yiwrZPWd3U97LudyzvT/NsoY2mJ0OjsugtoqWIHAjl4BJ/e8ZaIiBKzT5g+4x2aIJffIxTNdfU6DGFVXi2xH/nB5Cjs1MjYkifCrL5TbGk/+Iy1DYh7KdWyX2Dsm+EHtPhC6KnJvqciJJf98zEkLC6ScyWjtasjwASiDuufIp0pA/sfAvxULQL2VzPpfWXpCtTi4KGENreJtvwdxM2mu9JEGdy9j1LNLWFVtsWYsLf2LeQCpdlOwff1bWv/laglGFT9tzGLjh/D3rhkM9mVbvCFKelasDKWT13AKOGWE98EOFYfF535+Jt8r2UC9yi4bKjHtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFhicse2F72kK5uCVWDWiw4PUDLAgCSYTRYWXZDZDJo=;
 b=iJNudiiqU5b+5ja75xgZU9i59YG+Tulnt8whXwBGtTNjsJJwgVrzW3VFvbLnt0jYRMubnIJKIbubwOekHjHrnvZfirjlSPIDOTnWK3ze5TaN0k0m25Nb2lTX5tNHm1u+cwOR8/uRKAWMcIgSoE+SPkDjP7igZgjM/jUEKWbZ+6ZVpIkPtR7yMD5JiQiFPN7eMt1eQ/Lbmxw562EqtLjn2nWToygaHyRuQpop+FhkrS1zKPKR+ActxEXFvANWqnVtnkjFxXHd8Pkva4FnUW65MxENx5DjESschHUt8DSESpC0ll5lYWGYB4xYK2ZS/Txs5TLI3yMcQTxNvvY3DbCe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFhicse2F72kK5uCVWDWiw4PUDLAgCSYTRYWXZDZDJo=;
 b=XpKUHETiVKu7DJguKTSGrtyd/VbE76CaMl+cSCaAy2pKKbVFlMBmCjuxkwM9HnGAS6XXK0ZlAGXAmurCQb1FLGC0iCtrKPOJmPYbOJARdDX2Gbvo7isBtd+icsqJdQWSGhtMfQJpo+k0ixo/jx1uVKl9NcqnazSNNdq9DMkJBKVB8W7G3uGnQHzphoS0Jbr0IIkSZOjLqHsLSQ8kWdcI+BdEC/zS/FX6lPB+oGKdi/MgBaSDzPPOIDjf2f+JaWLgP2CgFaqdQ9mFDQLhFvejK/CBe/61QRKfn4t9v1WD8x22/bKsn9RWQiJ+OVmrDKJl/8ESDMwgN9P/EPoBVeQT7A==
Received: from CH0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:610:75::28)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:53:08 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::e1) by CH0PR04CA0113.outlook.office365.com
 (2603:10b6:610:75::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:52:53 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:52:47 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 01/12] netfilter: br_netfilter: Unmask upper DSCP bits in br_nf_pre_routing_finish()
Date: Thu, 5 Sep 2024 19:51:29 +0300
Message-ID: <20240905165140.3105140-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: e9827d8a-f80b-47a3-6a28-08dccdcb37d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8ClPmuaVKhHNfrKPc2Qa+aqbHhdvJK0Dq9Rxn/sPxVzEewAOYNW7gjNoSaw?=
 =?us-ascii?Q?/TS3DLe8t7mn3rvR+CJDCgmj5w6ppCpd+pqIRyCRET59HwqZdBEXOWFfNB8A?=
 =?us-ascii?Q?Fips5wEP7AK1ZNu66eDIAooZBPMa1Cj9TUVQVxPWjM/NyIeWPd1FHeoUtxQy?=
 =?us-ascii?Q?+5zK4BCbSWGtbUuyG2qBvNGyox/5mDPDpHGQ8K6sUgxplZGcUgw6HWaOpK+2?=
 =?us-ascii?Q?tvqBUK1qP51ai+8VWpak3ypkuxMwoaZpOrJ9XXStaT4xk1pvMERAxWquMhaP?=
 =?us-ascii?Q?dPNWmcLNJdeYJuo4Y402N0w4EXGzEdRagWhI1RSDEfKI8zlGl4vxvu4ffvBl?=
 =?us-ascii?Q?ec0fMIbU8n31WSX/lZjl0eZprO37Vqt6SEo149aH6Jj/B35E0dH/3l+s5j1N?=
 =?us-ascii?Q?pBS4nN3Q9EtcL/1yqixSeZ9UMdd7J/57DAlJne5cCA4IppF8n3N9/XWf5iH8?=
 =?us-ascii?Q?yAdYGzze616LDTCQvOKwF/qYgWQBkyXzrZnBIl1ztn55VV/rAvLw55xVKAAU?=
 =?us-ascii?Q?YUerfVbKF9ivS8W+RK+Ks8Ezzakj+2hqus6jcHnMhPxzO1sMpRChEbFU3Rm3?=
 =?us-ascii?Q?eJoAwl6MbFLrDasvgexU0LmVpVTxz/WssuntLYD4yh7VB0vH8SU2aB36vkAX?=
 =?us-ascii?Q?pxyyvGgStgnszZ0SjHfz/UzVogoxgKeOBF98IPAj0rDRHL+TQ8WzMzunRwBH?=
 =?us-ascii?Q?uLJqDDp/50GWdvrd83qe8vAlrUNzX+XIPxZC9MqfK5vWlopqrufJGyVJ4C/t?=
 =?us-ascii?Q?9sIka+/E97pTEr6V9fAbNu+Unt8yGNFXQsBGtCYQgNzONlIyZGMkSNfXkOvS?=
 =?us-ascii?Q?b+kBa5KciZedX7WlWrjB9oYe129knAPnKb6RlYngcVLCMnb0F41r4KyFRBWF?=
 =?us-ascii?Q?I7BLtGth5XhdhWf6WutBwuGp3uMeR5ocnVvqDLDacW8EHjWrWd3wE25xTyMF?=
 =?us-ascii?Q?DFacpJhgqZ+G8wRznNrlYt94QvDygASDsIVQqguCiq7pJU5ntmr/zBoxrSAu?=
 =?us-ascii?Q?vyh9aB4mUzVPvOgJQlo6PLi9Vb7B7zqLK/iOsLo5T16SJhlIl/3+9Mh0Ttlx?=
 =?us-ascii?Q?rV48yCd6WsIdIZ0wWi4f1CbX4nLat2TCpYrbP9EX+5rzbODD3zwCvUQQ+fJp?=
 =?us-ascii?Q?CGO87SfGaRR6tQOUvzVzEk4+NufERizAKbuJQU2zA1pgju5qYwVkZqE2NgFZ?=
 =?us-ascii?Q?DQ8baJo/OiGKMHZL3jY+k9x/xLxDVCoKU6ofE5F+tNJkQgC9M/Q0GB5O9W+R?=
 =?us-ascii?Q?Mul4ig0yF7/x4GYRSacL71KlcAnoxytQMllzc7HTFxrdfvvxASQ4gVzeAIPS?=
 =?us-ascii?Q?pIxL+tNA5NAZnR///AyvzaDRUkd1OGUE+nMI6dmLfqd5qISosJUu/tg8oL3k?=
 =?us-ascii?Q?kngVoA0NIcuFIHXbikkBJqVhegKo8TQHTy3/3cXjFylq5rvDeZOnQdgBzqXC?=
 =?us-ascii?Q?5Frpu+WPjb9A++6cQyhpRm9bRLXvoX5F?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:07.7059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9827d8a-f80b-47a3-6a28-08dccdcb37d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

Unmask upper DSCP bits when calling ip_route_output() so that in the
future it could perform the FIB lookup according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_netfilter_hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 8f9c19d992ac..0e8bc0ea6175 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -36,6 +36,7 @@
 #include <net/route.h>
 #include <net/netfilter/br_netfilter.h>
 #include <net/netns/generic.h>
+#include <net/inet_dscp.h>
 
 #include <linux/uaccess.h>
 #include "br_private.h"
@@ -402,7 +403,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
-					     RT_TOS(iph->tos), 0,
+					     iph->tos & INET_DSCP_MASK, 0,
 					     RT_SCOPE_UNIVERSE);
 			if (!IS_ERR(rt)) {
 				/* - Bridged-and-DNAT'ed traffic doesn't
-- 
2.46.0


