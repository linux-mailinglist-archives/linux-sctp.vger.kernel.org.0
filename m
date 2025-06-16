Return-Path: <linux-sctp+bounces-583-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B277ADBD23
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Jun 2025 00:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E010173946
	for <lists+linux-sctp@lfdr.de>; Mon, 16 Jun 2025 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C4221280;
	Mon, 16 Jun 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+fHD9z4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD5221FBC;
	Mon, 16 Jun 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113957; cv=fail; b=bNv7lbIhLXsBjoQqdakFpTWvMxLv358oo49zCIyuIi6DRYKIrgjihzax2ou/13dnqsAOeB9TJmfJghNdaN/WWhruh4nw3s0DsNeCjqGkkKmMpVCPvUV4xZ0+YKablIY8tXq74IkLYp4X8EQDsi+1OGHMK4RHzaONuV/b7WD1jsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113957; c=relaxed/simple;
	bh=WvkSgBPtVKAToV82JqbFedSmRNb2K/DFDxjo2eYmhC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj1bukKPUgrUhSZBh8WsnSxUemGqLaut6AnQj52AljUAAn2mD9oOrtS8rdBeJKoTObF+dVPgo+UGpPN6g68xvIJ2cet7eVQb63Q8OS2w8r2NW6n+dV2EfYjIVctSJ3pZ14qC3T2mJDvfGNnoCpYxBY2/RjlBDoYPQJCO5rCbbiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+fHD9z4; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZNNaJ9LSw28WP1zK7AltUe4gM2T72Fajw/nODVYiJJ7oa3kp9YcSFk0+5o0bAT1cUysB1wQ7FeFz5+xICBhpHy4wKBkmvWL61qK2eelS4RTzwT4M6ix7HX6I9ikWMLAdNeKffiFMlD+I07V4JaHpV3Op8ulrkPO7AAC6ioCA2oP9uZO2lwRCPmKZ8eq7m0WUUchI8xDAdkfI7Z06TMzqRsJx9hVHqpOmlJdj7l3eVjYQB5eQ2rTEZtJO6ViODb6W4VuvOH4HbAXfZKRuvCV4LPE+Ht6+pVxAI1L/kwf2hxgf4PwEu18PDCqksj1EP/ZBJQo6ec9/4TozUG+Nn7ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK2DEBpztnmsylwYxk2ap5Q3RzIPrknqxXiA75if1l4=;
 b=S/xFcB9924Y51LmpbJjynF0CiWn5tKEgXI2dYyWPd/yBPJpsyWOTCVtKQ2HVMOQsIRqT9zq4jFoeQf8Oihe6O95jnqRlsXIA+wbQM978RqK+fghdps9hwdtChI7HlM4tefpJBOaeA+Vbsd86OL1icrbv2NEpVCxCJ4JF/gzB3/0OICLlYpKbKTC7fcOg9/EEul9tEdz6gF5qadj/RvN8IrDtRd16OEI5IUYSniJ1QX/bKLslfkewx2KXkJNaUufKxRpFP1wTeltCZO2kWVxzlp4yGKSQY2cOg8dtwAEa3uhe8vV54H595jyvNW4aHv/mMRHpA5Jr9X67Hsc486jyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK2DEBpztnmsylwYxk2ap5Q3RzIPrknqxXiA75if1l4=;
 b=o+fHD9z45dmZCbY3CNthmhLEx5XAXkTKDp6dpeMiuSX0GaoUlM5y5rPPiYsv98vfu/0SFQAfwec3eiduGZrCFS4pqpqWqXCljcMgzwl9onFLpMtivN1Cm9PuXk6optGjp6xJJloAALNowgEvymJ1a1TRhVHgT7Ovd0gjYei8d1DfH9nIoYSc71sDK3NUn24V5/rGW9g9ZP0iQ4kLLIDmciVSCcSCY5AWeDb0T1xbaUpnG/0iBs0Ns2tLit39/hqjyuzz0lPFYiSZRSHiTLVaFsaxTBZ2MK3ZgOBH1O2DH9OfgKCxVrEtgCjYjkiO0f+gHw/vc+AKtmc3wyzC/Bki8Q==
