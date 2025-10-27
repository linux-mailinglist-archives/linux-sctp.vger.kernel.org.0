Return-Path: <linux-sctp+bounces-711-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4EC0CBE2
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58F61897F7D
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6B2F12D7;
	Mon, 27 Oct 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="oY7BCiuV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915126F29C;
	Mon, 27 Oct 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558416; cv=fail; b=E/PW2SY13736ORdgcITlnGcLQloFi8yPWFv3WbUFbIIJzWlS1NgBghjK8t+9wbPdSQlNmTM4YhHtOSc4vh3eRmDlA2XbnKzhYSsULZYl56g91GADF9RMZaRWHZUCuqgIChbP+HlMn+JGItcsUIh6sEB48RqMRIpAV4+KIc4KTMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558416; c=relaxed/simple;
	bh=g0rxbOJp9zfK+khfofVaBOeM7hCjB6a3lGxyd8JW05o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UOK1xY6xjrWSYeRUrYY22/EeKbZDHVDecU+h/hnPkm+HRBvZzeRCZt86qX9Xe3eSbK0huHwlVRQPOr1WN6/erPfPpcd9mS58NVQsBGmXOACyz+6id7cLy2EuzmiVG30iRGPqiwJmep0w0uq80y4LqY2K7p5awQniirfI9oqVfUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=oY7BCiuV; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWCCS/S5WVBCyrosjBbgXeCwSvQl2cGg4TBVyQfBEZxJCe84tLhdJhlBKVFSs8n19GQaKVYNN1rOVg9ccdMZg/AYgTvJEeMobslygjyabdSw3FtjvFVubM5NOC0VgZitw+m7inu8YUCvO/JjkEg18FdgrPAPFdVv6Ob8IdqdKeAVdydtBNHQJ4zKLH3QUw46MSr8WZ/WHMnQI7XS19yuJYjH4d7K7VPkUl0nn/NSILD1EHCcaUJ4tufH3seAfEr5TdXBm30PBigmv2eR7EIGsfrYnChub8LjGP8CYcnkbFBeb1O6dvG3afORFp33TmlhMSXuqVUke1YIplfrXkDPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9mJTTqOn7l7QusQF15SAo1mMbnrzWSlj8AsNDJP52k=;
 b=k7ynjgGTGhxT8wHPdbeMQvE0xpeSH1ZS6VIDjIHDyADrj0qw5qdtpecnuiAAsH6s1M86oP8IOo4bCc4e1c7v2IQGxwrCC/Py1zyqCfKG83rvRQyWGx9m2YixQZcp2ja+vWeUQsdyfDE9IDCzyP+yemS/se2x9zGupo2pU/n+KpZQXpVMZm/JHFfZPlFkjLIRbXdWr8UmZrHwRPz2m1wZObyNNOw4e3qa0w9vlYTMZ3/26uonL5atAVEBQF1AXh00pideBPrvm/rDw5lI21drEaeP6QYMknkStKBOWsA8MRqWZBqBh8UroCgsP321tnUVVzFoBF/Wxicg3FcXMccQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9mJTTqOn7l7QusQF15SAo1mMbnrzWSlj8AsNDJP52k=;
 b=oY7BCiuVI2mYOigMJRrzLHjLgE9GJC0+qr1lw8BnVQVgaiG5g5Dj6ZzyUPXIJXOLLGPKCZeEEu+CqBy7Bs4jbdvzcc2bPLfYp0WviY1KaB8dR6wGKrBLgY0xAGj13hmfi3uGNvBJsUKhNMaVwsW7KM/ZzaFhU1UwuG91QSSbXUoToNCyBzxQU7d1xVx6MA9bT7POMbV2Yby2GjrJ1F0zQkWSbZJTV0J4Bst15HKm02Kah0ZztpKL/ClnPNk3wAyFWjxRA/Y0x7tJzC+iykRp1SJ+jJ9aQ3oEQNA/MvklaIWrTOUxyXXgbH4df02A1wLG9KQ0L6NLwQ4PXvzUZ3OxzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GVXPR07MB9773.eurprd07.prod.outlook.com (2603:10a6:150:115::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 09:46:51 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 09:46:51 +0000
Message-ID: <e9beec83-aac6-4bb3-b04c-28ff584511fa@nokia.com>
Date: Mon, 27 Oct 2025 10:46:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sctp: Prevent TOCTOU out-of-bounds write
To: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
References: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
 <CANn89iKSP6pCtn2vu8D=5-Y7LSxCtQA4s=qXjvHsMeOTstfbOQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CANn89iKSP6pCtn2vu8D=5-Y7LSxCtQA4s=qXjvHsMeOTstfbOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GVXPR07MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: aafe1054-cde0-4fe6-105d-08de153dc0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXRGaVFrZXU1a3FjS1A0NFJzeXBsSjZGNVJqVitnajZSTENZZHJsbHRJdFN3?=
 =?utf-8?B?eENEY1hLOXlrMWpIWnlrNzVEZjN0THJ4aGNSNDhudW9ERDZqK2Q3VXY3Mk50?=
 =?utf-8?B?YkZZUEkyQjFpSXZzNmUwWVlPZW5pOFlmZytyc3dPT0FrbWVoUWZCMFh1Zlk5?=
 =?utf-8?B?OGltUE9LbnNmZjFSYzM2YVBFelBvZUlqNERtV0o1M0tHQVVXU1lub2dpdEFz?=
 =?utf-8?B?dlNTcTJtVjhHV0g1cmE0dm91dCtBNTFrZ2pkSVFBVEllekc5aUp5b3FBVkdT?=
 =?utf-8?B?Q0JVdzZJMHBWdnRYeFZxcjM5SGNjYS9LUmZuQnNPa1JPTmQ3OXkvbXhNMXJ4?=
 =?utf-8?B?ZDZTT1NieHJ2N0pzOUpWem5keEI2OU5pd3QrdWIrYUY2aGdyVDRYUFhERnhF?=
 =?utf-8?B?VStwQWljZDhDR3N1NTZOamNLbll1V0dqWHgvUXQ5L3p0ajBNaGRZZ2Z1UHRE?=
 =?utf-8?B?UHhJM3JFZXl1amsyTnF2a2hlVlp6L25rNFFrK0R5T0w3d2NtaDlKM0Q0QU9n?=
 =?utf-8?B?N2sxNC9mcGU0eEdIZFliTXprOFV2eG5nd21mU2FvZklXNmdIZm9OamJoUENL?=
 =?utf-8?B?ak5WYTBwdm1uYWRkV0d5YnF4N0ZGeG9Bblp2Y2FUVWlEb21OZ0xDdXJXYmQx?=
 =?utf-8?B?MlUwQUNoTkREbnNlQTlpcnpKSVZXV3VacGJlS1pzblFqNXkwbWM5ZDdKTzJR?=
 =?utf-8?B?eUtuemJUYlcxY0JNWlNFQVZUNThqM1o3RkIzWTVJazhXUEpNUVZxaEhZc1dB?=
 =?utf-8?B?Njlqb2I1aTZ3RTJPMy9WQVZ3ckNoQUdteXhZL01la1dncGNmenE1VlZSNXhT?=
 =?utf-8?B?S1JLRHJkMkVhWjNSc3I4UU0zRFVKQVM1QjNUTXFwa2laRStBc25YeUpnVEl2?=
 =?utf-8?B?QWxCUFJ3d2VEeW92RkJoQ01KVk84YjVkbVVqMTNIVWlsWDJ4b2dZTG1QTmtm?=
 =?utf-8?B?TUxoUGwzdUV0LzRQdGRjUWIxeHJPQTVpdGQ1MVQxcjlNZGdzV0VCem80S3gv?=
 =?utf-8?B?S1dld3lVUW9iOFVhRUIzNExsQUhZd3c2SitpNjZYeG5JUXErTVlnOU4rSEVX?=
 =?utf-8?B?bjlLdUNwdTVuTEZ6bUprcnVGbmsrdGdwVkxxZUtOVElUczlKRHZtZlhWSjVM?=
 =?utf-8?B?ZnJKRGVCZW0wV1JiSFRLM21Jb2wwcFFaZnlGZ3Q1Wk5jcWFOVGVGbGdnOHo5?=
 =?utf-8?B?ajFTZENQeTI4S2FnTzRsYTFwdXdoR1krSHVuMXZuOTRHSm96NTJyTjdteFlB?=
 =?utf-8?B?RG8ydE9DNTRtRkpKblVUNk5UUWFtZ2NaWTV5Vi8vUTIxRmtLb09TZk5NY3U3?=
 =?utf-8?B?NTZ5SkZxZUtudzRrbHdORkNEem1jZmZTN2FlQ1VuN0Q2SUJINHYxbjVqM1Er?=
 =?utf-8?B?WGZWdmIwYWVuT2tRRjhSUVlKOE1jWWpwRThVWDhOdjRYRjZleDRUR2dBZFQv?=
 =?utf-8?B?WjdXS3VlOHFWVDJKckllS01MdGxnOFQrZWdqK3c5aVErM1FMSHcwSzBPK3Fn?=
 =?utf-8?B?TzhVQVR0RXo2OXVIRVU1SnZoblRSYlhoNnMwQXhZZkppZWl6NWlqNXI3dmNT?=
 =?utf-8?B?ZWkrSkJuSU9EdTVLTW9BWjlCeDhWczhlUU1nL1hMSXhHOTk3M1BrU3FtMEdi?=
 =?utf-8?B?Y0RKcTkwTjFCQ09ydnBHSzBucFNRZUpXRFZqYjk2d2dOL2RlREwzcW9OUGtu?=
 =?utf-8?B?akdIZXhXQks3d3pnc09oa3FucHMxZlRYMGtJcU5GcGE3VVpYSzFET3pmdmZM?=
 =?utf-8?B?bjBuSkFROUZHaFUwQWZnalpPSkRJZFlmZlI0VFFydXNqS3Z5VDNYYXBmaGIr?=
 =?utf-8?B?L0FPV1Z0Mm56QlVyL2JkdGJQT1pxUXNpaTd3YUpad0RlSU1saTZMbzNpYXVB?=
 =?utf-8?B?YWhwNEM0dnU0UWcvUGgzdGd4clNNRFVtaWdMWVNjc0hHN0E1V1RIdDR0MEdm?=
 =?utf-8?Q?VGs1vB4K4jTV5UvjznLV9o8LMtLEG2X/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mlg2VXhHdVNlYVNCQXRYTXRHUW1vUXA5Z2kwSFBaMjF5UG9abDVQYTRzRU5q?=
 =?utf-8?B?MFZhOExwdHp1T3FXNWd0cTJaNmxWWC9rMXpUaTRQNEQzdnpNakJ5clpmUFVO?=
 =?utf-8?B?RS9CTzc0OTVBNEo3RTRDQmFDK2NFNnNES3BSejhIdVBxZnhEQjFEUmhnZ01F?=
 =?utf-8?B?U1N1ZythdUVpbzZrM2tqQVZaV1p3TzlRZFB1R1ZDdTZWMExRUDEzVnNGNDJk?=
 =?utf-8?B?T2UwZHdJYnlBK0dkYng2K1cvYWFGRTB3L3VmSjl2RUlwUlVVSjd6L2hvbkQz?=
 =?utf-8?B?Z3YrTS9mQlF4dGlTbmpnU2N3bERkUXl1NjZDZURzT2RvUzM5VVY1dG1XUjc5?=
 =?utf-8?B?azJHUTI4OW0wbG85QTlWK0k3eTRPMEZ1WGhCWTlHSkFDYVYycFQ1RFhRemh4?=
 =?utf-8?B?NGJuV0VsaXBpSFZsYmVPbkVwVGRWVFh4dlJvalA1TzFCNUpiQndCWlVLYTdh?=
 =?utf-8?B?dTJMM0prWkd3MEU5QUp0cVNTOFFNU3pKTWdreERTUkVFeStoK2ZFcUlQODA3?=
 =?utf-8?B?Zi9FM0RtQ3NjdlhQenl3WXNYR1pYQnZ3N01RMldkTnBIc1Vnc2tNR2IzV3pj?=
 =?utf-8?B?M1IzTWttTnhHbEkyQjNJNWlEVTYzeWVtY2FtQVo1TndPbnFiTDZybTRPZHFB?=
 =?utf-8?B?YnB3Q0JNRTZDU1FOQ2FDZ09lT2hLUE9LTWM5YkRmVk9JUklPWTZ0OFhJcHRP?=
 =?utf-8?B?OGJjL0ZzeTNDMWFkOUFJNGxSSzZHZkZqR1ZSSVBwSWlTMWduWi82aWlLUEpk?=
 =?utf-8?B?ZVZqOG5DcENZemwvZGROaEkwbXQxQmc4RHB6Qk9oMzRPdXByWXJ2N3owZUlk?=
 =?utf-8?B?SDFOb244WlB4UTNzRWhaYTdzcEFtSUdTRVhCdlFYc1lkdFNubk9UNUtRUkYr?=
 =?utf-8?B?eW1BcXNGUk9yTEhtUEcvQkk3c2Q4T2ZJVjh1N2kyS1Yxc0xwYnZBWGhQYmQ5?=
 =?utf-8?B?d1ZNYlZ3UzhmSDZKeGF6OWxXMFNjWXVKZnYwbW9Ib2FhbzM2eENNUlhFMU5Q?=
 =?utf-8?B?b2NkakNmdjJJYlFmTSsyaU1ISEhpNHZST3daaElCOXV3YS9xaFUwczNqa2N2?=
 =?utf-8?B?WXJCdWJCeGRKQWZVb1ZEcmtIbkZDZDByaEp2aHA2L3B3RTVyajVubHdjZ3Fv?=
 =?utf-8?B?V3RqSXdCSXZLS2wreTkySWVUckVuYnhOeEl5MEVUOWwxekE3ODc3WDU5Z1p6?=
 =?utf-8?B?anc1YmZiY0hrTDI5UkppT2FocEhEblY0SXl0bnp1MEUzOTBZcTlESmdVa1RU?=
 =?utf-8?B?RkpDOGV6em53WTE5aDZzejFDdnZZUEViZENFTUtoMTRQZDFQVlNzeEtMTWcx?=
 =?utf-8?B?NW5EUHRTNDlRS2V0NDB2YjJQeTFObUpvanpQT0pxYU1NaVhZMWdTb0dCazNP?=
 =?utf-8?B?TE1LWG5iYlpvSllnVEQxOVhPSVNEZlYwQ05VMDI4Q3A4bUJVaVF4dGlkTW9u?=
 =?utf-8?B?dFVzdGM5Sjc5a0NYc2V2TGFiQTZuSVBrVzJiZ2UxdVNadjV3aU5Tek11ZlJI?=
 =?utf-8?B?dXJzbkx0RW5KR0tFMnRrVlllOHRHcXNITFVwOSs4MzhVUVpDRmhzL3BkQzJN?=
 =?utf-8?B?a0V4WFA4Zmh5aHVVckczUTdoQ2ViQS92V2RPa3dOOHFoRzQxTmxmNStsSzQz?=
 =?utf-8?B?SXRwbTFwNkpZZ2JxNWRKbUZXcFhMY3pLeWVUSnRYQndMM3gwc3pPZGlFcFJm?=
 =?utf-8?B?MGtnMXdHUU1XcElidW0zM3JXU0M4OE1GZngyZGF6S2NDU28yVzgvckU1ckQ5?=
 =?utf-8?B?aE1VY2tQZzVUaHo2OHBxbWpvK091L3RvdzJyaC9wcG1zZXFpWXpNMUhaM25S?=
 =?utf-8?B?cFRTUFhwTGtSL2tUa2N4VWloNDcrQ3QrVkRHbk9KOEVXVTFaQnBpNmhMclB1?=
 =?utf-8?B?UklTdE5DZkhsWk56dkJ4clhPSjNYRE5NcDJrOHBaZm02RkVjbmVVdENaK1hw?=
 =?utf-8?B?enZ2NnNmOHFvZW43SlVKRFZPY2swTldxQndoRmplcm9EMk51MFB2RjM0V01Y?=
 =?utf-8?B?WktEVEUwd1RCMmdvU3NhRjhQRzhBY1RzVjlIdXAwOXlsS3FHTFF0K2tVMnFG?=
 =?utf-8?B?clJxWndvVFc5N3krcVNCdkt1WS9BRGtiTkdUa2tIZVVqSHA2c0NsbEJMdi9M?=
 =?utf-8?B?b3h5M1hIS2NqT2dVVy9TSkFHVG9HWFRDYnVWUDdmVUZCSkN0ampzekNSUkow?=
 =?utf-8?B?dVlZNkFwSTZER1JJeVJBdUhsTWljL2w2NmswVktUczFscHRhWU1SU2R1SC9E?=
 =?utf-8?B?NWVyZDdueHZFSzFGVGY2ckpkdC9RPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafe1054-cde0-4fe6-105d-08de153dc0d8
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 09:46:51.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBozCqUuE0gUxS3pGN7F1JUSNksTrGk+zJoPAGjkE/ggxiT6Obrz3hX1XfwDmiXVt6znVD3Wn5UbDrEBIb3TDBdJ9eCDijZ14GnieHfqtgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9773

> No changelog ?
> 
> Also no mention/credits of who diagnosed this issue ?
> 
> Please do not forget to give credits.

Sorry, changelog with a reference to the discussion is indeed missing, and
credit goes of course to Kuniyuki Iwashima (Thanks!) who found this issue
during review; will send a v2.

