Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F178B161FD6
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Feb 2020 05:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgBREiX (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Feb 2020 23:38:23 -0500
Received: from cnshjsmin05.nokia-sbell.com ([116.246.26.45]:19604 "EHLO
        cnshjsmin05.nokia-sbell.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgBREiX (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 17 Feb 2020 23:38:23 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 23:38:22 EST
X-AuditID: ac18929d-8e32c9c000001441-9e-5e4b66b83d28
Received: from CNSHPPEXCH1605.nsn-intra.net (Unknown_Domain [135.251.51.105])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin05.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id A2.FD.05185.8B66B4E5; Tue, 18 Feb 2020 12:23:20 +0800 (HKT)
Received: from CNSHPPEXCH1609.nsn-intra.net (135.251.51.109) by
 CNSHPPEXCH1605.nsn-intra.net (135.251.51.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Feb 2020 12:23:20 +0800
Received: from CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) by
 CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) with mapi id 15.01.1713.007;
 Tue, 18 Feb 2020 12:23:20 +0800
From:   "Chen, Chris A. (NSB - CN/Qingdao)" <chris.a.chen@nokia-sbell.com>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "Fan, Jessie (NSB - CN/Qingdao)" <jessie.fan@nokia-sbell.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "dajiang.zhang@nokia.com" <dajiang.zhang@nokia.com>,
        "piggy@acm.org" <piggy@acm.org>,
        "karl@athena.chicago.il.us" <karl@athena.chicago.il.us>,
        "chris@hundredacre.ac.uk" <chris@hundredacre.ac.uk>,
        "jgrimm@us.ibm.com" <jgrimm@us.ibm.com>,
        "xingang.guo@intel.com" <xingang.guo@intel.com>,
        "sri@us.ibm.com" <sri@us.ibm.com>,
        "daisyc@us.ibm.com" <daisyc@us.ibm.com>,
        "ardelle.fan@intel.com" <ardelle.fan@intel.com>,
        "kevin.gao@intel.com" <kevin.gao@intel.com>
Subject: RE: v5.3.12 SCTP Stream Negotiation Problem
Thread-Topic: v5.3.12 SCTP Stream Negotiation Problem
Thread-Index: AQHV5g0ePvHlF/NL5kaQVc1sX4qpvqggWDfQ
Date:   Tue, 18 Feb 2020 04:23:20 +0000
Message-ID: <05a00ef6c37d4463a1ed9f54a6042812@nokia-sbell.com>
References: <9c353cef257847c7b64793d3839abc33@nokia-sbell.com>
 <29c18e4a424343bab0fea1904cfae492@nokia-sbell.com>
 <20200218034001.GA2547@localhost.localdomain>
In-Reply-To: <20200218034001.GA2547@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsXS/ts4U3dHmnecwfsZehZtTXfYLBbu7Wa0
        mHdiP4vFjMtHmSy6J8xmttgzcR2LxdMFr1ktfq04zmrxreEsu8Xyk++YLc619TI5cHtcvuLt
        sXPtCyaPnbPusnvcXXyIxWPxnpdMHueu9TF7fN4kF8AexWWTkpqTWZZapG+XwJXxdu831oJX
        qhXvnvxmamB8o9LFyMkhIWAisfbkA6YuRi4OIYFDTBJn75yFcv4ySiw538IM4WxilLg44zwb
        SAubgIfE/w+vwWwRgQqJndObwTqYBSazSFw6/JodJCEMNHf1v+csEEWmEkvW/WGFsI0kvh1f
        ADSVg4NFQFXiwSclkDCvgJ3Elo9zwWYKCSxmlOh5GgpicwpYSSxe8oURxGYUEJP4fmoNE4jN
        LCAucevJfCaIFwQkluw5zwxhi0q8fPyPFWS8hICSRN8GqHItiXkNv6FsRYkp3Q/ZIdYKSpyc
        +YRlAqPYLCRTZyFpmYWkZRaSlgWMLKsYpZPzijOyinMz8wxM9fLyszMTdYuTUnNy9JLzczcx
        AqN6jcSkuTsYOzvjDzEKcDAq8fCumOAVJ8SaWFZcmXuIUYKDWUmE11scKMSbklhZlVqUH19U
        mpNafIhRmoNFSZy3ZfLCWCGB9MSS1OzU1ILUIpgsEwenVAPjvCldvhflZeY6Oq5ccWxvnqdl
        xZLf27iz7k3M/W2zf/KlXcuvd19mjdkeZml2ekP0zidrvSc9KkovS23zKmq3W+iz9mPm0iom
        jwv8rlNn5LTxpz40ZN63Pk6mzNZH5N/LQOdVTWfyX3Mu+cdvLxiwKPbIolMcfgU9hs0eD7xs
        LNnj9pQd7/2txFKckWioxVxUnAgAFdboI+YCAAA=
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

VGhhbmtzIE1hcmNlbG8gZm9yIHRoZSBjb25maXJtYXRpb24uDQpXZSdsbCB0cnkgdGhlIHBhdGNo
IHlvdSBzdWdnZXN0Lg0KDQpSZWdhcmRzLA0KQ2hyaXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IE1hcmNlbG8gUmljYXJkbyBMZWl0bmVyIDxtYXJjZWxvLmxlaXRuZXJAZ21h
aWwuY29tPiANClNlbnQ6IDIwMjDE6jLUwjE4yNUgMTE6NDANClRvOiBGYW4sIEplc3NpZSAoTlNC
IC0gQ04vUWluZ2RhbykgPGplc3NpZS5mYW5Abm9raWEtc2JlbGwuY29tPg0KQ2M6IGxpbnV4LXNj
dHBAdmdlci5rZXJuZWwub3JnOyBkYWppYW5nLnpoYW5nQG5va2lhLmNvbTsgcGlnZ3lAYWNtLm9y
Zzsga2FybEBhdGhlbmEuY2hpY2Fnby5pbC51czsgY2hyaXNAaHVuZHJlZGFjcmUuYWMudWs7IGpn
cmltbUB1cy5pYm0uY29tOyB4aW5nYW5nLmd1b0BpbnRlbC5jb207IHNyaUB1cy5pYm0uY29tOyBk
YWlzeWNAdXMuaWJtLmNvbTsgYXJkZWxsZS5mYW5AaW50ZWwuY29tOyBrZXZpbi5nYW9AaW50ZWwu
Y29tOyBDaGVuLCBDaHJpcyBBLiAoTlNCIC0gQ04vUWluZ2RhbykgPGNocmlzLmEuY2hlbkBub2tp
YS1zYmVsbC5jb20+DQpTdWJqZWN0OiBSZTogdjUuMy4xMiBTQ1RQIFN0cmVhbSBOZWdvdGlhdGlv
biBQcm9ibGVtDQoNCkhpLA0KDQpPbiBUdWUsIEZlYiAxOCwgMjAyMCBhdCAxMjozNzoxN0FNICsw
MDAwLCBGYW4sIEplc3NpZSAoTlNCIC0gQ04vUWluZ2Rhbykgd3JvdGU6DQo+IEhpLA0KPiANCj4g
SSBmb3VuZCB0aGUgU0NUUCBTdHJlYW0gbmVnb3RpYXRpb24gZG9lc24ndCB3b3JrIGFzIGV4cGVj
dGVkLCB0aGF0IGlzLCB0aGUgbG9jYWwgb3V0Ym91bmQgc3RyZWFtIGFuZCB0aGUgcmVtb3RlIGlu
Ym91bmQgc3RyZWFtIGNvbXBhcmlzb24gc2VlbXMgbWlzc2luZy4NCj4gRm9yIGV4YW1wbGUsIHdo
ZW4gdGhlIGxvY2FsIG91dHN0cmVhbSgxNikgaXMgZ3JlYXRlciB0aGFuIHRoZSByZW1vdGUgaW5i
b3VuZCBzdHJlYW0oMiksIDE2IGlzIHNhdmVkIGFuZCB1c2VkIGFzIHRoZSAiT1VUUyIsIHdoaWNo
IGlzIHNob3duIGZyb20gL3Byb2MvcGlkL25ldC9zY3RwL2Fzc29jcyBiZWxvdy4NCj4gQ2FuIGFu
eW9uZSBoZWxwIGNvbW1lbnQ/DQo+IA0KPiBGcm9tIGxvY2FsIGVuZCBwb2ludCwgMTYgaXMgc2V0
IGFzIGJvdGggdGhlIG91dGJvdW5kIGFuZCBpbmJvdW5kIHN0cmVhbS4NCj4gRnJvbSB0aGUgcmVt
b3RlIGVuZCBwb2ludCwgMiBpcyBzZXQgZm9yIGJvdGggdGhlIG91dGJvdW5kIGFuZCBpbmJvdW5k
IA0KPiBzdHJlYW0NCj4gDQo+IEhvd2V2ZXIsIGFmdGVyIHRoZSBhc3NvY2lhdGlvbiBpcyB1cCwg
dGhlIGluYm91bmQgYW5kIG91dGJvdW5kIHN0cmVhbSBpcyBzZXQgYXMgKDIsMTYpLCB3aGljaCBJ
IHRoaW5rIGlzIHVuZXhwZWN0ZWQuDQo+IHNoLTQuMiMgY2F0IDEvbmV0L3NjdHAvYXNzb2NzDQo+
IEFTU09DIFNPQ0sgU1RZIFNTVCBTVCBIQktUIEFTU09DLUlEIFRYX1FVRVVFIFJYX1FVRVVFIFVJ
RCBJTk9ERSBMUE9SVCANCj4gUlBPUlQgTEFERFJTIDwtPiBSQUREUlMgSEJJTlQgSU5TIE9VVFMg
TUFYUlQgVDFYIFQyWCBSVFhDIHdtZW1hIHdtZW1xIA0KPiBzbmRidWYgcmN2YnVmIDU1ZGFlNWJi
IGJiM2RlYzcyIDAgNyAzIDAgMjQxNSAwIDAgNTA0IDEyMjM0NTEgMjkwNSAzOTA0IA0KPiB4eC54
eC54eC54eCB5eS55eS55eS55eSA8LT4gKnp6Lnp6Lnp6Lnp6IHd3Lnd3Lnd3Lnd3IDMwMDAwIDIg
MTYgMTAgMCAwIA0KPiAwIDEgMCAyNjIxNDQgMjYyMTQ0DQo+IA0KPiBJIGZ1cnRoZXIgY2hlY2tl
ZCB0aGUga2VybmVsIGNvZGUgYW5kIGZvdW5kIGluIHY1LjAsIHRoZXJlIGlzIHN0aWxsIGNvbXBh
cmlzb24gbG9naWM6IG1pbihvdXRjbnQsIHN0cmVhbS0+b3V0Y250KSBhbmQgc2F2ZSB0aGUgc21h
bGxlciBvbmUgaW4gdGhlIGZ1bmN0aW9uIHNjdHBfc3RyZWFtX2FsbG9jX291dCgpLg0KPiBCdXQg
dGhlIGxvZ2ljIGRpc2FwcGVhcmVkIGluIHY1LjEsIGFuZCBpZiB0aGUgIm91dGNudCIgaXMgc21h
bGxlciwgaXQncyBub3Qgc2F2ZWQgbG9jYWxseS4NCj4gc3RhdGljIGludCBzY3RwX3N0cmVhbV9h
bGxvY19vdXQoc3RydWN0IHNjdHBfc3RyZWFtICpzdHJlYW0sIF9fdTE2IG91dGNudCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZnBfdCBnZnApIHsNCj4gICAgICAgICBpbnQg
cmV0Ow0KPiANCj4gICAgICAgICBpZiAob3V0Y250IDw9IHN0cmVhbS0+b3V0Y250KSAvL0hlcmUg
aXMgcHJvYmxlbWF0aWMsIGFuZCB0aGUgb3V0Y250IGlzIG5vdCBzYXZlZCBsb2NhbGx5Lg0KDQpN
YWtlcyBzZW5zZS4NCkJlZm9yZSAyMDc1ZTUwY2FmNWUgKCJzY3RwOiBjb252ZXJ0IHRvIGdlbnJh
ZGl4IikgaXQgd2FzIHVwZGF0aW5nDQpzdHJlYW0tPm91dGNudCB3aXRoIHNtYWxsZXIgdmFsdWVz
IHdoZW4gYXBwbGljYWJsZToNCg0KLSAgICAgICBpZiAob3V0Y250ID4gc3RyZWFtLT5vdXRjbnQp
DQotICAgICAgICAgICAgICAgZmFfemVybyhvdXQsIHN0cmVhbS0+b3V0Y250LCAob3V0Y250IC0g
c3RyZWFtLT5vdXRjbnQpKTsNCisgICAgICAgaWYgKG91dGNudCA8PSBzdHJlYW0tPm91dGNudCkN
CisgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KLSAgICAgICBzdHJlYW0tPm91dCA9IG91dDsN
Cg0KSXQgYWxzbyBhZmZlY3RzIHRoZSBpbnB1dCBzdHJlYW0gQUZBSUNULg0KQ2FuIHlvdSBwbGVh
c2UgdHJ5IHRoZSBmb2xsb3dpbmcgcGF0Y2g/DQoNClRoYW5rcywNCk1hcmNlbG8NCg0KLS0tODwt
LS0NCg0KZGlmZiAtLWdpdCBhL25ldC9zY3RwL3N0cmVhbS5jIGIvbmV0L3NjdHAvc3RyZWFtLmMg
aW5kZXggNjdmN2U3MWY5MTI5Li4zNGYwYjczMTJmZTggMTAwNjQ0DQotLS0gYS9uZXQvc2N0cC9z
dHJlYW0uYw0KKysrIGIvbmV0L3NjdHAvc3RyZWFtLmMNCkBAIC04MSwxMiArODEsMTMgQEAgc3Rh
dGljIGludCBzY3RwX3N0cmVhbV9hbGxvY19vdXQoc3RydWN0IHNjdHBfc3RyZWFtICpzdHJlYW0s
IF9fdTE2IG91dGNudCwNCiAJaW50IHJldDsNCiANCiAJaWYgKG91dGNudCA8PSBzdHJlYW0tPm91
dGNudCkNCi0JCXJldHVybiAwOw0KKwkJZ290byBvdXQ7DQogDQogCXJldCA9IGdlbnJhZGl4X3By
ZWFsbG9jKCZzdHJlYW0tPm91dCwgb3V0Y250LCBnZnApOw0KIAlpZiAocmV0KQ0KIAkJcmV0dXJu
IHJldDsNCiANCitvdXQ6DQogCXN0cmVhbS0+b3V0Y250ID0gb3V0Y250Ow0KIAlyZXR1cm4gMDsN
CiB9DQpAQCAtOTYsMTMgKzk3LDE0IEBAIHN0YXRpYyBpbnQgc2N0cF9zdHJlYW1fYWxsb2NfaW4o
c3RydWN0IHNjdHBfc3RyZWFtICpzdHJlYW0sIF9fdTE2IGluY250LCAgew0KIAlpbnQgcmV0Ow0K
IA0KLQlpZiAoaW5jbnQgPD0gc3RyZWFtLT5pbmNudCkNCi0JCXJldHVybiAwOw0KKwlpZiAoaW5j
bnQgPiBzdHJlYW0tPmluY250KQ0KKwkJZ290byBvdXQ7DQogDQogCXJldCA9IGdlbnJhZGl4X3By
ZWFsbG9jKCZzdHJlYW0tPmluLCBpbmNudCwgZ2ZwKTsNCiAJaWYgKHJldCkNCiAJCXJldHVybiBy
ZXQ7DQogDQorb3V0Og0KIAlzdHJlYW0tPmluY250ID0gaW5jbnQ7DQogCXJldHVybiAwOw0KIH0N
Cg==
