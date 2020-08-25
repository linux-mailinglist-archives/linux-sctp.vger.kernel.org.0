Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91415251B5C
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgHYOxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:53:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41816 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbgHYOxG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-47vdrNzgP36-UycG-3cNjw-1; Tue, 25 Aug 2020 15:53:00 +0100
X-MC-Unique: 47vdrNzgP36-UycG-3cNjw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 05/13] lib/generic-radix-tree: Optimise __genradix_ptr_alloc()
Thread-Topic: [PATCH 05/13] lib/generic-radix-tree: Optimise
 __genradix_ptr_alloc()
Thread-Index: AdZ67sMku/ljxmRrQsK68AYlrafjuQ==
Date:   Tue, 25 Aug 2020 14:52:59 +0000
Message-ID: <3313cca9b8a64ef0a192fc1a5562fb1c@AcuMS.aculab.com>
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

Take the code that allocates an new page and inserts it in the tree
out of line. It is uncommon (and already expensive).

Optimise for the common case where the entire tree fits in one page.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 111 ++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 37 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 212e04cf171a..b378e10c8fa4 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -108,6 +108,35 @@ static inline void genradix_free_node(struct genradix_node *node)
 	free_page((unsigned long)node);
 }
 
+static noinline struct genradix_node *
+alloc_node(struct genradix_node **tgt, struct genradix_node *old,
+	    struct genradix_node *child, unsigned int level, gfp_t gfp_mask)
+{
+	struct genradix_node *n = genradix_alloc_node(gfp_mask);
+	struct genradix_node *new_node, *check;
+
+	if (!n)
+		return NULL;
+	n->children[0] = child;
+
+	/* The 'root' address is 'overpunched' with the level */
+	new_node = (void *)((unsigned long)n + level);
+
+	check = cmpxchg_release(tgt, old, new_node);
+	if (check == old)
+		return new_node;
+
+	genradix_free_node(n);
+	return check;
+}
+
+static struct genradix_root *
+alloc_root(struct genradix_root **tgt, struct genradix_root *old,
+	    struct genradix_node *child, unsigned int level, gfp_t gfp_mask)
+{
+	return (void *)alloc_node((void *)tgt, (void *)old, child, level, gfp_mask);
+}
+
 /*
  * Returns pointer to the specified byte @offset within @radix, allocating it if
  * necessary - newly allocated slots are always zeroed out:
@@ -115,55 +144,63 @@ static inline void genradix_free_node(struct genradix_node *node)
 void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 			   gfp_t gfp_mask)
 {
-	struct genradix_root *v = READ_ONCE(radix->root);
-	struct genradix_node *n, *new_node;
-	unsigned level;
+	struct genradix_node *n, *n1;
+	struct genradix_root *r;
+	unsigned int level, shift;
+	unsigned int idx;
 
-	/* Increase tree depth if necessary: */
-	while (1) {
-		struct genradix_root *r = v, *new_root;
+	r = READ_ONCE(radix->root);
+	level = genradix_root_to_depth(r);
+
+	/* Optimise non-tree structures */
+	if (likely(!level) && likely(offset < PAGE_SIZE)) {
+		n = genradix_root_to_node(r);
+		if (likely(n))
+			return n->data + offset;
+		r = alloc_root(&radix->root, NULL, NULL, 0, gfp_mask);
+		if (!r)
+			return NULL;
+		level = genradix_root_to_depth(r);
+		if (!level) {
+			n = genradix_root_to_node(r);
+			return n->data + offset;
+		}
+	}
 
-		n	= genradix_root_to_node(r);
-		level	= genradix_root_to_depth(r);
+	/* Ensure tree is deep enough */
+	for (;;) {
+		n = genradix_root_to_node(r);
+		shift = genradix_depth_shift(level) - GENRADIX_ARY_SHIFT;
+		idx = offset >> shift;
 
-		if (n && !(offset >> genradix_depth_shift(level)))
+		if (likely(idx < GENRADIX_ARY))
 			break;
 
-		new_node = genradix_alloc_node(gfp_mask);
-		if (!new_node)
+		/* Tree depth needs increasing */
+		r = alloc_root(&radix->root, r, n, level + 1, gfp_mask);
+		if (!r)
 			return NULL;
 
-		new_node->children[0] = n;
-		new_root = ((struct genradix_root *)
-			    ((unsigned long) new_node | (n ? level + 1 : 0)));
-
-		v = cmpxchg_release(&radix->root, r, new_root);
-		if (v == r)
-			v = new_root;
-		else
-			genradix_free_node(new_node);
+		/* Multiple levels could have been added by someone else. */
+		level = genradix_root_to_depth(r);
 	}
 
-	while (level--) {
-		struct genradix_node **p =
-			&n->children[offset >> genradix_depth_shift(level)];
-		offset &= genradix_depth_size(level) - 1;
-
-		n = READ_ONCE(*p);
-		if (!n) {
-			new_node = genradix_alloc_node(gfp_mask);
-			if (!new_node)
+	/* Descend the tree */
+	for (;;) {
+		n1 = READ_ONCE(n->children[idx]);
+		if (unlikely(!n1)) {
+			n1 = alloc_node(n->children + idx, NULL, NULL, 0, gfp_mask);
+			if (!n1)
 				return NULL;
-
-			n = cmpxchg_release(p, NULL, new_node);
-			if (!n)
-				n = new_node;
-			else
-				genradix_free_node(new_node);
 		}
-	}
 
-	return &n->data[offset];
+		n = n1;
+		if (shift == PAGE_SHIFT)
+			return n->data + (offset % PAGE_SIZE);
+
+		shift -= GENRADIX_ARY_SHIFT;
+		idx = (offset >> shift) % GENRADIX_ARY;
+	}
 }
 EXPORT_SYMBOL(__genradix_ptr_alloc);
 
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

