Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258375785B3
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Jul 2022 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiGROoP (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 18 Jul 2022 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGROoO (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 18 Jul 2022 10:44:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DCBA6306
        for <linux-sctp@vger.kernel.org>; Mon, 18 Jul 2022 07:44:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-U7jgQGj2Mj2AEX1VVoyxdA-1; Mon, 18 Jul 2022 15:44:07 +0100
X-MC-Unique: U7jgQGj2Mj2AEX1VVoyxdA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 18 Jul 2022 15:44:04 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 18 Jul 2022 15:44:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'o.evistel@free.fr'" <o.evistel@free.fr>
CC:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp <linux-sctp@vger.kernel.org>
Subject: RE: Linux SCTP performance question
Thread-Topic: Linux SCTP performance question
Thread-Index: AdiZDXbD/Hs0BhtUSVuC4iETTaIO1qa6q9HzprdfFwA=
Date:   Mon, 18 Jul 2022 14:44:04 +0000
Message-ID: <bae67ce3e5b144f5a2281b65a904ca64@AcuMS.aculab.com>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
 <fba43514485c4fdcb015ef931e7e3fc5@AcuMS.aculab.com>
 <1129400938.449718120.1658153376702.JavaMail.zimbra@free.fr>
In-Reply-To: <1129400938.449718120.1658153376702.JavaMail.zimbra@free.fr>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

RnJvbTogby5ldmlzdGVsQGZyZWUuZnINCj4gU2VudDogMTggSnVseSAyMDIyIDE1OjEwDQo+IEhp
IERhdmlkDQo+IA0KPiBJIHRyeSB0byBwZXJmb3JtIGEgcGVyZm9ybWFuY2UgdGVzdCB3aXRoIGEg
Y29uZmlndXJhdGlvbiBjb25zaXN0aW5nIG9mIGEgTTNVQS1BU1AgVk0gKGNsaWVudCkgc2VydmVk
DQo+IGJ5IDQgTTNVQS1TR1AgVk1zIChzZXJ2ZXJzKS4NCj4gQWxsIHRoZSBWTXMgYXJlIFJIRUw4
LjQuDQo+IFRoZSBUQ0FQIHRyYWZmaWMgaXMgaW5pdGlhdGVkIGJ5IHRoZSBBU1AgKDEwSyBEQVRB
LUNodW5rL3NlYykgYW5kIGV2ZW5seSBkaXN0cmlidXRlZCBvdmVyIHRoZSA0IFNHUHMNCj4gd2hp
Y2ggcmVmbGVjdCB0aGUgcmVjZWl2ZWQgdHJhZmZpYyB0byB0aGUgQVNQLg0KPiBXaXRoaW4gYSBy
YW5kb20gaW50ZXJ2YWwgKDE1IG1pbiB0byBzZXZlcmFsIGhvdXJzKSB0aGUgQVNQIGV4cGVyaWVu
Y2VzIGFuIGVycm9yIHdoZW4gY2FsbGluZw0KPiBzY3RwX3NlbmR2KCkgd2l0aCBFUlJOTz0iUmVz
b3VyY2UgVGVtcG9yYXJpbHkgVW5hdmFpbGFibGUiLg0KDQpUaGF0J3MgbG9va3MgbGlrZSBhIG5v
bi1ibG9ja2luZyBzZW5kIGhpdHRpbmcgdGhlIHNvY2tldCB3cml0ZSBidWZmZXIgbGltaXQuDQpB
bG1vc3QgY2VydGFpbmx5IHZlcnkgdHJhbnNpZW50Lg0KUG9zc2libHkgY2F1c2UgYnkgZHJvcHBl
ZCBwYWNrZXRzIG9yIHRoZSByZWNlaXZpbmcgYmVpbmcgb3ZlcmxvYWRlZC4NCg0KPiBBcyBJIGRv
bid0IGtub3cgd2hhdCBjYXVzZXMgdGhlZXNlIGVycm9ycyBJIGFtIHdvbmRlcmluZyBpZiB0aGlz
IGlzIG5vdCBhIHBlcmZvcm1hbmNlIGlzc3VlLg0KPiANCj4gUmVmZXJyaW5nIHRvIHlvdXIgcGVy
Zm9ybWFuY2UgdGVzdDoNCj4gLSBEb2VzIDQwSyByZWZsZWN0cy9zZWMgbWVhbiA0MEsgVHggREFU
QS1DaHVuay9zZWMgYW5kIDQwSyBSeCBEQVRBLUNodW5rL3NlYyA/DQoNClllcy4NCkl0IHdpbGwg
YmUgYSAnZG91YmxlLXJlZmxlY3QnIHRlc3QgKGJvdGggZW5kcyByZWZsZWN0KSB3aXRoIGEgc21h
bGxpc2gNCm51bWJlciBvZiBwYWNrZXRzIGluIHRoZSBsb29wIC0gZW5vdWdoIHRvIGdldCBtYXhp
bXVtIHRocm91Z2hwdXQNCndpdGhvdXQgcGFja2V0cyBiZWluZyBkaXNjYXJkZWQuDQoNCj4gLSBE
aWQgeW91IGFwcGx5IHNwZWNpZmljIGtlcm5lbCBwYXJhbWV0ZXJzIHR1bmluZyAocm1lbSwgd21l
bSwgLi4uKSA/DQoNCk5vLg0KDQo+IC0gQ2FuIHlvdSBzaGFyZSB0aGUgdGVzdCBwcm9ncmFtIHlv
dSB3ZXJlIHVzaW5nID8NCg0KSXQgd29uJ3QgaGVscCB5b3UuDQpJdCB1c2VzIG91ciBwcm9wcmll
dGFyeSBwcm90b2NvbCBvdmVyIFRDUCB0byBwYXNzIFRDQVAgbWVzc2FnZXMgaW50bw0KYSBkcml2
ZXIgKG1vc3RseSBTQ0NQLCBJU1VQIGFuZCBNVFAzKSB3aGljaCB1c2VzIGtlcm5lbCBzb2NrZXRz
IHRvIGRvDQp0aGUgYWN0dWFsIHNlbmQvcmVjdi4NCg0KPiANCj4gVGhhbmsgeW91IGluIGFkdmFu
Y2UgZm9yIHlvdXIgaGVscCBhbmQgc3VwcG9ydC4NCj4gDQo+IFJlZ2FyZHMNCj4gT21hciBBSVQg
QU1SQU5FDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gDQo+IA0KPiAtLS0t
LSBNYWlsIG9yaWdpbmFsIC0tLS0tDQo+IERlOiAiRGF2aWQgTGFpZ2h0IiA8RGF2aWQuTGFpZ2h0
QEFDVUxBQi5DT00+DQo+IMOAOiAibyIgPG8uZXZpc3RlbEBmcmVlLmZyPiwgIk1hcmNlbG8gUmlj
YXJkbyBMZWl0bmVyIiA8bWFyY2Vsby5sZWl0bmVyQGdtYWlsLmNvbT4NCj4gQ2M6ICJsaW51eC1z
Y3RwIiA8bGludXgtc2N0cEB2Z2VyLmtlcm5lbC5vcmc+DQo+IEVudm95w6k6IFNhbWVkaSAxNiBK
dWlsbGV0IDIwMjIgMTQ6MTM6MzENCj4gT2JqZXQ6IFJFOiBMaW51eCBTQ1RQIHBlcmZvcm1hbmNl
IHF1ZXN0aW9uDQo+IA0KPiBGcm9tOiBvLmV2aXN0ZWxAZnJlZS5mcg0KPiA+IFNlbnQ6IDEzIEp1
bHkgMjAyMiAxMzo1OQ0KPiA+DQo+ID4gSSBhbSB1c2luZyBsaW51eC1zY3RwIGFzIHRyYW5zcG9y
dCBmb3IgU0lHVFJBTiBNM1VBIG9uIFJIRUwgOC40IGFuZCBJIGFtDQo+ID4gdXNpbmcgc2N0cF9z
ZW5kbXNnKCkgYW5kIHNjdHBfcmVjdm1zZygpIHRvIHNlbmQvcmVjZWl2ZS4NCj4gPiBJIHdvdWxk
IGxpa2UgdG8ga25vdyBpZiB0aGUgdXNlIG9mIHNjdHBfc2VuZHYoKSBhbmQgc2N0cF9yZWN2digp
IGVuaGFuY2VzIHBlcmZvcm1hbmNlcyA/DQo+IA0KPiBFdmVyeSBjb3B5IHRvL2Zyb20gYSB1c2Vy
IGJ1ZmZlciBoYXMgYSBzbWFsbCAoYnV0IG1lYXN1cmFibGUpIGNvc3QuDQo+IFNvIGFueXRoaW5n
IHdpdGggYW4gaW92W10gYXJyYXkgaXMgYSBiaXQgc2xvd2VyIHRoYW4gYW4gZXF1aXZhbGVudA0K
PiBjYWxsIHRoYXQgb25seSBoYXMgYSBzaW5nbGUgYnVmZmVyLg0KPiBUaGlzIGlzIG1lYXN1cmFi
bGUgd2hlbiBjb21wYXJpbmcgc2VuZG1zZygpIGFuZCBzZW5kdG8oKSBvbiAoc2F5KQ0KPiBhIFVE
UCBzb2NrZXQuDQo+IE9UT0ggaXQgaXMgYWxsIHByb2JhYmx5IG5vaXNlIHVubGVzcyB5b3UgYXJl
IHRyeWluZyB0byBzZW5kL3JlY2VpdmUNCj4gJ3NpbGx5IG51bWJlcnMnIG9mIG1lc3NhZ2VzLg0K
PiANCj4gUmVkdWNpbmcgdGhlIG51bWJlciBvZiBzeXN0ZW0gY2FsbHMgbWF5IGhlbHAuDQo+IEJ1
dCB0aGUgY29zdCBvZiByZWN2bW1zZygpIGNoZWNraW5nIGZvciBhIHNlY29uZCBtZXNzYWdlIGlz
DQo+IHNpZ25pZmljYW50bHkgZ3JlYXRlciB0aGFuIHVzaW5nIGVwb2xsKCkuDQo+IFNvIHVubGVz
cyB5b3UgYWN0dWFsbHkgZXhwZWN0IGxvdHMgb2YgbWVzc2FnZXMgaXQgcHJvYmFibHkNCj4gaXNu
J3Qgd29ydGggdXNpbmcuDQo+IA0KPiBBc3N1bWluZyB5b3UgaGF2ZSBkaXNhYmxlZCBOYWdsZSwg
dGhlbiB0aGUgYmlnZ2VzdCBwZXJmb3JtYW5jZQ0KPiBnYWluIHdpbGwgYmUgZnJvbSBzZXR0aW5n
IE1TR19NT1JFIHdoZW4geW91IGtub3cgeW91IGhhdmUgYW5vdGhlcg0KPiBtZXNzYWdlIHRvIHNl
bmQuDQo+IFdpdGhvdXQgdGhhdCBwcmV0dHkgbXVjaCBldmVyeSBNM1VBIG1lc3NhZ2UgZW5kcyB1
cCBpbiBpdHMgb3duDQo+IGV0aGVybmV0IHBhY2tldC4NCj4gDQo+IFlvdSBkb24ndCBtZW50aW9u
IHdoeSB5b3UgdGhpbmsgeW91IGhhdmUgYSBwZXJmb3JtYW5jZSBpc3N1ZSBpbiBTQ1RQLg0KPiBJ
IHRoaW5rIHdlIGdvdCA0MDAwMCByZWZsZWN0cy9zZWMgZnJvbSBhIHRjYXAgYXBwbGljYXRpb24g
b3ZlciBNM1VBDQo+IGFuZCBTQ1RQIGxhc3QgdGltZSBJIG1lYXN1cmVkIG91dCBzdGFjay4NCj4g
DQo+IAlEYXZpZA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNCj4gUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

