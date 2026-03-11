Return-Path: <linux-sctp+bounces-1096-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB3TIgY5sWkLswIAu9opvQ
	(envelope-from <linux-sctp+bounces-1096-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:42:30 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F1260F62
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D4330D7938
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379C3E2763;
	Wed, 11 Mar 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrrTfv0u"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBD3E1236;
	Wed, 11 Mar 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221187; cv=fail; b=ZDpCsjtpK1ojr9l6SVf2sw94QAWM5cAHNz+R3HbMaQcFpX1pMULLjOkxu+nh25bRynCOkMkA59+2ks7ERgN4bnRPG5vKhtv25BdoODhwJIglTawtytSOyBscF5Lk6loMDYSLdrdPwMsxCKZxpbZINui58//VQkciiQGby7kAakI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221187; c=relaxed/simple;
	bh=M1zX9+PPku/ezMDAwbUGLL4E51fSgV56iroRvGjTTG0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbRHfN84BrL4X4hua/Yx6FUmv3wEd11Vv+YAmql4eX9+xX3szURRqtIiz/Nz3/IYgvQbmSoELUloo/kemkTIZPKDZnTFvboAFtf4GrzgjnLDCaaxGi0vMsx3F6JLfGnW08hdkb/86bXpurwP9ZoJ4LhGyyvMWiGK+oMzgwfc1xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrrTfv0u; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221184; x=1804757184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1zX9+PPku/ezMDAwbUGLL4E51fSgV56iroRvGjTTG0=;
  b=PrrTfv0u1b1v9SAmPEqEus1FrNG3HTlcss0LasCYo7JPtGSbZKQxuxhp
   Fp/w0rPI1xc2TOJVJe1NFoby97whUxacv6NvnerXUtn8GaGzqENHxJL9p
   /8AVz+hBaTFIRIXl3If3psWCfGSZn9hFBMwuVJDsbJoPsvCrbHgXxhhrI
   5DQFAm8QJlILiojZwpVNhpxeTRucL0apXfrQXf1Nsr5e5Q4jMGFnrB1PX
   s7TbkvqPSBvv2hh02y8srkioNXl2wfITFOral+/hOHoOi7OTLsmN1pofa
   lETYTRs2017kxMtu1XnRaT7rT1/8X06QPwt8jh1K4Iahv+EusR0l3CC4C
   w==;
X-CSE-ConnectionGUID: g0Sndp2eR0+RsLzRfqsHZw==
X-CSE-MsgGUID: Z/li5jblSHW6s4D1JqFhiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84607300"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="84607300"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:22 -0700
X-CSE-ConnectionGUID: LMXY3nXATmyMWa3R/nchBw==
X-CSE-MsgGUID: ZqQVSMjVSvKtafNEdG+NQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219652696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:26:20 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHcSIfijcpH/6CRWMoLgzcpmerxymuEMU/11u9hBUq2RgCQMKONwbAgtuf0TdXeO63j5A8VJC6nUdOYYCur5CfY5FYoXgbr7ioY00VVV+VB58/wHGUJl3bqccJI4DCEvob5sH6S/Fy0nnIF1YtmGcV0+VKD7oDaxIUwQaEMQH4wJNGRLRFCfV636zxyF2xgp7COoqDZA19iQ2TZBkxmWvjfPYM1xuo41el2q9p6RMtkvzUYzsfu00hMxgCPcwmTveaou4d7Qr/Y2dqMmeoNA+XTaJJD7tMJwvDYg4tIWmHnWMLhLTNBNmR8ikJa8V3ZhUmsq0ckFPMpOZX9RO5b04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1zX9+PPku/ezMDAwbUGLL4E51fSgV56iroRvGjTTG0=;
 b=fh9Osd/t6LBSLRVXWch8QVmPLCtnKal2mEVH6UDjD2cX4NQlByAFShJXQxewu5aMe35/KS4KDzu211/10FanESnm2hIp87g1Hq7+qhPEG1q2VlydaVQUPm2WgH6I89aZz6BMAg4N6j15BBsnKXDa+FRkfyRjsEvB+s1w/6Y5MwXQEAmx+1DjPja6bR6taNNdghLIKjqfSJnrnIXplza9ssBNfxvdv+SRWyRF2rIzVoSyPxrvtnOoJqmg8r9O1D3KmAuta3L0tUuglPVZww+IYMTdvPjWg8LlIDJrf3wxRQcbGOTLfBAP9G7o7/5a984Z1a1XF9IfSnxKE6TisQsp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:26:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:26:17 +0000
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
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>
Subject: RE: [Intel-wired-lan] [PATCH 50/61] iommu: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 50/61] iommu: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKKsLw8ffVSJ0afYyGoGNmoEbWpEOYQ
Date: Wed, 11 Mar 2026 09:26:17 +0000
Message-ID: <IA3PR11MB898657C50235115E4008890FE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 96cac31b-82e0-4d79-7e67-08de7f503fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: L7AbhlILyxI6R8isGXcs2nyf2NNr0nZWS5k6L2IPzei04OuUfC1rIwLyClFyZ5je9ovWr/B1dafcS/kw7EJGerupbSOfwkAgOlGEpAwElfESJ/7GopwVGvFcM+uyrVGr8X4e62KV1J8AxGQqeRIfts3e51/x+lgsXn71Vs1qi+JL64U3u39q2K8GxJjJo0c7fkXQtNWIokNjRzXju6WLbhWVeKBrHbc8Honxw7SmCB0Bsj7ub9bACNgcuNtLXqQdMtKtzinrs348pVo/DKURLNMhZ/6zJSajZ6frL29TDE0k9BJd4y0kVRawVUEglESCQzbF9gFlZQhHmsJtLQcYLoF0YroTs7br5hAxzlK6Y86xNF+zZU2Z+YzNnzmnNt7cEyempZ7l/ucsfDbei1UxvzVICOE9MPYzamJXDR1lQRI8ScrSGrHeN9GUsdQvSVzFWGLMPMfAUYsmkJE9X5SDvC5p9+mJGDlrlaXtFNx1Y9sHSFdheSExL2PrnFgZ8BPkkF0NjEq1788KeQQifnN5WsCYRhSKLLdquuRAWg8zOHCuRjzrN8E7kRrPcnH9uOBkIj1G7cgJRsE4gjmo5hlMfjAUmcfKL/55e9kqsLLdQmYzUlm5KqsI25hYnls1PIttxskmnImEAy3x4OBQJHXFaSbgz/w2Nv6+5DNji7RlZY1ZXPBdfmkJua64pNZ0O8NEKZFY5vn7rJOXWEcTtWe0N3xSHV98d2yqC+uGv/HCkYZIJoJgDsvaqEgWpxkbClxSf0MTGF/Ns2XNYb1m8iu2CMxUIYRVgz8mBRjPM1q30T8QkhQGtw5toaNHkrdf3bHo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXFvK05adWp3aElIbVZCeElSdmVDdWY3cy9uQ2UwWVNzL0luQ2h2clVReEJi?=
 =?utf-8?B?UFp6UU81bXpsYmxnMEE2c3MzT3BVaTRIOXVIb0dsamVBcUY5cFdnVHFyYWFZ?=
 =?utf-8?B?MFZiUDFNUVdFSFJ5YU1HZVZtL1dOcWNyYkV5VGNnT08rSzZRUWxHcUVSbEZm?=
 =?utf-8?B?Q3ZGelRHZ0ZuZ05vT2JuVWtabXA1VEp0NVFqT1JIc1RCQXF3bVVwa3ZkdmdL?=
 =?utf-8?B?UGpjb3NOWmViOWY5a3lrNDdZZlhaaU81VzZBT0dYWHJBcVZGYlQ4dEZzR3ZU?=
 =?utf-8?B?NkF1ellaVkdLNWhUUTh1VSsvdG9xZjFxRnhyY0l5WEhUdTlnaXJ1TldKNE9o?=
 =?utf-8?B?TFR6OE5YZFJsekhQQ21PNDBMcVFaSmdLUFFsNVZkMlBVNDVyUldCSGYwY3ZG?=
 =?utf-8?B?ZGVicnM3WStiazBUTHozdjV0em4ycHhDbG12ZmdpbGZvaE5sSTE1MXIvSGR3?=
 =?utf-8?B?djZwZzFJWm4rNmlmMjh3YkJGVURGclpXZVgyMzFtalYyOXA2Y0w1TnRIc2ZZ?=
 =?utf-8?B?QzhXVVFKS3NQT1VpREFoVjdyNTdmTTFWZDVFMTNueGI3dE43a3ZMU1ZJb290?=
 =?utf-8?B?WkxkQVBVSnJKajd2MDN3MytyUlBiN3FKWlZJZERxaUVTeXhZSExzL3dpZEZx?=
 =?utf-8?B?aEhkekFPMjkzcWlQNmNBWVBHM08xRVpRRWROU1ExV1NrN0FaSWtVOUk2Kzht?=
 =?utf-8?B?bld1OXlOTC9JOFZwMXZrSHNsOFVUVFNnUG5DMnR2TGgrT0xSdGY2d2FzOXJt?=
 =?utf-8?B?OVBoU2lMQzVONmF6WXhUVmpHNXhvL3dITXRiamJLQ0FEcGdBRlVISmNkR0lr?=
 =?utf-8?B?VGwxWWZOOFBHWHQ0MmF5eE1jQStpbmNPclZyaXJJbU5meWFNQjh1WnZoa2w0?=
 =?utf-8?B?cnUzalUxS1l4RXpMcEdEUjlUY3lzSGlYVmNWZTNkeDZxRTdsZGxxeEk0LzEw?=
 =?utf-8?B?K0l3VkZmVGFGclJWeFNZb21SU1R5RmU0V1FwcXVUR2p6bE1vNlZSWTYvdHBx?=
 =?utf-8?B?MXc0SXFQU2hHeWlEdmlZS24wRlhjNTR3eXlxK3BxUEJObGJ2WG5BdWovNUZS?=
 =?utf-8?B?Mk5ic1Rxa0F3bnVORk9EbWRtczFYUmdIWTM1TlJCWEJMRVRXUDdmQ3ZFUG1p?=
 =?utf-8?B?cFVXeTJCd29tRjhnRGNLWDNybTZTdlgzQnpSd3NwTDZRcFE1Q285dHg3K3dl?=
 =?utf-8?B?SEJoK3YvNC9YUmx0NVFBcTJQVlNxWC9ldUlQRzUvUExLVFQ5OTU1d3I1eG5x?=
 =?utf-8?B?THpRVmF2ZW5ScVJnaGZiWithVVI4ejViTVcvT2NlTXRnK3V1OXloR0JOV1JL?=
 =?utf-8?B?UDZ1VlhHV04zVUpKQW5NQWJOUVFkZzRtRmlydU1RdnJudUYwQnRKVXhXYVlM?=
 =?utf-8?B?dkpJcjZUMm5XaEVrMW5sNVoxZTVJb0RJRnY3cUN4bThMTG9KdDE5S2hRWUhH?=
 =?utf-8?B?Nm1samhiL2RvV3VrVE5mU3lGZUV4M0pRVWJyS1g1Rk5JVkd2OWJyVkRwai81?=
 =?utf-8?B?VXdQL2FWTm1RUENUcXd6czhobFdqWG9SZUhkV3N4RXExZ2xiblIwdzdXU3JV?=
 =?utf-8?B?TDF2bmxQKzZ1dlZhQTlBMjk1RjgyWXlyd0RHNjFMd3lac2VPUkl6bWlIQ3VH?=
 =?utf-8?B?OE1OaUl5K1RiazF0ZGhBd0RmTTFtdkNMdDR6dHI0eFU0cG9DV2RXVGUyMHlY?=
 =?utf-8?B?dFlyWmpCSnpzWi9hMWlyYUxwb3F1QjhzYU9tMEhZVjltTGxzMzJ6Y1MzRElh?=
 =?utf-8?B?QzB0U1lJaVI5ekM1NUtsTVYxMWJkN0JkdkpvUzRmdHVUQ0wvRHJrZ09jY0xV?=
 =?utf-8?B?NlhtNFdjeUhVTWdCTFBqbndVWWRqdUpTanlCZjRILy95b05DS2VlRHArcU1K?=
 =?utf-8?B?aXV0Q2VldDFmS20yTnVyZFdoQVpSQlFKV3M1am9HcHNhTkRKeC9XR3BiZEhn?=
 =?utf-8?B?Tk9BVW5UY1pUUFBJNHhLMm5UUC9FR3REMmI1eTZrQno1NEFIcW9lSnBrTFl3?=
 =?utf-8?B?eFcvN1dHbVVWNEUvWlkvWldkdkZ0QU5KTFB4ZVNUN25MWm84N3lPZUV2cU1s?=
 =?utf-8?B?T0Q4SmNPL3Bna1EwTlh6VnJXdzRibGFBRjJyeVFJYXdFck0yQmFzU0xDbnVq?=
 =?utf-8?B?Wk5md3JQUng4VURmQ3NNdmlrNlZKM2d2MFMzcTY5RVNEdzI1VGdIY2R6RS93?=
 =?utf-8?B?QzVYQTY0dVNhRTF0WVM3M1p0U09YM2VEL1dBK3JtYjBrRGQ5Nzk2RzFuQ3Ra?=
 =?utf-8?B?RWNPL3pFOGpKa1hISGJ3QU5UOXkzK1NtOFVZbGt5T1ZQaWRrNCtLUjlWdE1x?=
 =?utf-8?B?UEpCbmZVOUpLZFVTRzZ0cjlkWlBlZmVPRDdQNnRQdjJaOXpuczlsUklmbHhP?=
 =?utf-8?Q?8Tc2j9aiEyVh+eMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ij9suR4+gfmfb75J72t3lGk74ceQ1dJA8Vk3YjNrzse2pltTXluRMto0A6PWt4MZCYpbGych7s9ipx4+D56FRlB0vIFbWQ9Ahqe5rQcmEi+hykaQd0SP6ZyeixwJ0B4kTGFqz+CQIMbIjWAURGPGeLqo6NSAO4nfWrghPgt32SHnGt/Pys8KCPXtUobyk26FzdDNfIp0fO0Co2lFE0Ptu7x90qqtcAV+LgseI9xwKfUhYgUbgyRVMX2xxQ8ncRk3QjFjQ1cSGDOyW4N+AQLyvybZN84FEG21l3UPxubJVvVn+4fMw3QB4h3zo/AURY1iqcrpPzZcNDGlu04uUt/DCA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cac31b-82e0-4d79-7e67-08de7f503fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:26:17.9098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKRoUTqSMgB7X+QiLzdNcDatHXI4GweH+7eYdOWlw+0DQhKehh0ceQgtCK4BL/RkhQUR0hD9OmNngsUP77xKwyRvxiR3TL2zy2CeBb7eKNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F33F1260F62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1096-lists,linux-sctp=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_GT_50(0.00)[57];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
