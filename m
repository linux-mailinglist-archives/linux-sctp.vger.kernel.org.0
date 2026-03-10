Return-Path: <linux-sctp+bounces-1067-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOW9EiFgsGloigIAu9opvQ
	(envelope-from <linux-sctp+bounces-1067-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 19:17:05 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63152564D2
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 19:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8467931B6678
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6C3D9DDC;
	Tue, 10 Mar 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ga2/3Nuh"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6312AF00;
	Tue, 10 Mar 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166426; cv=fail; b=LfBByfmQMy7zWa/LZpd3IsFGfA0mJR3D0SfNFAfmn4U+jzEtCz3VGbG5FxYOw1JGn+Xv6skpx6RtEWHj61pKuUm8M1/t2JhjAePXw8UHXU3cBEC0pojNZM6TgNihCpgLfFMf/Gc3/rKWxGzMRB3eSOnW4JiDaYSO7cwPRs4c3bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166426; c=relaxed/simple;
	bh=nPEo3k2fwZhwgIqrsgLaFQDOcFNuCDzt1kvGP06H+Vs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nG70aX1UaEAMZYxg766yxyR+dm2TcdNNWZHrf6RmhYpZmLjUAyksrOcqD7BbcX+PMu9L7xxqI3Itde7DY0py9Kzz6rBZMbdXiRIdaV/g+0riX3BHRK+QMrCS2Axn3pPZ3MdjGX7QwKc8W0hl/4Fhpzv+2Meph1LePpV9cHwQZKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ga2/3Nuh; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9qCvs1433673;
	Tue, 10 Mar 2026 18:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nPEo3k2fwZhwgIqrsgLaFQDOcFNuCDzt1kvGP06H+Vs=; b=ga2/3Nuh
	r68XFjQQGGtwNG1XbsRHtWHpfIeKo+qwkMM/siPPamZzms9RLh3Ce3457fpy7gA5
	Pot9is9EV58czfXn3oG+DJhzLENHR6s0Wn221ECkQUEScTOvfo5IwLdkMgeMQD3N
	veZktHQ8+7uI0py68CW9stlM9k1umkgbhxxCYFBjZnmZ/XLUDPYO9WDyOMwsBWgN
	H85ozeHcdrd+6QCkHWQoZZYe6YLDxqKhvOW83XD+g/DIc8zkUZV7+Le7JjoEnA6M
	X0sd0z4cKx8vurwOgcBCwwcYWXftjPlRrXa4zuwCBrgpl8YpgYCL3O6Bif8xRRvX
	2JlOQ7fbykpVrw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyc9g4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 18:13:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or7IekFNvA84bBHC15aisKosnAIWs70vTE0O4GD7ALXOJw6JOvdM4YvwcbUuVrRfwLR2VbQJEWfDAZEvKSW8f/t6ZhUS+ghE1dFMHEBIC5Tcmag7ImEXdhZ7LbHI/8qUGwuoEDPZVJa8vZgwOKWrHdrsW6Hd30Lq+8uI3oFL+MNBlvfycy/oYC7HdU4QdTnGvWq/Lkyvv/U0MPp9MidVIZtibuRdrTnGAZotf44yub8JlsCmrnETfZ4ndyOsUimiTfLufGRw5+wxfINYdapJxVPFwXvRsYjXd2C7M/QJbDLri61RcD7V+kzwBoE/30dct5thtxIR6iA2+f+NTwPpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPEo3k2fwZhwgIqrsgLaFQDOcFNuCDzt1kvGP06H+Vs=;
 b=CGWUw4qwgY/FudQfdnhZNC6HwbVcYl+/rMmHKkw40fvSyf4w/p9BzE9kFyRCclJJ4Sxm4q3vpPxXiyVTkcJhj0+v7bzuncQIyvk8udJhXWGBPjvfbRqM4P2W6zUl/TaZZgchbKv2TX3nMaYskGNrv3KVMyLNEMviu7uIDvCFqg2UxHe6wCJPX4SJORNL9JxRl8vH+q0NzDPs46hEORCyMvlQtGmC0EaPBg0ea5NkU3aibfsBsmSSeLHv7i5QKkrDkVDfnMk0wP8ZKq20EcPaiBGvmd384xuC3Ui2WTqCz3wZ0Vo/YWrIc8/2sh2uaZN6/YskrrF7u8xtEBTz7t/RtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH5PR15MB6945.namprd15.prod.outlook.com (2603:10b6:610:2f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:13:03 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Tue, 10 Mar 2026
 18:13:03 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
        "phahn-oss@avm.de"
	<phahn-oss@avm.de>,
        "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>,
        "linux-sctp@vger.kernel.org"
	<linux-sctp@vger.kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>,
        "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
        "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>,
        "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "cocci@inria.fr" <cocci@inria.fr>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over manual
 NULL check
Thread-Index: AQHcsId8oNXR/FZQ2EuIyBsTGM+uMLWoEgIA
Date: Tue, 10 Mar 2026 18:13:03 +0000
Message-ID: <1464b1fb96df5dd085984ac70086417c4b7cfb77.camel@ibm.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH5PR15MB6945:EE_
x-ms-office365-filtering-correlation-id: 18033782-9746-4e44-9816-08de7ed0abf7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 9LAe9FEFSN/vfSfiV5oqVZqpylENlWFi5RM+1C+1bDG44109Q6rTiNxosug6OQv/x6tkh5cOAar+HZNPI8BFM12KKS5lsJ3NGLrVlO20rSFB+jdQj6vSJYdmRBTqGeSk7Y/ombrAgdY3MA5Ccautt/cVbAKKVx1jhRWfOMSyT1CKFo7WLS/D/PvElWEONOQkdGwgQqqrYQOTplUYyJNVjErQTAFxACEOm5HY5EJOEQG1tvgurUHYAlmliMVw98Rk5Hgofogo+nX+QACpEY5he2lOVWKjyRLX0GSnMlWTP8G9IiiIiUanug554WDoMFtZVOzZXrNkvESXPjaSevtgOTXQcQOb0TNn8cJRHRwIYeCwjlIyfGh9m3Z1Umx4scOBXzyFzl9gLjbde9/SW1TkIABOGyFDuc5RA05kXkxaLRhegQBCBTdc5nN2wceNz88JjjhSNnjfvZzjUmjuBwUIJLEnf35VREfPs6aieiLroDKAiXT9qTxP1Oz7rR2l4/AWkUwRgp5Pv5h708JlxRKTT6yVHzN14nfhWFedrClZer7TdDN2qoXpUQ0dKki8BDQMS+biNGAsIVWyIR1+VWE9GgFUc1JfaNfHCn+m6N//yoBVvskxD8sqQ+1BWiFkunYzRuho7o9L118JV2Z8ratVms037j2+/ZBhORE2GBCFW9MOj2/vNDZ7WI2Vviyq+t8WMdVFAq21Eo1EybBoAjcAzsyLMGTD2OYXmESCcV68EEzeETd3U+VBmSkHDcQOFXypK/rMh0b5xn/QyWx2ZWqVnvxHjzN0mB7GqWzInRsHQXnEqAo3NHtf+SW1k4O+nVsZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm1qQ3FtMW1CeW84ZmlYMkhkT1ZEaDdjU2ZYUXZzMVk5RlR5MUEzYjFtdHdL?=
 =?utf-8?B?Z0EyNHlnUDErUFJXS1I1VUhSQ0lsQ0NrUmdZZnltSzhuTkFhZkx0bnAzeE14?=
 =?utf-8?B?K1RVWUdUUzM1NVgvZGx1WUFjKzVrL05uU0g5NEZzWDZueGRucEhLN3FqcG9S?=
 =?utf-8?B?RzlaN2huVWgzYVB5UXFQZnpEeCtEZUJZYjN3cmd2a3BnNlRYMWhpYWx0d3pl?=
 =?utf-8?B?aDVWU0hsamxaNkR3NGRMREdzd0VpRTdiT2svZ1UwQStTSzBXRkNFTCtBalFj?=
 =?utf-8?B?eTh4R01EcHB1NHovaTg0a2RPNnplRFdoN3UwT2ZXcElkVmIyQ1J5UTd2K0pT?=
 =?utf-8?B?ZFhDYktJNjJwb1VLRzY2eUt6b1ZqN1dvdVlyZFR2SmdaY1ltbXp1TTkwUmxa?=
 =?utf-8?B?QUNpKzFwaXB6WUlBTWU2SmU0WGdySE13RnY0SjB6QVNZR28wNTlPSzNSY2Vn?=
 =?utf-8?B?VTcvNjJzYVM2WnVRbGhaRkZEcEhTUWJsNlNhL090NUU1UHhhSG03Q1Ayc3U2?=
 =?utf-8?B?MjdTNlUyNjR1SWlOREQ3SjY2a3JlNDZPRVVySnBkWUhkbXAzRndMUEQ0Ritn?=
 =?utf-8?B?MXhKNXI1UTVYUkllN0JYT2dnNWhySDF4V1dTVzBVMFZWVFNMNGZOeTRJUXlE?=
 =?utf-8?B?WUxqNTN2ZHFycnU3V3V6NE5IZkl0OVQzYUJVZzFlMkpKUXlGZkNIUTZJUnBK?=
 =?utf-8?B?U0wzNDV6cERjdFYwcEJCZTlLbWpaZ2NoU2l6cUowN2dTcmVCbnlCUWp5RW8v?=
 =?utf-8?B?QWJya0kzWHRHTlJDWU9sSmVKeWJhcHJyKzBFMW5DVG5xVlRobk02SFZNV0lo?=
 =?utf-8?B?cjJrTklkeUc3Z2luWlNCR2hxa1hJdHcyM29nRkt6bktLdFBtWDB4RG5rMm9N?=
 =?utf-8?B?Sjk0UzRFSWhVY0pieXlHeGZMd0o1ZGpZRmdXNG13Q2xvK29WSnNsM0VxaFZ0?=
 =?utf-8?B?STV4VlV0TTRoMEZ0STJXdE9WU2xsV1dpQ0U2eDNrRXhYZzRXOVI0djhqTmZt?=
 =?utf-8?B?ejUxd09vWHVtUGdUSElvWHlMOXl3bGNKNUR1VEo3RFF1MlRUQ0xrbndGN0N4?=
 =?utf-8?B?ek9BTUR6SmhwRFh6c0piUFRWQi83RmtVV294N2R0czluUldvbHZBZTdlc0xp?=
 =?utf-8?B?eHBGMG9iVThMUUd2RXMyUUdpc3ppUFlWamhKSVBkR0tNMnk1aWVyVHpCdHhP?=
 =?utf-8?B?TUtjb3JMT3R4TjNkK3VSdm1tN0V6NmFFY2c3dWFxTU8wYlZSb2prbWdvUC9h?=
 =?utf-8?B?MzI5U0VsNU9nQVFKYmpEbHFOTmgrQm10aUM3dTNiWjg2c21nK0RBVVovNTNn?=
 =?utf-8?B?MVRtR2RLdVZYSVg5Rnc5ZGFTQ1k2S0plY1Z5UFhvank0eXEwSWdET2UzNVlQ?=
 =?utf-8?B?MHRtNm5uZnUwQnFNWTdBVUVRTzM2T1lWZlk1d1NWUVo5d2xqK1U5S285Wllz?=
 =?utf-8?B?U296c2JQYlZmNVA5U0lmcWxveXR6dTR0VGFZbVU5Q3Q3WlZnaEJhRURuVkRV?=
 =?utf-8?B?UExaWk9xN1BUUThTSnBpN2VsRk9CSDY1Z2RMQkRsMTFrT1FoYk1OeXV0cnpq?=
 =?utf-8?B?OVZHU3ZRM1dPNnZaaDlRKzBKZHRnZTZVR1BRNzNEcG51TGFPQ2VsRzBxcXVC?=
 =?utf-8?B?TDVDTThHRTQ2eWNKSnhEb1NzNWRkUy9tTUFNOGcwaEhVVC9PWUpKRXZETWR3?=
 =?utf-8?B?dnpWcmgrZVNCdGNrbWJZV3gxU2V4NkNyRkM3QzVsbmVZYUZXd29VOW82dWdl?=
 =?utf-8?B?NnpHdThjaTJ2WFl6WEIzRnl5TDV4YTJ5dThxb3dPbzIrdm82K1ppZXNWY2NZ?=
 =?utf-8?B?VTFpM3BPL0pMVFYzSUNUQjRwYzRBNERyRFJpSUhEa1BKdllIc2Qra2xjT0w4?=
 =?utf-8?B?eEFMdUtwUld5aWJvNWRHU3FNRGMrTjJKZGIrbGUrYUtEbWpRRmRJYXFKOXI4?=
 =?utf-8?B?Mm5HUWFsVmZrTTJsYzZ2NE85aW5ZZmtoajQ0T3U1S091clMvSFJMRHF4SWJB?=
 =?utf-8?B?a25zbndkdCtGUVkwZ3ZicjBldE1nRjlnU1hIMXZUc2taaStDN2k3YkdjYVcx?=
 =?utf-8?B?cmZRS016MG5KbmY0NXJXRXlkR2M4Sjlxc0ZBSXJhVXBTUW1OUVk2RFo1V0Rh?=
 =?utf-8?B?TFNjZ3piNE1EZE5saU90K2FlZnF3Ri9mbDFoOERCdmViYmttZTBYbjJGQ0dM?=
 =?utf-8?B?Nk94ak5zQ3VqSnNpSFdOZEtOWnJMc1lVV2ovWXd6WU5Rcmlhaldhb1JYT2R4?=
 =?utf-8?B?SHNaWmQ3c1JqencrWWtjblFnMHV2cjBTSTJTazZPTEcxVGlFV1lIMkFRTmNs?=
 =?utf-8?B?Y0t1aG1VZlAxNTJaT3E0SEFZY0hBdS9lNkpMZWRrcTNCRFZzcGxyZmVORkZu?=
 =?utf-8?Q?Iq2lDlzfBtjls/RqgWBNxcC8qOWZY+Buaqi/y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DFED98C1016741B63A5942D48D9A33@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ouzQV/duSnqj9eQ8t9/zqEveiX83JCuGT5oHXc1tPllABUbVA5x6zkyZdg67BB55FOpVvz5i3+CwYQ9Ebh13EnF3em44ULlGNrGgITl6vBQOny/5npv9YH2OsQRKhWEnVcNgN93pQHv12ucKaLAteirhdT9x4VgmdKw9IN5Izq/U8xCJ68D8ILetsGDfa0T7UBSTXUN2AHJLLXf15FNB4sS9QxlcwS9ZU7BYNPuMaoBps+zejTjTOzLUGOHsyQ2PeGqJmC03mdcPwTlaShQGo2ltTfNjWLi72t049HZt4+KPyP9fFzhNH6IoO2YcN8A22RkmujZYJ3xNX0GUPwFKtA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18033782-9746-4e44-9816-08de7ed0abf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 18:13:03.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l62UL/PqUVKAxWU1cokGv8IIbsrOCF/oF6OU1tLlpUznQ0knaQHxMGuUlis1RXGK2tklHd+kItvBK3L+kVosiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR15MB6945
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b05f35 cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=wCmvBT1CAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QMvxmR5twCbtgRVzoWMA:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1NyBTYWx0ZWRfX6gCHa0lwW10o
 lFCMC9kMC4V1/cnjVaPGFjIfGWXKsdgZnbCGIXo54/dpAg7JWd7mfhSnASQrXDTUTtwcKE+KBgi
 ytL71pon3keiWzVbwwYnn9OY+kWcYSSo+GwSIjjjyZbFoNqUgYc3zdF2t7Z0/a44ki+chQhhzEq
 FoPITlX1NgiOfTG1Tj8HMmDqyMEcINWLsIKuJHAszSN+cQdWzaATv028d7PD+ruIUFIgNVIo9JE
 OV6xrRDqYzXJ2+CDYXkhbIl43+KXaWK53hcduLUnuLOMwaWi1K0EuzsTNT6iYzjwF9QeBc+rDZA
 M/VoPBAltcjoFV88J+OQ4rnKEKIaAouRy7fDUJVSU2P978SRDZ588nWomMnMzcpXMsEGQczaEwB
 sh00qtt5B7Ead2PTPCrPKIBigUOv5dYN20g1tjrxMT5SDiF9H3lmVDRqIJNnZY6m1Z8pBjuzwfa
 aeBZIo7XCSVABS5JxWQ==
X-Proofpoint-GUID: ZYPILX7CsvqbmrLJ4cR2j1nTd6r7lS0r
X-Proofpoint-ORIG-GUID: p_Hc_VTpUe9-fUIfURJdp6NY95u6oY9B
Subject: Re:  [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over manual NULL check
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100157
X-Rspamd-Queue-Id: E63152564D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1067-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,dubeyko.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:email,dubeyko.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDEyOjQ4ICswMTAwLCBQaGlsaXBwIEhhaG4gd3JvdGU6DQo+
IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEg
bWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2lu
ZWxsZS4NCj4gDQo+IFRvOiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4NCj4gVG86
IEFsZXggTWFya3V6ZSA8YW1hcmt1emVAcmVkaGF0LmNvbT4NCj4gVG86IFZpYWNoZXNsYXYgRHVi
ZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+IENjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAgZnMvY2VwaC9kaXIuYyAg
fCAyICstDQo+ICBmcy9jZXBoL3NuYXAuYyB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgv
ZGlyLmMgYi9mcy9jZXBoL2Rpci5jDQo+IGluZGV4IDg2ZDdhYTU5NGVhOTkzMzVhZjNlOTFhOTVj
MGE0MThmZGMxYjhhOGEuLjkzNDI1MDc0OGFlNGZkNGMxNDhmZDI3YmRmOTExNzUwNDdjMjg3N2Qg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMvY2VwaC9kaXIuYw0KPiBA
QCAtODg5LDcgKzg4OSw3IEBAIGludCBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZShzdHJ1Y3Qg
aW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KPiAgew0KPiAgCXN0cnVjdCBkZW50
cnkgKnJlc3VsdCA9IGNlcGhfbG9va3VwKGRpciwgZGVudHJ5LCAwKTsNCj4gIA0KPiAtCWlmIChy
ZXN1bHQgJiYgIUlTX0VSUihyZXN1bHQpKSB7DQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZXN1
bHQpKSB7DQo+ICAJCS8qDQo+ICAJCSAqIFdlIGNyZWF0ZWQgdGhlIGl0ZW0sIHRoZW4gZGlkIGEg
bG9va3VwLCBhbmQgZm91bmQNCj4gIAkJICogaXQgd2FzIGFscmVhZHkgbGlua2VkIHRvIGFub3Ro
ZXIgaW5vZGUgd2UgYWxyZWFkeQ0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9zbmFwLmMgYi9mcy9j
ZXBoL3NuYXAuYw0KPiBpbmRleCA1MmI0YzI2ODRmOTIyYmZlZDM5NTUwMzExZTc5M2JmZTM2MjJj
ZDI2Li41MjhhZDU4MWJlMTYwNzEzZjkxNDE2MTE1NjU5ZTJkYzZmMjU5NTc2IDEwMDY0NA0KPiAt
LS0gYS9mcy9jZXBoL3NuYXAuYw0KPiArKysgYi9mcy9jZXBoL3NuYXAuYw0KPiBAQCAtOTAyLDcg
KzkwMiw3IEBAIGludCBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKHN0cnVjdCBjZXBoX21kc19jbGll
bnQgKm1kc2MsDQo+ICBiYWQ6DQo+ICAJZXJyID0gLUVJTzsNCj4gIGZhaWw6DQo+IC0JaWYgKHJl
YWxtICYmICFJU19FUlIocmVhbG0pKQ0KPiArCWlmICghSVNfRVJSX09SX05VTEwocmVhbG0pKQ0K
PiAgCQljZXBoX3B1dF9zbmFwX3JlYWxtKG1kc2MsIHJlYWxtKTsNCj4gIAlpZiAoZmlyc3RfcmVh
bG0pDQo+ICAJCWNlcGhfcHV0X3NuYXBfcmVhbG0obWRzYywgZmlyc3RfcmVhbG0pOw0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtv
QGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K

