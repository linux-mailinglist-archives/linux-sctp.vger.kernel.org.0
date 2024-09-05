Return-Path: <linux-sctp+bounces-235-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861FB96E06A
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7192875CF
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527321A42DB;
	Thu,  5 Sep 2024 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mr8zwO5O"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2181A073B;
	Thu,  5 Sep 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555248; cv=fail; b=oCkWEIh8PgT+WFEhnsMUr7uD6vflJDRyxYls50AKvoTGxX3I9Qhw6TPYLl2ygYJ25wXDAxkDOaUoMCFZ0cy3PTDIF9g7a3kfha7Vku6kJDzekAuEVJw34JQOTvOOeU7JacvSPQG6PLRLJQH8Nlr2ewxnm+YhvMqoPhabtrgf3jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555248; c=relaxed/simple;
	bh=B7Zf5l2IYRlHjaXCYqXQEbwNa5e79x7bReIJc97zXYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0zgIGpHw2lkquPh62wE/XzZJXW7tC2ueN0dHU2YMUlp5Ua1SvT2ElP4tEl+XrqLju/pERyR/6QqUKhTnfoOusvwjWEkT6F2df3a3U5IS8fjcaxdWkYt68nzaRXT/Zfng44L0ZMqckDUlDoKJWXVAi8LMfPfKUOoGvhEAJslDCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mr8zwO5O; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F83MV97TZQ5bhfiQqPX4eCN5+m3aL10VVSaSahZDaO0Vgg9IlpjK0Cvfy8vB7doibbGtolL0DHdhoGQtf1jVHSXXSf2+Y6bsunt1w3ei1opqvdEa8P9nbt+sYL3hP3FdUMQmugNHk5wE/taai8m/6LQ9KMy/1WymrfSWBNSHEa9aWfNI8GG1d2sm17Hxi+RsYtzaOBCaVVNWK/j2shkYuGEHpyFpcH67+ScxDQrWCECzckv0GAgrUANa78UnX+Q+UwDdP/EyzawOLXU9qTPQjS/Z5H3VDgjOmB+Ng+euTnDQmB+1K4ve4QgOi576hg6/zz4y6eE7PohDaUbF7IHO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krMxDlktnnPk8S9qsZwUuIqIucu2zygBKdu5hpxol6A=;
 b=goFBmvO9T3L/yV5d9R1y+baaArRK/i0QoQXUDOcnWM4BkVrZWxRR5DFPJ+BpXQBrxKZ8/on4qjQlyF2YZ5fHaSL31CYz32ZI6PwP3UZEeJDbpqTHLuXimILaVbXACnj4k9ekrzFZeHa24NAejJnkIdjsPmspI7+9cOubKbdqHt3sKw4a6bdQCWHbsAVaPNbeL2AbeCFIbVZz09ScjdNKz3C6T12WKm/XdRpaEyka/kU5b7BtLaCG+jsSrtv54/PQembsKKIcoidLfdEBIxKjElUYXACPhxHK9PWT/9wxeujPhFyB9O/AzWGn++P3GUFR+7/KUckOuxa4EyGwwBKhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krMxDlktnnPk8S9qsZwUuIqIucu2zygBKdu5hpxol6A=;
 b=Mr8zwO5OZA8+eQWpG4bdynxKAvig/KWZz5gJsYRMKA0t+MoVWes2GzjxGCoP95oeoAC83Sf0Ol/Fvrn4YU93pZ/ydEypdtmChmy1v+PcU5b9KJGeY6vkihdBQ4LpEnr7klplNxsT3Nq3AzsNGhJ+VPct3Jfmn/mhInGTiR2Jdo7TBtvNW+zXLmeqH9veHkigKPe34ViRT8HowyYAA5xX9anZKE+eK9uSv1XnnsCMj7vmkq4A7utgWS/coPK/xe6gFxxqLd2oz4CZz+eG0uWAbZMv4Nu8dXl1R0un5L6SMqVU7VuH1EhkcNvyMq36p8F4euuqKh78YjxPSyEBLqmPoA==
Received: from CH2PR10CA0001.namprd10.prod.outlook.com (2603:10b6:610:4c::11)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 16:54:03 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::b0) by CH2PR10CA0001.outlook.office365.com
 (2603:10b6:610:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 16:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:54:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:49 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:53:43 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 09/12] netfilter: nft_flow_offload: Unmask upper DSCP bits in nft_flow_route()
