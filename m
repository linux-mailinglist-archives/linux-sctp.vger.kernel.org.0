Return-Path: <linux-sctp+bounces-334-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E1A309FF
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Feb 2025 12:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6883A2296
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Feb 2025 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A91F63D6;
	Tue, 11 Feb 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEHc8YiZ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A611EEA38;
	Tue, 11 Feb 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273654; cv=fail; b=aq3r56RxFG6jCFW3MQKuWKMb0tIZsO484gQtNh7MtHKYVJLcxM4RV+vgrQlO2K33lqGnF8yLmsPaR3ZtlBoyzUcxHKPlatHwPwfsCltYYc7+QYyWOqHqKAJkIxaGhiFgCeV6kgH4b3F7zZT1Iwf1Wdof/zHB90HY5SuEUTxBPYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273654; c=relaxed/simple;
	bh=SLVLhz+D2jAOmcR428WLJXgcqPult/kdLbE/Vtlfsio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZquwedQhDsOk2e5HsOZct+JNqW2nK6i2g9hu3QLXTbanCt+YplVrew8tSJijD3mqY6DSpi8IZsUxyEB+B78ZICEFUCoh8AeJVTqEjKS04MwIhnHZUOmQZhgI68z5sspYQZoCGvdcXRXIfMkR3yFKRrax6N5oCo90A2uubt5l/2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEHc8YiZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739273653; x=1770809653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SLVLhz+D2jAOmcR428WLJXgcqPult/kdLbE/Vtlfsio=;
  b=CEHc8YiZOcL3LFofwtxbFWjET2hawtwHmIoavypgAzSXEp+BhJ2o5Dei
   /Nka1jwEBhMrUELw1dV6BT7Vy6qpjDdTpgEEg6+gW1TVpUz02x0R+ArKR
   JA8TOtVLLIyzAa0IsOcGLm3qal1nJcum4v4Dw+BczbsLl6WDqrGqlQCdW
   LNwxt/x3xh1e3KGjbUeupZhEgBp3fkVXNDogNwCr4tRJfu0KWya/q65A3
   toZK5qWL32B53MHBcpXiAjVcrJIodg5Z3p1JcWJIFTGlAENs5geVckDw8
   pmM7oqS2/RFM23Ook51WN5ZihRVIseEaoLcE+wkdWC2+IJh4f0qz993dH
   A==;
X-CSE-ConnectionGUID: 58kUGW/BRQitG2H5E2V0JA==
X-CSE-MsgGUID: Q+Id7zVQSoydmIK/mFz7PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39804211"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39804211"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 03:34:09 -0800
X-CSE-ConnectionGUID: 1TJO5DnBTnKAWqm2Rw+w+g==
X-CSE-MsgGUID: OB5MmyDdSs2BmJq2hZ09+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="112316478"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 03:34:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 03:34:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 03:34:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 03:34:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3sJVkWi81eoCFd0gcl/q2rZIQ2Ha/DJ9EGwLgdbDP+/3gi+8O7k1NlTo+dNTwzZxBwN/kUhhS71wNijVCULEqcOoX9q+VLYwFH4APdFqQl5D1F2fVeTLyYHhjnINoJx+KTwl4VgqO9+hT6jlZNFw7aB+TdQFFLUrGZaYadHcd1miJkEZD2CcIDnfSc1OSwqUkbHazzjVA7GchFKytAX9hCrin2OUYUMOGswNEwYjUMDSLuJRqB/6ZXF8p30wUm8Fl7Kuwpxeo8zemk9oEskP+pclpOCJfwWvCCGK7UdJikyeICoiRbokeyCB8MTGWhs92XDlUEAnpDIiBr/OMiG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6huH/ZWGu6r9bP0sBSAfiQoq4cqBzeEXjja+mWUgB0=;
 b=c6jI1Plgif8IwSmKWLeystkyAWqBrgsoNnz7VblgEV07eDICLWT4/U+R6HFXinPuMxpzI72ljZT+fGeN/+mlbMxXFGz4T2QnP54q/Jou8nX7v8OZnypWB+tLrgzEtAcOPeKa2gTTKcU9CqQgsy2uB6e/MDOQ+PBeidHv1fqeQsVkKrPcHhnGVqdtx9/5H74t/vX9hDjBrbJY/35egjke2wP96PPLCj/hFeMPps9Z6dFlNk8ZH9ysfgYGh3zr5K/XpwY9PYsc4I75UfSD/xoUOcRhYGSPGPutgHL0Tgez48XUFbyv4LoIVQV+Pz34g95T+pmPRFIs43dgxrYaZtj56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 11:34:04 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 11:34:03 +0000
