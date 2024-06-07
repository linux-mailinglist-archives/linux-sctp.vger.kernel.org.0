Return-Path: <linux-sctp+bounces-171-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2188FFE22
	for <lists+linux-sctp@lfdr.de>; Fri,  7 Jun 2024 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800A92823AE
	for <lists+linux-sctp@lfdr.de>; Fri,  7 Jun 2024 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E215443A;
	Fri,  7 Jun 2024 08:37:09 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ADE15B0FD
	for <linux-sctp@vger.kernel.org>; Fri,  7 Jun 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749429; cv=none; b=Hc6U3A52ABpiGNEK+htvGt7j1Jit1nxlYax+iA4lTWyT3SiVp8EsJSKla25t01mzPD8CuvqoeWC5cBOqlR07NDcRJkh2ULjK1G8wig+3vQJbwCB+bqY1ckUBgSzs10t1/rA/PpBVaDSiscKs9iXVwJAY66d9qYBqYYhjE8Bo1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749429; c=relaxed/simple;
	bh=CkKHSB/kpNeMmANPZeGUmTTs9lDJ7BraXRPWV0SFfng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BO9AQhr9HRUH0yJzjUxX5kgte6j88R6BCC0DyzsTrymcAgz2MsGlmFtV5Dvrw1Ir5bHGHAzVGRxLO92IX6HR7oMLJOXSaQ1BIwpaVWAp3v3Ygqm+oz9zuXO39XMljI0HT4ZVM5GM0TXuRDenaq0WXe9D9Eund3/0CbhWSCwJjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-aAGw2SK1NwG3-1KqFJvVKg-1; Fri, 07 Jun 2024 09:36:56 +0100
X-MC-Unique: aAGw2SK1NwG3-1KqFJvVKg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 7 Jun
 2024 09:36:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 7 Jun 2024 09:36:24 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Xin Long' <lucien.xin@gmail.com>
CC: linux-sctp <linux-sctp@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: SCTP doesn't seem to let you 'cancel' a blocking accept()
Thread-Topic: SCTP doesn't seem to let you 'cancel' a blocking accept()
Thread-Index: Adq1ybjOUyi6xNR1Tiu+WEi2iGmOKwCfCtIAABryTuA=
Date: Fri, 7 Jun 2024 08:36:23 +0000
Message-ID: <0b42b8f085b84a7e8ffd5a9b71ed2932@AcuMS.aculab.com>
References: <4faeb583e1d44d82b4e16374b0ad583c@AcuMS.aculab.com>
 <CADvbK_emOEPZJ8GWtYpUDKAGLW2z84S81ZcW9qQCc=rYCiUbAA@mail.gmail.com>
In-Reply-To: <CADvbK_emOEPZJ8GWtYpUDKAGLW2z84S81ZcW9qQCc=rYCiUbAA@mail.gmail.com>
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

