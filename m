Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93137251B99
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHYO5z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:57:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41459 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgHYOwk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:52:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-229-XTGr5FjFOiOuMkOxNdlKew-1; Tue, 25 Aug 2020 15:52:36 +0100
X-MC-Unique: XTGr5FjFOiOuMkOxNdlKew-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 07/13] lib/generic-radix-tree: Optimise __genradix_iter_peek()
Thread-Topic: [PATCH 07/13] lib/generic-radix-tree: Optimise
 __genradix_iter_peek()
Thread-Index: AdZ67z36LdYIWMqoTRCrizJoKBNmVA==
Date:   Tue, 25 Aug 2020 14:52:35 +0000
Message-ID: <d606b3e29ec3407f98d4deb20bc29662@AcuMS.aculab.com>
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

Use the the 'shift' rather than the 'level'.
NB There are exactly zero users of this code.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 219b43250a06..0df99ee428d8 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -22,14 +22,6 @@ static inline int genradix_depth_shift(unsigned depth)
 	return PAGE_SHIFT + GENRADIX_ARY_SHIFT * depth;
 }
 
-/*
- * Returns size (of data, in bytes) that a tree of a given depth holds:
- */
-static inline size_t genradix_depth_size(unsigned depth)
-{
-	return 1UL << genradix_depth_shift(depth);
-}
-
 /*
  * The 'depth' of the tree is held in the low bits of the 'root'.
  * Since all the buffers are allocated as pages lots of low bits are zero.
@@ -209,7 +201,7 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 {
 	struct genradix_root *r;
 	struct genradix_node *n;
-	unsigned level, i;
+	unsigned int shift, level, i;
 restart:
 	r = READ_ONCE(radix->root);
 	if (!r)
@@ -217,21 +209,21 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 
 	n	= genradix_root_to_node(r);
 	level	= genradix_root_to_depth(r);
+	shift = genradix_depth_shift(level);
 
-	if (iter->offset >> genradix_depth_shift(level))
+	if (iter->offset >> shift)
 		return NULL;
 
-	while (level) {
-		level--;
+	while (shift > GENRADIX_ARY_SHIFT) {
+		shift -= GENRADIX_ARY_SHIFT;
 
-		i = (iter->offset >> genradix_depth_shift(level)) &
-			(GENRADIX_ARY - 1);
+		i = (iter->offset >> shift) % GENRADIX_ARY;
 
 		while (!n->children[i]) {
 			i++;
 			iter->offset = round_down(iter->offset +
-					   genradix_depth_size(level),
-					   genradix_depth_size(level));
+					   (1u << shift),
+					   1u << shift);
 			iter->pos = (iter->offset >> PAGE_SHIFT) *
 				objs_per_page;
 			if (i == GENRADIX_ARY)
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

