Return-Path: <linux-sctp+bounces-238-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870B96E079
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 774EFB2389F
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78661A2853;
	Thu,  5 Sep 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HdlfeyLm"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701671A0BC4;
	Thu,  5 Sep 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555271; cv=fail; b=kdUWySl0m3ZWYTMVab9bGmyXkYzVDKWGmDVEeakeJOgHevdxwlgy7wwMd5uboc+p6QGhTupCWn4CenSfRotDF3yy5pxK6zP+HwNugLlP3ud/+vkLbDRQr60ID7FoyutLh1o12LWzf3LoblQZPFuaRaIIeq+XCFMIXHROypSxMcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555271; c=relaxed/simple;
	bh=QBXTvurjCgE0OVMvar9CMynCY/AONwcSr7kICORKzuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/2U955SyoPREOZyiuT6+z8SlICaetB+dhA6jqjZ7LcMd3KJOmIhk4SNJpLxGT3rk37FygQTAIDYVbvWFsYEtUbdfgJC2OkTczBg2xgFG6uWUEA8mdoW5MxMxAGVEndFbtPIJI1Pq1XfqAeRSsSTWsXm87fkJpX0d23nwcH88UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HdlfeyLm; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7NncgJeLDWcF54q/7gZcaE37VSnccKHK9LRPFovI+qXLnPd2UBvC+uXXcN/Y6xU3Eok5o/CbStO3CMXCTYed/rTcxM7GjPkrGC4iK/f0ffRerCcL3UN9rUJ84PwKv7SVK8m3DNZ/oSmXtT6T+47BIDePwAnDfTxqAguTdrY2/oBVDBEiYMSQ3gIB+BWfShwCr8aY0o5V8/Oy794OC71BOsL//1gJ7WOVmU7KBglJsxDDjlpjTfed9rNY6tio9XGySZbzaUzSajwJ/rxqHVzZNpYJ6PSoCax8cm7qk2W/HfljFUt/GIX3g7z1YPZ1F7ftGk3MS5VEhFpo33lUaLpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlW6D5jbBGzf9gtdxA6b93Ji9LzG1FR8AAebl2Ncboc=;
 b=fzxrSZnfzwJ4Ch7QPma63oOv8Zu/t8J2KCH45wxENyjDdYUf2i3aVBKQE9biTGqS0zZKvCGd6x765hPxqSDlFMCsk4gsj+WnBipUD1Sq3snNrn/UKuB0zMr2ff99xEgj0bnjAf6wdihVGhMal0QHnI2wNf2XeECQYPYOZcsxAarpJW249ngiiXFOSQdTwIfcOYzm2p7oRNo/B0xcAczNYqGSEx7XH92Nwnp2F/bpkUNYjqswYRwUuz4jOGtx2mx1JwgqjEdZv0xJ+Y++aXv4KKeO8xGMlDX/OMG3ug4wWNzyN0HXfbehZNZPLzfIocq44VkY7shGmaleEJdNCC2Xdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlW6D5jbBGzf9gtdxA6b93Ji9LzG1FR8AAebl2Ncboc=;
 b=HdlfeyLmFptWi37ZPhoj8sh4vOVieU1PomdwubJnNty/SctICgOkbobgCFarwmT6cdSG+yDB3JHOGD7m9ciVO3OWG9bnXp/vS18MFbh2a6NFNLWZgajFbitha7smQ80/3sd0kokn7HfHtAicDpU6rMQYYJXKmETwjqYQ7Z7kDTQXMv7i7PajyRfV7L+D1oRaoevn9THASvN0nrmBXnO3lXxp7IvRCCHhqlHiqBkk1zmMOiAadYPMCnERZjRgfTILa+T18uU/7GF+O18omPgIGHbiydHXNt4dIdyypKYrhBywzsbx8K1yofytJEh2aUulT+00/wzD/2qwBeJ8mgEbrw==
Received: from MN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:530::35)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 16:54:26 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::53) by MN0PR02CA0017.outlook.office365.com
 (2603:10b6:208:530::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 16:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:54:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:54:10 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:54:03 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 12/12] sctp: Unmask upper DSCP bits in sctp_v4_get_dst()
