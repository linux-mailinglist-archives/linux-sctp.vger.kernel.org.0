Return-Path: <linux-sctp+bounces-23-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FB8505DD
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 19:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD59286005
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A45D477;
	Sat, 10 Feb 2024 18:03:02 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440C5D46F
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707588182; cv=none; b=bsUny1Wq7H0UI8LtdxSBbggbVMa/8qPLV4QaGF7eP6XzX3x8uoSOmTLo5S0JHAaGVW4MU6YpOvzu+nx6Rf3XUiPFZiphyJ2rbPFWuLvH4tiIOkUrlxKW5GQKD4qOt+z1zpYHReYQ8APoD0lskfqW8tr8vn/QPoEFmMyy/T0HHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707588182; c=relaxed/simple;
	bh=+hdhWUGd72DmZCOzYDxZjz+KmsZCDHtIlUSXSTPKq10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MK7MFBLYzS8PXMxJhyC1YoBVzBxuL53cEykkf2GP2qK/Xm3nx8WDb6qdy+QxHHl3tMpaPfInnY9QgdotA53RY+vTqZNbdYsfTlsRINOB83+rc+TFXdXYAYgyzLU5bt6HW61YKumz4OvnOWjwwpVuLE7bOq9+W2K7mltR+//eZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-85-0tKoHfM4NoiaDBvJu1gHfQ-1; Sat, 10 Feb 2024 18:02:56 +0000
X-MC-Unique: 0tKoHfM4NoiaDBvJu1gHfQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 18:02:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 18:02:35 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Philipp Stanner' <stanner@posteo.de>, "'o.evistel@free.fr'"
	<o.evistel@free.fr>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: linux-sctp <linux-sctp@vger.kernel.org>, 'Andreas Fink'
	<afink@list.fink.org>
Subject: RE: Linux SCTP multihoming question
Thread-Topic: Linux SCTP multihoming question
Thread-Index: AdpcQw7o42LnVkYaSYSLKU43k+X0CAAAM4EAAAChmdAAAMAoAAAAF91Q
Date: Sat, 10 Feb 2024 18:02:35 +0000
Message-ID: <ddc189ebea24410c9387bff2de543f34@AcuMS.aculab.com>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
	 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
	 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
	 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
	 <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
	 <365e312e60de89031d2c816e502f18b4d74b98c7.camel@posteo.de>
	 <557a01dfcfd440e6b1b1b1762839d033@AcuMS.aculab.com>
 <04c483f34daaebb95d8de56e8e6a49a473c04fe4.camel@posteo.de>
