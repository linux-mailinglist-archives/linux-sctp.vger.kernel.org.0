Return-Path: <linux-sctp+bounces-340-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111AA33EBC
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F5E161AC3
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE44420D4F0;
	Thu, 13 Feb 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sa0p22lg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AC227E9A;
	Thu, 13 Feb 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448351; cv=fail; b=tzlMhL6CuNIgzoiys59Z+npfdSpFlWeJT6qF/N4uJxPbvfrqmXT1gX6loVwOpAWxQfPVoWzUZBjzdH36ko0rYVZg2IB3tyLzcuyXIkiLn8FY1JggogPI6ZgjgQ1Q4hE8w0a+Hwe9s0oAkSXIvoqKPQItUWpNneXWFM5+Jq9R9l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448351; c=relaxed/simple;
	bh=GulqG/RPZuOHsvXup2IVgFAm2t8oqDckBEtTS/RDt2w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m22V/pqse5nyRVIUdxe5QR/LLqcqYefFIu3UljhvNeP47sPote4+xL1M0gc2Sc5Gmw4/A56Q3xACHHyWstnD6enouzaq+2ozQQhSPr//LFLKkJAOQ8Fy4+YqXhuhlKlA/5eDwA/G5gn/TWWE/vPS+rE7vNeRnsxdifvIgdwMGSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sa0p22lg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739448349; x=1770984349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GulqG/RPZuOHsvXup2IVgFAm2t8oqDckBEtTS/RDt2w=;
  b=Sa0p22lgrJz7DfVaO2XJnQ7gHCAGKz2mNVvSL88ngBnnzS4tlqk9+4J8
   ErC2OAaoFOdPUOImywqgtAk7UsOWXlPUkKbU4KYe6mtFQOAQFwZAmeCwR
   9wvQm+xYY1hya8iL8V/6jwG8MiOHVgS4XLNttBj0j2vUIyWnxUDx4WWag
   1XXZSos4m6ak1w+/AeOs8gokZEbje0C+afTjXGpO9czHNdS3cuJqi5BvS
   6F8LRXT8i7rVtLVqbmT0FOUyHo4lOSzC6XZIqrN5IcvNOSFBrETW841gM
   T0kealrgjixxRyhi14Osd03yKmdKNaDp9MEUMRFGKCzYCWzEjJKQsu2MF
   g==;
X-CSE-ConnectionGUID: 4Hrd6e/2TwK1W72/GH1DmQ==
X-CSE-MsgGUID: XUkkEWtfToOKLoosngqKPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51576785"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51576785"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:05:48 -0800
X-CSE-ConnectionGUID: jzwasi6zR4mtsNethM/LYA==
X-CSE-MsgGUID: BnBiU3E3T6u4LjDLSZFeIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113621017"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:05:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Feb 2025 04:05:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 04:05:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 04:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlhCX10bPIJMkUdQioMp7W4UYMytvUIzSP8mdKiXejUkoQcSzEaE05p5ybllzjIutFjybrI0ndk/4NoYrqS8eE29V5Gl1fXrMJCBjn+rfFPPEXXvCzhtq0hdzHRlLwk/FeVYYMRqoHpLHA2qeT8PZbLzU13DeKsSDFxBqRLN/jS4NYlOnuXq17/5xGyGKrI7wyHkZKC1su1Aq1gf0bb56ze1ll7iStNQ3tW5prlHuoZn4HmYjacQc4sQI5Fg/IWI2mSPQoGNFY1GTmm39oBF0scfnTYERmppNvVjTqEewwpSrBT2eJ+fgtKJfU2J8GOLNkxZN9A7b5PWviREHuc9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QQIP2n+yV4EZyF91lg9miKE0p8FcCqjJF8HAUC44os=;
 b=SdizDyJdKyf8Y9PtMogVekEY879YqAyzbEFiwoYX4K2D3NRB3GY/61obDa1KFcnm42ynmr2h+zfwGbRKhkks9a4MCYT8oNoznu29FJcmSTX+b73GPd+q07yLQck5F0loVyKIAc5Xt+ozZ6htR42x1zAbINVQMMeVWhc+rxZc2vXA9hZGF0aoCpJZzdqIFaSrRYf9MTj9ubrZDayNP2m581tLynrlm550ay3xEKT4cHjwdgPFjFb83WVIG4zFX8lDmolhEwfjE2n83P20ZR5eyH943S6XqFOWUPsqzJRV8Cp7pbqcd5UsAacqwpfbNzUwr9u9oQYsgnlRFsWEMei+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 12:05:44 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 12:05:44 +0000
