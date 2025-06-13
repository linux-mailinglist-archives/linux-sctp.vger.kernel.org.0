Return-Path: <linux-sctp+bounces-579-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A80AD95B9
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Jun 2025 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB53AB060
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Jun 2025 19:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBC3239E85;
	Fri, 13 Jun 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdIFp3WU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689D22B59D;
	Fri, 13 Jun 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843692; cv=fail; b=D2c7OtAZNPCL8wIlcLynmZUw5fCG4FqHLCoV1PivXqP5XM/4rEq4A8oW0U71+JuW6TxXNC1QyOVHHKlhHCr9iG8cOX+jd7G5Vc3dBhqJBcJ+oKHkCN8WEzQt8qF19kRqQ5RO/hjj/5vcX1j+ywSpeLwJgDpzH4QBNfRnjPVVINk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843692; c=relaxed/simple;
	bh=2OSp3gcx0S2zGB24KcVR5Kc+F72O/wNjFrGtvhHQXhU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XBWfnl9OC71xm6iwqU3b/sAq4p+HSvdbZxtEHxuNkzW9WD1ZTC3G4jyCNlrlzKBYIWOGY8LOHovgectRty8ZmsxD1D9VdP+1MbVFUPlLPYrCrcNhwAGbSdQffbxFo09TRn60gLB/Cpt7NEIDzCrPEc+Wv8/RmUu2qd8oILLXSRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pdIFp3WU; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygIlO5cA/6d7nSZc4Z1bwRxO4sOTrZHFbLmLb+aluM9xDrdzHGEm+OPQcZjpkJyxe3TtVrGhRsDfYJV3rWbrxfzLnH3OQ3ehs3XIJB6aqaZuSFEQrfQxgPRw+43fjmK18mBN74Pt+m6UBTE725RN5pzaVwKXVS98cLtfKVF6Nlr6lie0Rpe5/EHWZk6Tz3Rj36YARzUUkXyqOGqGL6RY3WzwYrlkBJkJQ318Y4yyiaVWIE57guW/ABm3REzxmUWCfRbrjjJaJgjTA6ITMzRHwcnAIeruEdBHB6J77aMYsIPbzECa/vpSdXl0hWO8rv2KlO2zPYKTG1J6hddx1XvACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI6avApYmQ5bbzeWsf6br1B5roaScusavIhlEKslpTU=;
 b=kkdem+DBAOH08ciVErc1LnHqeVUFjvH4Xqw8HKuwKufAtsHKy3B4+WBdFxhQ5OkA3xgq9wgAbJMqxZzBxYLbsEhu2ipOKhSBsfKGeKuGSJvkUYuk4zOX0OWQkFYoQhAVZDvfxpRMQ22E95Uxp6lP0DuO4r0E0Xwi/1zgvM3ge2Clu2Agd8FvCuCe+NHMfuD4ig2ykwUkBi12r7DecQkalf3R8VmuefNGFLc6/H9cwcydUqvQFUGz9UmY24wkrx+afBPu9cg7PQyxn6IiB4TJRLB+Ja5UBJS/HqkEGy2ns1dyGM+y8teLPzTZtASDGI6NpCGhab5MWIx7q4UqLj1Sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.sourceforge.net
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI6avApYmQ5bbzeWsf6br1B5roaScusavIhlEKslpTU=;
 b=pdIFp3WUWJHcW+HMda1UOdafw6GZUWU/meQU5d19l9j3hlAbLWw+H4CHa73xh5rqB9T6NpHwWWrwz0XKL0YFa58Iqlkxx1fQqu4ICFMsIlkEkNJobQHu0kG1rXKe9jkrrnaPblKwFaOQM0tBXQ0914YJPNKWy+XQ6tJ59eWtAs9gs9JrGo6dvMoDE5mf1tm3ntVLctlfUQjfCyoh7YKweM1RvIllASYewyher25T7lEcd31XxyYNWgBY3yli8rxIKZb80xApzsXgQnaaoxdvAQiUsduDpyHuwlktSav4eTmZPKZhftKmO3S3lkT358L0dJXUeosMFmbDMtHUl+komQ==
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 19:41:25 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::cd) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.11 via Frontend Transport; Fri,
 13 Jun 2025 19:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 19:41:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 12:41:03 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 12:40:53 -0700
References: <cover.1749757582.git.petrm@nvidia.com>
 <93258d0156bab6c2d8c7c6e1a43d23e13e9830ec.1749757582.git.petrm@nvidia.com>
 <20250613094858.5dfa435e@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Antonio Quartulli
	<antonio@openvpn.net>, Pablo Neira Ayuso <pablo@netfilter.org>,
	<osmocom-net-gprs@lists.osmocom.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Taehee Yoo <ap420073@gmail.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	<wireguard@lists.zx2c4.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH net-next v2 01/14] net: ipv4: Add a flags argument to
 iptunnel_xmit(), udp_tunnel_xmit_skb()
