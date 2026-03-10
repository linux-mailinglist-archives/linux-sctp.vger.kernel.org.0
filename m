Return-Path: <linux-sctp+bounces-1063-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EMNA6c2sGkKhQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1063-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 16:20:07 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0D25332B
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BBD231D1D54
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC32FD1DA;
	Tue, 10 Mar 2026 14:45:45 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022090.outbound.protection.outlook.com [52.101.96.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581262E5B09;
	Tue, 10 Mar 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153944; cv=fail; b=uX9DUpxgWFknQA49k6b9M5zZqCnCCi9DxwgMsFRItTJeGDZbkVNopVAwgXgD34t6k+CFo9q+8Z0D5ElKaJAssrFPeSnyFOzLZZI8x7mGk5rSl383SezKxo42QGNEhouodeL6AoisJdMJnZ6Gxb8V6IYQhZp9GqQqo00ftYAHZ5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153944; c=relaxed/simple;
	bh=A9XlB1tUS0fux4kBO+UbAWsXGJ47ovKY4LzTVMEUK2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OjSp9MJKJqX/IihlcL4wrSS+bbKkc7k8sTvCKfiwrM6OHexqB1bjwgM5N6xMWmhJHFjs6a6dygC+KEVsGs7dsOthDRiTS60DxtpkpYFqf2oBeVwWcGda1CndsIfKHMblgE/Y7/909e4Wji8JCI7CElFr0niQOktVD7W9r22TQAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB3Xfg8fFKEFvKlN8/Fj9g4pkeaVtXn0kkDv06O/WSlvfRmYmXzgWxSHv/glXmpgWjTZmDQlgN6XQtexxgcXW1W3VL/TLBetRYLY+B0ZV+vUVrCE48T2TIf40hP5rOs6WTQ7mys9HRZ+1AY1OvWdkf82/IykWL/OF4A+EYy6VjDR2OHgY9tSg7ChErbiQ3cYlgp7LRs1+gUG8oz3MmZ8f87tinkxAlWUEiyIEYKB0ncf/zELL6vWI41RbzVzDg2PiDOv7VyMNBtlJHN7zzrYdtM2wpxx31mXGg7KPaEOEKyIvGxE9pmt0WWUaZE4NxXaxmjdGfClh+8Ek0cFT+UH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAqErPuH8jvSz3S3uW1/upneO2POe6vZLbo48MwocK4=;
 b=W7tN4kfmd1B4jfJhRrUU6g4HsnWTQgFcjxfu8uf5dskX9ZbOcsBt430GAQhCKU8RgliHekyDzVdtGLYNkozrOO6SD2vWf4qf8y8niwVpCVoOOGsGHOzd80vtscok3K+fUCblknwTOHpHEiaywOV7qny2C0CogV32hxhE8dxV7Tq4Wq/YUNb2j9iwjREaJEIkKWo7nfWO/XYQXuJneWwzmE7r626rMP84ru1sLQzsKq7frVNFpBeZl8i8bshHULXeIkAad5lsnmOQcGAdgsVX9wqpjlsdXovsGplhJS5y8yvgeyXsiFIw0qc/e9C8Bq3IiywnSpp6TSnFye1QIK6rYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB4117.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 14:45:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 14:45:39 +0000
Date: Tue, 10 Mar 2026 10:45:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev, 
	intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 17/61] module: Prefer IS_ERR_OR_NULL over manual NULL
 check