RnJvbTogWGluIExvbmcNCj4gU2VudDogMDYgSnVuZSAyMDI0IDIxOjE1DQo+IA0KPiBPbiBNb24s
IEp1biAzLCAyMDI0IGF0IDExOjQy4oCvQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiBhIG11bHRpdGhyZWFkZWQgcHJvZ3JhbSBpdCBp
cyByZWFzb25hYmxlIHRvIGhhdmUgYSB0aHJlYWQgYmxvY2tlZCBpbiBhY2NlcHQoKS4NCj4gPiBX
aXRoIFRDUCBhIHN1YnNlcXVlbnQgc2h1dGRvd24obGlzdGVuX2ZkLCBTSFVUX1JEV1IpIGNhdXNl
cyB0aGUgYWNjZXB0IHRvIGZhaWwuDQo+ID4gQnV0IG5vdGhpbmcgaGFwcGVucyBmb3IgU0NUUC4N
Cj4gPg0KPiA+IEkgdGhpbmsgdGhlICdtYWdpYycgaGFwcGVucyB3aGVuIHRjcF9kaXNjb25uZWN0
KCkgY2FsbHMgaW5ldF9jc2tfbGlzdGVuX3N0b3Aoc2spDQo+ID4gYnV0IHNjdHBfZGlzY29ubmVj
dCgpIGlzIGFuIGVtcHR5IGZ1bmN0aW9uIGFuZCBub3RoaW5nIGhhcHBlbnMuDQo+ID4NCj4gPiBJ
IGNhbid0IHNlZSBhbnkgY2FsbHMgdG8gaW5ldF9jc2tfbGlzdGVuX3N0b3AoKSBpbiB0aGUgc2N0
cCBjb2RlIC0gc28gSSBzdXNwZWN0DQo+ID4gaXQgaXNuJ3QgcG9zc2libGUgYXQgYWxsLg0KLi4u
DQo+ID4NCj4gPiBJIGFsc28gc3VzcGVjdCB0aGF0IGEgYmxvY2tpbmcgY29ubmVjdCgpIGNhbid0
IGJlIGNhbmNlbGxlZCBlaXRoZXI/DQo+DQo+IEZvciBjb25uZWN0aW5nIHNvY2tldCwgaXQgY2Fs
bHMgc2N0cF9zaHV0ZG93bigpIHdoZXJlIFNIVVRfV1IgY2F1c2VzDQo+IHRoZSBhc29jIHRvIGVu
dGVyIFNIVVRET1dOX1NFTlQgYW5kIGNhbmNlbCB0aGUgYmxvY2tpbmcgY29ubmVjdCgpLg0KDQpJ
J2xsIHRlc3QgdGhhdCBsYXRlciAtIHRoZSB0ZXN0IEkgd2FzIHJ1bm5pbmcgYWx3YXlzIGNvbm5l
Y3RzLg0KSSdtIHBvcnRpbmcgc29tZSBrZXJuZWwgY29kZSB0aGF0IHVzZWQgc2lnbmFscyB0byB1
bmJsb2NrIHN5bmNocm9ub3VzDQpjYWxscyB0byB1c2Vyc3BhY2Ugd2hlcmUgeW91IGNhbid0IHNp
Z25hbCBhIHRocmVhZC4NClRoZSBvbmx5IHByb2JsZW0gd2l0aCB0aGUga2VybmVsIHZlcnNpb24g
aXMgc2VjdXJlIGJvb3QgYW5kIGRyaXZlcg0Kc2lnbmluZyAoZXNwZWNpYWxseSBmb3IgdGhlIHdp
bmRvd3MgYnVpbGQhKS4NCg0KPiA+IENsZWFybHkgdGhlIGFwcGxpY2F0aW9uIGNhbiBhdm9pZCB0
aGUgaXNzdWUgYnkgdXNpbmcgcG9sbCgpIGFuZCBhbg0KPiA+IGV4dHJhIGV2ZW50ZmQoKSBmb3Ig
dGhlIHdha2V1cCAtIGJ1dCBpdCBpcyBhbGwgYSBmYWZmIGZvciBjb2RlIHRoYXQNCj4gPiBvdGhl
cndpc2Ugc3RyYWlnaHQgZm9yd2FyZC4NCj4NCj4gSSB3aWxsIHRyeSB0byBwcmVwYXJlIGEgcGF0
Y2ggdG8gc29sdmUgdGhpcyBmb3Igc2N0cCBhY2NlcHQoKSBsaWtlOg0KDQpJJ2xsIHRlc3QgaXQg
Zm9yIHlvdS4NCg0KPiBkaWZmIC0tZ2l0IGEvbmV0L3NjdHAvc29ja2V0LmMgYi9uZXQvc2N0cC9z
b2NrZXQuYw0KPiBpbmRleCBjNjc2NzlhNDEwNDQuLmYyNzBhMGE0YzY1ZCAxMDA2NDQNCj4gLS0t
IGEvbmV0L3NjdHAvc29ja2V0LmMNCj4gKysrIGIvbmV0L3NjdHAvc29ja2V0LmMNCj4gQEAgLTQ4
MzQsMTAgKzQ4MzQsMTMgQEAgaW50IHNjdHBfaW5ldF9jb25uZWN0KHN0cnVjdCBzb2NrZXQgKnNv
Y2ssDQo+IHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICAgICAgICAgcmV0dXJuIHNjdHBfY29u
bmVjdChzb2NrLT5zaywgdWFkZHIsIGFkZHJfbGVuLCBmbGFncyk7DQo+ICB9DQo+IA0KPiAtLyog
RklYTUU6IFdyaXRlIGNvbW1lbnRzLiAqLw0KPiAgc3RhdGljIGludCBzY3RwX2Rpc2Nvbm5lY3Qo
c3RydWN0IHNvY2sgKnNrLCBpbnQgZmxhZ3MpDQo+ICB7DQo+IC0gICAgICAgcmV0dXJuIC1FT1BO
T1RTVVBQOyAvKiBTVFVCICovDQo+ICsgICAgICAgaWYgKCFzY3RwX3N0eWxlKHNrLCBUQ1ApKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiArDQo+ICsgICAgICAgc2st
PnNrX3NodXRkb3duIHw9IFJDVl9TSFVURE9XTjsNCj4gKyAgICAgICByZXR1cm4gMDsNCg0KSSB0
aGluayB5b3UgbmVlZCB0byBjYWxsIHNvbWV0aGluZyB0byB1bmJsb2NrIHRoZSB0aHJlYWQgYXMg
d2VsbA0KYXMgY2hhbmdpbmcgdGhlIHN0YXRlLg0KDQouLi4NCj4gLSAgICAgICBpZiAoIXNjdHBf
c3N0YXRlKHNrLCBMSVNURU5JTkcpKSB7DQoNCkFueSBjaGFuY2Ugb2YgbWFraW5nIGl0IG11Y2gg
Y2xlYXJlciB0aGF0IHRoaXMgaXMgdGVzdGluZw0KCQlpZiAoc2stPnNrX3N0YXRlID09IFRDUF9M
SVNURU4pDQoNClRoZSB0b2tlbi1wYXN0aW5nIHRob3VnaA0KCVNDVFBfU1NfQ0xPU0VEICAgICAg
ICAgPSBUQ1BfQ0xPU0UsDQoJU0NUUF9TU19MSVNURU5JTkcgICAgICA9IFRDUF9MSVNURU4sDQoJ
U0NUUF9TU19FU1RBQkxJU0hJTkcgICA9IFRDUF9TWU5fU0VOVCwNCglTQ1RQX1NTX0VTVEFCTElT
SEVEICAgID0gVENQX0VTVEFCTElTSEVELA0KCVNDVFBfU1NfQ0xPU0lORyAgICAgICAgPSBUQ1Bf
Q0xPU0VfV0FJVCwNCm1ha2VzIGdyZXBwaW5nIGZvciBjaGFuZ2VzIHRvIHNrX3N0YXRlIHByZXR0
eSBpbXBvc3NpYmxlLg0KDQpZb3UgbWlnaHQgYXJndWUgdGhhdCB0aGUgc2tfc3RhdGUgdmFsdWVz
IHNob3VsZCBiZSBwcm90b2NvbCBuZXV0cmFsLA0KYW5kIHRoYXQgdGhlIHdyYXBwZXIgZ2l2ZXMg
c3Ryb25nIHR5cGluZyAtIGJ1dCB0b2dldGhlciB0aGV5IG1ha2UNCnRoZSBjb2RlIGhhcmQgdG8g
c2Nhbi4NCg0KVGhlIHN0cm9uZyB0eXBpbmcgY291bGQgYmUgbWFpbnRhaW5lZCBieSBjaGFuZ2lu
ZyB0aGUgY29uc3RhbnRzIHRvDQoJU0NUUF9TU19UQ1BfQ0xPU0UgPSBUQ1BfQ0xPU0UNCihldGMp
IHNvIHRoYXQgZ3JlcHBpbmcgZm9yIHRoZSBjb25zdGFudHMgc3RpbGwgd29ya3MuDQoNCkkga2Vl
cCB0aGlua2luZyBvZiB3YXlzIHRvIGRvIHN0cm9uZ2x5IHR5cGVkIGVudW0gaW4gQy4NClRoZSBt
YWluIG9wdGlvbnMgc2VlbSB0byBiZSBlbWJlZGRpbmcgdGhlIHZhbHVlIGluIGEgc3RydWN0DQpv
ciB1c2luZyBhIHBvaW50ZXIgdG8gYSBzdHJ1Y3QuDQpOZWl0aGVyIGlzIGlkZWFsLg0KDQpPVE9I
IHRoZSBjb21waWxlciBjYW4ndCBkZWZhdWx0IHRvIHN0cm9uZ2x5IHR5cGVkIGVudW0uDQpBbHRo
b3VnaCBwZXJoYXBzIHRoYXQgY291bGQgYmUgYSBwZXItZW51bSBhdHRyaWJ1dGUuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=


