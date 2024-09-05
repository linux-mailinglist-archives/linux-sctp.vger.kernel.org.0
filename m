Return-Path: <linux-sctp+bounces-227-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674B196E043
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8906B22E87
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Sep 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E94C1A08D7;
	Thu,  5 Sep 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjGF2ISY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17571A072C;
	Thu,  5 Sep 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555195; cv=fail; b=eWdaG+SO17V9Jrw9po1Bm9qRpuKlzh+zpjCfVfoeei1AyrKAIkP4NlwB/Zivx6qFKeGxDZ/AcV8G4kDnpwpijdbIkDQZQHS6U7BiIIYDg/Hoy194DtyctemeR+JD7gerk2DAxgJzNlPoXCciZEW1g7ifg/uzmThpqqPTQyNeF/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555195; c=relaxed/simple;
	bh=f7vy6HP2qTHFaXqfTWwrgvvsGsj0Wvls16oXbRaFucg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fr5NS/0yzo+C6JnX3UobjR3jKjOIhCy9kbLz2AruKudTnC+41MqEiTacAeYL+U3M9w4H8LNh9g1dCLcumI6CM1fsEfHw4rhyx6ADv1XhEXAuOmtKhS31/Z0VFT30ByeeuBuKst1qQmN3ydMyQjN1wot6KO2xGpit97fryivvslU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjGF2ISY; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJvL65PnPmrQakU19AsFdPaCWKR0q1+9tCa/p4TvEPmietGhoD5vs52RftmJgAAG2xAOZkEQyTRVerxEhUQQrtI7h6x+eONKItLrnx2w+vpjp4GENEAIqhcGxr9d6CqydcBck23q5apiSlgf+TQs/RjiB9i3ZnoY2kJqXBmwVyRKewOLL0HzL66wGLK3kyej3ZLPa72h5FdqX9PRt420hlsAmC5jelA6bsZ6ioebdwkvISap5aFFqHUVc634zR3mwNUqGcQ9Tj1QUP4nYJ6qOSelciQ4QeqmXK37/ZK0jrfXT3W6kEMfbj+yu9/Ew2z3wxIOaRPBMPnG3d6ii65bZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ae83Rh//rdcRPE9a8PHdJwMi6jYLDJcfIqRxyIUeh4=;
 b=DqvUQ+h8aoBuUEJzJKob4RfX6af9PzJM66O1KDU574NoBuTgMVQ+DM+s+0JkdxC2z9hbdYgX+WSAqNPqZo7aAA/3XBzrars4+FqFCAl+GJ/RqmdGkcTDUTknNXiLZzAm1vt+/RfrSjSg/eT8k2CiPtfuHoaONVZ2F2EAVcyzcF63//du699ZK9Eo6Aws8rrs7GDpZSus6H7oL/eh4e0U9MbCCzC0aG/IEiHmCSxV7op1SFfE84c5zePbwKiLWJCM629kUqTPbeXGJ0j3DCyfXCrq7Czflx53dctmCcZs5F8DdJt4erWLzinhhpX5S4pTxiYEwsqfxtGilYpCxoLO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ae83Rh//rdcRPE9a8PHdJwMi6jYLDJcfIqRxyIUeh4=;
 b=hjGF2ISYwU8JE1B7dyjTIBA4PUuQoBQIxKMXcwPf8OeR7U4ajq2RxLn2+bHV5VpxcWEkODH0vVBgyhM/OqymxgqcAyTA6rHhLVUklZAWBDK0qNt57SO6sER2vox0NwJ1SlI/klqtqlMyMxEhNDAq6flzKZmhBoReGBzgeyV8GkwxooEKyi+MVrDmj6rze5+gjHD4J4ua8BsEd6mmB4TCQ6zZnad75HjJYbyLRgjy/KP3urvpPvFseOxTZNfSiWbUNfEP129qd3CS9+Vntf0f3q5AjzZa3cyAktgrqNH9NN+pTYd6hb9As6KA3fEjSOjLKMu+TlqCgzpMielu8PF4Gg==
Received: from CH0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:76::29)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:53:04 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::8b) by CH0PR04CA0024.outlook.office365.com
 (2603:10b6:610:76::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 16:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 16:53:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:52:47 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 09:52:40 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<razor@blackwall.org>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<bridge@lists.linux.dev>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <linux-sctp@vger.kernel.org>,
	<bpf@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 00/12] Unmask upper DSCP bits - part 4 (last)