Message-ID: <qtwmj2mcbokwa7gexs5oqasjuitoaajiawc4d6dwcc224lmvbo@syjg6j6jggwy>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iksijtbqwcym3dge"
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-17-bd63b656022d@avm.de>
X-ClientProxiedBy: BN0PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:408:ed::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b40275-3529-4e12-fb2e-08de7eb3b274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	eS8vfNxIlcveoUfBbC1f0b/7XDyt042g0NrOSeRHjPQz8SGF8XhnduWnhSq6w/jRCubBJWCQ0em9JSqFUpfcMToM52skjTdNeFfaYr/iVSsKAWiaW3DO/bcnqdcpaQuiI02eS0+aO+CkNT1YH1QQ6E7Q57u6/qaWaQ20N+1FIBcJZS1mBzIioruuLmthEo0gpbRvPUw85MZ4BuTbyxgwfUdq297KnZNKBcxR51k+1QwxfVuZq9j/tn2i89QI1rer6MizYsOjruF/dbbHjCey+BSjf4ODjERjtTz7wyRciY2SWDagpg72iLn9KVmzZVKExW68zMr/l9NtJWoTedOYUByiSKXbyY/3JV9xRnX1MzB9BgBZzT1xIV+5HlUy2YjMHl/3dJLaD2oBPxNWLURA8Z08rKBhZiJO2xeSiCI4mtWcnPeq3oEWmmY/WeHCI/B3o7JWziYbmH0QC8uqLAo/mQeRtn2TDgHIlkcKjGfALzMiD8xYPzjGT5P2vIR5K1BknKS+wJWav08f2MBfPRpwDPe50D0F6uw8UO3X9XH+2FvKXluY6iP9bBIpwnIhpFLltJGAWJ97kBcunctHO08msp59QGCLa7B9KyIGa5ySuwKbRsiH6EO7wMRDJH8WU49ueWwW1LGly9m6jhK5/yiuwnls2+tKU53my80py9Z/IAQ4MsIkAQLyj3EYcQb0F1EbNzlO4n0fZQx8QozYXcKQrvPpY9dpMBAU9AUK3jolnXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjlvdnlwWk1CSFZIUGxWVloyKzB5bUNjN2lRU1ZhM1hLSHQ0V2Flc3Iwd0VL?=
 =?utf-8?B?bXArd0JIN2tZVzZLUGpqcHBUbWNFZzAwc2o1TmRuYkFRMnBERWo0OVk4L2JH?=
 =?utf-8?B?M01qcWhaNDU3SDMxYnZDcThyUkNHMjYrZ0dtR1F3V0ZIVTVrUnRKN1dOOHR2?=
 =?utf-8?B?RHpPcTI5V3R6azVuanpHZmg3U3dOd3lZRk94MUpZd2N2UFZnMitFcXdwbGtM?=
 =?utf-8?B?MVBDd0xUODEzK21Ma2FQSnZNQVNYMnNGU2xJbmhqOHdmb3RhYm82alo0MVlQ?=
 =?utf-8?B?VzEweHRPTGZxV25GM0ZwQ1BUcytpRGJIY3hVVk5KR0ZBbzhrUHd0YnJVMjdy?=
 =?utf-8?B?T3JWUFFPdzZJVitQVWE1b0RnRkNLbHlmVCtkS295eVFOa1FyMTB4aVFPTzli?=
 =?utf-8?B?V2hUMW52U2ZGa0N6TTF4UWZqejVMc0RPa05rbHluMUFBUVJQRTJZRGM3clEr?=
 =?utf-8?B?Vmc2aGVzb01QenlhdGlYc0NLMWY5WUVJQ1JIUHFYcWs1a1pEN2JORDVjTlFN?=
 =?utf-8?B?YjRTRUkwcitrUHM4blJac05MdDY3VXJTSStuZUhpcDZsV1EvazZkMGRYME1q?=
 =?utf-8?B?ZFI3eWtGN3NEc0RCcGNhQTErRXB2cjRXWnRzbVpTcWtISDh4Y213SVhnMU01?=
 =?utf-8?B?QjlCaTltWWgwUFFmb3VuaGQ3dDVKMkVwdVphRTNMR1hvVDkrbXBSMFNMUlVa?=
 =?utf-8?B?M0JHVmRmaHdxcFg5QlgxaXNtckQ2SGIzRWJzYnZuTzViVWsxQlZHQmlDNExl?=
 =?utf-8?B?Z1ptTVlDVVE2ZWQwMGdDZEk5Y0Q3NnFyWVltd0N0cDRUa2lXZ2h1R09tTGNT?=
 =?utf-8?B?T0owTUk0UFc2SkljekM3QlZsVzJiWVBpVkZtaHFMK0FBOEg2aEovOGd6RnBW?=
 =?utf-8?B?LzNsZkJmUU92bC9XUU5jZ05SbWNXZ3B5VXRzRVUzTm4vQWtVWFFqRnRYekY3?=
 =?utf-8?B?L2E4TXpUV1ZCZGxZbitRS1RPYlBZVU9Yb0NDQUNEQnMvcTllUGltK1MyN2tZ?=
 =?utf-8?B?WXNuc2hBelVVbVNtWUtYSi9SYzhWa095dy9RS1F6bHdibjNQYUpITTlhVTNo?=
 =?utf-8?B?SFhldlpnYjYza082ZmFKRjZKd0h4LzJkTXRpclQxazNrQm9zTG5ReEQ0anhT?=
 =?utf-8?B?S2s2L3ZiYUZzZU8rMHFEQkczZElUeW5KcEFRWnFHMVV1RXNsTzUvR1hNaG1Z?=
 =?utf-8?B?T052eUI1MlpyTUNiWkNHbFI2dFBOQ29rNS9hcjltTStCVVUveDZTNHFtVXlK?=
 =?utf-8?B?Smc3cmFlakdnVmtTak8zOHo4VHhzT0x6WmEwK29HckR1b1VPNUtiYlQ2SHIy?=
 =?utf-8?B?a2VCRGJzM0IrZUJnSlVVNSs2Z1ozTWdJTEc2TWg0dklnenRxbHBVNkRiS2Q1?=
 =?utf-8?B?VWdRbWlCTVRVZDZtQ0txNW1pYzVLVVd2L21mSElOMUhvUk90VWNYR3JFNUFy?=
 =?utf-8?B?VkdFOTRTUTlrN2c3T3dpMUhhWVJOYnNZR3UydnU1UEpUMlAwdTczT1FyS2NI?=
 =?utf-8?B?NUVlYVJ5R3R2K2tyYSt0RGdaVlZDSUJjVmNlYS8zZm1PWDQ4K3ZOT1BrQ1Ay?=
 =?utf-8?B?MHRNaUswa2thTDR3cGZuN1R4ZzBUVHI0ZkdpM2F0N0dGWHJ6bGt6T3hyU2NH?=
 =?utf-8?B?U1hJWHdweVpZcXU0RmRkejFLQXo4OGRNa0NiNmwwMzlFbGk4UklOaWtLSkRF?=
 =?utf-8?B?UkpkRklXeHFRUzNxRFcrWWtGRXVuYXR3ZFloTkR5YUtSeWUzUjJhMGF0UktE?=
 =?utf-8?B?RytHVTR5ODNjL2dpQjNMUkxMRm1QZmluWVJCWkt5VTZ3VW5vSXE0MitqU1k4?=
 =?utf-8?B?aGJxc2hOZEsxdnJXMVg4N0lYZE0yalpJS3hYR25lQUw4VlBUWVpkWExhRGND?=
 =?utf-8?B?UE5BQlkrajhVRWk1REJvWTBoeXdIRnJyQVl5ZDlTeEwyWWJrWEhGR2cvTG9N?=
 =?utf-8?B?UktDRDM3dXhLWGlLL3pCcWp4UVNrSEN5clNLYmNLUFp4NjlxTldpUWppRXVi?=
 =?utf-8?B?bERrcGUwdmR1K1AzUEVOdzYwaUgraVBkRUtUdEVIeEYweVQ3WnpKcHFsUjhp?=
 =?utf-8?B?ck9wYlVlS1FGNUtINUxaMzZSUTdBZkhkdHEzOC9jNUg4WWRHUTEzZ1VEc1hn?=
 =?utf-8?B?R0JxTFNOZ3VMMldjamx0Wll2MnJ1M2dzSjVNTlVUSnV4ZXh2b3prY0d4bzVK?=
 =?utf-8?B?alRna2ROMW0zdzVCZWxoQXpqSXplVUpINE9jbFdpOTRMT2l6bDBFWGxpTVBD?=
 =?utf-8?B?NkVGRWlFYXVZdEI2SEZsdmJpa253N0NYMlNVeVd4UmZVVlJLUWIyUk5BaFdn?=
 =?utf-8?B?elM3bSs1cmluUGdxWTRDdEVRU1JVNm1PR0llU1djMEZsdGdRb0hWUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b40275-3529-4e12-fb2e-08de7eb3b274
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:45:39.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwFautavIbFqmN5YwHCFfTVUxc9gxa3cpwndmicLa0FlANQgRiCX3WWVzDmT9lbq0RC4/eZ8BgFQOpVQW1fLOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4117
X-Rspamd-Queue-Id: A7E0D25332B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[atomlin.com];
	TAGGED_FROM(0.00)[bounces-1063-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,atomlin.com:email]
