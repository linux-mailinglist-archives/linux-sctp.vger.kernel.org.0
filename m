Return-Path: <linux-sctp+bounces-274-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE09B5104
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2532852CD
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD81DFE2F;
	Tue, 29 Oct 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="IRxAmv15"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403A1DCB2D;
	Tue, 29 Oct 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730223151; cv=fail; b=NsGPM4tZvVOsNQW9063LXvUETzrLSASNTf8sNv9pesaSEqj3V+TQ42Ci8OZYYjKkiCGiF3dm6F/H4dC7kfXEoju4HbPGVuTj2pgbSiSpcgK4PZo2urBkrBBI9ipe3PmsTvYTu9aquuTys638y5r/CbFbHZNZDLlSiYPjc8HYfK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730223151; c=relaxed/simple;
	bh=CBpsLp7NUsAicAIx5XebxrKE/UhoRgo5oOOrVQ0cg/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5451P3f8PtMlH9+x2QhgRJvpgiM8uZ9HlyAbUvMe+ML9uu/zRSev87xPRRS/6NrhtIx4k47XT9NaOc3Uv/mjsqIhbeuSGQAWGzrEcqSqG64EUXHqcfIsMeKK2FnJVTDErtFm3nMq+lcAkB5b6bsfxn8TjFwi/Ibh8BeYA2Tg7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=IRxAmv15; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6E67F200058;
	Tue, 29 Oct 2024 17:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txt5WxP6+IBd6lWyO3xv9V0Ul7KcKai4hbKCJY0rnlJhzOvjmWTI1oBKZYeJR811FAYR6cSqT41fE64BUaC/LinqLLx0oLD7hGriTSz/VmD2dnZOzT7oisMAg22XwbZm4pl0HY67o8k4Zkv04A3C1NtxA9KUlY5QRHIRlwUAXikolDijyzg8gQvL+AVRQ4WoCyS0aQqiDMWKBlsgUSJ5LRWYsawWutYZbcyQC3JjmVI6lJoD/whfYh56+Z/KmLoPY6nY3cnZijKG1VhFx5KV4ljjmKE82eE2AId9H7K/5uMwUE0dmAyAeuL/i+gZJfk3Z5aAYdaypSf+P11XWDXU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBpsLp7NUsAicAIx5XebxrKE/UhoRgo5oOOrVQ0cg/4=;
 b=ZJLVTMEI7omBO8wAgNuG/2EZxiqYPIahYUg32WOmuMZcE3i6s1JtOpzyHJ+eh2dCEXgMxolcsRoVUY4nyk/Ub1SF3PDH4ewJs2lbw5HBw0hV5KkOdZJ2q/UEYLG3rz5Ov31XASR72h82GU9Vl/HkaMzYs9/Nu/s9BCjiUb4dR4qNxCiLeEcIjF6LqXKV0hTiqBcOL3wUzNxrzuFvK/37ofSnoNUlqMmB/sk/pjN1c/sk6kWfujzghO4aQoNdJYy33OWCirRf9U/tor2DgaphdJ3WiJctIMStPcxED1yAENDQ+SbLh6Su5qXAl5u0hVqt/9975SirY4K9D8pLMqVd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBpsLp7NUsAicAIx5XebxrKE/UhoRgo5oOOrVQ0cg/4=;
 b=IRxAmv15B+s56gYwcU4Lii/8MH0DNIWIjeTWnecJkx0hiJ4Zj/qrbg3mI2QYLYRXgi084xkS8ZLy7sld3FEr8Tt3KPS5B98bA28f/qGoWJCftouP7Z/zJKvK7oyQHNjx/6uNP/YTQct70wJvDSZomgt9+Jyx4c8WHjq+Iy3tWHg=
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9873.eurprd08.prod.outlook.com (2603:10a6:10:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:32:17 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 17:32:11 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: Xin Long <lucien.xin@gmail.com>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] sctp: Avoid enqueuing addr events redundantly
Thread-Topic: [PATCH net-next] sctp: Avoid enqueuing addr events redundantly
Thread-Index: AQHbKRDfr0/aaXZP5UO2qaYqHmjxzrKd5dWAgAAY9YA=
Date: Tue, 29 Oct 2024 17:32:11 +0000
Message-ID: <8A95C40F-233E-4828-9D19-D26CC6307CC7@drivenets.com>
References: <20241028081012.3565885-1-gnaaman@drivenets.com>
 <CADvbK_eUK9QLzJ2HYtqQ1woAF=pcgTbvckeqCk1Es50HkxdZTg@mail.gmail.com>
