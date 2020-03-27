Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B1195035
	for <lists+linux-sctp@lfdr.de>; Fri, 27 Mar 2020 05:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgC0E5r (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 27 Mar 2020 00:57:47 -0400
Received: from cnshjsmin05.nokia-sbell.com ([116.246.26.45]:54213 "EHLO
        cnshjsmin05.nokia-sbell.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgC0E5r (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 27 Mar 2020 00:57:47 -0400
X-AuditID: ac18929d-db7ff7000000ac01-e4-5e7d87c5562b
Received: from CNSHPPEXCH1608.nsn-intra.net (Unknown_Domain [135.251.51.108])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin05.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id 34.76.44033.5C78D7E5; Fri, 27 Mar 2020 12:57:41 +0800 (HKT)
Received: from CNSHPPEXCH1609.nsn-intra.net (135.251.51.109) by
 CNSHPPEXCH1608.nsn-intra.net (135.251.51.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 27 Mar 2020 12:57:40 +0800
Received: from CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) by
 CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) with mapi id 15.01.1847.007;
 Fri, 27 Mar 2020 12:57:40 +0800
From:   "Mao, Jinhui (NSB - CN/Hangzhou)" <jinhui.mao@nokia-sbell.com>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: One question regarding the SCTP write buffer free mechanism
Thread-Topic: One question regarding the SCTP write buffer free mechanism
Thread-Index: AdYDLpGaGVoPpsYATP6yhoepKrJy1AAMzJ2AACSImkA=
Date:   Fri, 27 Mar 2020 04:57:40 +0000
Message-ID: <5e5090adafc24ee3b139801bf4f0942e@nokia-sbell.com>
References: <9f7ef2f9a93b420c915a9e130356cdfa@nokia-sbell.com>
 <20200326192909.GD3828@localhost.localdomain>
In-Reply-To: <20200326192909.GD3828@localhost.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42Jp/22co3u0vTbO4NgmMYunC16zWvxacZzV
        gclj56y77B6fN8kFMEVx2aSk5mSWpRbp2yVwZZzd2MZW8Iuv4um3ZYwNjCf4uhg5OSQETCRO
        7lzA3sXIxSEkcIhJ4vb7N1DOX0aJg0eXsUI4mxgl3tx4yALSwibgIvF2/152EFtEwFzi5ssT
        YHFmAVuJz229YHFhAQ+JaW2LgJo5gGo8JW7NkoQot5KYd+o9WAmLgKrEtYNPmEBsXgE7iXd3
        r7GC2EICeRJT33aBjeQEqj/YMhEsziggKzHt0X0miFXiEreezGeC+EBAYsme88wQtqjEy8f/
        wNZKCChJ9G1gAjGZBTQl1u/Sh+hUlJjS/ZAdYqugxMmZT1gmMIrNQjJ0FkLHLCQds5B0LGBk
        WcUonZxXnJFVnJuZZ2Cql5efnZmoW5yUmpOjl5yfu4kRGEVrJCbN3cHY2Rl/iFGAg1GJh7eh
        rSZOiDWxrLgy9xCjBAezkgjv00igEG9KYmVValF+fFFpTmrxIUZpDhYlcd6WyQtjhQTSE0tS
        s1NTC1KLYLJMHJxSDYwb1svfZIyZy3bn1ssvzDw3F32Tm3cwWZlfuGTLLT3vL3Injn8/dOvM
        4f8Ll5udu7lyxsvsIq3lUw5XFHYsEhLpL0u73pY143XaDk0FvqfT762ZfEfdpuryXYciyX/l
        YR/PPE/vnzSRJSZmavj7vTO/deoLJa+f9eD/JuY96ZGlP5JYmd8vfWXHocRSnJFoqMVcVJwI
        AC19nBOeAgAA
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

VGhhbmtzIGEgbG90IGZvciB0aGUgcmVzcG9uc2UuIEl0YHMgY2xlYXIgZm9yIG1lIG5vdy4g8J+Y
gw0KDQpIYXZlIGEgbmljZSBkYXkhDQoNCkJlc3QgUmVnYXJkcyENCg0KTWFvIEppbmh1aQ0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFyY2VsbyBSaWNhcmRvIExlaXRuZXIg
PG1hcmNlbG8ubGVpdG5lckBnbWFpbC5jb20+IA0KU2VudDogMjAyMOW5tDPmnIgyN+aXpSAzOjI5
DQpUbzogTWFvLCBKaW5odWkgKE5TQiAtIENOL0hhbmd6aG91KSA8amluaHVpLm1hb0Bub2tpYS1z
YmVsbC5jb20+DQpDYzogbGludXgtc2N0cEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBP
bmUgcXVlc3Rpb24gcmVnYXJkaW5nIHRoZSBTQ1RQIHdyaXRlIGJ1ZmZlciBmcmVlIG1lY2hhbmlz
bQ0KDQpPbiBUaHUsIE1hciAyNiwgMjAyMCBhdCAwNToyMjo0NkFNICswMDAwLCBNYW8sIEppbmh1
aSAoTlNCIC0gQ04vSGFuZ3pob3UpIHdyb3RlOg0KLi4uDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgaGFwcGVuZWQgb24gRW5kcG9pbnQgQSB3aGVuIGNhbGxpbmcgU0NUUCBzZW5kbXNn
IHRvIHNlbmQgbW9yZSB0byBFbmRwb2ludCBCLCB0aGUgZXJyb3IgaXMgIlJlc291cmNlIHRlbXBv
cmFyaWx5IHVuYXZhaWxhYmxlIi4gQXNzb2NpYXRpb24gaXMgbm90IGRlc3Ryb3llZCBhdCB0aGlz
IHRpbWUuIA0KPiAxIHNlY29uZCBsYXRlciBSVE8gVGltZW91dCAybmQgUmUtdHJhbnMgREFUQSBb
VFNOPTddIC0tLS0tLS0tLS0tLS0tLT4gDQo+IChBY2tlZCkNCj4gDQo+IA0KPiBTbyBjb3VsZCB5
b3UgcGxlYXNlIGhlbHAgdG8gY29tbWVudHMgb24gdGhlIGZvbGxvd2luZyBxdWVzdGlvbj8NCj4g
LQlEb2VzIHRoaXMgbWVhbnMgdGhhdCBpZiBhbiBnYXAgaXMgZm91bmQgaW4gdGhlIFNBQ0ssIHRo
b3NlIHBhY2thZ2VzIHNlbnQgYWZ0ZXIgdGhpcyBsb3N0IHBhY2tldCB3aWxsIHN0YXkgaW4gdGhl
IHdyaXRlIGJ1ZmZlciB1bnRpbCB0aGUgZ2FwIGlzIGZpbGxlZD8gRXZlbiBpZiB0aGV5IGFyZSBz
dWNjZXNzZnVsbHkgU0FDS2VkPw0KDQpZZXMgYW5kIHllcy4gQmVjYXVzZSB0aGUgcmVjZWl2ZXIg
aXMgYWxsb3dlZCB0byBkcm9wIGFueSBkYXRhIGFja2VkIGluIGEgZ2FwIGJsb2NrIGlmIGl0IG5l
ZWRzIG1vcmUgbWVtb3J5IHRvIGZpbGwgaW4gdGhlIGdhcCwgYW5kIGluIHRoaXMgY2FzZSwgdGhl
IHNlbmRlciB3b3VsZCBoYXZlIHRvIHJldHJhbnNtaXQgaXQuDQoNClNlZW1zIHlvdSdyZSB1c2lu
ZyBub24tYmxvY2sgc29ja2V0cywgb3RoZXJ3aXNlIHRoYXQgbGFzdCBzZW5kbXNnKCkgd291bGQg
aGF2ZSBibG9ja2VkIHdhaXRpbmcgZm9yIHRoZSBzbmRidWYgc3BhY2UgdG8gYmUgYXZhaWxhYmxl
LCBidHcuDQoNCkNoZWVycywNCiAgTWFyY2Vsbw0K
