Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3D5785B9
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Jul 2022 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiGROqO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 18 Jul 2022 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGROqN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 18 Jul 2022 10:46:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C689626E9
        for <linux-sctp@vger.kernel.org>; Mon, 18 Jul 2022 07:46:12 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-178-AhItwqHcO0yvj0vaZVOSSQ-1; Mon, 18 Jul 2022 15:46:10 +0100
X-MC-Unique: AhItwqHcO0yvj0vaZVOSSQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 18 Jul 2022 15:46:07 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 18 Jul 2022 15:46:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'o.evistel@free.fr'" <o.evistel@free.fr>
CC:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp <linux-sctp@vger.kernel.org>
Subject: RE: Linux SCTP performance question
Thread-Topic: Linux SCTP performance question
Thread-Index: AdiZDXbD/Hs0BhtUSVuC4iETTaIO1qa6q9HzprdcrkA=
Date:   Mon, 18 Jul 2022 14:46:07 +0000
Message-ID: <0fbdfa6320cb4eca88a49ea787f97c0c@AcuMS.aculab.com>
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

RnJvbTogby5ldmlzdGVsQGZyZWUuZnINCj4gU2VudDogMTggSnVseSAyMDIyIDE1OjEwDQo+IA0K
PiBJIHRyeSB0byBwZXJmb3JtIGEgcGVyZm9ybWFuY2UgdGVzdCB3aXRoIGEgY29uZmlndXJhdGlv
biBjb25zaXN0aW5nDQo+IG9mIGEgTTNVQS1BU1AgVk0gKGNsaWVudCkgc2VydmVkIGJ5IDQgTTNV
QS1TR1AgVk1zIChzZXJ2ZXJzKS4NCj4gQWxsIHRoZSBWTXMgYXJlIFJIRUw4LjQuDQoNCkZpbmQg
c29tZSByZWFsIHN5c3RlbXMuLi4uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