Received: from SN7PR04CA0081.namprd04.prod.outlook.com (2603:10b6:806:121::26)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 22:45:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::e1) by SN7PR04CA0081.outlook.office365.com
 (2603:10b6:806:121::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 22:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:36 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:27 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Pablo Neira Ayuso
	<pablo@netfilter.org>, <osmocom-net-gprs@lists.osmocom.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Antonio Quartulli <antonio@openvpn.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, <wireguard@lists.zx2c4.com>, "Marcelo Ricardo
 Leitner" <marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, <tipc-discussion@lists.sourceforge.net>
Subject: [PATCH net-next v3 06/15] net: ipv6: Add a flags argument to ip6tunnel_xmit(), udp_tunnel6_xmit_skb()
Date: Tue, 17 Jun 2025 00:44:14 +0200
Message-ID: <acb4f9f3e40c3a931236c3af08a720b017fbfbfb.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4dd0f3-9072-4f34-0bb4-08ddad278aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b16a6wf67wXXb/jO8gCEIzXHbX9jUJiDAnOoiV5xskQSkv5mpHz4iLW42QxX?=
 =?us-ascii?Q?XD4tqX/RtEniIIgLXLEstbkxfMfBHEHPyvBGnBDPsOXc2FtKzuhB4FOgJqc1?=
 =?us-ascii?Q?ViVFP3cKvOm3UtqWjFshuYbcQAEqDqdjmZJzfXeWpqpK2aeXcZms25atz0ef?=
 =?us-ascii?Q?KFUH5VPUE247tHKylvEa7xGhnDLgb848KRGz21SPfF1HOxjwj7NG81d1Co9a?=
 =?us-ascii?Q?aUBKWOp/27xdSbXKg150ksjCkRu4eUJ4Bry4c69kVTDWTmM0GdoqUWIPb0l4?=
 =?us-ascii?Q?gmzUGMQR1C2eJxFzV5pr4v6SL9s974tmu33olVa0ip4IJ/g7KO1idtm7iH92?=
 =?us-ascii?Q?vNMILT0tTsBROgGyw9BCcFYZFziNJQJhuJLXRISsnEcOjTxXf8y1SAiZwlfg?=
 =?us-ascii?Q?oU9j0bTOmAnMP+Z4CobeuNR6dnNx4jSkviTOLiEHPKU4YuEZAe3BesUNsG2X?=
 =?us-ascii?Q?2EMTbyISceEGkv/Qo7CZzdhIhDLCC1pIYZLoU+yL/VpMoHxZi4NdyCY9LeuU?=
 =?us-ascii?Q?Fr67NXywWEzIA2NyFly4fwnvbEzZxvdGoz7fBXznJn2nSbJbawVpjrBZJfXA?=
 =?us-ascii?Q?REtw0fU2zvnTFazQ1WEYeK28TO8mKV/Mf9DH0FaVWUpcQwXNsnuZdRDWvKye?=
 =?us-ascii?Q?J3b6LHEKXufSCLI/hoklYmZ+3X8U/iYOk/GSSk/nW4hBaiy4IuF3/vb8crEX?=
 =?us-ascii?Q?pVoQA9k0Sb9nS3ph/R5K0fAB0qSrgL9o/B9gVpiUIVlRcLn+so0bcEqqwF9y?=
 =?us-ascii?Q?hFV/J4fM5upRg/OWgUHQLfmcWxejoh/I+e+YQYFf+q7vmlLz0jsvy0T0R3/o?=
 =?us-ascii?Q?0iEc7JfRxiCm1dwNtVKfqby+FeUuVvoozzaV9TN+molimdEHAxZZKjxrK/jC?=
 =?us-ascii?Q?c5VY1hevtlElPY6RpZy58i2aWui5DQ++RkpllhHyL8cJBbzlFZKyEy6wHZKG?=
 =?us-ascii?Q?53nxS1DM9/WAKJMIhfcModo37O89B4/2lI+YffnByqtXHo0+7DqoJALABHql?=
 =?us-ascii?Q?1ZODZNER2gDJ1jl0iAF/ZRgSlCDCkIwjF2/ZRk/mBIAZCeoOSrN19EceFMXm?=
 =?us-ascii?Q?IFPqM0jPEekAj3drn/7PTVaIymeVhD5emFdpaW2b4Ux6jT65+rxKV2MSj8fV?=
 =?us-ascii?Q?Ln/s+O82ueOpX4DGYS919aqnhylK2l3iPi8AVBsVubMPlParRvoM8bgLLdm0?=
 =?us-ascii?Q?5k3v41zh1PBrKsRqbJEGZ+57715mC0fOg63FLYqZmNxklRmiMapfx7Ox9Vlf?=
 =?us-ascii?Q?cwNo2OKaLcg/ueHWy5De3i7ah6QwbU4EPQbByZBSugNSA3ngodJ2qrPNqD8l?=
 =?us-ascii?Q?bgQfvGV14DoLqMX9A/z66R5T4ObhfbuV2GgtigyQvnZi4V12qvu3DGNqv8xV?=
 =?us-ascii?Q?kExejRA9388iwGdWyYpbIixe1S3yRY8wGryl7Ngm17acbMpu5cqIVdsuLFBL?=
 =?us-ascii?Q?ZZCKNEss3plJq1VM+KAMHLu20Pz4SfceXHZ7dDPDIvmqDal2xNGUcsLAbQ3I?=
 =?us-ascii?Q?rFuobBJVYAfrDBqlAl7rGnj40wqZi1/o95Se?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:49.6522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4dd0f3-9072-4f34-0bb4-08ddad278aa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

ip6tunnel_xmit() erases the contents of the SKB control block. In order to
be able to set particular IP6CB flags on the SKB, add a corresponding
parameter, and propagate it to udp_tunnel6_xmit_skb() as well.

In one of the following patches, VXLAN driver will use this facility to
mark packets as subject to IPv6 multicast routing.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC: Pablo Neira Ayuso <pablo@netfilter.org>
CC: osmocom-net-gprs@lists.osmocom.org
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Antonio Quartulli <antonio@openvpn.net>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: wireguard@lists.zx2c4.com
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: linux-sctp@vger.kernel.org
CC: Jon Maloy <jmaloy@redhat.com>
CC: tipc-discussion@lists.sourceforge.net

 drivers/net/bareudp.c          | 3 ++-
 drivers/net/geneve.c           | 3 ++-
 drivers/net/gtp.c              | 2 +-
 drivers/net/ovpn/udp.c         | 2 +-
 drivers/net/vxlan/vxlan_core.c | 3 ++-
 drivers/net/wireguard/socket.c | 2 +-
 include/net/ip6_tunnel.h       | 3 ++-
 include/net/udp_tunnel.h       | 3 ++-
 net/ipv6/ip6_tunnel.c          | 2 +-
 net/ipv6/ip6_udp_tunnel.c      | 5 +++--
 net/sctp/ipv6.c                | 2 +-
 net/tipc/udp_media.c           | 2 +-
 12 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 5e613080d3f8..0df3208783ad 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -431,7 +431,8 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     &saddr, &daddr, prio, ttl,
 			     info->key.label, sport, bareudp->port,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
-				       info->key.tun_flags));
+				       info->key.tun_flags),
+			     0);
 	return 0;
 
 free_dst:
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c668e8b00ed2..f6bd155aae7f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1014,7 +1014,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     &saddr, &key->u.ipv6.dst, prio, ttl,
 			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
