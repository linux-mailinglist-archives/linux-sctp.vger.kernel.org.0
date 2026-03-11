Return-Path: <linux-sctp+bounces-1087-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNtQN/c0sWm0rwIAu9opvQ
	(envelope-from <linux-sctp+bounces-1087-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:25:11 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBA260591
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C68A30071FC
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671F13CD8C8;
	Wed, 11 Mar 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuKJQ6tu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1423CB2FE;
	Wed, 11 Mar 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220785; cv=fail; b=aaBZrGUNuoumQ+MK46+RpvDYzjMLWh3huEg56YARUCSvO8A+CIVr5Y5/MtnxprTHw/ESKYQweYsOe6Ik8C4rS3rRh6/NlvtJLPINSdPXKd64OtXG0YbetXQx/r6CnLYncDKowznRXkpWSkj1+AAxZw2RK40ElMPuPtF55udvNYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220785; c=relaxed/simple;
	bh=D7nUDKuPEo27qEdLzygrEIBg986pkmH1euYjXXqF7Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLoDi9n2OTOHRcp4Uo7NsF5a0e4W++o/B+wGH1S/i2am7T/8yZ3M9gipedTSrdBkaEgOqRrql8bQnYtP9VFEkYXokhDYze2rrP0R9L0Xs8J7yya5wf9uXKWOS6nAIPDUIbjZBoaOOv8UtQ1CMkjVS2MJH6MmiMDyHsz6NuKtDBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuKJQ6tu; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220780; x=1804756780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D7nUDKuPEo27qEdLzygrEIBg986pkmH1euYjXXqF7Ws=;
  b=AuKJQ6tuOxaMccAIeR7cMe1ZQCG4GUoB7uCpPli9IRoOxP3+RuEdKlQ9
   NsV84W9RQ7HrxamHb2+iLnvZuvfN7F7w03X+g+4KjfdJw/rMxHH346piA
   ylyuipvOrppIPVfPr8HmNvK1rE4A/LPqVvn/t6fT5gIzOuAX8s5a49PA4
   ESCAt8alRkYm+vM2gkOAc+H3iXHw/27M+8ZOUJ5MPc1XHnI7ccjeXws+i
   yWc37ETjoKGo6G9YI03SEu/M6ko7GLBfX0Z4BA1aKlpu7RtEhbvLH5YvT
   gy+QcTtv5Qs3GJ1nC07YSJPI9ETW1urVbqm2Qp6rlTi3nhZyqzBGdiBUk
   g==;
X-CSE-ConnectionGUID: SKbt9goLTeWGY6yNh9dwtw==
X-CSE-MsgGUID: S4/8NDFAQdqcF/qat1db/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61856219"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61856219"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:36 -0700
X-CSE-ConnectionGUID: 46pf2HV9S7Of7BUNrfOaVA==
X-CSE-MsgGUID: TdTMS6l7SK+FX+N1UIsSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258314280"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:19:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:19:35 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.34)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOGRW+21ayl7yzpaMXG8IDRvFnYbGJUDpVyo3NDYSpk+0PwwjHXS2xfnxc5bTyRZwymkJpwUlVyCP6ghD8tbbbtl/Fg3xhpcwVz2+eptBybtliryDiV4MplbQYoNVDxNB/2G+Nk1uGlpwGd2wr3h6xnftI6gnJtzVFzMYX00F9H2oY5dKSc/RhKeLKMXqthsd5nDveZrGgki9C1z5ij+LomeMPYFiVXNqfcFo0iHp9VQdR0HrobjPNK9Dp33aLIfetrd85AXEQ/5tSBnmslNcFtCS14ViwXpmZ6Ku1qxom1ymoN/bwBs/S40aGP/E3cwV6cnGl5/AqRaH2xldsnzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7nUDKuPEo27qEdLzygrEIBg986pkmH1euYjXXqF7Ws=;
 b=h1RAnkHJkwi18zhB7Ptgz2ymSl8UDIiA9LjueX0p6Mca63mNvLOAIKQxqUe8OcpH29stMJstkBHagzOXxKBUDtuGsovAFt4xH/+QCoOvS85UvEgU6xnln/75CUeXedJ+4oWVFCS8DQ0oJ6zgo+LpgBVyx2goSYJ8ZVQPJ3JPMPetApWjcj+VuCyC3Bp2z2e/heg1XewrfFrdh8eLdzCoO2mdmVWN6FiTJpfV0NnwOIqVHmfVtVMAdUVVMQrRUDsTFGTJsdfgG88ACnKjSBVGRDtAyYx6NSKpyTRcuHu8MonQPJTEyx1tF0cqh32/3ioRKu5Bj63an35Cxsq8NX2KPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:19:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:19:30 +0000
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
CC: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski
	<bmarzins@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH 22/61] md: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 22/61] md: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKKfBp0x5V0NgUq7H82vBk96YLWpDwOA
