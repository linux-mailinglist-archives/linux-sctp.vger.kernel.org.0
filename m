Return-Path: <linux-sctp+bounces-1088-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHPVOc42sWmesgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1088-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:33:02 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48B26094E
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA3133F25C7
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0E3CF662;
	Wed, 11 Mar 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4vKRzbD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BB3CF034;
	Wed, 11 Mar 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220806; cv=fail; b=SCdYPXab4hfOn6kXd7enuxpOM3ssuTUB9sPqRY2nIKPTfBhtKa3/IqjQxALqQhTkdDTB4UDtwhr9UyLFN/7oI1A61ppVH51vjAoN/p19KgrnFgFbvg0fpUbkoXqwP/bPnNipUMrqi8OUVZdyGRsgTGOhBcWXAv2B9cAUe3pWixc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220806; c=relaxed/simple;
	bh=VICTIF5oKMXxelvmMzEh0zJq1HLJVA1XI2LRgC7VCcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6oVQEIRRNSU71rxv9phHbmg+YO+H7LwRFaN2YRizif6gz0RVo15MpTE+s7x7Scsiu3oj0Cj4p+EixS3aoEmEmPZouQI6xWpZCq6F4XC7OCx8zxaGtOrdmDCu6umsBClWzIKSN34bih5DSz/G8/iQ+bkpoTAdkCORT01VavGlQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4vKRzbD; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220801; x=1804756801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VICTIF5oKMXxelvmMzEh0zJq1HLJVA1XI2LRgC7VCcU=;
  b=F4vKRzbD9kWZOIQT0yw3Zp6UEhZ5KB6WoTWuk0CTA3QsCuf98JfvWm6T
   /qjjS+/qkXtr9l60KeYPunrbrJk69YDYBkPNkLQNB2x8mEvX2xlfVG0jb
   7I00jjjIMJpgQVJoEFtUlbn6QuyEmyWpLyfyNY7wA+nNiPK6KdfyqFxcr
   +0FBG7DDpoNQlKcLdT8gGwIvs4DYGeao/8xRnYIcUtwp+ebfyVtK8q8E9
   c//73RhLzh8FL8CIPZCfFe7rbwa2LSr+/ppyqzGnE9jkFeVg/6ymaFD4/
   8Gl+PNVI9jcFQQIVBAs8kiRvOfqUb/WusogMDGwZUUK4sE1sYM+JRtXGP
   w==;
X-CSE-ConnectionGUID: VWZosoLzTzqApQIFUcPYsw==
X-CSE-MsgGUID: Kb3ZUbIsRRyFIZb/wXReHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85760418"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85760418"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:58 -0700
X-CSE-ConnectionGUID: rDRkcxt4S2OrIy4Cq2KTYQ==
X-CSE-MsgGUID: rJMf+9RKSX6kadZB4KURPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="246008222"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:19:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBGG4b7Mdcpvq8z9yjAjPaUvWfs0969wp35Z/SLhR6InEbJEFhaspgNYY88ae+ZdBOsep6jkskWKU85RsuBka9aNuS7ILrocSsI9607DCJrexM9Nzcemy7avRs9dkUQ3WfWXQsQNwAnzHSaUNsSafYBXS0W40gkMZONfhQhaTTTDqWzYitHdN/TEkLiCeNy+idNvXz61VqJaMl3G+NBxXWL8frlhzEYWrL6bgvEL++4KmrfGmcWkzAPM9v7t9PScMaV/jRMmKd49JNsyq6OBncJ1BBh3iiQhjw1tLvKTObiJXiy2p/DWvgtg0KFIKwkiHyD1HXK+2hptWijd0caB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VICTIF5oKMXxelvmMzEh0zJq1HLJVA1XI2LRgC7VCcU=;
 b=xfcbkXZEdYs5HLIJ2+RiuBCXGERHxwTQRaX8mksonk+QjitTrQrNfhKNs6k7ObcV+aQhOS7NWZe/wu6ZqZb6/GGM//v7K5wZC6l8reZEZf71p/KJnMEJOcIdNd8KeiZDUs7QhU04x3Me3t74jznDcB4OREvnvw51oAcPX5RZwMag4sIxX96PhH1W8/9nsYyKE2oPxh1MZZcM/fg8MBl4iVb81ZhXmhGlFZJAGP9qPSWYpRx2Sy0Smi8mWdn+9O0vKYZHVWiHGb5Sr161HNfzgG9TkIIlrE02eddq/HH65rKWWSwgXuLhvNmtj43akkr6ZfmnAgA3Y4Es5JhYrvIV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:19:53 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:19:53 +0000
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
 Schoenebeck" <linux_oss@crudebyte.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKa+tfh5nrJRUSV5t+CFXfTkLWpDx2A