Date: Thu, 5 Sep 2024 19:51:40 +0300
Message-ID: <20240905165140.3105140-13-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f86aa5-fcf6-4ffe-d4a6-08dccdcb6681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cw6XHcrnZRbE3TMYzot8moeE3Dm3skmwarZgxBmAyeDnTpDsdQzaoU838c+J?=
 =?us-ascii?Q?CAMKV3QIu25AiwE2xHj+lK3dHU4ilmGuATfYIggikTvRzcMYRbbVBR0FHOxU?=
 =?us-ascii?Q?fZ+dwxEtGkZVIUPsgJXn/jlmBIhR8Pn9LpKw0Ggoe6QxgQXBCZh465qQoPSq?=
 =?us-ascii?Q?ATYddjEQkleNzbqgk49Xs0tzpPRQQlyEWQdnPU5Kli+4qV0z4YGyg8NxG4wO?=
 =?us-ascii?Q?+dUyR4hBOfKKTy33a1SFWdtd8qLyHTT9tNMrh1YNNkkDG3YsJNY1/Z15AkeK?=
 =?us-ascii?Q?WB0rEDgUfDfO4EOkIvR2VvHhUgPon/hPuzBpilBjb5poSFVp5ynoJGGeFnD/?=
 =?us-ascii?Q?yDH5p2+TihCPvfkTtRQZxHwNuM5jd0AmjdM8iqNSEAQmwqev8vieG7iAw0Ok?=
 =?us-ascii?Q?sOXPqt/S50xT23E4ddQsy3VePWv+eOH8JLhG+NlNy4sr27soqI5zbgQyCa9R?=
 =?us-ascii?Q?0xsFmDfHKXwlJcuSTx6dB5eRJUhIFRvfu9zYbEvKkAvJmptw7UZ7uEbajqx5?=
 =?us-ascii?Q?aPqqjeL7Q9UWAq98slPRdhRSponEtHipJeptQNkrlkAoLx8QUBrO9pslLMIN?=
 =?us-ascii?Q?FgWqIOdMnOZs2I+VZh5u7noy3HDaU6gRM+fxUNvy/56nVbWxGh6vFAEikANY?=
 =?us-ascii?Q?Y0GYfjSjiY8pSih3zdR9BgAYuUTUZH0/ZVzJ15tAKI6bQVP4loTBtbzIbF8r?=
 =?us-ascii?Q?5A//4khZU9S+BXTiUdBBeIhxt5UGn3UxP6c62e0bS0TnJH6J+G9+0zDnZ/2Y?=
 =?us-ascii?Q?xCELXGlLmmhQsKDBNms1FWHNYl7Mrm4JiVXAyGWjeD10mit1N+2iZAD6W0jM?=
 =?us-ascii?Q?24L3LZRLBgyMfLOp8otmvKQaWccKPWNiCNDISS1loulBotxQGVIeURfEhf68?=
 =?us-ascii?Q?qBtR5ts4jJOJ+FEypBqR5Pb30Qb92GjJ4meA321IQl0NpkuKCyEAE0AQhH7V?=
 =?us-ascii?Q?91pohJorAbiN7TxS+5efbaRASejjuvbi4MhahYfH7VHaDxngv0NDFqjAVqvI?=
 =?us-ascii?Q?lrFhp0IZUmXs0eSoXb/ZnA7EhYWjOtlhqP6fxOvg1YUDbwmfwVIKAKgRSrDb?=
 =?us-ascii?Q?rIndQtGn2PO/SpzvnAkNVYDLCfrJV/U1FA1bmQ+oIWsven+0oPy1jz3/ycqw?=
 =?us-ascii?Q?m1m7IciLcVUqD+6Z7Mjr1Lyi2xIERSMqKUFR5Y2xSUmAPq+pVQsXNWVmQ5tc?=
 =?us-ascii?Q?JmSfBWEblMhqZVZGTLyyK0Ls81wBTWaUnJ37zlFu0RIpqZF9G/8japVA5hx4?=
 =?us-ascii?Q?9syDmIADEz1bJw552D+kg1IMA7+YwZX/0x3ArsI1M0ReBWoZQFOkEb3aYy56?=
 =?us-ascii?Q?7zGzB1Z1V1ay+UG4zmQi4GbfZVneo+5qNVKXUZu/KIuFbSf4dfbSf8Ga/+LV?=
 =?us-ascii?Q?o48Rfizd84YM6FCAGoE9OZzySDTocGAVLWLmpApnKXUGMwtH+mpIIaquSujd?=
 =?us-ascii?Q?6y6hGJbko4U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:54:25.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f86aa5-fcf6-4ffe-d4a6-08dccdcb6681
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

Unmask the upper DSCP bits when calling ip_route_output_key() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Note that the 'tos' variable holds the full DS field.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/sctp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 5a7436a13b74..39ca5403d4d7 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -44,6 +44,7 @@
 #include <net/inet_common.h>
 #include <net/inet_ecn.h>
 #include <net/udp_tunnel.h>
+#include <net/inet_dscp.h>
 
 #define MAX_SCTP_PORT_HASH_ENTRIES (64 * 1024)
 
@@ -435,7 +436,7 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	fl4->fl4_dport = daddr->v4.sin_port;
 	fl4->flowi4_proto = IPPROTO_SCTP;
 	if (asoc) {
-		fl4->flowi4_tos = RT_TOS(tos);
+		fl4->flowi4_tos = tos & INET_DSCP_MASK;
 		fl4->flowi4_scope = ip_sock_rt_scope(asoc->base.sk);
 		fl4->flowi4_oif = asoc->base.sk->sk_bound_dev_if;
 		fl4->fl4_sport = htons(asoc->base.bind_addr.port);
-- 
2.46.0


