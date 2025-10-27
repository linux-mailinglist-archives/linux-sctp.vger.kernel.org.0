Return-Path: <linux-sctp+bounces-708-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0EC0C869
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2026F4F1C7C
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4D2E8B95;
	Mon, 27 Oct 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="SHStBehV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD623BD1D;
	Mon, 27 Oct 2025 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555216; cv=fail; b=RGo1+p7S6AsTgilt9t2Bxh9+ppvHJLWAzJrVULxy0n7e0uJSYNt8WTOYI7XWsnL0gEmxm/lwmy4vvUo4qj02o4MYQZCrbFGNRrRliKbYXbFaJVUVBMSKRMFH7GpY2Jt/2X8sH9xjuyHEOc9JWbsewZLxPbjbivdn+7L83EnRuL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555216; c=relaxed/simple;
	bh=WlafrhpJpT16pe/Aol6+KWf1zttq6snVNa9+XS21lFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LatWFSfhn+2KX00S3+UEO7Oayw1y+YuiCuSXxmzuaKXrs4JIGa6uNx+NQt6jRA9/ij1DgNYZfwbzVH0Q9XKe6KixIJVRo8NgzBWmbs7XJyx4+0ypo4VkI+c0SXflXqAcQC2raxpwyJyXAYxkFOmW4Rj7GA21MFeBDiDz1WgQ5x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=SHStBehV; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk4iSacworRh7mFzSJ2nv6ayGjiD9p5MFyuXdGaB0jZ79hod6DDOWq7tIOmpH+it0xDUsKTa1T4qoD7oPz/5qc0MfHU6ShWAMvizJXTfSK1lq+wISgstJCs9fyYZaVa62/uhbHDonLs0Rwe9wwlZ/isoaULHEwW7eN8PVqAjLZXC7cUtJYDXzV1EpUUsQIqV7UMHbSd2tQEjAa5L9gTSGlc3TVfQLjHxswwusWThbamCUWq5tFv2K8/xpiFZrRBMXpuiSD42Pjx08LEgAgs0DDVWTGnYY+i+3irWW4w69zp3Cuk3s9LAtEK5g80L4mQXp5DaVKf426eTIth2rNSCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC7vgF2oLoWqb8/JGg3mP4YqdbvlVF7IE3w0Mf9ie7A=;
 b=AmIobR2u52ekR1/RzJLhmTuAgt1Wn04PQiX/UlDwUlE3DCNDYUJP8zeDZb4V5eQ+khqaDQKnbcFmoKFkKgEHIsoLiGU3HsQ0JTUJmzAOY+1Lj/v9ohT8EXGbiOC6OgjB+RwJvaW7qoZjbGwCRr0HZCSF9Wx/LM1ZSaQI3m3FCzhuefB1D91fqh8a8DVU7/4Nz+mScaHZBEdJwIwsYsKaYZxU+CLPzrUM7SwINrpvKng6JFxPOq/giQhRaRymp7mbxHf5P1d3cS2RwUfQTnJ6vgfVaJKPbN+dxBbReXR36QF03NEu77ZQMUK5JZc5yHdBX4KByAkwsN6Lvu+wF+Oqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC7vgF2oLoWqb8/JGg3mP4YqdbvlVF7IE3w0Mf9ie7A=;
 b=SHStBehVqyMN2AQNFh2i/VYeNV+oaFaqpapSGCsfnPifR9yV2IvuLjHo39l2SjPmP45g4yQ1cnPFyJtiMBLVohf0OSUM0YswTjSj+9DvxxRkNB1UCF8vmvIHzWURa+qM76lmc1YvXnC7tSgPFmbgrBYWkni6XhT2HKA9Hn0C0203458a3BR+OHmwgO4Q5pOeaSRdSHeuoTsYKmdGm9DbKcyjjz8+EwktSamLqynJdUrmz0rz9o6BTJqP3lqun97KQx4Yb07NaB4NTEgz8eTYNFbP9Su68NjKEW//hcRwyGH4pSK00lIQ9yubfp6Tg3Aiof/gVOajrUVaH8c9fRep3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB6448.eurprd07.prod.outlook.com (2603:10a6:800:138::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:53:30 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:53:30 +0000
Message-ID: <bb7aeed8-fa7f-4d8c-b413-5e3549ae8d09@nokia.com>
Date: Mon, 27 Oct 2025 09:53:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address
 list
