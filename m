Return-Path: <linux-sctp+bounces-524-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F5AAB9A5E
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540861BC3CD9
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3C233128;
	Fri, 16 May 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W5f0ilQd"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CC21B9E2
	for <linux-sctp@vger.kernel.org>; Fri, 16 May 2025 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392134; cv=fail; b=ZLhD7SK4stMlUc7SX7xlfW8lDVnwf7k9oAKTq/1cta83/Or0PUYQcYmCsFo8QXX8MnHHCJ/I5goa6ob6QCadXlle4oEak+Ybl5dMYJCaWbx6IwJZmbe2h2HP5/Nwv2Ili3TQEg9mHmyprT/WttkMmp8cbsNgKRDJpOS/mvjOyZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392134; c=relaxed/simple;
	bh=siH9Gl/mtarDsR80jFRPuripE2HgtMaF6T/ihVzTmk4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lBr0yq8w9M4TdPiikwy3DSiV3WRh/hHgSq3QgxDyiFR//koQe22XekuKtYNZnqYIRdhS2Gfbu5dPwekgsRZBiJszv3Amo2rGFbCUGeyX2i2joew3wq292r1BE4UKyp4RICet3GE4b+lK8/NUnLpzdwhrOFDpq/UJT3Wt8a9AK6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W5f0ilQd; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5veRR010986
	for <linux-sctp@vger.kernel.org>; Fri, 16 May 2025 10:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ICo3Qs
	XJdGiAZ/+eInv3xmeaFZ7xSBpPU8KOSNtF1rU=; b=W5f0ilQdfvhC2ULRf0hSAN
	8Jztklz1ckz0t5nxF3uE+Q8S30r5iauqwUpu+tDA4u+WegEPQvjo2hFPGnkttWYW
	Cj4p0/vXSEL1pPUsHMI278L8owfDUXrzCXrerFtnB5V+2pQSee/sx3/mJ/B7HTH+
	R2cl2txSVqiZuAixtf0Gm0A8WRZ4jkccbLbSk1ZQm4FqKyTvzGHPfotnWmCg5PfT
	3Hapo+CaIYC+xtAPhrrpvibQmRhNa1ygAoEkvcFuN3+2uU0LAXVlUfOXhX5PT1yI
	H9e5J+7Noesf3LCFgfECoanMo9mqL0hMe9r69mQ9GhbMo9CZ7PnRhIkdt1tYFNbg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nny7beke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-sctp@vger.kernel.org>; Fri, 16 May 2025 10:42:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54GAg8mU018778
	for <linux-sctp@vger.kernel.org>; Fri, 16 May 2025 10:42:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nny7bek7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 10:42:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54GAg7LH018746;
	Fri, 16 May 2025 10:42:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46nny7bek3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 10:42:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1Kj8k1fI64mU9pIWXENovyMz49XZOzDmI5sl5RjVBsVNHcWodkH8YIVdp7sfrFTV1CAEvJ+jIy/MLpEO8SiF7Q0y0Q/cjL61UjDOaAgzVhEPhfwLq3E+xpU7buI5nVdaRJf3BeD6lCuKuI8bgmIEXJ+wC76Gs5f/GPReeKHznRgv7ECO2jeya35CRDZLy+f98wwoz0sx6rWbpRq6g7pXc48DMRYfy4WnE0wHvufc/Txcnmj7t+NrTarxB3hkbZsBqH752g6LlpP1282rTeFTMfzMZ05zcqyED3CbYiU4S3PQ1XXYDfZ2V8xV/gf44smkUjEbNuG/V1ed0PMWCrRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOu7h3h6GSEzET3ATjZAyA1PAiCa2g23NEfxWOSl+CU=;
 b=bQFAkTYKtIHUhD3Z4hoZIXigsXto5x8WHESYFRFKZAuo8JIe8t5Q+9df/OC6mHeBgA42W2ctU7ZHq5ioAuvq+isbizzVPs4Xoq3hgNK65v6a6vyWWSeWPxvriHa8LcZfBudlzlwUvQm+bIpoFjJM2XPc/JDebpD65KLgViN/fsQMZGjdbyGdv7IQGfiSfxfjZpwINLRgwt2y+0joXUF+1PP0F2RPCJG5Vm+P2NFSkfbokNHLqHMGj55eRP7ij+zHOYSy/glGwKnqafkLEfWvVcd86zeTWtqvMdL9lI0J9sccghVRwplhjCnNIAn92NLxPqb8JHuoQHZSEB1LAwXZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from DM6PR15MB2522.namprd15.prod.outlook.com (2603:10b6:5:1a9::11)
 by SN7PR15MB4205.namprd15.prod.outlook.com (2603:10b6:806:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 10:42:05 +0000
Received: from DM6PR15MB2522.namprd15.prod.outlook.com
 ([fe80::75f3:e794:8dcf:7855]) by DM6PR15MB2522.namprd15.prod.outlook.com
 ([fe80::75f3:e794:8dcf:7855%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 10:42:05 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>, Bart Van Assche <bvanassche@acm.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel
	<ardb@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c()
 instead of __skb_checksum()
Thread-Index: AQHbxdROB2gH0sdzfkmj6snLXz6027PUH8qAgADyESA=
Date: Fri, 16 May 2025 10:42:05 +0000
Message-ID:
 <DM6PR15MB2522334B8E3DC181892296D59993A@DM6PR15MB2522.namprd15.prod.outlook.com>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org> <20250515201247.GM1411@quark>
In-Reply-To: <20250515201247.GM1411@quark>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR15MB2522:EE_|SN7PR15MB4205:EE_
x-ms-office365-filtering-correlation-id: dbf7b2b4-c3ac-4339-f86b-08dd94664cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUVIL2svVzArd21ET2daZUNyejBrdTRHSDBhWk5iZnd1ajVIUFVSMzc2UkN3?=
 =?utf-8?B?UGd3dU9ydDF6d1dqbXB4clJwMFpTQ1prN3QzRWtBTkQxcHJYMDNzYXJDWEdI?=
 =?utf-8?B?QnZCdjRKRmxUamZEKy90T2lodWQ0Wkl6THFCcXYrMkNHTXdhZ1VNSTdEYis3?=
 =?utf-8?B?RXd4b05JRFV1TGo2QVJwVzB1TkhwbkR2MzFxVjBkVE9BU2ppL1pUZW9iaXNP?=
 =?utf-8?B?Q2Z6cExwdytzdzlJZURPY2EwNHRGb3JMTlBrOFpMRkJqTkJnQkxQcTdzayt6?=
 =?utf-8?B?dnJ5VGc5WUZ5dzhCaXFiVzdSaFhkYitSVXlIYjF4L0xLMlhNNUtscnZOU1ND?=
 =?utf-8?B?OE5hZDYyQWpVOFowMG1qR1ZUN2Fjd2QwZ0FkeGN5UWRTZ3RqWlZPZVVGYmFW?=
 =?utf-8?B?ME51L0ovUllYTm1vY0NEenEvcFN4cTNDTnNhTDgxNGRCREVYNjlVOC9hblp6?=
 =?utf-8?B?OFBBMUxXUStsU2FmZTZEV1p1aUhsd1lOQ3hsKzJ5UWd1SDhuZkZGTTE2ZEE3?=
 =?utf-8?B?UkJDTkd2aVRsTUZkOW04VXdDSUtrNG10YzNMVFE3M0kzalN2SlVIeFhWK2k3?=
 =?utf-8?B?bGNBSnkxQ2NvMFVrNE80dlk5SEY0dlBzSU1mK3ArUklEMURyc09zbXZDbUdi?=
 =?utf-8?B?L2UyRFlwL3RBTWJFUVVQcnBEMmw1UW5iQ3NMbFRSaVh5VG1ZRVhIUENta3R0?=
 =?utf-8?B?RmErVDJhUDZKTVBOdGJIOFg4T2lQNjdINGpEcEQ2cmZJK0xVZ1RTV3d3WDNG?=
 =?utf-8?B?bDUrbXBGeFFmVWtnZkJZU1N0NWVpYnRPak4vamI1TkQxbzljVGMyc2dYdnE3?=
 =?utf-8?B?WWRZdnl4eEtOWU5xWXdVbTdXWDRDUHc0WjNSMy91K2UyaWx2RFBMdGRiT0dm?=
 =?utf-8?B?VWNUYnIvSUhMWUh0VnFtMkdrd0R6UnNUUlhIZU9PYUQzVWFmaVlwWWFCN0VB?=
 =?utf-8?B?SE92ajBYbGtZaE4xSHRBZ1lvdjdXUHgyaWRhT1NRemk3eFNuUnRzOElOZzVH?=
 =?utf-8?B?MmhHcy8xWTM3K3BJekJQam9lc3NQZGZkcUdUT3J2Z09aT2ZxeUVySHJtS2Rq?=
 =?utf-8?B?R3B0ZUZFNUJPUXVTb2NDMWNLNFJxcGNOMGVRWlpLMWloNS9JU3AwaVhSdEw2?=
 =?utf-8?B?anREODdsWW42WUJjQkdzYllYY3BLMmlMUnhncXREbEswUHhmVlJIakRsZm90?=
 =?utf-8?B?eXJERWx4MHpYeEJUZml4anhEd3RIdWk3YUV0TlliQS9qZzlzaVJxZWpRWEVr?=
 =?utf-8?B?OVNBSlpJTmlXMENKRllkZHphSnZiRHliRDVvZkRyN1ZROWlBM08vSXA5SGg3?=
 =?utf-8?B?emk1OStYWU5iM3JjR0IvT0x4dEF0M01xL2RJQVZtbEk0UWhhU3Q1ZXpwRUFD?=
 =?utf-8?B?QkdGaDZVbHVGbHlDSTFnOWZzQ3BycnBnSlAyb0V0Rk9CQzRKQXIwRWlTbG51?=
 =?utf-8?B?TGNiQ3BxQjlPcUExK1R3K252TWFJTkJWR2VwVTk2VXEzYWM0aCtLTnJiU2ZH?=
 =?utf-8?B?aDVLejFNVU9ERVhCcnNxeE8vSFJuMXVrODNZMmNyT08zcDRkdmdua1VnSE43?=
 =?utf-8?B?K1IydHp2TnB4STgwNE54SWdNclE3STlud0E2eHZOYmxUa29YbTNJelhPc2kx?=
 =?utf-8?B?RHBqQ0pUQTB6aGh6TXhuYXhTVmprUzkrRm45ZUdQSkx4Zlg4STFScVZPSTNv?=
 =?utf-8?B?NjE3Yjk3Y1ZDTGRjQ3R6WjJaUmlMdHN2cW1qM0pDUGVhcTU0ZVE5K0JIMFJu?=
 =?utf-8?B?ZGIwMzgvL0VSRkh2Y2lEKzRsbmhrQ0hyOTNtYjNhbTdqWGNWamNmZEh6UEN4?=
 =?utf-8?B?aFVJUUhoU3RCcEFveHVLa2Uvb0EzYnQ0UXpiNjJpV3JWYy8zcFJVazFRRkVp?=
 =?utf-8?B?WG5iL3VXWk1NUnJsellKeEtSL1VoZHBCanNmc0hNODF2QmhwUG9KN0FXLzEw?=
 =?utf-8?Q?p+6ww/ruL7A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB2522.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czZ4T295L3Rpc3RhTDRCcjRUd295SUlrNkp4VXQxV3FCaEV5SzVCd0gveVll?=
 =?utf-8?B?L1ZCOXBqRnBoK2FLS2lFYnFhKzJ4NWRZbkd4eWxHV1phbHZTZWxhdXc0UjRo?=
 =?utf-8?B?bllOakpvMDROWENRRmhDcmNldHJ3Z01XZ0NXL2F3RHQzMXYrTTVYcjNXUGY1?=
 =?utf-8?B?S2ZzM1pBbEtLWWRRc1l5bnc4VE8zTlFlOUQzU1VvcUtoS1R2KzdPbnV4M1JK?=
 =?utf-8?B?ckVFcXZzL3IydlF5YlZVencxd09rTVVna3drUWRXZHpIM0VYa2lCbHVOY1Fk?=
 =?utf-8?B?cy9iV1VBTWxEcTAxd2J6Yy9TQjY5MlVsbWFPd1F4N01PcWduK1U1M05tV2VH?=
 =?utf-8?B?S3BOZXhsN0VnTnFKaVhDMGJjOVc3OTlQVHYzM3cvdmkwbmQ4a3MxTnZpZnJV?=
 =?utf-8?B?cDZSZ3FpVlZ4czFvNFhMN0pIUnR2ZWYxWWRKenpMTXRCZ3kyeEVSRFBhSDhx?=
 =?utf-8?B?NldJejJsRkd2bVFEWFNqR0xUK1ZBZWVSOHNDVUovZkpSeXRNRkV3a3VrajAz?=
 =?utf-8?B?bHBQa1JLWGRhY1ppeTNDOVNmeEhwSGtPaUlJb3d4UHR1c2J4b0NuZVFTd2dB?=
 =?utf-8?B?RVhHaU5oZTRRYkNPbFRXWHBMUUlMeXBxcVpMVFFZWm4rRHlhdzBUS1lmc0hY?=
 =?utf-8?B?UmlWZWYrTWt1K0tHQVlEcytIOGd1WkZNaDhBcjY0em9KVHBQWnpKWVIvSVM2?=
 =?utf-8?B?aVZpRDU4S3I4ZjI3bTNpOGoyenFqUHBOdCtnTXdiaXljTnYvNkNaYmlJS3F3?=
 =?utf-8?B?am1HSXp5YnE3N3Uyd0Z3aVBxbzJKc3FkT0NQRzgxZUhhdHhTUlhxMkFVbGlL?=
 =?utf-8?B?U1FHUDF4Uk5rc093TG1JZ0hCVExweVlGN0R6MTFGUTRVc3NrVThPWjJhUGE4?=
 =?utf-8?B?bi82Y1k5N3JwRFdGeWs4M3lhNVFySkJUVHU3aDJHbjlRNURNdHF5czRkTStF?=
 =?utf-8?B?enBnczZQK2hNbDlzV25MNGExT28yc29jWEE2SHFKOEw5OE9iZ1hhU1VmOUVu?=
 =?utf-8?B?T0JHSW5BTEwvb3A4SE14cTdqRko5enFmL0U5bWV2ZGZmVDNXWWhIZHBUSWty?=
 =?utf-8?B?NzA2TGpBYTJFU3J3QmdqV3hwM0I2NU92SEhGbUZKMzNqSTd2UUdtRHp2RGVt?=
 =?utf-8?B?NjlFSzJ1N3VOOEgxekdvR1dGVG5ybGIxaVJkbnhoRmlZMVI5NUNyTm5tTCs3?=
 =?utf-8?B?VVBuVEZ0OStKbXpKYlRjT3BMRVpoRkFMZk1UZHcxUlFmZG4zYzJUS1RlSnNM?=
 =?utf-8?B?VXpRN2kzQ3dpaVFoNExUNC96SWJzek84RkM4YzlsMVZ0N0RsT1M0d3BEQmpk?=
 =?utf-8?B?a21kWTFhbnVKT1hoVEJwN1pzb0YrU3hsbjBUK2pody9MbDhWVzE4STVEZUh2?=
 =?utf-8?B?OG1lZWgwK2xtek5mQ3ZhaFV2Zmh4aXp6Rlh4c3JtWEJMbVNYZTcxZUlKWTBH?=
 =?utf-8?B?NGlIZEdpc0lBSDl6U1gzTmE3SnkvWTJaNUdkblN6aGNSeVQ0UU1vMUZzT2Fn?=
 =?utf-8?B?WDI2Vis3SnQxTngvdkZqSEd0cGI2bHRvSDFMOGVsZURrY2kzTUk4VGRnM3M4?=
 =?utf-8?B?YXhycklEZjFzNm1zM2hQRC9GRXIzNFlBdmpXdmczcGVuQm1ZRW50bEk1SHBy?=
 =?utf-8?B?Tm44NmRYS1F0ZEQ4TVBkM2NKbjAzd1VMSkZyK2RjcThuOUo4NkZKWGJSSlVo?=
 =?utf-8?B?UFVQd0RhOGczS1E4dFlKbGp6VVFkTGpSVVRNOTBTOW5JVnE4QjlZNFlmMjR3?=
 =?utf-8?B?WG1OakIzRFBuTnlmUk95RlFOY0E4UmU5a0VyRGt6Y2JLeEt6ZUN3K08vR0Ri?=
 =?utf-8?B?T05WZUtWeDBEN2o4emY2WGliVHl3UjBlbUJ2QzlTc0xrbitxL1A2cFR3UzNZ?=
 =?utf-8?B?Tm92ejVFRUdUOVVMOWVqSXIvbjBIYmNVTlJ1MkMycXZHRzd0SVJiYTA3bGFk?=
 =?utf-8?B?cnZpUkFUYXovMnh1Y08yUFV1SlZnL2sweEZ2R1NIbHUvblQyVklTbkRHVmhx?=
 =?utf-8?B?YjkrZE50c2ZwdkgxUUk5SHB4QWNtaW1Sd3puTXhIVHdtSUUvLzlyWHlqcStB?=
 =?utf-8?B?TzcrS3JsSkV4Rmc3SFlYeXFEeWRpQWllc3MzU1U0aVBqT1hyVkZTZm52QzlI?=
 =?utf-8?B?bVdPdk5GRGlWTkR1WnF2QlVCQjRzQVdwU0U1ampWOVI3TU1PakdnYXZPYW9a?=
 =?utf-8?Q?l0yyUzONGyULmY6jEQJc5uw=3D?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB2522.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf7b2b4-c3ac-4339-f86b-08dd94664cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 10:42:05.3643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kx/+JJtrnOqAO+gIUKdXaTzWnj8N2fQh90waPwkIzYrMFfB0Px/Zl9hdYHROG7EYY5ccLOFSXs3xOTbYd7CVmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4205
X-Proofpoint-ORIG-GUID: HYrFv_iV-8B4PIJRrd7hed4-w5Zy1Bbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwMCBTYWx0ZWRfX3MXf8wWkeOXl KpR1922GBL8gnzvrZi3fkr288LiGxJQ+Xrris6x3L4J9Kcqytvn/BHjxceYAHy6xNa8yUFS4g4h eWD/hMt4cDBeFmDuMEK3J66FwQ6Mdc1Ke1Hp+KTFhoq7wbfPEZNOywcXPK0zDKegbiX5s+jvhEz
 qvJoAAT9JxyrMEXslWXuGKlBNllWdao9n39rX/w0nEGqKK3VV5KsGXuhkZor9ZjhIekHJ4boDya n4rRgPqt4NIZrpFtZPWMPCFFkvqe01pkgKkyswhlIUA50wl72Nr1nNRTTN/ZpGM3nUojDY3ejlj 6sptxE9sTnH4t4j+8pvSvEtwO0mkb0DITyhcp51/GYGnv1g85Ej4SZHENby98zbi5BidxJ8w21U
 iLnUuTKK318ZSPTvpjhgb/jOolhUdWQXUL9IXgDcgDXTPYZ0fL/0tZe8LfxyCoWlAh8BhdQE
X-Proofpoint-GUID: mzuy5QXGd9wr6YYefxxQzlSuXK-PSLya
X-Authority-Analysis: v=2.4 cv=CfwI5Krl c=1 sm=1 tr=0 ts=68271680 cx=c_pps a=YmitjTGdGiwdiEq1Q8pHfg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=N54-gffFAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=HH38KTZgEw4nFtG3iMQA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=KCsI-UfzjElwHeZNREa_:22
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505070000
 definitions=main-2505160100



> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Thursday, May 15, 2025 10:13 PM
> To: Bart Van Assche <bvanassche@acm.org>
> Cc: netdev@vger.kernel.org; Bernard Metzler <BMT@zurich.ibm.com>; linux-
> nvme@lists.infradead.org; linux-sctp@vger.kernel.org; linux-
> rdma@vger.kernel.org; linux-kernel@vger.kernel.org; Daniel Borkmann
> <daniel@iogearbox.net>; Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com>; Sagi Grimberg <sagi@grimberg.me>; Ard
> Biesheuvel <ardb@kernel.org>
> Subject: [EXTERNAL] Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c()
> instead of __skb_checksum()
>=20
> On Thu, May 15, 2025 at 01:02:20PM -0700, Bart Van Assche wrote:
> > On 5/10/25 5:41 PM, Eric Biggers wrote:
> > > Instead of calling __skb_checksum() with a skb_checksum_ops struct th=
at
> > > does CRC32C, just call the new function skb_crc32c().  This is faster
> > > and simpler.
> > Bernard, since you are the owner and author of the siw driver, please
> help
> > with reviewing this patch.
> >
> > Eric, do you already have a test case for the siw driver? If not,
> > multiple tests in the blktests framework use this driver intensively,
> > including the SRP tests that I wrote myself. See also
> > https%=20
> 3A__github.com_osandov_blktests&d=3DDwIBAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=
=3D4ynb4Sj
> _4MUcZXbhvovE4tYSbqxyOwdSiLedP4yO55g&m=3D42RdxLC4OJSKYtu0EOtGxON-
> daxZpwd8xG9briOxYyywxa7RWrL-
> KukLFCucHn_c&s=3Ddtz3xdRBYawI7d1FpWaWUV_QhDeExTyHGbPMZLxpzPQ&e=3D .
>=20
> No.  I'll try that out when I have a chance.
>=20
> If the developers/maintainers of the driver could help test it, that would
> be a
> lot easier though.  I've been cleaning up the CRC calls across the whole
> kernel,
> and it gets time-consuming when individual subsystems insist on me running
> their
> custom test suite(s) and providing subsystem-specific benchmarks.
>=20
> - Eric

I'll definitively test it. Sorry for the delay. You will hear from me
next days. If it comes to things like checksums, I always try to get
a setup where I can test against RMDA hardware (Chelsio). Hope to
find time over the WE.

Thanks,
Bernard.

