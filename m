Return-Path: <linux-sctp+bounces-1064-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFc5ONIzsGnRhAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1064-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 16:08:02 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF8252E7C
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA3BD3030A05
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905730F7FA;
	Tue, 10 Mar 2026 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KELOA0oT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC692F3C3D;
	Tue, 10 Mar 2026 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155266; cv=fail; b=Exx5Jo29t21AuKh+iutjP1O0HSCp0cTKN3jSHmESFmCb82jBvH+v87T3MZm+bogwy5fCEt/ScOWfrDBE0q/gXILAo2WOUwSGCsx6TOM5xnEWqM1XvaJ02V2loLjfC1/KZvyH/07kYjIsvP8z+FOjzpi4YU5PwT7wXUh9rvWy6Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155266; c=relaxed/simple;
	bh=/dx0jFElRQCzuElB3xkafsU3B0B1oyWjkQOIQutQeyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvIzuLJd9pgigyrZaF66ydVCQRo34iBy9HdYHT49IspRGBNycsAf49AW5GexfaGq9kDM/ymfmbZr1YSFyBY+u4RZx/6nqQDnrJPmYgfJqx7FMX+cNoupQNpu9RbsfHl1qgx6rBo4HwICn9plRvu7mftXOWCLOB5peV/i7nPl6Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KELOA0oT; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A6bbZM1846057;
	Tue, 10 Mar 2026 08:07:37 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022097.outbound.protection.outlook.com [52.101.48.97])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte6uhnn4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 08:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mABx9NN/5C+R6XHBdjNDb3cqTt37N6+Lar2wFnkT+YKPW+7caZRxdlkyGoYWJVV34i1xL6Be3Uv+wdsBOsMeEeoZX6InTXp6Vr1/SBGCEtDSnBF3i1ugY/CsbBA27kt6TykgNOzCrawQ6wZVe7x7Olk7qrOs9lazKmLcev5rYwe1JJWWKapAPeBonzYR/63JGzpeFfnanR0y47drlaRoWbhzGwrsXnaxewmI7af71eZQj7uiMhBo0YjtY7LHb0H8GjM3md5s79rOv7G5McY73MQx5OPDZNkkeTa6t5oW1jbZnUAjKLqQEQtkRgJUKceTKdRT/TB47nHzyuFMz4VlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dx0jFElRQCzuElB3xkafsU3B0B1oyWjkQOIQutQeyI=;
 b=zRq8Ech820q8slEFhIannEobkplOx9ojLx3RImupb6UKASMVdgxjWVpSuQAoAZhZbggPjA6/anCxhJ8XiUhQHfyiOYi1rdpERFg13d09QB+HW09msnq948Okc2ZAkQtRCFDBTjbuZcFBGZmzZEtOoWSKooLaHUeKkZNN2vAqm1vQYfaQx00HV50btNkUCt0DJkVZYZLFP6EcWPqJ+3f4R6q+K7A9Tml3n11SN/EXtFe4S1rEtdgAn6zr8zPDy5apOeiaez6FiQ9Si/7dryxiuvjJ/yqEnNVY6wlig/yR1R0CcBWXOokCiLOnDwMqfElPWctTOhS+xkO+jbkmiSX0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dx0jFElRQCzuElB3xkafsU3B0B1oyWjkQOIQutQeyI=;
 b=KELOA0oT2dz9pXYGVjzVlBVL6naqUFQRhiiusj3iCuZqAMScT7fJUF30V7icKDopFXbPSpFvX8U3tNZLBHb2ChgmIIjSeQpmDFhpXCRUExhtOvv4Qtsjbr8RVANEPClR7emCMQJH55NUST/sosG2qIaL0sRow5JvI52ArCouJks=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by SN7PR18MB4400.namprd18.prod.outlook.com (2603:10b6:806:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 15:07:29 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::8581:a781:5bfd:fc1b%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 15:07:29 +0000
From: Elad Nachman <enachman@marvell.com>
To: Philipp Hahn <phahn-oss@avm.de>,
        "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>,
        "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "cocci@inria.fr"
	<cocci@inria.fr>,
        "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>,
        "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
        "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
	<linux-security-module@vger.kernel.org>,
        "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>,
        "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>,
        "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>,
        "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
        "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: Igor Russkikh <irusskikh@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Michael Chan
	<mchan@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Tony Nguyen
	<anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar
	<keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: RE: [EXTERNAL] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over manual
 NULL check
Thread-Topic: [EXTERNAL] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over manual
 NULL check
Thread-Index: AQHcsIkeZ/xggwHfFkuIUZ5RP4ycHrWn3KSw
Date: Tue, 10 Mar 2026 15:07:29 +0000
Message-ID:
 <BN9PR18MB425115D21F4E30DD480F56E7DB46A@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|SN7PR18MB4400:EE_
x-ms-office365-filtering-correlation-id: abfe42a5-442b-464d-4fff-08de7eb6bf6d
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 lIcbvYB7WZbatPehR+tNCJXPsytgVz8ncaoaPmz12te01Q/D8LntZ8ctwi/EnN5SuXfgyt4wvlVvLhS+kzTTqQbPvfu3V4oA6r7A6r20z3gkG2dEUsOF18S7doEjcQF03RVb0K3hXr2nUGU7lcvU1C7QUnvLucoPiyXTZWdmVLWoFy4N3zboFt3WoUrcPDdUzBB+ZyibNSiRWW9aZs4bQxl+D2q0Zjc7BZRUmN8HwMWccM+ZMz4k7Ai7aVgSyqUDVUb+45LckE4oFqoFWhsXVffS7dcVMCaiDN3dWIgZg5ar4Kkz12uCTLSjUVrrl3cB01yhuS2jZyRtP00RlqAyo5s6MpwWSqR7cDG/r8r7mxVUKzFEMaDveSXVhaM8Bpx2nd0oa02Mehcfxzz3GFeggrniABU7i+IGs9KQEr2WEc0hHiShki5HIl11CsGAZjEj2YMM+6YzTXapBW8UkSK4NQuH7rVoMNv1j9tXI0RYNIobvBi1sIuuIXbuo+09gN6zWeO+Gg3PUMfge6pUtgRBe6vzyb+yFSC1LrINVjgq7tfDapRDvnC+ifzj3pMRFf2dYuwemnqzszpKPVXxEkRitBoAS0L00MZLqvL37OkZMvMLIRN0aKTpszr4qULcuousalYR0aX0l7A3dR++sS+LbSvtM7PsvGJNBzSRF5BYM1/K3sdI2FGn3h6/4gQKgXS2z7o6Kl/mvN3OTYS5RAVfQIrEvC4oasmzWn6zSlWi9jCB4OshPprQEf6Ha2katbsGiQXryezqWn5/pNhp2KrNeLHssFiyD45DNGGFFvOESmKFOEV5e5kqdPYGFJ25fFbj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGp5R0N1UkppWkZkNk9kZWFoeC9Ta0F5VHNMcTh1eTVONkI2WXR4Q0doUE52?=
 =?utf-8?B?U3FWcHVqZkhXOTlERDk3RWF5bDZMRitXK1YxY3ZKY25uQXNsY20xOHVFdGhI?=
 =?utf-8?B?b2tDUkZEZVZMRjdZTHcyZjdiMkYzUE1RRjdacG43eWZQalUvOWx4dDBZUytO?=
 =?utf-8?B?a1IrZ1lrQ2hoZjRQbWF4R3BsZXNyS3ZMdHIyeE1ZYjlnZG1LTlVISExkamtU?=
 =?utf-8?B?NEpVSVZsc0NMZ042L3FScmhvMlRCWEhHeUxIbFJqTWpPd013NXhRYW9MYVN2?=
 =?utf-8?B?a2R3YytreGwwWXJrdDgzMjhMbDB2ZERPa0dCcEQ4ZGRQQTJYVFlQVHFKeFBw?=
 =?utf-8?B?TTBFbkQ1djJNY2FrSU16WWxaandGMlFhU0NkREZiUGdaSk9JcWEyTVVJcnFw?=
 =?utf-8?B?RVJrRTBXSFdoVGswNHZoOFRwYm9rd2Z3eEhETVYzaDBYbEkxZldHTG5PaWhJ?=
 =?utf-8?B?MndCUS9yUlFyZTFieVM0UVVja2ZLR01IUTdxN0dpVXlNakt6NjhCUkpuZ0Q1?=
 =?utf-8?B?NHdETUpJY1I5YlZ5QkM2MUFENU1IUVFJUkVWNFh2QU9kNDF6SFN5em5KZEZ3?=
 =?utf-8?B?OHFZa1pWVGUyZ3ZxQ09ObEpLNFpJdXdad1ltOHRQTlpxSEoyZWowS3lIbUVL?=
 =?utf-8?B?c21XT3dXVnNsOGlqNmZ2NExRS0l4MGZSejFaZXdueDRCdklkUllFdlROOUds?=
 =?utf-8?B?YTB1TXZybGQ4TnczRk9kbWJ6NGcxdnA2SWI0NVo2Wk5Lc2NnaVA2TEVtL251?=
 =?utf-8?B?U0hISFhwQlpCakJuQjZka25QOHF2ZVpYZnVhYTJCZXhwZW5qTGsyRFNyRlVZ?=
 =?utf-8?B?Ty9IbHcvOUZBeC9Xa3Y4akVKN05RMlc5UnJ5Z1grZzFsWU91L2N6aUxyL1lC?=
 =?utf-8?B?dWtobVpid1RBallLeE5xVTFndnhBTnJmVG1STklWSWlta3pha2NJTHVKcG01?=
 =?utf-8?B?LzA4THV2amZnM21zWmdBU0FlSmRKS1BGcTFKTGJWbDZIWEVpNEF6Zy9kalc1?=
 =?utf-8?B?d3kxbTBsUVl1R1F6cUFudHVyZ2Z6OXJuNWt0NWlsOEFNMDFqdEVFeWo2WGlI?=
 =?utf-8?B?Z0ozelJEQm0yRUg3ZytUYzdrQnI3Q0lzV2dWc2F4NHBsV2p3Sk9EWmJCUEZ1?=
 =?utf-8?B?R1Z2WnN2bnZkL284M1VtZ1BQYURYbS9yTFArUDBoTXZ3L1R2Q3N4WUo5OFla?=
 =?utf-8?B?RDVhYVZyc3YxbU5sbkorV2dUdWdLYmRjbkFCeXQ5U0FndnJFcFpteURxRVJS?=
 =?utf-8?B?SlFnSTczSzA0dnZEem1PdWxpR1JSd0NNOWp5c0xJRUdXQ2NXRmxKYWRVWFNC?=
 =?utf-8?B?MG5EOU1OM0RoblBPeVpRU1pqUmlGTFgyM0hhOWpVQUsxQXhKVCt4cDJlVkhD?=
 =?utf-8?B?NmxmUldEcG05eUZBWDZWQVV6aGVTTXVrNkdZNC9ZWTloRk9Ec3pLb3QxT1Q1?=
 =?utf-8?B?azhISDVVN1lTcVZ6bDlLS0ozY1crMkdsNTdicjJvRzBPSVdJZkdTYnhDR241?=
 =?utf-8?B?K0U0QzM5S0Z2Rk9CUlp4Wjc5V2dwbW9GcmRxckZSWi9Hb2d5UTF3TnZ0cHFQ?=
 =?utf-8?B?UnVOQXNBZ0czRDZaZnIxaGd1V2xtcWhGdlhFTEhUWWdlUEpzcXRWWm9jYkxx?=
 =?utf-8?B?WHVYSUIrY0FQMk9MRTBLcUw0eEZ0V05VTGFqeFJaa3Jmcmo5ZzlYWWgwSXAz?=
 =?utf-8?B?bDh0eHo3VkphcTBMcEdKZE84S0dOMEZuK21zcEdkU0lhYUFoS3JYemVnRTZ5?=
 =?utf-8?B?NlRVeWJ6RGtyZzdBUDJsTFFWZnYwWlBsY1RtTEZtTDRLc2pVWGxFQnBqZ0tZ?=
 =?utf-8?B?VEMxbjhCNXpkMkF1ZVprR0Mxa0tuTG8zTElMaENKK3JiYlNaRUxKNnZJTHkr?=
 =?utf-8?B?eElvSkw1bTlJTDE3NUNCV2tjME92SE5DZm9nK3ovZVA3MW9zUWMxaDVXa3FN?=
 =?utf-8?B?K3hEczVUbkJkZS9RMklUcFlzMHU2OHBBSjl3bUwybCtJdVRRSGxkdTlGU1Bm?=
 =?utf-8?B?RmJHTEhaRFFCMWZRNEE0UEF6VU02c2d4WWt5T3BiQ3ozclRDOWEzU1dsUVVC?=
 =?utf-8?B?cmFiTWIrQVBzYUI1MUw1UFFVVEgzNFBxSzRTM3hTekY3bTJLMFNUWGZ5VWlS?=
 =?utf-8?B?VEk2VStnMmk2YTJZd2ZEeUgva1h3RmZyYjJKUlhXUDhBSkJ1Z09IMlljR2g0?=
 =?utf-8?B?ZkxZMmpvaVMxcFA3MzI2MEZpNFF0VWR1SlFyU2lqUVdyT1V6NmY0a0Z4SEdi?=
 =?utf-8?B?TDJ1cEYrSS9KUGtEcmNsQkU0bTJ5d0JjeXd2cjlrTkY2Q3RscS96QzBjQXhW?=
 =?utf-8?B?NFhDek1wL2FGM0ZScmhGbnVKSXg0V25Dbmtkd3ludDZMTDlGUGJqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XTdsE3xw+r72za5XcswWbolKIfSFnh0plbDzuAgMAiCvxvFRvqD4Q2UBVPEeRsz2ZNnBbMFh0KGCXNGdSSC4lKg+4MbKI2a6IKAAg7I2RWHFRcI8csV2clUn0ix3os1yRI0K1UyuLW4ZMRDU/z5gZKErjJpzV5OPrJGEblGs0S90sIBuLMx+uq1elsmC9tMaZyVRanSwdaA1svC0+K1dEGFUVKecmpB+bSo0VjPP9CrOqz5ozfxrSGeUUN7FVws54fURoK6qP4keGM8HmkS6a2RFHQ9ow73UPonWGaN4t/J1HV6zDLeYmqGHYUTpIkQhKUb5Cs926YA+29w2sidS2w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe42a5-442b-464d-4fff-08de7eb6bf6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 15:07:29.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9il1EPukTYTVtWi+TL/GFX7Py26khauNltMzlXd0UBcwHwqH3ZQ0OC7MWbPWsQ9Be1ZksBhAUydMhKY+ShO3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4400
X-Authority-Analysis: v=2.4 cv=SPlPlevH c=1 sm=1 tr=0 ts=69b033b9 cx=c_pps
 a=kzsVodbpLl5/Zj7uDz6sWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=Q-fNiiVtAAAA:8 a=AGRr4plBAAAA:8 a=QyXUC8HyAAAA:8 a=g8kJ_gb0AAAA:8
 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=vzhER2c_AAAA:8 a=PHq6YzTAAAAA:8
 a=lTbjQzD5AAAA:8 a=phlkwaE_AAAA:8 a=JfrnYn6hAAAA:8 a=e5mUnYsNAAAA:8
 a=fxJcL_dCAAAA:8 a=voM4FWlXAAAA:8 a=37rDS-QxAAAA:8 a=hGzw-44bAAAA:8
 a=FP58Ms26AAAA:8 a=2Y-fJpPwltZ1yrNfleAA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=bOnWt3ThIoLzEnqt84vq:22
 a=ecSNLfPMzbq-p5zXJZOg:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=0YTRHmU2iG2pZC6F1fw2:22
 a=ZKzU8r6zoKMcqsNulkmm:22 a=w8YF5asEQ23juLwKoPR8:22 a=uKTQOUHymn4LaG7oTSIC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=Vxmtnl_E_bksehYqCbjh:22 a=IC2XNlieTeVoXbcui8wp:22
 a=k1Nq6YrhK2t884LQW06G:22 a=HvKuF1_PTVFglORKqfwH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX7sIdcLwRou48
 STpxAdzmTIFltfom6/gddPw+Hxt9YSeBSTr+FMrnQf4BYblVl1Swt32zRHGMP3M56MuSpUdsJn2
 zcRM+5GZReGqVXZ1Lux3ordmUOsRbt2ILzhaZgg/hq2THhMuyKU0O7scmOhy/0pcF74LOBuYP4X
 NBLWL06/vzs1LA/Teh6R1KJv7s1CUg1K8nJn7/gl5JVuMQieBGKwXj1ESX3XnXH73JQZD04dgFY
 T03/TZRF9WRI2XRqxnxVzVADrXT4QTWIx+thXyhI1HOKPUBg2U3fO3JX9Pk2c+tLOnox3snDfQt
 oajcgiAYPtUue/w0H5Y+ZKsdaUYTykSr3B+gTizfFHP4NlW73Yu7TyneBaFu+31qfNk/OleAsT6
 54ZBqPVMyCS0LZDYcuBHHhbU1CBkjLFEARuwqU31rD7NEhGdSAGwcRjcfuJJYE2zhXGIE3cAYWl
 TwfQXHWoP9LqfePUJ2Q==
X-Proofpoint-GUID: Nl5W4I-io87qvTSFXJtlxRwMkjWAYvb0
X-Proofpoint-ORIG-GUID: Nl5W4I-io87qvTSFXJtlxRwMkjWAYvb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: C8DF8252E7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1064-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,chelsio.com,intel.com,plvision.eu,gmail.com,foss.st.com,os.amperecomputing.com,armlinux.org.uk];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enachman@marvell.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PiANCj4gDQo+IEZyb206IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gU2VudDog
VHVlc2RheSwgTWFyY2ggMTAsIDIwMjYgMTo0OSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc7IGFwcGFybW9yQGxpc3RzLnVidW50dS5jb207IGJwZkB2Z2VyLmtlcm5lbC5v
cmc7IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBjb2NjaUBpbnJpYS5mcjsgZG0tZGV2ZWxA
bGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBnZnMyQGxp
c3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2ly
ZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LmRldjsga3ZtQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1i
bG9ja0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWJ0cmZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2lmc0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxp
bnV4LWV4dDRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsg
bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtbWlwc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgt
bW9kdWxlc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1uZnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1vbWFwQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtczM5MEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zY3RwQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1k
LW1haWxtYW4uc3Rvcm1yZXBseS5jb207IGxpbnV4LXRyYWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbnRmczNAbGlzdHMubGludXguZGV2OyBzYW1i
YS10ZWNobmljYWxAbGlzdHMuc2FtYmEub3JnOyBzY2hlZC1leHRAbGlzdHMubGludXguZGV2OyB0
YXJnZXQtZGV2ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLWRpc2N1c3Npb25AbGlzdHMuc291cmNl
Zm9yZ2UubmV0OyB2OWZzQGxpc3RzLmxpbnV4LmRldjsgUGhpbGlwcCBIYWhuIDxwaGFobi1vc3NA
YXZtLmRlPg0KPiBDYzogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPjsgQW5k
cmV3IEx1bm4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3Vi
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+OyBQYXZhbiBDaGViYmkgPHBhdmFuLmNoZWJiaUBicm9hZGNvbS5jb20+OyBNaWNoYWVsIENo
YW4gPG1jaGFuQGJyb2FkY29tLmNvbT47IFBvdG51cmkgQmhhcmF0IFRlamEgPGJoYXJhdEBjaGVs
c2lvLmNvbT47IFRvbnkgTmd1eWVuIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IFByemVt
ZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IFRhcmFzIENob3JueWkg
PHRhcmFzLmNob3JueWlAcGx2aXNpb24uZXU+OyBNYXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5z
dG0zMkBnbWFpbC5jb20+OyBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUudG9yZ3VlQGZvc3Mu
c3QuY29tPjsgSXlhcHBhbiBTdWJyYW1hbmlhbiA8aXlhcHBhbkBvcy5hbXBlcmVjb21wdXRpbmcu
Y29tPjsgS2V5dXIgQ2h1ZGdhciA8a2V5dXJAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT47IFF1YW4g
Tmd1eWVuIDxxdWFuQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBIZWluZXIgS2FsbHdlaXQgPGhr
YWxsd2VpdDFAZ21haWwuY29tPjsgUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDM4LzYxXSBuZXQ6IFByZWZlciBJU19FUlJf
T1JfTlVMTCBvdmVyIG1hbnVhbCBOVUxMIGNoZWNrDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQN
Cj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQg
YSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2Nj
aW5lbGxlLg0KPiANCj4gVG86IElnb3IgUnVzc2tpa2ggPG1haWx0bzppcnVzc2tpa2hAbWFydmVs
bC5jb20+DQo+IFRvOiBBbmRyZXcgTHVubiA8bWFpbHRvOmFuZHJldytuZXRkZXZAbHVubi5jaD4N
Cj4gVG86ICJEYXZpZCBTLiBNaWxsZXIiIDxtYWlsdG86ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4NCj4g
VG86IEVyaWMgRHVtYXpldCA8bWFpbHRvOmVkdW1hemV0QGdvb2dsZS5jb20+DQo+IFRvOiBKYWt1
YiBLaWNpbnNraSA8bWFpbHRvOmt1YmFAa2VybmVsLm9yZz4NCj4gVG86IFBhb2xvIEFiZW5pIDxt
YWlsdG86cGFiZW5pQHJlZGhhdC5jb20+DQo+IFRvOiBQYXZhbiBDaGViYmkgPG1haWx0bzpwYXZh
bi5jaGViYmlAYnJvYWRjb20uY29tPg0KPiBUbzogTWljaGFlbCBDaGFuIDxtYWlsdG86bWNoYW5A
YnJvYWRjb20uY29tPg0KPiBUbzogUG90bnVyaSBCaGFyYXQgVGVqYSA8bWFpbHRvOmJoYXJhdEBj
aGVsc2lvLmNvbT4NCj4gVG86IFRvbnkgTmd1eWVuIDxtYWlsdG86YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+DQo+IFRvOiBQcnplbWVrIEtpdHN6ZWwgPG1haWx0bzpwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPg0KPiBUbzogVGFyYXMgQ2hvcm55aSA8bWFpbHRvOnRhcmFzLmNob3JueWlA
cGx2aXNpb24uZXU+DQo+IFRvOiBNYXhpbWUgQ29xdWVsaW4gPG1haWx0bzptY29xdWVsaW4uc3Rt
MzJAZ21haWwuY29tPg0KPiBUbzogQWxleGFuZHJlIFRvcmd1ZSA8bWFpbHRvOmFsZXhhbmRyZS50
b3JndWVAZm9zcy5zdC5jb20+DQo+IFRvOiBJeWFwcGFuIFN1YnJhbWFuaWFuIDxtYWlsdG86aXlh
cHBhbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiBUbzogS2V5dXIgQ2h1ZGdhciA8bWFpbHRv
OmtleXVyQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+IFRvOiBRdWFuIE5ndXllbiA8bWFpbHRv
OnF1YW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gVG86IEhlaW5lciBLYWxsd2VpdCA8bWFp
bHRvOmhrYWxsd2VpdDFAZ21haWwuY29tPg0KPiBUbzogUnVzc2VsbCBLaW5nIDxtYWlsdG86bGlu
dXhAYXJtbGludXgub3JnLnVrPg0KPiBDYzogbWFpbHRvOm5ldGRldkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IG1haWx0bzpsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBtYWlsdG86
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG1haWx0bzpsaW51eC1zdG0z
MkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tDQo+IENjOiBtYWlsdG86bGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBtYWlsdG86bGludXgtdXNiQHZnZXIua2Vy
bmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwIEhhaG4gPG1haWx0bzpwaGFobi1vc3NA
YXZtLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGlj
L2FxX3JpbmcuYyAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNv
bS90ZzMuYyAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIuYyAgICB8IDMgKy0tDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvZGV2bGluay9kZXZsaW5rLmMgICAgICAgIHwgMiArLQ0K
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9wcmVzdGVyYS9wcmVzdGVyYV9yb3V0ZXIu
YyB8IDIgKy0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19t
YWluLmMgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL25ldC9tZGlvL21kaW8teGdlbmUuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gIDggZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2FxdWFudGlhL2F0bGFudGljL2FxX3JpbmcuYw0KPiBpbmRleCBlMjcwMzI3
ZTQ3ZmQ4MDRjYzhlZTVjZmQ1M2VkMWI5OTNjOTU1YzQxLi40M2VkZWYzNWM0YjFmZjYwNmIyZjE1
MTlhMDdmYWQ0YzlhOTkwYWQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9h
cXVhbnRpYS9hdGxhbnRpYy9hcV9yaW5nLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
YXF1YW50aWEvYXRsYW50aWMvYXFfcmluZy5jDQo+IEBAIC04MTAsNyArODEwLDcgQEAgc3RhdGlj
IGludCBfX2FxX3JpbmdfeGRwX2NsZWFuKHN0cnVjdCBhcV9yaW5nX3MgKnJ4X3JpbmcsDQo+ICAJ
CX0NCj4gDQo+ICAJCXNrYiA9IGFxX3hkcF9ydW5fcHJvZyhhcV9uaWMsICZ4ZHAsIHJ4X3Jpbmcs
IGJ1ZmYpOw0KPiAtCQlpZiAoSVNfRVJSKHNrYikgfHwgIXNrYikNCj4gKwkJaWYgKElTX0VSUl9P
Ul9OVUxMKHNrYikpDQo+ICAJCQljb250aW51ZTsNCj4gDQo+ICAJCWlmIChwdHBfaHd0c3RhbXBf
bGVuID4gMCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL3Rn
My5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMNCj4gaW5kZXggMjMyOGZj
ZTMzNjQ0N2ViNGE3OTZmOTMwMGNjYzBhYjUzNmZmMGEzNS4uOGVkNzlmMzRmMDNkODExODRkY2Mx
MmU2ZWFmZjAwOWNiOGY3NzU2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
YnJvYWRjb20vdGczLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGcz
LmMNCj4gQEAgLTc5NDMsNyArNzk0Myw3IEBAIHN0YXRpYyBpbnQgdGczX3Rzb19idWcoc3RydWN0
IHRnMyAqdHAsIHN0cnVjdCB0ZzNfbmFwaSAqdG5hcGksDQo+IA0KPiAgCXNlZ3MgPSBza2JfZ3Nv
X3NlZ21lbnQoc2tiLCB0cC0+ZGV2LT5mZWF0dXJlcyAmDQo+ICAJCQkJICAgIH4oTkVUSUZfRl9U
U08gfCBORVRJRl9GX1RTTzYpKTsNCj4gLQlpZiAoSVNfRVJSKHNlZ3MpIHx8ICFzZWdzKSB7DQo+
ICsJaWYgKElTX0VSUl9PUl9OVUxMKHNlZ3MpKSB7DQo+ICAJCXRuYXBpLT50eF9kcm9wcGVkKys7
DQo+ICAJCWdvdG8gdGczX3Rzb19idWdfZW5kOw0KPiAgCX0NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2NoZWxzaW8vY3hnYjQvY3hnYjRfdGNfZmxvd2VyLmMgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9jaGVsc2lvL2N4Z2I0L2N4Z2I0X3RjX2Zsb3dlci5jDQo+IGluZGV4IDMz
MDdlNTA0MjY4MTkwODdhZDk4NTE3OGM0YTUzODNmMTZiOGU3YjQuLjFjOGE2NDQ1ZDRiMmUzNTM1
ZDhmMWI3OTA4ZGQwMmQ4ZGQyZjIzZmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2NoZWxzaW8vY3hnYjQvY3hnYjRfdGNfZmxvd2VyLmMNCj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90Y19mbG93ZXIuYw0KPiBAQCAtMTAzMiw4ICsx
MDMyLDcgQEAgc3RhdGljIHZvaWQgY2hfZmxvd2VyX3N0YXRzX2hhbmRsZXIoc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQ0KPiAgCWRvIHsNCj4gIAkJcmhhc2h0YWJsZV93YWxrX3N0YXJ0KCZpdGVy
KTsNCj4gDQo+IC0JCXdoaWxlICgoZmxvd2VyX2VudHJ5ID0gcmhhc2h0YWJsZV93YWxrX25leHQo
Jml0ZXIpKSAmJg0KPiAtCQkgICAgICAgIUlTX0VSUihmbG93ZXJfZW50cnkpKSB7DQo+ICsJCXdo
aWxlICghSVNfRVJSX09SX05VTEwoKGZsb3dlcl9lbnRyeSA9IHJoYXNodGFibGVfd2Fsa19uZXh0
KCZpdGVyKSkpKSB7DQo+ICAJCQlyZXQgPSBjeGdiNF9nZXRfZmlsdGVyX2NvdW50ZXJzKGFkYXAt
PnBvcnRbMF0sDQo+ICAJCQkJCQkJZmxvd2VyX2VudHJ5LT5maWx0ZXJfaWQsDQo+ICAJCQkJCQkJ
JnBhY2tldHMsICZieXRlcywNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9kZXZsaW5rL2RldmxpbmsuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9kZXZsaW5rL2RldmxpbmsuYw0KPiBpbmRleCA2YzcyYmQxNWRiNmQ3NWExZDRmYTA0ZWY4ZmVm
YmQyNmZiNmU4NGJkLi4zZDA4YjkxODdmZDc2Y2EzMTk4YWYyODExMWI2ZjFjMTc2NWVhMDFlIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvZGV2bGluay9kZXZs
aW5rLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2RldmxpbmsvZGV2
bGluay5jDQo+IEBAIC03OTEsNyArNzkxLDcgQEAgc3RhdGljIHZvaWQgaWNlX3RyYXZlcnNlX3R4
X3RyZWUoc3RydWN0IGRldmxpbmsgKmRldmxpbmssIHN0cnVjdCBpY2Vfc2NoZWRfbm9kZQ0KPiAg
CQkJCQkJICBub2RlLT5wYXJlbnQtPnJhdGVfbm9kZSk7DQo+ICAJfQ0KPiANCj4gLQlpZiAocmF0
ZV9ub2RlICYmICFJU19FUlIocmF0ZV9ub2RlKSkNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxMKHJh
dGVfbm9kZSkpDQo+ICAJCW5vZGUtPnJhdGVfbm9kZSA9IHJhdGVfbm9kZTsNCj4gDQo+ICB0cmF2
ZXJzZV9jaGlsZHJlbjoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZl
bGwvcHJlc3RlcmEvcHJlc3RlcmFfcm91dGVyLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL3ByZXN0ZXJhL3ByZXN0ZXJhX3JvdXRlci5jDQo+IGluZGV4IGIwMzZiMTczYTMwOGI1Zjk5
NGFkODUzOGViMDEwZmEyNzE5Njk4OGMuLjQ0OTI5MzhlOGEzZGE5MWQzMmVmZThkNDVjY2JlMmVi
NDM3YzBlNDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvcHJl
c3RlcmEvcHJlc3RlcmFfcm91dGVyLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9wcmVzdGVyYS9wcmVzdGVyYV9yb3V0ZXIuYw0KPiBAQCAtMTA2MSw3ICsxMDYxLDcgQEAg
c3RhdGljIHZvaWQgX19wcmVzdGVyYV9rX2FyYl9od19zdGF0ZV91cGQoc3RydWN0IHByZXN0ZXJh
X3N3aXRjaCAqc3csDQo+ICAJCW4gPSBOVUxMOw0KPiAgCX0NCj4gDQo+IC0JaWYgKCFJU19FUlIo
bikgJiYgbikgew0KPiArCWlmICghSVNfRVJSX09SX05VTEwobikpIHsNCj4gIAkJbmVpZ2hfZXZl
bnRfc2VuZChuLCBOVUxMKTsNCj4gIAkJbmVpZ2hfcmVsZWFzZShuKTsNCj4gIAl9IGVsc2Ugew0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFj
X21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWlu
LmMNCj4gaW5kZXggNjgyN2M5OWJkZThjMjJkYjQyYjM2M2QyZDM2YWQ2ZjI2MDc1ZWQ1MC4uMzU2
YTRlOWNlMDRiMWZjZjg3ODZkNzI3NGQzMWFjZTQwNGJlMmNmNiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYw0KPiArKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jDQo+IEBAIC0x
Mjc1LDcgKzEyNzUsNyBAQCBzdGF0aWMgaW50IHN0bW1hY19pbml0X3BoeShzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQ0KPiAgCS8qIFNvbWUgRFQgYmluZGluZ3MgZG8gbm90IHNldC11cCB0aGUgUEhZ
IGhhbmRsZS4gTGV0J3MgdHJ5IHRvDQo+ICAJICogbWFudWFsbHkgcGFyc2UgaXQNCj4gIAkgKi8N
Cj4gLQlpZiAoIXBoeV9md25vZGUgfHwgSVNfRVJSKHBoeV9md25vZGUpKSB7DQo+ICsJaWYgKElT
X0VSUl9PUl9OVUxMKHBoeV9md25vZGUpKSB7DQo+ICAJCWludCBhZGRyID0gcHJpdi0+cGxhdC0+
cGh5X2FkZHI7DQo+ICAJCXN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXY7DQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvbWRpby9tZGlvLXhnZW5lLmMgYi9kcml2ZXJzL25ldC9tZGlvL21k
aW8teGdlbmUuYw0KPiBpbmRleCBhOGY5MWE0YjdmZWQwOTI3ZWUxNGU0MDgwMDBjZDNhMmJmYjli
MDlhLi4wOWIzMGI1NjMyOTVjNjA4NWRjMTM1OGFjMzYxMzAxZTVjZjZiMmE4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9tZGlvL21kaW8teGdlbmUuYw0KPiArKysgYi9kcml2ZXJzL25ldC9t
ZGlvL21kaW8teGdlbmUuYw0KPiBAQCAtMjY1LDcgKzI2NSw3IEBAIHN0cnVjdCBwaHlfZGV2aWNl
ICp4Z2VuZV9lbmV0X3BoeV9yZWdpc3RlcihzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBpbnQgcGh5X2Fk
ZHIpDQo+ICAJc3RydWN0IHBoeV9kZXZpY2UgKnBoeV9kZXY7DQo+IA0KPiAgCXBoeV9kZXYgPSBn
ZXRfcGh5X2RldmljZShidXMsIHBoeV9hZGRyLCBmYWxzZSk7DQo+IC0JaWYgKCFwaHlfZGV2IHx8
IElTX0VSUihwaHlfZGV2KSkNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwocGh5X2RldikpDQo+ICAJ
CXJldHVybiBOVUxMOw0KPiANCj4gIAlpZiAocGh5X2RldmljZV9yZWdpc3RlcihwaHlfZGV2KSkN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9yODE1Mi5jIGIvZHJpdmVycy9uZXQvdXNi
L3I4MTUyLmMNCj4gaW5kZXggMGM4M2JiYmVhMmU3YzMyMmVlNjMzOTg5M2UyODEyMzc2NjNiZDNh
ZS4uNzNmMTdlYmQ3ZDQwMDA3ZWVjNTAwNGY4ODdhNDYyNDlkZWZkMjhhYiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvdXNiL3I4MTUy
LmMNCj4gQEAgLTIyMTgsNyArMjIxOCw3IEBAIHN0YXRpYyB2b2lkIHI4MTUyX2NzdW1fd29ya2Fy
b3VuZChzdHJ1Y3QgcjgxNTIgKnRwLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiANCj4gIAkJZmVh
dHVyZXMgJj0gfihORVRJRl9GX1NHIHwgTkVUSUZfRl9JUFY2X0NTVU0gfCBORVRJRl9GX1RTTzYp
Ow0KPiAgCQlzZWdzID0gc2tiX2dzb19zZWdtZW50KHNrYiwgZmVhdHVyZXMpOw0KPiAtCQlpZiAo
SVNfRVJSKHNlZ3MpIHx8ICFzZWdzKQ0KPiArCQlpZiAoSVNfRVJSX09SX05VTEwoc2VncykpDQo+
ICAJCQlnb3RvIGRyb3A7DQo+IA0KPiAgCQlfX3NrYl9xdWV1ZV9oZWFkX2luaXQoJnNlZ19saXN0
KTsNCj4gDQo+IC0tDQo+IDIuNDMuMA0KPiANCj4NCg0KQWNrZWQtYnk6IEVsYWQgTmFjaG1hbiA8
ZW5hY2htYW5AbWFydmVsbC5jb20+DQo=