Date: Wed, 11 Mar 2026 09:19:52 +0000
Message-ID: <IA3PR11MB89860002CF9EED385181141EE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 146b6497-57df-4729-7c02-08de7f4f5a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: xCzo8EzOlP1vZF7EM8SGVAPapKDtDSJ9Onrfr0iC1Ul3jbJp+H5/xvrVGhWVhOAUvpUksI5GqokHPwAgYbia+l8Phr4v5imaJqjPwPVuAYpvIWoxwk5Fa34TmO36HQOv/zGERAVWPri+oruLJPjkDNbAwHWgEV3mSphZJI1ow7fgT9V6yNsiMdhw4MalqOBAxsnT0Kuak5pL+mD59TLzZ1FAu6dKl9FO4PB4ti7p1IrOMTXVtjRJ2niY9+E+LrmUdugLbF8jcggmgtoTGWi96vqbqxnEjkOIHm4YD9GDNCmIBRgteJ83GtQU4CZGUvfUbRjfFoiMuyNptzIBMZXM7njG2eUqaAxVZBj5K4Hxw9vaaZlwyz6Ppg6ZZLPRZgfF95iCc0x0nZqQKNH4QtV8JRb0offlpviOvR1+nNLwCBy9YfKrzsSlTDBJbg5DzfBXZfza4KQRT13W0ebTCbB1x4RVTgP09IYLKbWE1xiwKPJ+3resnHDtWC3U4/2xVQ/YqUVAJZMa/fCHwmD5NXnqYtw5CFBOj7178Qp3z5LuLgv9B7EjHv0xOb4W8YvYrLzDwMCwlj7CxK1NUhr8cAzkzgXMQadCuYA0JvhBNDBYqtcIsXyFDXASt5+/+JtoXn+Jb94eJqJZ7YHeStDaPrD7NlIVscXhkUdAOqzUzzeCpyhzUe/oTbXLycKPHJqNXyz6CNIU2OObJQevWL2VTAJu1rPJBWL8wRjMMQoyfe55tTxJx9VJCKw9hyXE454gBcuDtLLc1udWV/FbB7c7cC4am2lXYPz1pb61er8qpsY1LImElxWAQ1kQRXK4XecHwbar
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXZJUTJ5cFJtN1k2d09ZM3h6TXNaaEVrMXNUc1NHbUVPMnJrb3liY0Zxek81?=
 =?utf-8?B?aW9MRXIwR1RTYmFFQ1Z1YlNQb25lVytGRWVzZlpkMTVGa25VeUF1UVhlTHph?=
 =?utf-8?B?b1FHNlZTc1FuTzNUZkxUWTl1Mm5xbGpFMW5SNC84VUI4MDdybkx4WHhOemRy?=
 =?utf-8?B?UmNkWUY0V3NPYjF6VEgvOVg0dDQwQ0JvUXVXQ2JCZDI2bFYxd0ZFaHNrT0do?=
 =?utf-8?B?K2hiejVjM1NYeHQ0Yjg1M09PeGg1ZkwyczVjTEJnUnZNa0lxNnN2cG1xYmZL?=
 =?utf-8?B?U1MzVzN4UTI3Ty9SMmtQT2dGMlNsVlZ1KzFGRzBxdDJEaGd0dzVmYlREYWt3?=
 =?utf-8?B?ejdTLzUvcUF0KzJ3U3YwVUpudVVENkk4L3JRZTVNNTFqd3lVZHprNTdpTlc1?=
 =?utf-8?B?K290VWNEdFhBemRDMFdZTzBkbkllS1FJc2c0V1I1cmdRdktBSXArTU1JNFUw?=
 =?utf-8?B?SDNTbDFBV1BKWFVEV1ZyMS9FYkxGdERvM2pCSy9Bb05WeTVmQUk3NDdIb0N0?=
 =?utf-8?B?V1E5MDZiS3o3dUZrZTg4SEdjKzlIank4WXRuUmYwTUdLOE1ma3Fvckl6SGlC?=
 =?utf-8?B?bUoxZldwYXZ1cUFyQXBSc0pRN2NESmFUZ2gwQVVhQXZ4M1hObkk2UnJ3YmNt?=
 =?utf-8?B?VklvY3ZsUU95REZEUUdma29sbnJjSWI2S3N0Tmw3SVNVMEwxU1J4SVYwZzJC?=
 =?utf-8?B?dWhGcGFzVEdJUXhFOEViN24zbnNGdkU5R0RaOTMxTnpUN3VuQ05jZ1l1cVg0?=
 =?utf-8?B?a2FrRXh5WG1xaXlGdUhLRjFlbmFyNWlkVFdyQVozbHFuNytQMURIaDR3V2NR?=
 =?utf-8?B?Um5hc3JvQjI0THZvQzk3NXo2WlY4UWtKd0ZjanU1Uy8rZ3I0SjhmMDBtZW5R?=
 =?utf-8?B?T25BY3NwV0VGRnIxYWJFTlBqZlBQNjFTUFRoTjF1KzIzQnQwVDBzbHdMbHNE?=
 =?utf-8?B?dDZQb0k4azljMlAzdVdhQXlSZ3NGRWgzZ3hqYkxqTmRDc1E3d1dpT1drN1JP?=
 =?utf-8?B?M0J5dkpqYlI2cVJaUzZWMHo4RmpKNXQrUW9IeTBPMWN5WkQ0T01UTjBRZWd0?=
 =?utf-8?B?azNVUkkxdGQ0QVdUN0JGMHI2TmhBRnQvK01URlI1OE1WK3dVbEhSUHRwTUlM?=
 =?utf-8?B?S0R5SUd4SlBkZGJwY3FJdDQ2TFlVaUZuRXorbEhpSDczS3VFUWtTaEhRSXE1?=
 =?utf-8?B?K0lNWDZSekZpbTJhazFCUEE0K085cmwwZ0FMZDhKbnAyQk9iandCYnpDUlJG?=
 =?utf-8?B?VlZNcjhxZThBVFdRalAvL01MeUQ4MW9uVWd0QU11Mlh0UkZWSDhDYjNLbjhy?=
 =?utf-8?B?RkU4LzJVOUJKVWhjdGlCVllROVdCdnEvam5QaGRQZUM5Zm4wVWJIckt5RWUy?=
 =?utf-8?B?U2I0cGd4T1UxRytiUDN5QW80TzdVVnU4MXB2NXdWaVJtbUcwSHZCdytUeWVv?=
 =?utf-8?B?bTl6ZTZjNEhOTnJIRHNSYVN1bWE3TjRtWXJGeEZuV3d5TUd0eG85OWxyTHh5?=
 =?utf-8?B?Z1FLa21RQTVzWkNuajBSZTU4aGIyUUU5R3p1R0NGSis1Z0E0ajRRM2x1bm1s?=
 =?utf-8?B?T3pUWDZWdVRwd1VkNWNTSlZpU1JhRTliUG5OdjAyUzU1azF6QkFxWkpvSVFn?=
 =?utf-8?B?UktjSmNFZVV2U3pFeDc2ZHlOOFYwM3U2cHJNdWk0L0pRc1BOaFYrSlEyb0Uv?=
 =?utf-8?B?Nldnd2drMWxQQWdENUVSVmo1UHp6am1xK245alhPNFhZcFVVaDU0clJqSlJE?=
 =?utf-8?B?VWlqMjBOUWRodTJPNk03R1Z2dGhiYmROVHZ4aXlPVERDQ1Z2UHdNbjJKR2Jy?=
 =?utf-8?B?VWxmWUlRWWJHYkNQd1lCQjZrdjJtcGZ2cXhrbCtEZjY2ZkpqVmpsYno3UUxQ?=
 =?utf-8?B?WVkwWC9PZkJUU3o4aFBnYmJBNlBHb0dETVdFL1Y0cXl2ejA5cVB2MWNjNTV0?=
 =?utf-8?B?V1R4ZE9IUUZDODd2aUI2V2FXYkZONDcxSTk0VkdleUFjTlF6YVVvWmVDRmxu?=
 =?utf-8?B?VHdxalk0RjFTR2tGMndWMkdwS0EraDQvOUpCZ1pDL0N3NE9WOE5iWTV5VjY5?=
 =?utf-8?B?SVNWYW0ySUhBSXU4RHVLUU9MbEh4Yi9tdHBBK3oxUXhiaUdGWW9nSC9LRXpy?=
 =?utf-8?B?KzMwMXl6S2JNOFdnd05nK3owNVNEbVc2bDVYTjhUd08yU0x2WXcwVXozT0Zh?=
 =?utf-8?B?TUVqS2RYNlNYdDJSSTgyNzR5alNyVWNLc3J3RHE4WFk3V1JySEZuR1pKSndP?=
 =?utf-8?B?MjNySHJ1RGx3TDBVbHFuVlMwNkwzb1FzVTZFR2JQQS95VkI3ZFBrVUpud0FU?=
 =?utf-8?B?bVZPaUFWNlc1ZHRtMVhGdnJYZmhKM0tnL3crLzQ3R3gzdEFJczhnSnVRc3Vq?=
 =?utf-8?Q?4trO51J1GdXfqpgE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a69exJuCkYK9He6WhXS5mSdevm7QQYzMbKq84o6cab/5zxaKKIUsXxZYgqCNGumcBaFYj5zLT1NCQUL80c4a3isUjr381++Uszaxdb+w5gQ3ba2ICCPC4p4S98Tto+gtTS3inkmYhU6lWe4LdVhuTdSfcEEx5WYWHKzq9EoNXTXaza62zs2mCjoKYQ4FGd0s6imSNFVgZso0GnP1fA05JfZzBZXax8lUVJJD3NHpTVS7O+eMXVBl5SkwIt2o84IHBRoKTycswILn+dpCi1xdfZCcW0cVL5ytxukuqDkiRpzmx8Ifcw4FsWCPhc/WOC7/BSQT7ZFKDAzjTO/HqycriA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b6497-57df-4729-7c02-08de7f4f5a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:19:52.9395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ftkionec1AH2Drm+uzecDRYAiZuu9W4MK6U0DRbxspF/1CAxnRVLkh4XI4gsD2ggIGpaCVs0DgNhFcoz/9RHiBchDTTlsTKwloLswabMQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 7D48B26094E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1088-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[63];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
