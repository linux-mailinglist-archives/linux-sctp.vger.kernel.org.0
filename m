Return-Path: <linux-sctp+bounces-1089-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMbPAVc3sWmesgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1089-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:35:19 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1AA260AB8
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C026E341EFD2
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC93C7DE4;
	Wed, 11 Mar 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsyNZgGE"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0839934D;
	Wed, 11 Mar 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220916; cv=fail; b=moqaFs+bCs2/9NCHI7V8grhTd/f0z41cMJG7OIosc4JpUnkSw5JT627Cmjq9nB2h3IHQgE0x+sWQ+ZdwLSH95pcVzOCesnLIW51bsZ+3dUQOnTZb+LwNr5w4n1MP9cs5tQuAOwXh0Pcecp7GO3ctrW/4mbYdqfCEGUGqs8rYwGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220916; c=relaxed/simple;
	bh=v1t280Vnao4M3LdN6N1OEluSWRx5I9iIpTKM8xy2hGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fr4OcOhkBhOPmpHK3pi6crc27ka6xoQf9wzXWVJ0VB4RUId+IYJvY9nu8Ek+/O3InLhIiQvxq5eGMznjVK6xBJdII1KjU2dwQlh1BOLLcO+Xe6JfGQFmqJVFBKxRHCnKJMzPLSHaiHdPl2Ax/7tI5CBQiVBDV6Abl10+W+YJgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsyNZgGE; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220909; x=1804756909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v1t280Vnao4M3LdN6N1OEluSWRx5I9iIpTKM8xy2hGw=;
  b=TsyNZgGEA2VGvFN83tk24jltyOyG2g/v+VWpx494him/werf82Q8QupA
   HKEywwun2MyUZ6q5Uofld1/xGSxtAC4/RpGuDIxwg+JOCT7oHEBytcFZ5
   ANnWQNxwxwo2OZkM1bV0qsOOtUmWciTwPYNKuR1IiZMZBlLrGTUhTTmX1
   L5o5K8ef2aMC18ocwM4CT0Y/u8xzOth1sMJSbPlaMV6cOyQElUIk1vtYr
   pL51VIk6HcfuZ22uqDEvxi8YwuQQV6sl71cjSscTaK657wT6ckJrcMpJe
   W8TxAyvLU6NDDZC6Bov+MXk1N7XAXJZ5/WXcQFMkC5bWMIfXqn26dAWU/
   g==;
X-CSE-ConnectionGUID: Yrqo/1dvQWazNwGCIoCNlg==
X-CSE-MsgGUID: GNwJZRDLSACJdwLv8Yb0qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="61856362"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="61856362"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:21:45 -0700
X-CSE-ConnectionGUID: N/7289b9QyiHBtEPBGJDwA==
X-CSE-MsgGUID: JtgS+kDiQyOaY4gnmZIOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="258315167"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:21:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:21:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:21:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXodpLz1ypWACOxjs5Y2yzW80sowbvJYr/aIvDxxQl+ZmlEnPh/FM7km0tAylRfL9xBtInzAJj8Y858Jm2zhRKRHmUnzF1EhKbTKFQI2W3H2H7u3Azyq/LSNGld25wR6ZzkEV7GWoU0rjEFQHWdwbcjwrmSZ1cYfU9cTJD32n45m2b7ipHs+R8ZrDySuZjzNS4x8hckwOdgZ1wXm/GCKgbO/QnWPyTk3m7KADq8I67kSJ3zcD09BbI7zMV+WtfRUXxDaO0XQpRKydHfAtD2/zMb50M3vACZ6k2brlpDiEHMgGQnoNAmNmy6s2bkIuix/XiCDq5L9HIGtfuc6UWp2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1t280Vnao4M3LdN6N1OEluSWRx5I9iIpTKM8xy2hGw=;
 b=iAyEiRaFvhPZh09LE1osOGyngK3EbAzskXqsUU+kRwDn6PCUsYxBt6m9xUoDJQA3Z6xCNEyUWZvjJYD3NV9587UfrVsWitiaYljh3Z9IRbiKP+526n6MrPquTuh9wKXSjStSm12Xge6Bn7WBu4QaR+MIv8bUbTIsz/228IdbRldaB8Xe0qt/GpP0B+/yhWOoO8ujD486aziCbOQVsKRT2TvptQ0nVwTWJJ7d3U7v5rVh52B5x2F61jD+Z4VUzMKX6Ea1LO66VZHgTSaYwtFySc5wCmyQLkmeZ98yngjbmpHWszjpjbC81JMJv80RBPa8IOoyR5voDkE1b1pWYhHjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 09:21:40 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:21:40 +0000
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
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH 25/61] net/bluetooth: Prefer
 IS_ERR_OR_NULL over manual NULL check
