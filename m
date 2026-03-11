Return-Path: <linux-sctp+bounces-1080-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFtkIOYlsWnJrQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1080-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:20:54 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB625EFD7
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDBFA30451DA
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 08:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69C36166D;
	Wed, 11 Mar 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDCmL9L2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5341135A38B;
	Wed, 11 Mar 2026 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217088; cv=fail; b=E+Ug1ixAGaDFuiqM+5O3YG982SxsaKm6jgECcM1qwuy34HPM4O5DJ3+Xf41Vtt8CuRI/bwYbHBj1D6BkECHjIQUt9gDZuEU5xY+rCaeKyIc8v/fGyE1pTzGZMO18aU6qdmtecWLA5KjmeZslZ4JG0FJeXyKZHihQxMCtoLkVjDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217088; c=relaxed/simple;
	bh=rHSTPR8Fc9A1kcEr9BNgQ3H6ENCSh2fOQze/dBJ1Cc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlatXKm0xjLf7zBwj3QXzedZBRWkV3DDVdmv8MTl/7mLQHPk2Z8kMosaaX+eoza4eqRtSLV0rxtgNeL02GNSOo6laa6JBnYjKAPfgJricJXXlBEjOHAPPJIDuJwChFtCPsI6iHDjqPHXGWBAltaSzLmC9K8s7K96fU31a/MFf3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDCmL9L2; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773217087; x=1804753087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rHSTPR8Fc9A1kcEr9BNgQ3H6ENCSh2fOQze/dBJ1Cc0=;
  b=BDCmL9L2ayWiNdGY8whfHp85qh97G3BqG1GDr7VAUofTJ8MLVbT2pTlG
   pAtyACfrrnhQFW0UAWVhLWHJitPSUE7KMOZNwcbI6f+Iv+BKBRZFyWtEq
   zTNvKuomqUON9Jq8DydgD6WZPXC1jlnyIAkDDWJeQvhrnMsaJAIl+cS9Z
   Jd9MwWJ2YAgz0Pz5b1wkZkXou/cweWam69oKpXRgJMzkZMTLCXGtRuBrD
   iBh2UQlwNx5agvSqGvp4SWH+hQ6g7rpgjB+ZE4XtDQ5ShzKM9wEM2Ax1l
   R/opqAeWnLtuwvAwwruBn6lMlruGuDfE3qybm8DBbs2emrEGtVOUU0MLT
   g==;
X-CSE-ConnectionGUID: wdOBXCMuQmKI9CRUhNsGhQ==
X-CSE-MsgGUID: ZMK+mRGDSx6TeffJE1c8Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74249427"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74249427"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:06 -0700
X-CSE-ConnectionGUID: Hhe6i8ySQPa1KWece/+b8g==
X-CSE-MsgGUID: muxfWZe6Tw6D9HQb+gLyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224857183"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:18:04 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL8svBQNKmw/8mtSvlf2JIW+8FxyS1RH8RujcMGnqIrU6PE0pSCQCGW6orrobOk3d+Qqs0MwBMYcTSiLso2GVCQLryZr7ve4sSek8OTw3pLhTOAIiS/mScFmL1V+tpL4QU8nXPg0QJWVtZ6jEIB4Sul9bZMhbvVMpIVLZCbzF0vaF60XAKR+lPFPorKThoxvgQiN2FVV0RPN0D+0QHlHgGo6q1NsTQCXPClrColCxjKjjhXk7ytVAU8IBR1WfwuA/NwZEeLG2x/R3vb82hlUqjIRqRCMSq6CoiGRufdpoSfsNMzS/QRJxw2P3cPd22/Oxaz1zavPeVKNFEaQ7K1r0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHSTPR8Fc9A1kcEr9BNgQ3H6ENCSh2fOQze/dBJ1Cc0=;
 b=ah5CXqMy7Do+WJ9plSBMqsIWm9msnWzxQG3DgJEjUJStONsj+1qroIhag9aNQQbJKA1lWCegeTAYlytc6Tkk2b0MFIhcXUW4lkJsVZWJStdiRvuz/Qsjy1zL9Hz+PRVKG4El9NlL/D/U1qtiw4G4bJssFK8HwGYtLpjcsTbx2rAjg811TeYUMAUmgWSbrd+lSp1VN5FucGBRTqUpZy0wZ/m0FVBDOKdtCtEy/loTCKYEJ6sFefpIUvKdm3MCZP+rVk+fINU7M3K7E5vUe0DfSLFkNFeu/+4m7Blh/ozrb6/zN3QzKIn9ftDPjB9v3rL349I7q6oGwhFvY2zcR+lzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:17:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:17:56 +0000
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
CC: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
	<lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, "Christian
 Schoenebeck" <linux_oss@crudebyte.com>
