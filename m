Return-Path: <linux-sctp+bounces-269-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346DE9B29F8
	for <lists+linux-sctp@lfdr.de>; Mon, 28 Oct 2024 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86EB287810
	for <lists+linux-sctp@lfdr.de>; Mon, 28 Oct 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3817BB35;
	Mon, 28 Oct 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="bpZ35MJF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8218C03B;
	Mon, 28 Oct 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103056; cv=fail; b=ZzRdEu5SrflmeCa0j8lK+JHctxycQb1C32a0WYKSRjsGoGySwsbiqb6LY47QJZoXY44Cs9OU7ISt6SCJ6+5iwV0TEo36e16K1YRSqmoSHBrzMNdvjd1SToQWJ/wZoWyCqe/YSVjSNmOHK4XSHd+N+l5qzYxn/3gxsogrXJr3MN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103056; c=relaxed/simple;
	bh=rUHBDT4trXJmkb5tyswTaGPIxsqofj4yArimpxGUwPg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a46IQLCtt194JJ5npYQearLeHnK248NbJOsOEjiLR43gIxw8vMVZH9RTetKaxDIyzLMDlEEx+2uSzDAd3qyii+fmGEm17Y+G7lZ9a801saFCq1BSal6f886mZFRQdIQRSZcIuoaTSQPFihDehHHY4zpPc1r50ks9ceVYSZCMo4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=bpZ35MJF; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5ED296C0060;
	Mon, 28 Oct 2024 08:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6SrEl6IAihY5iIfbk276cn7VTlnZ44T43nXIQJ8eIcc4SYmYoCL9CmXASxq82TLQngvMAKAfhwKwOlo+nppJJUSmgo2qcDBFxDSYvVr9bJX9lFvy05lfg+311Yv4z+QhLnlJoryv0y9MeuL3LA0uWRFs/khS7YHK8ODgCw1/nKhYzm9JqDRhqDj2wseSera4Vnf/eZAlfEgVKeN7YfpPHf72cV4oM5IUZZQo2DTtpe0Ey7KQkivIQmzMEYvPMuy98vEaBgY10u4sV8ieqxOdQ8Bv4GLxEnyGnXis+fgJvtLkZq1BN1EenvRUtx/iAjJU5HhII0UWqPPObBT/oAcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpwZHf6EQzxJWttrlJs/mDpuDq9smaNvf3KW1JbI9UY=;
 b=e2Qj4uUYbNC7czKxo1JPLEU9j0JmCrWwhW8BqJNojEPNhH0K8To5HORbj12rIbOrR5PGFjrXRNLMvbjkGV9xEOCC/ntqmUwxssvCUazrMR3WJDjN36/JgBJ8vOcU7Yq8SYsNZyBGQparBljY/s7R2Zzi7rzYj+THZY3HQhatuGS4OJwMU1GWJayAL80kFVGYDjYGNqaQWEeQ/PUMmHLDYZh7u6Sezi9eoWIYUtGd7ZX2xp40yu+c9zzL2PwPozHhv3bYcrjVlxQbtF++RJfJSAUk4irVvs7uqYX0mx5dTueRmah3Y8l5LqnoODptu+InzP2SB5W72ElEMW4A699ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpwZHf6EQzxJWttrlJs/mDpuDq9smaNvf3KW1JbI9UY=;
 b=bpZ35MJFqEFX3wbDTw2iTah34f9RvH2OWz+U+qH4ykcaUndcIUuQN3A8KjM32vonu9I0D4sJ7/Y0ja9cTsFUbuFM/uAT5yERUfUKwIs6wYiiIwy7zvQHWUrWubRZyQK4d6wKv9P7whPfdCoEGLxetGD8XNxMWiOYvHjMSop6iUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DB9PR08MB7841.eurprd08.prod.outlook.com (2603:10a6:10:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 08:10:43 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 08:10:37 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next] sctp: Avoid enqueuing addr events redundantly
