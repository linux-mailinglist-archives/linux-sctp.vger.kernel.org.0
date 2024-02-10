Return-Path: <linux-sctp+bounces-21-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD18505BE
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 18:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037FF1F21F1B
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500385CDFE;
	Sat, 10 Feb 2024 17:34:31 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757529CEF
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707586471; cv=none; b=DjnNSP/LXpIHxHy957V9+Dl7X9hzhxahru8qCjaomKK4UyN4FUOJAd9A4gULUeuzodIAqMm2jROHs2odRc0PlCm4F+Lyw/N8O95phPnt+SraHyRckJunKcXbgU4JzsA0hjd/aU1B3Xp4/Yo8FiUuVCRCuG/bUBE458lMPd3vt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707586471; c=relaxed/simple;
	bh=YBvVxu26d7rQ7qAna9MZme5H5/JXUevYgItXgjqc2OQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Oq8WQLwrPMDo7r3u03h/NVcYAaTyJ5S5fi+tZbkCTymx+91BBjnfhXaIIbqNVFP1VVyd42aTmv/R1QylaLWZVtL8U3qTuRihXzbaCRc9jp0qO7UR3kfKd7g+T0i2iCTzB8fcoVT81fdzTQkkyXgwCL/++pN3PaicUPFg4fmHSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-105-jE_1N7CFOLubscGV3iP0ng-1; Sat, 10 Feb 2024 17:34:25 +0000
X-MC-Unique: jE_1N7CFOLubscGV3iP0ng-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 17:34:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 17:34:04 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Philipp Stanner' <stanner@posteo.de>, "'o.evistel@free.fr'"
	<o.evistel@free.fr>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: linux-sctp <linux-sctp@vger.kernel.org>, 'Andreas Fink'
	<afink@list.fink.org>
Subject: RE: Linux SCTP multihoming question
Thread-Topic: Linux SCTP multihoming question
Thread-Index: AdpcQw7o42LnVkYaSYSLKU43k+X0CAAAM4EAAAChmdA=
Date: Sat, 10 Feb 2024 17:34:04 +0000
Message-ID: <557a01dfcfd440e6b1b1b1762839d033@AcuMS.aculab.com>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
	 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
	 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
	 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
	 <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
 <365e312e60de89031d2c816e502f18b4d74b98c7.camel@posteo.de>
In-Reply-To: <365e312e60de89031d2c816e502f18b4d74b98c7.camel@posteo.de>
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

