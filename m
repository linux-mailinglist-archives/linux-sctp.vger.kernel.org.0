Return-Path: <linux-sctp+bounces-1082-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NcqJgMmsWnfrQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1082-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:21:23 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D797225F07F
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 957563042693
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2C38D6B6;
	Wed, 11 Mar 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSoUlYKb"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5EB30C35F;
	Wed, 11 Mar 2026 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217156; cv=fail; b=WYWBBJ81Zz9JDsSBs4EhI1/CXKZkrTFwLK4dgqsmfxOzX98ZCnN6a++4ILY1lltXIKMUdfiiBHWZySXh5FQqvmIFvcmgyz5nWhMNg31gQQyaT/otgdFqn0DUQsXGlFTBxWYWa9EFyIau4H9/su8fCwJHU8Fc0Nglb7nY4oJ6we4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217156; c=relaxed/simple;
	bh=Vb8k9EUnk5kJj2LtvvAOaCQRgisPN85MlLKf/pO85gI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkYTwTbn1aJbcOb3VWI6Ij+h2Dg/YuJ8n5jJVVJCHkKPBU/HfzXcQMu3w9xIIlozh59d3nCMsyL7DIQ8cEwhuuNQstDIgKjq0W8LRsGRoYQRYCqwqpBrew+/i+H6ydu5oSGa3oVt6OT3KBJLrDSmES3yuLisNiHEZwBKwGHKDTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSoUlYKb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773217155; x=1804753155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vb8k9EUnk5kJj2LtvvAOaCQRgisPN85MlLKf/pO85gI=;
  b=SSoUlYKbIt1MraGYxoJ9sMQwrJbOn9Ji8S0PjZVXhv7rod2JF78aM495
   vN1LKB4QId2a4kyCqrTevVnq761j3U4yFhO+oH+RDWuhsrkU5DafHYWCM
   sAihM5/k3qb+JuBlutFsAk0lW7L2YesKSMeHEKH7fPXCaGumy7q9+cYtZ
   igVZk/5HfDmu8kNd26z3kunov4Zr8b+ZLLQvYsz6w6foE3D1ALV2pI07y
   v0KrrHQr9CB57iuLoOgXALPnh8TQlZ6WVXxva9qhV260QvbluXT3cnjtm
   ogX0XD8wgZozEO9/zTiJXQkSHCDRUnvawu8JPnZLTEQtyjIP5fO2tirb9
   A==;
