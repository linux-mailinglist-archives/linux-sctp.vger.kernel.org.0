Return-Path: <linux-sctp+bounces-1095-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAcUNYs3sWmesgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1095-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:36:11 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED2260B17
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B154C303D485
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39633E0255;
	Wed, 11 Mar 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCtDmEgn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454C3E022F;
	Wed, 11 Mar 2026 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221171; cv=fail; b=gpsiCKz/gQvrKJg1ZakcXRWYBXYeuCro1+Yt781G8Vq24QOgC+Zx8UemS5/u3pgjTL2qaJbBnCHZamyiikxnFRyrhpX5Ntr4XE3s7+s1Nq9QlJ1Emvoiv1ClakI/r4AgmHB/zICW8G+xDkeOGXBtmZjHZtSlWjYrCrbMIp2hAvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221171; c=relaxed/simple;
	bh=cyKspt4RQZA4WPrUM7YTnCuz9AcvIkjZ2vzIJ7xgo4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhutRFV5i8NVzCZ7trltCxAzUbrN+xpK1/iWdGjRjbxTxrH32j2YoKmGMA0m7R4kPcwj+HmHOt8pFKhfaCbbbk72CmQjBRqi2lCHsKzljZI2d2SQi9Xq4yJUcHny2XUGgZCQqf2Fq6osi0kmTEcFPgfRofzAkHw+5s7DF0n1bjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCtDmEgn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773221167; x=1804757167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cyKspt4RQZA4WPrUM7YTnCuz9AcvIkjZ2vzIJ7xgo4Q=;
  b=KCtDmEgnm5usWPjo2bv3LJo2xDsX+F9Se6/ooeqeLh0dbS7d+OsmW5SJ
   7vgdSu36Ct7ddR9v5pdL9hTVhQii6g6sRt1UUzktM1qgLgFm5hFeI3TJn
   zntuDFk1LsJ8iejKbN4rFjHU89vMUJRy5oVqSilLurCL1XyvnyOzfbyw4
   MaIcYT8+AYZo89bDQoIbl7CQa+juC/GeNmEQaWmSW1a11Qke0FL6vyajT
   ZS7BSgXAgOGlI5/TOGA825J9hj8PrSrgQbz4tRpmIGfK6dXZy/xS5XVTl
   Zkk4EGFk4VF6pc/O1lvdtW3+iPA8wn3daSF8EZsSgwQFv2u/CKkp4jcTl
   w==;
X-CSE-ConnectionGUID: FkgWeCO1TJGnidsQDNYrXw==
X-CSE-MsgGUID: rYu/GoZBT/aF/bPaepKZ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91665783"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91665783"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:04 -0700
X-CSE-ConnectionGUID: LFU5EhHeQjeumOwM0B7MyQ==
X-CSE-MsgGUID: OawEcd+9SG+7pZpl4N5cLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216681025"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:26:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:26:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMnelAnsGLh5mEAtzesRCYmMt3dlbe/7+sd+j1vDC3YROHwbrIhkDxd0+Xx6utnKVfa7n+qBM+wqLN0qEEPQO6lKYauG+1KvJwdLax01tLZZyf6JlCkOMofD3uBMpzs/8oKmQ+5iezXjeMTLFwHwj0kKuhq2I3oW6mYy4zGql6QSi1jXDJbQz39PaIxZ8C1DZuOHA6n8/x45vRpqXGw0qjCJTSXqUACJEN1TWL7zVOWaxHNgKYcQv92836rDdTmPN3nBqNy/QBMTgcX4/d7CN3CwoCzED414/Wf9tP3MyPKL4cy7V9i/TbqYCu0lvC3nVnscZObE8DFPFZgRlcW69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyKspt4RQZA4WPrUM7YTnCuz9AcvIkjZ2vzIJ7xgo4Q=;
 b=GjlIN/UTpN09nyoNrbsP4m2NtmQT1Ly+FkBlozActzyCraWzuD1nUyJEp+HrS0C20oJk9RcPus48mUW2MDELLubo9aYbyFccc2ANgYjdky85DPnEmsAmPwH2RM6cdLln4Zvl8ojQHxebSljiJVMWyIjnqRh3YDBqJIW9eTgQXioO1CVb2lIzRlLlfUEHbOSjfcY7aIlDwUgCOzhRVMb06PT+9Om6d3qoVamqsPLZarpxSv+Bv6MmevXseYp4id6ZEC9phqppcUUluELbRG7zZBemV4qyBjLO2vfMTrVJL3LsfwShmujm+CNPQzLbDBK/KxrpauxZLWRUoUirtW7YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 09:25:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:25:58 +0000
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
CC: Shuah Khan <skhan@linuxfoundation.org>, Kieran Bingham
	<kieran.bingham@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH 49/61] media: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 49/61] media: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKJC7wOPu6zykS6DEkPokoDo7WpENMw
