Return-Path: <linux-sctp+bounces-304-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A8A02175
	for <lists+linux-sctp@lfdr.de>; Mon,  6 Jan 2025 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6480B3A3373
	for <lists+linux-sctp@lfdr.de>; Mon,  6 Jan 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EDE1D5ACD;
	Mon,  6 Jan 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RITJLoOX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131B2B9CD;
	Mon,  6 Jan 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154478; cv=fail; b=QIeQLz+9cDVJnHO9p5fJYnq3/crUWdYNZFlM8asqQyCWy7+w7C98KOYMMfzoo9ib+9npi5X6EaUoKUO/YkuBrOe0btod3OerYiJpcCxB7T0k76uH41ahrQmPB4NA8lbHREumazXlVOVkkfCRjnFckwVksHyDCTVUkurvM77Q5yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154478; c=relaxed/simple;
	bh=M60l+8P/3Sb7RDxNx/JEjjF46Y/gjwP0JPC2osCu8Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sLOPFOuxV1OEJdgM5ZfEppH/UHHGdCkmoe946XRyNjoA/Bhoauzz8NQBgrE0Zr/UoSJgM48lgFpKW5FxZyoK8IXMAtJLcsJODTlJ06VxuvxblR52tTLWSAfWjl/7NgIabLY1iD9dZA7cqFhsBIvjDq3OnFGla184tr73DJUy5fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RITJLoOX; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZu/bAmK4Kg/vRncSX1uf8USYmwpfz/nUwlFYIV+nC4ALBMHBuUTM527FtYofQ+vB/FTQxpXKG0/603ia6hpAb83GZYBmmF58MHb9u3hb9OdCHo4CimiQ30hJL8bi0L4POVNmuZMnNnOraiKlPXz4L17i8IFJutphfqXaIoz330yNz2RHNC2EIars3HoNqMayCUKaie4xrM2MInpRdfsaGesLx6LofolD+lQRjD/i1pW+zQ/eFQ+Kx8ojAwk787QjKv7JrjJylj3Qe90Z9VspJ9D+HpH68th22hdcWb/xffDLqcEabP/9/pFeGOxBygsNm9mT6ARHrdIpnb9cIs7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bFfTTGouookGjYy81umFN57p9UCWid1Shti8mkwBYg=;
 b=O0ExVT5k5dq5lE3W1bKfKFs6Qi62okaMrqciwXEfkL1sZTG7NPSlzpqNi1gmyJ3sQ3TSPnSHtuHCkWvcgkaJlHviYfQlN8monWFGQmGavLWxjPErEpLu0IHZ65vYb6raDRIXPyKjaFiC6cdrBOYWTUfQ4KevxreX35MrphYzkevEdTwsZvhjmdxu2p7jghs7GPm+p534uxkG7kyYoMjuHl3CYImfsw/WB9XWL8h9g/OQ81FL3JDRoffojW1s/U6yMXKrlNSny3JZOoplgD+4H85XLBQQNGUwRoqxxEow3A0w0JgGMLpROtGUTOOkp55wrrg0s/9nbyFA/mXT49aD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bFfTTGouookGjYy81umFN57p9UCWid1Shti8mkwBYg=;
 b=RITJLoOX08XgKop/d4qZ+z8GoHd3wHSMStyZUrsx/tMyr0V8EiImGhYW95eCPO/JgXpyfmt4CpeKSeXwqXGp0EY1NU1lx39o2R+6U+EJkV3B8LkYaJZuhpWKcjjFGEDJe68x8YTKvJ5Nu3Jf7WOaeDjUzG5vfZIeUlC2im5gzizetXJDIYkhLVuyU7YioMxaOythPQ5l7lS3PTsRc5bG/aCqbxS37YXbCMmB/5MFtpoetn2LTUTe5/E64keWnRIORztn+0sF7bRg6I5aO1TSQ7V7lfJljNiscdnfsqTdRJbuPP8SbtW/Wod481c+/HsYqjTTa92ndq69san8PsGx+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 09:07:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 09:07:50 +0000
Date: Mon, 6 Jan 2025 11:07:40 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t
 conversion.
