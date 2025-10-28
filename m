Return-Path: <linux-sctp+bounces-719-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5909BC15C83
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF7B1C6046B
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD6347BDB;
	Tue, 28 Oct 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="YKjdCrbW"
X-Original-To: linux-sctp@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8B347BD7;
	Tue, 28 Oct 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668158; cv=fail; b=P1Ngmbgk9E/4z/ptOI+czLinprmLw9nTIF1X9tB9SKNwNba0d270AhT5gu/1g94hp89zcty+lp2O+wvRIDflHJdL26zkeVlxlvGrUoWysGC3/zlx6QmWDlXhvIm3xYsG7tcSHS9nsjnRoEIb8GO/2GKopvqPJoRaKYAo2hsVGSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668158; c=relaxed/simple;
	bh=RSiqszUnf7XD8yTbpJnjWYQeITlWYOrpQm0TcOejkEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bywy2ha/wXjoZ3O7l3fEBBSaiumZBYz5Fkab4waZ09gi6vegRSJms9Vh7YM8tH7qliSWd3OIuY3Ppfw78Ak8ffjh2M027Ho06T2fD/0//wr/+uhnZPQanxE4dLg20tRA7LSofwf+HP06GWhzabZAVSu5a6+YJN3rWYLSZkz41Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=YKjdCrbW; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVMDTYTY3J7wG0+ftbYaqx4J3WpCCCsaBoAj1H9vYpfnw8XsZd984OphgP200w0CosoWpV7jQhmsCad/I5OdFMifFTvlH0Yda4VJ45B4l5+3OD/2NMt56JrK97uKYcOJwZZ/8lVsPbYIsMfbC3YxWRpjZISVQxPWuDverX/5p+S9WkT4DBtSj1uQ5PePo7j6iN1dyNiaxJqR60cEhVe7ijyzGCQmZdF5tkQYu8HkgKMXHI9iLY8BhE86eolh6aRCf0f5KGzixc6EOCCof8w6keSMPTdKfdNExpcSfp+LC4Gj5nc4LK2+C9tJRPadB4oZ4KOplqx9+e3ffenI4qOOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnF+kGP2JDy5n66pBvYcaWUHvXGrqUFH6ULX6K/ANkQ=;
 b=JpbhdlbTELtHxXUEBUHO6JOcMa7SI08l0gdYEIHzEcHZ1/R5iLH7Dk9pUrpizFaPWNkbkrzsInZW4WX4rmf2gd1qz6/w+WzicivAy/JEPItDDZ3wUJB6/jChs6M2WRUb6+MNQsG+VFilpuHFr/acipZVo4bHtkYaSAJKAF/SVlMaqOuqaCrU2Xe4b/OrgTj6caSB83JYWyRuhLRjbZvgkRKuVDLy5Lc2UMtTpWCkNBs1bw7H/u6LxMT4VhCaRAL6/RtOLwIu/QRw82VqtKVWMtAiHs1liAaVoeGqV+EUq/L3yCw6F/kMpNpTN7rdNFLMVWDWLcUIQqLtI0Tc9kKdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnF+kGP2JDy5n66pBvYcaWUHvXGrqUFH6ULX6K/ANkQ=;
 b=YKjdCrbW+rXVeP4ThwPYW0K2aQ0gL5hqINVO+jY029eYoYGN82HHpHVVBzqWqqK+qWzfra8IcszfHYW679VXGSowdyE02DOrY7KRyVFq5hFv8a3zGXupNNf2/G4c47gtHyo9QI0H3LK5xp5HLgJTXi8tX7qa9m7oDuPDfuTFK2MF8jBuuK+9cwfQFcCOUoFcWq14WvUEkIFouu4fOVOuMngYcBk6UMAlAlr/0S8bEaaOq0e5mVRDPF+ed3xPVxfN7eu2oHrv/LiT1vaED9KcEMcWW//2CSWkhWHG82xCebdMVsHCEEiOWMaN66D1Algee8Asi4x+j3qjnphHkS8tuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6700.eurprd07.prod.outlook.com (2603:10a6:102:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:15:53 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:15:53 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Xin Long <lucien.xin@gmail.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v3 1/3] sctp: Hold RCU read lock while iterating over address list
