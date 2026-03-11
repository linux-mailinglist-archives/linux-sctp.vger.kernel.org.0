Return-Path: <linux-sctp+bounces-1079-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNevDmAlsWkOrQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1079-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:18:40 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF225EE1B
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E10793045921
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63683624C4;
	Wed, 11 Mar 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsILeU5r"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C535A3B5;
	Wed, 11 Mar 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217019; cv=fail; b=Kkwq9NonuFeZtqeBRf7hXav4KVV/Jg8j/JV0KXFFvR3jW+ZaywS2MpokjFeKRIPz9XcBpRuPa9HPOUTcW6JePVwKHN+XYdxv9wiiXQLvm+26LbVnSo/TtsBxYEdsv7c7lY25s0Gq0f8Bqd1jObC/N9vWCiAJnIIcKyu3zBJvChg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217019; c=relaxed/simple;
	bh=Mh00NQrg2lIKNWkDXvNhPe2GMjEhYIMI8kQ4tCuMao4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ef8HHaDQ5eEn3LaC52nhnsl4aNCvHoy4rGiNKgesiET/Cdpksb+wCW+TMd2RX7+u3QBT+NrwpUvKpRZENUTmFw5NSZxBX3Sl9qsbLsikx76ZVXST1RH65ILfAQw7m7pZobiFZhhvqjqt06+6HqoQBctPXMb2F0mjX8Zy1HNpuTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsILeU5r; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773217017; x=1804753017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mh00NQrg2lIKNWkDXvNhPe2GMjEhYIMI8kQ4tCuMao4=;
  b=DsILeU5rV0fPJi+km4xx5Ps63KhDRKsSsZOv9uaJFx/hrotbAgIMaQYr
   8EJ2sESMFdk6eLRDwLME1PQZg2v2BuMvZ2kChElVJTjXQJaY8Rt92R0yw
   4FL0jjdyct9zXzSe6yQSBCojhB9ClFK7tIJABDexaP9hVw2ZzC4TSqqcD
   YLsD8g0LWPJXclMl+vUxB10AyBFtAWSGom4RfakHdB7MQvI7n1GsjOyXM
   pZ9udvY7H1zjAnaQj4PLTc/BLSMUejVZKRaatBqIdGs9kxRjDG9/+cCQd
   vreAaCyyFuF+2GAOSwkIaxiew0NyofhB+QPPxPYfN+HkUG7MkqzGxhmJ9
   A==;
