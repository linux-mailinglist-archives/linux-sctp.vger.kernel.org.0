Return-Path: <linux-sctp+bounces-167-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A28D705A
	for <lists+linux-sctp@lfdr.de>; Sat,  1 Jun 2024 16:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CB51C214CB
	for <lists+linux-sctp@lfdr.de>; Sat,  1 Jun 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBA2150999;
	Sat,  1 Jun 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IVShz7aA"
X-Original-To: linux-sctp@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2090.outbound.protection.outlook.com [40.92.90.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EAA2A1AA;
	Sat,  1 Jun 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250564; cv=fail; b=K6n+vzcQ+34il3J35wFaGgPgyV2ld969eRZi5DruYmYVkE6YJjqYfFpwoB4AnptVo7XkkAFaM2bMmgNhfmkchCfXkAZgldmKBd+eWIXejCPNYMWkChrGzQSwYJyZX01J5BuJ1j0Hq8Re14cFZjJxB6MCeyhnIykcZ9P1HLAy4ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250564; c=relaxed/simple;
	bh=xZwwySx7b83byc+6XlYPOlRxv1NNrDc/ztjcUYUIJ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYrjeoNSB+2zo8KvFSRolBbbRmsoNY74wHbUzfS/VrLO9qK73Q2mlV4D7CZvGffftoATWyW2k2kuhjOv/hMKVj5o7NjBRsbvpRWLiHQU4UcBTCPDtwQunE294xtVbKhjp0tZJXY5ezisAjM/YzlyVRz22yD2uJ5Mf0SNZrTOg1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IVShz7aA; arc=fail smtp.client-ip=40.92.90.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNb9maZd/Y621BV8Izt8n3Ot31gXMwM6HVH7kV7RqwIrFCuHb+BxUiWT+0z3bxHLpb6/9Qc6mLkdxZwHzCBcReFQFTF+jC+Kcg3Y0/G5NjVX+mXAqF1/2UnrN8+oPkx42zskLAAjRc1TJApsZ5sBBvfqBRYbCdricegW+LcPPJpsdGb0IaqaRT659ouA3NYs4sm2RdGz+J2PheAVewb40lUX2AvZEJVebTSDAF8Cb/qor6NqGI6jxuRKtJOa9XY6iMGflJRQnXDtdfnytKAYq3TZ82fCFpDD0v7j2s6grTrn87IpjkfBE4a+/daxY/IOiRbXMGl/2G34U8qeq1OoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PefMtOJX/y0JMl122vVviirtbv/SiKM4djNOW5/xMH0=;
 b=ceP0OO6ATEJcKy/iOMlYBI3mCWCTwKEjcKnoYK+0NB7HkpB3iIe+siyRo8nt2HpH/nx+AuW5AiqjxaMRscREXMwyT3cp5AS76ltxO0iqVDyndJIW12x+4xMjHLumpVWUQCkd3Hg36S4sJHJ8J0s2/LO9nBNunjGVUqtUUtf/BTNlFlqkZIAD6++5bL4kIM0pqkMDk8vKYn0arauXbfPy9SuUgoCOXGak5tvaOEz9MFQfZ29gm+IQEr1Gbuem6xeIN0mY5lK8zBLgorwTq+7aHQIYnj83HX4IA/DscDRmLEO0fjSf7P5y0LauSnkplvT/JyZDJJEdJglczhlQNeNdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PefMtOJX/y0JMl122vVviirtbv/SiKM4djNOW5/xMH0=;
 b=IVShz7aA0fwXPEm8oVvUxsASw4pGRaS0Z9r+Mdfa6/ST0xbRlDmBwoTzEX4XWnSu1bI9r+9phgbatXPrc1xwV+kipA7UHazTr6hpl9UzYEd26vxtNngY35nbAdrHao578b/t3vKkxhg0Rrb1wr/q5wBv3aXQfz7FX2Cpf7zWSBbCg1eHJWzCMSB6AwsAb458F0PAN2xC3UG2L8EvZrI479gjzMxMGkO2IJmAowpp60x0PGLbdnVGmnY3yytUgZWngTp25HA9KafY4HkCLn6fTj3m5xRPlfM/YtTD7Y5VoyXYR9lwq5rXZ0Trfs4ErO2NoKuajqxcKqsvFRVUXkv+/w==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAVPR02MB9158.eurprd02.prod.outlook.com (2603:10a6:102:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Sat, 1 Jun
 2024 14:02:39 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 14:02:39 +0000
Date: Sat, 1 Jun 2024 16:02:25 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R.  Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>, linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] sctp: annotate struct sctp_assoc_ids with __counted_by()
Message-ID:
 <AS8PR02MB72376F105A5EBEE013FCAB1C8BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-TMN: [eKENHV8Vwk3Y0cbAcSIGjJ+aGfw9E4Ny]
X-ClientProxiedBy: MA2P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::11) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240601140225.GA1824@titan>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAVPR02MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 33adef7b-4d43-4997-6561-08dc82437f57
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	XDkVQfbp2eyrep/R5nahPH/JIlEN7h3EYzd4UKlXFRAa0HVdm/1YMWJhGFLNlJhzOiHv2Y+Eikff9GwvwMgb3h11C8WbOHJqKm87On85+H/SLxI8NPASdLQyhIKCiR3xvjx3dSrS0cChW5zfqONmFFGG5dtIuPesxPKBWcnPz3EnkXysGAopzdmR/y0cfiDlnl5VqnfqJfWRUnf38vzq7riEMR/5xXRbXUwkLyaCwxrOcrMMNB6HR04aj2fPtUxhyC4SIPIiYPGbx2c2WE4JRcLbmJRZIWrvvBqdC5YjVEsqgrhz+YpCuekU7cgsc0NIX7SjzvchlHHCkIs3LGFbMmpKmnvvVqjb/7E9xGf/UCeN5LEVebyM44kBxBZ5DQcC6cGDvjPGp0qSDRf9l/5QtWtCSylgSP85gInRUkRnjb/HTJ/awNCAgajNca3eeTuIIpxTwkk+KL7NHlBW8zgiWW5e0TuT5tKccgcg9DlbR929vyW37ILxL8RtceQcQQrVYDJtWnqG40w50y0SjwAzLiEPDGHGdhPzCDd4MtuCqZw0coouKB29B+jwWVhyVGguiKBb1exAMxAI1zQsnAcTlI22kj+WBcKgrc+HL0P10mC3Zm48d7pEtS1Fgtq0BrO0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEjIsGJQ16OVSzMYgaYxJ9MBJzSTDJsUHjA7TDKcxA2iPEFAjUY+JKWjkqQo?=
 =?us-ascii?Q?KfLSTGYxw8OtRfmRr0a+vu1qvD1DaUpdSVzEyJD2eQpha/PzM32I43IoWR/O?=
 =?us-ascii?Q?D5lYJ0pu2tzZL9s/WMsyuWtt2PU9hlIsdba462tks6PljQ7ShR45WeKQ6ch+?=
 =?us-ascii?Q?4bOxVA3M4Q6dQ6dA9+nz8Gx+3/VBuKO4t0Q8BAJi8cdAz0e8a+j9anf9jgXM?=
 =?us-ascii?Q?ihkZSbdthPpEeo4GVRAA6w2Kkxnn8suSwzu5F9kbELiqB8Xo1GwmvqTCymWe?=
 =?us-ascii?Q?K+XVji62pLdN6WYk3qNq9cNW9HjtV4Xt7ZEEPG8L1/QHT3vKB1+VgCSsRTB2?=
 =?us-ascii?Q?fjioUVXOFw7nkQfY9RZsJQeNQUUj5sgIz2mLZxhvZ7eLXv/WC4+1vqd5sP7q?=
 =?us-ascii?Q?lGSX9DihZ2rnzXw/qhCaBl4PZ87WYYBJlxTr6NAT/xwxyJmgcKlwR3OuLPcc?=
 =?us-ascii?Q?oo17cvFxyPwNLmNItNZHug5m4M/E7Un6f31neYSAOM/esm1f6toxmFLPcUKD?=
 =?us-ascii?Q?d1lPT23HFcKhkhhoeHL0MB0EY98lFqmSwNH3xM28fEDDJ+1W9CfR9oE6NP0t?=
 =?us-ascii?Q?6iwPdeAETJuGSEdQ/FG2pJsaGLMXReq4qpn/tEXT7jXnz+NBSW/O1tx7WCse?=
 =?us-ascii?Q?BnxFFfSoDR9Vlqyvj/AUwVDuims5oorfgxVVhtQ73mK3Zai48v+WOspypHZS?=
 =?us-ascii?Q?LPdSLl44L55QKnojlbKF1KKqOvr2ajcgUwaXCvbXcGMzvA2KXBdhNuBRoBQ2?=
 =?us-ascii?Q?OZLZANvjdraw/HHcinTOiYkNC1OIO7brSHW5+qvKGuQ8KEZ05Z5Qc/S7Fh4F?=
 =?us-ascii?Q?hm1T/dyfX1H5DqeAOEKOqf8FXRpcuUE1U8BC+/PF4D3Os0MXTxFk8z7oGacU?=
 =?us-ascii?Q?q4R+Xq5ZMNN3AzCtP2NAK2VLFBMKZenCZ/qospGqED6vsrL6HFOiJzRs7Yi7?=
 =?us-ascii?Q?+cDtdwftYQnWeWNMEvnPWlqE1rf3vwvwoeX3o4h6gEGFnHZApD+X2hk9HPxv?=
 =?us-ascii?Q?62UuRZf86eA6xcNT1nBrauQJgqx7sadHwyGr65tti+O2W7lKefTz0fwOLlSi?=
 =?us-ascii?Q?bU0cMo1+HHvnLeiyEU12zmsHOLDcm5YwTSQcJ0/cd5DqlpQe3NJi6Diwmi+R?=
 =?us-ascii?Q?CbDfDX7PRhA6oekJM6rdkBL32rYE8F0kGmHcMI7y6Wa/6QfygpLTjUmYrxU4?=
 =?us-ascii?Q?uOYeUxPQu+a29fsKhJgz6d7G4Hp94GhcmKXARGpEunpnkfjJ0uo0ABZ6jwkP?=
 =?us-ascii?Q?lwHbkxoNHuRrgu4gQt3Y?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33adef7b-4d43-4997-6561-08dc82437f57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 14:02:39.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9158

Hi,

On Wed, May 01, 2024 at 07:01:22PM +0200, Erick Archer wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
>  include/uapi/linux/sctp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
>  /*

Friendly ping: who can take this, please?

Regards,
Erick