In-Reply-To:
 <CADvbK_eUK9QLzJ2HYtqQ1woAF=pcgTbvckeqCk1Es50HkxdZTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR08MB5388:EE_|DU0PR08MB9873:EE_
x-ms-office365-filtering-correlation-id: f70700a8-033f-4380-f73f-08dcf83f9f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEdtM0dsU2NGVDl4TENNS3RsNWt5dEtURXlqTU9JeTk4UmZGSStCa3JVT1F1?=
 =?utf-8?B?ZHU4OGlNS0RhM0txUllxUmtiYjk2NW1ESHI1SDVRZTRiZ29pZEFzZjcwVDEz?=
 =?utf-8?B?dCtkTnRZSGtDSWpaWUIwdlAySW1tZUtUZWZxelMzTHBXS29RdE9jMy9MRzFa?=
 =?utf-8?B?ZCtCdU5TQmFBR09CL2RRVVJTNlZhbHpJdjRoQjN4Nk5hc05Ealh3UnNzK3hU?=
 =?utf-8?B?U25mSENmY2lQR29pWDFlcE00OUk3bEVCSTZualpLV1cxVFpkMGsvTjQ5bFB4?=
 =?utf-8?B?SzY4bkhnc3hZcEFhRkFkdjVuYllDSU9uaExERmpQWVVEKzdxUkZQQ3dLczJP?=
 =?utf-8?B?ZU1pTmFjamhWU1NIQlJVQ1J5Sk9WYk9mcnJNNkNjVUt3Q2wreEllWWJ5UW9G?=
 =?utf-8?B?VitCYThiL05zV29tajhVSks1amd5c2gxY2hqUkpIKzJhVmV1MkdwbnNOaENy?=
 =?utf-8?B?ZVRlN1MrS3h5YlZJNFdaNklxZHZTSndEaGN0RVJCclRHcFZ5V0s0RlNYRFF3?=
 =?utf-8?B?VURHUWozazJhTXRHNXJwR1dGSTJlZU05QURYejRpV0FIWEdRVS8wWFVVQjJB?=
 =?utf-8?B?djlHNmJhekhwVThJYjRXSTdScStadXBqUmdqZjI3a203d1VDckRkNm0xMFdn?=
 =?utf-8?B?aDZHZzg2Q1hoSTFNQlp5THZObm9ZWG0yMFQvcUM2OWJzZTcrckJIV0R6Rk96?=
 =?utf-8?B?UjFucEg5azMxdTYwR1ovWGVmY1Y4ZnlJU29FN0RlUnp0SzB5ZmVveVM2Yjk1?=
 =?utf-8?B?MVc2SzREdnZ4K1paMU5yYkxSeThubU1MVHMyZE9qVk5mSjdwU3ZCTUMyeGhx?=
 =?utf-8?B?WHMzMFRoN1d0aDVSRjZXd21qNFg2YVdCRzNIeklaMXNEam1rMk9EcFJnV2xX?=
 =?utf-8?B?bFNpV21ETGxGcFN3UHFDWlYxbi9YZWxuVnZSY1llcXJsZ1c2aExXQWJDRU5w?=
 =?utf-8?B?UFQ3QkZFbmhHSFMwT2RkZEVGWWRYNGR6RHRsYzBadlM1b04rOERhVVdaMUlx?=
 =?utf-8?B?eWZNRk1uRXl5YUVXdmRVUGgxSkVqZ2Z5VGJpZUtSR3JJV2lLckhWMWFqYTky?=
 =?utf-8?B?Q3FnOS9NMXAvUm5CYjZkM0JhM0RNSmJIQ3gwNTM2aHpzNVdvVWJieU9nRTUw?=
 =?utf-8?B?MFN1MmJSM1ZhVE5rQ3BpdWpsZ2xNd0JLK3g2emk5eUNERythN3pGaytCcVZa?=
 =?utf-8?B?NG14N2dpRlhmRVpxbUthazlwT29IRmdvQVlWalpGd1Y4cUJYTzBocFZ6bS9k?=
 =?utf-8?B?dG02TjVQdW4raWRlQmlrNy8vbWd1L2lYMTNERzlYem1odEF2OTFzdzhpVFlt?=
 =?utf-8?B?aS9YK1hFdEVkRlFLdXpnWFg4eGVOQy85T3FHNkpMYVI2eW5ROVlSY1o4Rmcw?=
 =?utf-8?B?a1FXYlNUR2MwcmdjUTVBZmRnTkxLR0lodnFSdm9BaTdpZmpxb3JOcmtiT0dn?=
 =?utf-8?B?Z0NrbGxzQVF5d2xyaXVMRGNJMjlUL0d0MjRxT0YwMUNhdGRtamRET04rNUNB?=
 =?utf-8?B?eFBJVlBnWlIxZ08wakdvSUxYSmlvaUpJdVJ2WWt0YVU3NTNKeVFpY0Qvdkc3?=
 =?utf-8?B?dzk2ZEtUWVc4ZDNsdDFQWFYrQ3hVcm5uOEJBRURlSVFrdUtXUW9VK0w4ZkZF?=
 =?utf-8?B?Ukx0Rlg4LzJVWFBxL3JUdDNreGtvMjZ0V08xQkpZMkVFdk1DalE3aHpUdnRt?=
 =?utf-8?B?emFBbWpMaWFaTndISDVYeXhJRURxMTZtSXBldGl2M0VmcHlHODdYVnRkYVdE?=
 =?utf-8?B?bDlDeTVMWlRWTDZ6clMzKytNQzBwSDNxa3IwSHQ3aGNLSk9zdTVoVHlJTzFO?=
 =?utf-8?Q?GyiBne77//W8uy59zqg3o7o+8A0hlZJEtGuR8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmNOME8vUkdKRVUzbmhkU2QySmhBVVUvTkUrYU4va1dFZWNBQVZZUWhKQ0Q4?=
 =?utf-8?B?STYvT1N4MUVGa2E0SVRZcVA4aEtEYmw0N2Vjc0hOYXNoaUtkd2hpTldqeDJa?=
 =?utf-8?B?V253bXVJaFNqVTNxclZWbThzZDdMcng2OGJlV3UraGpPMHpBWGtvTmNFOEcr?=
 =?utf-8?B?TzZJNXlWN3BvOFEyMzZ3MXNFWU82Ui96VDFOcTZIb0VRRUxlcWJObkcwRXM3?=
 =?utf-8?B?TkhnamdHWGVrOWpDNzF5STdnRmQ1dGFydmFJS2NoOHFEMjMzUlVMQ0R5dW00?=
 =?utf-8?B?amNEM040TkdRV3I4aTVUb0NWTkwrQVlpR0JWbVk1ci9hbml5akFCTGE5TFAw?=
 =?utf-8?B?aEcwQkxHQ2xiY3lxWTNKNkZMeEFsVlNWbVBUT2UwSWxFekFHOFVWbFByZFBE?=
 =?utf-8?B?bitEakVsU0sraVlHOHMvQjJSOEhNWkMzZGo3YVhYN1FVRjlUaks1Q3VDcHhJ?=
 =?utf-8?B?bDVFNThuVWxRVDFtS2pZeGQ4a1VKcWJSaGdVcXA0TVk5UnR0MUEvSHZ4VGtU?=
 =?utf-8?B?ZFBJRzBQYWUzYk5DMFd2TjJBRlpDeDhGZFI5Z01xaEdQQXJIRUpCTXZKRE9D?=
 =?utf-8?B?bmRoVFNTNlUwemtCR3cvamhKK1NXNFBTcjR2TzZNQlZWTDJVVWlYM3B1Y3Vo?=
 =?utf-8?B?Zi8xdVdVdk5tMmQ1c1JKYUI0OXN2eDZhRU5vR3oyWWpNa3M3VnFzN2hlMEhC?=
 =?utf-8?B?QUJNRUpEUXczTVQ2WlAySjhGVEo3MDlZY0VNZnY2ckZYdmM0K0dNRm9mSHNL?=
 =?utf-8?B?ZTFqSGVCMWhJdEI5dnFrWjUveEZEUTZTd2YzRERwVHdEQzFmcW42RmZpbkVl?=
 =?utf-8?B?ODZYZ2Y5MTB5M0l4cnpCQVFQeG9YQ2daK0FKK2lraWZ4Tks2WUZnSVhHeXFU?=
 =?utf-8?B?bmVqS2FGeVVyN2ZjbmYyUkZTK1ZQUkNtM2dCNmlIc3BvdU12UEQ5em8xdWo0?=
 =?utf-8?B?OWhhNlBlNDQ3NkFGNlFhb0pMc3RkcGlTbkN0MnF1SzN1dmZKTjNIaE1ZQnVh?=
 =?utf-8?B?VHdKdHBTTTFvVTB5bDFBeGxCOWU1S3RFUHlLdTJCTERKcURtSGp5M1BqTmFk?=
 =?utf-8?B?M2NjbThyRW91Z3k5S0hzSXdnUnhQR21EQklkcG5HT21Lam1aRVZFRVZLQTY4?=
 =?utf-8?B?Q3BiZ29XL2RWdjRvTEo5L1FNN2tLNkxUcHVnbGMyYmg0R2hnV2JITU1VdWcw?=
 =?utf-8?B?elFONVpKVC9QWlp3a3hBQVhUZE5HaHBYbmdZQU1OOGxzMmp1azdHUFAyQVVW?=
 =?utf-8?B?bjhYMS8xbm1HMzNjS3lUbDJPbVdOLzEvY2UzODFXdjFHOVVUaGxWYUNXSkNr?=
 =?utf-8?B?Lys3cG4vczN2VXdIRjNLSE50WTJoUDZDQzlNczNrbTVBc1l2eC9DeW1UTzh3?=
 =?utf-8?B?bE1OUnlNOHo4bEpUdy9Ic3MwNGdMNDRQQk5VWGE1RjVCOThOVXBrY0ZUNTdW?=
 =?utf-8?B?L1VBdzlkOCtpbU54YmJqaVJwQVFhWWtNL29aM01udm5GcE5jODNXajE0NlhL?=
 =?utf-8?B?RFVNTHVlV0RqME1kVkZJM0tad2w2UC9JSWFBQjM3R3pkckpVUmVYdmhibWNG?=
 =?utf-8?B?ZW55bDlhQUhMekt6eGVuYzBhWHkyeUJxZlE0VGNMNGRmYXRRZjJ2YnpGRTZJ?=
 =?utf-8?B?U2Z2VmdlQWxmRWpOYmxzUzlkWFBVa2NRR2UrZkdkbVJxZ2NRYm5xUm0wcGJK?=
 =?utf-8?B?NE9IRGIxSzVGeVdGeE50OGNycXJZTWFESnNkTE4rMDRVc3ZncDl4QjBJcTZM?=
 =?utf-8?B?K2xsbEgwMDhLbjJFODZ4aXJzbjc1eEFJZGNhYVZBc2JSN3c1RDRkNkp4aVBV?=
 =?utf-8?B?M2FXSzZoWGRzWWkzLzI5ZlFwa2FMY3k0dTlacXdsd3lqRzNkdjQ2ZzhOdXIz?=
 =?utf-8?B?Q2pZUy9wQlBkb1l3N2o5SzQ5Qm9TN2ZlemFFQ3MyMGVTQkZpR1UyY3BLcjlV?=
 =?utf-8?B?b0FrZTJhWGpYSm9iR0VyVm5WUTJvbjRWUDZ2WDBxemF3OUtXUVJuK2VpRXRh?=
 =?utf-8?B?eWtGdUNHdkEralVmUDVSUFpuSkhoOG9GZnl5S0htVkdaazVrK2N3czBmVC9i?=
 =?utf-8?B?WllraEVHSWNKckgyT204Rkl4bHBzTzk1aVRuUlJjMnVLUk5RU3l2K3hvVkVE?=
 =?utf-8?B?bTlGUm5PMVVsU05RZHBOUGNFU1VWZmczdGsvU1l0UkFOTWpUbThnR0t6RDYx?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <761BECAE93B9B64997DC01EADAA5036C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QQ8g5oIPpGsDMCA0jgSlRPtnesaslu119HTs/5Q/3anotSEoLCKLV7zpfU7J11UoOWYkSW/SuYFqU8i9g6X09aZHqmiGVZmRK3JuR3U2+9Tpi/YE+xEpeybwgG1n8uBE0nObufWGMIyz/AZ1DmhBNlLqgw+9PL/7UdHtzwSqHbi2M1h6gHa21IcG+UIPf0IMyukylw05pFejOVwR7BnvRHzp+9uhWberGmFo3j0gfRE2T/f3wwZ6ugFPOPfIhb98nHTXMRbiSNKCg+myOn3NOwG6nf3+c27lKIgaG+q/kwsBmuidADywKdV1Br4GkcxAnmJ1G055fMPQh1ueqitdIh8M1y9g6rEI8sKpZmUJiac7U7PXjPmkySIIx32Fmftf6HDx/8GirLlpQBOMiw3MgEcIe5o+SGAzz/LC3LVxi0tFQzPIK0vfH7r8MdlAv7rYJe86UJ9F98zkacSStiBR+UzQ4EKg+X+v9I3UDpso6aUL/WYNRXf2nNXDc5ULtOntxgtIJ2qfIG/s4t5Fpe8BtMNGPTqbseIXe10ZQGFF3c42FLA5YvEKWZP3+DKJJGfeZ6rUBDsj06i21gNf6weBEvKnm4K0KDuSNwOftVCIsrm0B9XYRuHcVEO+bWoZtoqE
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70700a8-033f-4380-f73f-08dcf83f9f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 17:32:11.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gb2BfrqGR14EzsoXbQHsZLuun4M+nQ0984L7WwwEVj6sDfru4rGo1r/IyNtz0Ghx9TTYwbMYVjwMwkC5qZfqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9873
X-MDID: 1730223141-hVBzl2a7twsD
X-MDID-O:
 eu1;ams;1730223141;hVBzl2a7twsD;<gnaaman@drivenets.com>;0fb508fd2d7d252a5b49e2d561d41b8b
