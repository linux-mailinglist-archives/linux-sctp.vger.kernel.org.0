Return-Path: <linux-sctp+bounces-1090-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKUZHZs9sWmAswIAu9opvQ
	(envelope-from <linux-sctp+bounces-1090-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 11:02:03 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19577261A4D
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 11:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9FBE30F2E9C
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE273D47B0;
	Wed, 11 Mar 2026 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkT4KE70"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF53C9ECE;
	Wed, 11 Mar 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220953; cv=fail; b=Vb23Y9CJEl1Xcchz3jiPNZT1I3RCPbKAyAl/maSqRUUD6+eIicJcjTNFAJzSRGbdzfNxWoGuShJB/Vl1kefNI5aS4+fHvNO/UMNEMz73GzUsLDVo6ohuiaYBASy8j0AFrwelDxvA45Ws5yp7ebp/HAB7jp/4FKqUIMOBxRqfSuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220953; c=relaxed/simple;
	bh=H6ZMmP62ZGGoBnJAVDBydLgmrjhW3AY3g1J2nIlXoXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzEO9HmWRepfloY6SydhxokTtl47D21MtwccrxIT4120fs9WZfZJJmA70RkLNIw3uqzyLrGVQ2MDfLCKifZ6zP9DQOc440IuN2AuIJM3+7VY85PlG8P83y/e6xqbmc2saKzjty2GGNN0jzEQwqS2w/w2a5yFiAVpg/+2bPh09Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkT4KE70; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220949; x=1804756949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H6ZMmP62ZGGoBnJAVDBydLgmrjhW3AY3g1J2nIlXoXs=;
  b=nkT4KE708Lt9jhVZIXNH/7de9wJOvn8G01I3cKjHhJ0Y1pT4S+GelRgq
   QNsbAAtCUnIDLDrUpJR4R3o42ljxV10JyKQ78yJLEpt/4xBnjh/VxB9xr
   /DOya5Nkz/5nc7LtMVdnU7KVq+3GKjxz6G/vSCVMHgoCFGx+6NRHmJHdk
   WwAwb8JW4lTOQib6PJpUX0XPO7YWzw6fQeNQ66wFcbKILWxRaLIudqoKz
   CTr0PQ0HYmNim/ezcwtp+Hfg5+YaaPqygGcWLUuUFXUukz3oWX3mkSZcf
   y9/0t5Dfg0417QcWmqgIyv4Q3jpRHcGfQZYTsKm6XCjv+zArK5TrxWNbd
   Q==;
X-CSE-ConnectionGUID: 24B8mkjbS0q99hN9LIlffg==
X-CSE-MsgGUID: gswgfcVkRHKBzUCH6Ltojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899123"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96899123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:22:27 -0700
X-CSE-ConnectionGUID: SIJp3t8jTg+0sPOg1FzqMw==
X-CSE-MsgGUID: hJQx9mgjTWuL23NK3z4+SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220353685"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:22:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:22:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:22:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vASBVaMpzIm06ceB/scxlJEznniYt5pxjd6NOKFOD79z9rJB1P1qMHAEJQYOaMeXqv+Pesl30EiR4R4+sJz3qei2yYQqUUxEKxjTzeyFYXVzFgyn6aEnOgb0m3YmaNFoTmA1bQOJZS74q3seYqxW0gtsDtwY8ER66H1i8sdKJZPQg/qYapbqJCJ2oytR63+cjaPeBwy0MTndLiVyBUOFd1TOXWeAkWhQU89e4UNXJEE/YpSwhawQNKUwQHQpfFxutIXjQ4saRV15OIKlQUhlSaKLNdFm/n9TEfDJfOUaoxacc170Il9YkZNdylcxqIn2OJJq3O4//AnTBOMu7c1Uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6ZMmP62ZGGoBnJAVDBydLgmrjhW3AY3g1J2nIlXoXs=;
 b=jZQAJSG0EixaXIJpci1hZobEnzuy2JIXFBwt3fdUd72i6AflLKq+z5pV5LoziZOnZnnV9l6NJwxjwJ46uMlH5gRF5G6O3PEdqKjNceYzlnqjk5Nm01jE+LKYWeMSqNC/DpOlUArEcHUtlfqYwTSwsK4nvVGEtLqnXHB4dwbDFDcPyq/O6s+5yFtop3vsiKlOZjoBkCy6njnuxJZhPSax9lBhvy21KnnWzec2hZm1/JHbwDY1uiCrD+x17jttidfKQdtdRnJxdTNN6ECTtS2a5ps3OlHWyY0IkFsnJzCWvYF9ZG3TgX2H4mgzqC2dpsujmFmb/1h1OXFZdmMLwALrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:22:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:22:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp Hahn <phahn-oss@avm.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cocci@inria.fr"
	<cocci@inria.fr>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: "Hadi Salim, Jamal" <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 28/61] net/sched: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 28/61] net/sched: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKXKbLvNRaSjkqr+6oyWSzc/LWpD88A
