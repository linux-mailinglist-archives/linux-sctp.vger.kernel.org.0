Return-Path: <linux-sctp+bounces-228-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B9696E045
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2449B1F2626C
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F42A1A08BA;
	Thu,  5 Sep 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pg+xNElT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBE19FA8E;
	Thu,  5 Sep 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555201; cv=fail; b=k8zooPhVXM2C0m0fZbpzf8YU0WVlcH9Vsyw1rBFPswgTm02KujmiiBqy0Bg32xmwloT5VsVwAwbOK/uEXc1Cqjlr3fyFc/BiLYEanzhUXq+Ih90oTtwO/NDM+Hb5XyaakAsQaO+cNUsZjc4twyPiMx3Dhd+AV1rA0z3vEAdbhYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555201; c=relaxed/simple;
	bh=ZdARP7gaQDFvqpaUePtGLCW1hiGJh1I8MU2922X0GLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZUoratTb6FcXN8Y/jmLDommaODCgZ9npd6vvfWZ9CJBw8ia8P8fPguZrTrywQX0rY4jhfQCRd8UjUF/jfxGNCOZgI3UJfdMiyB9ijltkdUuWDUEOspkCtdWMMGFD/Uw5VnhWnuJoI5x1qZ9MGlITzIoHjjNV3YyfXMuTxU9z4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pg+xNElT; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1rBipW0bblB3YhtHVqB7Tp24q3VFsisueuCnfJzlO8KZkdHJShY5IaDVT4YKpUa/fUnO4n2PZg/kE62cZlqALw7jcPHpm4/udhPEQ59qH/0c9etGnXUFygbKYy1R1EJ9jNCp0bE61lz5anuNsDl2BdfcjxgT72yVpQPSHmEagq6y5YmOkWvDNfCqqhicJtHVYg2Pb9a28mHmR4+jTMOW7AcFH92D2IQel4w8xpFUoaZ4wGnnyQQh4Lr5ZT69kVir7WTFJI+EKMmZCCzwq/9dbU4fzwrAh7A/HBdaoGB0BMhd6xDd642sQ3r7EkpFCY9dIo5V0exI6KBFYQbSJb9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OBg8ULCo6Q62CHnr9sZBhNDIPBr9FwsCZxGR+Ys3VI=;
 b=K5PMT7S18TqbjxPPtnEhUsIqGVECSk6a0f7KyZL8JSZ9Mo+YLTTUN/bsPQyX2dqCbvc21K1hWuxZCgdJpkM/u20WY/S95itBztnQtEgwWlYO9MhaPwmHJ6zopE3PT1BrWqlfAKxpj7WJsWykOT3marB8Ide8HoDNbUWanKp+JZC3iFF4Icc/7YOu7CJwhYJjmQwEdwBDC004M8U/CcyrMWVx9lN6OcYZDl/eKyk5plno5Jeqh4l2JVTCB8LZhAlAVSJ/qxjsDcYSGgOmUtBCpA7QPGLGjekhVq+3m+LMHhQyM1JNdy4rXrL76UYOC97WWiPk6fGpTIf+VxHv24JvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OBg8ULCo6Q62CHnr9sZBhNDIPBr9FwsCZxGR+Ys3VI=;
 b=pg+xNElT0NNbqik+49TuqZxT3JVUbrKJeS8nUUqdKuSnHCoqOqdlsczgmc3ruanavkei/fa/ieN7/UzYAX5/8sywl6hfdmOix49rv7JJkhm9TDv7JiNH4mKIuKS8riV2UGbcLnPNBhFTvuoVgdy5vzhoHj5XS/dPhCOq9dGwdvH0fzlErXp8TyvYBnyoIzgb1emuJgqz2DFLB7wZQj76SnW9ZStIrVaLshiv0a9Wb0PSgkg/tUSx7/0ME/5wSEEX77ZYiMuzZgJqKWDhc8Zyi/5dFQL1h5aQdHbH1EspGenEhCYNPFAH5sdUiyinnwVBldNmJ7OqV8ow118GDWo6vw==
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 16:53:14 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::2b) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:00 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:52:54 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 02/12] ipv4: ip_gre: Unmask upper DSCP bits in ipgre_open()
Date: Thu, 5 Sep 2024 19:51:30 +0300
Message-ID: <20240905165140.3105140-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c7052a-04ab-4af0-3b71-08dccdcb3b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zUY7z5QPvdNAWSOZBU8lEf52gJ+zI+Y5YbURJ8Trw1JPZO52yjrDXbUyCcX6?=
 =?us-ascii?Q?Jx/aeLb2/p6Lnc6vL7mnn7Bj+h9Gp+UgjKBUWNGWmbByRMx9NYyAcn5mIc7e?=
 =?us-ascii?Q?7LiJV7EED1J7YoKRCH0QhCtFwTITC201Trdd/Ia8EgBvX/Zq/O+BGr2UCFfz?=
 =?us-ascii?Q?kWH/3q2fUmdOe9Um3Jhcxqkd1vodTDcSy/mv8/Lsy70PHM09VZf4pi1Fe3kh?=
 =?us-ascii?Q?oD7yfiBhapR4BQeRRvrtrnDUkhi5zPcR8jhtgcPP0ULdPblRucwGdPVvWWkw?=
 =?us-ascii?Q?N3xxV0O0Vd+MWJUM9gYDU1KPWe9BMSCgt9KaThAt//WHgOeMTOXGdZiemjdE?=
 =?us-ascii?Q?jg4eLN1Nv3u2yQAm1ulvH27aFJ3ddRhK/eRKCMkWmOvizyCicyQxaUmh4HEs?=
 =?us-ascii?Q?UQkSmeZ4758qKonKsyJoDNffAVyWz7wJHTJZ+eB+JVLwVkMWUef5lvtYifBu?=
 =?us-ascii?Q?8hIo4kYMQGBsbwwwuYXNtiAlHeOhR83Msv4fFDkzCYCge57UeBZnZfosR9wq?=
 =?us-ascii?Q?d5GUEToJ/HQY5FH1mw3aRilSEe3ZHUgCCsW9Vi+ey0/CAt5wOUsl3CBZQWLw?=
 =?us-ascii?Q?w0k5rsOkYE6y4rKZjZpTLfgdqw3WaZJJtGW/SO5fUGnjjhfW6Fd80qZBx+nr?=
 =?us-ascii?Q?xW7OOkE2YneCNv7oCk5L/Daka8tLJ65gv2XS2tyL75S3WIZFzBN79EZ/NqQO?=
 =?us-ascii?Q?+ndTfYVfCPMPNcGUr23+oy5tGLfhQRgWrrUmpgALMQc99sIhOxc1uz6Qb37m?=
 =?us-ascii?Q?rCtM9p7dlKczaLKxcM7vF1eBzVEu4LKbYiI8ousk4smOjM8OxmWN89HGcqZi?=
 =?us-ascii?Q?56ldLosb/Zy23ROBuz0w79TbezVlSyr3POyix4yx1hJ3aQO4GPJm1Cascm1G?=
 =?us-ascii?Q?E2lxIEV2ZoW3OmEiJvzK9YTobLzx6rLN+ZE2Axhl/aCyJPRSSFj52MgmGBty?=
 =?us-ascii?Q?k2bUUREEouarmv+eKSmtcT60CsSTJZnG0Zb6TTwwPo3eyVda05vTMWMJTD7V?=
 =?us-ascii?Q?HWRP3zKxOAib8KGfEnknxSjQbtSCe1D8Q29DFWyGSNdnUZtDIiXKO480DJVq?=
 =?us-ascii?Q?W6aBJ5tuIcv6PwT6W1X+bXFjmSeuCNxr/mZd4F2NP/hU7E+Efeoit015FgV6?=
 =?us-ascii?Q?eRezzYOIqeb5kTx2JBEb8be+pHmDQtH3c2bQ8AEWFAg1r6EMo1zXAyZBTi4L?=
 =?us-ascii?Q?V0Z6bspa2vs/7C1EVVxqy3ZgKt80FWVETuwXQdnsNPyOL1AyYSrAqDO8QIHp?=
 =?us-ascii?Q?biz4S6zWv9pn1kR56AgudwktG5Hz8EUXNo08Ad4Pk457HMBOdSqZmlFlGuC6?=
 =?us-ascii?Q?UVUblI26bNgoAUSeXy9fQGufHjc/S50L6V9WWTlu2yxQ6Xc0nvtym41AFaMx?=
 =?us-ascii?Q?KzxTNop7SuH3La+VI1JUsq7hy4iju55pwvUO1PS2l7pArmCtUqnOweK8HGrp?=
 =?us-ascii?Q?K7cBbq5hJ0R3fKtghluKQylSPMNtnSNM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:13.8797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c7052a-04ab-4af0-3b71-08dccdcb3b89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175

Unmask the upper DSCP bits when calling ip_route_output_gre() so that in
the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ip_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index b54c41f3ae3c..5f6fd382af38 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -44,6 +44,7 @@
 #include <net/gre.h>
 #include <net/dst_metadata.h>
 #include <net/erspan.h>
+#include <net/inet_dscp.h>
 
 /*
    Problems & solutions
@@ -930,7 +931,7 @@ static int ipgre_open(struct net_device *dev)
 					 t->parms.iph.daddr,
 					 t->parms.iph.saddr,
 					 t->parms.o_key,
-					 RT_TOS(t->parms.iph.tos),
+					 t->parms.iph.tos & INET_DSCP_MASK,
 					 t->parms.link);
 		if (IS_ERR(rt))
 			return -EADDRNOTAVAIL;
-- 
2.46.0