X-PPE-TRUSTED: V=1;DIR=OUT;

DQoNCj4gT24gMjkgT2N0IDIwMjQsIGF0IDE4OjAyLCBYaW4gTG9uZyA8bHVjaWVuLnhpbkBnbWFp
bC5jb20+IHdyb3RlOg0KPiANCj4gQ0FVVElPTjogRXh0ZXJuYWwgRS1NYWlsIC0gVXNlIGNhdXRp
b24gd2l0aCBsaW5rcyBhbmQgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiBNb24sIE9jdCAyOCwg
MjAyNCBhdCA0OjEw4oCvQU0gR2lsYWQgTmFhbWFuIDxnbmFhbWFuQGRyaXZlbmV0cy5jb20+IHdy
b3RlOg0KPj4gDQo+PiBBdm9pZCBtb2RpZnlpbmcgb3IgZW5xdWV1aW5nIG5ldyBldmVudHMgaWYg
aXQncyBwb3NzaWJsZSB0byB0ZWxsIHRoYXQgbm8NCj4+IG9uZSB3aWxsIGNvbnN1bWUgdGhlbS4N
Cj4+IA0KPj4gU2luY2UgZW5xdWV1ZWluZyByZXF1aXJlcyBzZWFyY2hpbmcgdGhlIGN1cnJlbnQg
cXVldWUgZm9yIG9wcG9zaXRlDQo+PiBldmVudHMgZm9yIHRoZSBzYW1lIGFkZHJlc3MsIGFkZGlu
ZyBhZGRyZXNzZXMgZW4tbWFzc2UgdHVybnMgdGhpcw0KPj4gaW5ldGFkZHJfZXZlbnQgaW50byBh
IGJvdHRsZS1uZWNrLCBhcyBpdCB3aWxsIGdldCBzbG93ZXIgYW5kIHNsb3dlcg0KPj4gd2l0aCBl
YWNoIGFkZHJlc3MgYWRkZWQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEdpbGFkIE5hYW1hbiA8
Z25hYW1hbkBkcml2ZW5ldHMuY29tPg0KPj4gLS0tDQo+PiBuZXQvc2N0cC9wcm90b2NvbC5jIHwg
MTQgKysrKysrKysrKysrKysNCj4+IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+
PiANCj4+IGRpZmYgLS1naXQgYS9uZXQvc2N0cC9wcm90b2NvbC5jIGIvbmV0L3NjdHAvcHJvdG9j
b2wuYw0KPj4gaW5kZXggMzljYTU0MDNkNGQ3Li4yZTU0ODk2MWI3NDAgMTAwNjQ0DQo+PiAtLS0g
YS9uZXQvc2N0cC9wcm90b2NvbC5jDQo+PiArKysgYi9uZXQvc2N0cC9wcm90b2NvbC5jDQo+PiBA
QCAtNzM4LDYgKzczOCwyMCBAQCB2b2lkIHNjdHBfYWRkcl93cV9tZ210KHN0cnVjdCBuZXQgKm5l
dCwgc3RydWN0IHNjdHBfc29ja2FkZHJfZW50cnkgKmFkZHIsIGludCBjbQ0KPj4gICAgICAgICAq
Lw0KPj4gDQo+PiAgICAgICAgc3Bpbl9sb2NrX2JoKCZuZXQtPnNjdHAuYWRkcl93cV9sb2NrKTsN
Cj4+ICsNCj4+ICsgICAgICAgLyogQXZvaWQgc2VhcmNoaW5nIHRoZSBxdWV1ZSBvciBtb2RpZnlp
bmcgaXQgaWYgdGhlcmUgYXJlIG5vIGNvbnN1bWVycywNCj4+ICsgICAgICAgICogYXMgaXQgY2Fu
IGxlYWQgdG8gcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gaWYgYWRkcmVzc2VzIGFyZSBtb2RpZmll
ZA0KPj4gKyAgICAgICAgKiBlbi1tYXNzZS4NCj4+ICsgICAgICAgICoNCj4+ICsgICAgICAgICog
SWYgdGhlIHF1ZXVlIGFscmVhZHkgY29udGFpbnMgc29tZSBldmVudHMsIHVwZGF0ZSBpdCBhbnl3
YXkgdG8gYXZvaWQNCj4+ICsgICAgICAgICogdWdseSByYWNlcyBiZXR3ZWVuIG5ldyBzZXNzaW9u
cyBhbmQgbmV3IGFkZHJlc3MgZXZlbnRzLg0KPj4gKyAgICAgICAgKi8NCj4+ICsgICAgICAgaWYg
KGxpc3RfZW1wdHkoJm5ldC0+c2N0cC5hdXRvX2FzY29uZl9zcGxpc3QpICYmDQo+PiArICAgICAg
ICAgICBsaXN0X2VtcHR5KCZuZXQtPnNjdHAuYWRkcl93YWl0cSkpIHsNCj4+ICsgICAgICAgICAg
ICAgICBzcGluX3VubG9ja19iaCgmbmV0LT5zY3RwLmFkZHJfd3FfbG9jayk7DQo+PiArICAgICAg
ICAgICAgICAgcmV0dXJuOw0KPiANCj4gV2hhdCBpZiBhZnRlciB0aGlzIGJ1dCBiZWZvcmUgdGhl
IGFkZHIgaXMgZGVsZXRlZCBmcm9tIGxvY2FsX2FkZHJfbGlzdCBpbg0KPiBzY3RwX2luZXRhZGRy
X2V2ZW50KCksIGEgbmV3IFNDVFAgYXNzb2NpYXRpb24gaXMgY3JlYXRlZCB3aXRoIHRoZXNlIGFk
ZHJzDQo+IGluIGxvY2FsX2FkZHJfbGlzdCwgd2lsbCBpdCBtaXNzIHRoaXMgYXNjb25mIGFkZHJf
ZGVsPw0KPiANCj4gVGhhbmtzLg0KDQpHcmVhdCBwb2ludC4NCg0KSSB0aGluayB0aGlzIGNhbiBi
ZSBzb2x2ZWQgYnkgbWFraW5nIHN1cmUgYGxpc3RfZGVsX3JjdSgmYWRkci0+bGlzdCk7YCBpcyBj
YWxsZWQNCmJlZm9yZSBgc2N0cF9hZGRyX3dxX21nbXRgLg0KDQpJ4oCZbGwgcmVzZW5kIHRoaXMg
YWZ0ZXIgSSBtYW5hZ2UgdG8gdW4tYm9yayBteSBnaXQtc2VuZC1lbWFpbCBjb25maWcuDQoNClRo
YW5rIHlvdSENCg0KPiANCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gICAgICAgIC8qIE9mZnNldHMg
ZXhpc3RpbmcgZXZlbnRzIGluIGFkZHJfd3EgKi8NCj4+ICAgICAgICBhZGRydyA9IHNjdHBfYWRk
cl93cV9sb29rdXAobmV0LCBhZGRyKTsNCj4+ICAgICAgICBpZiAoYWRkcncpIHsNCj4+IC0tDQo+
PiAyLjQ2LjANCj4+IA0KDQo=

