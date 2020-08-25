Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B33251B61
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHYOx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:53:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:34149 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbgHYOxM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-5-RxTbYGO7PkKmaiFzaObIVg-1; Tue, 25 Aug 2020 15:53:08 +0100
X-MC-Unique: RxTbYGO7PkKmaiFzaObIVg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:53:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:53:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 02/13] lib/generic-radix-tree: Optimise out ilog2(variable).
Thread-Topic: [PATCH 02/13] lib/generic-radix-tree: Optimise out
 ilog2(variable).
Thread-Index: AdZ67g1pvtP34U3MSIWqv3fjlqtq2w==
Date:   Tue, 25 Aug 2020 14:53:07 +0000
Message-ID: <5a4d1a42f61d4fd28e7ef177efd958af@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

ilog2() is relatively expensive (especially without bit-scan instructions).
Replace the comparisons 'ilog2(x) >= y' with '(x >> y) != 0'.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 5695fe547f9d..d5e97b51308d 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -57,7 +57,7 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
 	struct genradix_node *n = genradix_root_to_node(r);
 	unsigned level		= genradix_root_to_depth(r);
 
-	if (ilog2(offset) >= genradix_depth_shift(level))
+	if (offset >> genradix_depth_shift(level))
 		return NULL;
 
 	while (1) {
@@ -115,7 +115,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		n	= genradix_root_to_node(r);
 		level	= genradix_root_to_depth(r);
 
-		if (n && ilog2(offset) < genradix_depth_shift(level))
+		if (n && !(offset >> genradix_depth_shift(level)))
 			break;
 
 		new_node = genradix_alloc_node(gfp_mask);
@@ -171,7 +171,7 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 	n	= genradix_root_to_node(r);
 	level	= genradix_root_to_depth(r);
 
-	if (ilog2(iter->offset) >= genradix_depth_shift(level))
+	if (iter->offset >> genradix_depth_shift(level))
 		return NULL;
 
 	while (level) {
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

