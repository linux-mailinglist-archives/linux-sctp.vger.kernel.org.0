Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4842470A83F
	for <lists+linux-sctp@lfdr.de>; Sat, 20 May 2023 15:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjETNDN (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 20 May 2023 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjETNDM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 20 May 2023 09:03:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08A124
        for <linux-sctp@vger.kernel.org>; Sat, 20 May 2023 06:03:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-133-LK-B9zgTPvWRVmrWC1tFjw-1; Sat, 20 May 2023 14:02:58 +0100
X-MC-Unique: LK-B9zgTPvWRVmrWC1tFjw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 20 May
 2023 14:02:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 20 May 2023 14:02:57 +0100
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
Thread-Index: AQHZimPokjARdT8YlUi1kSrEdFLkt69jHkPA
Date:   Sat, 20 May 2023 13:02:57 +0000
Message-ID: <ab85b4420e93475dacd5e18017704b24@AcuMS.aculab.com>
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519135821.922326-2-leitao@debian.org>
 <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com>
In-Reply-To: <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiAxOSBNYXkgMjAyMyAxNjowOQ0KLi4uDQo+
IFNpbmNlIHRoYXQgaXMgYSBsaW1pdGVkIHdlbGwgdW5kZXJzdG9vZCBsaXN0LCBJJ20gbm90IGlu
IGZhdm9yIG9mIHRoZQ0KPiBzdWdnZXN0aW9uIHRvIGFkZCBhbiBleHBsaWNpdCBsZW5ndGggYXJn
dW1lbnQgdGhhdCB0aGVuIG5lZWRzIHRvIGJlDQo+IGNoZWNrZWQgaW4gZWFjaCBjYWxsZWUuDQoN
CldoaWxlIGNhbGxzIGZyb20gdXNlcnNwYWNlIGFuZCBkaXJlY3QgY2FsbHMgZnJvbSBkcml2ZXJz
IGNhbiBiZQ0KcmVhc29uYWJseSBleHBlY3RlZCB0byBoYXZlIHRoZSByZXF1aXJlZCBsZW5ndGgg
YnVmZmVyLCBJJ20NCm5vdCBzdXJlIHRoYXQgaXMgZ3VhcmFudGVlZCBmb3IgaW5kaXJlY3QgY2Fs
bHMgdmlhIGlvX3VyaW5nDQphbmQgYnBmLg0KSW4gdGhvc2UgY2FzZXMgdGhlIGFzc29jaWF0ZWQg
bGVuZ3RoIGlzIGxpa2VseSB0byBjb21lIGZyb20NCnVzZXJzcGFjZSBhbmQgYSBzdWl0YWJseSBz
aXplZCBrZXJuZWwgYnVmZmVyIGFsbG9jYXRlZC4NClNvIHNvbWV0aGluZyBuZWVkcyB0byBlbnN1
cmUgdGhlIGJ1ZmZlciBpcyBsb25nIGVub3VnaA0KKGFuZCwgaW5kZWVkLCBub3Qgc3R1cGlkbHkg
bG9uZykuDQoNCk5vdyB5b3UgY291bGQgcmVxdWlyZSB0aGF0IHRoZSBjYWxsZXIgYWx3YXlzIHN1
cHBseSBhIGJ1ZmZlcg0Kb2YgYXQgbGVhc3QgKHNheSkgNjQgYnl0ZXMgYXMgd2VsbCBhcyB0aGUg
YWN0dWFsIGxlbmd0aC4NClRoZW4gb25seSBjYWxsZWUgZnVuY3Rpb25zIHRoYXQgaGF2ZSBhIGxv
bmcgYnVmZmVyIG5lZWQgY2hlY2suDQoNCkFuIGFsdGVybmF0ZSBvcHRpb24gaXMgdG8gZGVmaW5l
IGEgdW5pb24gb2YgYWxsIHRoZSB2YWxpZA0KYXJndW1lbnQgdHlwZXMgYW5kIHJlcXVpcmUgdGhh
dCBhbnkgY29kZSBtYWtpbmcgJ3Vua25vd24nDQpyZXF1ZXN0cyBzdXBwbHkgYSBrZXJuZWwgYnVm
ZmVyIG9mIHRoYXQgbGVuZ3RoLg0KKFdpdGggZHVlIGNhcmUgdGFrZW4gdG8gYXZvaWQgb3Zlcmxv
bmcgY29waWVzIG9mIHVuaW5pdGlhbGlzZWQNCmtlcm5lbCBtZW1vcnkgYmFjayB0byB1c2Vyc3Bh
Y2UuKQ0KDQpUaGUgc2FtZSB1bmlvbiB3b3VsZCBiZSB1c2VmdWwgYXMgYW4gdXBwZXIgYm91bmQg
Zm9yIHRoZQ0Ka2VybmVsIGJ1ZmZlciBzaXplIC0gZXZlbiBpZiBpdCBpcyB0b28gbGFyZ2UgdG8g
YWx3YXlzDQphbGxvY2F0ZSBvbiBzdGFjay4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

