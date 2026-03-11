Return-Path: <linux-sctp+bounces-1081-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ07AG8msWnJrQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1081-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:23:11 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7325F132
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F5DF308910C
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048393A6411;
	Wed, 11 Mar 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UERYJs0f"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE31328B78;
	Wed, 11 Mar 2026 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217116; cv=fail; b=YBQhFQSHTJCLMH6O+LKhUFvli3plIQviFWFXpYT/do32/7ea38PyMGJy9b+JjYp9NcwAV3BgFusKIIo2n3G6nhbi5dkN5UV/YUXfOgZN8o+XybRgIl2bkO9E7vAURayCenZmPQzelI7UX+ffRaS+/dAmEVrTz/tJel9rvv4hv88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217116; c=relaxed/simple;
	bh=EtXvAtG2Nq0/hQHPRy+43TWGRsERYyZeG5NpAQzHH84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfvJBBKMHHjSC6N9ajq72YZBJVR6vbigv/dXcAFJaHnhvgD1Jq8K+QvaqgKeBBpnoGVpjTo2OtrPMg8kRGPB+TGur7FISL4U4+kXocqfTPQD4pHBcnhZg9fwy16mM3EmT6rndHHwjsdgMgFVxwi1NdYEGaS7WHxQRo7LKUoIu+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UERYJs0f; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773217116; x=1804753116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EtXvAtG2Nq0/hQHPRy+43TWGRsERYyZeG5NpAQzHH84=;
  b=UERYJs0f/DI1JTsMa+oNep5TRD2Qj11M1BA9qlnXss31PeQ/5ijIv3gm
   kIB2O0EaxpnygV8/Wzor3zczq0qtaZ68MwjAgZ1KYS93vZ3ma799veDWd
   p/k+xamoxyil3Z3XMgpi0FnRIqUWFUjQsfrsbu7FP280CKIyB1su+xVvD
   PSFJhhPx3Gp6iKSUYT4MxTHaSsONLKKMvTsJ5oGOp3mD2P0e8aJHVgFov
   Rq6UHI5lLgp9mosiKX3ct8Razbz9pntXVAYpPNz5ySMN7E/aRxxaBKRa0
   VaMs04+LOOxlcHk/qNHlg5y/64QCvppdcyoRDEYINJWW2fQ+arqTOlVQV
   Q==;