bS5kZT4NCj4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPjsgV2lsbCBEZWFjb24g
PHdpbGxAa2VybmVsLm9yZz47DQo+IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCA1MC82MV0gaW9tbXU6IFByZWZl
ciBJU19FUlJfT1JfTlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIg
dXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBO
VUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+
IA0KPiBUbzogSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+IFRvOiBXaWxsIERlYWNv
biA8d2lsbEBrZXJuZWwub3JnPg0KPiBUbzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4NCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bh
dm0uZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9vbWFwLWlvbW11LmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvb21hcC1p
b21tdS5jDQo+IGluZGV4DQo+IDgyMzFkN2Q2YmI2YTkyMDIwMjU2NDM2MzlhNmIyOGU2ZmFhODQ2
NTkuLjUwMGE0MmI1N2E5OTc2OTZmZjM3Yzc2ZjAyOGENCj4gNzE3YWI3MWQwMWY5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lvbW11L29tYXAtaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11
L29tYXAtaW9tbXUuYw0KPiBAQCAtODgxLDcgKzg4MSw3IEBAIHN0YXRpYyBpbnQgb21hcF9pb21t
dV9hdHRhY2goc3RydWN0IG9tYXBfaW9tbXUNCj4gKm9iaiwgdTMyICppb3BnZCkNCj4gICAqKi8N
Cj4gIHN0YXRpYyB2b2lkIG9tYXBfaW9tbXVfZGV0YWNoKHN0cnVjdCBvbWFwX2lvbW11ICpvYmop
ICB7DQo+IC0JaWYgKCFvYmogfHwgSVNfRVJSKG9iaikpDQo+ICsJaWYgKElTX0VSUl9PUl9OVUxM
KG9iaikpDQo+ICAJCXJldHVybjsNCj4gDQo+ICAJc3Bpbl9sb2NrKCZvYmotPmlvbW11X2xvY2sp
Ow0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92
IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