Date: Tue, 28 Oct 2025 17:12:26 +0100
Message-ID: <20251028161506.3294376-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PR3PR07MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6747520d-8357-4cec-17b1-08de163d4470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUpUlIYMoQpnYO4ewCfZlc1xIsQwPOkt8gFS6D5d7uo2C9CH1k4u7Cy3VlO8?=
 =?us-ascii?Q?7o1ygPi33FgQfpMYQHgQc9gaY16qGTfV08CeNr9WbhG3VA08RmgxH5gUViQB?=
 =?us-ascii?Q?G8UHVhPzuf5nKG/zrhNULp2q5nI10B/EZABjYqZlIx7Tj/s8+M52uqkTnFGv?=
 =?us-ascii?Q?23t7ZI1jcYl3wAVkr17ukS2fClaYyuTeZN8IuH3ETO8igdTPfDF1spViqnrf?=
 =?us-ascii?Q?wTDY/LTGn31flWopc5vJWrfvafRIgJ8BVUrSAURIEnxVosLEjlY9C9onUCKe?=
 =?us-ascii?Q?u0/5WUuyUqPZjiCYvU0sL07DypKEdA9VSaSDrHPpJ7kzZIEQ4ZCv2FFoQNni?=
 =?us-ascii?Q?x8Cafff+Ptk2dfLvH9MX/SSPblHn1Qs5TH4jQ2tVL2CGsvlDsVU1UPYmWKtG?=
 =?us-ascii?Q?Tme9UFTZlHf8EL9/3zidYjkKosI+xu62zuvitkt1ZEAM1eh7OGpFy9D0Ms1V?=
 =?us-ascii?Q?zijYhCWC8x9OT3qq2DkPjOQ9GZjREofzyH0RbpzDXxEpzixR2hyQpRPgaJI4?=
 =?us-ascii?Q?OJtS9aCXSOCteAZ2eHJoMZAgSo0eq9BzXQlucLHJ51f9zzC5fYuqGa7R0PWL?=
 =?us-ascii?Q?Km3qp/Du6m6kMat6jyMFCsNC9KkaWah8cfhhNAIYlUlR6g8e76SGKtEZ2Zeh?=
 =?us-ascii?Q?hkrRf6EI4CVM8EeIXK9GhwrWMNwdi5MsM1HqmKGw25wWWMVz16ZO791XtMhB?=
 =?us-ascii?Q?wWmJ2xfX9wDsC/HRh9KXJmVvgrriyhLyZp5BGMPs8hEVEkAEmXn7aOP9yV8G?=
 =?us-ascii?Q?6iDW8ME+52PGWeDgWJ2aWW44lla9Ga1yDZCNyWs91uDXBRXym83U+zrTuuGA?=
 =?us-ascii?Q?BHTUOIc7tGemxy3COSZGXMqzhuIvYQBAbohZT0dffs+oQ+vRNld7iyFp11bq?=
 =?us-ascii?Q?s1RwrEpOBVqaJjC+ogQ+qlxfAImh64i4b+jhL73Wse91i30xVMw8Eu3hqLdm?=
 =?us-ascii?Q?T0FMFD08qohdXx9ZV2pFNIlvVUQ4T6Y3Zq2IBcOnumcbVRSli/Cx+qlGr9NY?=
 =?us-ascii?Q?909OHeV9xpGtVZwNyW5pPIR4VJR0QktSdZYklMdROlrrf0iA4conDNkDtAEs?=
 =?us-ascii?Q?ZBsTjXodaqTjZ27nHqjDv7mAI0i9WHEE/JfVJZStpwHrhNAjxig3Ml6aiVNv?=
 =?us-ascii?Q?ayr1LnfFwkNlsyCjbWEuuvzQ/fHhQQrscs49nTCbxjF7dZ6oe4usqlpYVTg+?=
 =?us-ascii?Q?1DWAQtpCj1nPH+/Uq2j12vWMlABqo16ED7XfU1aAxivBbOnSs6toPGVtppG/?=
 =?us-ascii?Q?R6Ceit5QVsr0uxja0LDeM+c7YHFfMbgPsJSdzN57N16uX5PTZiujmC2SIAyA?=
 =?us-ascii?Q?sd8GWmzS+lKLpwPubqJY5eA2x0GEi20zQX90xl5zL0DVGMIouq9gaGjY1F77?=
 =?us-ascii?Q?zuBCH3XS8Yl18Qybd+PG6c5Y5v/Tc8TOqiy7W3Io22CQK+hxoeaEkJm/ZvbT?=
 =?us-ascii?Q?NmXIaFvjWgSF6z7m6pTiX3nePjvp8eo7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wQj3gnILy99vOF8biCXPz9fFoqRqfLbRaN/UzcVga+Dazj5T/boPjeUZBEMf?=
 =?us-ascii?Q?3vFT7/+ZMViT93WxM20G/yRwoShvWvvrz86vAwNPPMdmFAEbAgt3SMkRc5dz?=
 =?us-ascii?Q?9dOKuyZK+xCnbNM361XFPS2Lp5FkBf940y6qIKUOw41BooJxwDm7DXdThRxR?=
 =?us-ascii?Q?Qxp/vzyz1zK0wM2upBJtgity1YbsrD1LmH/NVMYCq8FOHxah5FSKOJIrAEC2?=
 =?us-ascii?Q?cE65YgjLvtWOffzHP4EFMFGdSaHKJOGpbciioOfJ2fmiRZIY/ssMpBAkyvi0?=
 =?us-ascii?Q?1+4gq/YaXsmaY3nge2Kg7enwO30P/MTBMiZ67mCycsztOUqxbFaCT5DT+GUL?=
 =?us-ascii?Q?kNaiRbBTvj1lIIJLE/GcGVKJukS5VF0iw7TneryKLEx1exWitCCLbrKd8V8P?=
 =?us-ascii?Q?QPQUkgwReIg59+eAEtJvP2P+AOX4J1A1fd14bSuHkkp3oZFh/R+KqJsAwaIc?=
 =?us-ascii?Q?xbWV1KEHkAJwVg4srzNWtPPGJK8juvYMeu5q9sKukSYH0C5xHIEBmil2NKYD?=
 =?us-ascii?Q?/jm6P84FgLpns5EIevfYcm/h7cs2j/IOWUPzyZD5EFtggsrVxPEDTDJBcaLP?=
 =?us-ascii?Q?QgbIFMgZ5QYDKJum/Ts2xPK5cMrQHkObkR54R+7pYpuPPvBJEx8GtzTGhFg8?=
 =?us-ascii?Q?42HHqKhmesmlS9RhiSt/LvZsvdIwqmVSi3Dedo7WLRxwEtfIudKJrPd7DHKm?=
 =?us-ascii?Q?fiGggkiI7Fsc7Gd+j/J2yxmoEgL9EszfkYOfGR5DYseRRAY6uq7YFBh49ssR?=
 =?us-ascii?Q?ghoZxNPk0TgXzUyRyVm2YTKLVu39ng/NTpxoXgsgoEu0fjwgb0JbopsbTa8F?=
 =?us-ascii?Q?52TsXGcIe23jIGXiVGFD5e8est0EL1aO4/mYm/OzAeb2zfuqMdfqIF91XDK5?=
 =?us-ascii?Q?Y3X3Uf1JHIE4KNtxN/3W31QogICZvOYHEGcN0CwMPgmOEIdIKhqEgZ7qFlHb?=
 =?us-ascii?Q?zFFEA4TdPEctx3f7xTufms9JPuU2hpOdt1W6YNxf/YlmnOW80C16nS7xU7uQ?=
 =?us-ascii?Q?PXHbO4De09hXOTo1Ug633VIiTbW/PvE2WHO6hNWs4p/X5R2aXBMpXdCMCzRs?=
 =?us-ascii?Q?YkVb1CdNkGb0z3coFx+eDKujNIjIhFPnN8S4wFEDrr1h0EAvNJUrAVHJdcZu?=
 =?us-ascii?Q?d6IfAu+0dw2AKfJRYv8reZtHb7IQu4llLgRwdjob8JwN7yV1x0O0gr58AYfH?=
 =?us-ascii?Q?covgPhghwpfpf3r9nchaT0zEnufuy3CKHnOVmyPmdxOIlnVCxFaU9nwJWnpn?=
 =?us-ascii?Q?ALL1qk2sNqR2F1RoMIwcDc70d/vrCBMedDI0LdyHs/grLGWM6byqc7nI9Zb9?=
 =?us-ascii?Q?QfpFauJKharibk76zz3GdkdgoIrl3ADfn/NrXZ0+nKxxZlQlx5v40SYV6CAj?=
 =?us-ascii?Q?kb8MtYpqnHFMuUSd705cD/rnVYNOIJMvNsfpVd06ajBCwMKb27CKAhxd99r+?=
 =?us-ascii?Q?M1xXM4AWSKM9eICPIJoZN49IT2lFMBBGVRMhluJd24QfehD1awmYMndRCKCi?=
 =?us-ascii?Q?p1lwOgWDrxlIeigt8M5JjJGUCQz6+iCQUTAc1sj4Fmt8V/yczBFZiFZRi6TL?=
 =?us-ascii?Q?LAfBVIhurm0RuJ7QOsTT1VO9C5wi35lA82HJ/C9xdO/HhEOaKdp/Z/3dBZl3?=
 =?us-ascii?Q?q1muFTZy/wCLgXrhW/4UHZHrMyZg4HqV2VaFVXcX8U6fl5A9pHz+HgPUaxlp?=
 =?us-ascii?Q?F6zJBA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6747520d-8357-4cec-17b1-08de163d4470
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:15:53.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUJcyB3YwVJlMtLkxa3arkssngJcYWvj6XAf6hfS5A7eW3zbHoip/L+M3NYLxh4t5ayvJU/pO0Lc1EKjw9y5C9+WvdOHD+GWxS3mZZXLcqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6700

