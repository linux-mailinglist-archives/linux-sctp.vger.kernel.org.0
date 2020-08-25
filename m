Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A50251B6E
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHYOyX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:54:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:37801 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726794AbgHYOxC (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-163-hVfUnaY-PSmsmFLTtVB4jQ-1; Tue, 25 Aug 2020 15:52:57 +0100
X-MC-Unique: hVfUnaY-PSmsmFLTtVB4jQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:56 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 06/13] lib/generic-radix-tree: Rename gfp_mask to gfp to
 shorten lines.
Thread-Topic: [PATCH 06/13] lib/generic-radix-tree: Rename gfp_mask to gfp to
 shorten lines.
Thread-Index: AdZ67nLEJ05Z5ukBSTyqWAXsBITR1A==
Date:   Tue, 25 Aug 2020 14:52:56 +0000
Message-ID: <00446927230e49bda61d1f50ee8d32e5@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Rename gfp_mask to gfp to shorten lines.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index b378e10c8fa4..219b43250a06 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -87,18 +87,18 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
 }
 EXPORT_SYMBOL(__genradix_ptr);
 
-static inline struct genradix_node *genradix_alloc_node(gfp_t gfp_mask)
+static inline struct genradix_node *genradix_alloc_node(gfp_t gfp)
 {
 	struct genradix_node *node;
 
-	node = (struct genradix_node *)__get_free_page(gfp_mask|__GFP_ZERO);
+	node = (struct genradix_node *)__get_free_page(gfp | __GFP_ZERO);
 
 	/*
 	 * We're using pages (not slab allocations) directly for kernel data
 	 * structures, so we need to explicitly inform kmemleak of them in order
 	 * to avoid false positive memory leak reports.
 	 */
-	kmemleak_alloc(node, PAGE_SIZE, 1, gfp_mask);
+	kmemleak_alloc(node, PAGE_SIZE, 1, gfp);
 	return node;
 }
 
@@ -110,9 +110,9 @@ static inline void genradix_free_node(struct genradix_node *node)
 
 static noinline struct genradix_node *
 alloc_node(struct genradix_node **tgt, struct genradix_node *old,
-	    struct genradix_node *child, unsigned int level, gfp_t gfp_mask)
+	    struct genradix_node *child, unsigned int level, gfp_t gfp)
 {
-	struct genradix_node *n = genradix_alloc_node(gfp_mask);
+	struct genradix_node *n = genradix_alloc_node(gfp);
 	struct genradix_node *new_node, *check;
 
 	if (!n)
@@ -132,17 +132,16 @@ alloc_node(struct genradix_node **tgt, struct genradix_node *old,
 
 static struct genradix_root *
 alloc_root(struct genradix_root **tgt, struct genradix_root *old,
-	    struct genradix_node *child, unsigned int level, gfp_t gfp_mask)
+	    struct genradix_node *child, unsigned int level, gfp_t gfp)
 {
-	return (void *)alloc_node((void *)tgt, (void *)old, child, level, gfp_mask);
+	return (void *)alloc_node((void *)tgt, (void *)old, child, level, gfp);
 }
 
 /*
  * Returns pointer to the specified byte @offset within @radix, allocating it if
  * necessary - newly allocated slots are always zeroed out:
  */
-void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
-			   gfp_t gfp_mask)
+void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset, gfp_t gfp)
 {
 	struct genradix_node *n, *n1;
 	struct genradix_root *r;
@@ -157,7 +156,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		n = genradix_root_to_node(r);
 		if (likely(n))
 			return n->data + offset;
-		r = alloc_root(&radix->root, NULL, NULL, 0, gfp_mask);
+		r = alloc_root(&radix->root, NULL, NULL, 0, gfp);
 		if (!r)
 			return NULL;
 		level = genradix_root_to_depth(r);
@@ -177,7 +176,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 			break;
 
 		/* Tree depth needs increasing */
-		r = alloc_root(&radix->root, r, n, level + 1, gfp_mask);
+		r = alloc_root(&radix->root, r, n, level + 1, gfp);
 		if (!r)
 			return NULL;
 
@@ -189,7 +188,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 	for (;;) {
 		n1 = READ_ONCE(n->children[idx]);
 		if (unlikely(!n1)) {
-			n1 = alloc_node(n->children + idx, NULL, NULL, 0, gfp_mask);
+			n1 = alloc_node(n->children + idx, NULL, NULL, 0, gfp);
 			if (!n1)
 				return NULL;
 		}
@@ -259,13 +258,12 @@ static void genradix_free_recurse(struct genradix_node *n, unsigned level)
 	genradix_free_node(n);
 }
 
-int __genradix_prealloc(struct __genradix *radix, size_t size,
-			gfp_t gfp_mask)
+int __genradix_prealloc(struct __genradix *radix, size_t size, gfp_t gfp)
 {
 	size_t offset;
 
 	for (offset = 0; offset < size; offset += PAGE_SIZE)
-		if (!__genradix_ptr_alloc(radix, offset, gfp_mask))
+		if (!__genradix_ptr_alloc(radix, offset, gfp))
 			return -ENOMEM;
 
 	return 0;
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

