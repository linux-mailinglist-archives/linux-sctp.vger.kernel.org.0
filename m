Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2991E251B58
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHYOw4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:52:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33219 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbgHYOwt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:52:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-7-5PqZYsFOPia8ypfsez1PdA-1;
 Tue, 25 Aug 2020 15:52:45 +0100
X-MC-Unique: 5PqZYsFOPia8ypfsez1PdA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:44 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 11/13] lib/generic-radix-tree: Pass the root pointer to
 __genradix_ptr.
Thread-Topic: [PATCH 11/13] lib/generic-radix-tree: Pass the root pointer to
 __genradix_ptr.
Thread-Index: AdZ672LQYo9E57zjRWuSGqe+jP0FNg==
Date:   Tue, 25 Aug 2020 14:52:44 +0000
Message-ID: <8edc9a8718b545e4aa2e6fd0e22288d6@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
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
Content-Language: en-US
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

It can't modify it, so no point passing the address of the pointer.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/generic-radix-tree.h | 4 ++--
 lib/generic-radix-tree.c           | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 5fe1c4c5588d..c486fb410855 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -110,7 +110,7 @@ static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
 #define __genradix_idx_to_offset(_radix, _idx)			\
 	__idx_to_offset(_idx, __genradix_obj_size(_radix))
 
-void *__genradix_ptr(struct __genradix *, size_t);
+void *__genradix_ptr(struct genradix_root *, size_t);
 
 /**
  * genradix_ptr - get a pointer to a genradix entry
@@ -121,7 +121,7 @@ void *__genradix_ptr(struct __genradix *, size_t);
  */
 #define genradix_ptr(_radix, _idx)				\
 	(__genradix_cast(_radix)				\
-	 __genradix_ptr(&(_radix)->tree,			\
+	 __genradix_ptr(READ_ONCE(_radix)->tree.root),			\
 			__genradix_idx_to_offset(_radix, _idx)))
 
 void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 363bcefae8aa..037a6456a17b 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -46,9 +46,8 @@ static inline struct genradix_node *genradix_root_to_node(struct genradix_root *
  * Returns pointer to the specified byte @offset within @radix, or NULL if not
  * allocated
  */
-void *__genradix_ptr(struct __genradix *radix, size_t offset)
+void *__genradix_ptr(struct genradix_root *r, size_t offset)
 {
-	struct genradix_root *r = READ_ONCE(radix->root);
 	struct genradix_node *n = genradix_root_to_node(r);
 	unsigned int shift = genradix_root_to_shift(r);
 	unsigned int idx;
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

