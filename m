Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F970A82B
	for <lists+linux-sctp@lfdr.de>; Sat, 20 May 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjETMse (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 20 May 2023 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjETMsd (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 20 May 2023 08:48:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67139121
        for <linux-sctp@vger.kernel.org>; Sat, 20 May 2023 05:48:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-ZFWb1jHDM3WePpzNReqI_Q-1; Sat, 20 May 2023 13:48:23 +0100
X-MC-Unique: ZFWb1jHDM3WePpzNReqI_Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 20 May
 2023 13:48:21 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 20 May 2023 13:48:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
        Breno Leitao <leitao@debian.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "courmisch@gmail.com" <courmisch@gmail.com>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "alex.aring@gmail.com" <alex.aring@gmail.com>,
        "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
        "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthieu.baerts@tessares.net" <matthieu.baerts@tessares.net>,
        "marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "leit@fb.com" <leit@fb.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>
Subject: RE: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Thread-Topic: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Thread-Index: AQHZinQFkjARdT8YlUi1kSrEdFLkt69jHBLw
Date:   Sat, 20 May 2023 12:48:21 +0000
Message-ID: <00e1ca50c7824750b24039c16a9d8bc9@AcuMS.aculab.com>
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519135821.922326-2-leitao@debian.org>
 <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com>
 <ZGeYF+pp8Ukbo4p5@gmail.com>
 <CAF=yD-L0MnbofufMB_SKu+8PZ+f_QdAGYoDe-jOavdkAjFrXXg@mail.gmail.com>
In-Reply-To: <CAF=yD-L0MnbofufMB_SKu+8PZ+f_QdAGYoDe-jOavdkAjFrXXg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiAxOSBNYXkgMjAyMyAxODowNQ0KLi4uDQo+
ID4gU2hvdWxkIEkgc3RhY2sgYWxsb2NhdGUgYWxsIHRoZSA0IHN0cnVjdHVyZXMgc29ja19za3By
b3RfaW9jdGwgYW5kIHBhc3MNCj4gPiB0aGVtIHRvIHNvY2tfc2twcm90b19pb2N0bF9pbm91dCgp
IHRvZ2V0aGVyIHdpdGggdGhlIHNpemU/ICh1c2luZyB0aGUNCj4gPiBvcmlnaW5hbCBuYW1lIHRv
IGF2b2lkIGNvbmZ1c2lvbiAtIHdpbGwgcmVuYW1lIGluIFYyKQ0KPiA+DQo+ID4gSSBtZWFuLCB3
cml0aW5nIHNvbWV0aGluZyBhczoNCj4gPg0KPiA+IGludCBzb2NrX3NrcHJvdF9pb2N0bChzdHJ1
Y3Qgc29jayAqc2ssIHVuc2lnbmVkIGludCBjbWQNCj4gPiAgICAgICAgICAgICAgICAgICAgICB2
b2lkIF9fdXNlciAqYXJnYA0KPiA+IHsNCj4gPiAgICAgICAgIHN0cnVjdCBzaW9jX3ZpZl9yZXEg
c2lvY192aWZfcmVxX2FyZzsNCj4gPiAgICAgICAgIHN0cnVjdCBzaW9jX3NnX3JlcSBzaW9jX3Nn
X3JlcV9hcmc7DQo+ID4gICAgICAgICBzdHJ1Y3Qgc2lvY19taWZfcmVxNiBzaW9jX21pZl9yZXE2
X2FyZzsNCj4gPiAgICAgICAgIHN0cnVjdCBzaW9jX3NnX3JlcTYgc2lvY19zZ19yZXE2X2FyZzsN
Cj4gPg0KPiA+ICAgICAgICAgLi4NCj4gPg0KPiA+ICAgICAgICAgaWYgKCFzdHJjbXAoc2stPnNr
X3Byb3QtPm5hbWUsICJSQVc2IikpIHsNCj4gPiAgICAgICAgIHN3aXRjaCAoY21kKSB7DQo+ID4g
ICAgICAgICAgICAgICAgY2FzZSBTSU9DR0VUTUlGQ05UX0lONjoNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBzb2NrX3NrcHJvdG9faW9jdGxfaW5vdXQoc2ssIGNtZCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXJnLCAmc2lvY19taWZfcmVxNl9hcmcsIHNp
emVvZihzaW9jX21pZl9yZXE2X2FyZyk7DQo+ID4gICAgICAgICAgICAgICAgY2FzZSBTSU9DR0VU
U0dDTlRfSU42Og0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHNvY2tfc2twcm90
b19pb2N0bF9pbm91dChzaywgY21kLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhcmcsICZzaW9jX3NnX3JlcTZfYXJnLCBzaXplb2Yoc2lvY19zZ19yZXE2X2FyZykpOw0KPiA+
ICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgfQ0KPiA+ICAgICAgICAuLi4NCj4gPiB9DQo+
IA0KPiBTbGlnaHQgcHJlZmVyZW5jZSBmb3IgdXNpbmcgYnJhY2VzIGluIHRoZSBpbmRpdmlkdWFs
IGNhc2Ugc3RhdGVtZW50cw0KPiBhbmQgZGVmaW5pbmcgdGhlIHZhcmlhYmxlcyBpbiB0aGF0IGJs
b2NrIHNjb3BlLiBTZWUgZm9yIGluc3RhbmNlDQo+IGRvX3RjcF9zZXRzb2Nrb3B0Lg0KDQpCZXdh
cmUgb2Ygc3RhY2sgYmxvYXQgZXNwZWNpYWxseSB1bmRlciBLQVNBTiAoZXRjKS4NCkl0IG1pZ2h0
IGJlIGJldHRlciB0byB1c2UgYSB1bmlvbi4NClRoZW4gdGhlIHN3aXRjaCBzdGF0ZW1lbnQgb25s
eSBuZWVkIGRldGVybWluZSB0aGUgcmVxdWlyZWQgbGVuZ3RoLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