Message-ID: <1fea7e51-9972-4c38-92a2-5e1a14ff1653@intel.com>
Date: Thu, 13 Feb 2025 13:05:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sctp: Remove commented out code
To: Thorsten Blum <thorsten.blum@linux.dev>, Jakub Kicinski <kuba@kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
	<lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
 <b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
 <6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
 <2c8985fa-4378-4aa2-a56d-c3ca04e8c74c@intel.com>
 <20250212195747.198419a3@kernel.org>
 <F83DD790-9085-4670-9694-2668DACFB4C1@linux.dev>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <F83DD790-9085-4670-9694-2668DACFB4C1@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::25) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d385b3-b27b-480c-d74d-08dd4c26be96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty94UUlhVzVwRzlRalVYYUQrdFFWYTNvcXNRbWFLVzR6U0g1bTA0dUNnR2gr?=
 =?utf-8?B?NU1kN1hHdE0zTktOYTZ3SjdTTHFFbTV5NDFiZ3E3N0t2ZnAvY00rc0orQ1Ju?=
 =?utf-8?B?Y01BSTh1dmNUUUt2MTRsU0JwWi9QSmk3a1R1b2N5TnFGUkllM2NVN3hpSFBH?=
 =?utf-8?B?ZC9sOGpIbkt6OGFwRW9NL3V3dW96K1gwV2JqZ1RpK1luU1J0K3RFb1JkRllj?=
 =?utf-8?B?YlhJL2N0dC8vaHVTSFJvMjNvTC93Q3JmeUloZEZtK25DdWxqUTZMSkEwaFRU?=
 =?utf-8?B?NUVnem9EQlkyZzZUeENhV3ZPbFVXR1ZjYnVickpuV0F4V01aRzhkdGJuWGFD?=
 =?utf-8?B?ZCtEemVXdlhhQXo2Rk5ubkJTQVRhMDRsWGs4QUg2T0lOV0k2R0ZkZEFaWjVp?=
 =?utf-8?B?TlkzT2kwaFVHNmFIbkpzQ0J2dkt5bVhpRUNvZjF3OExEMmJSdjVyL0FBSllR?=
 =?utf-8?B?ODZQZ1VhaVJxamg5ZXlVVDVYaW5KNXFqUTdWRWpsSG90ZmFtWTVtUWRlQ29R?=
 =?utf-8?B?bU9Bc1RTVlE1Z3Yvc1lVcmx1cEJvOTJUNFZOMnJPcGI0TEx6VnFVSkNwNXF0?=
 =?utf-8?B?ZEU5K3ZMdTZGSWsyRzE4QnlIRXRCVUJnUG1VZysvNUpVanJFb1AxNjVjeVVk?=
 =?utf-8?B?NDFaNUtlRnNmQmp0WUNmMXJtamZoMzB5Y08rWDdhR2NIek0wRmVJaFdjWnhK?=
 =?utf-8?B?MjRNclZHb2ZqWTRwNEVCeFNpUTBQTVhEU0hPc1BmMS9TSjhldVcvS3BBeGFM?=
 =?utf-8?B?L2pXNmNud21UdlZjTTBhcnk0VnE4YytzR3o4Z2xMYksvL2VYNlIyZGtnMk4y?=
 =?utf-8?B?cGZjR0k2WWtjb3Z6MDl4R0xuQW1nd3Jnd0Zxdlp0RTgya2R0TEcyTldKMXpx?=
 =?utf-8?B?VCtWZXZhaXNHOElqWmg2dnJINFRLOU9ET25jNXRTeEdMR0d6clNEUGE1aU44?=
 =?utf-8?B?RUh1Q3ZETGJ1a0NYRWFtR3NHamRDdWlROTZZUEEzKzh4MTBQY2NOVjFSRy9q?=
 =?utf-8?B?WXYyc1NyWHBaUHh4Z0R1bm5xZDZVTmdZT0M0Q21ybXFUN2hOSTIyOE9rMGhX?=
 =?utf-8?B?QmtFVG5IV000TmZmRTFJSmRGN3JqMXA4cStEUUo5TjdPY2VRWVloRml0WHMw?=
 =?utf-8?B?QmN4Yjh2K0puVWowMmMrM010bW5MbmZrSnFVeVptSHFJSGppdnpBWER1aVBF?=
 =?utf-8?B?OXNZamxERW56UEFuTklYZHN3bjZGY1RvRDBQUTN6clZ2bGxxd0pqMUZ5V05M?=
 =?utf-8?B?c3RrcnBxU3QxZ1grVzNpVG1tR1lWRWlHK3g1VkJ4N3FjbGRmNDA1NkY3b0l2?=
 =?utf-8?B?WUpiRm1jUk82ODYxSWxLWHZQaVg1ZUhDRm1yMDZhQ2pwdVI1SDFuUnZpMDJx?=
 =?utf-8?B?VkhxbWhnOUxmVUQvaUVGT0JFVEI3dHhacGczWUk2UFo4MStJdXd5WUNLV3Rq?=
 =?utf-8?B?TjlBRjNzWWVmOHgwdlVpWjJheWJpeXRmRXoxRjR3TGd0ZmN2SDQxeEhPZ1d3?=
 =?utf-8?B?cHNaN1p6ekNqM0hLc1hjUE5JQmpGNjI0QTBLTzNiT2c2OSt6UkRVaW80bjhm?=
 =?utf-8?B?bmx1QkpndFJVV0FXbXpyQUNUd2ovbkU1UjFEc0wzRE9DTmJHUVh1TE0xblQ4?=
 =?utf-8?B?MGdLaktFTHhjQVRBMjBndDRYdWJBVnA5Y2pDV1ozV29iNVdGZUMzUFE2ZEdH?=
 =?utf-8?B?UXlJb0hCNWNCQ2R1NDdPcEVmcmlVNzRBV1dST1BWMWtxOERVY2IwR1hsaXZu?=
 =?utf-8?B?Q3YxMk51VENxZXRaeW5aNjAyNlFUanJROEx0TTdzMG5WYUNNQkxONmdqdi9I?=
 =?utf-8?B?Z0c0RGhuZnpEemZYOUhsU3JpUHVqa09vSWdZemtWcFNLSFZnTzFBSGpYbTV6?=
 =?utf-8?B?anRBaXR5WFVCUUtCdktsY1ArOEJnNkRpOENNSTViOFlES1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9DTG43TElDZVl4UVNDa2p3dGVUb29Ja0N1U0R4R3NPSW9JK3oxSk05eU9V?=
 =?utf-8?B?NjUwNjBGNkhoemZVSmJJREpkSWNBQThqeGYxUUorMkhFY0ZRRHV6M01jMzRp?=
 =?utf-8?B?Wk84TkUrbzVMMkJPbjM2S1VFNFNsWW9hVDRyZjUrYmVWMHpDcCswUjlPRkpI?=
 =?utf-8?B?TXA0UnRJUmFQOGkyT0w4cnllTVVXUjQxbXNOcUx1YnVhTWNCS3FUQzlyWlVO?=
 =?utf-8?B?UUkydEwyYTNaLys5dHNtbEs2WnB2SWxpN1NBNmNCZDVQeUVuN2crN3RuNzNT?=
 =?utf-8?B?N3dGYkQycDEyNmdBbURrSkJ4UU9sYWtTSDlhVXljR21qVGVlVFVoOG42T1hF?=
 =?utf-8?B?bmVGYStpV1NNM2s5SmZSN0ZVS1QxTFc3c3NuNE1kWmcvbHhySEE4dFZlK1A1?=
 =?utf-8?B?WlRMNXdCaTdUK1lDSFlLOVpseXRNMjYxdkV4QVo4dzRJRzB0VTlYMVFFYWZa?=
 =?utf-8?B?b1lKbFJHQjlObXpQQ2NZYStmWTVrSi81T3ZwL0lMTmVlVFFLNkF0RmRYaXl0?=
 =?utf-8?B?NzZYd3FnSUdIVURKTk5iaXlnLzRwMC9DTG55QXhSeXB5ZVkyeEYwY0ltNFdY?=
 =?utf-8?B?WnBFbCt1N3NtckI4NTBaS3E3dEdyelBhVW16T1hjdVdhYlREVWYyLysxSWRG?=
 =?utf-8?B?dzZ5YzBqRW5YSmZWUWdhOW1kYnV5S2ZBZTVDZ0tORmtFNjVrWjArcThTODJ6?=
 =?utf-8?B?SnFnKzhCUExKZTkxWkczZGFCRXUyR0wxZ2xoeFdiNmhRSXpQMVZ5SzAyaGFn?=
 =?utf-8?B?VURXK0JlUHByUFFGMXdDVFByYkZJTCsraEF3TFRmNHdVV1B3Q1ZVeTZkNTRz?=
 =?utf-8?B?dzdJYkI3MDd2bHlLQ1AzRVNpTHBoRExpSHorcHZDdDRBcjVtbHFibzFuckVV?=
 =?utf-8?B?bmhDQlNCSFZaTGRCOTBkdXQ2OC9LTitFYkx3VmFaakEwZEUwM0Q1NzdMaGEz?=
 =?utf-8?B?N05KS3JSZ2QxcE9oVE52ZFNGT2xXcDQ3WHNzb0RkajVFZGRrbk9PWjg4VE1S?=
 =?utf-8?B?elREd3ZzMHlNbXEzYmpJRjBuT2lreGoyaEs0L1RveFlQS3dIUEFoR1ZjUzlE?=
 =?utf-8?B?Vmh6aWxoSUxtSWk5cmd4aGdCNHBZVHdKV2dzczR0UWlHak9jdXZ5LzlZTDRx?=
 =?utf-8?B?VWVVSVkzL3FsWXlQVVNkZ2RnV3pLRkJXV2RURE9BTWl2Vk9JSGkzT2lCem9n?=
 =?utf-8?B?c0NseEJVcGhZR0VpNndrVzBKakVxRjNMd2xpTkdRMWpuQ0s5UlZ6OWkwVnI3?=
 =?utf-8?B?R3U3YXl3SjZ4QjZZNzJUdlFYOXFKRE04MnMvbVZKUkFOS0kwMzJPUU5abi8z?=
 =?utf-8?B?UzRxaVdQNm00cWFzZkxYUXJPekxZVWZGeGREajhYVDRLc0xvL2IraTVCaHoz?=
 =?utf-8?B?aVpKZ2Y5K21hemtnWUkyU0d5a241TDBTOE43MFlLUFMwVmt3aWpWallpSW1l?=
 =?utf-8?B?bkhwRnVlQ0JNZ2t3MEc2RmFDMzd6aWRENFFYRzU2QTNTMkdBWHl0aXd6VGdY?=
 =?utf-8?B?ajZhK1hKU2ptbDVlWFNSUFlhSUNjUEZKemF1QXNmWmcyR084RndYWjJqcDBF?=
 =?utf-8?B?U2I3NzBNdXdJSklMTStyZ1hPazlNVlpGMGlMMitvTW9BUmZxbitobXNLSVZY?=
 =?utf-8?B?amQ1bTlROFA2T0M5Rlg4VFViQnZscmZNNUM2WjgzQVFDNFZvTEhzY0l2czk1?=
 =?utf-8?B?cnBYQnJSVlNBRUlycnFqckNLZ1p3MC93ZW1WZlR0eUczajhheGFya2VBR1ZB?=
 =?utf-8?B?dFBrRXB0NDNza3ZzejFIRHczckhSRXpnci8remhuMXRIcmdFMFEzbm5SNVR6?=
 =?utf-8?B?V0xMQ3ZUL0xHQjRCZWNtaUJ5djJnc1hiTkNEZ1ZscElxenoxQTVBYjVBZDNI?=
 =?utf-8?B?U0FWOVNJWFk4THZoNmEzeFROVXBJdjJXVENpRlZrSXJJcVNwc0xkQk5TaGJk?=
 =?utf-8?B?VzhZY0plVFhlbXVhNVR6dGFiL2svMnVzTUZXUWtwS3BwOTBvRFdGQVhiWXpR?=
 =?utf-8?B?TjhOckZFS0FWdG85dGxBYS9zT3VBVDRBeWgxVXNwU2UyOWZsaUw1RFRIcGt2?=
 =?utf-8?B?RTZYeWJER2IwS1BYM2lrZW1HT2Zyc1FuVThVQi9GYzZ3UGJaellHSFIrQXBP?=
 =?utf-8?B?bmprTDhucFhLQVJUVWNXSW1Ta3lzTkR3NTRJVnhzL1lsSGw4eU9lYk12TXRE?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d385b3-b27b-480c-d74d-08dd4c26be96
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:05:44.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCZm9AOfPdG2Igv9jMRdNuc8MLTYnuolgi5VQ6woCp9aZhiTMUkLaY2CgWkSxpeLfC6SHEZet3DAdTuCmxt7it4bbfw1I3G8jFq+isClVB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com



