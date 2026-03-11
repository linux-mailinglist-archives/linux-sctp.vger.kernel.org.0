Return-Path: <linux-sctp+bounces-1094-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ/FMRw5sWkLswIAu9opvQ
	(envelope-from <linux-sctp+bounces-1094-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:42:52 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70564260FC7
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8170533658D4
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCCA3DE433;
	Wed, 11 Mar 2026 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACNPngzu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906633CEBA5;
	Wed, 11 Mar 2026 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221150; cv=fail; b=r5NQHAIpvZPCskl5E7/yr4qeeIOBn17/z+rRirVyanL8fWlz3O9/sJnJJXeDuBSeqSybA4VTbtv+5WM9+s1KkTJakxMTgw2jjiETjMXnvchidmUDMV1WT+tMovrZw5gDrE8DkDWDTXbu3GgpS5Iq+yHDqoGvtnOfFXsUls3KrH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221150; c=relaxed/simple;
	bh=6tbQO6yGCv8N8ouulw89rMIOzkRWnTreTX8yvsT+jIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l9NmxZVJtiRuzL21Uy5S68EaKQvLiu8f3Mo2afUBY7yaucyGYjO7VqeSsPgEZW5RCgyCEUe10xTAJfrVH75b8vcT8u7igUUviSxA7LlkWg4qpxFKL2czB8MAavqAnXASG3ha/c7qDt4za5/FzGv+DUuG/C9uuD34psXj/8Q0rbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACNPngzu; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221146; x=1804757146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6tbQO6yGCv8N8ouulw89rMIOzkRWnTreTX8yvsT+jIw=;
  b=ACNPngzuQ9I6KU7xhL+zNFzSQJgdhzL3dCtpJxzJbUD+ENLZqecxQmJk
   KA2IwRHtN0QwWaVod2Rwk8ExxIyY28T8Cu2BoblUazpTjfx0P66iMXhBM
   G1HLSe8KyJhdBea0LcNn0vjocLv8lySv/WI7GvTSm+NIfDJkcUM8a68xm
   1/LV8mq5bB6KyoJfCzTA9xUyKa02zj5JeuAzZTauJ1PXyplPq+/xNaPn4
   MeXSxAaRKogxu/Fw97fQNV7jhKV07qoh9bMsFiNBwwGaiWsMyzIyh9myM
   RXB5dtsI3aX4mFtyVKaC3v/1dWvDoIimuzGHg9eRCGzLkXqr9Jgd968O5
   w==;
X-CSE-ConnectionGUID: q2nkwFW2QQejXO9td8HyoQ==
X-CSE-MsgGUID: 7XPKlCzlQjmSzr2Iivud8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91665675"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91665675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:25:44 -0700
X-CSE-ConnectionGUID: SeyEpxAdRfKJdobfw95FZg==
X-CSE-MsgGUID: +WNep8C1RFOCCFDhvBjEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216680976"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:25:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:25:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:25:41 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gW7OiJ/Vub6V5xTra/ISXVlXWhIT515YR6o9UWl/udHMC20jLQvrj8nFa/PS8DIIepyiaCG7xOVGsr8BbAXQBGQt1qn6UEPw2rOBw5w+E+IycMaBKlFzJ0MvVbxEI2I/zxUSZCJMfWE3Cc6RT/WW2yJsVR5BrEZcNknypHx9j/UtdK3k3oenT1hqvwXBbVnu8pgyD4zskIfel6K9+2y+QtBUHq/E2D0Nq8/0zbw0L0TVoofcWxetLyTwuv98sbQbRasji7oAFF5McjHGNBpPPXGRBZ6jobvKU7DVFLqYXgd7hypEb3zqU6Lx5p9q8NklQfZ8D1ts/7Mj85MVkzbaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tbQO6yGCv8N8ouulw89rMIOzkRWnTreTX8yvsT+jIw=;
 b=I3Thht5AdfSZtHdfajJ7eIVunnxE5CRvAwCbGR56ueiIf41wcbjW+t2KkXE/dbaJEEKCaiVddoATrP10ijwVcfOBsHecxOvNpl+NBL/f4CshphkIFQ/Fy3VZzqa/+x2AfDCHe8D6GgjyIQBujr5VNcYw3UQ09ZWLk52OVHIy61cUmBn1r6EShc3SBcjP+k4XxKUsR8Go1HpE0AQLlxpNcTsgLcv5z+C0FIsM09dHPG8BtEIgyqg3PAjPZPq56EMV92VbRknBrPTpe0c0lJRqoNrqaL0lGEk+qujM8+SGOrA8HRGCl8w8tVm5r+sdoRD/Y50jFsrNNJTk2QHw0dlmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:25:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:25:32 +0000
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
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [Intel-wired-lan] [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKJzVlY0YaDH1UWzLB4DgG1n+LWpELCQ
Date: Wed, 11 Mar 2026 09:25:32 +0000
Message-ID: <IA3PR11MB8986D7F17B8E72F94006F48EE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 90d04f78-f9a8-4250-9905-08de7f5024c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: PSa5Y/PRV2m/kBT405RyAaoUJSX5xxpx3lXjof6vmQpQmRNVaVIATI8WjW50wiW5w9NTDPVVyaNBrQ7GCG8kuJz4NzT9+GWO58CZB/MdOrAvvlxH1/wqcUH+UbgPV+WOfNbdLrCQK2qG2X0Hha3IOjShHNNIcCITQlMaE04JBDrstdeeBgFUwl/imZDKfAoLOX0iTzyxjZmfMCgg8ZjSplg6uJ3X4pZdna1n53VyS7k4r8JFU0z26QeggH6qVfEi5j2YZ8NWkMH8cjNYaYYaHFPchGvS3j547P5kmjcvcDN0jvjGZkOczaBz+ZOcloldMjJcdUl+V6jze/Z1+Txs/Bl1IamV0Y+i1TcMzNJms/9izJCqv5lalfuD5eINGmiIDrSSeND6V0ZUV09j+ZByyu3fmIZHUE200vw84Kj+vrBaWPzqXZfM/LzwAHGXNJ4pt9OpvXxqhwLopyo01OE3zLCZyf7tvGdt/tvvnZka/gZ4vanhaNBS4sSMtyYRSYbkkfAZ6Rtbtnlr3JBixVkWbLaslCvPzUWkJ8VAqRwMDTvCO4yMsDe5FWvQAFZpU0CMQKJlnGcD6Ar6qUx0KSjfJf2d9QPi2VC/AcilJSteFrdEdjJnD79WBYeeT2+AlBimbEDh3vw9eydSvxZXqwzkd3d5qalNQhocxZYvg6swL2YwkVmIrqLM2wR4fnX1l4owl+/UcnQcZUdiss+ftKZOPLdPuEBmEy5WzKNok4xpdncbA9Qw8W6wGIHot5EaqQWnMpN7u9S2DQ0iwsCf/dM95INa6yxB7kaztB5gh5XjcuEfZWTyqw34mZOkj4N6KU5Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9nY0o2RGxpeXRncjZMZVM4QjBOL3NMSWc3Kzh1SGllL2IyTHoxU2c4ZEc4?=
 =?utf-8?B?eVlpalJqaUV2d1lESHdwNFV5blUrVlBlQUtoQlNXV0ZQeFFUTDVVaEVpd3hG?=
 =?utf-8?B?c1V1Q3BiR0djZzc5WVJkM1lnWmgvbW9uNU9xQlkvYTQ4bkJreVkycXF5RUEx?=
 =?utf-8?B?VFZQNGRiWmowMHhTWGQrcWdtdTMvQnkyVFd3S1BqMmZJMVh3YzAzRGo2dnpZ?=
 =?utf-8?B?R3JhOWhQWm50TWVCd1prY3B5VTlGblcyUU42NkRxWWlEVy9JbG92NHgweVZC?=
 =?utf-8?B?YkhRKzJ2RzQrUC9MMmE5YzF4U3hJQmdteFF5eDZXUWtacDd2djg5R3laMUoy?=
 =?utf-8?B?WWNQZXRlQ1gxeGVEa3VMNmpJODNEZEVYUzFqYkRLMmtuOE1lRXE0WndLWFdT?=
 =?utf-8?B?eDdNMU9tOGtKREdGYUo2eGNyYy9ERG1WdTVDMCt3STQyYmdrZldjQ2tKZlZW?=
 =?utf-8?B?RmVLQnRFUVpneUdRd1h6b0NidG5PaGpjZEdaV2VJNi9NZkpvbWNKM3hzVitD?=
 =?utf-8?B?V3ROVy9ydFZLY204YkxXWTdpQVNPNTVJQk0wMDEzQiswa25RYVB2T0J5dVhq?=
 =?utf-8?B?bk5OOUV6ajdIQk5jRFRSMW9Cc2UwbVpvY25BL2lBRWpRVmIvTWErQTJzcC82?=
 =?utf-8?B?Qmp3YmJGT1FDVk8xK1kwV1FUZGdCRkNBREJKb3JRc2toMWFBRnlVZzBZcHBi?=
 =?utf-8?B?QlQ0YnUyeVZpMEFxdm8xakhlSm5sL0lxRkN5akRVMThDREdzMy9OV0RNZ1lE?=
 =?utf-8?B?Z0lpQnZVdTJ1eXdPVXJZN0xUUjBRSE5kSXcwK3RnK3J0WitQbitMNysyMHhv?=
 =?utf-8?B?bGFPSlU0TFdWUWkwVFNVSXlxUHc1dTNEVzYyMmxYYm5sdmlaNXFyYnVsdE44?=
 =?utf-8?B?ZmhQeG0xSlo3THZMRVlYUGZPSWVtQ3ZySjB4SkVQdUxNWHNrdGE2TkdneEwy?=
 =?utf-8?B?YTY0WmV0N1hSU3FOQmhIeXd3aUwvUkhrK3JLdUIvaEtXYW5OVWNNUzdldzNU?=
 =?utf-8?B?V1ZabjgwcEtFTWlhSnNTbGIwWURHM1BvUCtqWVY4Q2Y5NlcwWWR2MXhsUDVF?=
 =?utf-8?B?Vjk3Y2JCRUR0M2hOdVVUK0VRSXpxbTRnRWEwUnA4aU83bW1FdjJOMjg0YUMy?=
 =?utf-8?B?TWI3SmdQa3E3cGNRV3RCL09GeU1JSEZ0aGdaOFZFL0d0cGlZeCtlQTJoWUkv?=
 =?utf-8?B?aHh5ZTNCaitGZmhYTk1XQ1o5Lys2R290QWRsd1F4RDhkWjduSnFCbG5mU1Va?=
 =?utf-8?B?THVRSkpGU0VnNTByNkZjZStUZW9OSUxYTWJ4dFZML2tNWXFqVHFiOXBqbFMw?=
 =?utf-8?B?d3lzK0dMSU5IZlplUk1PL2NGSmR6UU9TcE1vanVTZU1qVGc2aGdZT1VQemRh?=
 =?utf-8?B?Y1l4V0NFZnR2L0xmTlh3UnRVVTQySEJvSVdUVGRiSGFXaTB1M3NieldUUjlz?=
 =?utf-8?B?RE93N2x3SjZjVjZZOW5DTUZnMWpaaXRpVHFFTFV4Yy8wVnU2bWdUQzFnYisr?=
 =?utf-8?B?VWt0ZXJoalpLU2F2ZWh2OXZnTXQyc2txMWFLOG9JNGNUempsUlo5NE9WQWho?=
 =?utf-8?B?VllNOXJSYlFJWUJoclkzRTBZeVNxemE2MU1VRXFIeGFNU0FRTlNyb0Rucm5U?=
 =?utf-8?B?V1IwS24yNWtBOFR1M3labWh5QXpnbFNUT2o3bEV4MnprbzFvc1FWb1J2Wll5?=
 =?utf-8?B?anFnUVJxdWhEY0JRaUtOazF2NFBPSGt3QXhnd1k1MUpaSExtUFFoZ1hEWi85?=
 =?utf-8?B?RkxMRCszRi81OFpMNWlUTDNGY2owbkVDOUk4Z0w5bk1RMnNkTGE0MGN1N3hj?=
 =?utf-8?B?NkJOV29hVDN6RjVhVldRd2N2UTAwN1ZVbDhSTktnMEk3Zk43ZHZYdmsyTG5q?=
 =?utf-8?B?WVJHYXczOVlTREVNcklZS0FoUzkzRjdOdTB1RDZQckNVdnYzMFl4TWZVY0lB?=
 =?utf-8?B?SVZWYi8yMGNJbkpHWkhaY0RIZnZXdXpBam55UktHd2wwSFZZbktGQTh0MkF4?=
 =?utf-8?B?RUN3RDU5WTNZd1dTVVRnb3hMd1pucTBMd3YrMXRLWXVXZXZNOEFXL1NKUWZs?=
 =?utf-8?B?RTZuVWUxWDZzbWRsWWRHWTNmOGtDb0QvdWFUbndSWUVrR3VaQ1Q1WSt5NitK?=
 =?utf-8?B?U01ZMExwMjYxRFlObXJ6WGxnVWVXbXlrdmtndWVHbGlVQjJPUUdHS2J4TDNu?=
 =?utf-8?B?K1VMakM5Q2l3MXJXdjVkc01GQ284TDZmTzVaa2NFV1UwNUZ2U2c1eDBZY3g4?=
 =?utf-8?B?ZUlSNGpnWG12Mkl6NmhNS3hsOFg4bG1PLzY2WjZFME5MRGF0ZU5QTUIwT0dw?=
 =?utf-8?B?NUUyTlhEQWNDRi9ZcXZQMmxraW8rS1kzRU9iaEJwT241cUEzTkdySVNleGlT?=
 =?utf-8?Q?4Jl7dbELKf/NIoBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qxLMk7b7Z4VaRlU/blG3DwPF+9DSKvWLDG8L40xgYD2idsB68FPTpw82p42vVz1K/Okj4Ka3poKyal4FgGaFj4PRs9ridMbhEqcd2D7L5JEhE2WoaPdMSB5ZRZmdP/VDOVzgrQH4dfjtDnh5HS4SOleEwdh81jcCnm7Io3RyAY3SQq7jAgWjySlw5s5slQEbvkrsakuI+Hk5bGu1lmwS6nBqU4zmHNQAitzVitGNZE1Tvw1aSdHfIOdt1eQnCH8+Wj5VlCgajHkzCxzBYiPnfaynRjrVdAgn52jYlQNVQ/whbFgnJ1idVgszD7bR/hDb5v5wBqgV+zJ5F7EPLGAuTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d04f78-f9a8-4250-9905-08de7f5024c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:25:32.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1pvfJK+0PL7J+YO35gTM9aZY86krg7i/7eFOzQKqaNkODxRVunAAG46KrZVxBvpu4/YFbLZrR5XM6UINBHaOiQshgEsxK66oYYWbE1iQ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 70564260FC7
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
	TAGGED_FROM(0.00)[bounces-1094-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[55];
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
bS5kZT4NCj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleEBzaGF6Ym90Lm9yZz4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDQ2LzYxXSB2ZmlvOiBQcmVmZXIgSVNfRVJSX09S
X05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VS
Ul9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVj
ay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IEFs
ZXggV2lsbGlhbXNvbiA8YWxleEBzaGF6Ym90Lm9yZz4NCj4gQ2M6IGt2bUB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcCBIYWhuIDxwaGFobi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvdmZpby92
ZmlvX21haW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby92ZmlvX21haW4uYyBi
L2RyaXZlcnMvdmZpby92ZmlvX21haW4uYyBpbmRleA0KPiA3NDI0Nzc1NDZiMTVkNGRiYWY5ZWJj
ZmIyZTY3NjI3ZGI3MTUyMWUwLi5kNzE5MjJkZmRlNTg4NTk2NzM5OGRlZGRlYzNlDQo+IDllMDRi
MDVhZGZlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy92ZmlvL3ZmaW9fbWFpbi5jDQo+ICsrKyBi
L2RyaXZlcnMvdmZpby92ZmlvX21haW4uYw0KPiBAQCAtOTIzLDcgKzkyMyw3IEBAIHZmaW9faW9j
dGxfZGV2aWNlX2ZlYXR1cmVfbWlnX2RldmljZV9zdGF0ZShzdHJ1Y3QNCj4gdmZpb19kZXZpY2Ug
KmRldmljZSwNCj4gDQo+ICAJLyogSGFuZGxlIHRoZSBWRklPX0RFVklDRV9GRUFUVVJFX1NFVCAq
Lw0KPiAgCWZpbHAgPSBkZXZpY2UtPm1pZ19vcHMtPm1pZ3JhdGlvbl9zZXRfc3RhdGUoZGV2aWNl
LA0KPiBtaWcuZGV2aWNlX3N0YXRlKTsNCj4gLQlpZiAoSVNfRVJSKGZpbHApIHx8ICFmaWxwKQ0K
PiArCWlmIChJU19FUlJfT1JfTlVMTChmaWxwKSkNCj4gIAkJZ290byBvdXRfY29weTsNCj4gDQo+
ICAJcmV0dXJuIHZmaW9faW9jdF9taWdfcmV0dXJuX2ZkKGZpbHAsIGFyZywgJm1pZyk7DQo+IA0K
PiAtLQ0KPiAyLjQzLjANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtz
YW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