Message-ID: <2c8985fa-4378-4aa2-a56d-c3ca04e8c74c@intel.com>
Date: Tue, 11 Feb 2025 12:33:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sctp: Remove commented out code
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
	<lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
 <b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
 <6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0075.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::28) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|SJ0PR11MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: e9634c3d-9dac-4124-40fc-08dd4a8ffca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXp4bHhXb3JRanJJOW9uN3V4SkhYY0RZK2YwODBzRmg5NnZjZzk0aUtjZG1u?=
 =?utf-8?B?elJDSTdMQU80UXdNakFtUFJvTEo4RWUwWVQxQllKTDJRYXgwRGQyRzdkWlNJ?=
 =?utf-8?B?SmloU1kxR3BzVWJJM0YzKy90WTEwOTJEMTJpQStuaWhERUs5MGJEZ2JrZGhE?=
 =?utf-8?B?NUpjWTZWejNWMzY0MjMvWXpxVzhCUUNEV1NyY0dVNDY3NzM3eUh1Y2pxWHNX?=
 =?utf-8?B?TndQMVJFTUM4S2hha1JHQ284ekFoR1Y2MnYzcWJRWFU2L0xGSENpMWdoRjBW?=
 =?utf-8?B?am1FM0dpZk5laSsxY2g1OUNNZjhUcDBuZldIT3BVMVJOSldyMzNFN2VpZTRH?=
 =?utf-8?B?RTk4bVdlTTNxVm5hZUIvaGlYb01ocmpGNjVWUzJRcGQwb3lLd01pMDFQazN1?=
 =?utf-8?B?RjllQlJVa1dCUzZkZjE3NE5TMllqbUxFUzZ2c2tQN0VLaWV3ZEFpbTRLaEVp?=
 =?utf-8?B?TXBmK2FMOGdoblk1aVVnODdFalRQQm1ZVm9nbWJNcVpTTnJPZGxhRDlKcDMw?=
 =?utf-8?B?M2VNd3lPeHhGTGd6M2FQVXdFQmU4SWVza0N2SFJUMnJhT2c1UTFONk03bGpR?=
 =?utf-8?B?VHZ1OTZMQ0ttTlBpS0J6bzcrZVp0VEFwcFd5YjNwdmJnejh4SFhiSkpJaVNx?=
 =?utf-8?B?SXkwL2M2a1Zzd0pyL25DUU13V2Q3bW5Ec1ZUZzV0aHR0ZGpkT0lpQUZ0Zm5H?=
 =?utf-8?B?N0RwbTMraDVKOFNYbndLQ3gxL0VPK0NTaWV4L0FaUmxlNnRNazM2cDVhekpL?=
 =?utf-8?B?bkxJb3Zub1pPdVUyd04yTlRpdkw2bDl2YzZLVDhORVlSUi8xcnpVMXpsQ210?=
 =?utf-8?B?ZUphU2ZaUmtyM1prTFg3WWFBVngvR3UzTFNNTUpUc3Exb0M2VTU4Q1NyNUh1?=
 =?utf-8?B?MXg2TUNabG51bkRTVUtXOHJXNTZqQlpPSzBnL2RyQzJXOVdkWm5RTW1QRkpk?=
 =?utf-8?B?bSt1OVZtVklJVnRKb3I2dElQbk9kUWZ6UG4zbWZRMFgySi9CR1JjNlgxMTNH?=
 =?utf-8?B?UkRsRFNDb3BmYjkzRFNOV0lKeW1VMU02UFBkT1ZtNC8zc3JxUVVJU0w0bE5r?=
 =?utf-8?B?NncwRjZuTWxxN3N3dzRYSmlOK2E3dG85Tml1RjQ3U0JBL3lsQ1NZOWF1Q09h?=
 =?utf-8?B?NVB2WWVReVJmbzFoYlRjWEdaejJGUGxJK1RZaVNoSGsySEdSYkdVVUVtNXBr?=
 =?utf-8?B?ZWhDUnQrQ0hISEh3QXJrN0FjVXpydXZxc3JDWlo2M0tySE9KNlVDWXk0MEN3?=
 =?utf-8?B?TFZId2xvWFRZYmFKVHNmVzFTU2NzUUY5WmFkNk1Yc3ZXOWQ3YU8rbDRGK3Rp?=
 =?utf-8?B?TloyWTVJS0c1S2ttWnNvb2dXcE96dXpCeXA4dlMzUU54SjlRb252blVBSkR2?=
 =?utf-8?B?ZXNjZTNpNVRwNER2NkdPREV4aVBEaGJTREk1ZzdPUVhiVTFjY2xIaWRCZlJV?=
 =?utf-8?B?NCttbUM2VFFGRTJzOXpHVUJLSWwrODJ6QzV1K3hxRGEybDFMYmVNWkhWL0JF?=
 =?utf-8?B?NkxOUGpNNzZGTktkdVlTcDF3QnE5YUQ1L2U3TVlZSENpbnVjbTMzUDZ3cWpH?=
 =?utf-8?B?VlhuU0FmU01UUHRtdDk2SEN4YTZFK0JhME5lbnU3ZlRHVDVpUmlCVzJiMG5O?=
 =?utf-8?B?b01URklyYzhSZ3BZOGlDb0lRcEJLaFhLYkE2WERHUUc4dHN4ZVFKSzJjZGY2?=
 =?utf-8?B?Y0VKVk4ycmxESEJrMEI3bFN6RFVtNXRPV0k2UU0wcy9LMUdONGxOYjkrSndI?=
 =?utf-8?B?TzlIUEsreDZFQldIZlV5ZlplR3RvSkd0Q1FvRTh5Vlk4bWxGblFUbVk2WnJh?=
 =?utf-8?B?ZFhKdGNtNURVRXEra1BTS3FBcnBnaDhhd3Ztc2EwTFV6Q1pFUWQ2enpyaHJF?=
 =?utf-8?Q?YQ0zXXFNATQ7c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3lNRzlBUnpyc1g3MnJlQ3NxYmxIay9iYlZMUTk3cmRuREhJTkRNUnYzMWtl?=
 =?utf-8?B?UjZZdmhhWTdQWlgybzFlMGdmNjBxd1Mva05OVnZuNUp2T25CSmVMVVFSZVV1?=
 =?utf-8?B?djVaYUNCMWFNZEI1NkJkd29MSk0wMFNUckpWdHF4akp3b3FFNlBVcTBxcFZ4?=
 =?utf-8?B?VjVKY05DWnVFWE0yZmI3NFU1d2l2OGttM1FVUkZzaFR3MXFoa01Ha3huM1Nq?=
 =?utf-8?B?NnY5d2YxNzM1YUFmTWtJVVgwak5uN3pUc3Bkd2tVd1ZsR2dTcDBPYXc3enV3?=
 =?utf-8?B?Sy9pM0JUa20zMEdOV1Bsbi9jOXZzQStiZ1I1aU9KQlprdWlaRXArZDlMRits?=
 =?utf-8?B?UXoxTVd0aFZWRTFJanFDbTdLNHBCWDQ4S3VMTVhGNjhaeDFsZ2FVaWg1YUJK?=
 =?utf-8?B?YThxVU5jU3Zkd0hQcTVSSnQyNVpVOE9rWlZFMjJSVlZ3UlJmNklMQ04wL0JD?=
 =?utf-8?B?TFFZcGJpa2xNZ0VxVFhqUDk3M1U2WGg1SlV6V1U0UzB6SUExZW5KcGxrb1FY?=
 =?utf-8?B?eVJyZlltZVZKVFRZNHFkRVZ6NkdXZklKNUMyeGVxU2tsTGE5b0Y4NDJ4MzRr?=
 =?utf-8?B?SXZTMXVjWk1BMVhLRjRrOHlYYkJObG9YUVdlbFdvODU0bDM5ZGR4TkQ2NW9q?=
 =?utf-8?B?a0UvVTVTVnM0Z1dGaUlRUUJTc0xBbFB1MHJjMis0MjZWcFdlQjJUSm1lYUZX?=
 =?utf-8?B?YVU3NUVVOWtzbGloaVZveklqWklYemtjT2ZGMXA3Y2J0OGZrQVdSMzVQeUhT?=
 =?utf-8?B?eCttTzRmeWlvM0ZzK0ZKYkIwMnBSUEZnaTljZEx6ZzRnclFWOHdFcHhiZWsr?=
 =?utf-8?B?Qk1ycUhveTNrSXI1d2hjNisvdVBZaGtjNld3MjhjZnN6SzB4OXd4YUJoMDFy?=
 =?utf-8?B?U1RiaFB3bmVyS2x4ai9xaEhxL1ByM3pvMUJsbWpQSGpadjJ2dFV2enZwTHZ3?=
 =?utf-8?B?TnJueUlmOXNyc01sTnJmZHhqeWtQQmF3QVZXeXpTUWZCeXV3anBYanFBbUc3?=
 =?utf-8?B?Mk8yWVVPb2xRNFpWSHlZSzlkVFJnaVllM0MraUcyYTZKSS8vMGQ3MHlJVVUz?=
 =?utf-8?B?T3hvQmFUQzNMOEJka3JyU2xQWDhhQUV2R3gydDZEMVNGR1FpZnIvQTI4cjBT?=
 =?utf-8?B?SGVxdmQwdEJxWmd3dmNUeVZmZXdSSjNKNjlUeW00WldFWVBCV2lSZnBta1lS?=
 =?utf-8?B?cSt3SFNBdHo0ckkrM3UzNm96TkZXWU53TzZQaUNWb01LMUlES0RiOUFuUlVX?=
 =?utf-8?B?RHJwU2JxdEx4NnN1cWRRaXdBYTdBY3lVMllVQ29zU0JZYlM1ZE84Q0hhQmsr?=
 =?utf-8?B?SHlDWHBVcVEzazlRZEtPTUFPR2J1RW5Wb1Nzc0MyaU9QQ1FId3RWQVI3L0dL?=
 =?utf-8?B?bSszdGpXOURyczhSUjRLYUk5QUtsQyt5cUc0bnM5SzFmeXdNZTZoekUxZ1Qr?=
 =?utf-8?B?cWNjRjUrVFdvTElDbklKUFZYWDlyZ3pBQlUzSndUSEh1OFUxS3JhTXRCWnNP?=
 =?utf-8?B?am1pMjg1T2RlZ252UkxPUDloNDJYSmFZZ05peXp4VmQ0WDZXZGViSTV1NFN1?=
 =?utf-8?B?WVNoOCtPbjZoMmE2VXFwZ2ZpUUNpMTQ4T2htWnNIaFZZL2NydFlkalVQakVk?=
 =?utf-8?B?bi9wNlBlZ1dEM2xRSGh1WXU2TDVUVEpXOHB4WVExVmdTUFUrWXhIRUFhR3J5?=
 =?utf-8?B?NlhtbHhCVUNXWXZ4ZkVmUHpLbHQwWmpFYXk0cUlqNjZzYjN3QUY5aXF0WWpY?=
 =?utf-8?B?S0ZWSDZycFlZenRlVVQ0RXFNWWZYQmxkOTUvd05HVENVbmJvWTlDb3A4TWMw?=
 =?utf-8?B?Y2hiQ0wxS2gzN2JhQzJKUE1QSCtMRER6YlRWRkdoVDhrbGhndUJCei9SV1RS?=
 =?utf-8?B?N2NBSTVNbGRhSVM3ZjRtbTJFSU5oaHNsOWRTZFVrM3ovdlhjNEtoTlNXR2cr?=
 =?utf-8?B?UnMySURaTW4wM0JrK1p2V2dtbXV2ZFF5d2hTN2d3YWdsS1FOekdkcVVSK05B?=
 =?utf-8?B?UXhGMnp6Ty9RMHU4dVBiT25VdC9kcFI0RmtaYVFJQnc5VVJ3N01nOStseVZl?=
 =?utf-8?B?UVFQY2lTTmlaZWhuc2JPdTFDK01ncHdmUDFDY0xkNGwyN3Yrakl2Slo1ZmZo?=
 =?utf-8?B?TldRT2FwRzlwbVNJbko5M0ZkQmJ2QU9YMVFtSU16Z0hOVkYwckVXVnhlazlW?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9634c3d-9dac-4124-40fc-08dd4a8ffca7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:34:03.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhROsc2nW5DkaC38RwXihnaCshTte9168IZNIMT5rZ/JKFGmTX/EW9x04zsVOFmGmDLiZQz5YadZINEBU3lTbwSAUdDUAoQ3Kza5XaVjamw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com