X-CSE-ConnectionGUID: 7ivUj0KLSTKTh2/MWvumgQ==
X-CSE-MsgGUID: XN9VJqn4SzO8s06eAxyStg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74249481"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74249481"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:34 -0700
X-CSE-ConnectionGUID: HltMTZSVTuKXfMA+/dCoxQ==
X-CSE-MsgGUID: H7QQi/l0S3GdrHVwbKdJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224857220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:18:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:18:33 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:18:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhWeUg9RHkwde45PsJ4JWqOSCdeKLI4zXqfmOmLC72RNsSuaePzgBOqydmdBart9kBRM4vGCsXHuicMQPqiRMunr+TDVDVhjNwU1uJeqkh0qw8A/rUlXEy/lbqK3GEeN6jUz2fC6wRsQWKqauF298jSC+Q/RFbzIE+W6VXt1JOgD0fpdatOT8es2hWEYCz53kPlVU+jVDyu2pogz6Wn68NcOQWy6ltCboG3aPGBv0QrmpKXLYCIr7s1fjtw0jMP6lZ8WrHxrb/qf/d7UhIdns54Ef5rr67QRiD2BG6rZQdTfrVQlCGs87WeWbmXIrMIE97HPLe1NmRthT+C2QpjZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtXvAtG2Nq0/hQHPRy+43TWGRsERYyZeG5NpAQzHH84=;
 b=oHyUy+PcAJ26UqZIDCAhBkwR5PEuLcOV9EAPJMdOG46fYZ3sZ2zEh+Jc6vEr0V4LxhaUtEWfuDtX7RY3ICuoXWxq5vIFctYkIcwqQV7qyRvYu2c5nW3GgdDpodZHiFagr8lWXwIHwa9+USjvsv1BLItaRNouSk6Pfqoisok3Citrt3is/cIKvqrJlJdXIS+bOYKW9LgL0dlSZXsVlJoadFXIuYaLtkBy4uIfc+igV9KMIS3gdk7CD4SJNdDHHpoSaTKjLN6hM0+Dxf+5rsxq3JiX692xN8nkcV1L9wo64i6ePYwPAEbh/cQuWFrnu4YYNRRwwhIP9PnelRsa44jKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:18:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:18:29 +0000
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
CC: Miklos Szeredi <miklos@szeredi.hu>
Subject: RE: [Intel-wired-lan] [PATCH 08/61] fuse: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 08/61] fuse: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKakfOg0IOsvkih4vkupNrtzLWo/fKQ
Date: Wed, 11 Mar 2026 08:18:29 +0000
Message-ID: <IA3PR11MB8986489054B55797E95481B4E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-8-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-8-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8510:EE_
x-ms-office365-filtering-correlation-id: f0b79d3c-8a1e-491f-e6b6-08de7f46c705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 218av+tk7NyEEEJHlt1fulpFsi4UC6fpwgDNRhUIo2srO+/2TlKPYUzqV6H5yx4/knSysiIYLAaj2nLqZWHAdu1SoQpRi0aWwfjkYGZkXXTnOqXXnGjeLjtTkO4fkIexEpaVwuoR3rXyNToQRzb5udkf2e0TkniRf63q3E4x2/Qsy+YHMKSDhdg0YrR7bqHLlTT65eVWUG8bQYTxuOIwxH/3eEeAr0QVcnMXps9rVv8ms4jTZAl9oBruoKwrcVKRvMAYtQeOHm/H4N+39mJro9jTVq7f0K2pUUVPUzLH0SjvADMnP79eNq0DfEgvto07cN9GtBHLJj9yz9ap6CHj+QxVwbx7qnEz+h6gtanoNtbQAXJS14mOiELCA7UYoGbm2oG9tpe0FbTbI35z3zgrJiCfOOkMu+TdauAyFH9ONVtEqs1BCc8Q08aATYoMPjnXz7l1F/Ie7LN32cpJHXtHUeLUZ7mt8QdGON2+772urnKn+bCSRhWpVC7iK5zs/aVo3VesNyKjWDntP0E+RvmNW9YW6iP29xyzZmIepfzptq7O0gVsc83K5NXWqNDl0XZbP2m+2SJLVItwf1rRVA98Uoic+p9HmIszvVm1BCdKiS3O68tN9M6AIUVmOV9o3WIVfAnXbSY0BVKVLXg3Mb2lx+2EkcGz43AAWbJ6eDOmDruN/6VoYWM/wCcQiAJj1WX/H//FLcsMb6L5AwFYc93/4NoHeaJGmcMFGb+D7+FzqWd9JGofHi/dA+FN1sszd7ygtK2IjBhTpNvItFkx5+FRi12Q/yLaVwUVyW18stZ9w32/hdIP58uJhbalSmXIx8AX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWx6ZFk5R0FqZEFyM01sZVlsSkc0eFhldEgyK3lOV0NGektFVWlqRThOOGlC?=
 =?utf-8?B?Ny9zTkZHVHlxWUhTUDVnL1J4WVBONk43VzZpNkprY2NyWDJPeEh3NmFjU1dC?=
 =?utf-8?B?bkU4d0pjVlFWM0pUNlgraHZkUFlLODBpWC82K2s1dS9KM2RDeTdlUytJaktV?=
 =?utf-8?B?dzI5T0w1bDVnUm43bEh2Q1UyOVVGYk1XblJEUmN0OXZxcEV0QTl0a0NzQUR1?=
 =?utf-8?B?NHZnV3dwY2pQclgrSTd1emRVT1g2VllPa3ZhclRvalZSenF4TjljK2hlZUUy?=
 =?utf-8?B?Rk9reTdLSlRlcUsvWlBWRjQyQk9WbFVDSGlzRkc5UlRza1lVZUx1N0dYOHht?=
 =?utf-8?B?dFFlaG1RV21lNlhMQkQ4UkVhM0JwbWEwNlYrbjBhRXIwbVp5WmkwTlFCTHBD?=
 =?utf-8?B?eDRWbXRnaFVYaGNkVkxFVFpaK3NOYUVuZXh4OVhxbVIwRk4xQ0hKQU1OL1lN?=
 =?utf-8?B?ZXpqeHhOTDY0MzA0SVdPdXdoS040NUFwN2c4eHA3WDkwUjZwNmV2Zjc2Z1h6?=
 =?utf-8?B?bGZpV3M5K3YwNnlDVlNRUWxkRUF2SHZUbStzQ01GUko5Qk5mRmhsMldWamhF?=
 =?utf-8?B?bUNVemRYWTVlbHBmd2NFSkRQZjIzc2dpOU01dktYbEcwN2FOT3l5RjVtSDdT?=
 =?utf-8?B?am9wSDdSWGIyTUg5UEtwTWJCWTFPZXhRZExxdlZuUGh0OXpTSExpN0dDczNu?=
 =?utf-8?B?YVR0bUtodFdVcHpyVUgyaEZ3UEQ3SHUwNjdoZ3RyZ2o2Y1B6Q1NlYkZMMmFF?=
 =?utf-8?B?YndOaXMzQ2NxeWJzRXF1NitOR0loOUtwSDVBZHg0N255V2hRdXJjVExuQVYx?=
 =?utf-8?B?V09BcDl2bXJQbTdWcmNQcVJhbENJdzZoc2VWSjZXSm12MkVoOHkxSDBEM240?=
 =?utf-8?B?Y09DY0g3aUxtZTlCMTc4ZWRzOEFubEY3UDZtci9lamVHZit6Y0tVK1cwdEV5?=
 =?utf-8?B?bDZ2RWFYYjNXMWRFTDhHL2ZhVXRpYm1DM0wrLzhacG1FQ1lkOTFvdnlCY2x0?=
 =?utf-8?B?MGJKZmloUUtvTWVCN1hZaTdITy9wdzV1U2tiM0Z2UGxXYWtxdWpLWXRxOFNa?=
 =?utf-8?B?dGdvZUNZSVRnNXFncDYvTEJhWGhIL2duQkJVUXp4aUJMWURVSTJSVGNRbkow?=
 =?utf-8?B?czBrUlNJVzl0N2FuUXJnaXBkNFRYMERQdlJqVHFBRFJKdUI5SmsvM3VscnFa?=
 =?utf-8?B?aVgyNlFDK1lIVERQeHJwWWpmMDFPMUdCRGNqUDZyUGNLek1BTVpmVGkyRlZt?=
 =?utf-8?B?RWVxTWJmb1poYURLZkkwRTNZc0liWlBpZUVKalZuR0taMVZBM3MyaFFhMnYx?=
 =?utf-8?B?RUpJVnRtbXQ1a1BRcE0rVUJXUXUwR0dVZmtLbUIzMVV1WTRKMDhLN1dTSngv?=
 =?utf-8?B?NTNpNklFTG5DU1duMWY1VTdTM0x3MFB0Rjl5dXVIa3JveW1KSk1Eb3pHVDRD?=
 =?utf-8?B?SktITXBPanVzVXJzOFZXUTI2eGpsc1YwOTRlaGRaMW55cnVqRldNZ2VTTlAr?=
 =?utf-8?B?YUdTYkc0YzNwSlRlNC9yOURYclN3UXlCRWxHR202ejZJa3lnQWdvb3U1OUM0?=
 =?utf-8?B?WnlpbEY2Z3FEM3dHUHJTOHNOTWJ5R0JCalRteHhmZlB4RXEwbFpZQlpqSEE4?=
 =?utf-8?B?UnVEZzlCa2Mvc0huSUEyQnJJSjhtczkyLzdIVXJ1RzRieUYyenpUazBwTzdL?=
 =?utf-8?B?RDFQRFVZNjFuUTc0V2ZnVjVmL0pOUW81YTc2cmN3QWtJNDRYcDZiZVozQ0gz?=
 =?utf-8?B?T2pFYWdTUlhqOVdQK09xUXNEVzFKb0ZBbU1FZVByUVUrZno1aUJNYTdoUFVZ?=
 =?utf-8?B?MzN3NzB5a1ZTd0xVeGl2UlRvcnQyTEhIY3phd1VMLzdWNFFqa0JQVVNYVGQ5?=
 =?utf-8?B?amhRMEhqK3lVRER4dmVEMGFMV1czTXJvNXEyVkZ0dHBHWU85SjRXSkplZ3U5?=
 =?utf-8?B?YlMzRVF5enFCZWJkQW9hVGYrZGJmWkVMVTd2djcyM29tWW9nckJFQ0VZWVNI?=
 =?utf-8?B?MUZ2TzZhMXFzOFkrN2xNL01PRXFZSm9tdkdtNXJ4V3c1YndxZUhOVytmUXdK?=
 =?utf-8?B?RE80RUhCMUdUeE1CSE1ldFB6NXRMTHhKbWhQNlJ2SlR6S3FWNjhFZ1lyUndl?=
 =?utf-8?B?SGtXbmtZWEpRVFJiSTU2Y1pPUlpIK1dIVGRpVXZHUkNRWFhWTDR4dE1ZWXFL?=
 =?utf-8?B?VzVMaHRwTDE2S0swcnQrSFJCUGdKamhQVktJSkpTNTg4WjNtUWJ6cE5aU3dn?=
 =?utf-8?B?QVN3ZE1VTjltdUpudTVrY1MzaGIrOG9nVjluZzUvQkRPZlNTbkpyaHNFcmda?=
 =?utf-8?B?ZzY0alErTU90NisrZnlMQXlRTU5WbEJsQ2VkWFJBZkttTG5jNzRpSVVKK29K?=
 =?utf-8?Q?937ogaSyRs1rYCpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BSr62bCMqwvc3ZcTgKxPQEVAqCIGt47aCt5UFuG+ESCN/jeAx23g3sUt2to6KpPVm0z784cA7hIp1ShQK03CNPBOyVdxyDvJdnWURgYcxcMwEN6Ctx1Vn0H1jrG9rOS4k3a/6F2vFOGDqyG9ziWaiGYqYVeBzCKxv5+83M/FkSqNsRReWlomos6fqjV7BpRVXvadNez2cWwMc3FFTZWyHuyu/K++tUfMA3eG48glHKIZjDt42c1OmtYDfm2TeM7VARx9JHPeh74XZuCdnPIendjbbcNtuv/eIcqF8D+ph2o8ajfqSNJ/od+hZxZ3kv6WmCx49CEZKRVe7RzbSDvROA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b79d3c-8a1e-491f-e6b6-08de7f46c705
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:18:29.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBgAK4LdcQe4vqxPgvycIwFMG4fqUxSz+qscY7c9Lw1EqVibO5WkDRGF3FDerZbyM25IO2GGZA3bgNIdAApemWxaqr28XJ0iX0vmtSb9Kak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B4D7325F132
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1081-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[55];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
bS5kZT4NCj4gQ2M6IE1pa2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDA4LzYxXSBmdXNlOiBQcmVmZXIgSVNfRVJSX09S
X05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VS
Ul9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVj
ay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IE1p
a2xvcyBTemVyZWRpIDxtaWtsb3NAc3plcmVkaS5odT4NCj4gQ2M6IGxpbnV4LWZzZGV2ZWxAdmdl
ci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBmcy9m
dXNlL2Rpci5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kaXIuYyBiL2ZzL2Z1c2UvZGly
LmMgaW5kZXgNCj4gN2FjNmIyMzJlZjEyMzIzZTNhZmI5N2I5ODMwMWY2MjNiY2U5MTdhNC4uN2Iz
OWMwMTMwMjdiZDljNGJhNmYwODBiZmM5Yg0KPiAzZWMyMmJjMmRkNGEgMTAwNjQ0DQo+IC0tLSBh
L2ZzL2Z1c2UvZGlyLmMNCj4gKysrIGIvZnMvZnVzZS9kaXIuYw0KPiBAQCAtMTU5OSw3ICsxNTk5
LDcgQEAgaW50IGZ1c2VfcmV2ZXJzZV9pbnZhbF9lbnRyeShzdHJ1Y3QgZnVzZV9jb25uDQo+ICpm
YywgdTY0IHBhcmVudF9ub2RlaWQsDQo+ICAJCWdvdG8gcHV0X3BhcmVudDsNCj4gIAl3aGlsZSAo
IWVudHJ5KSB7DQo+ICAJCXN0cnVjdCBkZW50cnkgKmNoaWxkID0gdHJ5X2xvb2t1cF9ub3Blcm0o
bmFtZSwgZGlyKTsNCj4gLQkJaWYgKCFjaGlsZCB8fCBJU19FUlIoY2hpbGQpKQ0KPiArCQlpZiAo
SVNfRVJSX09SX05VTEwoY2hpbGQpKQ0KPiAgCQkJZ290byBwdXRfcGFyZW50Ow0KPiAgCQllbnRy
eSA9IHN0YXJ0X3JlbW92aW5nX2RlbnRyeShkaXIsIGNoaWxkKTsNCj4gIAkJZHB1dChjaGlsZCk7
DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3Yg
PGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

