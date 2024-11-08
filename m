Return-Path: <linux-sctp+bounces-284-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884D9C22C4
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Nov 2024 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594EA1C23DBC
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Nov 2024 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA71198A17;
	Fri,  8 Nov 2024 17:17:01 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465B194141
	for <linux-sctp@vger.kernel.org>; Fri,  8 Nov 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086221; cv=none; b=gqc0kHf0N2cHidRIf+h7Wky5t3hA7ApC1OmbYg+waychxtRkWjI7uywMNhUBnC2dSVpmGRTi9tIXe8jywyjRHh4OVS8Wj3u2Fsb94d857UH+5HvGwg8jstXD5Wz2+oG7uRrDPKy8NmxWtZVwYy87RmEXjjEsANh8T8Jm/k7sImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086221; c=relaxed/simple;
	bh=3o/CgnvuqxB1cU56EknF1ysiJ7ooQ7MT5bXdMyiKBiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iCmHr7ulFZvbZQpdud8QRsSH6pLuJM0Zj5qbOGGYuPUjyMjV60EI964WL73bhT7JsT1pK3hcs6Do2MVih3V9mdPkQ7VLIeOPZAs/qc+z1irLQP2xevZqlTaYJoMtqnmoEGOqstbb3c/G3OMlu2CS9I4h/wgU3fyWk0xsFUXbaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-191-SiG0YL4AOpCoTeJ7l5iHpg-1; Fri, 08 Nov 2024 17:16:51 +0000
X-MC-Unique: SiG0YL4AOpCoTeJ7l5iHpg-1
X-Mimecast-MFC-AGG-ID: SiG0YL4AOpCoTeJ7l5iHpg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Nov
 2024 17:16:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 8 Nov 2024 17:16:50 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mikhail Ivanov' <ivanov.mikhail1@huawei-partners.com>,
	=?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, Matthieu Baerts
	<matttbe@kernel.org>, "linux-sctp@vger.kernel.org"
	<linux-sctp@vger.kernel.org>
CC: "gnoack@google.com" <gnoack@google.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "matthieu@buffet.re" <matthieu@buffet.re>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, "yusongping@huawei.com"
	<yusongping@huawei.com>, "artem.kuzin@huawei.com" <artem.kuzin@huawei.com>,
	"konstantin.meskhidze@huawei.com" <konstantin.meskhidze@huawei.com>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
Subject: RE: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Thread-Topic: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Thread-Index: AQHbK7ERAltPFf8wxU+8YQqG109nhrKtq6zw
Date: Fri, 8 Nov 2024 17:16:50 +0000
Message-ID: <ed94e1e51c4545a7b4be6a756dcdc44d@AcuMS.aculab.com>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
 <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
 <20241018.Kahdeik0aaCh@digikod.net>
 <62336067-18c2-3493-d0ec-6dd6a6d3a1b5@huawei-partners.com>
In-Reply-To: <62336067-18c2-3493-d0ec-6dd6a6d3a1b5@huawei-partners.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IbZXDvsoqpfEjzn5p3yd4Ii_aMmY9Vqn8wmrKJnwocg_1731086210
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTWlraGFpbCBJdmFub3YNCj4gU2VudDogMzEgT2N0b2JlciAyMDI0IDE2OjIyDQo+IA0K
PiBPbiAxMC8xOC8yMDI0IDk6MDggUE0sIE1pY2thw6tsIFNhbGHDvG4gd3JvdGU6DQo+ID4gT24g
VGh1LCBPY3QgMTcsIDIwMjQgYXQgMDI6NTk6NDhQTSArMDIwMCwgTWF0dGhpZXUgQmFlcnRzIHdy
b3RlOg0KPiA+PiBIaSBNaWtoYWlsIGFuZCBMYW5kbG9jayBtYWludGFpbmVycywNCj4gPj4NCj4g
Pj4gK2NjIE1QVENQIGxpc3QuDQo+ID4NCj4gPiBUaGFua3MsIHdlIHNob3VsZCBpbmNsdWRlIHRo
aXMgbGlzdCBpbiB0aGUgbmV4dCBzZXJpZXMuDQo+ID4NCj4gPj4NCj4gPj4gT24gMTcvMTAvMjAy
NCAxMzowNCwgTWlraGFpbCBJdmFub3Ygd3JvdGU6DQo+ID4+PiBEbyBub3QgY2hlY2sgVENQIGFj
Y2VzcyByaWdodCBpZiBzb2NrZXQgcHJvdG9jb2wgaXMgbm90IElQUFJPVE9fVENQLg0KPiA+Pj4g
TEFORExPQ0tfQUNDRVNTX05FVF9CSU5EX1RDUCBhbmQgTEFORExPQ0tfQUNDRVNTX05FVF9DT05O
RUNUX1RDUA0KPiA+Pj4gc2hvdWxkIG5vdCByZXN0cmljdCBiaW5kKDIpIGFuZCBjb25uZWN0KDIp
IGZvciBub24tVENQIHByb3RvY29scw0KPiA+Pj4gKFNDVFAsIE1QVENQLCBTTUMpLg0KDQpJIHN1
c3BlY3QgeW91IHNob3VsZCBjaGVjayBhbGwgSVAgcHJvdG9jb2xzLg0KQWZ0ZXIgYWxsIGlmIFRD
UCBpcyBiYW5uZWQgd2h5IHNob3VsZCBTQ1RQIGJlIGFsbG93ZWQ/DQpNYXliZSB5b3Ugc2hvdWxk
IGhhdmUgYSBkaWZmZXJlbnQgKHByb2JhYmx5IG1vcmUgc2V2ZXJlKSByZXN0cmljdGlvbiBvbiBT
Q1RQLg0KWW91J2QgYWxzbyBuZWVkIHRvIGxvb2sgYXQgdGhlIHNvY2tldCBvcHRpb25zIHVzZWQg
dG8gYWRkIGFkZGl0aW9uYWwNCmxvY2FsIGFuZCByZW1vdGUgSVAgYWRkcmVzc2VzIHRvIGEgY29u
bmVjdCBhdHRlbXB0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