Date: Wed, 11 Mar 2026 09:22:21 +0000
Message-ID: <IA3PR11MB8986B4E436132BCDF617CD4AE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-28-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-28-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 1d8c86ee-8235-4df5-c4b4-08de7f4fb316
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: lYTKhjmQY11Of1Xl+ydZd4yONcxgMTy4iHeBLMM9WUap0vDWuq/kRYJXEzMFDSH9UeiigqOQUt3OxTudans7ZFEPJAkiwS2axmcWoW/lnmEsT2o3BlZOfSwdacO/Ye6mH80vOkCcu382RyglV66jBPHKF1IoYS3czvfi/w5YLoTZBRCMgmy+OWPnwBloOfcod+2VpJ7aQnBvbsWFfGm3JOpqDI7K9jt3zDrG3mVJSK8rbbYD1kvJR73A7Brta40GId69c8upkLO8ewfXL0wp8T3wF2l02gMw6+/PRP2bdMQHlYLEBOKSoggABC/lp0075L3q/CiwDjr5p1IFLGURnGqen1/386TDweVGWf+8E1Mz7uYaTKABljfLoo8N4IgBacUCz8gL1pQNPPOzMh4haS47z88W1kuJTlPMJO5MXjtA+pDyaldjMBTZs9TJjaRoQTwbOgEWYPqQ/3PXEyZvuarj6EsNPsGx09VVhX+m4q9uMkNYmrESUMT8OvtFfTR5Ba8JCFgKxqSX/rofQWwKow5HaUToV0jX5x9T9XvJszQ3ruZSXnxqTvGvg45ywMKd59xbm38+/cS2UmBt0Zde/nxiFthY/3iRYhSgEeDde5AqCaGkaD8/i+eN6stimUv3iFAnHfdeGs5EiPkg/QUbR/+PzuMOD2E57q6c14IKEKtyp5JIFjBFCYUPRj/k2OM5pYqUjPt1554DALitLWA4gamM6l/2uJYJn11rqLASADzQB2lS/+RDNe1JYs9ahNo+a8cODNXYwPwvOKPfHgh/TUzTwtD8iYgeA8GTLP+UnCjouub/aOwbo6ZBFR65s9Km
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3krSFVqUkUyRkRDdkZDQlYyZlBJZld1STlDTkNrTm1WODRnNHVJckpSdWpX?=
 =?utf-8?B?VTJpaVRCQzErWW8rMEZwOGtVcmh1NXk0NkdKa1pGMUhjN2JmSktia0x0Yzgw?=
 =?utf-8?B?VU8yMG1sR0Y2VXJNTjBMQjIzVUdxSXBrU2p6QTIvU3pxV3BjK0s0b1Vrako1?=
 =?utf-8?B?K0dFWVJIZTRieVd5UkxRbUZHeXJlcEs2ZVd2VDRmSW0yYXk0SW9sWHFrbzFC?=
 =?utf-8?B?Z2xnM1VUWkwrZFRFNDM5ZnFxS045MmVIS0hGQXBvaVQwa3NmUzJiekZuYldt?=
 =?utf-8?B?dmpEQnh4UllyOUFVVTJBeUFHUzMxRWZMTG0vZ1k3Vng5TUpSbDVvVWNySzVL?=
 =?utf-8?B?cDV3OTlvRlkwVExrbWlpWUpDclkwM25FYVlhQVErcGFnV1FLWEpiM3pWdGpo?=
 =?utf-8?B?bkZYcGkrM1lQVVZmOVJIQ1doVzNwSVdDRlVGSmlrM0loWEZNYlgxSXZxMnJu?=
 =?utf-8?B?eEhjdC8vK0p6dm9OTk5MNHZMYndpdi8xZnFUa3l1RkpEeW15dFNicG1yOWtS?=
 =?utf-8?B?cHlBUkQzQkgxNDVHOTkrMDJlMUNQYm5KMDM1T1F0VE5EbHZDUytaRVZKTms4?=
 =?utf-8?B?b052dFkzTGprTWw0OEUzeFlkUGVjVXhvaEd0OExkZEZFbWJPVnR6c01vb0Jz?=
 =?utf-8?B?ZTlWakwzWTYyVmw0VFUxNUk4cm1NTDBGSnpvWnQ1NEVaeGFoaFlNVlRwWXhz?=
 =?utf-8?B?U0YwdmFUYUgxT2xObkUrbDF4cUdzSW9vdGF1U0FubEUxWldCRm9VM081OUJw?=
 =?utf-8?B?K1JWQjFFSVArVkZNeTlEWHArK1UrdHIxQWJ4VkF3N3MrTkp5NGpubnJIL21n?=
 =?utf-8?B?NVcvdDcvcmhhTTNNcVhjRGxYMXBtZFpEQU1DaDU2VmVXNlkyTGlFUTlWMmd2?=
 =?utf-8?B?RTBST1NQM0ZmalhKV1orNHNqQndlRGJmZ0cwb2VGWE1oTUMrejZBREpDdzR2?=
 =?utf-8?B?OHpZeUtXYS90eFZPdTc0S3RxSnFqRUN3dCtsV2RsbkhRcHBVd3FIODNiQ0Ro?=
 =?utf-8?B?elJLR2U0RmJpV21BKzV2Z2tkeEJOV3NNQ2VYSW9NMExCSE5jSmhQRjlvcHY4?=
 =?utf-8?B?S3liZ1hURjVwNzVzTGlJTUFqNFNRclN5SHQ0SFhHcWN6Tk9nQzZRVlZBZ0dz?=
 =?utf-8?B?eVJVWXBld2FNRGExb2R4N2ROYzRsUGxmbENrSzFxM2VmZVdmUEFEeDcwUWFH?=
 =?utf-8?B?UzlheHhJelliK0RMakhYUjV4cGZxSTZTSlRLU0Z1VWVobnRqT2xWQVJqTHVk?=
 =?utf-8?B?YUtSd0hxL3psTFN3WnBXb1kyVHh0UVFNUS9QRUpLTmh3LzNPNVNKM001UTFJ?=
 =?utf-8?B?WGpveHR6U0dHeXc2SkV3ck9PY01yU1lxNnUyTW1IN0NpMUd3LzdFQ3E1OFFR?=
 =?utf-8?B?YmdUMW9yMTJKVGpNejhlUTZ1cU4xNjdFZ1lpekVqL1lhb3lVR3VxMHNUL2pv?=
 =?utf-8?B?VE5SbG1OWjhPejhOS2ZvajBsT2NGaGxaeVFFelVXWmVWUFN1TUhCWDZ6S1dm?=
 =?utf-8?B?SVlxQmJSOHcwR2FiYVZtMklxMkx5cVVLZjJIOHdrUkdqdHVidHFncGFnRGlh?=
 =?utf-8?B?RjVnZEtmdjBjUUk3dkN6bFJYc3ZFMXpYNTNBVERzaDhvZUJnR1h4V2lGVHZE?=
 =?utf-8?B?M3JPaDl2TVRaSEJ3QWFkRVlMZ1hnVS9vdC93UDZQbmdBQ1AydjFEeU9xaDhE?=
 =?utf-8?B?djd0bnF1S2U1bkRQSE1GdXYvbUlpQmRrNEswUFBRUlpSSmw5WDk3dVpVY01y?=
 =?utf-8?B?M0FYL2hMbzlTL3FwQXpXdnVOeThaVDBSWFhGSTZTS096cXlmYWZjOVlMaGs0?=
 =?utf-8?B?YlFNWWUyYVRLN01jWmp6aGJITHo2QWhqNHRBNjZqVnJ1dzFaNzBpcExTa3FT?=
 =?utf-8?B?TmlXYnJTdjNLRjFXcitZRmdXT1NEVGtwVStMcnZ1MGNQRjFNcG0xMlBjWlJF?=
 =?utf-8?B?dHNOS1gvQWNDZEhvR0x2T1ZFbGRaNlk0M3pwaFhQbldYOWxQc3dkQWFsRG9x?=
 =?utf-8?B?Ukt4RVpueHpwZlJ0RDBKL2JSWkJYUkRDc3lsRkhrOWxyR1VmajlCSXU4K0V0?=
 =?utf-8?B?aS9Ydk1WTHlPMTdLaExaZldzRlFNZWRuR3JxVFRqVEtadmRtTmtqbkxnQjZG?=
 =?utf-8?B?alhjTi8wWWNEVXBQbGVyOC96RFUreHQ5Vm81K3dJNlpLRUYwTXlPaDQ3cS81?=
 =?utf-8?B?OWIvdXZXeGJwL0pDTFY2d0tBSHBUeTNjZVVlTXByWWZuRzU2WkhMMTJUY2xI?=
 =?utf-8?B?b2FKSXUzK2IyVnB5Tk84TXhEMEJBUUp5SUtQdjJXVnNTdDBIbXBEUHEyaXkx?=
 =?utf-8?B?WkdVV2wvaTEvRTM2djdxZTFNYVg3VEsxQitZWEEyOXA1UVBsR2tZczBQK3Rj?=
 =?utf-8?Q?TbjYjr9ffGvAw+9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kq1lx9DENBc8+VcNgYj/D6gMPOX8ZBlVF3Rat7fquqmPSpZyoMd2kGVMm4Uc5rr1vtMPb2Bg+9DbUhZdKAfAq4i4egfAuSr3wHNCt89bfV3Xqt1joyzlmKAkyPPs8x+5KJCrj+s7OCcoUEtW5TV3S/e26LRsX6ZfP7L2GOSXRvcP3UFODJ5O8Iv3wTkU4AqtLYlZb+uc8/QaCxQljRmPjMp/aeIh1puaQWQ5Uhlw4IQWk2zj244pbD3FI4LYp2/WX8DbHJ6VybajGY3K9Ovf/nKxpL8iwrsoXX9H7UkzUohR+4nyYPsxr/3WZ+JKTv3ydW3lrt37+4BgigMCvrTH9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8c86ee-8235-4df5-c4b4-08de7f4fb316
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:22:21.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ARGHiSh1aqJ99bPF9Ir1SfmdEA460X+vovmjgAKmEGwapctThjGdeMWI5LUI/zhc3VzMNi5q26EVkXPnkhnYaIMY0FKQyo1zDrRg1q0n3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 19577261A4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1090-lists,linux-sctp=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_GT_50(0.00)[61];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ5IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYXBwYXJtb3JAbGlzdHMudWJ1bnR1LmNv
bTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGNv
Y2NpQGlucmlhLmZyOyBkbS0NCj4gZGV2ZWxAbGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBnZnMyQGxpc3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1idHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
Ow0KPiBsaW51eC10cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBudGZzM0BsaXN0cy5saW51eC5kZXY7IHNhbWJhLXRlY2huaWNhbEBs
aXN0cy5zYW1iYS5vcmc7IHNjaGVkLQ0KPiBleHRAbGlzdHMubGludXguZGV2OyB0YXJnZXQtZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLQ0KPiBkaXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgdjlmc0BsaXN0cy5saW51eC5kZXY7IFBoaWxpcHAgSGFobg0KPiA8cGhhaG4tb3NzQGF2
bS5kZT4NCj4gQ2M6IEhhZGkgU2FsaW0sIEphbWFsIDxqaHNAbW9qYXRhdHUuY29tPjsgSmlyaSBQ
aXJrbw0KPiA8amlyaUByZXNudWxsaS51cz47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtJbnRlbC13
aXJlZC1sYW5dIFtQQVRDSCAyOC82MV0gbmV0L3NjaGVkOiBQcmVmZXINCj4gSVNfRVJSX09SX05V
TEwgb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9O
VUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4g
DQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IEphbWFsIEhh
ZGkgU2FsaW0gPGpoc0Btb2phdGF0dS5jb20+DQo+IFRvOiBKaXJpIFBpcmtvIDxqaXJpQHJlc251
bGxpLnVzPg0KPiBUbzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+
IFRvOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFRvOiBKYWt1YiBLaWNp
bnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBUbzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQu
Y29tPg0KPiBUbzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBDYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAg
bmV0L3NjaGVkL2Nsc19hcGkuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9j
bHNfYXBpLmMgYi9uZXQvc2NoZWQvY2xzX2FwaS5jIGluZGV4DQo+IDQ4MjljMjc0NDZlMzM2OWFk
MmFlOWIzZmNiMjg1ZWNhNDdkNTk5MzMuLjQyMDgyMjVlN2E0YWNhZjBjMzMxMDk2ZWJmOTQNCj4g
MWY2OGNjMmVkOTkyIDEwMDY0NA0KPiAtLS0gYS9uZXQvc2NoZWQvY2xzX2FwaS5jDQo+ICsrKyBi
L25ldC9zY2hlZC9jbHNfYXBpLmMNCj4gQEAgLTI0NDQsNyArMjQ0NCw3IEBAIHN0YXRpYyBpbnQg
dGNfbmV3X3RmaWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gc3RydWN0IG5sbXNnaGRyICpu
LA0KPiAgCQl0Y2ZfY2hhaW5fdHBfZGVsZXRlX2VtcHR5KGNoYWluLCB0cCwgcnRubF9oZWxkLCBO
VUxMKTsNCj4gIGVycm91dF90cDoNCj4gIAlpZiAoY2hhaW4pIHsNCj4gLQkJaWYgKHRwICYmICFJ
U19FUlIodHApKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKHRwKSkNCj4gIAkJCXRjZl9wcm90
b19wdXQodHAsIHJ0bmxfaGVsZCwgTlVMTCk7DQo+ICAJCWlmICghdHBfY3JlYXRlZCkNCj4gIAkJ
CXRjZl9jaGFpbl9wdXQoY2hhaW4pOw0KPiBAQCAtMjYxMiw3ICsyNjEyLDcgQEAgc3RhdGljIGlu
dCB0Y19kZWxfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiBzdHJ1Y3Qgbmxtc2doZHIg
Km4sDQo+IA0KPiAgZXJyb3V0Og0KPiAgCWlmIChjaGFpbikgew0KPiAtCQlpZiAodHAgJiYgIUlT
X0VSUih0cCkpDQo+ICsJCWlmICghSVNfRVJSX09SX05VTEwodHApKQ0KPiAgCQkJdGNmX3Byb3Rv
X3B1dCh0cCwgcnRubF9oZWxkLCBOVUxMKTsNCj4gIAkJdGNmX2NoYWluX3B1dChjaGFpbik7DQo+
ICAJfQ0KPiBAQCAtMjc0MSw3ICsyNzQxLDcgQEAgc3RhdGljIGludCB0Y19nZXRfdGZpbHRlcihz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiBzdHJ1Y3Qgbmxtc2doZHIgKm4sDQo+ICAJdGZpbHRlcl9w
dXQodHAsIGZoKTsNCj4gIGVycm91dDoNCj4gIAlpZiAoY2hhaW4pIHsNCj4gLQkJaWYgKHRwICYm
ICFJU19FUlIodHApKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKHRwKSkNCj4gIAkJCXRjZl9w
cm90b19wdXQodHAsIHJ0bmxfaGVsZCwgTlVMTCk7DQo+ICAJCXRjZl9jaGFpbl9wdXQoY2hhaW4p
Ow0KPiAgCX0NCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIg
TG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

