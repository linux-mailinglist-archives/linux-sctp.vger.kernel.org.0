Return-Path: <linux-sctp+bounces-1093-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E8zNMA4sWkLswIAu9opvQ
	(envelope-from <linux-sctp+bounces-1093-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:41:20 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A4260E6A
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71149349A24C
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE5E3DCDBA;
	Wed, 11 Mar 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsYUZply"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7683DC4D3;
	Wed, 11 Mar 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221098; cv=fail; b=tFlHipksnHuT8lP8SWUSuEhoJO3KfZqfferQzv/NSm85Ff/qgPLtbVJe0oywpoAlAtO1MuQ2ogdH4hRR5u/2bOK2zd0J9uwUZZTVGx62P3E5tEsTnSb+GNwBLoqsQVkMciFXI5Xo4XMyLssm4nhWJDvp2II33V30vLSYKFqgPlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221098; c=relaxed/simple;
	bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iySPD5JNUQGPktbsk5E9xjln2uMj4t4P+L0WuBYIea6808Y+ymD304eZWDABQ4qv+x2TEtqC7X14Dd6g5Uqf3aNMd7tAwecnZzqNrql24N/H14S7LP/BzACGj7TXDwqgiuYLSVXl8qZJgqLHpmg7lUitlJQZbjBjucLk2jwlRn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsYUZply; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221091; x=1804757091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
  b=RsYUZply6Hp6uWOrPIcv7+drS8RfTSKdY9ZIeWyW4WjDOBI719kp4NSV
   VHlNr5JOLvFkvNVpZ1olmMAo5qm6uRPFQfVBEpSm5AO5+SLuhJ3S0Squf
   UmYj+Jv16DykzoRIjRduGUqATFx1xykJh9TsHA2P5V2JgziKQ0bjpr9eT
   tWKIKCyfcCMHWzCsVfk6H+ieLUIzm6XTFkO2gNKy8f4r87ZVYS+V8V2C1
   C4dqB//GX7UONRzQD1avT1gdTCA/MJpvuoTZ5VFL3sQF+/uYW1SUq9T4i
   UOaS48vBlk33Hptb6deGgkWSjhJSZj5Q5aG6zRQFJnkKnSBwhF2ss28Xd
   A==;
X-CSE-ConnectionGUID: tCkPN6ApS5eMh9UABzgR7Q==
X-CSE-MsgGUID: pdWTGw4gQlOyrDxqeACuYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="96899628"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="96899628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:49 -0700
X-CSE-ConnectionGUID: +pNzCQuOS4iMOvUIOsAbbw==
X-CSE-MsgGUID: ihZy0IpkRxC1aXJmO8GjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220354338"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:24:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:24:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrGF6ysw3NLbFbz7lvDpDsZA34MAFk8M6PmU/DB+YGblIv+vOpJHUfRNdxOGGNT97eD/VPAXQl6832UdgZIlyco/xQ5N7yqkEP9715RZLzDgG2OCQPVM+c8qhUDQWzgNsSequTQ/0cGZBLotpTJdsw9XPPcvYJbc0W/0U13cjZxpsUs2+iBxSyLsO2jhJcZEEjEL65O/vlhdF4hOnb5V1YAhiiT08wChIxU/eWp8kLyw258X03oaDE2sw0J+vrdDo4X/jkMcyBQztWprdJH2K0PDhP9zDkx6cSSXKQUxpYrXJiioXIfZNZKg4X2+ZpjZTJceRSMn8YfckCdPx2uUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WnYjaq9zqroKxNH1/RH2NWPVjerKMwSwnhWZn9wJdw=;
 b=fEMQ+ysMnPe2j7XVEXA7acz6fhMjQ0kXtpbPix/u4OCeSl+jsMwiaXRncu292Ubnorn0DFmHj2r5fbLBS0tMaktq3yLpK67Yz9MZZksKW8cMKWP2/48/oi0Qbs1/78nwAKQS7KbhAgoKszGdIsSEhsdgPE9oY5UL743qCUq3eDsvPGV3dDzXTaPgUrK8YyzNp3FSP4nEk8xs+4aJ3mC+Sh4E6VtTKOLz5Ii7TYM+65aXFKGenEDpdLjLIqzCmHlJv9WyB2CBoB7Psd0bEnvWvBHO4Wd/YCGFEyQWVmLhMz/4VAlbZ0SuEW9Ka72ut/ucLp+5aLw47WUReY3sBQQFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:24:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:24:44 +0000
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
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Andrew
 Lunn" <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH 39/61] irqchip: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 39/61] irqchip: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKg9oKg4QUhq0yGHO8ZtUkDV7WpEHiA
Date: Wed, 11 Mar 2026 09:24:44 +0000
Message-ID: <IA3PR11MB898641F143E155B8A8069936E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-39-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-39-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 16e59c4a-c185-4674-e460-08de7f500851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: LSUZ060yA0zdkbfhlg7l9aVdcvsKojcvgwO3ACL3uZZlR/qzeqERV2DVHgMJwbPfqhu267UPDQzRLLv7X3d5RlS0JuOXDVxA9cm+WkkbMcCMMheQlIRAxrIktgbdkZESGhzlWgTbxl3Y/2gbbusycFgS0wjI5+GRZk26YjYST+YF3Cf7sBqIA7aduza3XxbWyGcS8eF9T0W6BRyf+jBN1IZ6mJ32KyDEwAPdnPfUMlrC6tr31AmtIuls+sW7d/tUscX6/XESWrivRoE+PBho0thaAsRLRKrhOV8qU1PPKRjY2iir7g48IrNLqDT5DRAQ22iTqJdt8cGwK7uoPrGBJxj7AULdq2IvwrtQYg0czy/oFGIJdrjEQvGAtmcVTPGkXmGkbNgRdgWIkvoA1lDlUMS2gALwKxiZh5PaAoX0JATl8b1EIr/ePZ+RXmc7HRRcAyUJ5ox0P84CR6ikaSNaIp/RQ4sOh2bGTfYI0V7N0JrWkAeVpHuGwS3+iRzCtLtXVMUvpcaKx6LgNt188r1ZN8p6Z9Jk/GFeOvJMqGFFsPLMwq0PebF4kfJt1gig815Ylf75pPpjL7O1ZPprsvGkgvnNM0uthucVJu6SuavLnsBH1QDfOy2BvuUqNHav1UU2sT7fQim8hOf8teLWQRN0nYSPrHNTDWP0c0PT2XpNnKCcpTYwz/bMUzACKZyfACaLP3dQ7r/lBBVithoKBQjk7PboSYKfrJ57BzzWTh1xwFMIbeKazCXevxZqhONUzLz3eAC5P0eeaEgZOsJ2yvUmoXihSND0r6uoToI7OcCqnrmC56cOaRHUHi+Q5fLAMXSS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmxSbWQwaUx5d3JubkVjM2tDUXZmaTdpNVNzYmdmbGhTdGRURTRxUjZPTFRL?=
 =?utf-8?B?QXVIejBEOFpaU0pHRXorVHBNR0c1dVV3Q0xBU2huK2VyNXBITU5IZU5vbHlI?=
 =?utf-8?B?UzdwS1BYVFhUUE1qRCtlK3JGZHN0bW5mNWNTdTVrTmhkWUlKTXJ6ZWlzcVlw?=
 =?utf-8?B?ZFFDYjZLaWFTeXhOYTA3SXpwWGVHVmZNcWZsQkUwZjhRa3BwbzFqWEdSQXA5?=
 =?utf-8?B?SndrMStaUmg1dFExejJqckFtNDBIOURJclI3MmVLOC85MGpETlBYWXU1MmJn?=
 =?utf-8?B?UjNTM0VUNEVkeHB4NlI0MENVSDlsclloMytKcERNVDczWjMzZHZTRjJtQ1pP?=
 =?utf-8?B?WTYwMVRsWXNLeDR4MWJxR0tqcmQ5OW1OTms2QXhScFdLQkgwRllnU2hIZWNC?=
 =?utf-8?B?dkl2TTcxbWJlRVBrWHRxaldyamNaTFgxdUF1Y2x1VmNTcVBVZEZvL25Gd2tm?=
 =?utf-8?B?V1Eybi9KOVJKZHIveW1kMVNmeUNVa3NpeDd4VURsRkRnSUZUN3p1SXQ1anhK?=
 =?utf-8?B?eVdDTTRNUUg3czYvK0lzUGFQcENCUEt6bGl6MENEalJ3aDFGaWlRVzRUMnRX?=
 =?utf-8?B?MEV6NmRseUFpYTdHL3FqYW41VWc1S3BYZEtkSGxTUkdZNEhBTXkwSkRSWVhr?=
 =?utf-8?B?enJSZ3V3VmJTa2gyWTdFVkdtcGpoTEVBSHB3Z2pUeFZ2M2IySDhTUTN4djUz?=
 =?utf-8?B?NUtscEVXM2Z3bFY2RGp2cGdpTXh4TG0rZmhhVDNLbGcrMFJ3dlUwSzlGYTQz?=
 =?utf-8?B?NEVxenZ4Wmt3TGdDalhRdWxSaFVVUWNaZUN2UlFZTFhFU1BPTFZhYlM1eHIv?=
 =?utf-8?B?YnVNbFFSYkRFaUZBcXpodHhnWldmRkUzUDVvQjVSZUlIb3FmOGw3UUM0TEgx?=
 =?utf-8?B?MFh2RGEyVHg3OVFhSE53OFhLakxqOHV2cGpJeHJVSXlLQXJBZUV3SFlMcHR2?=
 =?utf-8?B?OHZ2cmdKaGRvMUMvZHlmdklZUktUbk1FUFdoQk5YVENHS1pVN0VPRWp0Z214?=
 =?utf-8?B?Z1RYOEpJcHB3aXRXZ3I0cllMVVpRUk5xWTdXNXdpL0p1NTlCQnA5N1FRWDJ3?=
 =?utf-8?B?cnJoZGhrdm9MSFF3d1VlTlJzOVE5V0srdW8yd1o5RWdyRk5FYml5dUU3RWxK?=
 =?utf-8?B?TllLMW1nNVdXRytaYk5JWlVkKzdwbGdTRDhQYTdOTVpPRTh0Q0xzdkRsTmFm?=
 =?utf-8?B?WkJVUzhuWUNhRmZZZllKdzNvVWQwT203RTQrcVFHb0RSRHY5R0k4MEZZOC9l?=
 =?utf-8?B?dGlVbDEyMXFMbmZkYjNvcDdaR0JXODhaZ1hhYktwRytrT3VlM3NGbEdoSlZl?=
 =?utf-8?B?a2c5amkxTWlYV1c3K0tneUt6b0h6MUVMN1l0SG1mQXlRYWJiQXlJcUpZSTZG?=
 =?utf-8?B?MkRHdld0SDhDZUJ6Z0RIQURaNTdCbkNQdDJLWWR4clZuODBFSWg1QlNNdTlF?=
 =?utf-8?B?VHE1aGlCb1BMR3pxeFN1bTFaTmpnOHZnY3R2RWtmeEg2cjc5blgyT1czdGJw?=
 =?utf-8?B?UVdFbVB3Z1JwYnV0b1NidDkvZHZUUGp2dzQ0Z3RJRFVQUytJL1Jyb00raU5z?=
 =?utf-8?B?Wnlya3pMSW85ei9lbFJPNWE5U29vc08xUTY2b0psWnlrS1JZYWxUM0JvU3pX?=
 =?utf-8?B?d1NNSzhpcVFqV3RBZFhlZEQ4ODJlL2VyY3JaQzFibWxXVFI3TzZlZFlYbHVU?=
 =?utf-8?B?ZXVVUFhvYkFHdnRtUDJpdmRUZHh3SnFyNDZNd2FHUS9QNnRlSjRQbUNGNmJZ?=
 =?utf-8?B?N3QwaGN5a0lPQXJ3UmtHQmdXdFRQcVlSN21GUy96UGViTlBlNnZ4ak50dktI?=
 =?utf-8?B?UzhNbEZkVmJVb1BBY2lYbHJqQ2E0eDZhL3kvMFpXajVjSjVKaFByUHp6R1VW?=
 =?utf-8?B?QU1CaC9jUzdGL1IvaGNSMW5vbytyQ1RDeFZSVm5zT2ZkRmNFekpEZ1hkWWpG?=
 =?utf-8?B?bUFDK0xkd3Fld2laTHcra0srNUJabTMzdmV2bFZZbit6UXIveVp4djVsYkw0?=
 =?utf-8?B?YUd0M3J3RXdmSkpVSzhFKzB5bGRnRkxNVmR5RGFjWDErWFdCa1h5anljc1Q4?=
 =?utf-8?B?dzFwWlNFYitCTitjSTl0dVFpeitZV3BjMTdpanFTaEVocTFrbU1nTHZrZ1NV?=
 =?utf-8?B?VjNZMEtjK3BWTld2cjlmSlBOSjV5cG1kRnNSNW9peUpLT1dQaVlJRU9tU2NB?=
 =?utf-8?B?Z2RzRmM5YW9LcnNPZ0hWd3M1cnNwRXNzOEJrOW9MZXF3Q3ZHRTU5TXFhTVJj?=
 =?utf-8?B?NUNoVWZ2bXB3MmZ5U0tNRER0ZEMxZUY2dElmZDN5Y2UySzJTczgrdVFUVFpt?=
 =?utf-8?B?YWgrRlljbFVJZWI2UGtjSWVJcnEyYitUQ1c0R2NMQW4rQzZNQXkzUU5yT3p3?=
 =?utf-8?Q?EvJdgRAwpMEvFYGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zf8elrkojfQdHLplxPSo4yK9pOgnQPMMprHUKo82JkQvl86yNTT6u7FAqvRzYBNdLnuPysxlVmp8BstvFqQDqny1cWRhAcdoxkdIDAaCWkbh77LFjBUgp1P5ILvzqgKv76QMGIEOh1HCHFDMNpA6qp6fjlUNhGD4z0Xuil3d/pUjxQZg/3YpD7F/p0nRjF86T2yIY3G/pKQ7VqTDdvTi73RoDCb8vNdc6V/1zzPvjfuZV2K1E+0W4p1UNIHK0+vefUDENNd8FZMhHxLc8ThB/MIuhK32ckKHzwIfbK/qurKFCa8fafTrKq8nMw4io2MAQKvogLpLBhp4MU1Nvqflcw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e59c4a-c185-4674-e460-08de7f500851
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:24:44.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzVMZJlgYUyNW1d1n7aK2gDj2On6Yp4tdJvWL75v0WwQK8k+SncwWDB0auqqFg+FHOhWsQ/6XA7hgcstAFc1oOtOHcR/GJGawyNNy64hpBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 784A4260E6A
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
	TAGGED_FROM(0.00)[bounces-1093-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,bootlin.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
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
bS5kZT4NCj4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAa2VybmVsLm9yZz47DQo+IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47IEdy
ZWdvcnkgQ2xlbWVudA0KPiA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPjsgU2ViYXN0aWFu
IEhlc3NlbGJhcnRoDQo+IDxzZWJhc3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tPg0KPiBTdWJq
ZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggMzkvNjFdIGlycWNoaXA6IFByZWZlcg0KPiBJ
U19FUlJfT1JfTlVMTCBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IA0KPiBQcmVmZXIgdXNpbmcg
SVNfRVJSX09SX05VTEwoKSBvdmVyIHVzaW5nIElTX0VSUigpIGFuZCBhIG1hbnVhbCBOVUxMDQo+
IGNoZWNrLg0KPiANCj4gQ2hhbmdlIGdlbmVyYXRlZCB3aXRoIGNvY2NpbmVsbGUuDQo+IA0KPiBU
bzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gVG86IFRob21hcyBHbGVpeG5lciA8
dGdseEBrZXJuZWwub3JnPg0KPiBUbzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPiBU
bzogR3JlZ29yeSBDbGVtZW50IDxncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+DQo+IFRvOiBT
ZWJhc3RpYW4gSGVzc2VsYmFydGggPHNlYmFzdGlhbi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+DQo+
IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFo
bi1vc3NAYXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMgICAg
IHwgMiArLQ0KPiAgZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1vZG1pLmMgfCAyICstDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12My5jIGIvZHJpdmVycy9pcnFjaGlw
L2lycS1naWMtDQo+IHYzLmMgaW5kZXgNCj4gMjBmMTNiNjg2YWIyMmZhZjcyMmRkMmIyNGZhZjk2
YWY2MzZhNGJiZC4uNmRjOTgyNzM1N2EyMWFlMDVkZDgzOGZiNzE3OA0KPiA3MWM3M2YzYzc1NjIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLmMNCj4gKysrIGIvZHJp
dmVycy9pcnFjaGlwL2lycS1naWMtdjMuYw0KPiBAQCAtMjI1Miw3ICsyMjUyLDcgQEAgc3RhdGlj
IGludCBfX2luaXQgZ2ljX29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlDQo+ICpub2RlLCBzdHJ1
Y3QgZGV2aWNlX25vZGUgKnBhcmUNCj4gDQo+ICBvdXRfdW5tYXBfcmRpc3Q6DQo+ICAJZm9yIChp
ID0gMDsgaSA8IG5yX3JlZGlzdF9yZWdpb25zOyBpKyspDQo+IC0JCWlmIChyZGlzdF9yZWdzW2ld
LnJlZGlzdF9iYXNlICYmDQo+ICFJU19FUlIocmRpc3RfcmVnc1tpXS5yZWRpc3RfYmFzZSkpDQo+
ICsJCWlmICghSVNfRVJSX09SX05VTEwocmRpc3RfcmVnc1tpXS5yZWRpc3RfYmFzZSkpDQo+ICAJ
CQlpb3VubWFwKHJkaXN0X3JlZ3NbaV0ucmVkaXN0X2Jhc2UpOw0KPiAgCWtmcmVlKHJkaXN0X3Jl
Z3MpOw0KPiAgb3V0X3VubWFwX2Rpc3Q6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAv
aXJxLW12ZWJ1LW9kbWkuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtDQo+IG12ZWJ1LW9kbWkuYw0K
PiBpbmRleA0KPiBiOTlhYjlkY2MxNGIzYmE5ODI4NzZjZjU1MjU0OTlkMDJiYzFjOTk3Li45NGU3
ZWRhNDZlODE4MzNjZmUwNDc5YjZmYWJiDQo+IGE3MTViZjRlZjZiOCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1vZG1pLmMNCj4gKysrIGIvZHJpdmVycy9pcnFjaGlw
L2lycS1tdmVidS1vZG1pLmMNCj4gQEAgLTIxNyw3ICsyMTcsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCBtdmVidV9vZG1pX2luaXQoc3RydWN0DQo+IGRldmljZV9ub2RlICpub2RlLA0KPiAgCWZvciAo
aSA9IDA7IGkgPCBvZG1pc19jb3VudDsgaSsrKSB7DQo+ICAJCXN0cnVjdCBvZG1pX2RhdGEgKm9k
bWkgPSAmb2RtaXNbaV07DQo+IA0KPiAtCQlpZiAob2RtaS0+YmFzZSAmJiAhSVNfRVJSKG9kbWkt
PmJhc2UpKQ0KPiArCQlpZiAoIUlTX0VSUl9PUl9OVUxMKG9kbWktPmJhc2UpKQ0KPiAgCQkJaW91
bm1hcChvZG1pc1tpXS5iYXNlKTsNCj4gIAl9DQo+ICAJYml0bWFwX2ZyZWUob2RtaXNfYm0pOw0K
PiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxh
bGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==