In-Reply-To: <04c483f34daaebb95d8de56e8e6a49a473c04fe4.camel@posteo.de>
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
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogUGhpbGlwcCBTdGFubmVyDQo+IFNlbnQ6IDEwIEZlYnJ1YXJ5IDIwMjQgMTc6NDkNCi4u
Lg0KPiA+IEJ1dCB3b24ndCB0aGF0IGRlZmVhdCB0aGUgZW50aXJlIHBvaW50IG9mIFNDVFAgbXVs
dGlob21pbmc/DQo+IA0KPiBJIGd1ZXNzIGl0IGRlZmVhdHMgdGhlIHBoaWxvc29waHkgb2YgdGhl
IE9TIHdpdGggaXRzIHJvdXRpbmcgdGFibGUNCj4gYmVpbmcgc29sZWx5IHJlc3BvbnNpYmxlIGZv
ciBjaG9vc2luZyBhIHNvdXJjZSBhZGRyZXNzLg0KPiBJIGRvbid0IHNlZSBob3cgU0NUUCB3b3Vs
ZCBiZSBhZmZlY3RlZCBieSB0aGF0LCB0aG91Z2guIFNDVFAgZG9lc24ndA0KPiBkZW1hbmQgYSBj
ZXJ0YWluIG51bWJlciBvZiBpbnRlcmZhY2VzIGJlaW5nIGF2YWlsYWJsZSwgbm9yIGRvZXMgaXQg
bWFrZQ0KPiBzdGF0ZW1lbnRzIGFib3V0IGhvdyB0aGUgbmV0d29ya3MgYmVoaW5kIHRoZSBpbnRl
cmZhY2VzIG1pZ2h0IG9yIG1pZ2h0DQo+IG5vdCBiZSBpbnRlcmNvbm5lY3RlZC4NCg0KWW91IG5l
ZWQgdG8gbG9vayBhdCB3aHkgaXQgZXhpc3RzLCBhbmQgd2hhdCBpdCB3YXMgdHJ5aW5nIHRvIHJl
cGxpY2F0ZS4NClNDVFAgaXMgYWxsIGFib3V0IGNhcnJ5aW5nIHRlbGVwaG9ueSBzaWduYWxsaW5n
IG92ZXIgdGhlIElQIG5ldHdvcmsuDQpTbyBpdCBpcyB0cnlpbmcgKGFuZCBmYWlsaW5nIGZvciBh
bGwgc29ydHMgb2YgcmVhc29ucykgdG8gZ2l2ZQ0KdGhlIHNhbWUgc29ydCBvZiBlcnJvciBkZXRl
Y3Rpb24gYW5kIHJlZHVuZGFuY3kgYXMgU1M3IE1UUDIgYW5kIE1UUDMuDQoNClRoZSBub3JtYWwg
bGV2ZWwgb2YgcmVkdW5kYW5jeSBpcyB0byBoYXZlIHR3byBzZXBhcmF0ZSBNVFAyIGxpbmtzDQoo
YSBsaW5rc2V0KSB0byBlYWNoIG9mIHR3byBkaWZmZXJlbnQgcmVtb3RlIE1UUDMgc3lzdGVtcy4N
CklmIHlvdSBhcmUgZG9pbmcgaXQgcmlnaHQgZWFjaCBNVFAyIGxpbmsgaXMgb24gYSBzZXBhcmF0
ZSBwaHlzaWNhbCBjYWJsZS4NClRoZSBTQ1RQIGNvbm5lY3Rpb24gaXMgdHJ5aW5nIHRvIHJlcGxp
Y2F0ZSB0aGUgbGlua3NldCB0byBhIHJlbW90ZQ0Kc3lzdGVtIC0gc28geW91IG5lZWQgdHdvIGxv
Y2FsIGludGVyZmFjZXMgY29ubmVjdGVkIHRvIHR3byByZW1vdGUgb25lcy4NCllvdSBjYW4gaGF2
ZSBtb3JlLCBidXQgaXQgaXMgYmFzaWNhbGx5IHBvaW50bGVzcy4NCg0KPiA+IFlvdSBuZWVkIHR3
byBpbnRlcmZhY2VzIGluIGRpZmZlcmVudCBzdWJuZXRzIHRoYXQgdXNlIGVudGlyZWx5DQo+ID4g
c2VwYXJhdGUgSVAgbmV0d29ya3MgdG8gY29ubmVjdCB0byB0aGUgdHdvIGFkZHJlc3NlcyB0aGUg
cmVtb3RlDQo+ID4gc3lzdGVtIGdpdmVzIHlvdS4NCj4gPiAoVGhlcmUgYXJlIHJlYWxseSBvbmx5
IGV2ZXIgdHdvIGFkZHJlc3NlcyBmb3IgZWFjaCBzeXN0ZW0uKQ0KPiANCj4gSSBhc3N1bWUgeW91
J3JlIGNvbWluZyBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiBhIHVzZXIgd2hlcmUgU0NUUCBpcw0K
PiB1dGlsaXplZCB3aXRoIGNvbXBsZXRlbHkgcmVkdW5kYW50IGFuZCBzZXBhcmF0ZWQgbmV0d29y
a3MgZm9yDQo+IHJlZHVuZGFuY3kuDQoNClRoYXQgaXMgd2hhdCBpdCBpcyBkZXNpZ25lZCBmb3Iu
DQoNCj4gSSwgaG93ZXZlciwgaGF2ZSBvbmx5IHVzZWQgdGhlIHByb3RvY29sIGluIHRoZSBub3Jt
YWwgYm9yaW5nIEludGVybmV0IOKAkw0KPiBhbmQgdGhlcmUgaXQncyBkZWZpbml0ZWx5IHBvc3Np
YmxlIHRvIHJlYWNoIE4gZW5kcG9pbnRzIGZyb20ganVzdCAxDQo+IG91dGdvaW5nIGludGVyZmFj
ZS4gQWxsIHRoZSBlbmRwb2ludHMgYXJlIGNvbm5lY3RlZCB0byB0aGUgSW50ZXJuZXQsDQo+IGFm
dGVyIGFsbCwgc28gdGhlIHJvdXRlcnMgd2lsbCB1bHRpbWF0ZWx5IGRpcmVjdCB5b3VyIHBhY2th
Z2VzIHRvIHRoZQ0KPiB0YXJnZXQgYWRkci4NCg0KSSBob3BlIHlvdSBhcmVuJ3QgcnVubmluZyBh
bnkgb2YgdGhlIFNJR1RSQU0gcHJvdG9jb2xzLi4uDQoNCj4gPiBJIGRvbid0IGtub3cgd2hhdCB0
aGUgc3RhbmRhcmRzIHBlb3BsZSB3ZXJlIHNtb2tpbmcsIGJ1dCB0aGUNCj4gPiBkZWZhdWx0ICdz
ZW5kIGFsbCBteSBJUCBhZGRyZXNzZXMgdG8gdGhlIGZhciBlbmQnIGlzIHNvIGJyb2tlbi4NCj4g
DQo+IEhvdyBlbHNlIGNvdWxkIHlvdSBpbXBsZW1lbnQgaXQ/DQo+IE9ubHkgYWx0ZXJuYXRpdmUg
SSBjYW4gdGhpbmsgb2Ygd291bGQgYmUgdG8gaGF2ZSBzb21lIHNvcnQgb2YgbXVsdGktDQo+IGhv
bWluZyBETlMgdGhhdCBwcm92aWRlcyB5b3Ugd2l0aCBzZXZlcmFsIGFkZHJlc3Nlcy4NCg0KR2l2
ZW4gdGhlIHNlY3VyaXR5IGluIGFsbCB0aGUgU0lHVFJBTiBwcm90b2NvbHMgeW91IGFsd2F5cyB1
c2VkDQpmaXhlZCBJUCBhZGRyZXNzZXMgYW5kIChpbiByZWFsaXR5KSBiZXR0ZXIgYmUgdXNpbmcg
VlBOIHR1bm5lbHMNCmlmIHlvdSBnbyBhbnl3aGVyZSBuZWFyIHRoZSBwdWJsaWMgSVAgbmV0d29y
ay4NCg0KWW91IG5lZWQgc29tZSBwcm9wZXJ0eSB0aGF0IGNhbiBiZSBhc3NpZ25lZCB0byB0aGUg
bG9jYWwgSVAgLyBpbnRlcmZhY2UNCnRvIGluZGljYXRlIHdoaWNoIG9uZXMgY2FuIGJlIGdyb3Vw
ZWQgdG9nZXRoZXIuDQpUaGlzIGlzIGFscmVhZHkgZG9uZSB0byBleGNsdWRlIGxvY2FsaG9zdC4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==


