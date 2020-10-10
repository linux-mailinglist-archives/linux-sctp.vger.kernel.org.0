Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E128A408
	for <lists+linux-sctp@lfdr.de>; Sun, 11 Oct 2020 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgJJWz1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 10 Oct 2020 18:55:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:28385 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730133AbgJJSpW (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Sat, 10 Oct 2020 14:45:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-29-quXr8J0PN6md3-vqkAh3xQ-1; Sat, 10 Oct 2020 16:10:56 +0100
X-MC-Unique: quXr8J0PN6md3-vqkAh3xQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 10 Oct 2020 16:10:56 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 10 Oct 2020 16:10:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xin Long' <lucien.xin@gmail.com>
CC:     Andreas Fink <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: sctp discarding received data chunks
Thread-Topic: sctp discarding received data chunks
Thread-Index: AQHWng1GnBiC92Jzi0usTZn0U2V7p6mPGcdwgAAhfiCAANPdAIAA4KSw
Date:   Sat, 10 Oct 2020 15:10:55 +0000
Message-ID: <5af24669b72c4bbb9456b53c397489a4@AcuMS.aculab.com>
References: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
 <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org>
 <73434b87932e46a89dd1b5b5132b3196@AcuMS.aculab.com>
 <766ffacb7d4c48df81aea64204ff37d9@AcuMS.aculab.com>
 <CADvbK_farVU-bB9NeLSDfmCgPcdG2Oe44-odeU0o+b2BwfRA0g@mail.gmail.com>
In-Reply-To: <CADvbK_farVU-bB9NeLSDfmCgPcdG2Oe44-odeU0o+b2BwfRA0g@mail.gmail.com>
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

RnJvbTogWGluIExvbmcNCj4gU2VudDogMTAgT2N0b2JlciAyMDIwIDAzOjM1DQo+IE9uIEZyaSwg
T2N0IDksIDIwMjAgYXQgOTowMyBQTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERhdmlkIExhaWdodA0KPiA+ID4gU2VudDogMDkg
T2N0b2JlciAyMDIwIDEyOjE0DQo+ID4gPg0KPiA+ID4gRnJvbTogQW5kcmVhcyBGaW5rDQo+ID4g
PiA+IFNlbnQ6IDA5IE9jdG9iZXIgMjAyMCAwODoyNQ0KPiA+ID4gPg0KPiA+ID4gPiBDYW4geW91
IHNlZSB0aGlzIGlzc3VlIHdpdGggdGhlIDUuNCBrZXJuZWwgdG9vPw0KPiA+ID4gPg0KPiA+ID4g
PiBJIGRpZCB5ZXN0ZXJkYXkgc29tZSB0ZXN0aW5nIGJ5IHVwZ3JhZGluZyBrZXJuZWwgZnJvbSA1
LjQgdG8gNS43IGFuZCBJIHJ1biBpbnRvIGFsbCBzb3J0cyBvZg0KPiBsaW5rcw0KPiA+ID4gPiBn
b2luZyBvZmYgYWZ0ZXIgYSB3aGlsZSBzbyBJIGhhZCB0byByZXZlcnQgYmFjay4NCj4gPiA+ID4g
NS40IGlzIHN0YWJsZSBmb3IgbWUuIDUuNyBpcyBub3QuIEFuZCBJIGhhdmUgbG90cyBvZiBNMlBB
IGFuZCBNM1VBIGNvbm5lY3Rpb25zIGxpa2UgeW91DQo+ID4gPg0KPiA+ID4gSSd2ZSBqdXN0IHNw
ZW50IGhvdXJzIGRpZ2dpbmcgdGhyb3VnaCBteSB0cmFjZXMuDQo+ID4gPiBJdCBpcyBvbmx5IHNv
bWUgbWVzc2FnZXMgdGhyb3VnaCB0aGUgY29ubmVjdGlvbiB0aGF0IGdldCBsb3N0IQ0KPiA+ID4N
Cj4gPiA+IE5vdyBTQ1RQX01JTl9JTl9EQVRBX0NIVU5LX0RJU0NBUkRTIGlzIG9ubHkgaW5jcmVt
ZW50ZWQgaW4gdHdvDQo+ID4gPiBhZGphY2VudCBwbGFjZXMgaW4gc21fc3RhdGVmdW5jcy5jLg0K
PiA+ID4NCj4gPiA+IEVpdGhlciBmb3IgYmFkIFRTTiAodW5saWtlbHkgd2hlbiBldmVyeXRoaW5n
IGlzIHVzaW5nICJsbyIpDQo+ID4gPiBhbmQgYmFkIFNUUkVBTS4NCj4gPiA+IEkgc3VzcGVjdCBp
dCBpcyB0aGUgJ2JhZCBzdHJlYW0nIGNhc2UuDQo+ID4gPiBJJ3ZlIG5vdCBkb3VibGUtY2hlY2tl
ZCBidXQgSSBiZXQgdGhlIGRpc2NhcmRlZCBwYWNrZXRzDQo+ID4gPiBhbGwgaGF2ZSBhIGxhcmdl
IHN0cmVhbSBudW1iZXIuDQo+ID4gLi4uDQo+ID4NCj4gPiBJZiBJIGR1bXAgb3V0IC9wcm9jL25l
dC9zY3RwL2Fzc29jcyBhbmQgbG9vayB3YXkgb3ZlciB0byB0aGUgcmlnaHQNCj4gPiAob24gdGhl
IG5leHQgbW9uaXRvciBidXQgMSkgdGhlcmUgYXJlIHR3byBjb2x1bW5zIElOUyBhbmQgT1VUUy4N
Cj4gPiBJJ3ZlIGp1c3QgcmVhbGlzZWQgdGhhdCB0aGVzZSBhcmUgdGhlIG51bWJlciBvZiBzdHJl
YW1zLg0KPiA+IE5vdyBhbGwgbXkgY29ubmVjdGlvbnMgYXJlIGxvb3BiYWNrIC0gc28gSSBzZWUg
Ym90aCBzb2NrZXRzIGZvciBlYWNoLg0KPiA+IFNvIEknZCBleHBlY3QgdGhlIElOUyB0byBtYXRj
aCB0aGUgT1VUUyBvZiB0aGUgcGVlci4NCj4gPiBUaGlzIGlzbid0IHRydWUuDQo+ID4gV2hlbiB0
aGUgdmFsdWUgc2hvdWxkIGJlIG5lZ290aWF0ZWQgZG93biB0aGUgT1VUUyB2YWx1ZSBpcyB1bmNo
YW5nZWQuDQo+ID4gU28gdGhlIGtlcm5lbCBpcyBzZW5kaW5nIHBhY2tldHMgd2l0aCBpbGxlZ2Fs
IHN0cmVhbSBudW1iZXJzLg0KPiA+IFRoZXNlIGFyZSBhY2tlZCBhbmQgdGhlbiBzaWxlbnRseSBk
aXNjYXJkZWQuDQoNCj4gZGlkIGl0IGRvIGFkZHN0cmVhbSByZWNvbmZpZyBvciByZWNlaXZlIGFu
eSBkdXBsaWNhdGUgQ09PS0lFLUVDSE8gaW4geW91ciBjYXNlPw0KDQpFeHRyZW1lbHkgdW5saWtl
bHkuDQoNCkxvb2tpbmcgYXQgdGhlIGxhdGVzdCB2ZXJzaW9uIG9mIG15IGRyaXZlciBjb2RlDQoo
d2hpY2ggSSB3YXNuJ3QgdXNpbmcpIEkgd3JvdGUgdGhlIGZvbGxvd2luZzoNCg0KICogU2luY2Ug
dGhlIGNvZGUgdGhhdCBuZWdvdGlhdGVzIHRoZSBudW1iZXIgb2Ygc3RyZWFtcyBnb3QgYnJva2Vu
DQogKiBpbiB2ZXJzaW9uIDUuMSB3ZSBuZWVkIHRvIGV4dHJhY3QgdGhlIGNvcnJlY3QgdmFsdWUg
ZnJvbSB0aGUNCiAqIGludGVybmFsIHN0cnVjdHVyZXMgdG8gYXZvaWQgU0NUUCBzZW5kaW5nIG1l
c3NhZ2VzIHRoZSByZW1vdGUNCiAqIHN5c3RlbSB3aWxsIGRpc2NhcmQuDQoNCiAgICAvKiBzdHJl
YW0ub3V0Y250IGlzIHRoZSB2YWx1ZSB3ZSBzaG91bGQgYmUgdXNpbmcuDQogICAgICogQnV0IGtl
cm5lbHMgNS4xIHRvIDUuOCBmYWlsIHRvIHJlZHVjZSBpdCBiYXNlZCBvbiB0aGUgbnVtYmVyDQog
ICAgICogcmVjZWl2ZWQgZnJvbSB0aGUgcmVtb3RlIHN5c3RlbS4NCiAgICAgKiBTbyBib3VuZCBo
ZXJlIHNvIHRoYXQgdHJhbnNtaXR0ZWQgbWVzc2FnZXMgZG9uJ3QgZ2V0IGRpc2NhcmRlZC4gKi8N
CiAgICBvdXRjbnQgPSBhc29jLT5zdHJlYW0ub3V0Y250Ow0KICAgIG51bV9vc3RyZWFtcyA9IGFz
b2MtPmMuc2luaXRfbnVtX29zdHJlYW1zOw0KDQpJIHRoaW5rIHRoZXJlIHdhcyBhIHBhdGNoIGRv
bmUgZm9yIDUuOS4NCkl0IG5lZWRzIGJhY2stcG9ydGluZy4NCg0KQWx0aG91Z2ggQW5kcmVhcyBz
YWlkIDUuNCB3b3JrZWQgZm9yIGhpbS4NClNvIG1heWJlIGhlIGhhcyBhIGRpZmZlcmVudCBwcm9i
bGVtLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

