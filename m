Return-Path: <linux-sctp+bounces-1083-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFfROrAnsWkBrgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1083-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:28:32 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8525F470
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92A3C307A9EA
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C423B47E2;
	Wed, 11 Mar 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqfgfEUm"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FA30C35F;
	Wed, 11 Mar 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217176; cv=fail; b=T9WkMSW71T7J+V/RKLcCjb8SfD0YVZizd0tY0XyseD39yM5gsmWPqyzRxSv7XbWoZuiNWbDAmCLDjc+95ORb2fIez8t42yCCx25P556TDCB8JRmmB2BrR9XjrA9xm+RmcTNfEPE8hQYjEzY/7FNpD3g+b79EKd3u3Ro8AWRSq3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217176; c=relaxed/simple;
	bh=/ef+jK0YkTsaCNho9PZIEWOi4UpNIRGBY/ukEGrwSAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bj2Tc5XqTQrLpjvydwQr8dO3Y7xHlf/IR5nqhPIp4fkuvj5kbUeI4jKOpwnre6yazzQs1/M1fwJF+3yVx/ddkrD8y78gJzh2/85SmDoZYIfJDI0OpfBUpTkeBuwHKt4H4loOTFax+um/jo5umDpyK8DN2AG4RgCFcUSKG7l1/B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqfgfEUm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773217175; x=1804753175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ef+jK0YkTsaCNho9PZIEWOi4UpNIRGBY/ukEGrwSAI=;
  b=SqfgfEUmXMwoyLjBHFI8Bap0RxSF9UH83cvxFN91bLplSDWbvnHth8Mc
   vp7yRecHsf1Vb3hMqrpISysQ5G7PhEVn4CoomESodoQRBQ+XSg5zcOjW+
   XkYDXcSIG6Hn4MMxKtG96T2Q3eorOpFw78MD8U3kPLI2btVvFweLnra8J
   5bSJBEqU16jzDXQ0Aj456NsALt7n+yW44Gl2PFWZvUMKsglFkn6ug6acJ
   X7/Kb3IeJX+/nrjRrY+For50erXJ04IWPH8VrOE6BU/BajNSUgCgy+zxo
   edm3KSaArlfOABZ893i0bNx3mEhMcJTebG5ecfnumovuTN0mORZqTEtqZ
   A==;