Date: Thu, 5 Sep 2024 19:51:37 +0300
Message-ID: <20240905165140.3105140-10-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b584ef-5b9a-4c21-1dce-08dccdcb58b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p4fYSl2PxFJnCKkMrEQmJCZ1O4WJVMc5y/yO1gnX2n4+1XNf5YR8sLmu6a2s?=
 =?us-ascii?Q?UXIZU5qVj3pShYS/n55ao5LBdYX4c7H7cEU/PW41xAn3MMcwE7scYgd370Nn?=
 =?us-ascii?Q?OzmpR2KymfIteD3oZTNvPj+mmn7GRE7c9eVSO4/7R8hLffWftAkbf3TdKlNR?=
 =?us-ascii?Q?dkpzN545UpLDtCETc3t4dGjlfrQSs2M2kRQdjzIZ7wulmd3vRk+Y/6q2QJlf?=
 =?us-ascii?Q?VBW1Idfp8DowZNo4tj9ViSpy2l81L+v3HE1NvnV/VUhNr0J1dIpkbaJPjgk+?=
 =?us-ascii?Q?HDG1bES8dHNVtBiPx0cTSu+2Qu85X3H/tGuJF2ix6hBODxsUkKo6FCytS0e/?=
 =?us-ascii?Q?A3AkYr28MrNx/PnFweHOhf0NCkWc5TatCYS8LORwWOOmb+O3IVxDqW2nbRNh?=
 =?us-ascii?Q?KiMfI/LonxKU7OP7SQSK7+l/Tg/qo3xxa9Kgr8mAFlJ0KV+045c3F+gZpgxG?=
 =?us-ascii?Q?vP8+VYX32BAYp1NerR7pQmTASeO06pgmYLnJbzK0AtK9yPrHhsu1wK8x/KlV?=
 =?us-ascii?Q?N+NrYANU107e7upRploi+swncXDA4Gpkue6PqYCEXwvb5nVgTY9Y/fdVs00J?=
 =?us-ascii?Q?1wQsJqnnyWrm9T4BIyK5N03C4xNZE4Vkkd7a4KmC2xsqOS/EeEXVrjvsKQan?=
 =?us-ascii?Q?PnhkLBp2Nz1aABGmFVqVJFEEC/S0JFjuB+RYHZe1M01/Q9k74NrNP+GbxkV4?=
 =?us-ascii?Q?AupQM9jjXBGmMsM3tjf9wME2ZrVocp6fpoBn4YmwtRoi6vwZA4I4e7raBJdT?=
 =?us-ascii?Q?Vgon3hfVFhS3wtmHOIxtdmYq0E4Ue0SrEs11tqB8sP9bXm3+Zj3MX8IikTDP?=
 =?us-ascii?Q?mCboEhbj6/nWLwS7JLnKQDyKAxtkR18HI2hVcGY3fEPbmX6Rsj+ogp+IyoR9?=
 =?us-ascii?Q?I00OKveK/NSRmVB/HsvOB6Ogn7g0EU61WcmWV/MMv+yVhd5FXcxvRgQnaXXe?=
 =?us-ascii?Q?X4rgtIgCax8jITya3uhjoFu1smaU5hRhTcKKgkhCi0WKo8vknx4ukdT0Ms0B?=
 =?us-ascii?Q?ZfZaxrMsE8e232px/3boPd5SKLyO/r2NmIjsb6UmXmp6OFIKTB7GrbDkkyhF?=
 =?us-ascii?Q?LrrEF8M4N0p9lqXcM/4zR/SdPyJtEVQPtX/jtOoEHYru52vtUL+7zpMEbrtP?=
 =?us-ascii?Q?3GL3WJCG1qjSruiC3yQBIZVS5WQMt4snUHIscgdvCLhRvrqs375EqLT2hjVH?=
 =?us-ascii?Q?uWE0OCoxAElxH674YJCas5wRfwLVTbY44uO1vdrdcRFrks1Xl3/VwD+UD5rL?=
 =?us-ascii?Q?DIc1oZ5ziC5xwZ3IngHuqKQ1aaFQUWB6NiTCkxn3cpH0b0aPZt+fzmab+RdF?=
 =?us-ascii?Q?oERgjERQqvU0B1Uh0zHwrrylrwQfanXAbUKVaOUb9DqpnsgSBgOKOikiyEBG?=
 =?us-ascii?Q?VYba3E1vzNISZtDNkOCHWp1aaawIZx2lnSwjNZZ8lqKEi/M0ByOS+mzh1LDd?=
 =?us-ascii?Q?QcAFzee2rI/C3q8HBPOGDBKQtsJdYDAT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:54:02.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b584ef-5b9a-4c21-1dce-08dccdcb58b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

Unmask the upper DSCP bits when calling nf_route() which eventually
calls ip_route_output_key() so that in the future it could perform the
FIB lookup according to the full DSCP value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/netfilter/nft_flow_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index ab9576098701..8e7234107ae0 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -9,6 +9,7 @@
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/ip.h> /* for ipv4 options. */
+#include <net/inet_dscp.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_conntrack_core.h>
@@ -235,7 +236,7 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		fl.u.ip4.saddr = ct->tuplehash[!dir].tuple.src.u3.ip;
 		fl.u.ip4.flowi4_oif = nft_in(pkt)->ifindex;
 		fl.u.ip4.flowi4_iif = this_dst->dev->ifindex;
-		fl.u.ip4.flowi4_tos = RT_TOS(ip_hdr(pkt->skb)->tos);
+		fl.u.ip4.flowi4_tos = ip_hdr(pkt->skb)->tos & INET_DSCP_MASK;
 		fl.u.ip4.flowi4_mark = pkt->skb->mark;
 		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		break;
-- 
2.46.0


