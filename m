Return-Path: <linux-sctp+bounces-691-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C3C0534F
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B928F4E137D
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 08:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1F33064AE;
	Fri, 24 Oct 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Rrv9QW//"
X-Original-To: linux-sctp@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0027056D;
	Fri, 24 Oct 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295876; cv=fail; b=u31SAg3GWcG3jshrCHOvr5BlscnpZviflsIvGaKzjpzI2ZeyoZX/st1SRlMAtvOs3Ule6EecCh7rLo1Bvj0D76AG7chkqus46JnqU7DP11XAqKwLM+CWJrGGIyp0fYjsmqrq4cX7taBgLfOB6FDO+zV/vMP8LtSdKmsmzDu/07w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295876; c=relaxed/simple;
	bh=g8FyduGpTP0YSuNCCnL1t69OxZvwlbH1pdadLSDsjy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ik00DGpaWf/uY3vzOFkyEkUcwjxZEfAEXRCulijb83BsTOo+l5mx4qFLbDUjZnaJBABUHg834U51D8hk7zJ8dM9iREf7V4ju16EswMh0LBoeNxE+QCdZ5+6gHj6ixohuFhKwjNZtRLsnjCJXq73pVaQHrCXuI6qB61OCnnsEgtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Rrv9QW//; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0LhIGIczoP/oQkniDMbynrK2q7LfGW9A8Z7LPpAOK0ZCqxojXL4wJ67HjOQw54HWEaPUCCFMx2WrLDX6S0ZVQJeZU2+tZeBGCyLUO4xAGMY+ABZ+HrbH52rfq7rwEXubYGhYPymJwdONLyEQnTVzSLYxt9IWp09VQhiGXPZM9DuLJqPOKQKLMGtiXGrnzgQtz+fNX3gPcpYk5XuGyj7ziIecMZRVviTwyW9JWnGW0O/zPlCW3C2zvldDt22ufUffdz7lotmHTPVrR0y9DINaFw1p6geiCcpp3KGbl4Htcj/eNf8/VqhOVAMmv6C3df6le7J7dFimpMzHK63khfOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8FyduGpTP0YSuNCCnL1t69OxZvwlbH1pdadLSDsjy8=;
 b=stqndAmsrRICiHe5W1ojdkzXOgqobqhLrEAGd6IERwzFD9wdHUlopY8K3g7eXgvUXkt7oFKlSw6dlwrIT/ftJh2vaLLwt1WBPg40GboezEE7YLCOrWiOv4HCzizXicj36cdxDxrkecVjOzZmxolBBbfPto5ccHzC2ClGSoDBC8IhT7eTO3Ea2PRCyv2/GwVDz5oQz95psyp5AAt3Bdhb9W6ow5kmCXBflaHgikVFbsE0j8SrJOMuMS/4gYcXmGbSPTNp58HPBM2noUZXF0R8gviZJ0qtUjCRHLg6N3P0HzVl1fS/bokWPKRHBDIglffR0n50Yvp07U+s3WjCOnqAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8FyduGpTP0YSuNCCnL1t69OxZvwlbH1pdadLSDsjy8=;
 b=Rrv9QW//yM5xkdhnhWMxfh37OS/nYfJML3yCn7CDI2iDlqphRKkVHdXIHeHW43G/JBfYNpvfTcKMfI/kBX0EuIeu4PlZz1N4lewC4kNugn4xSdiJHPSg2NomsxuYMmJK8RbPrjx0w3qQgA+CBEQd3y4w1cGuv0PZvtt+B5r+IzC9H0iYhfROzbtk4RzF7s2ZFMJDDrmf1HrVkhhBmLYGrlmCf4K+UOaPJHgL9tUgb/laaoLTa4AJ8ME7vFeU2BmDhIoKwMOfprx/2gE5b/ruBvL5WeOHF+iFWH33F4d21kuBUr7W67kXnJzxXD0mxnLBZaofVHmpt98AeHmtPK9hBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS8PR07MB7640.eurprd07.prod.outlook.com (2603:10a6:20b:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Fri, 24 Oct
 2025 08:51:10 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 08:51:10 +0000
Message-ID: <cf5df107-1056-48b1-aec5-f70043a9c31c@nokia.com>
Date: Fri, 24 Oct 2025 10:50:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address
 list
