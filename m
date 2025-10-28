Return-Path: <linux-sctp+bounces-723-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48491C15E27
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DA93B3908
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C0344025;
	Tue, 28 Oct 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="oGIGs1t0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55F338F20;
	Tue, 28 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669305; cv=fail; b=ium9SonnH0JhZa92Y8F2CUlg12axEkhOyeqYZeb/B2CzJm1dd9uXz57mZnyxfVPLr90tMIqSO9UfiPaKCs3r2FxUd9/w8wQaiSkOSGv7AGjkfyzsqaykhXHDy5A896mVypmZfGMh2jzyIisrMR+QgiI5+PbQtTTrZBsUZwuHiiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669305; c=relaxed/simple;
	bh=cvPvIBHajku0uboHqk/srPdtzmnh4SFRNHs9N1jNaYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OYZGfYQoXRMUp4f3jqcVY+QvmSc3+NY5l4tXXwhcQXi+jUVIBkao1YgwE/8tIkgurGx2hiGe54zRzMiC1lhtdi02VEKnR+8u/ZmjROc9NxK+PTuz0TJVfvg+2SsO51EG1gdd7z/+Ov6oAGIm1nLZ5SCTw8iH9kUeRQW6rBPViQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=oGIGs1t0; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR7L4csBROWrsorXm4KgrFgCgunswgmo6shB1CHfCENmY1WgRA7D7RAIjjwMsXnjdBPqT1/vvvlAnpCVlgpJxHx6pCXWrgYJ9I0WbUrLx1BIM9Xm/AhEor4BjxugXibEbe0x4KPHymUrzUXCbU7k4et6x9oZn1aCbi14NbAelzJuCh8AU+1jdB5/+CnBftow56LRgii1fR5WNBbHSIzS5BWTEPiSxYHb7Dbuqu1X5OLo8MvcDOJghb3QzbGRv+69/mb30t6Dxi1sRBRBKlcpJR63ZyNH/eVyssJtzBBAPtyYgencW1Bnsa7caQ6Ja5Fm8FtW/GzhdCIEv0iK/+DS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvPvIBHajku0uboHqk/srPdtzmnh4SFRNHs9N1jNaYk=;
 b=R1C7aX0HKs1EqqGNZmXrZe98b4BcXQZx98zZGCUx3XkRPDih5A+PfHZ+fQh+8IYwgcV8WQ39T1hjiT/fGNPvHtfG4q1EY9ULimDEaSSIlXRQ5mpCZyBv1s23Bm2EruPJlhY3349qqUdP2reMryOo9QrD3cUkppQUXofV5HPCA9LcREYvrrOXVVn95pQZUVJkptczQnhkWt5vJg3QBNoJWg7gGW6aanzRuBPdZ7DZXkyu2+OnSQ7ccZ8jbhjWopstgBfJ843ldP2Y0+Q4CpXDKCJde7lXB8GUiNbN45uDDrB+AJYUBV1kmnFPFG1UMNhTSfA0ANRdQDVByRkTbr1kmA==
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
 2025 16:34:58 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:34:58 +0000
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
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI0PR07MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: beb4deb6-7f64-4afd-9311-08de163feed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWdCdGw1b0pudHMxNWExOGZvMGRBTUlTSXU1UWJib1dLb29HU3QzYWR5eDI3?=
 =?utf-8?B?aFVWd0tXY1ZhendmOTFhbURkYVJrTWNyL3ZPcnNWNU5oYUg1Sjc0SDM1elY4?=
 =?utf-8?B?bGxIbmZLTlREVHJ5WUtFY1VVU0JBOTBOakZXbmpxVW5vMnZpS0x6TVpuVGdi?=
 =?utf-8?B?bkQwbXM5V3o3MUF6RTVTQllhK1kxNVBTdFdhVGxUd0xFTGlZOFMvQVg5aVdk?=
 =?utf-8?B?cnRsWmNQRm5BUnRYU2JaY2Vya25Cbld1ZmFCVjVIK29YR281RERzVC9vOTFS?=
 =?utf-8?B?MTBTWW9kQytvbHNobzFlclBtcFR6a0diUmtUWVNkQ3pIZGtpOTk0NzBoS2lj?=
 =?utf-8?B?YTlhVlJ1YTV2M0ErRHkxcW9ndmlBTkdmUVlXTmYrWkNmSERZbFA5TlRzSGJ1?=
 =?utf-8?B?cHh6NnNHeEJyUnhPZGRrOGxpK2dEUzBRc0pLQ21HeDUxZHk5ZGl1QXpGcjlG?=
 =?utf-8?B?SmUwSmpSbmZ0Qm4zU25KQ1NRbGo5MmpRSTRsdThpZkZsM0FaRHZtaXlocjZ0?=
 =?utf-8?B?NWFaUC92YVM4aC9yZzAxOEQ1NzVJR2w4V0g0dzI5MmhISEJUU29kWFJFZ3B3?=
 =?utf-8?B?endxdnljWGtsR2dEYi9rTWk3VEd1NUtOOEpHcWlzblNrbTNLVTFDZVJhUlVi?=
 =?utf-8?B?YTJOOXQ2Wld2WGZ0Tm9JVENlcENuZnhlaEYxeDJ6bHdJYmliMTFRYThtNm95?=
 =?utf-8?B?Q0xmWVZLc0dMM2FiUENZZXVOTFJOM1I2MTkzQkFGZ084RVB3VFhReUtTUGM0?=
 =?utf-8?B?akNRQk1kcjEwNjR2YW81bWc4a3ppYkZ6NldkbkV3YlhybDBiY21WYjRpSVh4?=
 =?utf-8?B?RWU3QmtlZXZBNFBHYmZoK0RCcEQxNjJUcGJmTkUzUEtFeUVYTUdxWC9hZU84?=
 =?utf-8?B?WXpERlY5QzFIMEVhdnJxT3hGbTcyMUpCSzM0QURNdExLbWU3Vm5KZWtRV1pz?=
 =?utf-8?B?Qlo0SWVneEd5R0FIWWdNUEdwcXBpU3VCejVKOWk0RWxvQUdBYlJWdUdiQXRC?=
 =?utf-8?B?YlVaS2Q2NE95aUVXa09xRjduWXFsOFQzeEZ2bVkvR2tPNU1HR2VGUUpFWDBW?=
 =?utf-8?B?dDBTSFB4c3pScnlZWkVNMFhNWnBhTWh5amx4YWFvN0lrUVlFU1pLVnlMQUVv?=
 =?utf-8?B?QnJ5VUE2STZWUEpwdHdUQng1c2QyQzlIbFZRdnNOeDRxdTB2ZDM4UmR2aUdL?=
 =?utf-8?B?bS84bWVIS2g1My9SMVhNR1pBekI0aVRpY1Rqc0lMTDFrWUh3RGxlVll2ZzM3?=
 =?utf-8?B?OU9yVmxCeU1BMTFwc0QrVjI2MGFnYWMwY0l2bGszZTViR0tyZkttZm9mQW5r?=
 =?utf-8?B?RjNxTGRwVHZCREVKK2R0L3NOVkhaUzJQbWQxc0RKUUcxb3RXRlBZTld2Q3ZR?=
 =?utf-8?B?ZkVYVWNBd3ZxeGpPSEQzcDE5ZTRZWlBzYVlhYmpYSXg5bUVUdDdQZ3J5alZJ?=
 =?utf-8?B?cnFGYVhsRVpaTk40M3JqNTlHUXQycDNDODRCbUVYY1lIQkpweXVwRWxNQVhj?=
 =?utf-8?B?dzhCbmNCSGhNUERHaHhGbFhjYkZPRlNmalBkRVk4Vm9IMUZKcjA5dE1VVmFP?=
 =?utf-8?B?TmFGTTZrS05ibGcyWEFIWVY5WDFNTUpOS2VEZlRKQWZTaWRSVE96V2pma3ZX?=
 =?utf-8?B?dE5nenZycGFudnRDZyt0QzhmL1pWYnFob3NRN3E1TmxieXdrSGpwajYrSHhS?=
 =?utf-8?B?Ly9lVjkvN3ZNaVhpZURxaGQyQTViZjZRZjc5Rm85S29VUGtHeHc5NUJBbGRa?=
 =?utf-8?B?T2tyM3lmUVNzWmZZdmtMZTRjK2RxQmFzK2FUYjYxMTFMU21TaTJpRmJPT01t?=
 =?utf-8?B?MWlBRG1Wbm9oRkFnWTBTWkpsb2RjaXlHTnhtWkVEelhWU0ZKa3Z3S1BnTnVG?=
 =?utf-8?B?dGIxUHVMRUtVeGNMNjhGbmhSdUw0STBRaXh2M1M4TWZvTmJUSDJwTmxlOVNx?=
 =?utf-8?Q?pmqmeZ35PHkSv3z0ZpJ07fb+30oqQwr4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGxLbkJDTGpyZTMxaXV1TVFWalBiY3lZNWx0R2JVOEdVRWZ1WkpMOVhPUm03?=
 =?utf-8?B?RndGdEFQMythZml2UXZxcGx0bjEvc2xVblpoQmFyczJjcWpveEJaSXZRZDJ3?=
 =?utf-8?B?L3Y2eTk4Mk1jM3p1MmNuOGRROU1HMFo3RUZIUGwxMXFBRnZzR3VwMmh4b0pz?=
 =?utf-8?B?NldTSFBOdWlFWVZqWlY2a0d3N1ltUlJWR1hvdXdRR01jVkE5SzlkT1dRN2sr?=
 =?utf-8?B?SmNSRklwMVJNTXNmR2FMQUEveEp4L0h1akxCSFhuZHoxdjFEUkNNZStBU1pk?=
 =?utf-8?B?cjdDbzFUaHVWbFByMVRZZEt1MnU2bHJDUjR4RHc1a0wvWUpobE1ta05CeVY1?=
 =?utf-8?B?QURycENvdG96SHdFbHY2bmYvV3FwVElYbzJqTWdudTQ5Umt1MlR4Y1JHREFp?=
 =?utf-8?B?dE9DeUdERTc0K2xyQXVqSW9KbWRlMWUxWnFUSTZxSUNYUTYrZzZvS3hDcWVs?=
 =?utf-8?B?TFBoU3FFYTFGbGlnOXBtMmdTTzhoVEpmWkVlNW8xNEdnazdBQitJdWRmR3Fh?=
 =?utf-8?B?KzZDR0dTQTNRcnhCeXJ5WDBSckRNWUlKMTdLVy81THdKVjkyUEZKbk4xQmpY?=
 =?utf-8?B?Ym8rQnBlZGJiMDZCeWRvOXNJVzlnZFkvbGpwYVZYczZZek55blorZ2s3TmRw?=
 =?utf-8?B?dzN4YTJhYjQzMW00MUF6cTA5VjBZM21HQWZxZTBBVXVYbk1LZGk1TDFuRG1H?=
 =?utf-8?B?aEk0NWdUeXdRQUJweVdTSkYwQVlqYVdYOXl1bTdvOWFxY21GMXhtUzE2WG9U?=
 =?utf-8?B?T3V4V2plY2QvbVNTVDltQ3JpUUpQUUdvVVRZelpwRVZrWUl2bWtaY1AwWkQw?=
 =?utf-8?B?aGYvRlJIcGRLQndHVll5Q09CN2RRMmtsaWdyU2tlcllFcktJVnlRVFEwbjJr?=
 =?utf-8?B?WFhmemlkTlQ3SExkbWdjK0NtRnhrYzl1K0MxVEdWczdWVWFxSjRFU2o0U3VV?=
 =?utf-8?B?dWZDZCtvL0lBTlExQkowYWJvSytnc3dLVUhZd2lsbW9XQ0V2Tit1RFlNLzhi?=
 =?utf-8?B?OUVBU2lyYkJEZTJYTk9OTHVXRDE2U1dFeGJpaHpFQlhabkZmMjNONnVsZmpt?=
 =?utf-8?B?T2xoNTJNTjhyMEYzbGFTNXB5dEMxNytJM2FmdjFQTkYrSFVOR2dQOUF4MEh1?=
 =?utf-8?B?V3dNREJBYlhjdHhNNW9rdDQ5VkdYVmhGL29mM3J5eGM4Qm05SzBqUWFQWUs4?=
 =?utf-8?B?TVF3Q0hSQTBrWndqV1VGLy80dktGVnZ6dTJ0OFlVVUhNMVZiR0E2MFpKQ211?=
 =?utf-8?B?Z0ViY2lWWTlXVC9nT2hTLzEvc2htdXlybHJuTlVjUFhVNkttU0ZSTmt1WlNL?=
 =?utf-8?B?ZG1ZZ3IzdlI0dDhWTFVLRnI4NzEyNS9GM2UwdWRhN1dvZnJ1MW1kNUdUNmFN?=
 =?utf-8?B?THI0ZUJRdUFTU2Q0ZitmTzloTVB0UVg1emgxYWdYQ3Fib05YbmFrZ0xIMVpM?=
 =?utf-8?B?YWEvWTl1aG5VTTUwVklpNW1BWWt6RjAxR1VPcHB2dU1CZ0VXMEE3eWdZUFMx?=
 =?utf-8?B?SFMxWHljcGJIWklVTWROdUZmQkRZMmN3Y2dtM1lwMWpxNFpUSlF4N3JLcVNG?=
 =?utf-8?B?cWRQQ0hXRE8xWFlDUHFNSkJneldJTC9rYjZTSjBFTGVOZVlETzJQWC9hWGs2?=
 =?utf-8?B?b3ZwZmlrV3R5TGZ5S0dEK3lULzZkOW1OZkJlZzBWRUJldi9iVFJnTk1NajdV?=
 =?utf-8?B?Z3VyYW5JUDRTanNVdmRSTkFudkJPQkcrS1FMMHZQbXplMXArZ05sb3RJVHBD?=
 =?utf-8?B?M0JVRzJYMTNRWXpUMFBNeHEwNW50QmRDWlpqUUtKS2NsYWZiRGlXWWlwK0NW?=
 =?utf-8?B?U1llaFRQd2UxeWJwMm1KK0xLTHFPV0NjK3BVRHZib1VmdnFwb2JHNzkwN3dU?=
 =?utf-8?B?eDV4TDVkajNzbC82M3VBWUhETFEydTFSZDJrd09FSHhzTU9BbmMvUmgxRlNQ?=
 =?utf-8?B?a3hueDRNQUJ0S2lwcWxxeGg0cG1DQlJRUjhWdmtwbmxZTTZ0ZXRtTzMrV3BL?=
 =?utf-8?B?ZnE3VFFUcXNVUjZuV0hvSE1KTW0xOTM2ZEVOTmwvSVBDb25RdlRhVkxWNlE5?=
 =?utf-8?B?dXJSZi9GT2NVcTJtaUhLQjZtSGx3TWxSQ0MrczNwNTM0bEVhdGRReFF5dGpS?=
 =?utf-8?B?WlV2QlZ0WVYzOGJkVVBLVW96elkvUzdqQ0pONGJGOXArdnBRVnlGOXdCMUFt?=
 =?utf-8?B?V0NWTk1wMVBZRCswRGpZZkNZdldYSVgraGo3M3VUMjh1bTFvM09IU3N3Y0lD?=
 =?utf-8?B?N0hvQXNoT3hBRVRsRWZ5OXdvby93PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb4deb6-7f64-4afd-9311-08de163feed2
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:34:57.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeK2B4UKgEoxyt5OnCcDyG32ED0uKuVsZOIBBck9gzR0JVSXvbQ+qsCEVV1JVJ236asZLRicqTHqK21K+sIHYFeeRLA36d7wPTKpoRVbhoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11036

> Also, it would be better to post the two patches as a series

Ok, I thought it would be better to treat them independently. Here is a series of
all three patches:
https://patchwork.kernel.org/project/netdevbpf/cover/20251028161506.3294376-1-stefan.wiehler@nokia.com/