Message-ID: <Z3udXOESp_mzykwn@shredder>
References: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aabbc33-bf27-4ee5-7b69-08dd2e319895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1qEM31ThmFvBylzHtYzNuRkgo+EESk29dmdUH24F96Zg0CyC7XFugAEfU25w?=
 =?us-ascii?Q?ayJft17nncrqHWQLDtudMBDq2qsiw2Su9R8wn1OhmJ8RcQNxFMO52IGQa589?=
 =?us-ascii?Q?Fy8AS+L8QM+DwNg21jBX0Jz4uvhe+YhKetX0DkEWBMtqcekrXSrAWB0M9rpD?=
 =?us-ascii?Q?lADfJZ4JxZbn0KgYqeG7Dvo4JXW4u8gzVA1zBxGqNEb7puYtniVfWKmip3X6?=
 =?us-ascii?Q?oiW8riQdFRj6E1piPCxQfOr8pGZMpgW2BXDIDY1U3YjMDsWtiJHfvkcTprZ0?=
 =?us-ascii?Q?sPDOnGefm0UpOCwNembcAPBj8rugKIqp76ir6fvgi9TFMGRmjeXgzNI88IPe?=
 =?us-ascii?Q?W5f4dKNADHmWjl3XLXhXyx6sAgrbgaqA36KjkFsjRKVij/549nsQ37+7pq32?=
 =?us-ascii?Q?fY9lbqqrDyWhkdB3BjSKPDqBVwBqooYN5p/a39T53QHP+sAl0uAqx0wuvXny?=
 =?us-ascii?Q?fAsS9NsiPfz0Jb1GkIuz1MesHHufJ63bmZC4y/x0UA31nr9627giPmbNtt1p?=
 =?us-ascii?Q?zBE30RZKD14WSyIsyJiej63TUZqzkcJSVnPLsbKMZc0D9I3K87OLP+Rc5bPr?=
 =?us-ascii?Q?PgwIEH0rPhRnRP/qaa3UHwTkAJnpR5bKo0SeA+G92BHoDHDSOsCuoJBAX3V4?=
 =?us-ascii?Q?kpsGec1//hY8O0UN4kd0djVzzOkDUCOVlYhowU3Y+G3rVYKpXGSqxrzYtasR?=
 =?us-ascii?Q?7jOgTAZ/4lsxgGN87ddkZzrRUdAUDyYpLPLmhDox4qikr3i3HdNwpfSF2ta7?=
 =?us-ascii?Q?ooqLgpmqKMw3yDNBYgYFSzMYeOYZQWwD3OUjgRbk1i/cwzxTqAZemKIA5sG9?=
 =?us-ascii?Q?Z0czIGbwkXSrLNjPZ2ob9Z21jM+DQZYWBvKnhpJFEUJv/SO3Chu64VLbykhS?=
 =?us-ascii?Q?7fGzHGc/5GV77xX5EAJDllWpDULwGjceirmyY8BMu5GWuTs+exzF2iCIu1Sv?=
 =?us-ascii?Q?5HvnAfegbe4FSF53BHrCU864aEuBK2AEUSeLibQxvWBTBChxvO5CcgRnLB3C?=
 =?us-ascii?Q?Tvc/qsZaI1solERtX/rKY5+ll7a8NcJuP7ml4IGgi1vvXQnA4KBX1ZF6k5Bj?=
 =?us-ascii?Q?cy6fSFhjP0wgcYrpxKVbQDcX04qGKZxUEvBmfK5X9VjUUIQJXuzeL6FHbGUZ?=
 =?us-ascii?Q?50nkf8omy+erDuVVfi5J51eJSWCYo70hFMAtpcsI0tDcSm28nOkIuWjPdqf7?=
 =?us-ascii?Q?Ya+YdrIVcQRqOLPex6lU1DnohX8ypNNe3SiT0Z+oYFIh40kJnbffljNYL9pM?=
 =?us-ascii?Q?3uG+tlStuQpYgOM75tx/jfdt4F2nWYEzijRlIk5KAqBvVryKFBMskX9Y+cfI?=
 =?us-ascii?Q?bZR7DZ4chYyeF7meH6W8AwDXYbyXei6G9Rn5Yz43Ok5K4GQ3va2Jz58PFG++?=
 =?us-ascii?Q?uhRy02CRR+78oKBHZZGlpIqzEtQM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikOQqTynv/I1ZE1Ba1LNIjb7beQaD02/MwqHIPUG9gpBBQuWdhD1m4To21tg?=
 =?us-ascii?Q?JoN0wrzzZCzVDDxFLkdGvFPuVL62Sf611q/FnxQPOLrKGoVdomTM107NN+1F?=
 =?us-ascii?Q?EJooQ7/obDzIsIcGB6504EgZhRDg6zTnJ39DxnQP9gadqGCwxFJpaKrKn5iz?=
 =?us-ascii?Q?57L9Zv1cro6O25qcgepb+KgSg89Cc7pRQVGqSbTvpLwuZCUciSJPugB2Rdzg?=
 =?us-ascii?Q?D/2IT35xqAuhPutcL0dkk3A0tFtiHSVD8M4FituC7Wird7JCskdixVvSLnrf?=
 =?us-ascii?Q?sjFbwfNGRyUCmLXs+ySM9SO2Hc6OmcrBoe8kIZNKYxyAycm2L29eGX2JvDTn?=
 =?us-ascii?Q?G5j0n1XZVxPZ76GzirNa3iKFEPkyO30BBWkg7iirkP6d/hFpbMA9rU1lU9hO?=
 =?us-ascii?Q?oDCiv+d1wlu/fC++VK19kYr0VyoSGi1CA/q+5whL0czuuGF4P5P/Tq+GCUtT?=
 =?us-ascii?Q?sf82T+jmUzrNj9kNReqVg6u0O2Rrm/cw1Svs+YuArCUFpy6pYYkt0NUkpzSp?=
 =?us-ascii?Q?43FbhVCHUaEJuMN17y19f3ZuuNHkl6ibN81GqdI6Dt3l458zNTxPfswRcRHd?=
 =?us-ascii?Q?eh0qVG/GFt/1FiVy6kb90PeqGBG7qgePI2mS7HsyUfvIbsBMS474YEC0Behd?=
 =?us-ascii?Q?5YtrLz5ZkbEqgQP3xsPE6JWPx9VQhNsXCtraKsBTet1YfLpWoydysJGGmQY3?=
 =?us-ascii?Q?6G2oKPFNY5BsZLwFBEDiq513hmFpN/cYVUJzYb1pBsaENsRobNQLzo/5hLjO?=
 =?us-ascii?Q?962RsnWxEtxdhUeAoChgq8H9IzIWkQ1sLhdo0hgnJLU7o4kahUOwORGU4Hm2?=
 =?us-ascii?Q?GJv4i2Wpy6mwwoyarrB/FmYnwk7BFguSYLXzRNmt0+NmSO8Ilu6BgCpCTyWg?=
 =?us-ascii?Q?xnmmhRYZMRQwvPtV095aUafiyH3R62x+BnRLbOf8aW87eWdESVX9QOgnNsOD?=
 =?us-ascii?Q?UuIkiZN9Yq0xDsUtD7cO6y8UxbJ8Ht+kdmBQmfbfWirmCdJasUM4TzTKSN+v?=
 =?us-ascii?Q?EIp+hYKIFHJXRC/DNHtGIJZgjSIccOl5U7bdwSGeSH700v9wUMl6xm8LvUEP?=
 =?us-ascii?Q?p1oY4zaQ2UQwny6136Y9HnEr7zavb+NuTDq5xFrYygoeJJHRyMfbGUdMLaGh?=
 =?us-ascii?Q?QRa4sbrdOnCoGfMrFJiq21oKOj3j0sr6LsZHFBkHYRZQE2b0oGjejsyrLAYb?=
 =?us-ascii?Q?+Xtx25Nh4EZU7zrIrceKVBG0FuiOhgn2BbdRfnWdTbBoPQ0OSk6jyj0VSn/3?=
 =?us-ascii?Q?HWxD6aHaJTvKm89A8WgTl+1mZp8ffWNyG/czEd8cy0kp6Z0nBoMy/1qvKotw?=
 =?us-ascii?Q?CO8njAhmj73f9zRyuk2qfWJZlVi3/xFsRPYj79sSKIWV41K9fUexFZXMTDSV?=
 =?us-ascii?Q?dNle0/CwfZMOsx+uIawe6CVo/zWyl9luUsKWtOhO3qVlNid/+t/WZjxGQ3nE?=
 =?us-ascii?Q?PE5RXB5o7v96c3UgWt2SsYoUC45vb/0ZJN4BM5gZfddDGY9m71eiyXlj1exg?=
 =?us-ascii?Q?vpg/C4NF8l7NUq9d5wk/dRCgLG07X1jlWIVkz72uwKDMWffrsSYzXfAWlmEA?=
 =?us-ascii?Q?pds6WaEjsrWrETqWJyUexjbdpsgP4IeRkliwxEMg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aabbc33-bf27-4ee5-7b69-08dd2e319895
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 09:07:50.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAoPiUipdFLQprf1TTUvICBgr19XCebMt8/iFgYUWDJg9ohy8UbDzdyY2iMeqYK32hxwlLgSZv+C5FKwwgRB0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789

On Thu, Jan 02, 2025 at 05:34:18PM +0100, Guillaume Nault wrote:
> Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
> that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
> variable. For the SCTP_DSCP_SET_MASK case, we can just use
> inet_dsfield_to_dscp() to get a dscp_t value.
> 
> Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
> to drop the inet_dscp_to_dsfield() conversion function.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

