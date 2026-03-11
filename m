Return-Path: <linux-sctp+bounces-1086-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e638J+07sWmAswIAu9opvQ
	(envelope-from <linux-sctp+bounces-1086-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:54:53 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C74261615
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5EFC328EF72
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D373C8729;
	Wed, 11 Mar 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cunJSnsZ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B73C555C;
	Wed, 11 Mar 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220707; cv=fail; b=A62Rv/DXTJhXOyA7QtQxsfK4IkB8P6/vtlCPDMG1cK+MP3iwj+Fk4TkzDc0SsZnWz/oQPX0H1ApUOj8YnZ+5BoxMOdBvZRAY+JOvGhs4C1O8n+9aa9FyyObCBXHLkDGLTMMWzp2NebqXR4udZewgROWbXqTRsUvme2f+TMH3qFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220707; c=relaxed/simple;
	bh=0XsUbJr6kXjuRtF79qpmNM/wiiW/pKARuseo0u1QYd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICiHEul5XXiu7H35lVkUfTnulxzEiGYRSovYeyy/eU/YAZ5T+QPOzB574ga8c07I7INT8Aga7GKxJDvuyfLxlx5Rf/xJlpWwsFdUIJwRbunWDEntrjrJiU+T8YNOgoYDkVDe0+XwRyys4Jw4xRlULqDWYvuvVhJMFvJEbDCcwgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cunJSnsZ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220704; x=1804756704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0XsUbJr6kXjuRtF79qpmNM/wiiW/pKARuseo0u1QYd8=;
  b=cunJSnsZ/KezWTnwZ6zBeWli56uEtChfZ2xd/hqjeIK2Bp8fKwmO1ZF+
   heVSi4qAvBfWj8qNXIeO/sdlH78NQx9xIWaoX92G0DSo6ODaLbk7n473M
   f9amZtctQqORvyU/Lf/cj8yiXFUze8c9u2Zv0VNuhOYXabnhT3c6e8mTy
   sG43hCC7wxPmv+xF8ijBah3xBqNTd8Ou2NaMWFplNjO1mlea2K9rS0QnT
   ymjbZgadKcDGqnRtCS7t0w2q2o9qCts40Q+1C+pjd2qXmfn0wZPicxYUT
   SWYutogXiKOsys5s+o48JVR7Cjj0/Q1aSzEs4P5Nbxj4WHtR0vqxn3UDq
   Q==;
X-CSE-ConnectionGUID: CaYX27JGTqirGqTXRCVssQ==
X-CSE-MsgGUID: m4xyLOJMRc+m2YnjjxDssA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85760289"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85760289"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:18:21 -0700
X-CSE-ConnectionGUID: NxX1EamFQoSh3UJDpM+/Ww==
X-CSE-MsgGUID: 5wb7UjhrQfKGhvEcabKrWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="246008064"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:18:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:18:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:18:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsYEUMbMx92ijibRhLQ26uX2yxPGs/SUR4PcurcOQ5pNmZhCvqJk5Ch1dFYWtyxJ4MQdvguy0bSe9+V5bBFSueJhX8mDTAHJnQK1MEdfypKs4x4BIr1nxNlA7j3a1DXg0z2h17f57XjWQOh7PXQC5S5KaEOo3tAOsfbvDkSuHl1dqYTepdLTV99YzhH8dH7vTEE+yfQV2miN9oNLKOoKixNLd+jhHJtXTQQv1t+xvxq+2QUyJrCbC/C4G+jWJwWpknuAiC6bLCI1GUFGT9kHprHBzvp+0gFZykIcpxa/pHCahmS6f6PLMJMN2XXTPehHOEGYF7chIxaIgxK6z+N7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XsUbJr6kXjuRtF79qpmNM/wiiW/pKARuseo0u1QYd8=;
 b=nfQm4LD3rfqjcMm8IXRBbICNV/eGeNvcCgh+69CMNjZlV00JNMUAdsmflN1TB/K+BeigwnzXT/6P6nSUC1w4HUCU6dEWCnsNkZhUL9zzaU3rqMvS6zIIluyYHF5dVHOq558kQFJVULWxoR7nLPZi5kCjEVkW1QiWd26zrQfn2CihzeOG/xxrc7iWsR0/7cTgTPiV37RZmSx06hvnDfwENDa/U+WKa97sVIOzFw9n5p1JLi88WhgKXu8WT35FplAYGAs3AeYm5tsns/p6TWXpJlFGNjuXANdlFIsy4T8CpcFNQKZrFDZWefDmTT1x/PlXN5moI1O4FxotN85Le9Wq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:18:09 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:18:09 +0000
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
CC: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: RE: [Intel-wired-lan] [PATCH 17/61] module: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 17/61] module: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKJ4ahF7LOyphUCOzd4K1MYbJrWpDp9A
Date: Wed, 11 Mar 2026 09:18:09 +0000
Message-ID: <IA3PR11MB8986803ADA5C966425D0F3B7E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: a0eb66c5-988e-4cc9-7dd7-08de7f4f1cb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: RgrtkBu9FG9L9sCO49CaTRTJ32/k1uT7Vp/mptuRJFzCoDh3TQ9NG7bf0bXkMi2xccdgkStOkh0vwl4um0sQogTjIXDe8yD0OE5QpgJ42utIQqqB2ydvB28HOGt38wvAsAnV2Lk1fO8tSUmjk6zngmzbhPcd3ZVAo27Uu+94qfC0kNEfh7kaFpwRp6Ng1Bh86P04nyp/gdyzpavqW53Byx3nGpRPB3ApyG8dZAgWIyN7kjYCnHTYS01ilbzNDdviC//RzaJ2cOKfC11KOcMG5zXw/c8dRZ9n14s8J+quGYT6KCoA057tXwJOO8HyvOOweeuVPz7lIVLHvyFVVAo0ue0/92hNvrF2hI3k5ZeTHAWbF8vf/tkd7/J9YJkc9iCSSS74oxpwIYUK5xRDMbfKy8tTTmovDhHZWXBCAJqdFCHdG8IMDRJjG1wigv/22OYN+fHO0jGJEXX/FgPPT3RFatemNKlc6VNyXY8XSxnX422zGIR2qu1NVNFQPIpxzdfgMCAuxZvEimcqxWb3V7/i+Ocd6c9rpn/HiU0/k17qY+Ts1uq0a+nhocbv1Ldi5sAZy7zuz0hpXHlWX/mIGLjzAMRPx0vKw96fdNm1atGgCEk4rSIdXkU0sNWKrVFwxmpSFJS/QnYEtm28SL631PPCtXk6iQjA43IL4ROGUUY4LISCaf7ufSY45PV+joZEhKDpqcG+dbqOICScgdZe2NUlML9mVlQxrlv2DB1GB1/RDNKKspUvHOKX0i8nWCgiZWEGy/m/94ex0nfXTkZzceSxr4Io4JevvUzlcd06ptKODaAUjsB6B+mDvSx7L/JtE0Z8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T092MjlLSjhJdk9KcmRSVVVpUkdGdzBjckZZQzMxakY1NGoxYm9BU0xkZ3li?=
 =?utf-8?B?b25Ec0pYei9PWko0dERLRVprWGwzYjFySTFxemUxVEIzcjllSVJyS3lxajRF?=
 =?utf-8?B?MlpldmdWeko2RmxSL24ya3ErZ2RKME94NENvbVUrbDJKbEVwMlpIWXdvalNC?=
 =?utf-8?B?djVGcndEYk5OMGszaUJIVnMzWUdieCt4RUYxSWx0ODNrK3podXovSk1MM0pN?=
 =?utf-8?B?ZEJEVEV6VFFPZmFuZC92N2w4bHlYK09LcEdLNGcraE13dTJIMHl1MkpxQWMr?=
 =?utf-8?B?YUhTVzcvK01xazEyV05TNkUrT01vbU44RVo4Wkd6WUNqWmp4eGUzanFPQ3Rv?=
 =?utf-8?B?cDhmZzlZVnVMMmU5R2ZoaTZzZ3EzZThIOFhwakttSEFzRmlBU2RCT0E3L3ZD?=
 =?utf-8?B?dVA3U2VTRkdFUkF3bWVYb04yR0NmZDV2ZU1OV055NStaU1hNaE45YVhmNkVE?=
 =?utf-8?B?WFdZb2Rkb1NSTkxERmplK3FUMFdyM2RaNUNJaVpndW9uZURmb1NQcjBEZ3Zq?=
 =?utf-8?B?WnlGMkMxd1lkbzdhMVNTS2twZm5VenlWKzgzQVNyY2xDMnFtTnR3OVYrT0Yz?=
 =?utf-8?B?ZWZGR3JkWTI3SnJEb3diWFVqZ1ZPOTM4NlpwWU5mQ3BMaU1xZG1WV0hoVTJ5?=
 =?utf-8?B?bUozQ0xtVTduZy9nbjh5TU5ZRlZ6ZWtRbmpqaGFaTXp3OTI0L2Z0Y2FpUmpx?=
 =?utf-8?B?Vnl3MWcvVm5EYmo0RkRYcUZKZG94YzdNUFZ4UEU5WUhtdGNFRFZnU1hXVXpG?=
 =?utf-8?B?bjJteFQzb0VhdkgySGtuY3crYmdXQUtvd3FUclhWcjVVdk9lOStSY2FSVzcv?=
 =?utf-8?B?MDFneEpob0FyamE2QWcxZUFKQVIyNVIrOFdsL2RIMmlaWk0wVjgrbzdGOUZG?=
 =?utf-8?B?SCtaLytXc0dkcHpGZW44cnRZRWZSSURkdnIvUHpkK2gyN0FLRC9oSytKK2x6?=
 =?utf-8?B?ODdtQ1RVcGZUdWJiNUFxbkFQUGxSY3VJUDg4N1Ryd01aS3ozRHNBclJCaDBW?=
 =?utf-8?B?MCtJU0c3MDNxTTZjUHZpTUZJaGpMQWpvZk5uSlNNYndTNmsxRmlsVDZDcFJq?=
 =?utf-8?B?MTA1TVpvSnlnVGJocjN6U1dVdm1GeVU0U1drVWJsSmFITnFodnRvVUI4aklE?=
 =?utf-8?B?Rmw1N3NnS3JscTY5ckdyc2dlSnJxNXl4TmR6bE9HRHBpMG9ZZ1E2R3UxZ1Bi?=
 =?utf-8?B?UHkwbkZOTDh4a1pGM3hLNkd3OEw3bjczZjl6bU5SenM5UWE1LzVteHo4RkZx?=
 =?utf-8?B?eTB2R2ZVNVI0Wnk0eGR3b3V1S3RGaW8wYU1pSE1RTWRzTmJCclRhRTF6WmNx?=
 =?utf-8?B?bkU3YTZ3RXhpMFQ2cjU1bUZXd0ZDM05VVkhuOElmQjBva016QVlHakhwOHg5?=
 =?utf-8?B?TzRFYWNNUUJuVlNCTU80NGVPLys5RXNwVDBFN1M0QjNkS1pTSzNTdkFjK3Qz?=
 =?utf-8?B?VFAwVS9tZGNRZjV5cHNmVlZLcHFhc1orNU02Tk5MSUV4UnlvMHEzODNsZzha?=
 =?utf-8?B?V2NmQlZYNFBHb2ZCU2I1MVh4SGROdXFWamozMXhpUmtYM080dWlNRGo3R3p6?=
 =?utf-8?B?VXM4OVI0b3VkMmUrVHNWNlZFNFpQSjVVRlJUYlZxZVl6cExVMFIwNGViZ3lO?=
 =?utf-8?B?Z2NQdVZzczZEUDNpTkVhT09WT1lmTlh0SFJacE1GSkF1ZUQrL092dktZcnFY?=
 =?utf-8?B?MnBkdzF0U1ptc2lXWCtySWtibmJ0NTAzM3FhenByYWUrN1k3a2JOSk9JakRD?=
 =?utf-8?B?MWlITlNubmFudTluaC9QamVzc0EyQXVvNjY2SGNTL0RpM1FuejJzZjhUK0VY?=
 =?utf-8?B?Yk5kUElSbVlOdnlLWVBtSXAzdUtRRm9ZTW0wamVXYUtFZVVRcFhnVjYzSTRo?=
 =?utf-8?B?WmNHRURzS0ZwUTlhUTByNGdjUmlHZlFXUVNlVGxuZjYvU0lodUdLRW5sYUJ1?=
 =?utf-8?B?dDVka1dsYjlabWltNVJWZ29TeVRlWW1uTEJUTGFZQm9peFVoNlhXOGFGeE5E?=
 =?utf-8?B?NzB6TzFLeUJvenR5V3pkcytYUE9jaWR1bUtudFJ5Mm5sVnEzb0Y5dFFwTHJZ?=
 =?utf-8?B?bSs2a25XdURwcHlGRDlGNGx5aS9UMVBLUjJWdHFrRVFFRTRZeTJ0R3FlQXNL?=
 =?utf-8?B?MUtRMG9GWEdxd3d6SlBiVWE4VVNmNS82ZlZXdUIvSHg0K2xSSjBCUjFhcmc5?=
 =?utf-8?B?bzFRR01wcHFUeGluSUt5R2VaN2ZMemdBcTBwUmIxS1dLcUE3a1ovNksxc1RT?=
 =?utf-8?B?c0JvaWdVZ3JDYWxGUjQxdmFadGZWR2N6Zmk3ejN4VEhueEZBeStlODdpcGRC?=
 =?utf-8?B?Z3FvL1BNQlFyZEordWhCNU1OVDlmMkdNek05VVI2M2tmOVNIeUFxUUYyZ09S?=
 =?utf-8?Q?yoPse7gjpcycE6jA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mN0KteOGTD7a4jL5FmknbuglbGAQBeL4vvgpfMErQSpe/IpxyD4L3HmNK1XoiRfwpAPFgUZWSynRQkHKAAfpnfncU7u0KfXAObZv4S4OqI4HI9p/qsIxFmQERcDw7k/e2xxiPV+9nRSimE26kNPW60FO3SA2o75fjkywwyJKPcYNXDPSftB9nj8RPGb+M1nDRXr8UMqsB8JBb8nSOemP0wfDsMdIasdH89l5NPLtkJT/Y3c91pKNPmvFH0GdT5SvazSia9yMIvLa+RVZ3qEnbc+4xTF00dCRSUSa2j13QEydq90txVVZiELY7Oj1qnV1IzYfTensPcaRDFDlxTiXEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0eb66c5-988e-4cc9-7dd7-08de7f4f1cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:18:09.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQF8zbYKxq9DcL/+EE6exOS2W6wvkjfzZ3C+4pDr68oix8WhhWW1Ho6fNgFJaSBdZ/EhP0gYrl9T3VzjMlQUkUEhANczkEl40dMJrlBfflg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 30C74261615
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
	TAGGED_FROM(0.00)[bounces-1086-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[59];
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
bS5kZT4NCj4gQ2M6IEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPjsgUGV0ciBQ
YXZsdQ0KPiA8cGV0ci5wYXZsdUBzdXNlLmNvbT47IERhbmllbCBHb21leiA8ZGEuZ29tZXpAa2Vy
bmVsLm9yZz47IFNhbWkNCj4gVG9sdmFuZW4gPHNhbWl0b2x2YW5lbkBnb29nbGUuY29tPjsgQWFy
b24gVG9tbGluIDxhdG9tbGluQGF0b21saW4uY29tPg0KPiBTdWJqZWN0OiBbSW50ZWwtd2lyZWQt
bGFuXSBbUEFUQ0ggMTcvNjFdIG1vZHVsZTogUHJlZmVyIElTX0VSUl9PUl9OVUxMDQo+IG92ZXIg
bWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92
ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFu
Z2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBMdWlzIENoYW1iZXJsYWlu
IDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4gVG86IFBldHIgUGF2bHUgPHBldHIucGF2bHVAc3VzZS5j
b20+DQo+IFRvOiBEYW5pZWwgR29tZXogPGRhLmdvbWV6QGtlcm5lbC5vcmc+DQo+IFRvOiBTYW1p
IFRvbHZhbmVuIDxzYW1pdG9sdmFuZW5AZ29vZ2xlLmNvbT4NCj4gVG86IEFhcm9uIFRvbWxpbiA8
YXRvbWxpbkBhdG9tbGluLmNvbT4NCj4gQ2M6IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBo
aWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBrZXJuZWwvbW9kdWxlL21h
aW4uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jIGIva2VybmVsL21v
ZHVsZS9tYWluLmMgaW5kZXgNCj4gYzNjZTEwNmM3MGFmMTY1ZTJkYzFhM2M3OWY1YTA3NGE1YzNl
M2QzNC4uN2Y2MmYwNjIwZGNkNzU5NjBlNDMxZjdhZjNkMQ0KPiBjYWRmNGNjNDFlNGIgMTAwNjQ0
DQo+IC0tLSBhL2tlcm5lbC9tb2R1bGUvbWFpbi5jDQo+ICsrKyBiL2tlcm5lbC9tb2R1bGUvbWFp
bi5jDQo+IEBAIC0xNTUxLDcgKzE1NTEsNyBAQCBzdGF0aWMgaW50IHNpbXBsaWZ5X3N5bWJvbHMo
c3RydWN0IG1vZHVsZSAqbW9kLA0KPiBjb25zdCBzdHJ1Y3QgbG9hZF9pbmZvICppbmZvKQ0KPiAg
CQljYXNlIFNITl9VTkRFRjoNCj4gIAkJCWtzeW0gPSByZXNvbHZlX3N5bWJvbF93YWl0KG1vZCwg
aW5mbywgbmFtZSk7DQo+ICAJCQkvKiBPayBpZiByZXNvbHZlZC4gICovDQo+IC0JCQlpZiAoa3N5
bSAmJiAhSVNfRVJSKGtzeW0pKSB7DQo+ICsJCQlpZiAoIUlTX0VSUl9PUl9OVUxMKGtzeW0pKSB7
DQo+ICAJCQkJc3ltW2ldLnN0X3ZhbHVlID0NCj4ga2VybmVsX3N5bWJvbF92YWx1ZShrc3ltKTsN
Cj4gIAkJCQlicmVhazsNCj4gIAkJCX0NCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdlZC1i
eTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