With CONFIG_PROVE_RCU_LIST=y and by executing

  $ netcat -l --sctp &
  $ netcat --sctp localhost &
  $ ss --sctp

one can trigger the following Lockdep-RCU splat(s):

  WARNING: suspicious RCU usage
  6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
  -----------------------------
  net/sctp/diag.c:76 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  2 locks held by ss/215:
   #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0x84/0x2b0
   #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dump+0x38/0x200

  stack backtrace:
  CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e9a6 #5 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x90
   lockdep_rcu_suspicious.cold+0x4e/0xa3
   inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
   sctp_sock_dump+0x131/0x200
   sctp_transport_traverse_process+0x170/0x1b0
   ? __pfx_sctp_sock_filter+0x10/0x10
   ? __pfx_sctp_sock_dump+0x10/0x10
   sctp_diag_dump+0x103/0x140
   __inet_diag_dump+0x70/0xb0
   netlink_dump+0x148/0x490
   __netlink_dump_start+0x1f3/0x2b0
   inet_diag_handler_cmd+0xcd/0x100
   ? __pfx_inet_diag_dump_start+0x10/0x10
   ? __pfx_inet_diag_dump+0x10/0x10
   ? __pfx_inet_diag_dump_done+0x10/0x10
   sock_diag_rcv_msg+0x18e/0x320
   ? __pfx_sock_diag_rcv_msg+0x10/0x10
   netlink_rcv_skb+0x4d/0x100
   netlink_unicast+0x1d7/0x2b0
   netlink_sendmsg+0x203/0x450
   ____sys_sendmsg+0x30c/0x340
   ___sys_sendmsg+0x94/0xf0
   __sys_sendmsg+0x83/0xf0
   do_syscall_64+0xbb/0x390
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   ...
   </TASK>

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/sctp/diag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 996c2018f0e6..1a8761f87bf1 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -73,19 +73,23 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 	struct nlattr *attr;
 	void *info = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list)
 		addrcnt++;
+	rcu_read_unlock();
 
 	attr = nla_reserve(skb, INET_DIAG_LOCALS, addrlen * addrcnt);
 	if (!attr)
 		return -EMSGSIZE;
 
 	info = nla_data(attr);
+	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list) {
 		memcpy(info, &laddr->a, sizeof(laddr->a));
 		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
 		info += addrlen;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.51.0