Thread-Topic: [Intel-wired-lan] [PATCH 25/61] net/bluetooth: Prefer
 IS_ERR_OR_NULL over manual NULL check
Thread-Index: AQHcsKKfY2LGU59NIUyiYsEtTLG4YrWpD5cA
Date: Wed, 11 Mar 2026 09:21:40 +0000
Message-ID: <IA3PR11MB8986984785C5D967485333E8E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7897:EE_
x-ms-office365-filtering-correlation-id: 7226963e-0fed-4154-d9cb-08de7f4f9a57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: fJZ5n8hAlyXDfP0YDfkDn7z6vFCt+GrYnz30UYmYjojmxfDFquyzt5QyTDe9wxdqAjAhxkFW2Dwsh5dNNRKcChxLhdRKRe62KmneDcetFkttgK9sacTWDioY3H/qcGKQt0jU1RL0KGZHSDKbCl4dQWRsQkJ/aZncoa53wbbuvAIP2u5/31nFdScaUFkhW9pe8nvCt7PZMS4psIDrtFHcWmgLBB3671Ai3D4BmI/qCX7ztZ3kQDVRACYTGVh5QN+QMSrkOukQxY9qTanZkqO2po7GSA3RClaD6r3Y9jAG1kNQPnWmBKjdoznlKfWWglhG4ixnfDw+qFL2W7vThVD3QzdZV977pmrIDWdwvbQMQ03yFfK4pHj5MHhRME2QT9h+ilPtEpTmroVd/xK3Aum6b5GfTsP+AgonPjB6YOXiVBRjMLI1/soSOgRQ4ii44eN5YCFPPpBWOUIpWss8FJNuzDsfrrVlg2BzHXyzhxErAL5uaE59wkecYdk4mhM3Dxxt+4jC1U1jmSeT89QQExeDQ9F4c4CNXoJR5IeOvpwKQEBuGT5gBJiX5FqkIAf6DvApKzoZm+UMesTjQ043jNazxStk4HQrlZv2KOknuMa8gUkGPQ/JSugLkJvRW0Yp6gxm1Yfe+JWNJjt4d3DBCO5WyGpR/VE87+/dPVqdA+iS0IN8GZKUT8ZZE0M5UBU64/hj5VE0KZManqnyMLdFj5guyHjfcuE4omOqM7zmo2WJ8zt4VMt4UtmobAt1OmMt15GBcD4JZpXEjdYM6U4gxEHxUet15xjMlPNmbP36pbe7Ewzq9O9A8ixqgObSPQNSC+0v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnhKTG9nd3I5V0YySC9UNGpUc3VIUGZhdXRUQlcwQ3d0TFMzZ293V1kzWGNs?=
 =?utf-8?B?N1JKQ014Yld3S3dZbi8wVlFaUnhVNldVQ00vODNyWGp1enZWY0svZE45R3Bp?=
 =?utf-8?B?aHIrbGpCUEVZelNTSmxlTUhCNm5pek5yY1E4SmhJSG1oMVlUTXR3YjIyTE1o?=
 =?utf-8?B?QTNyS0hTbGNjalFnWHc0NEtSd0Y3TDVXWGtUcDJSRWpUdisxU1F0Y0FjdVd2?=
 =?utf-8?B?L2M1VTRWUm5FeE9qU0hwY1FzbzI3MzUvZk1uMGpXbndWTzVhS3R0VVNEYmE0?=
 =?utf-8?B?cEdsR05BdkJtUElxb0xocE5uZm55NUtCVTViNjIyR0hKQzBRcUtiempGNCtO?=
 =?utf-8?B?Mm1XcEZnbWNlOHpSWnY0WTJnSHNrS0Q5L1FvUmJnY1Bra1g3amJkMUc0Rmpq?=
 =?utf-8?B?Mmw1SnF3c1Jad3BsRkQwbG5YMVlNU0V1RENFV2FlY3JNMFpXYjN0TkdabWEv?=
 =?utf-8?B?SWFCbklENGRVTDNDYTYzL1J0NGc2MThtTkFMZXZGM1k0M211YUx0eTEwV3BC?=
 =?utf-8?B?OVNYcVdLczBxekE1Smw4YjNPYzdaWDJndEg1cTJMZFBKSzJYU0lvTVgyQ0JU?=
 =?utf-8?B?dnRmT0FreU92bkJXV3dzOUFqd1VRTnJZOTM3bXljNjljcUxHRDU2S25zWnha?=
 =?utf-8?B?TnJ6KzVzR0xNR2ZQNzFGNVNsRVduTllOV2hTc3ZVMS9FNklkMmVWTytNV0Vq?=
 =?utf-8?B?b3pnOXFPb3FVcXZpVEFOd25xNHNmYW9NeWFXa0VwNkdCNlpmZmNXaVFRMVl1?=
 =?utf-8?B?SXVQQjVlWmd5VFZiMk9xTXRhMUw0SUZiWjQwclpiNk11MktlSEpYWUZ6ckdk?=
 =?utf-8?B?U3cyK1ozT3FxN1ZZZlkzKzhrcTlDMzRRZ3lEMWFvTFp3V0hTOTJMVkhSWWFx?=
 =?utf-8?B?cEhVWEZ4RUNieFk5VVNBSEowYU9ua2VOM3RjNFZJbVZ4cFgyc2R3cHZNT3ZJ?=
 =?utf-8?B?SUJMY2k1RlZzbVRSb3B6ZFN4RnpxQS9mdkQ4RmdxMTVxOU1hQUxYU1JIa3p4?=
 =?utf-8?B?M3RxbHFWR1c0WW9QOW1aSkZ4aWRSUTczMWZPamt4QlNjLzBnQ0s5ZHVUZ3ZF?=
 =?utf-8?B?cnNlaE9aMTcxWWxSOXVIWjdaNWpKQmZoZzRId3hSMTgzVFowZHAzZDBvSjN2?=
 =?utf-8?B?bW9yS1N1SklheXJqVVRCQVpMbENrLytGdXNISXVHbFE5WnE3aEs0UzRpNGlr?=
 =?utf-8?B?OHdCYzRHTWhjdG55VVgxVTRQdlJDd3d6SFhkaVJWQUc5Z3lmZUh5UnFtTlVN?=
 =?utf-8?B?KzZwVnlqQ3R5dkpsYmk0dU8zVHAyUXh5clAzNkR2L1NrSXUxMFRMcE9HbEhS?=
 =?utf-8?B?eWphcWdmS3cwMUo2UUJqMDVMSUtTMlQ2Vnpab0EwNUJtb3lyWFh1RXZKbm1n?=
 =?utf-8?B?TkVWaWs0dCt0Uzh2Wm9pNlA3TDhTWTJQaStLRys3Q0gyYTF3bTNPQkY2dSsy?=
 =?utf-8?B?U1IzZEY3dnhSbXpHQngzUnNYb0JBME9KTWR6blVueDRTYzRTM2lJOUNXdVFL?=
 =?utf-8?B?WVhIemxhNTl5WGxmTk1BTkZsQTc3N1hTWFIzWDI4YTNLNGN6NGdNOTI0S2k0?=
 =?utf-8?B?bmNNNzNJbnptVk1BZlllVW1OZzRWdVhlaGRHQzk4eEtYclBJZmp1aVFCaFFn?=
 =?utf-8?B?YThtYk00b2hpWlVRKy9mMUxXOWVvZ0tnNHUxRVVoR3hoMWpScmF6TW9lZTVD?=
 =?utf-8?B?QU9Ub2Z2cDdna0U4M3c3RTEvdkdwNW1ieWYyRXNCcGUxQUJ3d3p1STM0R2ZK?=
 =?utf-8?B?ZmprNkxUNVR5Sy9sODllaXZPTGFzRThmRWRrOHo5NmJqK0FzdmRuaTc2Z0xI?=
 =?utf-8?B?NnBRK2VaV3cxKzJOMW5XWjJXcjJZUENkL1RHRGFOb2NVWVQwY2pYc2x3UzhY?=
 =?utf-8?B?aWgrelgyL1NUQzZ4b0JXcHFHZjkxQ09SNHZ0bkQzZEFNdkJYL0ppdWkrZCsy?=
 =?utf-8?B?Y3JER08zV0dKTEY4MnlwS1FqK0MzQUtQK0plQitNbmw4SDFjRzBWRWQ2ck9a?=
 =?utf-8?B?aCtpUU5HRVRWczVQS2FuT2tra1FtNkw0MDRESXRkZlIwam5tc1Vmc21kbzU3?=
 =?utf-8?B?b2VxUE5ZZ2JORllYb3ljc1Jxb2lrZlVsK0thb0FTWlh5WjZ4UlZ2Y094N0tY?=
 =?utf-8?B?OElCbmNKazdxK0ZQVEpsV1ZNOTNTcEdtZThuMTAzb0lqSUNZOUFNTjMzZEZR?=
 =?utf-8?B?M0JYa3h6NzBBcFpOd0g4a2dRU1M1c0JIWi9aVDhIcTdZVjVHZ3dzYjBVeXhn?=
 =?utf-8?B?SXp3OEh1RDlHZzZXRG9LaUJIYmhVYWh2dENYNlNiWW5oNnhmSVVFRGlaUzZZ?=
 =?utf-8?B?YnFRUW14RjJOMHZNS3ZFK08wUVNLZ0k3VVlVMUhYYTlVaVdONnFMOCtNaitk?=
 =?utf-8?Q?dp6qTd4tTyIr8nxA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EKSgq8YxyB6SQjCJLYlEMyCI3jNphKsg/+Qj8bvXgpnOPyghf/rR8MM+q1SNVS4rhfFdDEHbU16vqV1PJF+ZgwX3bghoHtvlt9wI/QqzyHK2Y441h+FPRqe68t1OMy/31wxjO51TkQHuZXGGM9yGmtUGmn95KTo3N/pxYO2LbbmWzjcGvfqCIgCXmy0ufA/+MzqhNd0Lmk2bPYsbPy1EB6bSe+OL4aZactvdB4wdqgS+QgLaQq82yViuNZ/+NWU1oufNHIpKLPyFvIQoXQvx4Rc2C/ZlRQgzKYrWuz5goSXRUEuI7rontLLjHpP0W54mjZOPsSu3FCLdmJxxNiRlGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226963e-0fed-4154-d9cb-08de7f4f9a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:21:40.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXVyM1udEKOqZuvOHaP8T8W4bTGeVYOjXfLAgEw/Lyi0EG1f9FPPOfFsv8kpQvm1q6xkaU61sKgabJVhEvk/ZHNb+mqLMIoMp777pmRqkgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9C1AA260AB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1089-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com];
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
bS5kZT4NCj4gQ2M6IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz47IEpvaGFu
IEhlZGJlcmcNCj4gPGpvaGFuLmhlZGJlcmdAZ21haWwuY29tPjsgTHVpeiBBdWd1c3RvIHZvbiBE
ZW50eg0KPiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1s
YW5dIFtQQVRDSCAyNS82MV0gbmV0L2JsdWV0b290aDogUHJlZmVyDQo+IElTX0VSUl9PUl9OVUxM
IG92ZXIgbWFudWFsIE5VTEwgY2hlY2sNCj4gDQo+IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVM
TCgpIG92ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEgbWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0K
PiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2luZWxsZS4NCj4gDQo+IFRvOiBNYXJjZWwgSG9s
dG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IFRvOiBKb2hhbiBIZWRiZXJnIDxqb2hhbi5o
ZWRiZXJnQGdtYWlsLmNvbT4NCj4gVG86IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVu
dHpAZ21haWwuY29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
IEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAgbmV0L2JsdWV0b290aC9tZ210LmMg
fCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL21nbXQuYyBiL25ldC9ibHVl
dG9vdGgvbWdtdC5jIGluZGV4DQo+IGE3MjM4ZmQzYjAzYmI1NGYzOWFmMWFmZWU3NGRjMWFjZDkz
MWMzMjQuLjA2ZDJkYTY3YmJlMTRlMTdlZTQ3OGFhOTM5ZGUNCj4gMjY1MjZjMzMzZDkxIDEwMDY0
NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL21nbXQuYw0KPiArKysgYi9uZXQvYmx1ZXRvb3RoL21n
bXQuYw0KPiBAQCAtNDE2OSw3ICs0MTY5LDcgQEAgc3RhdGljIHZvaWQgc2V0X2RlZmF1bHRfcGh5
X2NvbXBsZXRlKHN0cnVjdA0KPiBoY2lfZGV2ICpoZGV2LCB2b2lkICpkYXRhLCBpbnQgZXJyKQ0K
PiAgCQltZ210X3BoeV9jb25maWd1cmF0aW9uX2NoYW5nZWQoaGRldiwgY21kLT5zayk7DQo+ICAJ
fQ0KPiANCj4gLQlpZiAoc2tiICYmICFJU19FUlIoc2tiKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9O
VUxMKHNrYikpDQo+ICAJCWtmcmVlX3NrYihza2IpOw0KPiANCj4gIAltZ210X3BlbmRpbmdfZnJl
ZShjbWQpOw0KPiBAQCAtNTczMCw3ICs1NzMwLDcgQEAgc3RhdGljIHZvaWQgcmVhZF9sb2NhbF9v
b2JfZGF0YV9jb21wbGV0ZShzdHJ1Y3QNCj4gaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwNCj4g
IAkJCSAgTUdNVF9TVEFUVVNfU1VDQ0VTUywgJm1nbXRfcnAsIHJwX3NpemUpOw0KPiANCj4gIHJl
bW92ZToNCj4gLQlpZiAoc2tiICYmICFJU19FUlIoc2tiKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9O
VUxMKHNrYikpDQo+ICAJCWtmcmVlX3NrYihza2IpOw0KPiANCj4gIAltZ210X3BlbmRpbmdfZnJl
ZShjbWQpOw0KPiBAQCAtODI3Nyw3ICs4Mjc3LDcgQEAgc3RhdGljIHZvaWQNCj4gcmVhZF9sb2Nh
bF9vb2JfZXh0X2RhdGFfY29tcGxldGUoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEs
DQo+ICAJCQkJIG1nbXRfcnAsIHNpemVvZigqbWdtdF9ycCkgKyBlaXJfbGVuLA0KPiAgCQkJCSBI
Q0lfTUdNVF9PT0JfREFUQV9FVkVOVFMsIGNtZC0+c2spOw0KPiAgZG9uZToNCj4gLQlpZiAoc2ti
ICYmICFJU19FUlIoc2tiKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHNrYikpDQo+ICAJCWtm
cmVlX3NrYihza2IpOw0KPiANCj4gIAlrZnJlZShtZ210X3JwKTsNCj4gDQo+IC0tDQo+IDIuNDMu
MA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25v
dkBpbnRlbC5jb20+DQo=

