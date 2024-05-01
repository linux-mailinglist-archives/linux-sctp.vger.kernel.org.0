Return-Path: <linux-sctp+bounces-145-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2F8B8E55
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31721F2326E
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6548D27A;
	Wed,  1 May 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ppjLnAXA"
X-Original-To: linux-sctp@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2077.outbound.protection.outlook.com [40.92.74.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0ECA40;
	Wed,  1 May 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581453; cv=fail; b=bPJbF1tXiUzufkhf/LMKJaxwPxMNsez4JRef8G44mPvGWNqKuw1C1qHOxrY2NhXoAQGHTfux/AvxipxS3nvGIRwqOIXB2kyVzsKVh5/DQRmSNwaeLdc/3VwY0ACxM6iDfcqg0rk+be/dolf5I0ajhJvKmmCN2zvL2zd5e7rpQFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581453; c=relaxed/simple;
	bh=OooobC4A8kqMtKwMra6Ngc2WaKs0SGSrVTHTuxpEedE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCsTI57YJrWR5DvBKlpBFKApwLi1/J0NKJ5FLvD8wB4xTg5xetCqTiWnNglPGfeT23eSRrit6TE5ZSkW/ehWNCJ6qHIoqj7tIg8LjOHfHb63u+0t/riJoJTln1ZpBuG+th8QmvZr1DWxhWOImUfVxaC9S7tj8qCUoyT4KOVlPXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ppjLnAXA; arc=fail smtp.client-ip=40.92.74.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuL78lWlQEEM9C295ble6ga1xW8+WX5tQZBspe/Nfy24mzW2OxWX8gTHzd/NHUKpTlmtvg0M8FwD4CTQS+jxsdri6xxUNrUm5qlPYbmR3N3wgd+RgFwfSxtxxu3dSfYXO0ou0FSV0cuNnJD7YjFlqT/Od8UiFtVcAFScrNealbUU17nXj+zw6aM0zzUr9bReHFL3Nw3mxitvtLJcS8JFsXSNlBcL9kkDsiKeEaGpWJJ1ZB+8e1vdOv3z5HJ3O8FKVCXNyqdw0TfKrA6XE5WgQoSDf9Wd5vqXbYg8fTEBp5twVm8HRizjqRm2dpdgk+wS8Ya8UyzM0/ciOiR1AhmVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfsFczYG91bQA32ZlVBrilhwXs7nxmIlA0HUgNxST0k=;
 b=JbBP26TYlE+PkOalv0YCN32Qmxsecq78cI1f8sgyGKbA+ZTzu9qZtBk5WRcH7WQFizFZ9S883wD9AHkASsdGMZb5FsfbyoruxfBVHV3BeJ59f/HJ3Q29WIysNMswMcVNdCBqSu2uk+idtJhqwnJztUR8kwtxwNbGl7CTBs+jMJSAwmsNf/GJO8ZyhtoN7Z6XtplYEWZRpBY4hnQ2pRtYEgasrIKDjZ4/4NFwFT2U5q95BbCRcgQifoqBB2EN7HoJHAuFDjLNxEMED0NPm820hAWwV/LyXXtDY6Bo9DGUxyUfQetMrmCtiJFKNku6tymc5DLlsBDbo2XwYmIvgN1IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfsFczYG91bQA32ZlVBrilhwXs7nxmIlA0HUgNxST0k=;
 b=ppjLnAXAvZoRBVZbZwQkaDMIiDeh50R1kwbpmFwe7a5OJEGV/db9kBuUTlyREhYRfd92DnXWwy2q7Z0TUb8uoESstdjA2Bde3f33zTU7nWIJl2ltV9nAN+Rs5ENaMjTbHwoeYWlhYGN0+AuPdv7CUD1nk5bGV9AcJ5B5zdW54JvQb4C3cv2s1eyKPjY/7sMCKizqCRAkstRO1uNliPY/JyD7dEGvTJN7+2wsE/r6LRmF7bBmjDrb5MxxUc3TKxXqgzCbl83LlcLNkP4+eQbjvp+yBc25E6WJm3eofi4Glyd3rC+QoiwpuYbw49oSNdDGMTg0bSOLZp2lilwHZgDm7w==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by VI0PR02MB10768.eurprd02.prod.outlook.com (2603:10a6:800:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 16:37:29 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 16:37:29 +0000
Date: Wed, 1 May 2024 18:37:18 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Kees Cook <keescook@chromium.org>, Xin Long <lucien.xin@gmail.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sctp: prefer struct_size over open coded arithmetic
Message-ID:
 <AS8PR02MB7237FFA530C63CD23BCAED378B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
 <202404291044.E9A6A13@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404291044.E9A6A13@keescook>
X-TMN: [18fQlFTCXQDkNU0VRO5NxCCU0JVepnWa]
X-ClientProxiedBy: MA2P292CA0021.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::13)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240501163718.GA2735@titan>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|VI0PR02MB10768:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e5f06f-e1a2-43d9-d5f3-08dc69fcfdbb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	2cQab2gUCmqyRYobw6gPY6uBBDX3DnG/oEyCAI+8xd1vKCXl3+ecEbFfi2VXnRTBw9GJQjHeCMo5XDkEtT/WQPb8iD1lMx/rRXzbix9PPbawlhyHgktKxJh6K41HP1wkHHYxFMe4My9SF9y+mpomKkHVhixmIVd97SMHIRhHzhvq2UXrGaNvd2e6i9W1Yxct1S8MJzbPkwV9PP+KU+IijIQkJtaHMz2LzfRLAchOndB7ksedcoBTDUj/8mQpVLEXQef9xxTr4GVvraKcIgKYYpdjxn+GNYGw1IQtkf+ekpHHtNo6x9xo24eCMeJAUtgaLoPWvp4bCGU0UVnwvS6i6SO4w6z4tkdWbBJZYibCuC3X/XIWTjHi/usRsO/wxUmo3Iqrncer+HDOcFMi5JYMLVOxasXrc0zwFRvSrWhl+xLiAbz88KQPVcPlRDTIf9s07hiMVYd+3elwC/xrXOcefG8BNwS7IquRo9dBGC0lQ1S0mdRaQNQDRWvjwKMHKoD0vJPrtz9gwsGU+uXY7FiNHPGEghRFUqNwaKzm9Ogiuz8tLPOxMy/JUJ6P2pVaumxcYr8/sBbSsmgYObzJPLL8C+CQOeBHmoDvSzMds1BogZjbq7bXe0cUizSVMDqfJFZn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2q+/a5b5VPjoDgsODGSQ8KKICd6RAw8v743y3Ux1qdjM4pgPnXw6KWzCimlo?=
 =?us-ascii?Q?y1CCK4+HJ3m1nvTn4uChMk8ac7z4HUkIEPNZcZ2dpDtDT4BlvcIYBU/9YS3B?=
 =?us-ascii?Q?jlTItyQ1oHnGOFcQYEssEXffZUu+ShH/01n738gw+VmI4sUiguhITdGTsuRe?=
 =?us-ascii?Q?DsDvXzlkbF2D+rhfoccaG89NmgNn09I7FtqI4LzOqsColBu0YJT5yv7EDUAJ?=
 =?us-ascii?Q?HRK/y744CTfmn1cC7nTqXnTDOR1BACxIgZpNtlhuhzHRLX3MzjMjs4Uv7Fu0?=
 =?us-ascii?Q?RrdeDPvaRyrs/2BHoRA/nXMbvBP/zB8Gfo8s1Q6yhw8wS4QS6jiCYtgfJw2l?=
 =?us-ascii?Q?bSWx+4ATmjs9pxi63nxJda6Oz5s7NMG2W2pC36RTrkWaRaWrHpIzWlOcfXHK?=
 =?us-ascii?Q?grIWq44jD+qSPagOpxFltxmaacTW788qIuU4RLoSMJtKCC7SMn7mDFeNGDft?=
 =?us-ascii?Q?398ExM/W61KxuFLnB9/SzW2fpotNkDmyN1L1NwhGjW8LNBYN67MWC8RLYVe3?=
 =?us-ascii?Q?tLJjy2xsEWfnUsx2DT9E8bIhZKRPHVHVV9SpfDcy+WMk64l/Ar586hSWCWCk?=
 =?us-ascii?Q?yOs8nOZHbR/Pwc7n7salNM0EmOlgso/5wwhyD7OS3wOj80MUNqcsfDgcxpFU?=
 =?us-ascii?Q?AHGGaTvkFB4X0oipH9s4cMdfaZo6IbxA1Oz0xE+mZ5/1Cqe3QqWSmnSVGsR1?=
 =?us-ascii?Q?cr5Nk0LwfbOg91bQejMxKcVnSUA/2TP7sRpl6wt+4QkSu2cxWGX0hs1J4cFO?=
 =?us-ascii?Q?cRw+OAE/14Fbm/ESfiCdnW+mI3K7hRwH/lh+rYLwARpctFvKli3s8EGNTjli?=
 =?us-ascii?Q?6Y9cdyhfRlLmM3y43x49gg1qK1K6GRYNHFfoMV2PUT3hXk2NXxyIk4BuvAie?=
 =?us-ascii?Q?CwcGPFS96u3YcVBGeNcaEI2pjghOzZzNSuZWKC7NxXkP8NHA8y4SkaddFLb5?=
 =?us-ascii?Q?bhpxXw7D+X9dJLGXV/y3jSHE1O1WO6pBziBAZL6BPt+1r5PyvPreE3XK4vZX?=
 =?us-ascii?Q?SjhaE+PM5lECvYN4eM3QHliqh24XCS+NxIijqXeSfeYIskLpq5LcvNVlhwyT?=
 =?us-ascii?Q?8fVl3i6fIP364/ILymA0UcfDTOsJL8ob1gCDAw4oHSKpP6/hU3h5aGRAGXUg?=
 =?us-ascii?Q?5dy+YRb4bTm0ocqZi8p2T1Q+ygruTgd2LL+ieWY+D6bgeIYn6cckId2UDB7c?=
 =?us-ascii?Q?jUWSOBZpWHN31WO7S7R7arGk/TtcHMzbi9PSfr4naHC+jAr4HUAShuaoJwgO?=
 =?us-ascii?Q?jIgdU4L1U2XNTD6EaFT5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e5f06f-e1a2-43d9-d5f3-08dc69fcfdbb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:37:29.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10768

Hi Kees and Xin,

On Mon, Apr 29, 2024 at 10:45:20AM -0700, Kees Cook wrote:
> On Sat, Apr 27, 2024 at 07:23:36PM +0200, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> > 
> > As the "ids" variable is a pointer to "struct sctp_assoc_ids" and this
> > structure ends in a flexible array:
> > 
> > struct sctp_assoc_ids {
>         __u32           gaids_number_of_ids;
> > 	sctp_assoc_t	gaids_assoc_id[];
> > };
> 
> This could gain __counted_by:
> 
> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
> index b7d91d4cf0db..836173e73401 100644
> --- a/include/uapi/linux/sctp.h
> +++ b/include/uapi/linux/sctp.h
> @@ -1007,7 +1007,7 @@ enum sctp_sstat_state {
>   */
>  struct sctp_assoc_ids {
>  	__u32		gaids_number_of_ids;
> -	sctp_assoc_t	gaids_assoc_id[];
> +	sctp_assoc_t	gaids_assoc_id[] __counted_by(gaids_number_of_ids);
>  };
>  

Since this patch has been applied to the linux-next tree, I will send an
incremental one.

Thanks Kees and Xin for the review.

Regards,
Erick

