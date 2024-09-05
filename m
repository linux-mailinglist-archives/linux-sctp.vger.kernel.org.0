Return-Path: <linux-sctp+bounces-232-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462496E058
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288CC1C23F14
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4021A3026;
	Thu,  5 Sep 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IoL92wEt"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110D19FA7B;
	Thu,  5 Sep 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555227; cv=fail; b=GczxZ1cR1Ufn4aS0LZy8Cncpe8X1h6u8MnE0jxSxwOopX8tHy1T522Vv8sZdAoNjajbSpsEtkpq2Kge8CLL9Twd9uA3++maY/8hg4L73PGj6bLJcpxuL/wNkub/vs24vWDxExZEwREotzUO6A8J6+BuoCositsxy3F7eFCmapag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555227; c=relaxed/simple;
	bh=v2hI4qYUxX1FaDEygs3k3UoKkG1n2O4w4Qjx2zWE3qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e91WAj0HlUPcEgG+xWoeiJnTS8o7sQHL05Y8DbEoRXXswETvNQrRqtsT1lszq7kqWD2cAGreO4ylfw/n35dlcJyaq5Yzn/XrAQCGxOKp58gRDntZVW6eMljsp7xaYT9ZHTKiplfwFARYDbSKeqH6QAMaeAyiitZGvvS1/otXEzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IoL92wEt; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCy4j4HOcWhsxWJUXD4+EbeMMV/RwQxuI4sMdZQANK0BXPPixRMFqdcdKOsbIAD30dT1iEsiHdr/VOSp8H2zcplhABdF7hy15Mnu/JUMtF3dhU6BoY5IJYYsh0P/uaYEZvGjhXq9yOEAw7p9AIKKgciyuY08qb6yaCVUc5q6h6jyL7MjwsYs3xPsf/2r0TOSTjZ0oLgDozvTELs0Xavzz8LHz+Ny8j2vfuZcMb9nLZDtVBQLLlC40XybV4kyXmFFCfZwpPJPKnVoZpIetO5m+O/T1tdf8yOntffv5nC/1N4Jt3WIupoPSA0M8InGZCRlaDSginQLmVYG+WrC3V0X2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8usJFygsNES1ec5uqJ644YVwThc/z/TcvpZKA0++d8=;
 b=sJ/W3F8QsKSmoGPUYA2v6wkZTiBs+sKFB7UssIxGi/SNZu0s34YRhhIXoSd2/SlUb73rN/xCbTK1lFzpfbAY24X3AuEkWRxyXkRHS4qfXSiwZgKswEOMmIvO6wEWr/V2zaBcjqJiYKgDGGMVrhyjmiP6xVK6CarohiqRm+SjRoY/Pzw+HkRNvFd6Sl6grAuV+7CPIJxRriFV8Cl90jS85bKIar6ZL24Oz89TmA4LyfvgAdpWlZ7A3FLJIxB/V2jMlVsu314BL4XZix+45JswBTPao0vZ5hpxYrFACvsp4igHm1QiXT0NO05oIXsN5/ljQFbPW5NtghrtBD+k2PzplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8usJFygsNES1ec5uqJ644YVwThc/z/TcvpZKA0++d8=;
 b=IoL92wEtDpOJV5N53p5Z/1qsjWkDL7zqn/Uz3nVA1bCl2occnQhV9r6kpqNsBixh6mPxitOuTkEVbG9sW3bG86n7TDRVY2OC2X3gQbI+V5xXlDYcdARppcOq5i4Cl1GvuVDtKHujZjNv09mTFDh8h10lH4uXPDqCy479AbFNdisfu3YNdyMEGPP5+vcV9Jzu1lSCrNsfakex5IWPxqBlcsSMtVNgOrgnrkz78VrPa8WT37e1BZ3hYpXHJxRNsT4uqmjOz2i1VFdGhKqG6w0AtptZ8G/AXvPiazhj+apP4mWlzflruXj/yyiAk0R8FUzarterl/5QIiCU9XWOL3bNFQ==
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:53:42 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::ab) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:29 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:22 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 06/12] ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
Date: Thu, 5 Sep 2024 19:51:34 +0300
Message-ID: <20240905165140.3105140-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 809fda69-0546-47a4-717f-08dccdcb4c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Y46brMqadYb1o0jyWhfHs0jPHfhiqdCNkTCJoxOvF42tOxZ66OFVZEsSG4o?=
 =?us-ascii?Q?yAgSL52wGLD4CtIrEmNLpbWcYR6hBV9vfKDU+AlFjIOizjQnwGwFhcxTqsQQ?=
 =?us-ascii?Q?MmQ7A8UmpI+hHR02cUwdHfNi21zHl9deT9678GXBayJfKGSGVo7B+NUfyO3s?=
 =?us-ascii?Q?rHap/kr4tOdeyDocQeW1Lpmez7NKdhx3xqObRYBJC6SNX30PLfcfZbnZdnQV?=
 =?us-ascii?Q?0/Nm05DQ4xMksE1SvEIa3upGxHJ6S7pNQj2eF++nmd0s8kF7hwUP52iqMacM?=
 =?us-ascii?Q?0eMEFHUM8O3+BGXYT306xkClAP4mYLUDUGuz/v4Yc7WgVOc0a0wVtiyrgTuR?=
 =?us-ascii?Q?rwFBUAADzIS21DU8g04/7RsekiPGO+7t4mnatVssX/LTyFil2YccP1hYnaWO?=
 =?us-ascii?Q?5H1VJCySbQ7m0cuCCPt/tljDhT8dbxecitDpLCKYejBOCsQ2NUTMeTJvPIYc?=
 =?us-ascii?Q?qw6WgPIXBykgjwOnw5sV6RcMXxyFslYfacU0J0AV1hMyzaau9EFybzBXTSGB?=
 =?us-ascii?Q?fPZT4FdMvP7NW8PiiD/a9MJ4H1rjWHiuSFvdhtkpnt+HXeG4Q/SfFlGZr8xz?=
 =?us-ascii?Q?RwhC6DSI8szWYsPZ7TSwykfnRQrRn4S3M5FNoZ2vOysdGUVNKFEuqETQyidA?=
 =?us-ascii?Q?gXQZArxZEdgVSZjP2LcqJI65vt8UxG7yxzeqpXQIF2XpVyPyOBBagnhgxR8+?=
 =?us-ascii?Q?PxZ65JFQQp3/8Y7kR4pFOOvtvBEqaRITXj6yRn5kvF8OyJ+4NCG+bOQ2Nfzz?=
 =?us-ascii?Q?Xoc8ycelTfSzR8Mp5DyMoCLX4GwzFUw7HASlS2zfe+tQEiIZrltqaF6Am2rP?=
 =?us-ascii?Q?47PRoWq7rmcxgX51rD6dUoNNQUWUvr+QYzx4+BbZjg82Dslks3sn2xJJ6y0U?=
 =?us-ascii?Q?AHzNL9V6V1x0fieWC13O082vxyLS+hyeeUkZ+DTI783igQ1Nsc0RLyp/1enU?=
 =?us-ascii?Q?lGctZrp6S1cu/Ysbaw22ORR0ta6tHDggXY+UrXOn5fddwPlZVHhK+bFueMLt?=
 =?us-ascii?Q?Qe1/b7ZTtRzw3U9GzPQTCoHJG0Ld9/+x4McfPjJzit33unVTXBpOA/S9STBe?=
 =?us-ascii?Q?hXHdWafia2vcVbJIrlRsU6Zzn/vdG+PQ5IyuB/+RV5c700ujegyYhsCL9A2a?=
 =?us-ascii?Q?kGEhKdMZgsZboCMWDT2slaykgVhdPjS6BJvdFcJ2GmAil9elUrtgrHPC/iKM?=
 =?us-ascii?Q?VqqBu/j/JzbsrE+ZnGbxQVtQTINfQ9WyRJLgf/CN8k62LRBHqVyYSohJCYKj?=
 =?us-ascii?Q?mi/9rVtwap9TUOQrM3UbeGwGiCZ3iKBWR8dnkmEHDTV1hvdtGsyKNrXKlU0d?=
 =?us-ascii?Q?rdGpQGqBfavANOnxvojutK42SSte9hx1TjjiMVX8iL7qiToNrG+cgMPIKoQ8?=
 =?us-ascii?Q?NhGH+JsAIjzUc/zz1+FamDX+v4qe6OPJ6zIcZeJ18naONk2uK7mbzkG+ryoH?=
 =?us-ascii?Q?gM0DOp761kRt2U+ni/dMEox+0TOsfytY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:42.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 809fda69-0546-47a4-717f-08dccdcb4c8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988

Unmask the upper DSCP bits when initializing an IPv4 flow key via
ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
in the future we could perform the FIB lookup according to the full DSCP
value.

Note that the 'tos' variable includes the full DS field. Either the one
specified via the tunnel key or the one inherited from the inner packet.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_tunnel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index b632c128ecb7..09e0effcd034 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -43,6 +43,7 @@
 #include <net/rtnetlink.h>
 #include <net/udp.h>
 #include <net/dst_metadata.h>
+#include <net/inet_dscp.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
@@ -609,9 +610,9 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			tos = ipv6_get_dsfield((const struct ipv6hdr *)inner_iph);
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
-			    tunnel_id_to_key32(key->tun_id), RT_TOS(tos),
-			    dev_net(dev), 0, skb->mark, skb_get_hash(skb),
-			    key->flow_flags);
+			    tunnel_id_to_key32(key->tun_id),
+			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
 		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
-- 
2.46.0