To: Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20251023191807.74006-2-stefan.wiehler@nokia.com>
 <20251023235259.4179388-1-kuniyu@google.com>
 <CAAVpQUBxfpYHaSxS8o8SAecT27YtrNhcVY9O=rSYFr3GshF0_Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CAAVpQUBxfpYHaSxS8o8SAecT27YtrNhcVY9O=rSYFr3GshF0_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS8PR07MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ca71d0-2cbf-4061-d621-08de12da7a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdkYWFMUkd1VG1TZ3ZxOXFIdlh2NFFwWUFXTjd2d2RRYzJRdXNCNndNbDJu?=
 =?utf-8?B?cnZzeVN5M0dRMDM3a28yeXh6Slh5d2MzcWV4VkgyZWxwdjdBTTl3VG9ibzJt?=
 =?utf-8?B?M21UYmc4dS9uZlJCajVxSGVpQytuTG1LVjZzUm5tUE9OT0xGTjdkWTMzOGlJ?=
 =?utf-8?B?azRQOEVHaTNKa3VIeUtYZEN6UDdrSTl6N1gvdlo1OEVsdUx3bG5yQ1ByZHdF?=
 =?utf-8?B?M2pzTU1EUzRVV3VIR01Eb3Jmc2l2a2dBbFdnaTRiUnB4Vkd6MmFXZUtqK0xV?=
 =?utf-8?B?blBVQW1wdFFwQ3Q5Q3hwVEZ0WkUrRGxTQnRYcU1oTGNhRTdHMUxsRklQbXdp?=
 =?utf-8?B?Z05LS0EzNWhkbHFOOXJXellBQVR3OUFMc290MlBHOS84Y2FWSElFSjhLWnNI?=
 =?utf-8?B?NE10Q0NoMnBJYXFIV2V2SExtOTdEOFJFWDNMS0JheDhIc0oraHdzcWVHZnpo?=
 =?utf-8?B?NnNyZWNCZm5zU2ZEemZZaEoza2lQTWIxUE1mdUl5eFZXUUVmNEVtdnBJaGtz?=
 =?utf-8?B?MVMwOU54RnlxcnorRmV4OXpNQ1oxR0VpS0ZkM2lHSzJDc0t3Uk1YU1Y1QjVh?=
 =?utf-8?B?NWRacWlqMzNmZlhKcnR3d005NVh3WlpjaE02Vk1BWU5oNEx0Q1lLZjZENDF3?=
 =?utf-8?B?YzdSVmhhMjBjNm9oSG02YTV5V1l4elFjLys2NFIyV0E1eUFIS1ZOSUFveFhm?=
 =?utf-8?B?VXBNTWpXWU5CekVwc3dabVc0R1ZrZ3pWdGc0NHlxb1pqdXFpaWthWUplWHVw?=
 =?utf-8?B?WXZaRXU5YzN5clNmY1RObmx1cU1abUVRN0NZZ3Q4S1lKQ20wZ3VPcDMzeU9S?=
 =?utf-8?B?akJ5M1Rrc1pqZ3BKWWRXSHY3ZjY3WVFJc3YvTVRwWTRNTjlpc1dBdkFSYThx?=
 =?utf-8?B?Tm1Ball2ejVNWlFNclkxWTE0M25LYjNGckdRc05OYjlrajBnMjlqVGFHR2tD?=
 =?utf-8?B?STlHWUluOG1aTUlsdktyZkFYM3V6eVkwVFZjcERvNnFBbHI0RllFandReXp4?=
 =?utf-8?B?dHVBak5meEhnNk1pSDBvUjRaS2h4MjdlaHJXc0pXaFhhbGVDM2xmZEw3TFJE?=
 =?utf-8?B?U2ZPRklpR2NrcGFUbU9JaGxGd0VIdjdyUytUd3o1emFQeVFvZTBUZWNIUU9i?=
 =?utf-8?B?bWN6bEYwYWo2bUhITWR0b0JndGprRyttdjhuMDI0aTZwUnAyamRXNlV2akRI?=
 =?utf-8?B?VG53eERGMXpFcFNvVTcwK3F1L2FZR2RmdnlWUHNIekJjVVJ0N0xmZ0pVOE53?=
 =?utf-8?B?RCtXakNCZWFIMEM3dE1TRnpqeXJ3U0c5T3JVUXlhODJTSDcrWUE0V2NEa1dV?=
 =?utf-8?B?VG1nQWVJaHJRNS83aTd1Y1lra05zTVVYd3p4UVFmaldUZHNvOFpVbzlIVjV5?=
 =?utf-8?B?dDNWSFpKQ2pBUU5rZk1rTThrelFJWFF5RTNvUnlxeHJmZmFPa3p4cXBHZ3VG?=
 =?utf-8?B?emJzVFRVOE8za0xzeDhPWXQreXF5cVRybERKYTRyVjVoaVJmMWVxSnZSWTBM?=
 =?utf-8?B?ZWgrOVQ1WUREN0RGNWlvNUJGN216MUI5dGM1RUZNV3lDTTJMRUJaV2x3RjJo?=
 =?utf-8?B?TmpRY2xOR0dXY3JvdTdUMXBnZDBLU0wzZGZEUUc4TDVHVWZCK2dRZVBTUmVv?=
 =?utf-8?B?VGt0UGJDbFR1RG5iQzFhTEg0Rzl5QlBGMHA2NHQ5Z0NXV2l6ZjVBNjJrTDkr?=
 =?utf-8?B?OUdPUjBjSS9YNWZGUDg2NFl0Wld6ckgybVBPbEVHSDJZbmpLMTRwNFptZkVW?=
 =?utf-8?B?d1cwODlwdnRPOVZGbHowdW1iRHRXbjV5VVd2UVJrVEZVS2I3VXVGWW5OelBv?=
 =?utf-8?B?eFo4Z0E1Q0VwZmhoVkJEZ0ZiS2Ivc2xjSWhnUnJCWUJDS3dLVTRobklLWUM5?=
 =?utf-8?B?TTNFZFZ0NlpSKzhpbmZzMmxOVDRNRk5Kaloya0YxSVlZbUVDSEdkdjFDSUE4?=
 =?utf-8?Q?xowo/sT18lbQEVeoh7GyHfe/FhWAVujq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2ltN3l1M2lMWnZiNndIRDNWekJrOE9wd0pQTEN0VUd1d2Q1ZUVQMmkwbTNo?=
 =?utf-8?B?ZDBqYWdLdW11SllQNVNCRUl5OGtMRWxSYXlQYVJXdWdqMkdhejVSWkY2bUM4?=
 =?utf-8?B?ZlJ2VlNWejl2R1VyU3VxWnVYR0F4eVY2RGE3dW9yZ0VYMVg1bGN4TEFPVndv?=
 =?utf-8?B?b0FqRWo0dDlISXhrQVZNUkpjTmFkTHhYR1Q5TEtsRG9kQ3ZWdEIyUW5MeWQ5?=
 =?utf-8?B?MGRqSXN5REpFUTNnMUVkZWFacjNteHplQmpWODF3ejRCRDg1ZHptbjZLRDQ2?=
 =?utf-8?B?alNjSFR1TXJLMldBYy9uK1BqTUpDaW5oNWdvVml6RS84RnZtY0J0QkpFUEtB?=
 =?utf-8?B?VWwzbkt0eFFrNlFUS3hCbFdURFNnVFFiUUxpaS9HY0pEcE5vKzVoM2lmVlEw?=
 =?utf-8?B?Y1hXRDBpTG9wT2FvS2ZKMi9vcEVwR3NqcjdmQVBNbnJNYkttTXR2eTY5RTlz?=
 =?utf-8?B?YXJQWFdML2lEQlZhMVVZazdRNnlqRllKdStrTHVoOFMxNStkczJteTJoeWJn?=
 =?utf-8?B?Z0p6TENvSnBnUkkwRmlxWTk5MFBvSlAwRzlFQS94T2NoL0x4TkVJMTVCNmVC?=
 =?utf-8?B?NjU1R1ZOeXV3WFBXR1BIaE04YVJNRUNUWE1pRUQ5QnRqTCs3N1V5dm5KRFBP?=
 =?utf-8?B?cFpYeFI1T2Y3NWF2VCs1SklPOE0yd2ZMUkNLdFNOTDI2cm5UQTkyT04rZERL?=
 =?utf-8?B?Nmx2SkpBRVAzUHJiZC9URm8ya0U5ZFQyYXpqZnRXamxzSlVKZkV4bXd4anNh?=
 =?utf-8?B?ZktBM05TYlJPZlA4QXRFWDc4NTV1SkZmQk1CM2ZORDRaTjdCUDE1K2VFUFd3?=
 =?utf-8?B?S29kVUNQSDZRSjhhaGw0ckZ0L2NxRkZFOVJwbjhCNWNJSmMydUM5K2pweU1L?=
 =?utf-8?B?YXJkZHRUT2NrQThEblUreVlFcVZpc2laYVlsREYxYk9KOXR4UXhFSExOWmdw?=
 =?utf-8?B?V1NSQ2FJcENKTTgwS1pINVpydktxM2VKdm5wZGJQdGpPU2NuNll2WGlUNVlx?=
 =?utf-8?B?a1RGbmJ4YnlxVjJpeFZKNmpwZkR5VEs2RzhiT09JQnZIVGhOM1R1Y1hzaFB6?=
 =?utf-8?B?c0JsdVM4VjBPcXZoWS9jNlhpdTg5K0x4MGlwaVNOR3JVai9BZFUxVTZKY1J5?=
 =?utf-8?B?SlFKdFNKVFBIZTJuR3VPT2dKai91MzFUOEcxSEtOdHYycFJpZE9sR0t4SjdC?=
 =?utf-8?B?bWNyMnliQ0pPdkY2OG12MXJJTFhNN0kvdGFueDM3VXZEWlk2S2k4bTlCRkph?=
 =?utf-8?B?aG5wUXFtVldDVDdMM254enk2TzZCbkg4SDZNdkd6WEV6VllhTDBoRTBseUlX?=
 =?utf-8?B?UStMWUcxd1ZITGFYeW1VV1o5SUwwcFFTSWZBbnU4SFdsRnNqNkhqSmFwc29u?=
 =?utf-8?B?RjRDMzRlLzdDY1FvWjNmckxYZ3ZGSk4xNE0xOVhPZmw1azFKZHQxaGFaWTR4?=
 =?utf-8?B?UWNDOFVFOE5lMnhkNUpvM1V5cDhOamQ2bDlzRGVXNTdKbHJSbnZwdlVOSiti?=
 =?utf-8?B?Q1RHL0dEVmpCQlFHRVYvUXdTV0V6Rnp5d29xRGRtR1VBRCtJOFdlSVVlYlF5?=
 =?utf-8?B?STBHdmMzK3FMRTYyQndINzNtUmc2YjdlVkl0czhPeFlQeTRua1QvOVFGd1VC?=
 =?utf-8?B?TVNvcWRaZlhqTFdPMWlBUU5aQTY4aUhPbU9NWlhSNDMxeWZKU0xXSzF1NXYy?=
 =?utf-8?B?Yk1DREkwaXpJZE8vM0lBL2dBRGFBNlI3bmYxOEhiTzNiZ0JHUDJZait5V1Z0?=
 =?utf-8?B?ZGUxck1SQ3l1NWpoL2FUVzFqZUowakJFNm9Vak5YZmlNWDZSekFKd1o2VGRE?=
 =?utf-8?B?VXkvbVZhWnZDRWVKeUFXdTd0bm96YlF6OVYvOG04cUFyM2FjNGNYdDZzQ2Q4?=
 =?utf-8?B?VlFNcVlmWGRsYWJzRDVrUXZiZ1dZRE5FVDRibFM2T3hmZkkyeENFMXlxK1I4?=
 =?utf-8?B?dXREQUlpcktmYWNES0VZL0c1dWpkU1E5bG5Ja3F4YVNEM25sVHNSaHNDVG5s?=
 =?utf-8?B?ekRyUWJRd24vdkxMM3o0ZzFOMzRtMEVqa2Vpa0RmdnVBMXAzZnNVTDR5Qjc0?=
 =?utf-8?B?UWFjNlJpVXpEZW9VTjhiOC9CcForMm5DWk1HcUpoTzlmMzdLblI0b2lBdFJp?=
 =?utf-8?B?ZDZBVTFXMEJTSGloUnVNOEpGTFRNY0dNRGV0R091amtoUFpJcHo4OTc5MUg5?=
 =?utf-8?B?Z0NFSXhxTEZ5aFIwUzJuN0NBZFBTSnJDeWVYSHBGWG5pM1grTC8xa29sN2VK?=
 =?utf-8?B?RUduTGpGY0FJc21xZVUyLzZKTFZBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ca71d0-2cbf-4061-d621-08de12da7a69
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:51:10.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo6g5HZWfhmLFM/h4LatOh4iPs/4CAyR2ikgQcogPuvq/j4uU70j6fIci1Otp6zhqvtAoAxRxraGZT4Da7chXgu7nN6/uiFag9Mh2nuLJN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7640

> Or if lock_sock() is enough, we should use the plain
> list_for_each_entry(), or list_for_each_entry_rcu() with
> lockdep_sock_is_held() as the 4th arg.

Right, I've already hinted in the commit comment that lock_sock() might be
enough, but I'm not sure about it...

@Xin Long, as you're the author and have already acked, I suppose we actually
need to hold the RCU read lock?

