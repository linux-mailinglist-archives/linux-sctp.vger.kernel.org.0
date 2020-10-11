Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E328A7F2
	for <lists+linux-sctp@lfdr.de>; Sun, 11 Oct 2020 17:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbgJKP2v (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 11 Oct 2020 11:28:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23922 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388167AbgJKP2u (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 11 Oct 2020 11:28:50 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-122-bOx-x7AyPAO2UKth8Bal2A-1; Sun, 11 Oct 2020 16:28:44 +0100
X-MC-Unique: bOx-x7AyPAO2UKth8Bal2A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 11 Oct 2020 16:28:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 11 Oct 2020 16:28:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Xin Long' <lucien.xin@gmail.com>
CC:     Andreas Fink <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: sctp discarding received data chunks
Thread-Topic: sctp discarding received data chunks
Thread-Index: AQHWng1GnBiC92Jzi0usTZn0U2V7p6mPGcdwgAAhfiCAANPdAIAA4KSwgAGaErA=
Date:   Sun, 11 Oct 2020 15:28:43 +0000
Message-ID: <645944cb37fa4e41b90b18ff2b5d313d@AcuMS.aculab.com>
References: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
 <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org>
 <73434b87932e46a89dd1b5b5132b3196@AcuMS.aculab.com>
 <766ffacb7d4c48df81aea64204ff37d9@AcuMS.aculab.com>
 <CADvbK_farVU-bB9NeLSDfmCgPcdG2Oe44-odeU0o+b2BwfRA0g@mail.gmail.com>
 <5af24669b72c4bbb9456b53c397489a4@AcuMS.aculab.com>
In-Reply-To: <5af24669b72c4bbb9456b53c397489a4@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Li4uDQo+ID4gPiBJZiBJIGR1bXAgb3V0IC9wcm9jL25ldC9zY3RwL2Fzc29jcyBhbmQgbG9vayB3
YXkgb3ZlciB0byB0aGUgcmlnaHQNCj4gPiA+IChvbiB0aGUgbmV4dCBtb25pdG9yIGJ1dCAxKSB0
aGVyZSBhcmUgdHdvIGNvbHVtbnMgSU5TIGFuZCBPVVRTLg0KPiA+ID4gSSd2ZSBqdXN0IHJlYWxp
c2VkIHRoYXQgdGhlc2UgYXJlIHRoZSBudW1iZXIgb2Ygc3RyZWFtcy4NCj4gPiA+IE5vdyBhbGwg
bXkgY29ubmVjdGlvbnMgYXJlIGxvb3BiYWNrIC0gc28gSSBzZWUgYm90aCBzb2NrZXRzIGZvciBl
YWNoLg0KPiA+ID4gU28gSSdkIGV4cGVjdCB0aGUgSU5TIHRvIG1hdGNoIHRoZSBPVVRTIG9mIHRo
ZSBwZWVyLg0KPiA+ID4gVGhpcyBpc24ndCB0cnVlLg0KPiA+ID4gV2hlbiB0aGUgdmFsdWUgc2hv
dWxkIGJlIG5lZ290aWF0ZWQgZG93biB0aGUgT1VUUyB2YWx1ZSBpcyB1bmNoYW5nZWQuDQo+ID4g
PiBTbyB0aGUga2VybmVsIGlzIHNlbmRpbmcgcGFja2V0cyB3aXRoIGlsbGVnYWwgc3RyZWFtIG51
bWJlcnMuDQo+ID4gPiBUaGVzZSBhcmUgYWNrZWQgYW5kIHRoZW4gc2lsZW50bHkgZGlzY2FyZGVk
Lg0KPiANCj4gPiBkaWQgaXQgZG8gYWRkc3RyZWFtIHJlY29uZmlnIG9yIHJlY2VpdmUgYW55IGR1
cGxpY2F0ZSBDT09LSUUtRUNITyBpbiB5b3VyIGNhc2U/DQo+IA0KPiBFeHRyZW1lbHkgdW5saWtl
bHkuDQo+IA0KPiBMb29raW5nIGF0IHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBteSBkcml2ZXIgY29k
ZQ0KPiAod2hpY2ggSSB3YXNuJ3QgdXNpbmcpIEkgd3JvdGUgdGhlIGZvbGxvd2luZzoNCj4gDQo+
ICAqIFNpbmNlIHRoZSBjb2RlIHRoYXQgbmVnb3RpYXRlcyB0aGUgbnVtYmVyIG9mIHN0cmVhbXMg
Z290IGJyb2tlbg0KPiAgKiBpbiB2ZXJzaW9uIDUuMSB3ZSBuZWVkIHRvIGV4dHJhY3QgdGhlIGNv
cnJlY3QgdmFsdWUgZnJvbSB0aGUNCj4gICogaW50ZXJuYWwgc3RydWN0dXJlcyB0byBhdm9pZCBT
Q1RQIHNlbmRpbmcgbWVzc2FnZXMgdGhlIHJlbW90ZQ0KPiAgKiBzeXN0ZW0gd2lsbCBkaXNjYXJk
Lg0KPiANCj4gICAgIC8qIHN0cmVhbS5vdXRjbnQgaXMgdGhlIHZhbHVlIHdlIHNob3VsZCBiZSB1
c2luZy4NCj4gICAgICAqIEJ1dCBrZXJuZWxzIDUuMSB0byA1LjggZmFpbCB0byByZWR1Y2UgaXQg
YmFzZWQgb24gdGhlIG51bWJlcg0KPiAgICAgICogcmVjZWl2ZWQgZnJvbSB0aGUgcmVtb3RlIHN5
c3RlbS4NCj4gICAgICAqIFNvIGJvdW5kIGhlcmUgc28gdGhhdCB0cmFuc21pdHRlZCBtZXNzYWdl
cyBkb24ndCBnZXQgZGlzY2FyZGVkLiAqLw0KPiAgICAgb3V0Y250ID0gYXNvYy0+c3RyZWFtLm91
dGNudDsNCj4gICAgIG51bV9vc3RyZWFtcyA9IGFzb2MtPmMuc2luaXRfbnVtX29zdHJlYW1zOw0K
PiANCj4gSSB0aGluayB0aGVyZSB3YXMgYSBwYXRjaCBkb25lIGZvciA1LjkuDQo+IEl0IG5lZWRz
IGJhY2stcG9ydGluZy4NCg0KWWVzLCBJIHdyb3RlIHRoZSBwYXRjaC4NCkFwcGxpZWQgdG8gbmV0
LW5leHQuDQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0L25ldC9zY3RwL3N0cmVhbS5jP2lkPWFiOTIxZjNj
ZGJlYzAxYzY4NzA1YTdhZGU4YmVjNjI4ZDU0MWZjMmINCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