X-CSE-ConnectionGUID: sv405qvoRK2ohHqE3+wYpg==
X-CSE-MsgGUID: xaHTp5MlS4ysg3j3HlnVvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74467598"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74467598"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:16:55 -0700
X-CSE-ConnectionGUID: BMGoJHUZRWmghWNXe/Zk3Q==
X-CSE-MsgGUID: g5YTB1s2Sqi+a6FaJQciMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217077384"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:16:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:16:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:16:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Opo9MpRJtwx0zLgDgZOZFJvPXyHqHHtJzkUiUwVJCsz4tKEKo07LreqxtnrsCjwVojH4U+UwLGvLUj6tWPkc6m4pF4S6tJD49D6pQ27s7xGcfs0lsvws5Mc4Crewz36bF2iEdApjb3wgDXOINHplZ8RrYmMyGB9KiYtvU5ZM7+8PPHQ4D+mLJZuIVu46F87G8kMLHuO5LzweNhPlt1T0hwPb8bjCxWtbmFufuecYQPnZ5Losrc+UeFJp5bjwsqeLk92kr09MQxsBmElWGC1C55jrobnIuiBTr7MkzzIlRr7ETHdfc04dd2ppiR3SK20FP0U+KXkotq1HmCcVeC5k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh00NQrg2lIKNWkDXvNhPe2GMjEhYIMI8kQ4tCuMao4=;
 b=PvZIA67maJcJZMl8ktUdh9e+oCmpUPO8uwMtDhImWg/7I0jtaQ97c2U03ZqEoY5MA8kxm/yaPjMOIZv/MRKJR5724vKgt3Zy0JtPGquxl+oby5wgXKR+gL5+Or5WdIAw4vi7PIP0s32fyfKM3StEJoqnrE68jqMTix3K03Ob2M8ClebhUzWxUWTTpgzEU+9ptB0YRzkwnLjf3Gbc5uI4fJXkLyhlVjPmb83qjchjgoQt/KAwPjnhtyjdlxnRgmuNmCsuQLP2UvSKZFbsiecOE8S+TAZM+vodeF7mGh4J2QrbQPRzL3dwaH393UaCBjVAY6A3gLotIzLPB/B5adEJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:16:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:16:43 +0000
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
CC: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: RE: [Intel-wired-lan] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKJtosLQvJfHUESbmHNNZ0gghLWo/XCg
Date: Wed, 11 Mar 2026 08:16:43 +0000
Message-ID: <IA3PR11MB89868EDCF9D093C501E01FA3E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB8379:EE_
x-ms-office365-filtering-correlation-id: e34e8a58-dab4-497e-6b65-08de7f4687c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: jQMLhYHNcc8rWLFFel/x2sMvHTNauRhuYBG4bf+v7DsJZFhupIQte49LtN3UoUBak4B1IEWtI5P1CmysS1a+awGpSJz1r40isgFFN6L4/mibvFUKClT/MHdIMjSE4HQukbYf0M2IxFRTmvLUaDZO/+OqT2RCKgtSBSNwPfxfWkRyzOeF2hz7VqpT/bP5wowbzNc66q4wL8xr7nzirI6YWKRsmxf1DWqNzDJq0ZDssnFrN3NJVD+DmQgHzvk6oU6znVEUc7rJrNuDvx5SfI22I0vk5YAHgZS3r3GWilsK/mH0/G6jWruqtyFazGqdS4YPo4VggHYRFgUF4hMOlNHdsU7DcnNMARrbZ0SGm+HoHpUKEXC4slgRMBk4pTRlS1bNRHmu7dctE53a4eld7MfvX4/VCisN7uIrH3H7wkgEnlsZFrITVWlYj6tCEICkv95CBNqOFL+vcNYaZDnlXRN4h4ieBBAs4bkxgJo51IR6odZkbLzjMXpzGcqsI/mt6RfxXqC8AL1RcxFJ07fcXv73zoGCVGHcwPZIItHDvtrPE46pL/lO0UByfnfuhJKRNACe4ge0dP0jWubYBPg4uKPCBIlEiu1E9lLwYWDODI+MxWMdCnw7Hi6ZWZe7Crnx98PGgc8WM8q+qFjTlWci6orACn3nPHmShktAHNmKZLfzUy4xRYweFBtNzgWrA73evyHgmwW3MabvCgHgm+V/f7BaRNGziMylCelvMtY5LRr3SVkxqtpuIWlU2tl6maVXxD/6Zma/pAGcxVD3vEAJpHEREdZUf+Id82qWyMcEFNe8aBamRKZIZReDd6IYnkL9aw8J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JnUUFIYlQxQkxQM3YrYlVCSThmZkoyOGZMejBVUmpSTW1IdDhLdTdBRVBI?=
 =?utf-8?B?MjRuT09YQWdUSjNsclQ2Yi8wSDZBQjdiVzhCZmxXZkhQSTkxNjhXWExvNkZB?=
 =?utf-8?B?dGNLYlNJbi9SNlMwSG1HNTd0RmVRT2NJRmVYMklXdjdDNFI0Rnd4dWtKUFZk?=
 =?utf-8?B?YnZQVDBHelJaTmluU1FFQXZTelZZUlRNblJGMjVPT3Q5VkFpQXFLeW9UNmNJ?=
 =?utf-8?B?Vmc0bEkwVVBOSk5xcVJJMzh3b3NNWlI0MnVPVmE4SGxuUVJiaXF1NkNkUXBK?=
 =?utf-8?B?NmFLa2tEeWU4UEVPWERuTzVsVFZzREQyYnArUWdRVWRTRW5OK3FQcXZWRHpZ?=
 =?utf-8?B?MXdxUmtzUC9uS011RnlNZmYydWZHSVMrcDl6b3JnWEl1MnpIZk13eFZpVHda?=
 =?utf-8?B?UXJpT3RRRmtyOFdkUHVyKzZUN2s3NVMzNkZIU0ozUUgxNzRES3pjOHZaRTlw?=
 =?utf-8?B?YXBqeUMwaUg4WmNTWkdUWlpaV29vWVVVSWk4Rzhnb0dDeGlZWVVPbVZHN2lm?=
 =?utf-8?B?VUFobVB5cDM5K1ptdG5kcFFJUXd0aEJhNVFYanZKUkRIOFJKZUlweGZvWGxW?=
 =?utf-8?B?SVRwaEpvQk5nQmJTVCtPQ2RGZ0NnNWNiYWRaQzkyWmlpMzVzbThGZ3B6RFVX?=
 =?utf-8?B?UGxTOHJUSWFyeWZDSlZWSmtSM2Uwc3BEQ0dsM3hJS3J1S3FObTVvOW5sVzQz?=
 =?utf-8?B?YWRoekI0Wk40R1Z0Smh6VHpwZlRCRlBXc3BqQzgzZmZVYVd1ZXRtL3NHc0Jk?=
 =?utf-8?B?YWtqTEFtSHh2ODd6a29LYkpwSS9nUlQxU0xjdVA0c2JqUG9pT2VxMHloakNK?=
 =?utf-8?B?NnZmMTZXOGczQzBZLzhyWDNna1dmdWtXVUFaTlZnTHM5c3kvektGNEg5TG51?=
 =?utf-8?B?M2tieDF4dTBhUUJaRUJvQkNqcGkyMTJSYVl6eUpDNEZsbG42SCs0YWRNT3hp?=
 =?utf-8?B?UFQvVzJTTis5RnFEWE1WWjlSZVdFSFAwb0dLQkIvNlpUODdtdHFlT3JKeXhJ?=
 =?utf-8?B?cUN6em01SW5RQ0p2djM2NDR6UUxiQis2OGJGSHBzY3VURTZ2enhCT3Y0aDlC?=
 =?utf-8?B?aEZNeWdVTmlBK3hBUHBuWjRVSmRFZmJNWE40NVJ0RE9mc1IydUJmYlU5WitW?=
 =?utf-8?B?WVZKUXk4dUJGaE9tNUd1WmJ2ckN1V0VveVpqOGhXekxZeUxTcVRENWVFeVhr?=
 =?utf-8?B?V3dpSWZYajNPZWdZTkdpTWlta3RtK25uTTBpZENMUTU2NE9YeS80bE1uQi9D?=
 =?utf-8?B?SmFQdDQ3bUpRWmJwT3lKcVRFdEpHd1VwSHU3cXlBbnAraVBaR1NVQ2lSblVo?=
 =?utf-8?B?aVN4eXBTcmRHSHJNaFhITWpCeG81dFl0dE1VTUwraTc5SVBmTEFBMzR4eFJ1?=
 =?utf-8?B?bHZFYk1EZEYyaEVDTjlPUlBxN0ZhQmRRRms3YUdlZGpwTmVNMGp2UlJLS3h3?=
 =?utf-8?B?UVBhZzZJLy9XQ1FVVElVeHBVTzRBTHRPNXQwam92ZGFJaXlLQXp4TWxaMkxY?=
 =?utf-8?B?d1hGU1M1ck0yZkF4WVQxaXJaTlhjTGxXSTE1dUVwMVhzMmhmbC9JRk1yV0Yy?=
 =?utf-8?B?RDhWQThtL2xpT1E4aEt3OFBVcnU4bHJrVDBvVXpMM0RhSXNqSDdpcjVSVzFh?=
 =?utf-8?B?SWYyZDVLWUtBMExrcmQzdmJZYkhaN2c1VVR6SXUyWWVKNFE1Vit1dHdLcWF5?=
 =?utf-8?B?RTRaWUF2YkdtVGxHSVFTakRabXU4Y0lYOVMyMURmb3FrK1lPRVQvQ1NQZFpC?=
 =?utf-8?B?YWgzeEhPTjB0TjRNZ1NkVTZBeE1IMG9FelU3Qk8yYkRML3dwQ2RuTXJWdU43?=
 =?utf-8?B?ZFZPUS85bmw0dnc5cmFGWDlxbm5PbGlOdzJKTWhTSUk3clNXNTc4NW9NQWIy?=
 =?utf-8?B?MlJTR2JkQ0xiYkYrdE5LbXF2RkVERllYMzFZWCt2RFB3SlV3K0ZSeFJ1VTMz?=
 =?utf-8?B?ODA1bk45VERFZ2hiRXlWeFNJOUJLZ1AzTk9DSDJVMEZSYXNxWnlqalU4b0tP?=
 =?utf-8?B?K3RtZTFCb1VRK2l2K29abWdZZFpRWFl5d25GYmRURUlPbGxtTUJWWWpVem1a?=
 =?utf-8?B?bXcvR054UUd5WUVTNnlKUFAxdzdaa1NtN1BJSjJXWFFjY3h6eWp0TmdDS1A3?=
 =?utf-8?B?MWlybnExWTFMRytzeTVXNytOcFRNME42eU9wNk9xc3pQd05tNk42V0hhQm1L?=
 =?utf-8?B?dTl3YTBjbGxkYjUvMDdmV2NTNnlPdjl4Y09Ec2VrNXZZYW01amJOM3pZdWp6?=
 =?utf-8?B?YVAwSjFoV0FydDhMS0J0VWNWUmFDNVBtTXRnUEVKNnJ3R0N3RnJHNk42SEN0?=
 =?utf-8?B?eDA3ajdsQ0EzTkVhcXhBV0lsOU9vdk0rU0gwWmpnYzNnMHdBcjM0TXViZ2Yv?=
 =?utf-8?Q?pmu1iw0JdmpqlrD8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lS2x9ZIERkqgSn6Qc2Rfme6olSfFFxn2kmThqyIUm9Tyig3CNDNpPt1RwVWn7smwbBGJOzGfzCUuSOp27IHdik5xKs6rWV3ymJopLnDQSlVKAM6dlmNiDO3CJSy8X/IwO/YZdVRbsCsLTnoDX/jQ7pe8NGHKIbWh/d/7lgxquo77YLgktOmX9UtHTSiUFZKVZNxDUkmF1ReoboNIUri7zvoUg3oS177Awk4d+KM4Mj0dBehbim9Vu9HmZcBLy7DO0/CV06JdE98SmKBKqBbfyaW51ogywi/q2lMNh4w0K3qwNL6po5vnFnNYH1EUfdnz2mU2G/+qIrH7ce+ltJ6kWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34e8a58-dab4-497e-6b65-08de7f4687c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:16:43.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICks5v4abd3Mi47kJZ/Surb/+jNIrlILUiXV7SvcOuIRk0/oIphN5Js5Fof8QKa29fKfn+Kf31+5teG4Pxt9Lzf6o71UCRgFr4PD3RuzL9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8379
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D2FF225EE1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1079-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,dubeyko.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ4IFBNDQo+IFRv
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
bS5kZT4NCj4gQ2M6IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPjsgQWxleCBNYXJr
dXplDQo+IDxhbWFya3V6ZUByZWRoYXQuY29tPjsgVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBk
dWJleWtvLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDAzLzYxXSBj
ZXBoOiBQcmVmZXIgSVNfRVJSX09SX05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiAN
Cj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQg
YSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2Nj
aW5lbGxlLg0KPiANCj4gVG86IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPg0KPiBU
bzogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiBUbzogVmlhY2hlc2xhdiBE
dWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCj4gQ2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwu
b3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBmcy9jZXBoL2Rpci5j
ICB8IDIgKy0NCj4gIGZzL2NlcGgvc25hcC5jIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2Vw
aC9kaXIuYyBiL2ZzL2NlcGgvZGlyLmMgaW5kZXgNCj4gODZkN2FhNTk0ZWE5OTMzNWFmM2U5MWE5
NWMwYTQxOGZkYzFiOGE4YS4uOTM0MjUwNzQ4YWU0ZmQ0YzE0OGZkMjdiZGY5MQ0KPiAxNzUwNDdj
Mjg3N2QgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMvY2VwaC9kaXIu
Yw0KPiBAQCAtODg5LDcgKzg4OSw3IEBAIGludCBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZShz
dHJ1Y3QgaW5vZGUgKmRpciwNCj4gc3RydWN0IGRlbnRyeSAqZGVudHJ5KSAgew0KPiAgCXN0cnVj
dCBkZW50cnkgKnJlc3VsdCA9IGNlcGhfbG9va3VwKGRpciwgZGVudHJ5LCAwKTsNCj4gDQo+IC0J
aWYgKHJlc3VsdCAmJiAhSVNfRVJSKHJlc3VsdCkpIHsNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxM
KHJlc3VsdCkpIHsNCj4gIAkJLyoNCj4gIAkJICogV2UgY3JlYXRlZCB0aGUgaXRlbSwgdGhlbiBk
aWQgYSBsb29rdXAsIGFuZCBmb3VuZA0KPiAgCQkgKiBpdCB3YXMgYWxyZWFkeSBsaW5rZWQgdG8g
YW5vdGhlciBpbm9kZSB3ZSBhbHJlYWR5DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL3NuYXAuYyBi
L2ZzL2NlcGgvc25hcC5jIGluZGV4DQo+IDUyYjRjMjY4NGY5MjJiZmVkMzk1NTAzMTFlNzkzYmZl
MzYyMmNkMjYuLjUyOGFkNTgxYmUxNjA3MTNmOTE0MTYxMTU2NTkNCj4gZTJkYzZmMjU5NTc2IDEw
MDY0NA0KPiAtLS0gYS9mcy9jZXBoL3NuYXAuYw0KPiArKysgYi9mcy9jZXBoL3NuYXAuYw0KPiBA
QCAtOTAyLDcgKzkwMiw3IEBAIGludCBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKHN0cnVjdCBjZXBo
X21kc19jbGllbnQNCj4gKm1kc2MsDQo+ICBiYWQ6DQo+ICAJZXJyID0gLUVJTzsNCj4gIGZhaWw6
DQo+IC0JaWYgKHJlYWxtICYmICFJU19FUlIocmVhbG0pKQ0KPiArCWlmICghSVNfRVJSX09SX05V
TEwocmVhbG0pKQ0KPiAgCQljZXBoX3B1dF9zbmFwX3JlYWxtKG1kc2MsIHJlYWxtKTsNCj4gIAlp
ZiAoZmlyc3RfcmVhbG0pDQo+ICAJCWNlcGhfcHV0X3NuYXBfcmVhbG0obWRzYywgZmlyc3RfcmVh
bG0pOw0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlv
bm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

