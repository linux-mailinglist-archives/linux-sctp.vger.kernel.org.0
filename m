Return-Path: <linux-sctp+bounces-1092-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK2WAXg4sWmesgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1092-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:40:08 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97692260D87
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DBB03032062
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91B63DA5C7;
	Wed, 11 Mar 2026 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMPwwkUP"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D93CCFC3;
	Wed, 11 Mar 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221079; cv=fail; b=EvHF1ljjAUZNNujLtCCIav6ClGxr29AnM/HC1yfLFzbaiK/PljWHxt4xVp8LH3WQ5oV0gYGEuksdCAFIp9CIV2HZl+dQrZ67+yFF88PEcRIPz2fRxbnATAr17Vvdc9JBOcXCqc1NtEaHhzhRs1AerH/a2uBSQFylVJF40LxkK9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221079; c=relaxed/simple;
	bh=5RoLMOnUP13VcDZLe8DOkUtk65UsNylplQ/Hwrj5XX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omWDfu3wNxMridkanP2yLHa7QBkNLtVzuw8ENvOQULpIc9TT9yVNjIDxTpAT8y1fbiDm51UA0/kjQUW3yMGu4uda9YKmJAfSRmnqXYooenrFIw9CPsZmrBKIC1gYD1tYiUukM4oKmUXosU4jKQgi7kJw494e6q2sVHYlfVZVcIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMPwwkUP; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221071; x=1804757071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5RoLMOnUP13VcDZLe8DOkUtk65UsNylplQ/Hwrj5XX0=;
  b=gMPwwkUPUfjp4t546RfD6eWcLlJ4Rs54xEPM54GYFRMDpO7YoMt3NRQd
   4kBIfeFvAJ98wcYYEicXqKQFPqhdqwgPbapUtj6f2DHYqQrrNw9rawl5v
   2IrmJ8okEmA6hffzHPTzAB21iBmy0LSgd0+KnyLj3ddCEEp8pBGeaVXLn
   7eqbLas5Ni+HrsPbBngfvd+EMKYcGMFICufG59lM+mm243n7mq23mGrL/
   NNjpG/RqMGJUaVSy34g3RJWDa7q1K7MuEzsOrk1L3SQej8Nc8+EQVWJ57
   kaHJ0gqVEyT6GHlZm7UwtCdfz3SyT+lSWh7diUvtK5Gal8HKwsImwlYVj
   g==;
X-CSE-ConnectionGUID: oNCIRz3YS+a1Rmuf7Aiu6w==
X-CSE-MsgGUID: sRgxB+nxSLaTRP0KNij4Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74403625"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74403625"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:28 -0700
X-CSE-ConnectionGUID: XlPxWM9tSxuxy/R2m8bOgg==
X-CSE-MsgGUID: 1FQ9T3YETb+alF/y3zB6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220442344"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:24:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.54)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4+obR+DUr1NWwPV/opT2BKJh5cML7CR20tMRhNWdIVCWngUB6pzmViltafc4aDRm55nkHXh2TM7mR7st8u9tFZxfVU1SKXLojgWQRvGac+YzVyLh1OfdMQIvXqJq2VkW4MdAnl9kIwLIuTwxCRwVeKgvpcvYR0X/z54xlfkdT59fzK1+cv5NVOp0P3Ka/RX66j6C5Wo38YNKA9g6ojB7TSZbBTooYeaGaSF4EMhqyFemSb5To6PE+n/adJDL8MXy8Mo74eAOWKGvTwoyApFeVMBqYYpVNMqUAyLoZB1I8YufPsAmo1xHgKWaBtS2wGz37ilXKYdOgTuTIq5FeoSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RoLMOnUP13VcDZLe8DOkUtk65UsNylplQ/Hwrj5XX0=;
 b=C6pGgAvmJtyJbfm2PTOG3k6NJQdDzvUvhD74MCZldYycKj2miReiyKckyYPInfpA9uAeQ98ghwAPbTe2itQFk2LVevWtFM5tbBH9vrKUn6gKowICmRixlKTv/E4CchxfNN56c4dZ41mGzvLJJ/X3YGj/pBt9WE3jyqgDe9qDV8YBglbLiB371dkd9+hWLNu8kgvmETk3pQrB+oH4Snu+vgYsbu+pyu6dKmxVIpdnX5pnJvTKjsYE+sdZa6krSYFuplswmu+ig/d7lFbCuStKUhVx32hAtgqoW07tVVtB4t1Hx61H9GopyGe4KqWQVndSHrD1NghJz0swgoU8/0pQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:24:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:24:20 +0000
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
CC: Igor Russkikh <irusskikh@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan
	<mchan@broadcom.com>, Potnuri Bharat Teja <bharat@chelsio.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: RE: [Intel-wired-lan] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKD4Ry70gA6uk6MEWNBv9uR1rWpEF0g