Date: Mon, 28 Oct 2024 08:10:09 +0000
Message-ID: <20241028081012.3565885-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::32) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DB9PR08MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 15487743-1ab7-4385-a184-08dcf728018c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bq71RQ3j8bTjvdDmR7LIdnw+7Db34j+5c/7KUJg4x73yVrwJunvRYg8HY33A?=
 =?us-ascii?Q?tjEzDErzPv3Y/EQ/m0/H+HocK4dCtLSsemUsVF9iEJ67BsS798tXbdVAtA3E?=
 =?us-ascii?Q?zD6ciLj/olHEEIRYBJX/JjhxoN80RzED3CnIjpuvWAwmBO30wkDPDzJCCwc+?=
 =?us-ascii?Q?9z+S3VGGI4kPJepww8C24Xl9U2iqrXRxi4fZF0GrQUOTk7ZLzqjxx7Q3GTv1?=
 =?us-ascii?Q?bBGbkL2pVAKqYL5me5hNA96P4lmNV2h4uQ65yhFyi+nR5b7W0eKoaxJOZuAB?=
 =?us-ascii?Q?eIgeIZR9CWa1KmRwwWqZ2hNVqIwRv04Knp/wZCi3jl9UAhDMuxm+z/f5bt6G?=
 =?us-ascii?Q?80wT7kKGt6rAU1AlwwW9pkaoFzRzCc3C+dO42uqb5txw1FeMFT5jFuxzHnwo?=
 =?us-ascii?Q?qjk8+6gmc3U/9XGL0x4t2Err8IV8ESIQ1jIQSnekuaX2c5bwXyVGk8qBUbAq?=
 =?us-ascii?Q?W2cEZsDMk+7D3BSnVONzU7xlftOLboF7I9H+LMB13l5S0eqhjGxQYtSPZ3VP?=
 =?us-ascii?Q?Zceo1sWQ2MpT+wAJ3Uv93uQgIaRwv/GgVQxt7NcjSkDPUHvIOcEMdzOBs9FG?=
 =?us-ascii?Q?/h2joIhigjl8astl6p/At5tiFfXJVRuHN/zLpMhuBmKC5pTyvzdIAi7eWSEi?=
 =?us-ascii?Q?t1tyEydcP6U5+6FKxhylHR5DK8P0hLMG58V5tAeJSJt6tH3qkefB77QkVQga?=
 =?us-ascii?Q?U4Z0GgZyILAxuHJcQ7cXIG60Rq2t/UhQEKVAr6rl7Xtfm6nuDL+r3US5P85N?=
 =?us-ascii?Q?ZP+cYm8vvf98O1D5lBxJMBf1L3shqNbmRpK1EnNvJi8go0h/KHk+X81N4bUf?=
 =?us-ascii?Q?+BxKd/jamQnbpjey7Yhmkx9/m4j0g3cvjSFO7UeFIUg+MeI2teu2VP5+55/f?=
 =?us-ascii?Q?v7csk4UrpuQW5itu9kwG8ZS7gpSGNDJ3wy0gSeJZyVCVHUr3lRMyCQtmwLMf?=
 =?us-ascii?Q?LtoQrQNsRLzVxPaCl/sciI9aWQCGb459mzsIcu3cSlaPBijOMSPwM6xKT0tr?=
 =?us-ascii?Q?IkBlLyM2TtgufqwCBmaJVicnZdjy0S1TM0JpZu4I0gKOQJAf/qMqJbWspPzc?=
 =?us-ascii?Q?doNYbztymiApLrE7EWGtMIC1NUtVC4E3VWKiqYooZNtc/yyvjP736XXHoM7A?=
 =?us-ascii?Q?8I/ms00VR8or3jqkpZ9Wh/xvzAXmnfeHoV/rTITVk9ZUfT5DfKWmhCTPtgsA?=
 =?us-ascii?Q?w73I4/OVptECNpfcQBfgOkNCTgmO9jERozB08D3uQRvp1LhpPbdmZM8ingT/?=
 =?us-ascii?Q?wSEgHgxCLBzycXPvV3zOFONBY3VGuw17+5J1ywSo5H3CvhOYPWSG+4I/3/w9?=
 =?us-ascii?Q?q/e470gJrJs1qp7+2iB61oTVJpJ2cP5CBkukQPl4Beepps857yuDPFiekYzi?=
 =?us-ascii?Q?YKg3T/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zzg0tBdUvUidrQ6xSjrSOKT+2yQl6LSSyUwlxzjqV29jf9he4mOB57qiGgnP?=
 =?us-ascii?Q?7R4B7mJC5lSkEYQfIqA0BCftWTmfxyoomF6TjoMVR2EajR3l/kxfMt4uJALJ?=
 =?us-ascii?Q?m9cfo2+hLSVfSbDzPQwStVe0p0lzhYG3GbF3MiO0dhuo6UY4u8RJHgyMWR+g?=
 =?us-ascii?Q?ZjOGQplUWQxl1+/i+lgMvCTWt2n45Ixjc5sD3CG8FXYdxqIX/mjcNOTmrHD+?=
 =?us-ascii?Q?yamtjMmZUXvWRnfLHAZid3EOoMI2OuLwzjW1rHYYEGLbIhzUC3R5iPnwlTk+?=
 =?us-ascii?Q?QYksmCO0m7IVEAoQ0fecEvtyaU0i1WRdsvBylg+7Viog6K4Hw8jnXBA6zKoX?=
 =?us-ascii?Q?iqAJnHer8ZjQS4JqIGUUhZa4kbpeDtVx4ejN1PP5VfiiCJikLsDPSsLZ6CjG?=
 =?us-ascii?Q?GvMYiybhjspbFrAmVz2uqVdkQ9LtyGngVif1IrGvmCB0c8iY+GSfsb198/HQ?=
 =?us-ascii?Q?RtSteDlyE0iH6soOiHoghcE0EBthdqN5IUfoXDJfcrwFHUkScrNLXWPU3gd6?=
 =?us-ascii?Q?3Qy41H6Ohzo3HSjhdePVSSDofIiqlnL3GvmYfc08pRqaZ0yCtdb2XSebdbQY?=
 =?us-ascii?Q?zK/vFgpVbrC4KQRlU5y3pgCa6V2XiRLOmSuoR6iRviFYXq+Juv0L1iCuxQwk?=
 =?us-ascii?Q?ZuN7M6CkKC8GlIPud8CZQEqWLHkH7nbQcucc5A7PpzKaxY9Xr7BUqGW7Tr3l?=
 =?us-ascii?Q?GIWxYX/ii6PUqy4/DEczF3H76gUW1DtK//1FQVIpcjzuKyB3wJtEI1kxPUrW?=
 =?us-ascii?Q?skLgGU4bzvHNExO29ynJRo9ctZw9NL5PgzzEtD844OVXP/FYes/e65PeIvf6?=
 =?us-ascii?Q?y7Le3iMlD9KLDGlu7BJqjnqczOV5TI2oZdTkgtbYxnaPKW+dss4dmEAe1klB?=
 =?us-ascii?Q?0F+bDByO3Vko20wrxRWoJB76tm5RCvNciRegZn64oUmIgecIovdw3MnXJQy7?=
 =?us-ascii?Q?B8yfsewVxJObipMV8Xqc0TlN3/vGV0PWfYVfC8iqAnjAx67u6EK/w+0bO2WP?=
 =?us-ascii?Q?QU6BEQBSbmNzh0XJrz1KlPvEQWknkyXVXyqIQGzxkMq4Lr8BabbAn+lxF1fv?=
 =?us-ascii?Q?VubiD8f+sL37TumGuASWv6vwfrgvw3tpeOj2pNK783B43hzNVXq8uRAuw1GI?=
 =?us-ascii?Q?qgNzfMOuXPNh1cnWQ5v/vIHOtBphXrOyCIB0Jh6zWgY33AfR1DW4FCsoeLH7?=
 =?us-ascii?Q?R7yftMyqXNXP0CzQwOga5ikzOAtOZ2gddOmGJodT/Ls/V5Q3Fu00J0cE8G7X?=
 =?us-ascii?Q?izxjsyxhGEWDIUpikEunOmHE0f6mLg1WexWp1Nt/sqfzSFjxEf7SNxUeVfZ5?=
 =?us-ascii?Q?ELvnOGEi+mZ/qX6iBW1psbQ39/pcUeWxCbxtGdL/LmRhSn2wXNjYKdGGqrHK?=
 =?us-ascii?Q?6CeN3PPiZSDcw/bxJFqjBE4HOVkw70HFD20HGZ3Q7Aeku5m+6uxw7GQ4x7iQ?=
 =?us-ascii?Q?hJnJK4v6AGLuB/vWQp1NROPn8d44ZfKan7SZSVfcdWtmTe9nxb901hUBcyH9?=
 =?us-ascii?Q?gpsq/PB4TiATXHtRUSROFRKr7M4EMn2sHIAmwW9V3cjTpwGqrZekaMPbdyaA?=
 =?us-ascii?Q?DblAZK95Wqz6ToHtFDeYZl+xiZhrP6AkF2cDnNqf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	croxcPfP6HSxZHxFPWHu/N3Kr1jr03n//QPUzRUYB4K9PLYCL1ynqZ25jyFxSV3lly3uhHcgnNnRKqe15UOogHcok908YHMNCZgGIzTGrCJqbxNAh4G2bonu5B9FdkelCEtyBTz56krlA82Sc1NDH5GBUMIgj2FHEp3ZmpII4w+J9tggQsiFTuLD/o4pnnYvtUmpAB9/olkfAS3D9Bysg1qD4ALStm6lZSPmBESiK7T84WBXh14S3a3bJB6+o43zXqiZ792CvUXfMWPluzZ/2faVVOzElzVDpHd3KFPUG6oA8PFnkjwXf1n1NQL9l04DJioVwjJh6MdOsbzf0KKlmOXctyAQ4NEGLc+f9gGvG/5F4pMdm6WeK9e6Ex+lEoq4Mb/eNcpEHPuJPOT89o1PSoWTnapQ/C4jve3rwuWit5+FOUvj1o123cIf1AU+y/Xj2MdIigv900PzCln5+aMh0Zc5r2bQ74795DChPYtLBsjRIun34MmO9PQdz3WBjmsexr+86qDMUFVjhwhAmflu5RQu4W/NOHeOhhQzSMSf08NjkLzZ+jF+LkqvwCYrLL1aSCkldqyhKXdhiOzWAolfYihZ+krlIDhEkcWbijwEL12Ic25Kpi/uaB7lD6Kguose
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15487743-1ab7-4385-a184-08dcf728018c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 08:10:37.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWO+m+kU2LmIBD88SQxwtHSEbcKlSXtHyt+IU3lxNGJAFpOU2Y35V9aGyqH0yY/8Zz2Y/avb8mrPyXS0rJ2Oxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7841
X-MDID: 1730103046-t_UVn2DocGQx
X-MDID-O:
 eu1;fra;1730103046;t_UVn2DocGQx;<gnaaman@drivenets.com>;7bea9940ffb8aa46f58eafa9edde571c
X-PPE-TRUSTED: V=1;DIR=OUT;

Avoid modifying or enqueuing new events if it's possible to tell that no
one will consume them.

Since enqueueing requires searching the current queue for opposite
events for the same address, adding addresses en-masse turns this
inetaddr_event into a bottle-neck, as it will get slower and slower
with each address added.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 net/sctp/protocol.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 39ca5403d4d7..2e548961b740 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -738,6 +738,20 @@ void sctp_addr_wq_mgmt(struct net *net, struct sctp_sockaddr_entry *addr, int cm
 	 */
 
 	spin_lock_bh(&net->sctp.addr_wq_lock);
+
+	/* Avoid searching the queue or modifying it if there are no consumers,
+	 * as it can lead to performance degradation if addresses are modified
+	 * en-masse.
+	 *
+	 * If the queue already contains some events, update it anyway to avoid
+	 * ugly races between new sessions and new address events.
+	 */
+	if (list_empty(&net->sctp.auto_asconf_splist) &&
+	    list_empty(&net->sctp.addr_waitq)) {
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
+		return;
+	}
+
 	/* Offsets existing events in addr_wq */
 	addrw = sctp_addr_wq_lookup(net, addr);
 	if (addrw) {
-- 
2.46.0