To: Xin Long <lucien.xin@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20251023191807.74006-2-stefan.wiehler@nokia.com>
 <20251023235259.4179388-1-kuniyu@google.com>
 <CAAVpQUBxfpYHaSxS8o8SAecT27YtrNhcVY9O=rSYFr3GshF0_Q@mail.gmail.com>
 <cf5df107-1056-48b1-aec5-f70043a9c31c@nokia.com>
 <CADvbK_ddE0oUPXijkFJbWF6tFTq5TntpFMzDWH+uV_kc+KB7VA@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CADvbK_ddE0oUPXijkFJbWF6tFTq5TntpFMzDWH+uV_kc+KB7VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: f9aa8ac9-a714-4ae0-51c3-08de15364c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enlsN1h5OTVtME5aQXM3dEFGdDFLV0Q5ZDhiT0FhUjU2Y0Q1VnEyZUl0UTYw?=
 =?utf-8?B?L0ZueTRZdm5LTlI1eERrOUJHQlgzNVhZRnp1dTJUempQbzdxMXBhSmZrclc2?=
 =?utf-8?B?SFNHWDJsSUhoQnQ1cWVZWkxRa01qdkhvL2FQak5tT0dCdU5adjV5SENqYUZ3?=
 =?utf-8?B?MlM2N0FRK1ZLRjNKeU4wRFRVeE5rcEdWWFJwMHJSaEgzNnRUWlZRaTlWbzhU?=
 =?utf-8?B?SG9STzRuRE5jNzl3bkd3REZaMGR0QW9KcHZ1KytreUhlZ3dMbEFyUjZYR0M5?=
 =?utf-8?B?a0JoWHBrZjJxVVlQOFpMaUZSQTBJM2cybng4TkR5MUEzTTVydkZXTkozM3Bk?=
 =?utf-8?B?aE1XUTdaTWJaVUJjWU42dE1PS2hyOFdnc1R5dlcvbjd6bktUOWM5aTdlK20w?=
 =?utf-8?B?Z0V6R0NuUC9QTGc2VzZNVExjTmYwSllTR25sdlJOcGVES3EwaHRQeTNUR2Zi?=
 =?utf-8?B?VnRFaGpQbmFYdFg5eDl1amxlQXA3ZUpRTzhwYTl1d2VlYnhEMW1zMUhBamNX?=
 =?utf-8?B?T0h3bDNkM1N3QjUvYitnRmVqZjlwYmFjci9UTUJIa1N1OW5LZ1d3OTc1ZTFz?=
 =?utf-8?B?YUdUc29VczFyMExlWWZWVGJWSE9Yd2o5bkZ5VnlPMXdCejgwMHVLRm50Vi9J?=
 =?utf-8?B?cjNlajVZdHQwREEwV0dsb3JWUmdWNXhYdWx5L3YxOTFRb0pEVTdISFVERURZ?=
 =?utf-8?B?NU9xR3BvRHNNSDl0cmlRMjJ6NERCRlJlRHNHd0FzY1FXSERmL2lXMFBXa0lx?=
 =?utf-8?B?WHpMVUhrYm1Yanc2TDRjRHJGRml2Sk4zWG5QOW9GUnhTRHBtR3VibEdoY1gw?=
 =?utf-8?B?V0FZY0lqaCtGUnFMNGF3RDNDZzJuNXE5VVVaamNSSFNtUm92YTR0eUpWOW9i?=
 =?utf-8?B?RzVTZHBkSTZZT1pEWjBhV1pwTDZrRk8rMHZvVXFROTZlR0gvTitJM1FxL0ww?=
 =?utf-8?B?TTdyemJScjhHNms5VkRyeElWRmlLM2VscjF4YjBXQlZKdzJjdmowSkp5TzZz?=
 =?utf-8?B?d0hPU01hVmhJY0FIREpFNlViK08zSE1ORnExN0ZjMHdQMGE3SUJkQ0pJb2JE?=
 =?utf-8?B?bEpJYXY1Y0JRV2xzMlR2V3djd2ZrTW5kK0V1a2QzbUwzWTFoeTZZL3BLZXRq?=
 =?utf-8?B?RXh0V0ZYSEx6TE1FeC9jTDB3eGN5b3FuYjBIeEhhblh0ZjRUUUtEcjUzN2Z2?=
 =?utf-8?B?VnF3MldRaHFVdHdWNlBCSkI5WHErNDkyNU5HUkl2RzQwbmR0d3ErZUUyWElM?=
 =?utf-8?B?bkkrbWJOb3JJSlE4a2VNRXA5MzFwNDZTTklIelRuTDlaWHVDOEJGYVBrRGdD?=
 =?utf-8?B?bWwvaXFNOHFoZ0o1MFRLV25GejBPVWM5RCtTWDAyeWtyNjNhdm8zQ245Sy9p?=
 =?utf-8?B?aVNHWkVtME1hMmRmS1pIdnVIblFZNytlTlpKSnJqNnZ0V3EvSkZBS1dFa2Uz?=
 =?utf-8?B?eUp5eUVRc0tFUGtzeGJGcU1oZUZJKzM3SEFIeGJPYmV1TDVZcTdJV0Vqb2tu?=
 =?utf-8?B?L0FrK09OdlVtMytIdHVsNUYwQ3RXbUx3YmVkK0lnTjRKRjMzTmR2cGN0RnBD?=
 =?utf-8?B?aktyT0RHTHkyc1d5RGhyVDExM1hLZ1pjUHQ0S1MwSnVLNzhvTWlvWXhXaTlV?=
 =?utf-8?B?Y1pvT3dvbVRWOVVhMTUzNDNwRHBNR0Z5ZFBlNGJNWEhrbFo1V2RWY1FScDZS?=
 =?utf-8?B?NDYxV0pIYmlHYnlxZGxqMmFSM3R3MDl4TWE3clZ0YWdRMXA1OXM3V3VMeE9v?=
 =?utf-8?B?V0VUZkZqYi8zbllVd3FxT3VkNUQ1aUVzVWdZT0syUzMrd2pKMjR6YnlCMGI2?=
 =?utf-8?B?cmZlTytyTFpKK0RvRi9WRWcwc0pQWVd3ZmFFcWwvSHp6NVdMdTliMUNWMXg4?=
 =?utf-8?B?SkhtSUJ1TXBpelZRNExZak02VFUyanhuSDI0Tnk2ZEpRdkJNNjJPdnEvVnBK?=
 =?utf-8?Q?J1mo2b4AaK/49bjf9/S61GX6e/nP+O57?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1pQUlNtUmY0SGp1cndjemYxc0RjbTVrL1JadkxtMitZUGtpN3F2QmdSMG5S?=
 =?utf-8?B?V2FwbXdwMGoyNW43VTl1OWRqaklTdzZrWHRxRlhOQWJHUnRTQWpQUEZFV29X?=
 =?utf-8?B?N2N0VkZXSithSEI2RGxCS3ZKdzlpcXh3Q1oycmdkclNyMWF3eXVqR3VQMStP?=
 =?utf-8?B?d3hUVXJGUVR6aDFDQ2RKdy9mMTNFeThQbjJSSVExT05hNkN0OVFmYXRLOGlE?=
 =?utf-8?B?K0J5aXlVcWZKbXNkQjgwQ0tJeTZFUXlvWTRWTjgvYkhVTkRPSTJIUkVVNml1?=
 =?utf-8?B?NHorNFdTZWp6emtjdjdjTGxoOUdpd2FSTGR0a0lUTHQ1cjdnaDM2U0tWbHF6?=
 =?utf-8?B?bkFxbEQ5eENQcE1PaitpbitZcDlLVjcvZE45UVNUNGF3NXRxWDBxZHJaNk0w?=
 =?utf-8?B?ckdKbXNnUVlQaktwYXpGMkhMZ0QwM0MwMlFJM2JvcVdBbTRCU2F5RnNDMkUx?=
 =?utf-8?B?N1N5Wld2MHorTHNsZ2RRbC9LWWo2WjJOdkcxdmRlUVBWU2hiWFBnK2JDcmVH?=
 =?utf-8?B?dGFWc2M1czFDbWRyZmVlNVVKeXpjaFM5ZFpqNjlLbHVzbXpkTS82TGZVVThB?=
 =?utf-8?B?OW5samdUdWtabUM4ZGEvbnowYlNyc0FlT0FCY0EvUEFYaE5FbnJVWjJPbDBh?=
 =?utf-8?B?dXROUkE2dUErV3BMZnZuV0RsOUhSYTVuam45MDNOZVhXVUxHU2tCUUZFVWll?=
 =?utf-8?B?OGRIWWpXZ3QySk5vSmVkVXhjNGlSRGplZVdxM3lHbm1kdzdLaE0rL1F4UHRN?=
 =?utf-8?B?SmM3UCtCdXhObWdNTXRMeUpseXlPZXRCcjROWkJIZFpUWjJ5dVhxdnpmSnVZ?=
 =?utf-8?B?MmZwTm0raExSdUc0dkVid2NjSStXL0ZJTnNWK0xZeUxyL3FkOGoxZkt0Sit6?=
 =?utf-8?B?bHV6cFRoSWtuQjlId1IrTzc3RVRrQnZXcERPVDlHSHdqVlZURXUxOHJOQmtD?=
 =?utf-8?B?Nk5xV0ZxZlJiSzArRDdoakZjc05RUk9ZVVRnbVFvaVh4TCt3dmxtVEt6b1dT?=
 =?utf-8?B?UytncmdiTVZpMmhsK1BlUnRTUldDQlYvcEVIVEdkeHdIZFZ6Y01TREJWQklm?=
 =?utf-8?B?ZEZkQ3VoeTlYbjg0N3BvTmhmSjdSS2FodWlPSW41b3U5MWdqV3hyUE5ETHpU?=
 =?utf-8?B?c2NhTkpQZFo4VzhMc0RNNUJlWEJWc2JxZEdyUHk3TFo2M3FTek5KT2RkUXRD?=
 =?utf-8?B?amsxL2VKY1A3eFNvTXpJNzI1azBEWGltUnpINDZ5RUpQQS9RL0hNb2Q3dlBz?=
 =?utf-8?B?TjAydzNPaW5Wb0RMdmdWckVmbzhiNzRXVGRUcFJ5aHd5TlZnamdJR0hvNDlq?=
 =?utf-8?B?c0hpK3dNcitPeTR2UUhJMGZJQlRtMkZWQnVCd2hjbDlXbi91MGU3eng0VEV5?=
 =?utf-8?B?VnFSOE5PcFlLN1JXYlJsenM5RzVpaXBSNEhab2MvVUlnTXRGaGR3V2NPV1ZR?=
 =?utf-8?B?SC9kdjZ2Q3h1aTR3Y3JOeHFEdEhDZitpUCtBSWplL1RVNXBYeTNNZlFqbTNG?=
 =?utf-8?B?UzdudjNrUWczVmk0WkY2N3F3YWYrTEJraStqSHZwT0U5RzlSeHdtcklUMXJH?=
 =?utf-8?B?V1VDYkhvOW9MbTYzcytKUXpldTNPV0RQakcvbVphb1ZFYnBwVGdLRC9YS2VO?=
 =?utf-8?B?eVBvcVlYUnVDazVYdHI2bjZGZE05eGdVa09zK1JlaFp6RWdvK2ZTWHk1NkMw?=
 =?utf-8?B?QkZabHUrMzFTZUwyYXhnRVU5cGxSWVhZeThySUFlekJiYkpzUWFEKzFKZ1px?=
 =?utf-8?B?bGtCOW9xdTVvc0dZMGpha3FzSUNteURaRkdTUTU5UUhSWU0rVmtsR3FpZWJI?=
 =?utf-8?B?NWVIeHRSazdPT0JUeXJwYy9CWWQzZnNoRXhYbTlGMENTT0ZWK2RKVnBUKy9i?=
 =?utf-8?B?VzBpSlo4RWVQS3MzcU1aVmFQTXlROUw3VmN3d21RUVRoS1hjTVA4Y0lSVXo3?=
 =?utf-8?B?YyswdkJtQ0NZQ1FDb2pDMThaNU1zeFQ5M1gwdVliaE43dGZOOUlwVUFBcDdN?=
 =?utf-8?B?ckJlR2ZZMjB6YnVSNG5hemJWMzFlcUVrTGI0QlBNYXZHSEswVHZkWlRhSDlr?=
 =?utf-8?B?YytSM2oxYXFEbGVwSm0xbUhqU3hRUk5yY1JnSE9PWkVRQWROVFFlUUR4Yktj?=
 =?utf-8?B?Z1JvQ0YxN2kvZ0pCQUhsYUxOUEZYM21GUFA5Ujl1N1VVRnRDVjJ0TkFJa2Z5?=
 =?utf-8?B?RWlPTFNBM2Uwc1hSMjlIQXpTN2xUOXNtczkzUnk1NkdhTG8xVHZzZkR3UjJ3?=
 =?utf-8?B?MStSLzd3KzdKQUhhUDdpSURHUUpBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9aa8ac9-a714-4ae0-51c3-08de15364c4d
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:53:30.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/TJ0w+qCMcc4NtEULrUDXPFIuqLYkmVFxOtnfpURRRz/ps7Ub76hluBlzJW+f7RwbZqn7Bwax7DqJsAgJ++O+P25v53BysfZok21gRrd3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6448

> Yes, there's a path not holding sock lock:
> 
>   sctp_diag_dump() -> sctp_for_each_endpoint() -> sctp_ep_dump()

Ok, thanks for the clarification.

> Kuniyuki is right about the TOCTOU issue, we do need a check there:
> 
>                 if (!--addrcnt)
>                         break;
> 
> BTW, there is another addrcnt thing in inet_assoc_attr_size(), I think you
> can fix it in another patch, like moving nlmsg_new(inet_assoc_attr_size(assoc))
> under the lock_sock() in sctp_sock_dump_one() and delete _rcu?

I've sent out two separate patches for these issues.

