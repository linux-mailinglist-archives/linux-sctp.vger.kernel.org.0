Return-Path: <linux-sctp+bounces-722-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B052C15E68
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CECA421B8F
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A8331A46;
	Tue, 28 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="oGIGs1t0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54B2853FD;
	Tue, 28 Oct 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669303; cv=fail; b=YEI3W/5ZElk57Y3/qOfq+QoMkkYsakKf38h5mfLC+cu1gTM33f1XtBVRARtOJjCusOj/RI9LP2lt1kUkpXlXN+SDCH0qdBl3g5N3aww7+tSmWIxU06fZOMSd2eSdmAJwsnVWtKj3ioJWn4L2REIO1iNSF2F4VNgdba6RrKlLf/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669303; c=relaxed/simple;
	bh=cvPvIBHajku0uboHqk/srPdtzmnh4SFRNHs9N1jNaYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fdH1VKFFzE9/Ebf+QVX6HgdPlk4G6Mt96Vg8R6w5H4ebBWqEP8tiBnkt/eXdnrdzl45/4otfIVdUD31rDH6MSBV7z6I0Gzm1llx8DYImlbwrgUe96QKO6rwIt8mV0Y+YEuae2IL5qSUqxomSn1Dz62kWz55pkMRWUothMrMNq6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=oGIGs1t0; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlfwrJq2vyK02xobpTqo4w9J4J1Vsx8ylsvEsRhdyrHe4oK+T/K9JSrEzCJnadkiON65jCn5igdQvnTu9xYCFe2Ef+/kBNMxFWFOsDj50wocLkgDd6zyWdaz+VqtHiSRenEP4wHj+OGRgXT32c5swX3f4ZZvTYVJt298uq5yQ4/j5Vo56eOsCbwK0XtRMgOXmg3Nu3EtiaDX8FmH74BJ4okUyGwE5JQqVNvu7DERkh1y5mYcVaQJ9kyooA6JjxNIlNaqTjj0VjH8kXS55Jb5b416BnbcFxKUV6fhMCEGtSlPxrrp3FDkcPg0Czwib0ZM5utnN+xktyH3I7JcBqjekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvPvIBHajku0uboHqk/srPdtzmnh4SFRNHs9N1jNaYk=;
 b=A5qtESBs37feW7PZJxiVhCXoWxnPNHXd2RK9/6wrDe1h5X6ZETAqyJ3aoDcQ8U88GBTeXMJTpuIFO21LExuPt6DbWFjj+Xt5/gLD/GcdL7EC11rrmVIiHUR09EJ/HNPlwONL1rw2FmNNgnh05T2wTuaLTyS8j1j2RiSBJRUG4m510pfHYdFl21+rZHiiQhWI4ubh0t+02ULH9C0B6OAhXgwHKZO4beSDdtZ7cBoEi1wqCHWR3LRbHOC+iOmC6TmMwpEjSf+BIqgUNGsSoD1rSYN/5mWSmVegnjKKep2en1jUq9i4KJpdjn8rbJ4MdHdK/llRYA74z0caPsdNH24YyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvPvIBHajku0uboHqk/srPdtzmnh4SFRNHs9N1jNaYk=;
 b=oGIGs1t0teNyViLxk6iPmkPS90nlCJbszE3lhF/4vOQf3xTwrVRKCjCpdE46qhQYzaSoRMy5Ik2qSun/x1eFpyH01bbUXa/hywpc0ADA29PrciEtLiCgHic8GgiOTocyfERDr4Ejv7OZVbCQx7dCmoAsCSGJIqcjinSI0LiWHGzO1/TovIx/baCbIFvyGgy6amqOMkdw/d0cZ9nr5OAATg41KFRPIq/7RP308xMHs6gSSiVvNuOrpeKkp2DxTLXzi3sxa82ccZStf3KjXgsu8YDBQFfJ8cVoOhBI39GXFUWBIzmkARNz1rXNc0t4s6y0/wBQXWSeu5o9R2FlYUHfcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI0PR07MB11036.eurprd07.prod.outlook.com (2603:10a6:800:2dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 16:34:56 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:34:56 +0000
Message-ID: <e153addb-81b4-48b6-81d7-d08e00aea804@nokia.com>
Date: Tue, 28 Oct 2025 17:34:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] sctp: Prevent TOCTOU out-of-bounds write
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
 <CAAVpQUAHHVUBQZ=fgCUe8Mg9CD6d=CutyEsE4m82TGdt+VqpNQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CAAVpQUAHHVUBQZ=fgCUe8Mg9CD6d=CutyEsE4m82TGdt+VqpNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::12) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI0PR07MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d658d9-a41a-4627-3ae8-08de163fee0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDBFR09YQXRRYzhnSGozSk1SbFNIM3ZEbDhoVFRocC9VMFNnbmIxZUI0aFZS?=
 =?utf-8?B?WDV3cUMxUCttSVNTSzI1MkY3b25neS9ySDZKSDhjWEpKSmY2dU5GMnFuOEM0?=
 =?utf-8?B?cTFMN2RhSWI3NnV0M0o4QnBleFpPRWVBSkNwV1dIb3lrdXFkWGdzVlFKZ2tP?=
 =?utf-8?B?MHUvN3Z0bEoyenNzNXpKZUIzVkVTTHJGR3g5NjNSKzBhQ0grVEtvbzR2K1Zm?=
 =?utf-8?B?TnFpcWk4VXZGWDhUVWZWdWEzVW0vYmlxV3lTbXlyUEpDcVZmczh4TGZBT2dR?=
 =?utf-8?B?S3pmZ21WNkZ1Tjg3aWdNZlhYSEdiTENnYll3cVRZMWR5TEE0NVVzcUxPM096?=
 =?utf-8?B?NG45Q0NxckdzZ2JUeVVhUUVTeHFWODZhakVjKytsekpsQ0h6ZzRjbE5POWV4?=
 =?utf-8?B?bzhUTnBmdU01cUNTcndidlRkR0VZMjJwTWJ4Mmk0Q1Uxb2hGSnZpOE80MURS?=
 =?utf-8?B?UHhwOUtqUDg5SEU0Ull2RVlVTEE0SnhJSjZhOEdEZ2N1L0VlMUU3MXpONTVr?=
 =?utf-8?B?M2cxUDZOZ1k0RndjdmhMTTQ0YjdhMDZsVHVlWjhoejNvaGlVOER1Zk50TE9t?=
 =?utf-8?B?RVVhT2x2eWJCVDZtODlMZFRhRmxXNU5mbVJKNFQzZDJFcE0waGI5UThjZjZS?=
 =?utf-8?B?VlV6bHdMZmhPaTZNbFdTRWVPMVcrSkswM0VlbzlQUjh2VExZV2hET3AxcW1I?=
 =?utf-8?B?empjVFVUZDE4Vms2dkpzRnh4SkxueHhtQy9KVFJNMjB5cTk0TzQ3ZnVkYU1R?=
 =?utf-8?B?dnQ0TmZ1YzRGS25JZlp4ZldCYVdVeHVReVpKTjE1UUV2c0xWcHdmV1NSZm9O?=
 =?utf-8?B?MGhjaXNQN1Q1S0JXdkpXaEp3SWZ1a1ZySG45KzE2MDFybE5YZy95S3IwdW1N?=
 =?utf-8?B?ZStzS2czUzNraVRKNS9VNkdJbG51TFZ2K0dhdGNOQzArMmpIK2FYbnNaMitp?=
 =?utf-8?B?aFNrRzc2NzlNTUx4L3RWV1NTOFM2V0kxUG5HSUNWazkzNnVoS29WYi92YlA1?=
 =?utf-8?B?NldwMHZ1Um41NGRZcERMSkhoYndXTWxteUJSdU53SVcxMGEvWHZiOVJQWURH?=
 =?utf-8?B?RytlSlFLUTVsc1RPeXdpdUZ5byt6dVNJSEx6NjA3QzI5aUFPVFJOd0JXeDdq?=
 =?utf-8?B?Ujh0K3ZPM0NRODBqdmhpQ3o5RzNiLzBQb2lEcndUQzcyaDIzdTdISit4Ui84?=
 =?utf-8?B?K3I0dngxR1dMZXVwTHltRkRqMXFxS0s5SWEvTHpGdUtscStsekZIQ2VIMDdp?=
 =?utf-8?B?Zld0T0dudEJkMVQxVGU0OHJsaFRiRkc3blZYRmdvdVNVTm9VbE1CUjlMWWNj?=
 =?utf-8?B?YXVyNDlNNlVqVWdnVnp3TWFJOXVyUmovb1h0UytOVGtBaW1iU0hwdVdHU3Jt?=
 =?utf-8?B?c3duS2NhYkVwOTJVSWVGNFpWRUNod1BlU2FaMkNHZHk2eGF5NSs2dVZLUUcy?=
 =?utf-8?B?bWYrY0pHak15aDllL1pEWS9XU25XM2htTFgvZUgwQm1wMjAzZjZZWVZFK28y?=
 =?utf-8?B?QVM3eW9jaXlLNUhYVmtuZjBnelY1NUloNkthVmNQK25ZeGdCdHpiWkhWYlpH?=
 =?utf-8?B?MDkyWXYrNXJsRm1Mc1NwSFlTU0prWi9VM1VKbkFpdjlqcGpLSDNKTlRzQXAz?=
 =?utf-8?B?SlpQWktReTJKaFRscEtYemhyTnQvU3lTd0RNbWdVbGpYT0JHV0hJUk5CWFpM?=
 =?utf-8?B?blRLc25wWEdBYUI4YWxGbkR6TXJqTTV2MW1DemprM0FiUkRLdmpqWms3cE13?=
 =?utf-8?B?eWlyQjlFYUU4USt2RkZPREZUTXhTaWE0b1ZJVWtWczVQSXVkV0JEeGJLUG1a?=
 =?utf-8?B?YzRXR2x2cWl5N21wZUtaRS9BaEc4eUd6U1RkSE1tdkUxZnJJd3Rwek5tV3Q1?=
 =?utf-8?B?SGZITzZZMEl6cGZNM0lGeWQ1WEMvd2dqT2ZqU2M2b1pLUmdranFzZW9hcE1j?=
 =?utf-8?Q?rh2z6R76Kl/Yh/iwRyEmU5uuBn8JZMcT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1M0YlYrL2VYWmZWNE9MQzVlZmFXVjBTTHptNUhtRXAvYU9XcnFqRHo5eVNM?=
 =?utf-8?B?ZkcvcDF4SThhanFpVWZkYTMrY0JudXZkelpFWGdXVFV4QzdFNDhNMWlUWnN1?=
 =?utf-8?B?RTdUWmpsLytCWE80aDdnZ0VqenkycTM5TDZNN2xFVmx2VEg2K2ZXZGQvNHp6?=
 =?utf-8?B?MnRPNEE5VzMvc3pISTVxUnJPSVpXckg5dzFzSi9rdGQrMHJtZDJSYmkyOFpJ?=
 =?utf-8?B?dEhYQUI2RFpwQXJFWVRPbU5CQi90bmNOM3JmU0NoblNKWFVhUm9LK3UvYm4r?=
 =?utf-8?B?UW5sbGx1anAvK1hoaGN5bzIydmpHMUNEUkFBVkpoVEFpUEFUNU1HY1pYbmV1?=
 =?utf-8?B?MHhldUM1UGZXQkNPc1BCdGdwOEtKS01PRk0xbG1SSFZvcVpxZ1AyUnVRS3FX?=
 =?utf-8?B?d24wSk90clEwVDFGNTZ1SWYrQkd2Q2hXTmtqMTJHT1I5Si81OFQrVkd1bzNP?=
 =?utf-8?B?Q2RFUW1RUC9jL0FxSFJ4Yjkwc0pqYlkzaGlnMGtKSkp0NVFOM3RiQ2U2bCs0?=
 =?utf-8?B?ZzJxdE5BUGMwbzRSd0tsZG43ZEN4bXdpY2NkNmw1Rm8wTk1NSFdVbGQycVBw?=
 =?utf-8?B?ZmxDdzlMOFZlczJ2UGhRbWN0VEg3cjBlbFZXTFlzNXRwZmMrUmZXUkZ5VWF1?=
 =?utf-8?B?bUNFdUtidElkTHJqUlBUSDJOOGl4eElTaWtVaFJBS3pXTmo3RlE4QlNoNjJC?=
 =?utf-8?B?V09Md2xIVDBRRWtzRUNRTHJXZnNmQ1BJWmRHUDNJMHhhTzdmaDVBa29nam5E?=
 =?utf-8?B?cXpKNzc2OS9hZkNFdmU2UHdBRFBlN0gveHRWVVh5TWZUSVNrVzY4UGlFMzU1?=
 =?utf-8?B?eDBzT2hIUWsyKysvZGkrZzJKRk84T1dZKy9Eb0YxbGhsOEdJZG54N3BXQzR1?=
 =?utf-8?B?YmtHZjVTQW51azBaTXB6QlFKbnExNFFoWXF6VWZIRFBWbVlraGx4MjVCQzRi?=
 =?utf-8?B?aTdnUnhIWDhlZTVDazBKa0ovRU9vQmJqRmNmYjRtdnBSSEZDVkFRZHlCeVJD?=
 =?utf-8?B?T2JyTFpYbld5Vjd0Z3ZVNXYrUTA0YVFkeVhOSEE5eURXYkV2SFh4TUtTN3lT?=
 =?utf-8?B?RnRFNzNob21qWHFmOTBHK1NudjM1K1JSdElxdHBvV0RoQzJxdlJTRmdwOE9R?=
 =?utf-8?B?K1owM1U0RGxOZlpZT3FHbitYbGlZRkY1WFFhUU1wZURlMVovWFNTaTZ4Ylpq?=
 =?utf-8?B?K1BMTlZjZ2laS1c1RTFjQXdOTlp5RTBmYUh5VXpxaG9HQ0pveWNlbjcwSVhJ?=
 =?utf-8?B?K0xBc2JSeGJIYUtFT1ZORTJLZVEyaWtBdDFTSVdOcW5FeHhYZ3BqSGt0TXJJ?=
 =?utf-8?B?NmsrYUdFMGRneGl0YXhKbk5IWS94YTVRSlg1M2twRk9wWEthOXFHeDlkM3R1?=
 =?utf-8?B?MGNMcVczSTRlcFBLZUJ0Ty9lRm1BZjVhWjB6dHZqcVJTdDNEZkNWMHJnalNt?=
 =?utf-8?B?NlhWckNiSU4zWmN4MWNJQitnZjVNVVhMTktjUktDMk85WXBOS2VKcHFTTExB?=
 =?utf-8?B?RFpBZG5kQXRRMzkvUThPaXQ5V0VJTWVaaWtoZHBvN2JVaHRTYWpmR3lHYm8z?=
 =?utf-8?B?WGZicC9CSGFmNHlzdERRMWRPQXlsTVJsV0FDVU5QanQwaGhDWDRRdnhrSlhR?=
 =?utf-8?B?b1NTSWVXNUJNZFd5MDVyQTNjdWZZQ3NqQ21wVTVYdzRuRm4yeFU3N1BxVTgw?=
 =?utf-8?B?UERlVE5LdU9ON2d1czV0ckVGQmN6N0l2Y3pjaksvK1RSY3FaeXpCMEJudG5F?=
 =?utf-8?B?TmMzcGJQeFB3Nk9vWG04MTV4Sms2cXVmTEh4N2Z6aXlHZGV6MmI1bFBsSzR2?=
 =?utf-8?B?dDdJV1BXQnN0UnB0NEFMSGdzdldCaTJ6Nk0zSHVmNWVFSDJJaCt4RmpzaGcy?=
 =?utf-8?B?WmlrZjd2ajhCS1p5MWhMbE9vdmliVXdqeFlkY1NwTS84MEkxQjZjUGRmb0tL?=
 =?utf-8?B?TDhoMjZFWFJNSUNURzNaQXA5eUJYUldkVnNEWDh2UGJWaVBBSkFWV2tkMTB6?=
 =?utf-8?B?bXN6b2hHLzdwbisyL3p1TEVBSzExdDA5ZjczQ3ZEQnhRQWsxYTY0Q0VuWXE2?=
 =?utf-8?B?dDVCNGh5bTN0dkZwMFN4R09YcHdiWGtIL3JoS2t6TG9wTklONlN1SUhSa2Uy?=
 =?utf-8?B?ZjhqTVd2Q1A0ajdCc3Q0ajNpOVowS1hmUkNYdU93d3dnTkJqSmRBSFhYWjdJ?=
 =?utf-8?B?SWpsRHNOT0U0R1VPNVEzbU1ibG9udVJjYjNZaEtCc1djNHdRUlRzNlM1eDVI?=
 =?utf-8?B?Vy9NMEtMcnQ0b0dxTFZ1OXUzdDVBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d658d9-a41a-4627-3ae8-08de163fee0f
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:34:56.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3W7OAPIjBthHVCvowKvgsy7KJUone6ugrsF+CrUSaDyrkKyReJC6cZtt0KloVWFGQ6YFft29TfZIsC4gxDMVMzchomtazMLqpc13seeVtfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11036

> Also, it would be better to post the two patches as a series

Ok, I thought it would be better to treat them independently. Here is a series of
all three patches:
https://patchwork.kernel.org/project/netdevbpf/cover/20251028161506.3294376-1-stefan.wiehler@nokia.com/