On 2/13/2025 11:49 AM, Thorsten Blum wrote:
> Hi Jakub,
> 
>> On 13. Feb 2025, at 04:57, Jakub Kicinski wrote:
>> On Tue, 11 Feb 2025 12:33:57 +0100 Mateusz Polchlopek wrote:
>>>>> I don't think we want to remove that piece of code, please refer
>>>>> to the discussion under the link:
>>>>>
>>>>> https://lore.kernel.org/netdev/cover.1681917361.git.lucien.xin@gmail.com/
>>>>
>>>> Hm, the commit message (dbda0fba7a14) says payload was deleted because
>>>> "the member is not even used anywhere," but it was just commented out.
>>>> In the cover letter it then explains that "deleted" actually means
>>>> "commented out."
>>>>
>>>> However, I can't follow the reasoning in the cover letter either:
>>>>
>>>> "Note that instead of completely deleting it, we just leave it as a
>>>> comment in the struct, signalling to the reader that we do expect
>>>> such variable parameters over there, as Marcelo suggested."
>>>>
>>>> Where do I find Marcelo's suggestion and the "variable parameters over
>>>> there?"
>>>>
>>>
>>> That's good question, I can't find the Marcelo suggestion that author
>>> mention. It's hard to find without links to previous series or
>>> discussion :/
>>>
>>> I guess it should be also commented by maintainers, I see that in the
>>> Xin's thread Kuba also commented change with commenting out instead
>>> of removing code. Let's wait
>>
>> In the linked thread the point was to document what struct will be next
>> in memory. Here we'd be leaving an array of u8s which isn't very
>> informative. I see there's precedent in this file, but I vote we just
>> delete the line.
> 
> This patch deletes the line and I'm wondering why the "cr"?
> 
> Were you referring to this patch maybe?
> https://lore.kernel.org/r/20250114215439.916207-3-thorsten.blum@linux.dev/
> 
> Should both payload fields just be deleted since they're not used?
> 
> Thanks,
> Thorsten

Going further I see that in this file there are more fields in
structures that are just commented out, like:

struct sctp_fwdtsn_hdr {
         __be32 new_cum_tsn;
         /* struct sctp_fwdtsn_skip skip[]; */
};

or

struct sctp_sackhdr {
         __be32 cum_tsn_ack;
         __be32 a_rwnd;
         __be16 num_gap_ack_blocks;
         __be16 num_dup_tsns;
         /* union sctp_sack_variable variable[]; */
};

Does it make sense to do the cleanup of the whole header in this
patch ?

Thanks