Date: Wed, 11 Mar 2026 09:24:20 +0000
Message-ID: <IA3PR11MB8986CEEF7657B227DE50BB7CE547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 63193b5f-3977-438b-d8d6-08de7f4ff9e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: RgkrEof3rBWQFwe3FC5U4zx9z4zsXX197T2TnOA/LmSF1sXJiOcogItWd8nR52P67MFVsl294YF8lIK7qyuGP71/sFqcDuXC/PPs6sKebUAtadKRjL6erwv0g5zGPPBhMR+RiPTv18H0kLEnwNIZl4sZgRDSCBYPj+EVcZL4lqDWpjHJQv+ocpkZQX0f+C8+k5qmm/50uTUAJA2nXbNpWIf5ro+RwC5os6JQbBWXM8DuxIitv6eENm/ZwrV9DaSKm4LL4iQh95P0vV6On1lpP2N3O/jsLsYBBpDAe682AZv/YONWwDALs0CzkU9aVzMDzM/Lq2J3d8y0yJ+cuEoHTeOp6ChixF39mzZ9LYXxTs4qm005aEfANeh15vW9ljZ/s4jDYpb0sfnZ1zDvbx0nncPqc3wK4ENUrtaWG68vllsEsJeUWunovycH8UwPHu6NugbYZoFqbtjzFZSt0mjC6M+ao9DIurYQkhcQ+J/Tvr1HeFBYFlrgKkFBO3W7uBa2JCdk0ObImtjiwU91Chj7j5Z2MYnHnly19+MOB3RueyoXHhtxP0919zBkT8aqMsqlT6us5Z0Ud8GZjKr6KdnzBNQv+oC7/q0Uq6SFtz+h+SPxQV9LVE5x3VkNd14B3L3cVCaovzE27HT2HdRqFUFcbRkoQ7gvDFBN2qx+096pxYHUmCyhZ/peMsmjjtg0YKzxd5JYqpGx6B5wExqFVNAygcdlcMS4yY2Kg/cn9DZWE5Cxt5HQQLoifGZBhpyCl4DV3/79vhL/L2+lbem5ZF71pVBWKPZJCVKCLmjd5kpYALiNPBgbwHwazlKE7HI6g/BQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3JkMDYzeXV0aVc4VmVvV2MzYTNOZ2s1TTFUcUE1eU11azdybzVYaVZldzA5?=
 =?utf-8?B?aTBsdG5rcW8zNTc3Vm9yZXljV2ozUGQ1WXU1dTBzRDNQUmVrT2x3MCt5Rnhi?=
 =?utf-8?B?QzJpVmRkTzZaV251YkY0U2lsbmZFaFJJb2VzSHEzc3llckhSMU1WM1czYW1k?=
 =?utf-8?B?UVpKQXBBZU1OcnlYaHl0TUtIVmRuQlBqSVZDL2EwWnBtTEhVREl3U09xQjRJ?=
 =?utf-8?B?Z2M5L2pIVzlEalBVNG8wNjdiOXpSeE12UVdERjE3Q3paLy9GRG4waXhnZEp2?=
 =?utf-8?B?RUNXdDBHZm9NUkUvVWRYcGkrNkJPVGlyVWlFNTNHRCt5MzU2cy9uQTA1UkY4?=
 =?utf-8?B?OGtYTmNjL1k4U0tCTnI1R3hBV0R3TGI5UitLTmx4b1NqQkdBbStyQ2JHaWtv?=
 =?utf-8?B?WlFacy9yeTNyc3Q5bnlBdnVDUHFJK3VFZkJ5MFVyc2lWUlViSk41UENJYVlh?=
 =?utf-8?B?SndNUkx3WXdoVW9YNWJtQllmYmlOcEdvaTBXaE80UHY0QXBoRUZWdStBRFI3?=
 =?utf-8?B?VjNHOVMwMnMxSnRXMm9lVkl4RVBjWDF2YjFpa1JyR2srNHRGeFhrU1ZjVnVr?=
 =?utf-8?B?MklOcE5ic0IySFJCd1A0V2RaT2tyVnlHckxiNzRBam1OOWtPcmFnZVZIMWFF?=
 =?utf-8?B?YzVWSklMOFZMSUVDVndyOTFUNjNqZUJXb2hPRkpOOEJORzEvUkV4bHpyVlVD?=
 =?utf-8?B?ZENNM2RtcmVQa0JXTWxBZ2VmRzNNVUNGUlZiQnFWQVh0bk8zTEpMc1kwTUM0?=
 =?utf-8?B?a3JxS01PSER6N3FWQkJtUW44Mnc1YnZycktDZlFvR1dSNlpzUEQwbExuZ1Bt?=
 =?utf-8?B?NHAvRnlGMlQ5Qkd1Wll2SW1WeVh6clBsQW9CVUgzTkxlWlZvMHBUa0lxTUly?=
 =?utf-8?B?YWFpb09qN2dvRWVvOHN0Yk1lRHR1bkFLaXRyTWlsbHhHMHIrVUpScm5TcjFa?=
 =?utf-8?B?Sys3YU56SEdWVHV6WFJsTzBMRTI3WjNxYlNoRDRZdzJwc3FmczlwS2k5NGwr?=
 =?utf-8?B?R3E1VWdIY09wRkg3SW5OeGJhSzdQMVlTUUIxK2lnYjNoL21HSjlOanhjTWpP?=
 =?utf-8?B?Qll1eHBBdDU4cE9hVHk4ZzErZUo3d3lFenJxR1Q4WWNkWE9hUEZ1Q0RZcFdK?=
 =?utf-8?B?MEhiemtOVWlEZHhtM3puV2NWenJCZnFzRFBncmNRSUZ2TEFXQnJiOTU5ODcv?=
 =?utf-8?B?Wkx2T1c2NHlOcHFUOU5US2ZxT1k2eWxxbkFidzlwYzBZZTB2ZTVxaTU3MUtN?=
 =?utf-8?B?VnZVV3hMdVVObkVuUjVmVWphMHFBWVRyM2tyL3lYajlEcHU3VXhPeWswWTRF?=
 =?utf-8?B?MGhmcDNmR1pDazV6VkNZUFNlbzEzSUE1ak5QMEQrVHR6cG5XdkV0S0h6T1B3?=
 =?utf-8?B?a2hWTVJkTlUyT3hTTk1Ga3dSQmZQajhOM0dydjN5aDIwZkNBS3B4VFduYzdT?=
 =?utf-8?B?TFl0WW5rOUJnbDArWXhqa1h6ZmtKdjB6Rm5jUFMyT09CcC9RUUZvaTU3d0Ry?=
 =?utf-8?B?LzkvUWF3azVVTTVXZ0hIcmJYblJYMEVRVXRudGFmSmx1WUdreVd6SDZ2djdC?=
 =?utf-8?B?eHdlVW5FMW8ycG9aclRtbWVvZ25jam4yMVZjMTJIK2hCbUphUHlMcWE4ZkNr?=
 =?utf-8?B?cU9XT2pPY3hoR25YZ3dKd3RaWlZoRnh4U25IVGZqeVY0Y1B0ajlRQk9WNEE1?=
 =?utf-8?B?QnloMHVkakZtMlpJT1RvS0tMWngyNWpkS2FES3M1WEYwNllMWGQ4MDlXY2NS?=
 =?utf-8?B?azkvMnluYThyeHJVRWFTUnd6ZGVPbEhpTFkvRTA4VmRNSTUvVUV0WFFTb1dO?=
 =?utf-8?B?SkMzMHlKNHMvSDg4dHozVHJWRy95VzZvVXdUNGxtbzlRL3pIOXlkMEFtZDVh?=
 =?utf-8?B?NTNoL21iUEwvUmMrdlFETitnNXpDTFRUWWpycVhuZ2FkYXlnU05KTUY4RTdN?=
 =?utf-8?B?aU5qckxrdHpMV0w2S2d1ZWFHaUx1Ukl0c1pPYnl5aGF1VTNhc25pRWNkdHFp?=
 =?utf-8?B?Z1BHT3BMYUhDSDdoa0xUUmRRMm1obXd4Mm9ZM3BNRG1VdGVSUjdETWNycnRm?=
 =?utf-8?B?YnF2Vjg4dW9TTHZGSVVUdXVwcGN4MEg0akI4U0JkZUJYTnZYQTd4SkNtMldV?=
 =?utf-8?B?eVROOFV0M2ZiaHZkK3VZRmRVajlnYTVQU0R4ck82WjUzcXdOVkp3bnhaQXRG?=
 =?utf-8?B?S0krUW81ZFk4d0FGK1U5eXN5YlpTUHljMS9nQmpreFRlbnUyTGpka3YyOGdx?=
 =?utf-8?B?K1pSbk1PNTBhR0tFUG4rVFV5ZW9hSHpGU3N3NTB2aEQxK3FabVR0MEEzMGhr?=
 =?utf-8?B?b2E1UWYxSDN0OXhJMm1MVFFkYmtXUVRYQ2tuT3FVWW1KZGVyeUphSkdwOTZi?=
 =?utf-8?Q?K9umCgd0L7xEFc8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AZwS5pzkS+D5Nh73DvJfKXwuNk8Q81jLKYf4KuXrdEmDElrdoxJ+RlB+KWtM7wBvtd/MjpDS+6pYLjB91TmVt2v7YoFVhC+4LQOcaCl3kFKvfqv1G50mfIYQj+zvxnsvkiVqdqGR+A4iKK5R03s1w99lvqOxzMW5/XKRmNy42GRnrIX2KKXfqo0DvAd7afvfpqs52iNZEwtUVP0QgFnHh5/hZO/pbwtSLXxGiM3Rlz3gm3Iv4xq5EWCAdEmkK6dOW8woUoYZJDeMWl34IyVmn3FFU/HDabQdc+z4aSa69sViJAk3qSCF0RJPn5JsT9Ujhy65+16jwkfK+TXolw3DeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63193b5f-3977-438b-d8d6-08de7f4ff9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:24:20.4139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTSSA+Jgtyl80MXGEpHEOtktlwsSjBf7+eCeufNAQo7CS/YqBWskpsPW8wBpAkjRhMREhc3ZLbJuxK9CE9E6oAGpyKAGYr0bqoL3MzzO7CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 97692260D87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1092-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,chelsio.com,intel.com,plvision.eu,gmail.com,foss.st.com,os.amperecomputing.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
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
bS5kZT4NCj4gQ2M6IElnb3IgUnVzc2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT47IEFuZHJl
dyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVt
QGRhdmVtbG9mdC5uZXQ+OyBFcmljDQo+IER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBK
YWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8NCj4gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPjsgUGF2YW4gQ2hlYmJpIDxwYXZhbi5jaGViYmlAYnJvYWRjb20uY29tPjsNCj4g
TWljaGFlbCBDaGFuIDxtY2hhbkBicm9hZGNvbS5jb20+OyBQb3RudXJpIEJoYXJhdCBUZWphDQo+
IDxiaGFyYXRAY2hlbHNpby5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXll
bkBpbnRlbC5jb20+Ow0KPiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxA
aW50ZWwuY29tPjsgVGFyYXMgQ2hvcm55aQ0KPiA8dGFyYXMuY2hvcm55aUBwbHZpc2lvbi5ldT47
IE1heGltZSBDb3F1ZWxpbg0KPiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IEFsZXhhbmRy
ZSBUb3JndWUNCj4gPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20+OyBJeWFwcGFuIFN1YnJh
bWFuaWFuDQo+IDxpeWFwcGFuQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBLZXl1ciBDaHVkZ2Fy
DQo+IDxrZXl1ckBvcy5hbXBlcmVjb21wdXRpbmcuY29tPjsgUXVhbiBOZ3V5ZW4NCj4gPHF1YW5A
b3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFp
bC5jb20+Ow0KPiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDM4LzYxXSBuZXQ6IFByZWZlciBJU19FUlJfT1Jf
TlVMTA0KPiBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcgSVNfRVJS
X09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+IGNoZWNr
Lg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBUbzogSWdv
ciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPg0KPiBUbzogQW5kcmV3IEx1bm4gPGFu
ZHJldytuZXRkZXZAbHVubi5jaD4NCj4gVG86ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZl
bWxvZnQubmV0Pg0KPiBUbzogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBU
bzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4NCj4gVG86IFBhb2xvIEFiZW5pIDxw
YWJlbmlAcmVkaGF0LmNvbT4NCj4gVG86IFBhdmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2Fk
Y29tLmNvbT4NCj4gVG86IE1pY2hhZWwgQ2hhbiA8bWNoYW5AYnJvYWRjb20uY29tPg0KPiBUbzog
UG90bnVyaSBCaGFyYXQgVGVqYSA8YmhhcmF0QGNoZWxzaW8uY29tPg0KPiBUbzogVG9ueSBOZ3V5
ZW4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPg0KPiBUbzogUHJ6ZW1layBLaXRzemVsIDxw
cnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiBUbzogVGFyYXMgQ2hvcm55aSA8dGFyYXMu
Y2hvcm55aUBwbHZpc2lvbi5ldT4NCj4gVG86IE1heGltZSBDb3F1ZWxpbiA8bWNvcXVlbGluLnN0
bTMyQGdtYWlsLmNvbT4NCj4gVG86IEFsZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVA
Zm9zcy5zdC5jb20+DQo+IFRvOiBJeWFwcGFuIFN1YnJhbWFuaWFuIDxpeWFwcGFuQG9zLmFtcGVy
ZWNvbXB1dGluZy5jb20+DQo+IFRvOiBLZXl1ciBDaHVkZ2FyIDxrZXl1ckBvcy5hbXBlcmVjb21w
dXRpbmcuY29tPg0KPiBUbzogUXVhbiBOZ3V5ZW4gPHF1YW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNv
bT4NCj4gVG86IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+IFRvOiBS
dXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGludGVs
LXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBsaW51eC1zdG0zMkBzdC1tZC1tYWls
bWFuLnN0b3JtcmVwbHkuY29tDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcCBIYWhuIDxwaGFobi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0
aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYyAgICAgICAgfCAyICstDQo+ICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90ZzMuYyAgICAgICAgICAgICAgICAgICAgIHwgMiAr
LQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIu
YyAgICB8IDMgKy0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvZGV2bGluay9k
ZXZsaW5rLmMgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9w
cmVzdGVyYS9wcmVzdGVyYV9yb3V0ZXIuYyB8IDIgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL25l
dC9tZGlvL21kaW8teGdlbmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAg
ZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDIgKy0NCj4gIDggZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFu
dGljL2FxX3JpbmcuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGlj
L2FxX3JpbmcuYw0KPiBpbmRleA0KPiBlMjcwMzI3ZTQ3ZmQ4MDRjYzhlZTVjZmQ1M2VkMWI5OTNj
OTU1YzQxLi40M2VkZWYzNWM0YjFmZjYwNmIyZjE1MTlhMDdmDQo+IGFkNGM5YTk5MGFkNCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYXF1YW50aWEvYXRsYW50aWMvYXFfcmlu
Zy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3Jp
bmcuYw0KPiBAQCAtODEwLDcgKzgxMCw3IEBAIHN0YXRpYyBpbnQgX19hcV9yaW5nX3hkcF9jbGVh
bihzdHJ1Y3QgYXFfcmluZ19zDQo+ICpyeF9yaW5nLA0KPiAgCQl9DQo+IA0KPiAgCQlza2IgPSBh
cV94ZHBfcnVuX3Byb2coYXFfbmljLCAmeGRwLCByeF9yaW5nLCBidWZmKTsNCj4gLQkJaWYgKElT
X0VSUihza2IpIHx8ICFza2IpDQo+ICsJCWlmIChJU19FUlJfT1JfTlVMTChza2IpKQ0KPiAgCQkJ
Y29udGludWU7DQo+IA0KPiAgCQlpZiAocHRwX2h3dHN0YW1wX2xlbiA+IDApDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90ZzMuYw0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2Jyb2FkY29tL3RnMy5jDQo+IGluZGV4DQo+IDIzMjhmY2UzMzY0NDdlYjRhNzk2
ZjkzMDBjY2MwYWI1MzZmZjBhMzUuLjhlZDc5ZjM0ZjAzZDgxMTg0ZGNjMTJlNmVhZmYNCj4gMDA5
Y2I4Zjc3NTZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90
ZzMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS90ZzMuYw0KPiBAQCAt
Nzk0Myw3ICs3OTQzLDcgQEAgc3RhdGljIGludCB0ZzNfdHNvX2J1ZyhzdHJ1Y3QgdGczICp0cCwg
c3RydWN0DQo+IHRnM19uYXBpICp0bmFwaSwNCj4gDQo+ICAJc2VncyA9IHNrYl9nc29fc2VnbWVu
dChza2IsIHRwLT5kZXYtPmZlYXR1cmVzICYNCj4gIAkJCQkgICAgfihORVRJRl9GX1RTTyB8IE5F
VElGX0ZfVFNPNikpOw0KPiAtCWlmIChJU19FUlIoc2VncykgfHwgIXNlZ3MpIHsNCj4gKwlpZiAo
SVNfRVJSX09SX05VTEwoc2VncykpIHsNCj4gIAkJdG5hcGktPnR4X2Ryb3BwZWQrKzsNCj4gIAkJ
Z290byB0ZzNfdHNvX2J1Z19lbmQ7DQo+ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIuYw0KPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2NoZWxzaW8vY3hnYjQvY3hnYjRfdGNfZmxvd2VyLmMNCj4gaW5kZXgNCj4gMzMw
N2U1MDQyNjgxOTA4N2FkOTg1MTc4YzRhNTM4M2YxNmI4ZTdiNC4uMWM4YTY0NDVkNGIyZTM1MzVk
OGYxYjc5MDhkZA0KPiAwMmQ4ZGQyZjIzZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2NoZWxzaW8vY3hnYjQvY3hnYjRfdGNfZmxvd2VyLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIuYw0KPiBAQCAtMTAzMiw4
ICsxMDMyLDcgQEAgc3RhdGljIHZvaWQgY2hfZmxvd2VyX3N0YXRzX2hhbmRsZXIoc3RydWN0DQo+
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCWRvIHsNCj4gIAkJcmhhc2h0YWJsZV93YWxrX3N0YXJ0
KCZpdGVyKTsNCj4gDQo+IC0JCXdoaWxlICgoZmxvd2VyX2VudHJ5ID0gcmhhc2h0YWJsZV93YWxr
X25leHQoJml0ZXIpKSAmJg0KPiAtCQkgICAgICAgIUlTX0VSUihmbG93ZXJfZW50cnkpKSB7DQo+
ICsJCXdoaWxlICghSVNfRVJSX09SX05VTEwoKGZsb3dlcl9lbnRyeSA9DQo+IHJoYXNodGFibGVf
d2Fsa19uZXh0KCZpdGVyKSkpKQ0KPiArew0KPiAgCQkJcmV0ID0gY3hnYjRfZ2V0X2ZpbHRlcl9j
b3VudGVycyhhZGFwLT5wb3J0WzBdLA0KPiAgCQkJCQkJCWZsb3dlcl9lbnRyeS0NCj4gPmZpbHRl
cl9pZCwNCj4gIAkJCQkJCQkmcGFja2V0cywgJmJ5dGVzLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2bGluay5jDQo+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2bGluay5jDQo+IGluZGV4DQo+IDZjNzJi
ZDE1ZGI2ZDc1YTFkNGZhMDRlZjhmZWZiZDI2ZmI2ZTg0YmQuLjNkMDhiOTE4N2ZkNzZjYTMxOThh
ZjI4MTExYjYNCj4gZjFjMTc2NWVhMDFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvZGV2bGluay9kZXZsaW5rLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2bGluay5jDQo+IEBAIC03OTEsNyArNzkxLDcgQEAg
c3RhdGljIHZvaWQgaWNlX3RyYXZlcnNlX3R4X3RyZWUoc3RydWN0IGRldmxpbmsNCj4gKmRldmxp
bmssIHN0cnVjdCBpY2Vfc2NoZWRfbm9kZQ0KPiAgCQkJCQkJICBub2RlLT5wYXJlbnQtPnJhdGVf
bm9kZSk7DQo+ICAJfQ0KPiANCj4gLQlpZiAocmF0ZV9ub2RlICYmICFJU19FUlIocmF0ZV9ub2Rl
KSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHJhdGVfbm9kZSkpDQo+ICAJCW5vZGUtPnJhdGVf
bm9kZSA9IHJhdGVfbm9kZTsNCj4gDQo+ICB0cmF2ZXJzZV9jaGlsZHJlbjoNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJlc3RlcmFfcm91dGVy
LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3Jv
dXRlci5jDQo+IGluZGV4DQo+IGIwMzZiMTczYTMwOGI1Zjk5NGFkODUzOGViMDEwZmEyNzE5Njk4
OGMuLjQ0OTI5MzhlOGEzZGE5MWQzMmVmZThkNDVjY2INCj4gZTJlYjQzN2MwZTQ5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3Jv
dXRlci5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJlc3RlcmEvcHJl
c3RlcmFfcm91dGVyLmMNCj4gQEAgLTEwNjEsNyArMTA2MSw3IEBAIHN0YXRpYyB2b2lkIF9fcHJl
c3RlcmFfa19hcmJfaHdfc3RhdGVfdXBkKHN0cnVjdA0KPiBwcmVzdGVyYV9zd2l0Y2ggKnN3LA0K
PiAgCQluID0gTlVMTDsNCj4gIAl9DQo+IA0KPiAtCWlmICghSVNfRVJSKG4pICYmIG4pIHsNCj4g
KwlpZiAoIUlTX0VSUl9PUl9OVUxMKG4pKSB7DQo+ICAJCW5laWdoX2V2ZW50X3NlbmQobiwgTlVM
TCk7DQo+ICAJCW5laWdoX3JlbGVhc2Uobik7DQo+ICAJfSBlbHNlIHsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+IGluZGV4
DQo+IDY4MjdjOTliZGU4YzIyZGI0MmIzNjNkMmQzNmFkNmYyNjA3NWVkNTAuLjM1NmE0ZTljZTA0
YjFmY2Y4Nzg2ZDcyNzRkMzENCj4gYWNlNDA0YmUyY2Y2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4gQEAgLTEyNzUs
NyArMTI3NSw3IEBAIHN0YXRpYyBpbnQgc3RtbWFjX2luaXRfcGh5KHN0cnVjdCBuZXRfZGV2aWNl
DQo+ICpkZXYpDQo+ICAJLyogU29tZSBEVCBiaW5kaW5ncyBkbyBub3Qgc2V0LXVwIHRoZSBQSFkg
aGFuZGxlLiBMZXQncyB0cnkgdG8NCj4gIAkgKiBtYW51YWxseSBwYXJzZSBpdA0KPiAgCSAqLw0K
PiAtCWlmICghcGh5X2Z3bm9kZSB8fCBJU19FUlIocGh5X2Z3bm9kZSkpIHsNCj4gKwlpZiAoSVNf
RVJSX09SX05VTEwocGh5X2Z3bm9kZSkpIHsNCj4gIAkJaW50IGFkZHIgPSBwcml2LT5wbGF0LT5w
aHlfYWRkcjsNCj4gIAkJc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldjsNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9tZGlvL21kaW8teGdlbmUuYyBiL2RyaXZlcnMvbmV0L21kaW8vbWRp
by0NCj4geGdlbmUuYyBpbmRleA0KPiBhOGY5MWE0YjdmZWQwOTI3ZWUxNGU0MDgwMDBjZDNhMmJm
YjliMDlhLi4wOWIzMGI1NjMyOTVjNjA4NWRjMTM1OGFjMzYxDQo+IDMwMWU1Y2Y2YjJhOCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvbWRpby9tZGlvLXhnZW5lLmMNCj4gKysrIGIvZHJpdmVy
cy9uZXQvbWRpby9tZGlvLXhnZW5lLmMNCj4gQEAgLTI2NSw3ICsyNjUsNyBAQCBzdHJ1Y3QgcGh5
X2RldmljZSAqeGdlbmVfZW5ldF9waHlfcmVnaXN0ZXIoc3RydWN0DQo+IG1paV9idXMgKmJ1cywg
aW50IHBoeV9hZGRyKQ0KPiAgCXN0cnVjdCBwaHlfZGV2aWNlICpwaHlfZGV2Ow0KPiANCj4gIAlw
aHlfZGV2ID0gZ2V0X3BoeV9kZXZpY2UoYnVzLCBwaHlfYWRkciwgZmFsc2UpOw0KPiAtCWlmICgh
cGh5X2RldiB8fCBJU19FUlIocGh5X2RldikpDQo+ICsJaWYgKElTX0VSUl9PUl9OVUxMKHBoeV9k
ZXYpKQ0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gDQo+ICAJaWYgKHBoeV9kZXZpY2VfcmVnaXN0ZXIo
cGh5X2RldikpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2IvcjgxNTIuYyBiL2RyaXZl
cnMvbmV0L3VzYi9yODE1Mi5jIGluZGV4DQo+IDBjODNiYmJlYTJlN2MzMjJlZTYzMzk4OTNlMjgx
MjM3NjYzYmQzYWUuLjczZjE3ZWJkN2Q0MDAwN2VlYzUwMDRmODg3YTQNCj4gNjI0OWRlZmQyOGFi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC91c2IvcjgxNTIuYw0KPiArKysgYi9kcml2ZXJz
L25ldC91c2IvcjgxNTIuYw0KPiBAQCAtMjIxOCw3ICsyMjE4LDcgQEAgc3RhdGljIHZvaWQgcjgx
NTJfY3N1bV93b3JrYXJvdW5kKHN0cnVjdCByODE1Mg0KPiAqdHAsIHN0cnVjdCBza19idWZmICpz
a2IsDQo+IA0KPiAgCQlmZWF0dXJlcyAmPSB+KE5FVElGX0ZfU0cgfCBORVRJRl9GX0lQVjZfQ1NV
TSB8DQo+IE5FVElGX0ZfVFNPNik7DQo+ICAJCXNlZ3MgPSBza2JfZ3NvX3NlZ21lbnQoc2tiLCBm
ZWF0dXJlcyk7DQo+IC0JCWlmIChJU19FUlIoc2VncykgfHwgIXNlZ3MpDQo+ICsJCWlmIChJU19F
UlJfT1JfTlVMTChzZWdzKSkNCj4gIAkJCWdvdG8gZHJvcDsNCj4gDQo+ICAJCV9fc2tiX3F1ZXVl
X2hlYWRfaW5pdCgmc2VnX2xpc3QpOw0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5
OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