RnJvbTogUGhpbGlwcCBTdGFubmVyDQo+IFNlbnQ6IDEwIEZlYnJ1YXJ5IDIwMjQgMTc6MDkNCj4g
DQo+IEFtIFNhbXN0YWcsIGRlbSAxMC4wMi4yMDI0IHVtIDE3OjAzICswMDAwIHNjaHJpZWIgRGF2
aWQgTGFpZ2h0Og0KPiA+IEZyb206IG8uZXZpc3RlbEBmcmVlLmZyDQo+ID4gPiBTZW50OiAwOSBG
ZWJydWFyeSAyMDI0IDEwOjA2DQo+ID4gPg0KPiA+ID4gSSBhbSB1c2luZyBsaW51eC1zY3RwIGFz
IHRyYW5zcG9ydCBmb3IgU0lHVFJBTiBNM1VBIG9uIFJIRUwgOC40DQo+ID4gPiB3aXRoDQo+ID4g
PiBtdWx0aWhvbWluZyAoc2N0cF9iaW5keCgpLCBzY3RwX2Nvbm5lY3R4KCkgQVBJIGZ1bmN0aW9u
cykuDQo+ID4gPiBJIHdvdWxkIGxpa2UgdG8ga25vdywgYWZ0ZXIgYXNzb2NpYXRpb24gc2V0dXAs
IGlmIGl0IGlzIHBvc3NpYmxlIHRvDQo+ID4gPiBpbnN0cnVjdCBTQ1RQIHRvIHVzZSBhIHNwZWNp
ZmljIGxvY2FsIGFkZHJlc3MgZnJvbSB0aGUgbGlzdCBvZg0KPiA+ID4gYm91bmQNCj4gPiA+IGFk
ZHJlc3NlcyB0byByZWFjaCB0aGUgcGVlci4NCj4gPg0KPiA+IFVubGlrZWx5IGluIHRoZSBleHRy
ZW1lLg0KPiA+DQo+ID4gSWYgdGhlcmUgYXJlICduJyBib3VuZCBsb2NhbCBhZGRyZXNzZXMgYW5k
ICdtJyByZW1vdGUgYWRkcmVzc2VzDQo+ID4gKElJUkMgZnJvbSB0aGUgSU5JVF9BQ0sgLSBidXQg
dGhleSBjb21lIGZyb20gdGhlIGZhciBlbmQpIHRoZW4NCj4gPiBMaW51eCBvbmx5IHZlcmlmaWVz
IGEgcm91dGUgdG8gZWFjaCBsb2NhbCBhZGRyZXNzIGFuZCBwaWNrcyBhbg0KPiA+IGFwcHJvcHJp
YXRlIGxvY2FsIGFkZHJlc3MgZm9yIGVhY2ggb25lLg0KPiA+IFNvIGl0IG9ubHkgc2VuZHMgaGVh
cnRiZWF0cyB0byAnbScgYWRkcmVzc2VzLCBub3Qgb24gJ24gKiBtJw0KPiA+IGFkZHJlc3MgcGFp
cnMuDQo+ID4NCj4gPiBTbyBpZiBhbnl0aGluZyBvZiB0aGlzIG5hdHVyZSBkaWQgZXhpc3QgaXQg
d291bGQgbGltaXQgdGhlDQo+ID4gcmVtb3RlIGFkZHJlc3NlcyB1c2VkLCBub3QgdGhlIGxvY2Fs
IG9uZXMuDQo+IA0KPiBJJ3ZlIGJlZW4gdG9sZCBvbmNlIHRoYXQgdXNpbmcgdGhlIHNvY2tldCBv
cHRpb24gU09fQklORFRPREVWSUNFIHNob3VsZA0KPiBzZXJ2ZSB0aGUgdHJpY2ssIGkuZS4sIGl0
IHNob3VsZCBwcm92b2tlIExpbnV4IGludG8gY2hvb3NpbmcgdGhlIHBpY2tlZA0KPiBkZXZpY2Un
cyBJUCBhZGRyIGFzIHRoZSBzb3VyY2UgSVAgYWRkci4NCj4gDQo+IEkndmUgbmV2ZXIgdGVzdGVk
IC8gdmVyaWZpZWQgdGhhdCwgdGhvdWdoLg0KPiBJJ20gYWxzbyBub3Qgc3VyZSBpZiBpdCB3b3Vs
ZCBoYXZlIG90aGVyIG5lZ2F0aXZlIGNvbnNlcXVlbmNlcywgc3VjaCBhcw0KPiBsaW1pdGluZyB0
aGUgcmVhY2hhYmlsaXR5IHRocm91Z2ggbm9uLWJvdW5kIGRldmljZXMuDQoNCkJ1dCB3b24ndCB0
aGF0IGRlZmVhdCB0aGUgZW50aXJlIHBvaW50IG9mIFNDVFAgbXVsdGlob21pbmc/DQpZb3UgbmVl
ZCB0d28gaW50ZXJmYWNlcyBpbiBkaWZmZXJlbnQgc3VibmV0cyB0aGF0IHVzZSBlbnRpcmVseQ0K
c2VwYXJhdGUgSVAgbmV0d29ya3MgdG8gY29ubmVjdCB0byB0aGUgdHdvIGFkZHJlc3NlcyB0aGUg
cmVtb3RlDQpzeXN0ZW0gZ2l2ZXMgeW91Lg0KKFRoZXJlIGFyZSByZWFsbHkgb25seSBldmVyIHR3
byBhZGRyZXNzZXMgZm9yIGVhY2ggc3lzdGVtLikNCg0KSSBkb24ndCBrbm93IHdoYXQgdGhlIHN0
YW5kYXJkcyBwZW9wbGUgd2VyZSBzbW9raW5nLCBidXQgdGhlDQpkZWZhdWx0ICdzZW5kIGFsbCBt
eSBJUCBhZGRyZXNzZXMgdG8gdGhlIGZhciBlbmQnIGlzIHNvIGJyb2tlbi4NClJlcXVpcmluZyB0
aGUgYXBwbGljYXRpb24gdG8ga25vdyB3aGljaCBhZGRyZXNzZXMgYXJlICdsb2NhbCcNCih0eXBp
Y2FsbHkgMTkyLjE3OC54LnggYW5kIDEwLngueC54KSBhbmQgcHJldHR5IG11Y2ggbXVzdCBuZXZl
cg0KYmUgc2VudCB0byBhIHJlbW90ZSBzeXN0ZW0gKHdoZXJlIHRoZXkgY2FuIGVhc2lseSBtZWFu
IHNvbWV0aGluZw0KZWxzZSkgaXMganVzdCB3cm9uZywgaXQgb3VnaHQgdG8gYmUgYSBwcm9wZXJ0
eSBvZiB0aGUgcHJvdG9jb2wgc3RhY2suDQoNCk5ldmVyIG1pbmQgdGhhdCB0aGUgZmFjdCB0aGF0
IEFQSSBjYWxscyBsaWtlIGJpbmR4KCkgd2VyZSBvcmlnaW5hbGx5DQppbXBsZW1lbnRlZCB1c2lu
ZyBzb2NrZXQgb3B0aW9ucyBiZWluZyBlbWJlZGRlZCBpbiB0aGUgc3RhbmRhcmQuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=


