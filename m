Return-Path: <linux-sctp+bounces-1085-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBBaFf40sWm0rwIAu9opvQ
	(envelope-from <linux-sctp+bounces-1085-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:25:18 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9002605B0
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5630F32F919B
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B03C944F;
	Wed, 11 Mar 2026 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZCJgzkd"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECD3B3887;
	Wed, 11 Mar 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220586; cv=fail; b=lj719sJ89D0ZgCEdwds7pk1YcRtPSPifqbbhhUIPAX/Pbbuoeh/IcWOvDMIt6Id1J5nJyfira8Y26HHShEl/Cdn5Z3szJoeEq2Z8vVBcf6HhdbE5KHYiSGATJUpRGthIq6fmKJpHz6CK7rqZrec83h3vqnAQL1WiwFGZ/JULvc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220586; c=relaxed/simple;
	bh=xPVL3bTeONWi/ds5cJDTAGXrbPqCVMwyIidh5uvqAMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qEgXzTTBiQcSv1LKF/cfQz3fiQMjE2ZSfHS2gKwO3/6IK4n/CSC+iEuOVe6SxWgNmXggf/jiO8E7WNR7QMwPTuF+Cyv566Giq3ps9ifh+ZD7P4L1lcK3jCh852DZQAWt3m8anTUOKOa0zjJnXTcOkrTEj6+uJNjzVXZxmJvPGRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZCJgzkd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220577; x=1804756577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xPVL3bTeONWi/ds5cJDTAGXrbPqCVMwyIidh5uvqAMA=;
  b=HZCJgzkd/D96rlUe9Ui0/dSDxAdWOgiNtkIACIZfrOWvJh9PuyZcF0a3
   0kWYsmQTmS97Y4n4/XJhOmIjLiJqovonibvWAwbHRLJB72+wElbwmF3Bp
   7pVlYXrMZv+NvRGduOVQf4R7qGZvoXWnZnYaIn3uhf4T/GjxW5rS7wzdX
   pW96175mHDy1mfXz4zzARsub52+VkRvLfzKYPIJfQxVVZ8bGOK+Wgmiku
   VZ9ub28lPL4Xny6DgFFcS38s9nw4k493vXa9y38eFMpYlaIUIwEf3T3Br
   ypyIoqcESWkKhUks+ikGAYRS0JpwOmKRhDqqVCh6+dEuyX9AGtKbwBu47
   g==;
X-CSE-ConnectionGUID: dn6EbHGKRQC/sZ+/7PkAiA==
X-CSE-MsgGUID: KmDduod0RpqoqsYiox7nNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74473161"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74473161"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:16:15 -0700
X-CSE-ConnectionGUID: 0nldSm1gQjySuKZO2vFqPA==
X-CSE-MsgGUID: z1vnnK3bT6GqnlTxUKLRkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217088498"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:16:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:16:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:16:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/04S6Prr2YA2xe2B3IprnhrK7EgUmJRr1d/dWgNNo1VyR+AGeHf70MFTmnZCUa6yJrDLzQAGLT/gizQz1D9PDrj0wkd04QQLtgpNSdGKa+2MtdH5LSrS3Mfk8fRNbaMEaLcWULWgs+iVRyzhFw1oWIFZyjELsu6cfLmgB2hQJnFFyQsIqT5WiXQTazrikD070Ftk1YCd8p3tT+exOIDiUGjCVeDRBb0dQTDIE66MlVHYTiW50u72SRewNrkdKVSQOo3t7Tfe19JltpwtkxYEq1S4KrIHODYKBfrm5ZVCTltiv6btrS/Da7bDDaNxA6zgNI6VG6OYTjMixb2e0xlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPVL3bTeONWi/ds5cJDTAGXrbPqCVMwyIidh5uvqAMA=;
 b=CKBOAgqZ+sYTR9FSJGdOI5a5Rt0GJswEcmJFCN0S/PIo91CN8VepAt0aERjuu3wwDCtGUyWOqyKu3trreCp+8R2GlQH0YCVZCqvQlG38ugcFFGWfQZD6Q8WFCYRuJJ+Y/tbqYUz5Y2/ooQuXdOK11ymBuBXAvEeLUBO/hVPlBllNNGfCWcgnPpgsl6G/IkH2uZybj86P1F7zwwdwwSAHM60Ylg3cCzHkDk90g++a1afzgjhJ33WNXJp4usIzuAaMr6so1shLrPu3VGUBFoYSsUdYmqIiIQYOFZYQcZ2k0jrNFShbR287OLH3GZCtRUFAbJv+2eAF5EE7Guo6wNkbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:16:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:16:08 +0000
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
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH 16/61] sched: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 16/61] sched: Prefer IS_ERR_OR_NULL
 over manual NULL check