-				       info->key.tun_flags));
+				       info->key.tun_flags),
+			     0);
 	return 0;
 }
 #endif
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 14584793fe4e..4b668ebaa0f7 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1316,7 +1316,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				     ip6_dst_hoplimit(&pktinfo.rt->dst),
 				     0,
 				     pktinfo.gtph_port, pktinfo.gtph_port,
-				     false);
+				     false, 0);
 #else
 		goto tx_err;
 #endif
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d866e6bfda70..254cc94c4617 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -274,7 +274,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, udp_get_no_check6_tx(sk));
+			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
 	ret = 0;
 err:
 	local_bh_enable();
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1cc18acd242d..b22f9866be8e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2586,7 +2586,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
-				     pkey->label, src_port, dst_port, !udp_sum);
+				     pkey->label, src_port, dst_port, !udp_sum,
+				     0);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 88e685667bc0..253488f8c00f 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -151,7 +151,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, false);
+			     fl.fl6_dport, false, 0);
 	goto out;
 
 err:
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 399592405c72..dd163495f353 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -152,11 +152,12 @@ int ip6_tnl_get_iflink(const struct net_device *dev);
 int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu);
 
 static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
-				  struct net_device *dev)
+				  struct net_device *dev, u16 ip6cb_flags)
 {
 	int pkt_len, err;
 
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
+	IP6CB(skb)->flags = ip6cb_flags;
 	pkt_len = skb->len - skb_inner_network_offset(skb);
 	err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 0b01f6ade20d..e3c70b579095 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -158,7 +158,8 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  const struct in6_addr *saddr,
 			  const struct in6_addr *daddr,
 			  __u8 prio, __u8 ttl, __be32 label,
-			  __be16 src_port, __be16 dst_port, bool nocheck);
+			  __be16 src_port, __be16 dst_port, bool nocheck,
+			  u16 ip6cb_flags);
 
 void udp_tunnel_sock_release(struct socket *sock);
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 894d3158a6f0..a885bb5c98ea 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1278,7 +1278,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ipv6h->nexthdr = proto;
 	ipv6h->saddr = fl6->saddr;
 	ipv6h->daddr = fl6->daddr;
-	ip6tunnel_xmit(NULL, skb, dev);
+	ip6tunnel_xmit(NULL, skb, dev, 0);
 	return 0;
 tx_err_link_failure:
 	DEV_STATS_INC(dev, tx_carrier_errors);
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 21681718b7bb..8ebe17a6058a 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -80,7 +80,8 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  const struct in6_addr *saddr,
 			  const struct in6_addr *daddr,
 			  __u8 prio, __u8 ttl, __be32 label,
-			  __be16 src_port, __be16 dst_port, bool nocheck)
+			  __be16 src_port, __be16 dst_port, bool nocheck,
+			  u16 ip6cb_flags)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -108,7 +109,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->daddr	  = *daddr;
 	ip6h->saddr	  = *saddr;
 
-	ip6tunnel_xmit(sk, skb, dev);
+	ip6tunnel_xmit(sk, skb, dev, ip6cb_flags);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d1ecf7454827..3336dcfb4515 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -263,7 +263,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
-			     sctp_sk(sk)->udp_port, t->encap_port, false);
+			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 414713fcd8c5..a024fcc8c0cb 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -219,7 +219,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		ttl = ip6_dst_hoplimit(ndst);
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
-				     src->port, dst->port, false);
+				     src->port, dst->port, false, 0);
 #endif
 	}
 	local_bh_enable();
-- 
2.49.0