Subject: RE: [Intel-wired-lan] [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKDga63OVEHpEC6YaWFyczaH7Wo/acQ
Date: Wed, 11 Mar 2026 08:17:56 +0000
Message-ID: <IA3PR11MB8986DF184F43C9374B8A7735E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: 5b5ab855-410b-404c-df48-08de7f46b385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6rDIySybMEnrEtdINr8k5jYWFGk8tGETDyo7F47FsEs2kMQfOvBZpAEQatb2K5j5ba0H/ZnUKTlyVgDIHPUOdISEsD2JcGuzuWM2tLNvSgKyu/uxYe4lZDdxnx7k1ojHaZvToL0delNFlXnFDB0nAktpwIhjqHaLXFsoc+4GByTOnjlSMMZ7KUrq+6++Bgiq+O1Mj4ufCZKHxXpa+EPJszUnKaVoXkSiFZ3b74gfVTUCiHtDu2LwF1QCypkl6/4mAAmVDJDA/Uaf9FT5wkDwAq66pvnDzWJhMYqEXXRN8MY5mvX2Kffk9N97BX7tbUFGFCzylPMu/MH5y+0yxkqIJ7xzwUMFySm687PBUj52++g9lJ+EMuEAWFI6BT00dRSx2msRhrWj71pprY+783ksMzmFkfKy6Dhp0F73qeovM8SQ7joY4qouGvbRtfI8YQqbBo/lvKGaY1cdbCKq8zbwRtwppkrur1my3rSAazmyCL2PTyC83GwC3IcNkGtmQU46210aqn2QbjHOMfHARazZrxZB+5HVJG5B4kaJvamypCshm8Jg1SsCQlyHlpyqb4pVW+9NPWBkKnUbinEBZSTcidL0qQK7JymFLTd4ODfQLuB9vPlLk5eKDoWnL7lhMpa1nNXgek1mf7neEuZJGCWczr1ll6M9dbhjjsNvfICX/ZgRVdae4zAotC2Ig9WGoYH7U2gJ4uHvDf97GnMxb7GZyrtkzchjEdX+P/iBelbNbkQPtoo4FD7hGj8jJIYM1EKPcAtnOnwLOIzmNTT/xEivtELHoERlnQ7QssO1MG7syDWPzlp7MUyim+knN/0Yvwc3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEZHWVdxTkNyZlZDTUljRWpJNCs1OS8vOU9vUWRiSWxDVEgxWmZiSlRmbnU3?=
 =?utf-8?B?MTdPMXBBdkFLYlVpcnMyS3F1dllxTzZXNWFTR3czSk9jUVd4NjE5ZlpCbVNS?=
 =?utf-8?B?UlQ3eDFoQkUvbTJqMTRMNkEwenh3Ui9CaG5od3pORkpWT1dxbXR3bUVtRWU1?=
 =?utf-8?B?RnViNXpDckF6bUxkdnlSdDZ0MG84bzU1OG9OS1lSR1p1MUhTL1ZVUlZ1UzMz?=
 =?utf-8?B?ZEF3WWpyNFNrWUp5c0ZaSFBzVVJzTk1EOE9lZ1hyWFQvaEh6djJ3Uzh0VlFT?=
 =?utf-8?B?aTNKQmFKVE1qYXozUTMvS3Q4UUlNMUVkV1Y2TWVGd0JLSWc3aUdjK2ZlSWJQ?=
 =?utf-8?B?aXI0SHJEOUJvQ3NVUVRPRzVSUTJJT2Q0bHNxd21ZdldFeDRsaXZzZ3JNd0NL?=
 =?utf-8?B?U1ZhM3ppUTJtbHViTU95WnNCeURSdVQ0QjVERWVrQSsvTU1OUUtLaWlvcUFS?=
 =?utf-8?B?ZjZidWk1anM4aUJ6WmlGdzMybTgyNDBlSVFqUFFIWmUwT2c1NWhxN0MrcW5P?=
 =?utf-8?B?SE9HNXBKeHpWZ0JYZW5UaDVwaERycUFzY0doRVFrREg3bjhIdHJQenRMbmwz?=
 =?utf-8?B?STJ6Nmd4RXRydmw3RDB0SEJ0MHI5TDEvT0FnSndoVUFzUExXQUJmQlRNSjU3?=
 =?utf-8?B?UzB0ODVzNW5pQ2VGQ2lsTXJXN2JvY0F0dnUvMmJNelFEcjU2STRPOU9yNGh5?=
 =?utf-8?B?QWFLTDNwTDRRdTdXcFQ5NFVybEpnamN4aURmNFlneVVQcmdRTSs0NEl4Vktt?=
 =?utf-8?B?bW9VazFvVi9zallyNWIxNkRvTHpKazVPZ0NObEVUK3hrUjRRdTVwNytnMHl4?=
 =?utf-8?B?MWVrMmZybnZiNlpvL3d2YWJQcEdWWjlJTElaNFQzb1FFb0g3cmJVcitCOVRM?=
 =?utf-8?B?TmhjYks3QU9yOEc2bHBNVm9XMFM0T0loNEcrdi9DNDA5M0dhUFZFMVNzMHZM?=
 =?utf-8?B?QUNRa1dya2F4UWZaZGRMVUpRdHpnUXk1Nldxclp3ODhFWW9MUTZnRFJma2ts?=
 =?utf-8?B?c3Y1WCt1OWEySlJLWExLVlp3ZkN4eVZab1Q3bVdwTW5QSzZ4TUhlMzBlbjhU?=
 =?utf-8?B?UTVKakhIcUM3c2ozQThUN01heDFFNVUxV0VUQ2FlTFM5MW9JcGs1d3daNEJv?=
 =?utf-8?B?bXZacmdQYW1CTDFEbjV5QklXQmZTVmpyOTJ2MTFVQjdiRy9lQTFpNTZzMklE?=
 =?utf-8?B?cU9xQUNqU1RWWm16UEk1VE5PSnlxK0dReHhBU0VmM0JiSEN3cGVSTTR3SnZZ?=
 =?utf-8?B?ekpoNEtxT0REREQrUkhQOTFCdHVQdmViSXlDaTN4N2NnbkpHZ2ZpUTY4dG9Z?=
 =?utf-8?B?dkVOc2VXNStTcFdUaHovRDNDRUY1UUZuSSsxTFo1OTRwVmNta0xKdmdKTGxZ?=
 =?utf-8?B?a0FmVzNXa2Zab0grbk9jTktyZlFLYXZna05XQ29tOFhCZUVvaEhMeVVsSU5M?=
 =?utf-8?B?MWJ5b1VhaXlsbkhlSERHZm5ZODBjaVAwdU15NWtJNlJyVElxTWwyUDRxZmlz?=
 =?utf-8?B?c09RVmRIdWdpNG15eFBhZ2pYR1MyU2oreURsWnZnOEd0YjAxa3RyOFdrSndk?=
 =?utf-8?B?enlnMjlrSnBkbTQ1ckdJSFZwWWZZb0NSWTY2S1o4amkyVDIxUWo3VDB2dHdT?=
 =?utf-8?B?WERRTC9pVWVxSE1mdjkydDBjTWh6R215UDFQcWZxclA1ZUIrN1NyYXN0cFlE?=
 =?utf-8?B?M0E3ZlZQTHRUZm9hZEdyVndNdHRLLy9LQkdsbjBaQkNLODF3UXpydkI1d2Zj?=
 =?utf-8?B?S21iNGRleVA1bFdpZVBPRFgzV1lnRGZna080N3h2RDhuR2ZMRTZqN3d1U3VV?=
 =?utf-8?B?d3FNRHRaQWpFNDZ4ODhKWDgwRDhkcndlZmRNQytIVllVcVlvYWZHVWx4K205?=
 =?utf-8?B?cTA4TmdSV0JJejluMXRvMXpBMmFadi91WEJUTmtYM2xnYllORG54N284ZVVj?=
 =?utf-8?B?NTlMWitpNFBmcXFRREphKy9NSFdzU3p2TE52ZERTU1piN0haK2duR1FtK3pN?=
 =?utf-8?B?Y3Q2SWE2aFZYaTc3OFhOYzduZWtBVFZNTlU0U2thQTdMTjRXWEhyMVdJWkFU?=
 =?utf-8?B?VmRDNFBaRDYxOVJMdnM3TTl4MHlzbnRJM1RPckRwbTE1WkFteHBBM2wwRFl5?=
 =?utf-8?B?bjhvMDdlSDBLVE5XbGYzdHJTc3lCcU9sNE1LMHZHRkpQcHhXT1RlRUErY0Jt?=
 =?utf-8?B?VXRTamNyWXZRMGYzM2pKWGZ5bjk2Z3NPa25ncWkxeExhRXhZUlZvVjVVMzUv?=
 =?utf-8?B?cyszUU1nMFdrUzI5MC9QcjR2c3dHL2pqdFV1QjhDekRSMGhjMzU5WlhobDlL?=
 =?utf-8?B?dmUxZlh4aGdxUktZNy9iM0J4Y0w1eEhGSkFtbVRXeG5OZ0Y3TlF0emNDbWpN?=
 =?utf-8?Q?IDe+ZmwHwp+2VO6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: USw/wKHP68g1t56EH6siG7zPpyocD42Cu4vWflTDaMTguNZOaT9sPsucGnvHksNlMqdOMvn8ggcqsA4MnMXXmV+qcROA1KdgumK09PT3bgSG/u48PbpHQQZdmSXbyfrSG4REn5n7D7KP0Qb5vJGBbzWdWTnxklwqPRPFzXxy1QKl2feOGmPS0TAs/niD5OjhYle2zcTqs3i51pW+GT3Uiz5eFpOWjJIT7/s5caAqF6/mnU73L2AMjxG+X5g9wDIP7KoRZzACzaQdF2xQTiZjwH50DgfiomRjcdqzwC7f88mNqbXtZQ9Gm8Dn40liAQLZfSYiRZV4a92/S7OTf084yg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5ab855-410b-404c-df48-08de7f46b385
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:17:56.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W68ONACbRXrFUYzV7oSeFHRa5YZyG3+ltabAb3fDtAr9g1RN1zo3PBObktdebn+J5Cyze5fLQUBtTpvdulDRemsIZPtbnN+HE6XWLYpSSTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 23DB625EFD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1080-lists,linux-sctp=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_GT_50(0.00)[58];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
bS5kZT4NCj4gQ2M6IEVyaWMgVmFuIEhlbnNiZXJnZW4gPGVyaWN2aEBrZXJuZWwub3JnPjsgTGF0
Y2hlc2FyIElvbmtvdg0KPiA8bHVjaG9AaW9ua292Lm5ldD47IERvbWluaXF1ZSBNYXJ0aW5ldCA8
YXNtYWRldXNAY29kZXdyZWNrLm9yZz47DQo+IENocmlzdGlhbiBTY2hvZW5lYmVjayA8bGludXhf
b3NzQGNydWRlYnl0ZS5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCAw
Ni82MV0gOXA6IFByZWZlciBJU19FUlJfT1JfTlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNoZWNr
DQo+IA0KPiBQcmVmZXIgdXNpbmcgSVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigp
IGFuZCBhIG1hbnVhbCBOVUxMDQo+IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRo
IGNvY2NpbmVsbGUuDQo+IA0KPiBUbzogRXJpYyBWYW4gSGVuc2JlcmdlbiA8ZXJpY3ZoQGtlcm5l
bC5vcmc+DQo+IFRvOiBMYXRjaGVzYXIgSW9ua292IDxsdWNob0Bpb25rb3YubmV0Pg0KPiBUbzog
RG9taW5pcXVlIE1hcnRpbmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPg0KPiBUbzogQ2hyaXN0
aWFuIFNjaG9lbmViZWNrIDxsaW51eF9vc3NAY3J1ZGVieXRlLmNvbT4NCj4gQ2M6IHY5ZnNAbGlz
dHMubGludXguZGV2DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBmcy85
cC9maWQuaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzLzlwL2ZpZC5oIGIvZnMvOXAvZmlkLmgNCj4g
aW5kZXgNCj4gMGQ2MTM4YmVlMmEzZDFhYjU2NWFiMmQyMTBjMGEzZjNiZjk3ZTRlMy4uM2JiN2Vm
NDM4MGU5NzJhMmQ5YWI2N2ViNGFhYg0KPiA2Y2M1YmZlMmVlYTcgMTAwNjQ0DQo+IC0tLSBhL2Zz
LzlwL2ZpZC5oDQo+ICsrKyBiL2ZzLzlwL2ZpZC5oDQo+IEBAIC0yNyw3ICsyNyw3IEBAIHN0YXRp
YyBpbmxpbmUgc3RydWN0IHA5X2ZpZCAqdjlmc19maWRfY2xvbmUoc3RydWN0DQo+IGRlbnRyeSAq
ZGVudHJ5KQ0KPiAgCXN0cnVjdCBwOV9maWQgKmZpZCwgKm5maWQ7DQo+IA0KPiAgCWZpZCA9IHY5
ZnNfZmlkX2xvb2t1cChkZW50cnkpOw0KPiAtCWlmICghZmlkIHx8IElTX0VSUihmaWQpKQ0KPiAr
CWlmIChJU19FUlJfT1JfTlVMTChmaWQpKQ0KPiAgCQlyZXR1cm4gZmlkOw0KPiANCj4gIAluZmlk
ID0gY2xvbmVfZmlkKGZpZCk7DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFs
ZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