Date: Fri, 13 Jun 2025 21:23:20 +0200
In-Reply-To: <20250613094858.5dfa435e@kernel.org>
Message-ID: <87wm9f2zwd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0bda78-e74f-4502-195f-08ddaab24847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBkOBtaw2nYDDxcz9jKxBfa8Qfqxk30adb/NuDjtE7m3/kAqgS+5IelgdgDT?=
 =?us-ascii?Q?xsQ8pzomx1aJg1iGPGgUYSyt6bFXXz1HYsgcnmsdgnBltecg/3McyLU0SRyB?=
 =?us-ascii?Q?HhqQahB5Z8cDeHTnLpuLXs4Q5WQreK/c3txOaa6LRBmPMEfIMCw/CA3i/TLH?=
 =?us-ascii?Q?rBvc4Nnpm5oCzBtuJ7Dy4Fp/EimodDI9v5/Xxn+jDHysAJqq/zYYmee3SnAf?=
 =?us-ascii?Q?TV1Y5yv8vNO3x7tHhf7o8fxfurvOaylrqzadro1mTFZjKM+3QD7AQaOLkgHf?=
 =?us-ascii?Q?ZWpcsPsQP4ML1o0WO6scAmMpKUs7nzyAhGZelyggsnKSem1gvYNOcx/HruFt?=
 =?us-ascii?Q?r/cEHeK4rm8bmAzciQuN9Tvn72Bfooylv7mEA8kYAFBcBWryJlmnNggCJ+47?=
 =?us-ascii?Q?BQ1OkZWBb+XWZUKpRMnUfMeaY1Q/c8si/SM5sPtGzUjrconqEXXNUnW3KCmn?=
 =?us-ascii?Q?QMpCYt1vx2undm3x2bwQXC+vB6JWjptJaUtMnrIkLnEJb678PDMkmaC8r8V3?=
 =?us-ascii?Q?zrHQBDOYdOPYvsvK16kLFyyLfw8ZsHiy0HALfwTGbVEgM3n0sedk4QHEDNsn?=
 =?us-ascii?Q?XHnoXWEabntvD88WkI+iaCWsW7JRajWPMltHheeXLESsdTYYk5sksKbzHv7E?=
 =?us-ascii?Q?Ce6N7/QKzgBx4oIGTo+M1+9L58W9AFsnfS6fTWPsFJOTJxr/cMvdE1ehPW1Q?=
 =?us-ascii?Q?Fmb/XhP/q1/y4V2H8rnHIk5m7Mhos0a3RgiYJUnbKA+3vws/kmNVCW3OQ0wA?=
 =?us-ascii?Q?E/CYxhch8Qo7amA4ufrU6MMxgCe+EITCxL3n3Tfj2OklQux0bkf2Y5vRgp46?=
 =?us-ascii?Q?mFf4Aei8Iot5qb20E2ySFnfaMTNTYCsep673p7Z4iwIQe8B95EYbry6pkoM3?=
 =?us-ascii?Q?s70Sv58jI1uS9UkvGBZQlyFo1X0NmQUU3Ju4HoBV0Zmij0Ahc1Mgn41oX2N5?=
 =?us-ascii?Q?7jAlBLOaWuS/o0b9QK6XCx+7GhN2lERjrYgWWfvj7gyx5++RLcO7BRe6eCdG?=
 =?us-ascii?Q?r0BWlVbLpKsxGxb6NBFoiIDRhDIzdOaAKFu8hnxJ/muOiV8JxNyp7o7bURB4?=
 =?us-ascii?Q?h4x+I/4+AZS2fAYXqZ+in/dMv9ZY4kD0lLQEOP4Rd0bkCQ592BdkYbEbOcrP?=
 =?us-ascii?Q?aQTsX56V9t1XF7IEIsBQDKAM9B/lDzC3DwLz6bCgL2cFlMKMXLRNtl6GCgCo?=
 =?us-ascii?Q?Gb11ZUlMNuqauur6rVhub2bD77LmdupfZRNSLbM3yz+b1Q4aU9jM61LUeQve?=
 =?us-ascii?Q?Ka/nGKjaHMAIkAFQaUazR40hZRCJJZauBVBlIufLLV20OTMQUOHKR6EophYv?=
 =?us-ascii?Q?3fi1u3MkXaFA9v5GBccLJGH1sMlFbFDvLNg259dmQ1QVOovvkxZzsNq8Hr3b?=
 =?us-ascii?Q?nmLh0gWItEDK078t7CttIAigb56AmFi04cbmBKb+qN05hKbMYl2Ej7SrJBfN?=
 =?us-ascii?Q?FZHHAYdDMRvoR6CiDOOgsLBNKNfv6xYDUhZYQf7pD+90nQNrfBKUoWbbyN3Z?=
 =?us-ascii?Q?dLTa90lJ9Yc8deGScQ01mT1E4/Efl3WQCGGh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:41:24.8480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0bda78-e74f-4502-195f-08ddaab24847
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 12 Jun 2025 22:10:35 +0200 Petr Machata wrote:
>>  void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
>>  			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
>>  			 __be16 df, __be16 src_port, __be16 dst_port,
>> -			 bool xnet, bool nocheck)
>> +			 bool xnet, bool nocheck, u16 ipcb_flags)
>
> This is a lot of arguments for a function.
> I don't have a great suggestion off the top of my head, but maybe
> think more about it?

It wraps functions that take many arguments ^o^

We could exchange src_port, dst_port by passing in the UDP header
directly, but I don't think that's a good idea.

I guess I don't have great ideas either.