Date: Wed, 11 Mar 2026 09:19:30 +0000
Message-ID: <IA3PR11MB898600282FF5877B7BA5F6A4E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-22-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-22-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 6a1600e1-fbfd-405c-1a68-08de7f4f4d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: JlkxGI1KNes5SM4EPeAdCVfP4oDnmvDeYpX/iNiNHKxD2Q4TiSg2fEub0BCtGGhtbunsUWplSf0FvjD9bp4cllC0bxNEMK+ESQLH15YQaLFKxhnM8o8HongNJCHIzvbgdb0yU6RWc0GWS1dsVi/s/XAWyXTjrzn2OxzUgadFHkzZ6tm9d8vKWdfZstTzTNdOOAj/iP+OJRRdtFWDDrNUKp3SAZ4DzpdOegZ8drGWVpB0fG5IhZd3avRmgABsuQBrTkJU6H+jmC10KEUsswpfkjHpVWOrzzKbMINrZYJrwwJb0pAzOcRxijVBeOU1ZkVoBtMalt2F3RJ+trjGPOrDfuBBZoqhD5aMOAkEn9WFCb21dyFBK4xdDVwXKgswu3s7xcLR0OrmECftDKxvXyRYeFfTCiX3JvCjHXVFHcWCjh5X2pdKmkm3Dsdbh87PURE6gZU0FnVzsfiKGeokE1hm9fFdILMJB7cqcjfyduTWIlaEZsK0KHXLB7W3DxgXDI1CJQ4nl1xP70SU5WPmaMifl9KCQivy8YCp9oxZFvtgkcpwklu2uE42X2xVi/o/R0UvwkUPj63e1vNHa2T1IuaH2P1uDuafc9majAjExU1OEetnoXLTB3FK3suXtiKP6soCiPuRPposC1tiI+jtetlAHA49Z/aeEVUQibhPSmhST/b62+4Q8a/lDZVn4rXLYJKFLkqUROEHyLiR+lR9kBbYTGNpGfZ6jMj4ijc5WlfV+OYUZHmGb7wVPEx9TgqF4lAk82hyfk2yM8C35lO9pLVts4+4xV1kc66GQWgYvLkLo1gDicrEATJ9/5Ps1wiBkCBp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEV0Q3RJTDRzdUJuOE02Wmc2RHlmbHRBVWFkdDdBcktxNW8wUlZKMkZOZWJ3?=
 =?utf-8?B?MHJQdmxJUmJkWkxjWHdJSkVFUkJhZmczWW9VazJ6c1R5MlIxRXVpMFJqUVh2?=
 =?utf-8?B?cWFXSldIMllTWnh5L3orcWpvYlFLYmw2V2tWeGZYU0N5NmF1V3FmSThsSjRC?=
 =?utf-8?B?Z0MwNEljKzc0a0F6WGRGMlRvTVB0ejYxL3RmVVovdEpuTUU3MkF1NHBUTEZj?=
 =?utf-8?B?T1BYOUVuM3Q3eEVmMkVPZG1iTkFhQm1TQlIrVC9YMDhuQ2VSajhWUGMwZWph?=
 =?utf-8?B?QnFHVnFTRjhnRWh6WGFRSnJQbVk0bEQ1V1o3Nkc5UWhUM3Vqb3BwTUZ6TUpV?=
 =?utf-8?B?S1NZOWU5MzByUUNLYWF1R0ZidHZHZ3J0T09vYktXbmJRR2Y5dU5kRXJIUFFD?=
 =?utf-8?B?REVHanZyaXI1QjlBVmJBbHhnOGVJWWdNbXNUN3ROb0RzODAwcUYwYU5aSkZn?=
 =?utf-8?B?M3BrcE9JNVVjUHcrMG5PaFlQVUJ3a0oxRC9GZGMwZ3Z3aUYySE9pTWFXVE1Y?=
 =?utf-8?B?cVZWV25xK1RGbkZRa2tFZElheXBkODRpVTVIZldJUm1NNG1VeGJzajZ0UnJM?=
 =?utf-8?B?Sk1MdFl0QmpoTk0zVXRoZ1ROWG56d1doK01iYURUOWNqeXBDa3E1YVNBUXBu?=
 =?utf-8?B?cGY5ajVSZkNyZ09TSTNPL1hGL0ttWU9ZQ2FPbmY5Mjh2d0FMYjNNS05McmNZ?=
 =?utf-8?B?VEZDYnloOGYvV0FUcGRucWJoZkhEbHpqS1dQUlBYa2ozQUt5MGdOTGloTnp0?=
 =?utf-8?B?VU0rc1phd3d3MWVZbFFUcDhPY0hhUzlIaVdvNjMvcmljUjZLZUY5cnZ2Qjhn?=
 =?utf-8?B?aHlRbXdRaExDcEpGQnRreWQyR2NQMFpYQThUS0h4K3RPSnl6Q2dVYXhGMnFS?=
 =?utf-8?B?MzZhVjlJcUFyd2MxR0dvaXZ6NDZJVEs4eWYwL2hEZ29OVGREaFJTZGgvOEJT?=
 =?utf-8?B?U3pCMWdVcDh2VEhVK21BYlVDYno3MHhUQVJoYnF5VEdQQmhnT2dZWC85UDIy?=
 =?utf-8?B?VC9HR04xeklSQ2ZQLzlkSGQybm5QT1FsOVlZbzJaOEp1RjFuWTdwcWloR0ZK?=
 =?utf-8?B?WEFMYW84cVZtSU5mL0djdndFQTJFNStOMSs4aU5xYUxQUWJReWhPSjF5OFdP?=
 =?utf-8?B?NnpaTndGSHBLdWQrV1JJaHpWMlg2aWloS0hzVU84cytIV21Hc1hsUE1sMTR3?=
 =?utf-8?B?NFRTR0V4aUozRlJkeW92VjhtZXJoNDdlN0RxTjNBZjRmdW4rRG5ST0Q0aGhX?=
 =?utf-8?B?R3VKanhCM281NVR6MDh5V0hrb0FPdVc4RHQyM3NpeDhxVEMvUFo2N24vVWcw?=
 =?utf-8?B?Y1I5UE5ndWpKNnhrRG01MWEySWxHWlBVeS82SngwV0Z2Y2hwNU5DUEpwOTN0?=
 =?utf-8?B?THJ2ZkFBNW1IVFRLM3FYQzlKVHFGQmRrSk5pWEhReWc5c0RoRzYzdjQ3dW1h?=
 =?utf-8?B?V3FLcUFKbzI1VC8vRW5aNHQwaTZYL29GNTBhQ08vb2lrbGhmUmphMEIwZkJX?=
 =?utf-8?B?c1FaeEsxdTE3VEc5STFyQ3FVemxQVUs1eFR6RHlwclJJc2JoYnB0blpZcFFk?=
 =?utf-8?B?ZGR6ZWpoOVcycmZmcmNMK3VQSWhOaEtZWjdneVduSWRCMHE3eW90TzNDc1Fa?=
 =?utf-8?B?SjczdzlJT2tYdGhudnU0TFdnYTRRN24xQWNFek15eXM0dmdCcnkzL1RaQXFm?=
 =?utf-8?B?SGdVM0tkRXBwKzhzYXV6ZHlwZkNUTVM3SDR5N1hrWGRvWGlrbHV1VS9weGxL?=
 =?utf-8?B?U3hkeE5mZ0VBMm1vUC8zRE1YdUU3cHBrVGdEZkFSRjN6Yk14ZWcvS3pCUmRL?=
 =?utf-8?B?SFdqbmhGRWdmOWdPVUMwVjZreGR4RTVGUTFWVUlmeEFKRkdJM2twbUY5YlVK?=
 =?utf-8?B?ak5nTDZuV3NwU2ZVeTAyb3ptUGVkQk5nS0tiODVrbE9DWit3aVA3czd4UjA5?=
 =?utf-8?B?dEJuZU5oaWc3RTVLbHNRTkNMSjA3NlU3alFWcEJYVzl4OFZFWDIzNkJvMDVr?=
 =?utf-8?B?ZFFRUE9iUUVYa3czdnNNQTNGalM0d20xdlFTdTdKaTN1dXZLZTArYklMU2RX?=
 =?utf-8?B?RkljdndMdEhMV0twRk9uSGVCUExWUnd2cVpoUldYeHFIbXl6TzQrWmhMNHJX?=
 =?utf-8?B?UXVmRENGS1NBR3BnSzVKR3FBb0dqMVZRdklxNFJnL1h6a3MrcWRTOXo0SXk1?=
 =?utf-8?B?eUV5d3NCUVNSM3F4Z0lWM3haMHJQR1BCNUwyT1dldlJxR3J1ODRCNzFIS1VM?=
 =?utf-8?B?OUVZb3ZNRU1hWG5sZkt5NUZsTk9NZkpyV1dzM0RMeGVUWXUvalQvYmtpTUc2?=
 =?utf-8?B?WWk1TUI1OUtnU3lsNzRndDNPa2VLY1JkL21QZUZrbGZzSHg1aGhNMGYrZW5L?=
 =?utf-8?Q?PWCV9o1gkKx3kQ5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: opkXWzvr9+5iDDZTc0HWriaOOVbQDkf+oFL6/qS7jlbwfRf8japWyBNENI6otrFpWubOIECWz4GCkEVTyh259InxDlE1qc3CmglEFZZLaMkw9cSq3lqA1N04/i6byJOyvyzOCZuinPiDwu51bfDjt54kKTjkj6ASrNT8smclHgAuAneHzlLALuaaX0DpSA2o1bBulkUkcVOnKg9wNx08jqKxOTy2akwzjp7I+jaGfXfJAPV+slv0zS/eJGwcGcP3ib3+08l4PlA9MlWpBbdGkKgkUOUE9lZwvc3DqRGYBnpDXH3rASakEX/Ng8jMHa1H7ygFs9vs8fxm7RUyHuwB1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1600e1-fbfd-405c-1a68-08de7f4f4d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:19:30.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcMSWlihf874ebTGWI5rWHXg56vV2OaJWOiuprdMU1jWfA0iXSnL6QVl+yp5XR9hl165XANg2V3jcXhiXIgSO/ilyCY8z2S33Z8g7i5MG20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C7EBA260591
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
	TAGGED_FROM(0.00)[bounces-1087-lists,linux-sctp=lfdr.de];
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
bS5kZT4NCj4gQ2M6IEFsYXNkYWlyIEtlcmdvbiA8YWdrQHJlZGhhdC5jb20+OyBNaWtlIFNuaXR6
ZXINCj4gPHNuaXR6ZXJAa2VybmVsLm9yZz47IE1pa3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FAcmVk
aGF0LmNvbT47IEJlbmphbWluDQo+IE1hcnppbnNraSA8Ym1hcnppbnNAcmVkaGF0LmNvbT4NCj4g
U3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDIyLzYxXSBtZDogUHJlZmVyIElTX0VS
Ul9PUl9OVUxMDQo+IG92ZXIgbWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJ
U19FUlJfT1JfTlVMTCgpIG92ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4g
Y2hlY2suDQo+IA0KPiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRv
OiBBbGFzZGFpciBLZXJnb24gPGFna0ByZWRoYXQuY29tPg0KPiBUbzogTWlrZSBTbml0emVyIDxz
bml0emVyQGtlcm5lbC5vcmc+DQo+IFRvOiBNaWt1bGFzIFBhdG9ja2EgPG1wYXRvY2thQHJlZGhh
dC5jb20+DQo+IFRvOiBCZW5qYW1pbiBNYXJ6aW5za2kgPGJtYXJ6aW5zQHJlZGhhdC5jb20+DQo+
IENjOiBkbS1kZXZlbEBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBIYWhuIDxwaGFobi1vc3NAYXZtLmRl
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbWQvZG0tY2FjaGUtbWV0YWRhdGEuYyB8IDIgKy0NCj4gIGRy
aXZlcnMvbWQvZG0tY3J5cHQuYyAgICAgICAgICB8IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZC9kbS1jYWNoZS1tZXRhZGF0YS5jIGIvZHJpdmVycy9tZC9kbS1jYWNoZS0NCj4gbWV0
YWRhdGEuYyBpbmRleA0KPiA1NzE1OGMwMmQwOTZlZDM4NzU5ZDU2M2JmMjdlN2YxYjNmZTU4Y2Nj
Li4zMmY3ZDI1YjgzYTE4MWEzMGE3OGM2NjNkNDhmDQo+IDc4ODJjYjk3ZjdiNSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tZC9kbS1jYWNoZS1tZXRhZGF0YS5jDQo+ICsrKyBiL2RyaXZlcnMvbWQv
ZG0tY2FjaGUtbWV0YWRhdGEuYw0KPiBAQCAtMTgxOSw3ICsxODE5LDcgQEAgaW50IGRtX2NhY2hl
X21ldGFkYXRhX2Fib3J0KHN0cnVjdA0KPiBkbV9jYWNoZV9tZXRhZGF0YSAqY21kKQ0KPiAgCVdS
SVRFX1VOTE9DSyhjbWQpOw0KPiAgCWRtX2Jsb2NrX21hbmFnZXJfZGVzdHJveShvbGRfYm0pOw0K
PiAgb3V0Og0KPiAtCWlmIChuZXdfYm0gJiYgIUlTX0VSUihuZXdfYm0pKQ0KPiArCWlmICghSVNf
RVJSX09SX05VTEwobmV3X2JtKSkNCj4gIAkJZG1fYmxvY2tfbWFuYWdlcl9kZXN0cm95KG5ld19i
bSk7DQo+IA0KPiAgCXJldHVybiByOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS1jcnlw
dC5jIGIvZHJpdmVycy9tZC9kbS1jcnlwdC5jIGluZGV4DQo+IDU0ODIzMzQxYzlmZGE0NmIyZDhl
MTM0MjhjYmQ1MWYzZWRmNjQyZDUuLjA1ZWFlM2QzYzdkZjZiYWViZDBiN2E0MjE5ZjcNCj4gYjY5
MzhmNmU3Zjg3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21kL2RtLWNyeXB0LmMNCj4gKysrIGIv
ZHJpdmVycy9tZC9kbS1jcnlwdC5jDQo+IEBAIC0yMjk1LDcgKzIyOTUsNyBAQCBzdGF0aWMgdm9p
ZCBjcnlwdF9mcmVlX3RmbXNfYWVhZChzdHJ1Y3QNCj4gY3J5cHRfY29uZmlnICpjYykNCj4gIAlp
ZiAoIWNjLT5jaXBoZXJfdGZtLnRmbXNfYWVhZCkNCj4gIAkJcmV0dXJuOw0KPiANCj4gLQlpZiAo
Y2MtPmNpcGhlcl90Zm0udGZtc19hZWFkWzBdICYmICFJU19FUlIoY2MtDQo+ID5jaXBoZXJfdGZt
LnRmbXNfYWVhZFswXSkpIHsNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKGNjLT5jaXBoZXJfdGZt
LnRmbXNfYWVhZFswXSkpIHsNCj4gIAkJY3J5cHRvX2ZyZWVfYWVhZChjYy0+Y2lwaGVyX3RmbS50
Zm1zX2FlYWRbMF0pOw0KPiAgCQljYy0+Y2lwaGVyX3RmbS50Zm1zX2FlYWRbMF0gPSBOVUxMOw0K
PiAgCX0NCj4gQEAgLTIzMTIsNyArMjMxMiw3IEBAIHN0YXRpYyB2b2lkIGNyeXB0X2ZyZWVfdGZt
c19za2NpcGhlcihzdHJ1Y3QNCj4gY3J5cHRfY29uZmlnICpjYykNCj4gIAkJcmV0dXJuOw0KPiAN
Cj4gIAlmb3IgKGkgPSAwOyBpIDwgY2MtPnRmbXNfY291bnQ7IGkrKykNCj4gLQkJaWYgKGNjLT5j
aXBoZXJfdGZtLnRmbXNbaV0gJiYgIUlTX0VSUihjYy0NCj4gPmNpcGhlcl90Zm0udGZtc1tpXSkp
IHsNCj4gKwkJaWYgKCFJU19FUlJfT1JfTlVMTChjYy0+Y2lwaGVyX3RmbS50Zm1zW2ldKSkgew0K
PiAgCQkJY3J5cHRvX2ZyZWVfc2tjaXBoZXIoY2MtPmNpcGhlcl90Zm0udGZtc1tpXSk7DQo+ICAJ
CQljYy0+Y2lwaGVyX3RmbS50Zm1zW2ldID0gTlVMTDsNCj4gIAkJfQ0KPiANCj4gLS0NCj4gMi40
My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT4NCg==

