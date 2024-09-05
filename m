Return-Path: <linux-sctp+bounces-229-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD296E04D
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1DD1F2576D
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C21A08A9;
	Thu,  5 Sep 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utvxE/7/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787F19C578;
	Thu,  5 Sep 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555210; cv=fail; b=YrElOXIygj4xF8UWLmCzIstdf4WAZXpeLp/1EjXIibud2UTaorNfjhWFITAJH3lvM+Dvk6LF8/MKx+NBs6zQsqheZEW0qz4qYQectdi6y5xOZic5l6dl//NRFBj8prG6d+AMmec4NVD8WY7phjZoRUoj4LCEnVGYronte/4gBGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555210; c=relaxed/simple;
	bh=cSrNHdHtlseE7Yn9X1eFH7bh6jE49Wd5WWlKBsgTIYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyC5p0CkkKFMX5zX5aZsE7GdIam0qvK29tCnGX6SJ3qNIfXDHq3lzzvrjCzFPcNy4LrFPonD6inQBS0ik0eLUCVwGTCgIpNoWfm3WyGn9S9VU/LkpHIZB1gkN9Rx/L1brwlcLR53aP6Jazkf05cd4rVNyG8Z0psNnA5V4tZHz9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utvxE/7/; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0FfI8wQUL/ORuJVqlgzyEFTTuPnbT/3mbC7xX3RcRAy8fTT2+WIxdhaGYNnptTC0JxY7PHjQ09+5KYwozaTDo2x5TwuSVB3kLKlSFwJfbsIf9tKBlmGMEDt9xPd1IWbnxcDIXzA7VzxeCH4RNW0jp+IOTbGote3A+byG6LepMM51GGlgjZse218qzFxc14XtWTJmTCCfEJTliYGDnBo9rWgImJkS6FSEQTL8LdOWXy4JYNQf8OQglowl2srCHNL9eCFWDneEI/Deq1MkivXoO2eMCTuHdhYYhVGFrMToyCh5llhT7AeZdfxf6JycdedGGqSw8z17GgEkEIjVSE72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRMb+eB8y0wfaJODOjXOhQGzOrBnV64b9vMyAWLYuR0=;
 b=X5i+JLw0PTyyP6g3I6GTbALbpQ1cAJFecDNs1HOo1aAzb3ycVx9C7/V4rASXvIz/2rFpdtbi7bfO6Y6TxEtt68OsGOl+7xOnNO3cuXClOcMptWw8hJ6g4JOe2Oko+X7S8k3MYjWMMIONT7mrvaVkKHJvqwmkaC5BlnSSWuIKM0wxdkxXvbgKDXjWRUlccphwwN27j7LaTBk2m0R8+rgm+eiufCHLgu+ZaqhPWPjcIjbJeVBT5I14wxyy2NRsYFYBmSHGJsPK8uWJtQ26UuURPBw/EHxbHwMQz6G8EYN+jCZflzgpusCebAl6pYQoeZJd+pxF8puSzgVK/cVr5oH92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRMb+eB8y0wfaJODOjXOhQGzOrBnV64b9vMyAWLYuR0=;
 b=utvxE/7/mIlGHArpQv7FEmRFpV7POInaumguGJeju6sgN83XshgtZ/UOB5ONWQEt+/9UWp6U+urERPhtZ0c2J4bGh7p/SI2TV4hc1tFbPfmN8H6IUnCyCSE6ThUl9k5wz7sTmjwBg7DDSiYwNatVN7VqmrEUajtcZouaS3KRGqnJeSiaMt/OfLu9wNPkbI/x6HuTuIFeyCJ6JEOq0HTpgDTMhv2oCkHPclSYEeXGUaYAN1IvvnMaKyC1UnTp8XRHtSRVPp0BHIfSx4aEWObMLNz7hA5bDLmRrt/FYPCTZP3uqegNqC6RQ3eWCc9a/nwZ1/zYTq4Dl0RhRn2CUiYrfw==
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:53:24 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::a2) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:07 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:00 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 03/12] bpf: lwtunnel: Unmask upper DSCP bits in bpf_lwt_xmit_reroute()
Date: Thu, 5 Sep 2024 19:51:31 +0300
Message-ID: <20240905165140.3105140-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: abd9a2e7-b96e-4d7b-f5c0-08dccdcb4158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLMwk3OH0Owe7TrgqlAPFRBkIHa+WQrIhDY8N5/MiAWPXuZI1xbLNSCdGfco?=
 =?us-ascii?Q?ZncbaGDv15Kq2h9Xi4U1FOSiwD8dUpQv1fqH53T0BvtmzgOVSyJoOq0StNC8?=
 =?us-ascii?Q?SKRmx5ETVd639QKK3gwpB4/eqYwjSc4Wt4Ueg/Jm8LmhpQ7Zfq+UFfE1kBEF?=
 =?us-ascii?Q?cC/lYMfNQ7gOcFM7qzC+0eQYqNlxPoohCoUAUqfdpakDpaxtxBj6AwObGq6B?=
 =?us-ascii?Q?BE1mWnX7FH8OpnYTgt3+d7uRsKuuv3lHsXpfjKuGWUCEIJ3Ipso1FHemx2kI?=
 =?us-ascii?Q?bXbq86c/soyIGx5Ck213mKapkZGQxtZO2CZ3pnz3TbW+CkVd4m0PmVfLCEJ9?=
 =?us-ascii?Q?ecJNPJXUJ8T+Gna3vcM93PTTAzgK1sNQ+AlfoipXXbrBAW0Z38Wej55VDDP3?=
 =?us-ascii?Q?crkE7VoBxdCW+KrrASWfEiPRFreYME/J4d7leYHyk9CbNy0fVgpvJVBYNjt3?=
 =?us-ascii?Q?PWEK2wkIEKfOw56RogEtBlvO8XF0zTr4IWWqsB7CekPb5UtC4GDV72IiX1W+?=
 =?us-ascii?Q?QjH26MLppLVgi+BZKhjrn52mXhv0AX+n/ICtfic1yRK4LIyK/Dx2hWaDZQK5?=
 =?us-ascii?Q?4eU0iT1VXkCGr9Hdyx1jrigEuzYWTHnTDgaD/fIAhgL6zblvqjP8w1x8zvuf?=
 =?us-ascii?Q?ZUngc4ewo9JgPj/5QdMRphp1XReDGuHG0a3Cw/0VisPrfzIbF16A7iRiM6n3?=
 =?us-ascii?Q?vtubcKfSXpZTYcdG3o5F1GhWZytu1vF1gFrh1jihbDYTBf9MIO3D+n/9SIlL?=
 =?us-ascii?Q?YUruqK5/RV4iGqJnOWYEXY8ID1Txwp+E/Uil13S0iEzDAxzsXZnq0G3wDM17?=
 =?us-ascii?Q?Nwd34zcWnlxNgBnW/9T8A5o8VnEONMc+cuwMs1HZiAjAvJ+XJnE5xJwoSw+0?=
 =?us-ascii?Q?4XK0VENx2V4Liz3M3KXYIxQb60+PpchlLWNqIW/hAIvDDw/Wh+ZGiil+VBBr?=
 =?us-ascii?Q?R7HXxWYbkfzXaaMyZOBGqLDaPxIvSYhoVlV7OfXc27P0IEDO2OWWTDtOOkzm?=
 =?us-ascii?Q?f62p5dWSIztnD3QXidPrzHWzte/T6SWrHaCWLmJkkidF0akS7+BIdHTEzXiz?=
 =?us-ascii?Q?RXUp1dGxJVc5oQn2SY9WxkRux5DvaH26wjtPfIjCtyUfqnuT2y7NKMaTGs1k?=
 =?us-ascii?Q?awfeMAWJmCIhQGrvadYUyHOPqtf9P3+CARvDFZlYxwnimGHQXlbq6ywqCS1z?=
 =?us-ascii?Q?ebJDH00hP4p7ywZgK4GtCzF/jMGfuj6Et/rj4P8r1GcYZNEoV38hLYQRqQYx?=
 =?us-ascii?Q?lQvUeHvAbPmT62uyleVEHSeup5OJ7Oi02RGqfb6gCEA7dNt8uQjyjRa/BQ26?=
 =?us-ascii?Q?51mgllIDHNbfjnmn48c1kDA+Fp8gLWOK5FAEwZSdzAQel5Mra71+oiS+/Z3I?=
 =?us-ascii?Q?2haXIojM3fSf0s/BrRTRvTuqlUbqKUY+lNYP2o8LOEpGTseH+v9Lmpuevrlb?=
 =?us-ascii?Q?oSO+6Qd/UWkUTvrgDb3cZMcztjr/Agze?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:23.6140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abd9a2e7-b96e-4d7b-f5c0-08dccdcb4158
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

Unmask the upper DSCP bits when calling ip_route_output_key() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/lwt_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index afb05f58b64c..1a14f915b7a4 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -12,6 +12,7 @@
 #include <net/gre.h>
 #include <net/ip6_route.h>
 #include <net/ipv6_stubs.h>
+#include <net/inet_dscp.h>
 
 struct bpf_lwt_prog {
 	struct bpf_prog *prog;
@@ -205,7 +206,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl4.flowi4_oif = oif;
 		fl4.flowi4_mark = skb->mark;
 		fl4.flowi4_uid = sock_net_uid(net, sk);
-		fl4.flowi4_tos = RT_TOS(iph->tos);
+		fl4.flowi4_tos = iph->tos & INET_DSCP_MASK;
 		fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		fl4.flowi4_proto = iph->protocol;
 		fl4.daddr = iph->daddr;
-- 
2.46.0


