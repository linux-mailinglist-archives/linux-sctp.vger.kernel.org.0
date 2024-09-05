Return-Path: <linux-sctp+bounces-231-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B496E056
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A71F214A0
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5720A1A0B09;
	Thu,  5 Sep 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MGyrYbu3"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1F1A0731;
	Thu,  5 Sep 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555223; cv=fail; b=ansk5msLkwtwuZX1bI99vaJhKR9AEQ6EfXjvpF1TVErMPYxhcP2ZyXqAW667/Bir+22JnroKou/KzxKxSsx1F2dfk0rZOJACinFRnC5PIZhY6sHoAFAhMR5C6FLPU3vr8trcczCuSppqYOi22lAYaEt5SM4A8s17nyyq5qIusVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555223; c=relaxed/simple;
	bh=c43dXuOb83RTSDV55P5LoocBLzqtSKFlvO0emGQJCKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md+iwJN1fvTcDuFzRTt92PtC1sl/ME7nPbKlc97gUSoH1UY95tXFXAyfjoK/p/wyFB5SuAnrpY2mhjceCTLiGnsWR18CRjCY6+88FgkrYKkhxCD66EOPe6fgQT5t4XH40vmLP2shoILECse82vhjATw7sY/TMgD2LYWz2cu6Wv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MGyrYbu3; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqTNpNezA8cAmTky3iYwqzqKZOpYRzMNpQxdcX7mQSAYphU+pglSsa4ieEW4juUl9UiAmRJ9PA8OXFDfQilfJnVGl1NN5qNR9FRUdlKn3cEs12ssivxUb08svwYqxLIxkz2Xii6HhYdqh8wb5UM+rj0GeSbT/rfQTDFIAe+JOioMUEo3oBzoCOdArIswGRLeFWoJoIUrgvUPb/uNpFcbMDNmeQeC1WYywfMSZolsI0IdpAmQ4rXvdRZclHf4vlvolAw9G31IokjDCqrGK6Se+fZXajZ+7b7s4kYsAijsHPkZNyh1uVrBbJHtUM4tHT0UxE+iMXEheVzEB5/70Y73vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGT/0X7Y0NBOOg0EEtgOzcOygPeeKAMFDwuGVROjGhk=;
 b=PFS26jZDBMbku6V8HLPX2r32f+E3pp0pUyn0XO4h2emOLnbrPZJ7AoGhxtXC9H249abAMo4H5EGuintRi2tG/wk4pRWkh+kcN45euDrCH5XAkU4aN2WeBoVm2pDiCNC8bRfByTd9VhX7zEse+tXCtZVXWBIP7gRTHwcWQzxVs+jRZPwD0pgv5KWpsm4bc6OP2rVm7uZKYge1vO+p4/rZvryycsVOazj2XvZJ+pxfcPap15gaQM4gfyKFUFMfHOzP37gVtfE2UDQGAJ33AroXyGNWb27nDHaU7rkte3O3SVIa7AFlEa9TiMV0WCote6bitQLMe1Ljn8Ov3DAr2BGauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGT/0X7Y0NBOOg0EEtgOzcOygPeeKAMFDwuGVROjGhk=;
 b=MGyrYbu3wryaE9wle6/qxMUdvJ+rIaQ9cXY3SjU2ANrqkB/mEElm4wWmDAVg2Q5LPvVnzBVG/51EkwFaWpLaoJG5I3F5hx/9LeoIlFplTVBwtnVbJZMFNQqCCxEYnf6G89MEcC90uhcWA5Hu59NDAOUf6akXyHpjUTTqRz4qwvSpf8nWpei6uKhg5+RjFp4qoqDMlbkhupWoHQqVomxRG+rZ9wxIgafAFCgpeSm/xVHh4+vkh2bYM0lEmD0poyq3cQ7P2a3hYKA55F4ihVEiCKJda4ljZrVJE8sQEBbXpG85l2Qjx2q8bzxNhXsHQm4syAcqmAdGN0AKrS8UgzXHXQ==
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 16:53:38 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::e7) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:22 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:14 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
Date: Thu, 5 Sep 2024 19:51:33 +0300
Message-ID: <20240905165140.3105140-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e945d41-9f6e-449f-4332-08dccdcb4a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H8g4/aJ/AUIMYu9MJYrp/06Y5elrVKr2LIS7QSzs8SA5OnBtd9ZNTpXPvjT5?=
 =?us-ascii?Q?SLZ+kK12veLkUw6hx/gHruvLGBex7eJDuA3KJOvmGOY4X/A4RANqPtyAhlSI?=
 =?us-ascii?Q?2G70L+gTFJeT94SVi0sFuIKbdaSB5+9QczexdeTRL5SrV5B30WVqYU54XPOw?=
 =?us-ascii?Q?/KYrBtIYRomU8nhdeuSqRi6HXpRo+ytGJm4ghLUIUrn69SxdorhcpQnkmcUI?=
 =?us-ascii?Q?G/eE4bASdpx0i9doPEf0SZtqqc37SxOoYDTnJF2MV8PWAxXOnCBmuVgNWsLo?=
 =?us-ascii?Q?NV5bqUis1Ek5llPmZcqZMae9VBVQjUkiMcD/cZLaNUJSDW+qYVYfyA6jC0Jr?=
 =?us-ascii?Q?McGGQ2Vq0AsVRgDOYw+P+KcqDMEzxWKD4sEdGWgmHgzGEvtcqIJ/+Zy4p3im?=
 =?us-ascii?Q?dXS1WfuWWimYajPNt9YI0ew0M9L6HSgmVh3YWCADR+sWJOihTcmwtJMCyQVe?=
 =?us-ascii?Q?7vOVLQ/cVxYkjKQLeXt58cWZd/11rZ8j7hTKwMXVS70EPA51J6RfXvFDeDA/?=
 =?us-ascii?Q?nnfQOjIZQ1XQDcdmcmDrkkE31E9DonGsP9bKmLX/EDZRHHM+G8axy1v6phRk?=
 =?us-ascii?Q?WrJugvP6hxisFFUXlH8FNtBju+RPs+sXBY31Vngg/fKa/8piYRm6DuvB7ng7?=
 =?us-ascii?Q?fKL6q6wwDUK8oSGQWTIfaw15HtCcsr6TeCWvK7SLnWsZFfzsU8fnKByBfwB0?=
 =?us-ascii?Q?ufUEI5ROdPuey5CcwY7GZ1R1NBLGaUugsMHD6rSFoZ7oimB8NLWtQoo0t9ZU?=
 =?us-ascii?Q?f1foYs7ccOb76UF5YpkZ3O+7p+Dv3F+RWutAWldt7+rgUX3fYm/r47f0o9CA?=
 =?us-ascii?Q?8tS65ipYW3yOZnHhoz/5vsHJx7DcuCEh6D4H8kItIiKaHOBXVoa0fuU/3G99?=
 =?us-ascii?Q?IeQRMgmJB0xxjkAR4IP4d0b2NAxR4qoA3/B4gO7JsGmaYUOZ7PH3XILw9dOz?=
 =?us-ascii?Q?60bkfD395/LOReEB59omnsO2O8rOxgSfksuS/q84zFg94YESi8APMHtxMH1/?=
 =?us-ascii?Q?2AlTzyHQtL2yDYd2Wy/EcaI0H/s5YlltbWZwqAhdLbIYVqDcjxsxfKSP2oAJ?=
 =?us-ascii?Q?1gXeh0J0PqGFnxScLUkxTjtub08V1rVu1e+JJY5tziv7M1JkIx6yysmGVSQ+?=
 =?us-ascii?Q?Q9OfT+KCDGBFx3HD1iZ66d2SWKoV/0UHoH2Fdoo5l/VwKYds7RXTzG9jiRrC?=
 =?us-ascii?Q?konmXFfKbEkgQuD7sLYyz7CpEOZKqewiGiqCyFEjqcYAFzj+ZzGihhRuSptt?=
 =?us-ascii?Q?CY7pbN6wxUHficlDsK39LJVIgBPryjj1UlSdCldhFUfu10auPyuTyltbLNBC?=
 =?us-ascii?Q?WH4Hz8tXo/51VlYV4yUnN2wJHeFQame+P6x3hC+vbIdae0ieA5IS/7W1jGCP?=
 =?us-ascii?Q?1u5IMWLpe6n8vDDNgbKXFr7jIOM9rHyjMcxRr9sbqXfx+Q3D51cMF0bAmBqD?=
 =?us-ascii?Q?QvVdeDtAp7gdbZMyGoHfJAZTQxpIEI3o?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:38.4912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e945d41-9f6e-449f-4332-08dccdcb4a32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413

Unmask the upper DSCP bits when initializing an IPv4 flow key via
ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
in the future we could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 18964394d6bd..b632c128ecb7 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    RT_TOS(iph->tos), dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, dev_net(dev),
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
-- 
2.46.0


