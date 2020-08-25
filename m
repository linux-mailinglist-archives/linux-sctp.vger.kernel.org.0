Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16118251B5B
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHYOxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:53:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:30024 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgHYOw4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:52:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-173-Wvx2BJGKOQiqJ5F1Fe8Fiw-1; Tue, 25 Aug 2020 15:52:51 +0100
X-MC-Unique: Wvx2BJGKOQiqJ5F1Fe8Fiw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 09/13] lib/generic-radix-tree: Check sizeof(_type) when
 defining a tree.
Thread-Topic: [PATCH 09/13] lib/generic-radix-tree: Check sizeof(_type) when
 defining a tree.
Thread-Index: AdZ672a1FEFrjN29SvWEbOsXPPX6cQ==
Date:   Tue, 25 Aug 2020 14:52:50 +0000
Message-ID: <9ddf843612ea429682b68d5747bd93d8@AcuMS.aculab.com>
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

Move the check for the structure type being larger than PAGE_SIZE from every
use to the definition of a tree.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/generic-radix-tree.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index bfd00320c7f3..53149bc1b92a 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -64,12 +64,14 @@ struct __genradix {
  * to it for casts/sizeof - we also force the alignment so that storing a type
  * with a ridiculous alignment doesn't blow up the alignment or size of the
  * genradix.
+ *
+ * Generates a compile-time error if the item is too large.
  */
 
 #define GENRADIX(_type)						\
 struct {							\
 	struct __genradix	tree;				\
-	_type			type[0] __aligned(1);		\
+	_type type[sizeof (_type) <= PAGE_SIZE ? 0 : -1] __aligned(1);	\
 }
 
 #define DEFINE_GENRADIX(_name, _type)				\
@@ -98,11 +100,6 @@ void __genradix_free(struct __genradix *);
 
 static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
 {
-	if (__builtin_constant_p(obj_size))
-		BUILD_BUG_ON(obj_size > PAGE_SIZE);
-	else
-		BUG_ON(obj_size > PAGE_SIZE);
-
 	if (!is_power_of_2(obj_size)) {
 		size_t objs_per_page = PAGE_SIZE / obj_size;
 
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

