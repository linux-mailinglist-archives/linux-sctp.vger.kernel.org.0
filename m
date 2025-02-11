Return-Path: <linux-sctp+bounces-332-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8EA3091A
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Feb 2025 11:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823F2161CD0
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Feb 2025 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC51EF09A;
	Tue, 11 Feb 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqz5T3qj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB61C3308;
	Tue, 11 Feb 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271028; cv=fail; b=GiEPT0A5npbz8iwV/B/TgNwlPLw1uyVKZW9YHzvvk0mCIGE8vdbi1VYhcZRrLzM6NwGfcEzK0t2VDSf7qYnRfIddkeDC5puu+h3kA9CJaTzyJKxmWzZmRN0iWrzbYXIuyCoeXT/V7+kKEZVWLEHguPdP46NuCx16h4Y9PqROeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271028; c=relaxed/simple;
	bh=qzKdGh4YwczBMh2k+jChIGbSUQXxC1wQxZq4sXidptM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMI6tBBrJElb9mcaNwdIhpHExBv5BkJ6LoRjvhCev0OZJwtBqSKRdEIf7bpdDKISuAuhznGrfjYh4sLlwUmAucunQC3sm8bJOfbqGQsMcVOHmFgRKmDgg19Vnktaba2KiTnJ4Wd7K7f8IRjCXteZ8BYkB0uU/BJhO/20Qts2pio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqz5T3qj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739271026; x=1770807026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qzKdGh4YwczBMh2k+jChIGbSUQXxC1wQxZq4sXidptM=;
  b=bqz5T3qjKCFD9LqKQWrtNZEZd4BW9lVj41gH6QaUiP9IeKA61gBFki8y
   ZyFoth1n+WtMd28SLo14oJfPSAMa7tz5FYCfTjRXYKePPRzpOqmNgXzzy
   bdLuQKCWP7ZN9sVL0jh6szAQ+zpILsvEovy7Qe5UMLLarenLltzbtnSJ5
   YeAYtP2UehI1xsefmESwe4eLUnBR5/EfRZmK0XIl9VjqPtR2gsCDmWaSt
   shOEpZH8iVH5qvNsHQ0p9QQEPL4hzLAbBKG2SRYa/n1MdMNEQh6uFIk31
   H1Be39O5WM/mZdEGS52X3w1WuCvjytcx+vbaYRJR5U1Cq+w4J/8pH4TDV
   g==;
X-CSE-ConnectionGUID: pMje2AeyS+K5jezrFqhm+Q==
X-CSE-MsgGUID: 14b7aL9MRwSmKBpt6RX7GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39578339"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39578339"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:50:26 -0800
X-CSE-ConnectionGUID: v72OwQZGTFShwUk7PyEujQ==
X-CSE-MsgGUID: tOlwQVYURgmq+AhVdY8R6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135724391"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 02:50:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 02:50:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 02:50:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 02:50:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJVmIgEb0A1j1b4apHapCOMR5+BX5UWbt091oRzNDXZy3xKQwGH0XCayCvrnOesCTcGSk1URFjjV6lF47qCKPc81Mnn7hUzYd//OWqSJ++Z2PdG9bdDCf5RyIf4MRAL4KfDKM7eDOA2/go8p1W621plQnt7ba1DyUT9uj3Zj8Wl7PXpI7yrSB2yJPwPHiKP605kLhzkVFtDNJSdinFVqYvkqjbaadAa3PXPKd+QfTROitbLnd9+Zatn83QsPIDXowR6E1XDpkL75HcIZGuS8lYkDaX4cETH6aGR8EIwljSgvensmdo4lpNxEJA4tKl3r+PKnYzLZzk/3Rn35scrOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPNNrVy1JpHlFvHJ8FTLdnpsB2B++ht1Y4guAY1Za0s=;
 b=BrfifGPQPsB5g73JMbeWchFiux87hffaPMczb8unkE0oD8wHQQ6nvlWQFdwIqVHflcN8JdqEdyw3Twx3QavAKvgB7KrJCp1Htwl2nEndvEIWC1nxMy+XOs67B28GoVxx+3QnbVr6Dta8Iugfge+LpzB9VG49LIRc06iPEwhVP8FBdI+lKiiMyEo6+5POkBR/J9bVerZGTeGZcQi+80E5Zh4eFlUFRsVt+YnZXOrQHr2fbPDIuPPpTQRdFOJB9SfjCEbVZlwLJwvyyoQCIl7P7Tc3ToMYCmg0AN2R86hD0+d7/iqBFtPwfIehu6ytd5uCxPTfttPRL476urxu0ROwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:49:53 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 10:49:52 +0000