Thread-Index: AQHcsKKfUYNoLm9pdUuTIzut4nKxsbWpDgGQ
Date: Wed, 11 Mar 2026 09:16:08 +0000
Message-ID: <IA3PR11MB89860B67553D69141D41B381E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: 21fb89e6-e749-4c05-6fde-08de7f4ed4cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qTRoNxtrbOzoNiDMXOgHCRRy4iHbiJrgtvgwYO44MVanYjZgMhyavLxKBk7cdDGb6c936CFY/D++xMeX2S2/7CM4v6vVLPXA0FJFsc+2fEetReB07WYN4Yo1to/CVH4Hl8c9xGG/RnRoxtww2Nyjz9UVg0Evk4vIGYmYDGMaiD5qcjqEHdICUg0xFoDhN/ZIQsrEYjGJHgfrjWvCERcw/+LcDcpBacDAhD5edPGUZqm7eJ7E9KFnU7kU7j6XYyRkZ4MGa2dzl93dOOHyun61nI5yfMNQS9pMByKpRmjxxQQtg3riDgn0T458vn2T9gJSfQfr5vQaEt09jfzbsWt02UU8qcZSP95yawlaVAeHTCQDykGEv9dwiOrJx2Fqf6k7u6KszQfzgo6oGNxxBOA5Ox2+WG0Ynch2n2tBp7AB6Fp3c5GrPMhsjNG9FFwGMh3i4iXD5A4R+5AZhSL2SvcVc6xjnOoI8ASm76kx+cr6Tjpa0YhFmOB9wAKFIeqr9eD+Y7JVLI73qC2rku9bESO7bmNOqwJQTpf4gRT2M//vxHmWVQ+p0o0YUrrpt7bsTrrU+BcoQoMPFLJ3GBmid44Cvs6JGuaiJZjrEHpPr2FR/pzZRQ3WwsOdUUq0S3w4uRS7phrCeZMTskyyaJi0phvIz1Jt1MKX0gKv+3iHsjBoAwLCR5/FPTl59m7WxiVerDBxqrvwbmUSQp2hhtqV/5H9lRmrSlskd22+2NqJ4tTV1s4hSiq1jBjWGE+xWG2K6c0NjSnFSfm0EWNDIx2AraNR/VV6JB5tU5hhPnnijlps1/0iRCljCFtaSrD2CA1/RKg9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWxaUFFaK0lPT216T0xlQ085QXhWeFhJQkp1enl6ekJxUHVFaEJpb2FFeUFw?=
 =?utf-8?B?OFprdTRrOGhFeHg5dk5vd0RPdGxPT2ZOeFpLTk1qQVhSSzBzYkkvZDI5WEtP?=
 =?utf-8?B?VDgxd1FXS245SkRHeXE4TlJQSWM3WjdNTnRjcTZxQllDT0s1MmUzVU1GZHBr?=
 =?utf-8?B?RGhNZ2ZINzhLTS9zOEEvRzcyMUlBd05lZE4xV2pPL1hkV05Jd09ONCtxUUxP?=
 =?utf-8?B?YXVNVVllSnhwamd4b21XcjhkOVFtb3Bpak1IMHU2VnFsTWZUeWl3US9WZUJF?=
 =?utf-8?B?cldJWnpPZDVDcFYvcVpzU1FDOVY0Um8wYnBYaVB0blluN1NBYk9hWHEwT09X?=
 =?utf-8?B?czBVTEptOXR3V2JIVTF4ZTNGRDhvY0EvM1kyYTBwWmk0OFlGSFdiTGs4Y1Rm?=
 =?utf-8?B?VHdoSVU1bEQxd0oxQmgrWXRPdmNRKzBaWFVzWWhoRURpcFgyc0lVOWJwRFVS?=
 =?utf-8?B?UXV1ZUpDdldMMmgwN1gxNGY2RUVrdDZxcVAxOS94YXZkcXF6cElXSkJCQkNp?=
 =?utf-8?B?YUNvcXJrL0lkNTNVT0svSE5kRVUxbjlRdmpWZ3A2TWJHSWRTblJUcktkU1c4?=
 =?utf-8?B?TWNUUzJCRDFMU2U2SXBBZG1KUWtxa291cEEydEZKU1htdmxnVXNrWG4yREVZ?=
 =?utf-8?B?OCs2cElscUpsaXoyTG1HTmthOHBpelZjUXd5OWVzRFJ3eFFDUVU2azZqcnYz?=
 =?utf-8?B?SmQyRVovL1lxTFFoVkJTVlNCUHBPUFUrckZmWlNoclFUMG1WczZ6WFFxbXZK?=
 =?utf-8?B?RUJZdjI0TVVRWUNkckl1K0F2K0E2b1dVem1KRnluM2VVSlg0czlFYkxydHJw?=
 =?utf-8?B?STVQa2lLUE1Db3N5YUR3QisvRHBvWlIwMVlmQmROSnBBc1U1alBqNmxUWWNZ?=
 =?utf-8?B?dmEyeEhXRU5wakg4Z0wwTkxMV0U4ZzRaYmNPTmN6bXdhVnNsdW52K2FFYkRV?=
 =?utf-8?B?eFkxVUNGQytXVTZ2cnNSWHFESEs0YzEvRzcvZWg5TEIwTzRPRHRFM0RIWUZZ?=
 =?utf-8?B?TUU3QysvT2xzakp3Q0RXM1VGN1pvM1Zqdm9KNmVVRFdYa2FJU0hYMVNOZDBx?=
 =?utf-8?B?RXgxYnhXbWNlR21UOXpkV01ZSmk4VnpYOGd2OWRmTTlQbjk1VklMVzFEcld5?=
 =?utf-8?B?RTg1ejRJOXVidVUxenN4RDJhbTZRdEt5aW5HcitDOWxZT1pCcjlnRStZakx4?=
 =?utf-8?B?aHZGb2YzOFpRUitMUTNZMEFmMGJ3eERyVmJaRlIvaklNNkw1Y2NCK0xFc0Ix?=
 =?utf-8?B?REF5MFdzenVrNUF3ZmNDZGFLY25waVBMeG1JYVZiNVdvdi83TitHM3BoOWtk?=
 =?utf-8?B?RU1uMUxYNU9Hd3UxemRWWUlIWUVwSHBobmZ0WjNZZGI0T1FWUUFMbUwxRm8z?=
 =?utf-8?B?VWFicTZTTjZpMjUzdlRMcEJHZ3lQakV2aDl3NWpVd1hYRW14MUpJM2dZbkZD?=
 =?utf-8?B?WFpHUDEzd2xKRzFJVUdHbXJjbDBRYmRlU2U0NTYrcFZBYmpERWw5NUU0blph?=
 =?utf-8?B?em82anRFWXVUTlRSY0hoK2pVdGl5MjFLdHlrZ2NmWXVmSFpyM1hsazBoTlJx?=
 =?utf-8?B?TFcxOTlZRjJmbGF0RVN3WDVDa25oN3hIYVFVZnRBNDYzRDd5WFljTy8xUUpJ?=
 =?utf-8?B?SHJvSGFWaWUycEJHbXlNTjc2ZDI1WU1RcXQxTEtUdm5RMmlVQXVIWUlZUXdO?=
 =?utf-8?B?YzdCS0luL0lpTVAydENFMngyT2FOVEdFdUMyaDJ5U2NYVnhkUy81azhaQzlr?=
 =?utf-8?B?VllIY2lsbFNRS0x1bkdUbXVmSnNjaUFZNGRJSVRpMHRRYnRWdUhJUFk4WVhX?=
 =?utf-8?B?Qy9RNXpLcHdyZWQyRStGMnViN25vYzlLdldFVjhQTnAxOWs1Yk9OTG40djVn?=
 =?utf-8?B?ZDFCdXU0ajlJOHZsWGdneURva3ZySnhyUnFybTI1VHJ3WlREcFFkRldvbGNr?=
 =?utf-8?B?MmhOZCswZnBKQStzenUwRFNObzArZjFkMllpNjRZdURoL2tEbnpUZmVFWVlQ?=
 =?utf-8?B?Slc4cGwza3Z2K05XM0xuYUlOV3hzNlkrS1htbjYrc0FUOHpGQjJrMXB1eEVi?=
 =?utf-8?B?cFBCMElNOEVxOHZzRmd3TjFKVmdSU1BpSFdkalBlWFBlTEErdUpGSXRiNEpG?=
 =?utf-8?B?MlptL255NGl4U1RWRlZPeXNFZ2tHd0M4Mkt1OG1GVkxHUnNXREhGeHVWZmRZ?=
 =?utf-8?B?Zy9Ya3NYbUF3bG1yQkRFUnp6T1dvd2tGNDlWcklYRzdYTGw0TDliSXoyUHBT?=
 =?utf-8?B?bURaYmgrbHY1ZGZyb0o3L1IxMC9GdDF6dmYrNGNiRHl5LzFDck1BMTJnY1F3?=
 =?utf-8?B?aU5WcnByTjczbHZnRkdsTVlRU1I2NnhIamc3VWVIcGFyUHowbWgvWDZEOU11?=
 =?utf-8?Q?AxQtvYoIkyHYX4PA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M3cngJEvkFuurESqdwsRbufXMuRoqMkoe6jxfomI88XKAiMl7ZpyE5ss46HqjTtO3g4uf7YqDnk/nQDsPkB1r6tIelsYVMm01y5Nd9qG/rlyVJybZfaL9H+9ijc4ui8EXmDe41aKbVnxbq4xOpX3Ma0UKZS4roN3UnszvRSu76YH0sGNhcw8/0A/AyBV9EKiitGKA1lf46ndW/+UJDUSzxpuR25eDuanCI1ZudbTl/lMPnr1f/mYSg+QHVshBtO3/75kI1ed51WwnsOgM3pqnzpMvPOLPLFrWxpdcm/Sg8OVr2SntFxTlEfhY1WS3fH7WFbYSKe0oLxQ7x8Fj3veRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fb89e6-e749-4c05-6fde-08de7f4ed4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:16:08.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h47sHmLqaUCG9vERJMTMEVxi4anH3F71frhZm7Ao4Df9aB1l1rCKts+uUTjDLDD04Kf+AvEB5gcJrSB0AOLGrVWD6Gml2s+5NUYuU0ZCqVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: DC9002605B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1085-lists,linux-sctp=lfdr.de];
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
	RCPT_COUNT_GT_50(0.00)[67];
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
bS5kZT4NCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz47IERhdmlkIFZlcm5ldCA8dm9p
ZEBtYW5pZmF1bHQuY29tPjsNCj4gQW5kcmVhIFJpZ2hpIDxhcmlnaGlAbnZpZGlhLmNvbT47IENo
YW5nd29vIE1pbiA8Y2hhbmd3b29AaWdhbGlhLmNvbT47DQo+IEluZ28gTW9sbmFyIDxtaW5nb0By
ZWRoYXQuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsNCj4gSnVy
aSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPjsgVmluY2VudCBHdWl0dG90DQo+IDx2aW5j
ZW50Lmd1aXR0b3RAbGluYXJvLm9yZz47IERpZXRtYXIgRWdnZW1hbm4NCj4gPGRpZXRtYXIuZWdn
ZW1hbm5AYXJtLmNvbT47IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPjsgQmVu
DQo+IFNlZ2FsbCA8YnNlZ2FsbEBnb29nbGUuY29tPjsgTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNl
LmRlPjsgVmFsZW50aW4NCj4gU2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggMTYvNjFdIHNjaGVkOiBQcmVmZXIgSVNfRVJS
X09SX05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiANCj4gUHJlZmVyIHVzaW5nIElT
X0VSUl9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQgYSBtYW51YWwgTlVMTA0KPiBj
aGVjay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2NjaW5lbGxlLg0KPiANCj4gVG86
IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz4NCj4gVG86IERhdmlkIFZlcm5ldCA8dm9pZEBtYW5p
ZmF1bHQuY29tPg0KPiBUbzogQW5kcmVhIFJpZ2hpIDxhcmlnaGlAbnZpZGlhLmNvbT4NCj4gVG86
IENoYW5nd29vIE1pbiA8Y2hhbmd3b29AaWdhbGlhLmNvbT4NCj4gVG86IEluZ28gTW9sbmFyIDxt
aW5nb0ByZWRoYXQuY29tPg0KPiBUbzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQu
b3JnPg0KPiBUbzogSnVyaSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPg0KPiBUbzogVmlu
Y2VudCBHdWl0dG90IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz4NCj4gVG86IERpZXRtYXIg
RWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4NCj4gVG86IFN0ZXZlbiBSb3N0ZWR0
IDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0KPiBUbzogQmVuIFNlZ2FsbCA8YnNlZ2FsbEBnb29nbGUu
Y29tPg0KPiBUbzogTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPg0KPiBUbzogVmFsZW50aW4g
U2NobmVpZGVyIDx2c2NobmVpZEByZWRoYXQuY29tPg0KPiBDYzogc2NoZWQtZXh0QGxpc3RzLmxp
bnV4LmRldg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAga2VybmVsL3Nj
aGVkL2V4dC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2V4dC5jIGIva2VybmVs
L3NjaGVkL2V4dC5jIGluZGV4DQo+IDE1OTQ5ODdkNjM3YjA5ZTU4NmFlNzg4YjdmMmU2MzM2MzMy
ZDYwNWEuLmNmYTg2OWJkN2RlNTQwNmE1Y2EwOTQ5OTJhYjANCj4gNGM2MmIwZTkyZmQwIDEwMDY0
NA0KPiAtLS0gYS9rZXJuZWwvc2NoZWQvZXh0LmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2V4dC5j
DQo+IEBAIC0zNjg4LDcgKzM2ODgsNyBAQCBzdGF0aWMgdm9pZCBzY3hfc2NoZWRfZnJlZV9yY3Vf
d29yayhzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QgKndvcmspDQo+ICAJZG8gew0KPiAgCQlyaGFzaHRh
YmxlX3dhbGtfc3RhcnQoJnJodF9pdGVyKTsNCj4gDQo+IC0JCXdoaWxlICgoZHNxID0gcmhhc2h0
YWJsZV93YWxrX25leHQoJnJodF9pdGVyKSkgJiYNCj4gIUlTX0VSUihkc3EpKQ0KPiArCQl3aGls
ZSAoIUlTX0VSUl9PUl9OVUxMKChkc3EgPQ0KPiByaGFzaHRhYmxlX3dhbGtfbmV4dCgmcmh0X2l0
ZXIpKSkpDQo+ICAJCQlkZXN0cm95X2RzcShzY2gsIGRzcS0+aWQpOw0KPiANCj4gIAkJcmhhc2h0
YWJsZV93YWxrX3N0b3AoJnJodF9pdGVyKTsNCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdl
ZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+
DQo=