Date: Wed, 11 Mar 2026 09:25:58 +0000
Message-ID: <IA3PR11MB89861DF7C206BD634B477539E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: c9ed382a-e59f-464c-640e-08de7f503440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: +h66MB2j2vOXsLZaMH2Eb9pjjcM19YQTG6uM/bPbqnKJKI99df9KIqs9QYBEEAIR3WdzyLC4fz7DgIn9WnSe+EhbqCc6JwetdPXEJxaN+Z96UtWHQvrTThP76ftGAaGTJc5M2KLRc46RdmGHskO2Z+qarm3AyIUGfwOuiLpLsqiKjo4v+HlEYJtRYrhXc3owI7zaRzFeEftfpBZ+cz15SrWYjf/WJHFfXK3IX29T/vsLHaNWNNjGBvcE1Xoe41F1TUeO61BzemC0ghFCnrSpwfWZVQ2x7m6zs425wMWVfpok0Le/M/w+RG9Yd46JoLYYRxb5YRrVaT5iHv8NAsMCjHGsORvP0P/dL6wIgk4TT8s1Tmi2aU5w5zXdgT2N/bzSoaC4AouUEfMWGdEKuF6G049D/Kc/dM5FFvDvFS1rRdB/ZNNPmjTe72OyYvwyqdYJqyuVne+FaG4CsbbKsWuTHF2kz2Nflqalvzm9hgDWmj9qyyDIeyhr3YEeDjJ59bQ2tIeOWIK8BZ36OshnVjOdr2jgHJ+rmIzqnSGkEsUkRYSCo0xeEuMTVk1oxU1ntyKcshAuNRpOQAC9giFYrajphl+bvZmKk8SRmNfWVyb1VQwwvxU3RYcj52WRVJWNS2jut6tOSRuDYQmospdx7wp5f24zdMI2BAZeY5ydGrMcmhF4qWvGs71HYgjdMP6Mutx+2BBUa/Iz7S4yqHiagw4S5/lzQ2MwBhhpTiPgXyY4lewdvBLPHyuMt8Z0AwymRno43q/8w3tFcIoRg7dRI/w5p8lNNSoG9vd/liEKI5uiPYNsBn60fKJ4IUGT/9+sGc1B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW54aFNRcDZSZURGMlo5UkhvN0RHSVpnZHlsTUJLZkM1a2YxTzVOa29xSVNE?=
 =?utf-8?B?UmcrbTZORk1ZV2h6QTlRdXpiK0lWS2VYZlFSbmlDMVF3ck9TdFczN2FYVjBl?=
 =?utf-8?B?MmpyUERHL0F1NG1nNDF2b2hRWktndWVvWjl5cXc4ZGJxY05NSUh4MmpoYzl2?=
 =?utf-8?B?c0JNNGp4V3NDdkYybGdMUllLZzBBWVRvWDFmMTRHeVVSL1MvSVl1ejV3UmRq?=
 =?utf-8?B?VmdkZG40OFhkdk8wMEpUMkNsR2ZpTkhtNVhtUzhBR1VSQ0VvcGxjNkl2a0Zm?=
 =?utf-8?B?bExiaGhVK1dDYVA2YkR0ZHRRQ1lnWEhaelJuZXFuZUtuS3prUU82OHMzay9O?=
 =?utf-8?B?K01BT3lqRjVhTmRTNlZjUllIc0hMUUdmUksxYS9aclhLV3cvWXBSbE5FQXlV?=
 =?utf-8?B?TElhYUNvZ001NEFraEhJZFpkL2ZDdEF4MkZoMCsvblpCNGg2K1BOVXVJdkkw?=
 =?utf-8?B?TitRSE9NU3IrZDhuNVpHdXZ0Kzg1TVdNYlVWTVRtbWFLMTJQUnJ1WFd2WmI2?=
 =?utf-8?B?T1REUTN6N24rNDdwc0x4U1VQdUxFeUdiT2h6bnUveEEwNEkzazZZWnl4VzQ5?=
 =?utf-8?B?UXpVblYxWE1SdE5PYzltbHo0WFFWdVNkM2xmN0xzcXhZKysvbC8xZUYvcDk0?=
 =?utf-8?B?OVhXWHU4UENwR3gwaHo5MXJsMjYxMmgyRkFFdzFQVXg1czFtcnJmdTUyNXF1?=
 =?utf-8?B?SkNHSUhCREVDdmw4UmhVVGlRZkxxWHcxdHB5WkhXaW84U3QzZ0hSQ09QM1lZ?=
 =?utf-8?B?eWZOd051SEVzTXFlNCtyRHpHUjhja29ZNzlGZnp4cmVFUkg2VGJWSFBJajJE?=
 =?utf-8?B?eitNZlFBTm1hOWdVODBnUWZDM1hFNkJhTmtGazhVbUpBM3c5UkFrZmE1emZ5?=
 =?utf-8?B?R0lZZEZJWWJZK0h6QVhISHhvOGx2N2tlRWFNWjNxQU80aGVYTTI2dzhxaE9N?=
 =?utf-8?B?a3RwVDJCMGhJcGpLUEVyTExsWlNiZkhLUjJOQTJwbG1WTlp2cWdsOEo4SCt5?=
 =?utf-8?B?WnhWMDhaRDFxWWFNMXArbG5TMlRuYkZyZTl6eFF0VHhqeXV2aC9RQVBTNUND?=
 =?utf-8?B?dEV0WUo4bEh0aFo0UXFyNEcyY3czaHladFpJTlJmTVRFNVhoREszVy9QWXhP?=
 =?utf-8?B?bEZGS3BVcklKdTFWZStIOHpxREpFTWNNeXZzVFFrQnZVenRXV1lLajhrbEpu?=
 =?utf-8?B?RjNpa3FQT3ZOVWVVY0w2emlmRGw3MUpxalYzOGk0RFMxQURuNU1rMG0yaGh5?=
 =?utf-8?B?MDY3WCs4N3RQOGJXRFZQRzhob2NFa3FNV0FaN1RHWmpzVGlBUysrTlorb2JT?=
 =?utf-8?B?MXZWNXprUDR0U3M5YmRZa3B4K0lKL1I1RVdrZ1hOVlVYNmdmdVJ2aFVmUzUz?=
 =?utf-8?B?Q29nV0pMWVE0OVI1UkhiSDIvK0paOTZma2RTVkdXL0hJNjNXaFBQZExMbUR4?=
 =?utf-8?B?cEg2b1hpRGtud3lDNFNCN0E4R3JzUmxaLzNoMkhUR3VUVDNzWE5aZmtQOS9U?=
 =?utf-8?B?a283Q0xHbTVtaktqbWZHWkVRK2JPMVJnek5BN3NXK1QzVDE4cnh1cXN1SitF?=
 =?utf-8?B?L2lvcExuYk9KbFNZY3VRbnVtN1F1UjBxWGZLTkNjK2lDTnYzY3NSRmFKT1NL?=
 =?utf-8?B?NFkrZTVMVGpjUHFLMnlocnNtYnpkaDhnM1h0K2w1L01FZXllOEs1bjFPd1lQ?=
 =?utf-8?B?Q0ZvSGFCU2FSTldLaTQ1WXRsaXhxM3BhSk4xeENhaU50cWhpSCt5TUpvVFFz?=
 =?utf-8?B?RDZEL1d2UGt5RStEWjhJL0JqQ1FFSEhBZ0RsU0wrYk1IdTljcVVhKzRJMWsr?=
 =?utf-8?B?UXorc3Q2NkRVcmQ5TXZuVnFKUE9LT0FDaE1IUUVndno3dHBjN0YzdHdPNVFv?=
 =?utf-8?B?Kyt6RWlya3UwVmdMQWR6QnluZnFuMjBPeDhrMFpoak94QW9JaytwTHdyeGRW?=
 =?utf-8?B?N0JlVkVoVXZHQ0xCL2NqaUxLSm51N0VVR2Jnck0zc1kwZU5ndkNyOEZEMkRq?=
 =?utf-8?B?WHJJK3kzL3RxNEl4MHM3OENsdHJjeTYzYiszWVNrSWJKS0U3SWI3L3c1ZE1M?=
 =?utf-8?B?RzJNMzNwdjJoK0ZhTW1DbytmN0V1VUhYT2dGSWtXYUdOWWdiNWQxRytOQmZR?=
 =?utf-8?B?cTF2Vk4xVTc3dk5yR3BRQ0xxbmp5UStlMXh0YWdvdWdObnRua2lvMUI0Y0NF?=
 =?utf-8?B?cGl5aUs0NnZBTlJZdk5JeGtjWGM1bTlIemhCbG1HbUVPb252ZUhOeVBWLzdK?=
 =?utf-8?B?TDl2emN5Nm9ydlpUS0pEbmU2dmJVUDNod0dSalgyU29kSmhLUXI3VnpXQVRV?=
 =?utf-8?B?aVBQUFg0Z3VVL2h0RGlod1Q0ZFJWcy9wQThxZUZGL0R4UzlLZFpUVFJHaDNV?=
 =?utf-8?Q?S0CYujZn+ePJQXsw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SQZePNg7nKAAbDqMZ7dW1KHZ0FFwuCn1Jt76oEzgegnF5SJgaGKEma+2Ac/wYI7p91qOK6NWHvlqijxMpvA1Xza0Jp4lz2KSWF/jDCkOBRpYZfPPob7+/x1rDy3YvjVepeutrQse19LJjPl3wgjksdB6NxWPkcJdKbdr6UtWEumlUyob+dvC7YmHtdOqYRVglVtCv7xN/s/kOoRo7wbnCqfz8YpnB2EAV5EegXbPvG9BeGRclUz1aOXpzB1+3hzmIim2BIiLVIznk4NiitZnWOlJPFzUCAVHh7vcsc5I+DmmrWO2DMt/V/STYZrYLvvBzUlSimeefDhCGuunhuIZNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ed382a-e59f-464c-640e-08de7f503440
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:25:58.3602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjZdscLZqaiMLL5IiMuiPhMYno2isL9hRuKVDLo/kqTRKMwOrvrBMcD4bI+ntSh9gHqWiFjs9lRHrj3mUdYG1LDTIMXboOJ3d8OYEwoCxpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: D4ED2260B17
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
	TAGGED_FROM(0.00)[bounces-1095-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[57];
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
bS5kZT4NCj4gQ2M6IFNodWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBLaWVy
YW4gQmluZ2hhbQ0KPiA8a2llcmFuLmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT47IE1hdXJvIENh
cnZhbGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggNDkvNjFdIG1lZGlhOiBQcmVmZXIgSVNfRVJSX09SX05VTEwNCj4g
b3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxM
KCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+
IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86IFNodWFoIEtoYW4g
PHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFRvOiBLaWVyYW4gQmluZ2hhbSA8a2llcmFu
LmJpbmdoYW1AaWRlYXNvbmJvYXJkLmNvbT4NCj4gVG86IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8
bWNoZWhhYkBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxp
cHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL21lZGlhL3Rlc3Qt
ZHJpdmVycy92aW1jL3ZpbWMtc3RyZWFtZXIuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWVkaWEvdGVzdC1kcml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jDQo+IGIvZHJpdmVycy9tZWRp
YS90ZXN0LWRyaXZlcnMvdmltYy92aW1jLXN0cmVhbWVyLmMNCj4gaW5kZXgNCj4gMTVkODYzZjk3
Y2JmOTZiN2NhN2ZiZjNkN2I2YjZlYzM5ZmNjOGFlMy4uZGE1YWNhNTBiY2I0OTkwYzA2ZjI4ZTVh
ODgzZQ0KPiBiMzk4NjA2OTkxZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvdGVzdC1k
cml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvdGVzdC1k
cml2ZXJzL3ZpbWMvdmltYy1zdHJlYW1lci5jDQo+IEBAIC0xNjcsNyArMTY3LDcgQEAgc3RhdGlj
IGludCB2aW1jX3N0cmVhbWVyX3RocmVhZCh2b2lkICpkYXRhKQ0KPiAgCQlmb3IgKGkgPSBzdHJl
YW0tPnBpcGVfc2l6ZSAtIDE7IGkgPj0gMDsgaS0tKSB7DQo+ICAJCQlmcmFtZSA9IHN0cmVhbS0+
dmVkX3BpcGVsaW5lW2ldLT5wcm9jZXNzX2ZyYW1lKA0KPiAgCQkJCQlzdHJlYW0tPnZlZF9waXBl
bGluZVtpXSwgZnJhbWUpOw0KPiAtCQkJaWYgKCFmcmFtZSB8fCBJU19FUlIoZnJhbWUpKQ0KPiAr
CQkJaWYgKElTX0VSUl9PUl9OVUxMKGZyYW1lKSkNCj4gIAkJCQlicmVhazsNCj4gIAkJfQ0KPiAg
CQkvL3dhaXQgZm9yIDYwaHoNCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdlZC1ieTogQWxl
a3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