X-CSE-ConnectionGUID: hvYdWNWPTh2jC4OLgHU/Ng==
X-CSE-MsgGUID: dpHye1dMTHiA5wGl/OGyTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78164845"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="78164845"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:13 -0700
X-CSE-ConnectionGUID: 0G/JU1hJQDO4CX97TaJrVA==
X-CSE-MsgGUID: 7FfCmmmvT/izw51Ty9X2lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225346316"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:19:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:19:12 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4t3UpqGV4Iwt1Cg6SX9sEYFE2m/da3cKxX1afn4MUvi6yj9zT4pthCq9A004dIzW7bXS98TU+4axPGJTAwGmaY4N+rIysvulbxBCWvABnjSe2slga6kxxoUrNS2SrwEb3m72CFNJrcnea8IwcAnV2fNBnVp+qQiIqggtQxb12siFmvcMMNQiQ/amYzFg0jAmYSdgAJQ+skniHyl9D5Cqd5q3+NuM1nWRLNYV3+y5+VCCRYlUYIStZFepSpxeyPs41EHIwIt1vDy5IeBXEiCTNxJFvoavqlmZWmUEVv2c8mw1/Y/AK/xOfvnTAbGkRRK4mxSnbdM8rkcHEzBqL8uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb8k9EUnk5kJj2LtvvAOaCQRgisPN85MlLKf/pO85gI=;
 b=EiUDl672fvZA+ijYyaPTCjPwCEpLVplqSI4cfOec7Ynh7DU2D4qpjt0i0z23WnYoDvTJQctct/WQka/5QESAAZNzsS6Xs7eWWanjQegd5OMJJHYOXP+7iSea7FgOCC5gb/aTcR1EKawbkJ4kSdCGsG2h9POGEZyqLyqzBCuM9FavPV0Dd9MeP2JP/jXaJ6uo+S9AQL/5zKzlmIL0Te6Kn8TcKQD52+fBTb9lcUvFHL43STQ0rxNQ/FMHlW+R8Z738/lbQsDmYnFJTo42pYkPGtx+qlkbTdQ8UoDbCsmeR8hKVcgCEALh1m6n7GH8z/HcjPI3HsUO1QXiriKSC/Cdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:19:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:19:03 +0000
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
CC: Jan Kara <jack@suse.com>
Subject: RE: [Intel-wired-lan] [PATCH 12/61] quota: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 12/61] quota: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKaOR7G0NDKQEmlo1IiQUHj5rWo/h3w
Date: Wed, 11 Mar 2026 08:19:03 +0000
Message-ID: <IA3PR11MB8986DFF52256F69D2D8813AAE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-12-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: 45170395-41f3-4f6e-eee8-08de7f46db56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uDlo72zsfG7E7OegXYkgviuwxoEgXaQcvEoAJg6j4/rltsamRh/Qn9VNeTSSeHInq0aq0fsq4v/Bdcg7Bu9fowjf7kVfGkmRO4sHgo6UoLAucxJE5mV1UPNNekdUC8c14BHka0ajN4E62VBuw8ezPo6Szn1KmPPoCHszFNbnFKt73DcPuLI1+5CzzWdpgYMbhYzughjIDAdGd5KaDrao2XCGz4Y7vlp4pPkxhGSgBcWd8od5s+H0FtaAvLLkNLcxHrrNOJw7W3cr4+lGQ4TYN+96OzlDiZ98/4xKM3zQxVUr2YXyQnyaw2/LKg6lIZBu/bWHL1GmeV0gkPoWjYtsvSf8c8B6B50GnO0Q/HxfYmkH42E+A5vQGURNRR0syUZ+5vE42aTiX2VQSvEJp2bX8V/VCBR492SZ/RQAB/B86gzbVjpJhp/UCY+d7MAlBeNz3Vhaz2DbUsQxbpdQJTlcjBFUadmDgWef08tW5Dn28lL+u3v9HxgXk6FrNIqU/uuxb2gNMow5kq/4A3yV841iZVQanjpdLzZE15xBEFpzoOnLaSUsbEc9vap5CVUMr3oJKfVh6txp+I/91pdubcTMhiM9H3SoxgEyDUY0a5gKuil0QqoD2+8xDTkcc0lhWGn8p2QfT7dFHBEqprQZJl5C3GACzzX2bzH68IsnSQ/ZwxfznEaGV+bglhaLusO13upuwd3VwYC311TO4BYUFl6nKdo/Xr579B2L/I6b8Oh+5SKiokkchULV9lvfi4xnS7hLMk97rjgDRIKbAYsYJjOEn/YP6hTF/tCJfk2+qJeQ21XLP4lDmom5BfybqRJ1Uelu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xncWZUZTJZaUQ5SDZWeEtDZlMzcVc3SDZsSThjMUJSYjQrV3JWU0ZqS2Fx?=
 =?utf-8?B?czNKVzhscERCS2VEUzFhVW5BbEk4bjRZeUd1ekdmekFlTSs2bXNFSUh6T2FG?=
 =?utf-8?B?cXUwZlJGdTQyVUhPUmI0emsycHB1d3FuUTdRWC9GbGdNR1RpRVZIZXVUa1FR?=
 =?utf-8?B?YU8zRVcrUndtNG0zWEFCQTRNdldGQ1RSbjQ0d2txZHNuZDVmYVVhQko1dm92?=
 =?utf-8?B?OERFTmh5SkpLdWVIenNSV201YkRndWlWZ0FvMW5xWHI5eEFLNEdydkRlTTFT?=
 =?utf-8?B?R2VLR3FIV0xEOUhQUDZJeStlRmxSU3doZEV5NTZtbS9DWHhIQkt2ZzZsY2dn?=
 =?utf-8?B?M254RnZTbXZSV2piN04wRTF6L21oWmJya1l0d1hjUjlOdEtXcGdpZE9Zelhy?=
 =?utf-8?B?dVJxWmlvV1h0TVcwMDJwd3VkdGRKdWJSdXdFakQwZ2hGMUFuWEp2Y3ZLSG1m?=
 =?utf-8?B?Sk52TkRZKytpbm1VYTg3K2c0eUZ1ZXZUSXZJaFg0ZksrK0hYZm5TMVl4Zkd6?=
 =?utf-8?B?Yk9ta2ZqUVZkSUlFVFlCNDVtVDJwbmNIdVdkbXlRWGZ2eW1LQlBWMlNJdEdj?=
 =?utf-8?B?bU4yUjdIODFPNFZJVkZzYitwSkFPZVM5UDIvWmhHbk4wUmRNckE1TDJKeHZS?=
 =?utf-8?B?aGh1Y3cxUWF2S1phOFFPQXptTzlNblB5dytGMHpCdStmcDM4R2k0bVVISDY2?=
 =?utf-8?B?aTVJRlZYdDlBcXpSdm40NHZGUHFPMDZkYTU0dTRUcmNidzR5TjFxS0FOSDdF?=
 =?utf-8?B?dmVEcmRXQ21LSDd4STd6WVhLNC9UNzVVTG9PbTNONHFZVUlSWUFvRmsrcVcr?=
 =?utf-8?B?U0F2cXVsUFBWSUhSb2M3ZUtCU3lxZTFjekpEU2k3c1ZkdWV6WXBLU3plc2tH?=
 =?utf-8?B?U2hGa0VTanpGcDBNbDJBOFhOQlRCR05BRmJYMm9lZUdScXU4a3Rxa1kycVV1?=
 =?utf-8?B?YTlpN2QreHdNYjR0Q04xQ1d0ZEtIeHZKenBQazhvY1V3a1VJeElKSmhRR1V4?=
 =?utf-8?B?bjJBRkxXVDIzT3gwYVl3eVNiYTVwcFllTzN2WGRSaDlVdzAvdE91NUphUVRz?=
 =?utf-8?B?aVZaODlUcElwNzU2Rk5PZVEvbkhWbDhhK2pxd3dvMXNxeUNrM0tZUmxGaC9Y?=
 =?utf-8?B?WVBzWVg0VUlyTGEwVWZjYnhGYk1sZUoxZG1PWWh0ekw4dkJROE83Zzd3Q0FC?=
 =?utf-8?B?NHV2R0UvdS96a1R4Y1JadEFab0d4ZldRbnQzR2xqa08rQUc4UWZtVXlrRUxM?=
 =?utf-8?B?MXVyWFJOVG1Ha01mSXpiNG5NeG5weUpGVDRqV3ZuOVF1YlVWMUJycnhMbU5Y?=
 =?utf-8?B?TTZrVG5RZTZNT3QzZUkzYU1QK1F2VUE1ZUZVWWlwd085QWdQcFQ1cVA1WVFI?=
 =?utf-8?B?b1cyWk9QZzhWaHZkWDlnNUZ0cERKL2F4cFVyN2R0MVFjN25XMkdGVUFiTEd5?=
 =?utf-8?B?eGRwaDlGUWxZaHhtNVhGQUFOOXNRdTcyZ2NFTVdIM2JYYUhOTlZ0ajlsS1Jh?=
 =?utf-8?B?YjFEZERQNDAvWEpGZ1RxUmgvYjZFaHdLcGdZSTl3RCt1ZFpycWNjL2NyYUIv?=
 =?utf-8?B?Q3JxUGdrOFhGM0xpNkpGYXBOd2ZNWGdaYnpaRnpPMmhQYWZyZ2tOdTVYSk9l?=
 =?utf-8?B?ZTMzNCtQMFo4dmFTd3QwSXhqZzdiRjZGLzZOSFNmTGoxZkFpcXlFY1dBUDUw?=
 =?utf-8?B?V2JkaDBkV1FXZG1WNUJZcCtIWDYxTVpjcmFrMmtDR3RmT0t0QjkySDRzUUU0?=
 =?utf-8?B?d3BzSEZCOGNDY29RaVNrSWZ6cnpiV29Kamw3ZmQ1c0VhOFY3V0paWDRaelVv?=
 =?utf-8?B?d1E3RFJHbmNJdG1uNmptTC9kNmRpQloxaDNvd25DVC9mays2MDlMSEwxbG5z?=
 =?utf-8?B?UGZBQVoweFhSK3BVUzVVTmJQRnBIdFlEUEI1Rkl3S0ZDUUwvdzZlY2NRTTZG?=
 =?utf-8?B?anJTVEtZd3B1S29rU1dnRU1CRlhTaEtuUmhzeHM2alQ2NFo1cklTSU0yaDB3?=
 =?utf-8?B?Z1YwUlRnOU4zcnJEZkVQZmFKTzZWYkEwaFNsZGFhZXNHdFlsUHhHZ2xkOFAr?=
 =?utf-8?B?N2xVVjdNaGlwdDJ1ZG5YK0xjdGp4N0dERk5laVBKQndMSm91Snd3MSthVm9j?=
 =?utf-8?B?a1BlcTlYR2cyZ05zdWRtbGRteXl5T3JpSUQ2eHhub0JFeGd5dGNmeTB3bTIr?=
 =?utf-8?B?ZGJFTDh4SzV0NFVSSXhvdXVlKzBKc0haSXMwQnhFKzg1SWNYdGhtSXQvaVlL?=
 =?utf-8?B?N2t1bFNyYThOWWVySmZFRWVVdHRQT25KZWtMcHBOUHRvQ29kUjIwaHdjUWgv?=
 =?utf-8?B?ZjBlQ25mMVhRZG1CcGlrOWVQMU9uTThtTUhJNElGN1FXazRlUy9TbUVwMVRw?=
 =?utf-8?Q?7E/cpfHei4SBWdR4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ch+ochnprmtl2q9ovwqRCZrVKKPwM03tyxbmujYFXAOT4AvuwA9ANdyDEY1HYq6IS0CBOXih0ogi6kACQR5W6FOpUALMb1OgLPFZSt7TP7Zhrw7oa9Enw/9mMlwsHJG+Pm3TxuDNvdJyQO8kQOVniBOcvmswGUA/ghhpct1Qc942Npgeam/uTxbvHzh0RlgJgnbg0BOQC/40OOrTRkwjrKD0Zx07MQljFPxynL49qHtwlJhex01xgxSeN3yRDQ93lb8sXyrrmWc84Hn2r6LcA0e8KmOYPSzhVMI7T+UZ3AilKzyF9I4T3COOKVRZjIH/UnbR9RG+DtSLbXhPRtKf5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45170395-41f3-4f6e-eee8-08de7f46db56
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:19:03.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RHPwGkuHaFJ/hqNzAtwi022X2mgyphxIgJ+1aWEloOatEVlDDLjsHcJbFCqfAMKzQX0FZ0cacMjTK6ge16Cprkp4plz4B+kggP05WubqN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D797225F07F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1082-lists,linux-sctp=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
bS5kZT4NCj4gQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggMTIvNjFdIHF1b3RhOiBQcmVmZXIgSVNfRVJSX09SX05VTEwNCj4g
b3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxM
KCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+
IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IEphbiBLYXJhIDxq
YWNrQHN1c2UuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAgZnMv
cXVvdGEvcXVvdGEuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL3F1b3RhL3F1b3RhLmMgYi9mcy9x
dW90YS9xdW90YS5jIGluZGV4DQo+IDMzYmFjZDcwNzU4MDA3MTI5ZTAzNzViYWI0NGQ3NDMxMTk1
ZWM0NDEuLjJlMDlmYzI0N2QwY2Y0NWI5ZTgzYTRmOGEwYmUNCj4gN2VhNjk0YzhjMmExIDEwMDY0
NA0KPiAtLS0gYS9mcy9xdW90YS9xdW90YS5jDQo+ICsrKyBiL2ZzL3F1b3RhL3F1b3RhLmMNCj4g
QEAgLTk2NSw3ICs5NjUsNyBAQCBTWVNDQUxMX0RFRklORTQocXVvdGFjdGwsIHVuc2lnbmVkIGlu
dCwgY21kLCBjb25zdA0KPiBjaGFyIF9fdXNlciAqLCBzcGVjaWFsLA0KPiAgCWVsc2UNCj4gIAkJ
ZHJvcF9zdXBlcl9leGNsdXNpdmUoc2IpOw0KPiAgb3V0Og0KPiAtCWlmIChwYXRocCAmJiAhSVNf
RVJSKHBhdGhwKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHBhdGhwKSkNCj4gIAkJcGF0aF9w
dXQocGF0aHApOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K
UmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50
ZWwuY29tPg0K