X-Rspamd-Action: no action

--iksijtbqwcym3dge
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 17/61] module: Prefer IS_ERR_OR_NULL over manual NULL
 check
MIME-Version: 1.0

On Tue, Mar 10, 2026 at 12:48:43PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Luis Chamberlain <mcgrof@kernel.org>
> To: Petr Pavlu <petr.pavlu@suse.com>
> To: Daniel Gomez <da.gomez@kernel.org>
> To: Sami Tolvanen <samitolvanen@google.com>
> To: Aaron Tomlin <atomlin@atomlin.com>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  kernel/module/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c3ce106c70af165e2dc1a3c79f5a074a5c3e3d34..7f62f0620dcd75960e431f7af=
3d1cadf4cc41e4b 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1551,7 +1551,7 @@ static int simplify_symbols(struct module *mod, con=
st struct load_info *info)
>  		case SHN_UNDEF:
>  			ksym =3D resolve_symbol_wait(mod, info, name);
>  			/* Ok if resolved.  */
> -			if (ksym && !IS_ERR(ksym)) {
> +			if (!IS_ERR_OR_NULL(ksym)) {
>  				sym[i].st_value =3D kernel_symbol_value(ksym);
>  				break;
>  			}
>=20
> --=20
> 2.43.0
>=20

Hi Philipp,

Thank you.

Have you considered other users of IS_ERR() in kernel/module/main.c too?

Perhaps it might be best to prepare a clean up for each applicable
subsystem in isolation.


Kind regards,
--=20
Aaron Tomlin

--iksijtbqwcym3dge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmmwLosACgkQ4t6WWBnM
d9aU9xAAqqgNT5SoU+VYtTZ80wOUwEE2OMdLBYzCI0mjnqJPXnb4U+JQX0SteStv
Wd+zDAGE5Me5p/CfEt/+aiyKOuiZL7yQucXzvUMGKxqLMQFwqPvA3WtSoTVFL+rF
LkaH0u5Q5L3fR1LqaiKYIZuzVEvau4J1yxwpr3TSOVVjsiNOir78WKYMWkbywt9w
2ZGJmWlqCHaicR+MbDxwYxmj6A8vWK4lMNrf9/bSNlRcevwMRBi5MEVCXNAmi8/K
HL+Lff4iFQayNqX+KHvqO+d71PuZJ6uRoZtmn2TOsqPFvRhSEwOCORUQRwprUwHK
1AXthzlvxw54scM7jH/H7EVz4b/StJaeHqfZLJ4y6QJv7HWYccOTXqVPj5yDF4AS
LNEe/UEO2rZOSVwqm8USG03ipXDhoZ7is3ump24r9vmbuJ4Ut/UkZnPPM2f1V8YS
AiWpOQ5tGWd+85RvZUyJfbagqS9XcCxV1Ec+y4MXwaab2ddu81t86xc5nbRANS/k
juKrG81J7nYvlpvQajkCU6tK/ZZsalYBs/BCg2IAYhG1V5SqGHR6o/a3KjVtmdwP
5t9pTp1q1bD8/UPf4bSgjULpyVSusQkcdm6aoNJD80Jqi8vPQSuZUDFw9gdbbWdT
6f5kQv0sOH33oz8IDL0pTNDmWbOF3HKDQCX5nbTnNtfG048XNxo=
=x/q5
-----END PGP SIGNATURE-----

--iksijtbqwcym3dge--

