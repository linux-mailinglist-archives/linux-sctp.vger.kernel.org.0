Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2A920B5B1
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Jun 2020 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgFZQN4 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 26 Jun 2020 12:13:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24493 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgFZQN4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 26 Jun 2020 12:13:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-209-xCfHYBrVPvC4iNDOenTImw-1; Fri, 26 Jun 2020 17:13:52 +0100
X-MC-Unique: xCfHYBrVPvC4iNDOenTImw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 26 Jun 2020 17:13:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 26 Jun 2020 17:13:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xin Long' <lucien.xin@gmail.com>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
CC:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "minyard@acm.org" <minyard@acm.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: Strange problem with SCTP+IPv6
Thread-Topic: Strange problem with SCTP+IPv6
Thread-Index: AQHWSUW2AOXwYZ/c30aD/cEnXBcaYKjrFNkw
Date:   Fri, 26 Jun 2020 16:13:51 +0000
Message-ID: <50b0a6ff186e408bbfe6211221cb3998@AcuMS.aculab.com>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
 <CADvbK_fddQiOJUVJNkJuxkzQ9V-tpk_ATBP4NpZ2rZketHEFcg@mail.gmail.com>
In-Reply-To: <CADvbK_fddQiOJUVJNkJuxkzQ9V-tpk_ATBP4NpZ2rZketHEFcg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

RnJvbTogWGluIExvbmcNCj4gU2VudDogMjMgSnVuZSAyMDIwIDExOjE0DQo+ID4gPiBJdCBsb29r
cyBsaWtlIGEgYnVnIHRvIG1lLiBUZXN0aW5nIHdpdGggdGhpcyB0ZXN0IGFwcCBoZXJlLCBJIGNh
biBzZWUNCj4gPiA+IHRoZSBJTklUX0FDSyBiZWluZyBzZW50IHdpdGggYSBidW5jaCBvZiBpcHY0
IGFkZHJlc3NlcyBpbiBpdCBhbmQNCj4gPiA+IHRoYXQncyB1bmV4cGVjdGVkIGZvciBhIHY2b25s
eSBzb2NrZXQuIEFzIGlzLCBpdCdzIHRoZSBzZXJ2ZXIgc2F5aW5nDQo+ID4gPiAiSSdtIGF2YWls
YWJsZSBhdCB0aGVzZSBvdGhlciBhZGRyZXNzZXMgdG9vLCBidXQgbm90LiINCj4gPiBJIGFncmVl
Lg0KPiBUaGVuIHdlIG5lZWQgYSBmaXggaW4gc2N0cF9iaW5kX2FkZHJzX3RvX3JhdygpOg0KPiAN
Cj4gQEAgLTIzOCw2ICsyNDAsOSBAQCB1bmlvbiBzY3RwX3BhcmFtcyBzY3RwX2JpbmRfYWRkcnNf
dG9fcmF3KGNvbnN0DQo+IHN0cnVjdCBzY3RwX2JpbmRfYWRkciAqYnAsDQo+ICAgICAgICAgYWRk
cnBhcm1zID0gcmV0dmFsOw0KPiANCj4gICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGFkZHIs
ICZicC0+YWRkcmVzc19saXN0LCBsaXN0KSB7DQo+ICsgICAgICAgICAgICAgICBpZiAoKFBGX0lO
RVQ2ID09IHNrLT5za19mYW1pbHkpICYmIGluZXRfdjZfaXB2Nm9ubHkoc2spICYmDQo+ICsgICAg
ICAgICAgICAgICAgICAgKEFGX0lORVQgPT0gYWRkci0+YS5zYS5zYV9mYW1pbHkpKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gICAgICAgICAgICAgICAgIGFmID0gc2N0
cF9nZXRfYWZfc3BlY2lmaWMoYWRkci0+YS52NC5zaW5fZmFtaWx5KTsNCj4gICAgICAgICAgICAg
ICAgIGxlbiA9IGFmLT50b19hZGRyX3BhcmFtKCZhZGRyLT5hLCAmcmF3YWRkcik7DQo+ICAgICAg
ICAgICAgICAgICBtZW1jcHkoYWRkcnBhcm1zLnYsICZyYXdhZGRyLCBsZW4pOw0KDQpUaG91Z2h0
Lg0KDQpEb2VzIGl0IG1ha2UgYW55IHNlbnNlIHRvIG9mZmVyIGFkZHJlc3NlcyBpbiB0aGUgSU5J
VF9BQ0sgdGhhdCBkb24ndA0KaGF2ZSByb3V0ZXMgdG8gdGhvc2UgcHJvcG9zZWQgaW4gdGhlIHJl
Y2VpdmVkIElOSVQ/DQoNCidyb3V0ZXMnIHByb2JhYmx5IGlzbid0IGV4YWN0bHkgdGhlIHJpZ2h0
IHdvcmQuDQpZb3UgcHJvYmFibHkgb25seSB3YW50IHRoZSBsb2NhbCBhZGRyZXNzIHRoYXQgd2ls
bCBiZSB1c2VkDQphcyB0aGUgc291cmNlIGFkZHJlc3MgZm9yIHRoZSBwcm9iZXMuDQpPciwgYXQg
bGVhc3QsIHNvdXJjZXMgYWRkcmVzc2VzIHRoYXQgY291bGQgYmUgdXNlZCBmb3IgdGhlIHByb2Jl
cy4NCg0KU28gaWYgdGhlIElOSVQgb25seSBjb250YWlucyBJUHY2IGFkZHJlc3NlcyBzaG91bGQg
dGhlIElOSVRfQUNLDQpldmVyIGNvbnRhaW4gSVB2NCBvbmVzLg0KDQoJRGF2aWQuDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