On 2/11/2025 12:17 PM, Thorsten Blum wrote:
> On 11. Feb 2025, at 11:49, Mateusz Polchlopek wrote:
>> On 2/11/2025 11:20 AM, Thorsten Blum wrote:
>>> Remove commented out code.
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>>   include/linux/sctp.h | 1 -
>>>   1 file changed, 1 deletion(-)
>>> diff --git a/include/linux/sctp.h b/include/linux/sctp.h
>>> index 836a7e200f39..812011d8b67e 100644
>>> --- a/include/linux/sctp.h
>>> +++ b/include/linux/sctp.h
>>> @@ -222,7 +222,6 @@ struct sctp_datahdr {
>>>    __be16 stream;
>>>    __be16 ssn;
>>>    __u32 ppid;
>>> - /* __u8  payload[]; */
>>>   };
>>>     struct sctp_data_chunk {
>>
>> Hi Thorsten
>>
>> I don't think we want to remove that piece of code, please refer
>> to the discussion under the link:
>>
>> https://lore.kernel.org/netdev/cover.1681917361.git.lucien.xin@gmail.com/
> 
> Hm, the commit message (dbda0fba7a14) says payload was deleted because
> "the member is not even used anywhere," but it was just commented out.
> In the cover letter it then explains that "deleted" actually means
> "commented out."
> 
> However, I can't follow the reasoning in the cover letter either:
> 
> "Note that instead of completely deleting it, we just leave it as a
> comment in the struct, signalling to the reader that we do expect
> such variable parameters over there, as Marcelo suggested."
> 
> Where do I find Marcelo's suggestion and the "variable parameters over
> there?"
> 

That's good question, I can't find the Marcelo suggestion that author
mention. It's hard to find without links to previous series or
discussion :/

I guess it should be also commented by maintainers, I see that in the
Xin's thread Kuba also commented change with commenting out instead
of removing code. Let's wait

> Thanks,
> Thorsten