Date: Thu, 5 Sep 2024 19:51:28 +0300
Message-ID: <20240905165140.3105140-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 183e123c-7f4c-4b6a-51a8-08dccdcb3585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQ0ZF4YJH4rLrIOjblVwCZjmJoQCHa3/n9gQ2GlHI19iS/lmG9rWiGjeHeA8?=
 =?us-ascii?Q?ltRvrPbMjHywONA8LxN1cAJktWEDmgmm5hTxY9nZad7CYu0SuDK/5cin5J3I?=
 =?us-ascii?Q?ZTLJcf22HLoNzYurScnZEDLFf8TBUso+1lDQ3WrtHZV069JnLHiT5SadUU1G?=
 =?us-ascii?Q?UhdmVmg7KWsSUnS/pZITGqtP+URgrWk0oqENeeijQSRxz212coeVEt2+Nxzt?=
 =?us-ascii?Q?Ogq16RqhhHMA9wv9URUtc2FRu8fNLzpnDzDKDaQY10bbGwNNn5Jjy2/6Da2A?=
 =?us-ascii?Q?62ixKQbd7VfHpyRb/2LbTrpf4mlY9iDh9vZ9Qx9mPyT7ca6dciZR3u++9q2A?=
 =?us-ascii?Q?/Y0MU+8xGLN4QpraEGnmRQ06VNjvufC3mAcsauzzFYQBGprKm0DYko1yS+dw?=
 =?us-ascii?Q?HPDL1027BjG0iEoQ918VQhlTgm1V+BLj/vmZOB1pRg0NMTp2qzQW4JWGe1un?=
 =?us-ascii?Q?IZWK+Gg+nEjWXvEBQSwS2hZZswq0/1TM2ktnoSdcXqd2+dO2lMGQzLmsVxUE?=
 =?us-ascii?Q?axqvBI9ayNH0deFVE5kEJFecElMed3KwrbO1ty/v7GoRzGZuZYwrZTPSEH97?=
 =?us-ascii?Q?j4Eef7W7LZ6UvRvzT5EYKU5Fko7nttC6Md7Edw4uuNooP2/uOrTj2upWBfKr?=
 =?us-ascii?Q?6C48JEFsOvSM4iN8RuVe4OiLNZBAjCJ2TMlJ+DoUH+Bdj3Pn1pKiTEI2DUB4?=
 =?us-ascii?Q?FAHa6WJOWOOKj8fFvl0eDNgM3Lm1cFKXkRK4ZingMhGk/VtHEaD5wNkZYhd/?=
 =?us-ascii?Q?XbPs0RwchCqUmRoofRFpwMalfteJMZeg6RVOtuT1sQkaXGBaRxuBA5psXkkY?=
 =?us-ascii?Q?cGfcQsdOgxj0Gm1fDjFuKVgdjCP2PcOqMyERDWv9nwRE3qqaxktmFAn6LeNi?=
 =?us-ascii?Q?Ky9ts3A5LL6MMUlDeKwk2nafUSx/llkD3pLZPi+8b5EdueW/2F7eY9+trckK?=
 =?us-ascii?Q?36nno0d9cS08/rTfNBhjlvU5Dir63JYHB7RkYw4KGGHDnaXmealptRb31BZQ?=
 =?us-ascii?Q?18xecexYUf7uhWK6MJVkYefnkWxTkgzBakUEdXdAEjBhjXlG9uSAGPrj+US0?=
 =?us-ascii?Q?/WjhlTVsFfM7P68dpVYbld+c9s7PW334vGAv0U0i8pSVTgoDRN2Zyu3OEGGf?=
 =?us-ascii?Q?GLidvSuFx72WsMcVNmE68h8AgQSV2egNBNEg+qN5Ldj2s4RTpQpDE0ZFzrNU?=
 =?us-ascii?Q?oYtkb9n3+fwyNWFlxsdmeHPQHP9NZe3c5aworwBRM9gkY06EuxAViNS/DKDF?=
 =?us-ascii?Q?8EdIoTKilatp0C/UkI6bJjXGEPR4KV9mRhKbzLAeRmMPcnIgwH/XI42i1uLN?=
 =?us-ascii?Q?Qc+gU8LREYDn9VPcy5Cufv7n1gZUQxI9Hcz1GsV41i2Why/NhZmDQCoHYl4r?=
 =?us-ascii?Q?6ej95TEsJHRaN14lTZ/pFbvkx6rZ/JaDbVVbgqt/K5x7pHHYnDLhBo/n9P5d?=
 =?us-ascii?Q?pnGwaVbK+pS/vAUUHyLj+s3b8C5Ff+dy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:53:03.8190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183e123c-7f4c-4b6a-51a8-08dccdcb3585
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

tl;dr - This patchset finishes to unmask the upper DSCP bits in the IPv4
flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
functional changes are expected.

The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
lookup to match against the TOS selector in FIB rules and routes.

It is currently impossible for user space to configure FIB rules that
match on the DSCP value as the upper DSCP bits are either masked in the
various call sites that initialize the IPv4 flow key or along the path
to the FIB core.

In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
need to make sure the entire DSCP value is present in the IPv4 flow key.
This patchset finishes to unmask the upper DSCP bits by adjusting all
the callers of ip_route_output_key() to properly initialize the full
DSCP value in the IPv4 flow key.

No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
Centralize TOS matching") moved the masking of the upper DSCP bits to
the core where 'flowi4_tos' is matched against the TOS selector.

Ido Schimmel (12):
  netfilter: br_netfilter: Unmask upper DSCP bits in
    br_nf_pre_routing_finish()
  ipv4: ip_gre: Unmask upper DSCP bits in ipgre_open()
  bpf: lwtunnel: Unmask upper DSCP bits in bpf_lwt_xmit_reroute()
  ipv4: icmp: Unmask upper DSCP bits in icmp_reply()
  ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
  ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
  ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()
  ipv4: netfilter: Unmask upper DSCP bits in ip_route_me_harder()
  netfilter: nft_flow_offload: Unmask upper DSCP bits in
    nft_flow_route()
  netfilter: nf_dup4: Unmask upper DSCP bits in nf_dup_ipv4_route()
  ipv4: udp_tunnel: Unmask upper DSCP bits in udp_tunnel_dst_lookup()
  sctp: Unmask upper DSCP bits in sctp_v4_get_dst()

 net/bridge/br_netfilter_hooks.c  |  3 ++-
 net/core/lwt_bpf.c               |  3 ++-
 net/ipv4/icmp.c                  |  2 +-
 net/ipv4/ip_gre.c                |  3 ++-
 net/ipv4/ip_tunnel.c             | 11 ++++++-----
 net/ipv4/netfilter.c             |  3 ++-
 net/ipv4/netfilter/nf_dup_ipv4.c |  3 ++-
 net/ipv4/udp_tunnel_core.c       |  3 ++-
 net/netfilter/nft_flow_offload.c |  3 ++-
 net/sctp/protocol.c              |  3 ++-
 10 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.46.0