b3NzQGNydWRlYnl0ZS5jb20+OyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5u
ZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgU2lt
b24NCj4gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQt
bGFuXSBbUEFUQ0ggMjQvNjFdIG5ldC85cDogUHJlZmVyIElTX0VSUl9PUl9OVUxMDQo+IG92ZXIg
bWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92
ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFu
Z2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBFcmljIFZhbiBIZW5zYmVy
Z2VuIDxlcmljdmhAa2VybmVsLm9yZz4NCj4gVG86IExhdGNoZXNhciBJb25rb3YgPGx1Y2hvQGlv
bmtvdi5uZXQ+DQo+IFRvOiBEb21pbmlxdWUgTWFydGluZXQgPGFzbWFkZXVzQGNvZGV3cmVjay5v
cmc+DQo+IFRvOiBDaHJpc3RpYW4gU2Nob2VuZWJlY2sgPGxpbnV4X29zc0BjcnVkZWJ5dGUuY29t
Pg0KPiBUbzogIkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+DQo+IFRvOiBF
cmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPg0KPiBUbzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0K
PiBUbzogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBDYzogdjlmc0BsaXN0cy5s
aW51eC5kZXYNCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFobi1v
c3NAYXZtLmRlPg0KPiAtLS0NCj4gIGluY2x1ZGUvbmV0LzlwL2NsaWVudC5oIHwgMiArLQ0KPiAg
bmV0LzlwL3RyYW5zX3JkbWEuYyAgICAgfCA4ICsrKystLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL25ldC85cC9jbGllbnQuaCBiL2luY2x1ZGUvbmV0LzlwL2NsaWVudC5oIGluZGV4DQo+IDgz
OGE5NDIxOGI1OTNmM2ZiMTllNjgyN2M0NzI3NTMzODAxOTM0NjEuLjRiZGU2YmQ3MTZmMzIzYzgx
OTc0NWU2NGM3YWENCj4gYzBkZWE3YmViNzJmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL25ldC85
cC9jbGllbnQuaA0KPiArKysgYi9pbmNsdWRlL25ldC85cC9jbGllbnQuaA0KPiBAQCAtMzY0LDcg
KzM2NCw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHA5X2ZpZCAqcDlfZmlkX2dldChzdHJ1Y3QN
Cj4gcDlfZmlkICpmaWQpDQo+IA0KPiAgc3RhdGljIGlubGluZSBpbnQgcDlfZmlkX3B1dChzdHJ1
Y3QgcDlfZmlkICpmaWQpICB7DQo+IC0JaWYgKCFmaWQgfHwgSVNfRVJSKGZpZCkpDQo+ICsJaWYg
KElTX0VSUl9PUl9OVUxMKGZpZCkpDQo+ICAJCXJldHVybiAwOw0KPiANCj4gIAlpZiAodHJhY2Vw
b2ludF9lbmFibGVkKDlwX2ZpZF9yZWYpKQ0KPiBkaWZmIC0tZ2l0IGEvbmV0LzlwL3RyYW5zX3Jk
bWEuYyBiL25ldC85cC90cmFuc19yZG1hLmMgaW5kZXgNCj4gYWE1YmQ3NGQzMzNmM2I1ZTZmZDFl
NDM0NGQyNmJjMDIwMWZmN2Y3Zi4uNjA0NjEzNDRiNTM2YmNiNmU5NDExMmFhY2U3NQ0KPiBhODhi
NmE5OWFkODYgMTAwNjQ0DQo+IC0tLSBhL25ldC85cC90cmFuc19yZG1hLmMNCj4gKysrIGIvbmV0
LzlwL3RyYW5zX3JkbWEuYw0KPiBAQCAtMjUyLDE2ICsyNTIsMTYgQEAgc3RhdGljIHZvaWQgcmRt
YV9kZXN0cm95X3RyYW5zKHN0cnVjdA0KPiBwOV90cmFuc19yZG1hICpyZG1hKQ0KPiAgCWlmICgh
cmRtYSkNCj4gIAkJcmV0dXJuOw0KPiANCj4gLQlpZiAocmRtYS0+cXAgJiYgIUlTX0VSUihyZG1h
LT5xcCkpDQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5xcCkpDQo+ICAJCWliX2Rlc3Ry
b3lfcXAocmRtYS0+cXApOw0KPiANCj4gLQlpZiAocmRtYS0+cGQgJiYgIUlTX0VSUihyZG1hLT5w
ZCkpDQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5wZCkpDQo+ICAJCWliX2RlYWxsb2Nf
cGQocmRtYS0+cGQpOw0KPiANCj4gLQlpZiAocmRtYS0+Y3EgJiYgIUlTX0VSUihyZG1hLT5jcSkp
DQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5jcSkpDQo+ICAJCWliX2ZyZWVfY3EocmRt
YS0+Y3EpOw0KPiANCj4gLQlpZiAocmRtYS0+Y21faWQgJiYgIUlTX0VSUihyZG1hLT5jbV9pZCkp
DQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZG1hLT5jbV9pZCkpDQo+ICAJCXJkbWFfZGVzdHJv
eV9pZChyZG1hLT5jbV9pZCk7DQo+IA0KPiAgCWtmcmVlKHJkbWEpOw0KPiANCj4gLS0NCj4gMi40
My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT4NCg==

