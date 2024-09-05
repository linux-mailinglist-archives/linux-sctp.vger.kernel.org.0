Return-Path: <linux-sctp+bounces-233-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7AC96E060
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DAC28929A
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4611A3A9B;
	Thu,  5 Sep 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pvTI1+vD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F01A0719;
	Thu,  5 Sep 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555232; cv=fail; b=n8Ka0R0AFyePx1Nf1NyDrmU4gKNcvv8+yg04m/7ty25zTrShHT8B46UxqgdoyJXiGVKIm0w7Dyg2QEc2OdE+VgAJUt4CSufGVk/O0O+jaiTQYQtE2vnT5IR+J5s8tTd3PuLytb87GtvQOuoyxTGKH2fnTj0t7TuXcW9xNrDHae4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555232; c=relaxed/simple;
	bh=rhaTMcj710LpjcIgxqXFf1b5EbTypgnIgk46bddlvw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCKB15i7Tdw5eb7UDMYKQ5XKUT0Ek+RmJn+Jis7aj/M/+6J6qP7S4O8y1sJ+NO5M1K/PvDU7cj+VakuWik6hgwDO6BS6sXjxyqVXpCcssBWw7v1CVz6CIjjAt5DaokaAotUUKLOTkhH4rIvZ0wRqur1h9LACcwMRuQG0oXO3JB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pvTI1+vD; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUN6WGdO/fc5PnzS6IuhLfJAfvgAnHA3od6tcEOXOZEo7nP7jREbcbgET9zwS4z10BTK4A/zas7K0Wy8EuaSdAmRk4O7Sdun/z1rXZQz34fVNRyt4KwoQS4YrIhq7caBl+n/9r40RwnQyjefuTegPDwtNHTc1ddYNLCqN44SQ2jbWXKQA93Weo7UjfEeQTk6zpImjYcxXJSeWeKpbV8WqMk+FswUfq/OeGor0sF0SclfGkVTcdKX4O6CY3y/67S+SinDf3ZFIBprKix5S23s9WpjYhsyUW0oj/auHaiAGox6uB8jYWMjk58mSI1SDgEKdHHWWZ/4YtILxm7Xpx6xJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DWp6Hvk7r+d8v59uhCYjuBx1Ng2bV/VbEVP9jBbyEw=;
 b=F9q7e6AT6BVnllJvwcheiIQMAwyvAC/wRDEkrSIGG0lZiSXUwBon5az+TVQjvIi6mJrMDaekFU59vZ9K1Xklx1znuURCkbx3LTR0zJN8kW8JftvcQDeoTr7FQbvYH8mSNXTSJE5ytYSjkCbog5ACz8xmoK5BLx5UyvmHRCRi4yxkOkNkL82DDh4f7afoLNsM1EDHfCfA6kfmljl4MNGcLHrGQ7eT9eIhZFa7/tV4Hildqb7iXRk2jbsLoXVYl+NTyhqD1ZmCuKGecDlGFvGxwtAUgUKownEgWA/7svRASsvknQqvjpLXOo3CAWYVTJL3gPUhDRKIbTFYM15/wkFw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DWp6Hvk7r+d8v59uhCYjuBx1Ng2bV/VbEVP9jBbyEw=;
 b=pvTI1+vDMu0KQ870MlWvaxS0o2/gEK/2m3o5VQ2v779gB0DVyQJOd8Z9edGi5RBuRgOqU8H+AQkLTOBF1z2IouBUSc+dHq4VT2dvJUZYeTjylqus3dZ29v0683vsjLXl41iq5o6EYNv959u26k/frIc0QJx8ua4v9flMZ11gAjJ5tGzhniC9gszwSBuGD/ku7j8L15CtAB8DLVMlT9qjk0IRs+Lc22L4GERSFMbeGusM7DtyBhGAPa2QYqYcOot3s6dgfiinLdSbWCdPlkNhaVGVMjp8gpdDofCln7Xx3yXEySZbMCOAarpR306jvWZc2uU5TZwhtTJamW2Tn/TyFQ==
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:53:47 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::fc) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:35 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 07/12] ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()
Date: Thu, 5 Sep 2024 19:51:35 +0300
Message-ID: <20240905165140.3105140-8-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8ddfde-7a35-42ac-cfb9-08dccdcb4eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtbK0weEkxXtI/mFlkmEN1NpVXzFpR8XReFCpXsYXqJ+2E8hPqkFlFgISLXI?=
 =?us-ascii?Q?VMWw2b/PhM3FQ+LdpCKYa/qCvlC1t42i3hcCkGHa225/QU9Zyh1fqNWCh269?=
 =?us-ascii?Q?lmFGak0A7yBjbaFkTq33PL+n05lwYAP5LFU65PSuGgi4HGY3pHc0hnWFg6Ay?=
 =?us-ascii?Q?yhC40UHOmXcDwxThpMefQD5H+VcsExDjiChhURcmdGYzqbsl0w7Zb8svQ1gh?=
 =?us-ascii?Q?Ucg3c2dwU+aP05xY2k8wA594CP7gCPAiIMZDxGMm/XTeKnv7bNQAg87B+pBB?=
 =?us-ascii?Q?/jJGV7dNFqc6I05c5ARMK3rgy7PszOytiIvAkbU9p+fDr7Xtmvs+uubZTE8T?=
 =?us-ascii?Q?Nvx66J1hCFNNkSY2Il6cTLocIDL0hFn16om6L7QLaSn3pSa4U2GAppNA65by?=
 =?us-ascii?Q?l6nimMYhN1B4moJm7xqMQgN9uwX9XFOSlQDYkt/2+/ZDIWZ9mNdFCfkKiEVG?=
 =?us-ascii?Q?6V0q8jigt5d9qktyZ339efhaiwOfurEoYdDx1agqukyCcQjJisr09Zbs0jOj?=
 =?us-ascii?Q?EzSjPfvVJzzfkDrs4w52FKiRxg1wPwIzVxpA+MUPowSLOIAiOJNaP7Tz7Am3?=
 =?us-ascii?Q?oA5rQeUaOpgo+q50S3ZmSxX4KP8/ZntmnHO3r/dcfkeYkoqNC0oWsev03lex?=
 =?us-ascii?Q?mPfTRy3cC63rBtdqNlWFUXY96+mnDdm6o68G8GBgbxeP7w4bp8jA3W3TyM72?=
 =?us-ascii?Q?/KIxe0QgqxnYqtOERKdYJ/IpDhbeBoLzzf47nnbIeIykss+KuDK+IfGFtoFr?=
 =?us-ascii?Q?HPtdqVS0uqGjfDk9Mu/QJoX90FXcZB7TmYHJmYUrcUZwmGnLND+lymTEOpE8?=
 =?us-ascii?Q?6DvA5CBUzg6pwhI8gfnkF+o0MiXkDlEGCZBUx2UV6eTQ1cgwORGrU+98vus0?=
 =?us-ascii?Q?RDOAvwyUpJQDaIRP1FOadGrZ2IxEOWDHMojQrBu3xKGgkBmB1wjcF9W5OoRL?=
 =?us-ascii?Q?w5W2K7NKbIAB1GcTYDr+qbGAZ+gfgx7Sew7h89oLwc92zFdGN337atruJf/G?=
 =?us-ascii?Q?+CeCWYjwkb+kOh+q6hl+VQqnGTo79Howd0m9UkK4bzLoj7JCYkLA2oX9SJ6L?=
 =?us-ascii?Q?YnyG74GUpdtrAoJFuw6MwzXvJH1/SfUhp8qqQqmU6RYZOqHyguv14lcoyFeG?=
 =?us-ascii?Q?mvseOuqGZrvlrHjQsM+ywqbhYBuZ0q6l5lw0Dn0hZSbVjafkeZWvEgXZ/jkh?=
 =?us-ascii?Q?T2Yx2Trz9WJ3zYMJkViNvI8VgUlsxe+/mCLYmRg19YKteyJRW+qD+FOYBKiP?=
 =?us-ascii?Q?xFMPXRm1onETotbS/ZxFr+iOd3ednsMkvK5nDhyC6tkaNs/acoRwooTEY3vf?=
 =?us-ascii?Q?DDvzmXw1LD86vWZR67ZyEf6nGQnFqLkGgBcvP4+ehUSJ38nOoBrIK6wjk2Qq?=
 =?us-ascii?Q?knzhdTYk+gcCf3/y9UDLMnLIgjxUEtqyKv8+epJl14XSRiUUeIedyEVowLS6?=
 =?us-ascii?Q?jSekoPiccO8RblkHpzeHmTaQt+oBP2PE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:46.0027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8ddfde-7a35-42ac-cfb9-08dccdcb4eae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428

Unmask the upper DSCP bits when initializing an IPv4 flow key via
ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
in the future we could perform the FIB lookup according to the full DSCP
value.

Note that the 'tos' variable includes the full DS field. Either the one
specified as part of the tunnel parameters or the one inherited from the
inner packet.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09e0effcd034..d591c73e2c0e 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -773,7 +773,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
-			    tunnel->parms.o_key, RT_TOS(tos),
+			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
 			    dev_net(dev), READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-- 
2.46.0