X-CSE-ConnectionGUID: WlyuI4XHS52c4s3jMkd4jw==
X-CSE-MsgGUID: UKwBjY7HS2uPNyoqPRuKdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78133106"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78133106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:33 -0700
X-CSE-ConnectionGUID: 5S9cH0XpR8WSgUZGhQWMXg==
X-CSE-MsgGUID: vsD02ZUFQyedQpUuP67l8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216669451"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:19:30 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6x7DOxwYL2URrNljXUye9/pkkJEgGvMluK0lJvrxOuC0xbXj7FAX30FaacLX8YhZ0OPHvObfLJMQO/2SN+g35yiqaoD0NRLoUjVpE+2Q20auqMH/3eN8vNqeXNA0qqon9XPsaIe92fDZVh+Mg1UkmBsd9SsRDy4gIp0tNH66nGK1sHczu/E46/iEpMu3OTnw5VrTffX0fgcASGq/Ie7EXqV/nMY/jUbQKm5RmjvL6qjRWcWKx6ViJTBK/cyTXPT4S2tdWggG498XtLIIpii+AJvy2fTLtiYSBf15Q9eG3T+Ca0gqQjmJsGaeiN50sqItyfsZKYw9iiBzpM1lzZGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ef+jK0YkTsaCNho9PZIEWOi4UpNIRGBY/ukEGrwSAI=;
 b=H0VSauvRFB1tI8e0jq/4o+oqrWBjsBXRh7ExZegW3lLMuyS/pJ8v4XumtQgojS1iLuwQTGOV+prn9tIE9yLvCiPKb0LgzbgzTM91/8bsXzhSMk92RR9XdGex53qyRcZXOcTP8vXLmFmQINKNoLGDVP5PXaQO/TMnuutqnu9OmCV1ulxV7byf9gzFy0GUcZG79usH9ZV1Iv++LyV/eXJAJeavY0sG/e2QjPhRrgpLP4eMPT0EII6zOos+2wm5EvsoXAp/yqRiVl/sKShbUTDOq+/0mmlp5E5Wj0FJ/f3VGv3eIPxXujghHwmOa0nhwqTjYIAM2NmfqC6EEZaXDgxY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:19:22 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:19:22 +0000
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
CC: Phillip Lougher <phillip@squashfs.org.uk>
Subject: RE: [Intel-wired-lan] [PATCH 13/61] squashfs: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 13/61] squashfs: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKX2fg+jweOV02/w33fa6lR77Wo/jSg
Date: Wed, 11 Mar 2026 08:19:22 +0000
Message-ID: <IA3PR11MB89862A758B9D064ED69DDEFAE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-13-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-13-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: e8b0c821-2d3f-4cc9-93af-08de7f46e668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hyIuLUdmPyLzFfo/AMlIgUhhPpxXs27MqgAcsjs3Lri9dZWGQ5+fJQ1xWd8ZICk+wRis9iHYgsfZNVJ7jkWWDmFCNCV8kgbZKJlJfRNFyAspZsHjUK8GuRP2mfAL52msAf5GSElgzxcXii8zigcZ2ryUL7j8/4SNLIl5VyYkLT1yroOARCGG/WEyuf4tG/uc2H3MEDJhclHNB0LS7X6mxBbL5fB9NvyIP4lyNKMBwNKVFM3Mjaf+9wFkQBlnfH/Iix3qoDyr0Db1QFfhi/8Tab8b3B1mrEdPW85Kxuriria1pFrWGRUraaG6oRMtPONRUwJnepMR0AWDZSDUF9rzHGvvg5owyPeXf9trGZR2wey3G3QSzs216LtP6d955vO8Msnp92wZz174C+XkIsNGJCupjXktimz09COEuUYxgEwEVnxrAU/iX+PUqnoLZJolB97WMvzkGwqGt0NDJfKP5Y9eqiVm4RUn7IVxfXSvypR+l+Br036/OsOWsR0WvlwkZ7HZQmZwEOIGhD6MEQQIVSgYUhE5yDNKNX1tpNmVNxzMy+dB9deYm2IYTdcC0Ugc/mJu36P8u3i1vhrRrRtXVxmaeREovrXHsz/DzvxYsAWq/oBYKm2+FhLXVAyqOyF5qH/bLfCZijH0D1Bv4+iOy0u7ONlVBTxbOr5Y9JwqqH9p7jkhWALVMfPuloIvXuVs1JpzFIWvYpe755VYqBYIpVEaNwBvF9ONxe7vaRpvSfgCEtGZ+lgB7Cj2x5eqwIAqFLvGI1zZ1oGsiYpofTLbJlkPqlbZe1keXc5yayewRg43f8P95QMeCWPzC5G7dys2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWRZSndyN3p6MVJLdm8wQWtCdUs5MzFPRTJMOUFSK1hTVGFzM3phb0d3cyto?=
 =?utf-8?B?bU9zV2k5UlJNUVVCZzFhd2gvdEpicW95VFFqY1pxcTRCNjU5ZzNKRWtQMktN?=
 =?utf-8?B?MFl6ai8xbUR2Y3I2SjlwRmQ3aXNDTXZRNmZ5eWo5b0dndEI5eG1NNXZxYzg5?=
 =?utf-8?B?Szl1U0MvTit4bkRMeW5WZmZlYkQrRzVBVjZocnVqQytGY3RFVmVnNkVwTity?=
 =?utf-8?B?NE00YTNXYjAydXZtQ3I3NFE2MnNlZ2pxb3U2MmkwcC9haUk2ZGZlbEZFMWl2?=
 =?utf-8?B?eHRuaDlzU1ZGUWg1UlhlaXcvZnZNZTZISVdCSUgrMVB3eGt3MGhjUGxjZ05i?=
 =?utf-8?B?a25ZNmR6bDBOenBaaHhvcDVSdWRFb0k5MWRML1VTZlVwRkhRTE5Idk1rN3lD?=
 =?utf-8?B?MndNazNEbFo5UXRiQ3FOcFRqUXl3ZE5lOUdKWUo3Y1VVVEFodXowMUFXNWl3?=
 =?utf-8?B?bG16S1pGMjdJNzBmd2U3a3BvS3Y3b1FrMkcrcEJIY2o1QUYxbDRseFZ6bS9n?=
 =?utf-8?B?UkxJWnoxMXBETlRlaGpjR1J2d2NwYkdYejZMSDEzY1lrQzRkSllpeVE1TmYr?=
 =?utf-8?B?bWd3RWh6MHhLM1dYblFaNkNsTnNoQUs2eThTZUs3dGJRUlkvUUxwcEg0WUZs?=
 =?utf-8?B?Sm0vMWxIUExwV2tjR1dxMlROZkJnTWxVWisxK0V2SHZtU3Mrb1gzRVF0aDhL?=
 =?utf-8?B?ZTdtSUh4cS9zbFpjeFF4OW03U3NsV1FUcmdZRjRHWWlMK0ZKVnRrd2ZSVUpw?=
 =?utf-8?B?bGlJWUN3TnhVOE9iZzNMT3RWRE1OR2xES1dZcDJ6alBmOGxMcTg5QittRUha?=
 =?utf-8?B?UXVCS1Nka2wrM2NKcFVLaXc4OEgyUzhVRU1ydGJkMXp1V2RQdGc4NGUvdUI1?=
 =?utf-8?B?d3ZMdWFpREdIdUxHSEtlSXgzazV0eG52QjY0QTdaNXRKam4vWGdvcTNPeDhQ?=
 =?utf-8?B?alVQQTlhYnRkMWE4ZGlQYnUyUm16N2hpaVdRbGNEVUZXakhDR1NkcVhtSjhl?=
 =?utf-8?B?QzkzajRsYlZEQ0JyV25USVpzMG5hSHRQMFpWWi9KMXBMSEVRbjQvTU1pUlJl?=
 =?utf-8?B?SDFHOElpemRwUUF4NjN0dkhhYitKRUNKWmh0VkhJRDRzTUpnMGRsZzdmU0RT?=
 =?utf-8?B?WVlNSi9HaDZRVnQ5Nnp1aWFFcGZFUVQ2aG43d2lMWHlhdFJlUEYvVlBybTBG?=
 =?utf-8?B?cVdkMmg2aVNkSzg2azBLSXRkWjJ4cXJsN3g2Wk1hTmhxODhscStUMC9QbUs5?=
 =?utf-8?B?TFNhRTg0bXo4ckh5ajRQVmd3ZERrelByN28yRm9GRFBTSUhnZ0tHZ0FyOWxw?=
 =?utf-8?B?MGV4ckdXaTFVdmRpbTBsNHNycGN1a20rU09MRWJibXVCYXhWanQxZ3gyaml1?=
 =?utf-8?B?YnYyMWtrQXhDaXBBWm85eERWOXloRUQ0RU16M0dhRFZucmJyZm9qWC8zdTBL?=
 =?utf-8?B?MUZaM3dCSE16a3lxcjVSeGFCdUo3M1RaSUxzTnJ6MVFiUUpWYXltSFhsN2dD?=
 =?utf-8?B?YWdTZ2R2VVR5KzlVRGZCVkZJVm9IU0poOFhaVm1pOTBzUThmak5aUmlNMERz?=
 =?utf-8?B?aEVnS1FqZEFDMGo5dE9VaG5RUFBhZEp1M0cvdWllaytEVFU3WUgrTnBFQlRN?=
 =?utf-8?B?MXNiVXljL0JIQ1BRVkJKTUZrakprM0Y3TnB1Rmw0YzBLdTNCTEpGb0IrSnkw?=
 =?utf-8?B?OE10NlZHS1BoLzVmQ0ZKdlRjWXg5WWRpY09hT3pURVlPQldSaXd1ZDlpUXU5?=
 =?utf-8?B?MjFFT2RCMDEzUXA0L2V3VmpmZTA4RURUOG5heFQ3dlBoKzFTbnFvRXcvNGE3?=
 =?utf-8?B?RDJTbHdPV2ZDWU5MYXhaTTMvQ1RQUmJveXVraWoydjFjSGhranJWVmJHYUFN?=
 =?utf-8?B?ajNYRm1UaEo3MHdqSFJFcjc1Qlp2eFE1bGRHUWhiRzg5V25RU0RGWDVGeVhj?=
 =?utf-8?B?d0hMeG90Ylo0aE5MSkUrZUtDMU5QTTBheDVVZndEeGdYcTlCbGVLa3VTRFNL?=
 =?utf-8?B?TFcxZTBpMVFxRmF3dVpjZnVkRnozUUQydnBuem4vUkpSQ2xYMUhLTDZvazlv?=
 =?utf-8?B?SWdhNGtudFhKZStXaWFERXNlQWtMTnJJNU51WnZKb05HNHJPSU9UeWQ3TXE0?=
 =?utf-8?B?bDREektPd2grVHUwU2YyTXhWNzZKeXdwQnU3YjdJKzJ5dlJmbkhwdHJ0MHli?=
 =?utf-8?B?V09CQjZ5UDh5ZUwrZkFiN0R6VGNJWWtLbkx6WFRHRlZJZEpkb3h0YWtuTmtE?=
 =?utf-8?B?NWk1L0s0WG16OVZnTGJ6cEZhNW5HU3NtWGVSU3Q4Q3R4ZEs5KzdZajZzZnBp?=
 =?utf-8?B?cU1zMHVWZjBMbGM2eGdDYXp5MmlId2ZINlFmQ1N2Tm1jUHo0bWJ2b2xVd2dF?=
 =?utf-8?Q?qzpiEgWXQIGOWACY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P0Tryjjgi7r5Sa0dlJeJhxUWOQBz8cPKEFEztYoIPr4G9+CoOlxKVru1o9mOIJtLJTY8Te8NA1zDRylwrIJ8bEp9UvPbQY3P7wrnmq41gcDMf0KideWh7G3rBfeh4eusiMFtOni/PI1ZCcuU7kkjtwBleS6siQ0a1Rv86ZTPBRp2FdISTmJLmkDC7KRDl3GmMiwpkTbJFJ7/0QuSkCIUlmrscye0PIOC9mWlgNEE1LMhsArZCWgtD7EsRjD0lmgKJ46qBspyG8JcAnk7wYrD57fKY38r2tUvYJA9hM+vSpC0o+LODVBGEyovjgeGID60S25IUFIu1VtmqFyYsdFWGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b0c821-2d3f-4cc9-93af-08de7f46e668
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:19:22.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/8DqgpKLoEvRkW7zxyEgNR2f6Ove8R3jDy9/Bed5FvhwcoXhnWgJFh0D0pbQpAo9gEO552WAVc460NALCUO8gCA2vIi8cOsqM+scnMQn2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6AB8525F470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1083-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
bS5kZT4NCj4gQ2M6IFBoaWxsaXAgTG91Z2hlciA8cGhpbGxpcEBzcXVhc2hmcy5vcmcudWs+DQo+
IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCAxMy82MV0gc3F1YXNoZnM6IFByZWZl
cg0KPiBJU19FUlJfT1JfTlVMTCBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIg
dXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBO
VUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+
IA0KPiBUbzogUGhpbGxpcCBMb3VnaGVyIDxwaGlsbGlwQHNxdWFzaGZzLm9yZy51az4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBI
YWhuIDxwaGFobi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGZzL3NxdWFzaGZzL2NhY2hlLmMgfCAy
ICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9mcy9zcXVhc2hmcy9jYWNoZS5jIGIvZnMvc3F1YXNoZnMvY2FjaGUu
YyBpbmRleA0KPiA2N2FiZDRkZmYyMjIyMzVlNzVkOGMyYjEwZDVlOWI4MTFkNmUzOGQ4Li44ODg4
Y2MwMjk2NmUyZTMzMjEwYzg3MmM3MzMyDQo+IDA1ZDRjNTgxZWNjOSAxMDA2NDQNCj4gLS0tIGEv
ZnMvc3F1YXNoZnMvY2FjaGUuYw0KPiArKysgYi9mcy9zcXVhc2hmcy9jYWNoZS5jDQo+IEBAIC0x
OTgsNyArMTk4LDcgQEAgdm9pZCBzcXVhc2hmc19jYWNoZV9kZWxldGUoc3RydWN0IHNxdWFzaGZz
X2NhY2hlDQo+ICpjYWNoZSkgIHsNCj4gIAlpbnQgaSwgajsNCj4gDQo+IC0JaWYgKElTX0VSUihj
YWNoZSkgfHwgY2FjaGUgPT0gTlVMTCkNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwoY2FjaGUpKQ0K
PiAgCQlyZXR1cm47DQo+IA0KPiAgCWZvciAoaSA9IDA7IGkgPCBjYWNoZS0+ZW50cmllczsgaSsr
KSB7DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9u
b3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

