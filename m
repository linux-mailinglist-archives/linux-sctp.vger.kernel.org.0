Return-Path: <linux-sctp+bounces-530-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5148FABB81F
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA25916F19C
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1826C38D;
	Mon, 19 May 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kd9PzIve"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CB226D1D;
	Mon, 19 May 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645478; cv=fail; b=vDvuHQhf+yFTrbspO2NW1uJD7PfxQlIuV7X+Ti0v3qZjW+Blb78P+UNlzlU1gfhteitc2zfq5Y1QDln0AXSA/mljJGSu3ZlHcI/KNONvYhXlc044SIzI5XS1513GrQAEfKfJfc5lg2mtU4Y7hOErP2qMGJKad/rdm8zTNeafHcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645478; c=relaxed/simple;
	bh=yRVSNPTSkHVLYngL3aUEjjzFq0Ct5GCfOTYmrf/BMfA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=edsKoUa0btjIRQXzMUhQVaVkGD6y4ruaAWEmxU69hnS8sR00cBWA3KPfUOvy5CwSshLwkeyPXAg4NYT0h73xcmAlkuqpA7P067s8Esm9ZhROS+FuXL9cOk3bZl356XvHY4oAp/UuVlsrIFvAtcBo3QryngW/JsOeui3L6NWkOW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kd9PzIve; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J4XwUk014019;
	Mon, 19 May 2025 09:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yRVSNP
	TSkHVLYngL3aUEjjzFq0Ct5GCfOTYmrf/BMfA=; b=Kd9PzIvekADkkV0s7sTD/r
	aRqF3LyHl8AgFN/T+WRxsDmT2Mqe5XcddUDGr96OwVTN0s0KJsjM6UBNZwgznAXy
	OXmQV2FPJIu4k+gy16dK/7NMr8g6m3pMTvDNnTBM5J2i0DBjT/fhSvYGgmhxXIxk
	VqOvRMrNn4IFROWljCBOc9v7lB8ycsz040xejIE8F4QIREz6w1ICDUWyLWAVt9Hp
	S4ju+ADe7Bbfxu3iCG9FNJDhhaHzhpiJtjOWwaFrEsGt7dk3DudqMaAhqQ14dBpg
	w3Y/s8P4S2BGChSuoIVg5aqKfzZNXDPtZrZ7DvdcTH5ooVQle7C7/PWbBfVW6q0g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qcrjc2rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 09:04:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54J948b8024150;
	Mon, 19 May 2025 09:04:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qcrjc2r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 09:04:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym/HlvHtLfZ2ZF/8LnhgSnNXTO117B5Fe8d1IKcY/hCuRlLbJ5wny4zASvwv9hQY8OUwrIWZ1jQ0soAW6nY3e1lF6Swp2VVZDKHUmod0iAofPIZWgtn3Cmo1LlIcEGz+HJw46wdZQjtuvGPV/uQVYzvY7f03hPbTVZF4XwYxVNyqHfBHz+LYnpwI2Kk0YM7zQUqOCZCqcLcKZHGAD1GLTmkqVJh4Zvq9gHMdihijiAEuB1eOaEeOZ0DFhPVvxTCNBgJrWg+g94aKfMGF6kfxxRijFDswhGygQ96zdwU7OQVFsB3x1xe5sWLVuwYCUkX1DShRLMBREeyKtJO+O5OBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRVSNPTSkHVLYngL3aUEjjzFq0Ct5GCfOTYmrf/BMfA=;
 b=PqkrqhY+qOXSkihYm6NVIOXsGenj/uqNzyfQTggTP7h6eC9FQd2FD6LeqUR7yZVqQuv0c2Fz8oZ1caIvG7WcSu2DQNWD5+7Ls8tzNrZQ8F/024Yq2RXeUmP2Q62eVKUig/6MmudGXr67wXZEGIxB/stU7IFlp6x1qE4kTLp6ql00MK0wkRlV/wzF1UbvhjWeh00k/bGEvb6/wpKpzZm2PcuuCLq1jOOkb7N/zzvDO82ShxeBkMN8mvSWm4ykO1f0nOriC3hiW4lENOAqKcsKulQ20UjDhGcTSm+Es2ckji0kO7jqq8s6KrpOkHLeUzurnVaPn6ila6/pbYROtAr7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by MW3PR15MB3833.namprd15.prod.outlook.com (2603:10b6:303:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 09:04:06 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 09:04:05 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel
	<ardb@kernel.org>
Thread-Topic: [EXTERNAL] [PATCH net-next 04/10] RDMA/siw: use skb_crc32c()
 instead of __skb_checksum()
Thread-Index: AQHbwg2dD6TqLfA7rU2DHmSkOGmvKbPZs3Hw
Date: Mon, 19 May 2025 09:04:04 +0000
Message-ID:
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
In-Reply-To: <20250511004110.145171-5-ebiggers@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|MW3PR15MB3833:EE_
x-ms-office365-filtering-correlation-id: 07a87fe1-39b3-4906-db1b-08dd96b41b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDZjOVZrc3VDT1phNElDVHpneTN4SVEvUlpUcnZtVTNyL3g0WUJlSFlkQXFN?=
 =?utf-8?B?aG5nOGpMK1JjRFkwRTFwazVPVmU3Y2l3K2VKdm10OGtPZkxIelYvaXZzajdY?=
 =?utf-8?B?cGxLdFNUMGloU2p4YWhIeXlSZ3NjbXVvYTFCNXdjNHVhcmMvN3NXd0ZrUnNo?=
 =?utf-8?B?aEM3NnA2UFRsMXFTY3RKeURKdk1Hb3VlemVPczlzaEJLYTlwYVlXSG55VnpE?=
 =?utf-8?B?VmtQd09uS2pMR1NKOFZkYk5EZUtBN1lxU3ltamJROHQ5My9qbkZhTVNPRXhU?=
 =?utf-8?B?Vk5HTVhCTXYxbkNPY1dQK1NHVlgzdStEaWcrMUlocjJyVGV3b1ZFQzVRTVhD?=
 =?utf-8?B?YXcvbEFmVGt0NUEraCs3dFIrbGpYYjEwVjNON1ZKajRQUkNLZEoyY2VVQWtp?=
 =?utf-8?B?UFI3QjdZUnZiUnFFNEg4UGM4VFo4NHBWWFJoem01M3NXWE1UWEdYR0pjeFFw?=
 =?utf-8?B?ZzZMLzBjSzhOS09lMi85VlMrM2FSS1FOZ2pFODBqUWk0Qk5STG85SnVGSXpx?=
 =?utf-8?B?cjR1aDF1dUlFRDlpQUFuUkdpc2E4MnFJM0JWWWJockMvWDhjbjVNZXNvaHpB?=
 =?utf-8?B?M2hGbks1UzNQSENBQmRaZmNVcWdCTUtnS3p5aVdXVHFvYWVFZ3dMamE2Vmxn?=
 =?utf-8?B?Y1ZIVFhGZmRsU0pxVkZXMXBVVEVIc2FVeDQ2d1VaSUwyaENlTzh1aHFYcGhF?=
 =?utf-8?B?d211K1Y2NkNqMUxUZHF1UWkxMk5jdjlCR1V6SXMyRFlJNnNrREh0MVk0TXl4?=
 =?utf-8?B?RFFqbzg3WmR5Q1lTYy9jSHUycVBYc2hUQkpFeGFKSm1SNXA1TEp4OXFoVU8z?=
 =?utf-8?B?VDg4UGRTM3Mvd21TOE9TNTR6VDFBbUEzY3NCL2hVL2tIZTV6L3AvVzJzV1JQ?=
 =?utf-8?B?dmpMWTMrdVdMbWNNNnIwVHh3ZUdFZklweUdvODJwRHhDNUhUcWQ2MVNEZGhj?=
 =?utf-8?B?SXQyS3RLdVdxWWRMVlZPNGFzcVY4aHdVdlpCeWFucUVXSkYzbERQTEEwOFZJ?=
 =?utf-8?B?R3JITXcwQzJuVjR3SVZUdFlEeXZCcTVaTEZ0NS8waGw0dTdaSWxLNUVUd2VK?=
 =?utf-8?B?ajF5MmVJRlNyNVE0NTJlRjEzc3FxZTBTQ3NKMUgvWFNRcEhweWJjZFQrRmRU?=
 =?utf-8?B?SU5pRHdHRElCdDBIdkNsbGdRTEVlbzFTcnhncWZWUDJIU3BBY1QxS3J1S2lD?=
 =?utf-8?B?L1ZyUmdoN09qd0JDektKOXdmaFdoVmhSckUxbHZRNXJrUzZQRTc1U1BQMFl3?=
 =?utf-8?B?UmthOGF1bnh1YVhmVGw4ZG9YY29ZL2dlS0NlY2NkUTZlNG1QWktYSG5IUmwy?=
 =?utf-8?B?U1JJNjJMNlBYOWFlSllYVFk0OGZxNysyWk5DS1VzSG9MWUxUaDAvU3dSTjVt?=
 =?utf-8?B?cWtGeWwraHA1cG9YWGt3WlZlRVJWQm9zVmRBREJJVkM1SldSVW5wKy9SU3hL?=
 =?utf-8?B?a0IrTXdSVHVyZk41QnI1L0tGc29HRWdKNWloMlBmWEdzUXpnU2JoT2dtSEdl?=
 =?utf-8?B?cFROUVcydWtKU2N4Y254TzZlMHlEUlRWTnEySk9pams0c2k2MkIyd0ZtaGZ6?=
 =?utf-8?B?QURGSXNLWVZVU0JjbmEvY21TRmdsUzljeFBXTkg5M2ErSjI4SmhYS21saDBk?=
 =?utf-8?B?MG8zaGdwTjdWNlhsYi9DcEhSNGZSd2hrM2gwYmV4bmZYVmk5clNNMW8wUGM4?=
 =?utf-8?B?MmNHdVNCTWtuVkQvUDRtbUJqR1ROdXFHT1JQT1JzTmFvbysrVGo3RisyRTBM?=
 =?utf-8?B?MGtXNUNCTjFWSHllWS9FaHA3T0NxVUNvcENrSVRFZkVRMHJHNkxraXlPWmtp?=
 =?utf-8?B?emNNSit4dSszRjdGV3YxTVpNMDJxYlYzbTQ3VjdXMGxuNUhyQ1dPOTVvNFhF?=
 =?utf-8?B?dGR4V05SK0IzMlRCN1pmeGJheTZ5ZUR1eWw4azdvMmpQRTlFY2pmRU1oZytM?=
 =?utf-8?B?TURIdklCNE13RDNxVGJUcDVIUDlLRjZuT2E2K1hyQ3I2MklZalYwQ09sZGxw?=
 =?utf-8?B?YktncDIwN0x3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFIxdm42QUV1SlhrOHBJc2JjMzlYcVdWVWNiaFhQSHVrbUNPK0RyenFyRHlK?=
 =?utf-8?B?WjBONGVwcGZqaGcwSEZYc1k5VkRWRmpST243Z21MY2pid0FjWGJxZy84d3o4?=
 =?utf-8?B?WUx1d0V2SktaR2hBbGVaM3BoenduWFh2dWl2NjhGcUNwVDBYVFhBV3UrLzFm?=
 =?utf-8?B?ZkM1MGVYL3pFQ2QzTGNsVzRxU0dYcXFSYmhXZjUvUStpMTNVN0ZEemUzT0I0?=
 =?utf-8?B?WE8vNWJQMDdzV05Yd1YzZkFlK2xhRWg1YTczYlhxTTJmd3hnb0FqRWV1Ulc4?=
 =?utf-8?B?TVNJQ3VPZHdjS1psNENwSlN0a3B2V1JkWGZiTFlpWkYybHRycldOa0xYRytj?=
 =?utf-8?B?cTF1ZHhpT0VkRW1MbWdYSW9CaUdKbTl4bWxqK3c2cGhjN1Zqc1NZRmlGQUo2?=
 =?utf-8?B?cFVFSGU4cUZGWCtETW1YcVVCSTJsb3pPR1kwQ29yZHB3WWIzUm9qY1lDWHk1?=
 =?utf-8?B?ckZxczl6anFHU2lXejJCa0w3elZyRW1YLzlxOEFxZitNTzcxVGMvVlVWT1Ns?=
 =?utf-8?B?N05RSHZHNXFYeVJ1RVkvdXd4d2VEZ2dSelVxd3FyNlZkZjUrMmFiNzJ1MWFI?=
 =?utf-8?B?cXEwVDBzQWx6N3kzcU5JSThPUWROZ0g2MWhoVzJjODRyYzZmY2V6aHpTeUNq?=
 =?utf-8?B?NFJjU2lOMDhMWm4xNVRScEllWGJQaG1RSDJJTGR6S0xsSVNtbjRZYlhkZ1RM?=
 =?utf-8?B?UVdUNmhWeHhJbGVtYkdLL3lta1FtV0d5amJLUFpHMVMrR0ltbDdTSTJlS1Rx?=
 =?utf-8?B?MHZGai9qbnd0d2l4dXRWcHZpU1JLaURmd0xRSVM5Z0RkY1FQdjhXUStRczVR?=
 =?utf-8?B?QWlIbEcvdjhGSmdZb1hIODZTVkYrNlp4S3NRMDk5ZzVLa0JjcVhEQWZ6L0I3?=
 =?utf-8?B?TzBvaHRrZ1dzSUM2S1ZNQ2NRZ2JZZTlnY3NpY3BnRjZaWmg1VVNXL3ZJQXpi?=
 =?utf-8?B?Z0dHQ1hpWEVkSUJmKzZSaTVsMHJyR3d2RUNwaEJUWEwwUVgyN1ZKOSs4Q0x6?=
 =?utf-8?B?LzJLMitvSDdqS3RYR0NoVVVueUMwa25kUGtlN3h0RU1HV0pJanNMOWpBSk1L?=
 =?utf-8?B?dUVnQ2x2UGIwMHlPb0ttWittbms1TTcyQURady85V1BZYW56eEZyMko2VGEy?=
 =?utf-8?B?UTFJU0pRRUlYeGlmUmJoTllML2k2dDZselIwTmRRc3UvazFiai9qQmlMb3pM?=
 =?utf-8?B?ajNJN0FlNThoZEsyQXh1OTI5VVZ3aVNHeERDWGx5Y2dpdjluakg3OTlZdlpi?=
 =?utf-8?B?NTlxQ2FrWGVzalgyV2sya2cxT1BoSUxLSXplbFdKclRHRFlKWVZHcVE5cndy?=
 =?utf-8?B?c2xMOURJOWQ0Q2J1ODVWNG5XSTRHa2JtMlc2OERHZGtxSElnUlFwaEJDTHlU?=
 =?utf-8?B?cjU4ZGtWM0h1NStrZFdUMVRYVEJGYWZJS2JUSm1UcldPT05iNVVtamlVNXE1?=
 =?utf-8?B?UW1KVHdyRHhJZzBiaU5BWXFpMlVzTHRoTyswRGt5ek5pZGFVeXhVcE1BUVF6?=
 =?utf-8?B?YVBGK3VvM3E0bVJBRG5HTGgrcm5GYXJGV2VKMTZxUkJqMmxrdTZCYjlTU0VN?=
 =?utf-8?B?cFBWdm9jWE9BVUk2anJ5ZXM3N0JqMSsxVHdoMkIyY0tjTEV0Ymd6Um1TMzVs?=
 =?utf-8?B?NXhzdkN4TmswcGdlUFhjTFJ5ekZlMkxPeGRQa0tnVXBQTVJ2ZWFQeUVsK1Nr?=
 =?utf-8?B?Nlg4bTdTN3doVEs5YWc3WS9LbGRkZ24veWlZZEZFekdmaDFNLzJQMGkvaWZG?=
 =?utf-8?B?UDRtY2k4SlowbTdTZnUzNnpYODZoWXBHOGhsVVJrOVlBQzV4WUE0N2QrQnl2?=
 =?utf-8?B?REFuaXh3STFsc2RySkFGQVowTHlSZ3dQcVY1SFA3STRXMzc5OUcvcnJsRmM3?=
 =?utf-8?B?Q21mckxMVGxxVDllaE5nSnpJMDlOZkZxS0YxY3NxWHRPYTdOejZiT2tMR0t0?=
 =?utf-8?B?dEErVUUvZWZxQXl2T0NHaDB1QlJwWjkweGVoMFVvbURLOWhENDE0RFAzUWFL?=
 =?utf-8?B?MDNONmJIeFd2TGdBR1FsZEtaNnRPWVB6NERzRjFJWHIvT1grZkJUeE1xYlky?=
 =?utf-8?B?NVhMeGJEcW9JQjlNSElzK2RQTjFTVWNhem1hSWZKcktkUFd5RzVpSW9HMExI?=
 =?utf-8?B?TkkxSUx1clQ5WEtBT201eGZrWDhXQ1BNN1E3MW0vY1J1VXBPWk1SRW9rRnZ3?=
 =?utf-8?Q?JsO8f2+kp1Sa39zeoFW6/Cw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a87fe1-39b3-4906-db1b-08dd96b41b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 09:04:05.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q288UMasqpwZuo6r5KyyHXkk6ytJ1Gcgh/5zAFEGlOJW5YRnMd8xvxGxZekDJDP1ubNI5XhrWCnSwaQXVrhWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3833
X-Proofpoint-GUID: rhcm0Q2BBHYPsDMwdHn-nmbiZnmeCxjG
X-Proofpoint-ORIG-GUID: MC1b9fKtQVgrKaT-VAndRc6WHs719_9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4MSBTYWx0ZWRfX7XSOqSbiZKK8 czcmnTJzKwxqxnda15ML2UrP40L5+vBAi7DxL5dG2wOBY9TELjq4kt3sbuOkJUSdRFzzqAif3qS HffnRhaSzfe8ZixSUtE4ITFZJuJorZhEArp8VpI4YibFJIhCS1xxwYJuhWpP8/Q7yr6MH3zmfBM
 EL2EVb/XCA5v0m81dslJNTW7Pez0XAt96e5AKWJm9w1fZZcBt9qB3DI9MlGWTNy0We0WG4tM4KN xlK+SXKeRvWRNtq3TZGPZ+9h/tU/cZIBvpKR6ncDgyLPbtDo+vQrom7KgrjknNUMGPBJOnUPs8P StgfPaYUGJ8zLR0vyrWoCCahq/8O93TLNE/YftU5ATckqdze0K11SFJ1PG3bjP11lavXBKMq1OE
 Z+TULA2EhH3IgXral2DP1mRRnsEuqelE+KrKb9Seaa6GuoByC6pHQwnh6QNZgB0XcM8iBxjT
X-Authority-Analysis: v=2.4 cv=RZKQC0tv c=1 sm=1 tr=0 ts=682af409 cx=c_pps a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=MNUl9BmgKzteVFJH8hYA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=KCsI-UfzjElwHeZNREa_:22
Subject: RE:  [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190081

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCaWdnZXJzIDxl
YmlnZ2Vyc0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIE1heSAxMSwgMjAyNSAyOjQxIEFN
DQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcmRtYUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhbmllbCBCb3Jr
bWFubg0KPiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBNYXJjZWxvIFJpY2FyZG8gTGVpdG5lcg0K
PiA8bWFyY2Vsby5sZWl0bmVyQGdtYWlsLmNvbT47IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJl
cmcubWU+OyBBcmQNCj4gQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBb
RVhURVJOQUxdIFtQQVRDSCBuZXQtbmV4dCAwNC8xMF0gUkRNQS9zaXc6IHVzZSBza2JfY3JjMzJj
KCkNCj4gaW5zdGVhZCBvZiBfX3NrYl9jaGVja3N1bSgpDQo+IA0KPiBGcm9tOiBFcmljIEJpZ2dl
cnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+IA0KPiBJbnN0ZWFkIG9mIGNhbGxpbmcgX19za2Jf
Y2hlY2tzdW0oKSB3aXRoIGEgc2tiX2NoZWNrc3VtX29wcyBzdHJ1Y3QgdGhhdA0KPiBkb2VzIENS
QzMyQywganVzdCBjYWxsIHRoZSBuZXcgZnVuY3Rpb24gc2tiX2NyYzMyYygpLiAgVGhpcyBpcyBm
YXN0ZXINCj4gYW5kIHNpbXBsZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJpZ2dlcnMg
PGViaWdnZXJzQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9LY29uZmlnIHwgIDEgKw0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaCAgIHwg
MjIgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvS2NvbmZpZw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvS2NvbmZp
Zw0KPiBpbmRleCBhZTRhOTUzZTJhMDMuLjE4NmYxODJiODBlNyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvS2NvbmZpZw0KPiBAQCAtMSwxMCArMSwxMSBAQA0KPiAgY29uZmlnIFJETUFfU0lX
DQo+ICAJdHJpc3RhdGUgIlNvZnR3YXJlIFJETUEgb3ZlciBUQ1AvSVAgKGlXQVJQKSBkcml2ZXIi
DQo+ICAJZGVwZW5kcyBvbiBJTkVUICYmIElORklOSUJBTkQNCj4gIAlkZXBlbmRzIG9uIElORklO
SUJBTkRfVklSVF9ETUENCj4gIAlzZWxlY3QgQ1JDMzINCj4gKwlzZWxlY3QgTkVUX0NSQzMyQw0K
PiAgCWhlbHANCj4gIAlUaGlzIGRyaXZlciBpbXBsZW1lbnRzIHRoZSBpV0FSUCBSRE1BIHRyYW5z
cG9ydCBvdmVyDQo+ICAJdGhlIExpbnV4IFRDUC9JUCBuZXR3b3JrIHN0YWNrLiBJdCBlbmFibGVz
IGEgc3lzdGVtIHdpdGggYQ0KPiAgCXN0YW5kYXJkIEV0aGVybmV0IGFkYXB0ZXIgdG8gaW50ZXJv
cGVyYXRlIHdpdGggYSBpV0FSUA0KPiAgCWFkYXB0ZXIgb3Igd2l0aCBhbm90aGVyIHN5c3RlbSBy
dW5uaW5nIHRoZSBTSVcgZHJpdmVyLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXcuaA0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gaW5k
ZXggMzg1MDY3ZTA3ZmFmLi5kOWU1YTJlNGM0NzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXcuaA0KPiBAQCAtNjkxLDMzICs2OTEsMTMgQEAgc3RhdGljIGlubGluZSB2b2lkIHNpd19jcmNf
b25lc2hvdChjb25zdCB2b2lkICpkYXRhLA0KPiBzaXplX3QgbGVuLCB1OCBvdXRbNF0pDQo+ICAJ
c2l3X2NyY19pbml0KCZjcmMpOw0KPiAgCXNpd19jcmNfdXBkYXRlKCZjcmMsIGRhdGEsIGxlbik7
DQo+ICAJcmV0dXJuIHNpd19jcmNfZmluYWwoJmNyYywgb3V0KTsNCj4gIH0NCj4gDQo+IC1zdGF0
aWMgaW5saW5lIF9fd3N1bSBzaXdfY3N1bV91cGRhdGUoY29uc3Qgdm9pZCAqYnVmZiwgaW50IGxl
biwgX193c3VtDQo+IHN1bSkNCj4gLXsNCj4gLQlyZXR1cm4gKF9fZm9yY2UgX193c3VtKWNyYzMy
YygoX19mb3JjZSBfX3UzMilzdW0sIGJ1ZmYsIGxlbik7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBp
bmxpbmUgX193c3VtIHNpd19jc3VtX2NvbWJpbmUoX193c3VtIGNzdW0sIF9fd3N1bSBjc3VtMiwg
aW50DQo+IG9mZnNldCwNCj4gLQkJCQkgICAgICBpbnQgbGVuKQ0KPiAtew0KPiAtCXJldHVybiAo
X19mb3JjZSBfX3dzdW0pY3JjMzJjX2NvbWJpbmUoKF9fZm9yY2UgX191MzIpY3N1bSwNCj4gLQkJ
CQkJICAgICAgKF9fZm9yY2UgX191MzIpY3N1bTIsIGxlbik7DQo+IC19DQo+IC0NCj4gIHN0YXRp
YyBpbmxpbmUgdm9pZCBzaXdfY3JjX3NrYihzdHJ1Y3Qgc2l3X3J4X3N0cmVhbSAqc3J4LCB1bnNp
Z25lZCBpbnQNCj4gbGVuKQ0KPiAgew0KPiAtCWNvbnN0IHN0cnVjdCBza2JfY2hlY2tzdW1fb3Bz
IHNpd19jc19vcHMgPSB7DQo+IC0JCS51cGRhdGUgPSBzaXdfY3N1bV91cGRhdGUsDQo+IC0JCS5j
b21iaW5lID0gc2l3X2NzdW1fY29tYmluZSwNCj4gLQl9Ow0KPiAtCV9fd3N1bSBjcmMgPSAoX19m
b3JjZSBfX3dzdW0pc3J4LT5tcGFfY3JjOw0KPiAtDQo+IC0JY3JjID0gX19za2JfY2hlY2tzdW0o
c3J4LT5za2IsIHNyeC0+c2tiX29mZnNldCwgbGVuLCBjcmMsDQo+IC0JCQkgICAgICZzaXdfY3Nf
b3BzKTsNCj4gLQlzcngtPm1wYV9jcmMgPSAoX19mb3JjZSB1MzIpY3JjOw0KPiArCXNyeC0+bXBh
X2NyYyA9IHNrYl9jcmMzMmMoc3J4LT5za2IsIHNyeC0+c2tiX29mZnNldCwgbGVuLCBzcngtDQo+
ID5tcGFfY3JjKTsNCj4gIH0NCj4gDQo+ICAjZGVmaW5lIHNpd19kYmcoaWJkZXYsIGZtdCwgLi4u
KQ0KPiBcDQo+ICAJaWJkZXZfZGJnKGliZGV2LCAiJXM6ICIgZm10LCBfX2Z1bmNfXywgIyNfX1ZB
X0FSR1NfXykNCj4gDQo+IC0tDQo+IDIuNDkuMA0KPiANCg0KVGhhbmtzIEVyaWMhDQpXb3JrcyBm
aW5lLiBDb3JyZWN0IGNoZWNrc3VtIHRlc3RlZCBhZ2FpbnN0IHNpdyBhbmQgY3hnYjQgcGVlcnMu
DQoNClJldmlld2VkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==