Message-ID: <b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
Date: Tue, 11 Feb 2025 11:49:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sctp: Remove commented out code
To: Thorsten Blum <thorsten.blum@linux.dev>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250211102057.587182-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3aacc3-96cb-4ff5-81ed-08dd4a89d085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE9ua3dId21iQ1lMNWh6Z2NiaTloc2F4aHphVjdwVnNkb3JjSVBzZDQyMjdt?=
 =?utf-8?B?czcrNmYvRkpNRURrTHRka2I1dWdqbGE4SGJjNDJ4VGRzTWtQdEsyZ2p0d21t?=
 =?utf-8?B?YUFjK2JWdm9JTUtFb2ZLVURwK2k3WloyS3dtUFI1SlMySGpvVW9iSHM5NWVJ?=
 =?utf-8?B?aDM4V0hvcWFjRWFaQVlFZjNyOGwrNHhWajQxSGZOejZlR1Rwa0h2cGltUWwz?=
 =?utf-8?B?TEoybjBDUXFrYlB4a3ZRZzZQRWlWczM1QTh6WXFnQWw2OE5uUTFYSmowWWNV?=
 =?utf-8?B?MXAvVDJnQm9PT1N1dW5HdUZYZEh5OU9ybGpKUzBSOTJHd2plL05NWGx2b05Q?=
 =?utf-8?B?cGF4Rm1HeDI3YmpoWmZBc1E1LzZvL3pBVWNOQkRoTHp1WUNuRmJUam9uTGZY?=
 =?utf-8?B?UldlRzlPVjNpSUhjTEhCaHUwdmdHVURKTDhUZkorcnZhMllCQzVjWlZPOEpZ?=
 =?utf-8?B?VldRaVFzSFF5K0RWZEVOWUxSaU5vdllmMjAvZ29GUDNjME93Zkc1VmVRd3BX?=
 =?utf-8?B?Wk40aVpJUnlra3dqMnFSMDhpQWZyWkY3YVc4Z3FuYlNKSnZjc3FGMTdObmRw?=
 =?utf-8?B?cVJxd0pSQjZsb2ZLKzFMVTJUcm1HaHl3R2lhcmVEWnJyWVdWVVBhNHMzYzBs?=
 =?utf-8?B?RGZtTndlWVdaNi9lWStVbWZPcU1EU2k5Zkh3YmY2UkszRndEbSs0Y0pYUTRq?=
 =?utf-8?B?dDFOakZoL3pyZXlyKzJlVytPWU5xTjBZTlAzWEg0VDNZYmg4Q0piVE5FQVk5?=
 =?utf-8?B?L2FRNzMvek1aVW1ZbXpYRi9tcE1ReEVNVFB4NVk2bFJPcHlqeGs3RWZJWlNw?=
 =?utf-8?B?ZFRBZEUwZHl0T3lNZGZrRWVRMjVURFZEVVdBamkrM2tpOGM1LzVBeEozYVNz?=
 =?utf-8?B?Q3QwZER2S0dYaDB1SEpYcGZhMnRGeml1aWQ1MTZpd2NhSU1HcUFBRThTdThX?=
 =?utf-8?B?WmdIbDNGdFZ4T05vdXd0blh5djNxbjBBVWJqMTN4QkRXRXdWVGhFWjJxMFlL?=
 =?utf-8?B?UUozWU9zZWlQRUtobTB4S0dMQmVJdndIQXJ1Z2VQQ0FXTmlLL3d2VXoyQzdk?=
 =?utf-8?B?WjJwa0kvcmJEWlg4LzRpL3pOVlAvR2o2WVNtM2hCL3dJb2lNeVlEM2ZvcUZh?=
 =?utf-8?B?V2Vybmhyb3pFTFd0WXZzaGRxdHRQdlVJSldNMFlJN0Q2cHVyaUNrSnNJeU9S?=
 =?utf-8?B?bzNYVWxuWFZiYlN3SDFvbmN4NVJhSUpwTGZGbmg0TzlIM2RJYjhVK2doa0Vx?=
 =?utf-8?B?NDEyT1Z0SjBaTDJxeUxuUy9wZEFBdzFXSTJPV0REVUNjWjBXV0RCMERqS2Zs?=
 =?utf-8?B?MTdYN0tXaTFNL0tUL1lWT1AwVnkrcUMvQ21oS3FSYzQ0UVdqeGVvT1hqTURn?=
 =?utf-8?B?di9yQ0Q2V2ZMcXE5cjRnTGFXNVZORGNVYnRIaHh6aHlrOWZPQXg5RXRibWti?=
 =?utf-8?B?ay9iVXVWNE9xRnNaUDZzWXAvOFVaUlg3RjJkUnBIQ01nVE9ucEpiYm9Md29m?=
 =?utf-8?B?NG11NmMza3RGVEFXSVh4RGZna0ZpcTFkUjdmQlBHUnpRMzdIbVJJSTFOM2tW?=
 =?utf-8?B?b0Vuc2ZOaWZBeE5jSkF5cVJ0L0ltV1Z1Y0lnQ1gvVjdpa3BqbDhpbm5JSU1x?=
 =?utf-8?B?L2VJRGZDR0FGV3YwUC9vTUFPNFBBVnphL0hRdTZKeksvRHVkeWFWbHBlU1Yr?=
 =?utf-8?B?K0Q2eHBxUW5CUDMrdTNwSUpqcTFPa0FGdzJ4Y0ZhQ0RyT1NCOGxjby93Z254?=
 =?utf-8?B?cjJxS0tXcFQ4eURUN2NyZGE2OU5ha3N5SzFCVDdKQnQ4YXZBbHI1WHlrR3Jk?=
 =?utf-8?B?RjAzZm9ac1l3emNDQXNWWHlKWmpaY0I2em5SNlRiVWxiYlQzVW5VZUVHSlh5?=
 =?utf-8?Q?l0xZoiZEki4Dl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZQbkVxdkVjanZXS1Y4dFB3NTJpWVh0RlVNVXk1T0xCR08yNXNQaXhmUjdF?=
 =?utf-8?B?MEYwWmJja0VVdkFDaVdMRmx0amYyRExQdk5BOC9QSm51cXNzeHhCcWdnRG5T?=
 =?utf-8?B?UGI0eGNNSUdHcTYwMURnMCtQSk84UWsxU3ZKdFIwYjFyVzJDRno0clpWMzgw?=
 =?utf-8?B?bEtvblpHdW9oM3JrOHdjWGVQUG9ZMDI5WWpnNGljNlNPa3RBeGtRdjdDb3BD?=
 =?utf-8?B?dXlFdFQ5ak5KK05relVyYmR1WjJVU1F1ZnZxVjdPUTIxV0ZncXBWbDBUSVRT?=
 =?utf-8?B?eDliRzUyWUhQa1cvLzRTQXhtVW11bFNpQkYxb09INlRlODJ4TUhzajNaZFA3?=
 =?utf-8?B?enRuMnlKWGxnUmx2U1hnT000RDZ2TVd5VEJjcjY1NmMrblV2UEtvdjdqQU9k?=
 =?utf-8?B?S3BXclZGWEpXLzkrSHlTU3l4WUpWb0NselpnZC93Z21FRk16MU51OXU1eGZ5?=
 =?utf-8?B?N2dLN2MwYldrdVpFaGNkVWRPZGUwVWhnZWN3Y1Rub1ZLejhCSWJlMkZFQUlw?=
 =?utf-8?B?Y3dFVkNZSkR4THhob0toSVpqYzA5d1JxM3ZUK3dSMzliNkN0WXhWYlRXUlNH?=
 =?utf-8?B?QzN3TWw2OHRPcTloV0VUd0VxZXNSQzFaeU9LOEFWZDJUZjN4NWhjUGtjV1pE?=
 =?utf-8?B?RzNDRWxHaVNJa2RmUmtjQU5VSUY5K01IMElTSXhCUWp1K2hkcllDSHErd3Fu?=
 =?utf-8?B?SUsvZlhDbjRsVDc2RUM5WlUwdmEzUWJ3SDZwNkMxTGhCcHlWd0NTTjhXVjRn?=
 =?utf-8?B?OWZsRThUVlpkUmJZUEpuOHRqcmtZS0Z4UlpDalc0dWxmZ09tRGZwcEE3bjh3?=
 =?utf-8?B?M2xXUGxzeWNvd01GSXlIM3QrMVZYL0N0blVObS80WktidVN3SGxFNm1vdmxT?=
 =?utf-8?B?NFY3dlRoMVdndkxwMUVZS0Z2eTQvK0EzUmlUR0NQNDFGWk9TMVpVbjlZTHBv?=
 =?utf-8?B?clQ0eDBUWFpiZUVQVU9ZdUpqVWxSWklvUFg1dFdMYmJwc1VrMEFvb3lPcXNq?=
 =?utf-8?B?K3loOXFWemNjbGpPeDdMS05ocllEcU1QNjFrM0czb2dkYVluMUQ1THg2MnU1?=
 =?utf-8?B?MHZwTWlJN09KaDhWRHVQa0M4N2UweFVCNlpPWVcvcnFud2tMYitxdG11ZlF3?=
 =?utf-8?B?WlpQSXErUzNZK05BUlFPbUFkQVlaREtYc3UxYXVqUGtKcEJVMEQ0eFdHc0lZ?=
 =?utf-8?B?cWRMczRueFliU3cxb3ZHdjNNS2QvSEd2TEUxQ1BEdkc4ZCtvKzVFRkt1UmlU?=
 =?utf-8?B?NmxoUi9QdEpJTFBGdUlaZlZUdkpUc0JKcmduNGRId1VGcXBMU05kZmlxSlVN?=
 =?utf-8?B?Qm5YRTd2R0dnM2NWVzF3TXh1RnRKUXVtQytsT1NCV1FZSFpXODRYbnI1bmgy?=
 =?utf-8?B?MWNUSjNHTS9PN2pFTWVqOVFCdU5wQ1FocEUvNmdUN0x4K2lTY0VlT0ZGLzZs?=
 =?utf-8?B?Z1VMeUV4RFFpQ2hnckRHMmYzNE1KQ0lSS3NqUGloQ25iZHUrK1dxWlZpempp?=
 =?utf-8?B?Y3JnT3JPZ21Na1dNRFpVYno0Ny8wZWo3eVBvMGhMeEMvaTZBQWhyTzFMNFhq?=
 =?utf-8?B?eUtQamdaWGs3bEIxVjYrcXhzKzBJMjZvdkFSZEtzL3RSb2lXZ0VMckpESW9Y?=
 =?utf-8?B?dkgwWFlTYzd0UWZhVEZITE8rbzA4Q3dMREFCZWk0eFRSY2tZcUhiay9aOU5o?=
 =?utf-8?B?MVV1STFUWGY5Z21aQy9uaytmTjY4TzBCMUZBWVkyR1JBbUE4ZEc4dlp3Y05G?=
 =?utf-8?B?WEkwL0xuOXQzRERvSFF4ZzFTa0QvOGNQcGlBR2d1cWVnYVhFcHpCVVduUDdS?=
 =?utf-8?B?RFNNUlVKVWxpU3B6YWNxOEZqNloxRTllbDQwQmNPNzZqTEd6RjdaL3h5UTAz?=
 =?utf-8?B?ZlpMekUyQTB2cFN3bFpqTW9vd3Nrdm1uTHBoRmc3dnM5OEJNK05scTVZbWVU?=
 =?utf-8?B?aGVaMllpR3QzZ2t1UnlqMk1LZllLOGd6VWxHSlhHSU0vR2lpS3FWcjFKNE9Q?=
 =?utf-8?B?TzUyS2owMFlVN1g3M2YxVTRBRGJsbjRwTU5vbU1lSENudnBhMUF3cEpJZGlw?=
 =?utf-8?B?OCtlK244dHNVU25oa1R2T0dmODlYalZKLzEzWUZPbWI5NzFGaVNlV0tQdklF?=
 =?utf-8?B?dGZpY253ZGhDem42M2svNDZpL1dvVThqdnpqN0hlVGwrUit0SEZLRTlCNXR3?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3aacc3-96cb-4ff5-81ed-08dd4a89d085
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:49:52.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k67zHzvIl0cr3QRGtXwZF8oDWE9Xv/MmRSGoq7i5uHHYTsmMV6FN/D3qQ0fxYYY8FEwXD2fIYNjH9M4l0ipezukhMnSHrsMsCbdO7pJHt7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com



On 2/11/2025 11:20 AM, Thorsten Blum wrote:
> Remove commented out code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   include/linux/sctp.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/sctp.h b/include/linux/sctp.h
> index 836a7e200f39..812011d8b67e 100644
> --- a/include/linux/sctp.h
> +++ b/include/linux/sctp.h
> @@ -222,7 +222,6 @@ struct sctp_datahdr {
>   	__be16 stream;
>   	__be16 ssn;
>   	__u32 ppid;
> -	/* __u8  payload[]; */
>   };
>   
>   struct sctp_data_chunk {

Hi Thorsten

I don't think we want to remove that piece of code, please refer
to the discussion under the link:

https://lore.kernel.org/netdev/cover.1681917361.git.lucien.xin@gmail.com/

Thanks

