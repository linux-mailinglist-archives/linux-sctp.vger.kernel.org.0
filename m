Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF2251B5E
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYOxL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:53:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:60353 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbgHYOxJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:53:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-71-L3-xON11PtOLEe4CqjcDXQ-1; Tue, 25 Aug 2020 15:53:05 +0100
X-MC-Unique: L3-xON11PtOLEe4CqjcDXQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:53:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:53:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 03/13] lib/generic-radix-tree: Always use low 8 bits of 'root'
 for depth.
Thread-Topic: [PATCH 03/13] lib/generic-radix-tree: Always use low 8 bits of
 'root' for depth.
Thread-Index: AdZ67sMOiNwc769vS+ykdMxOWsTznA==
Date:   Tue, 25 Aug 2020 14:53:04 +0000
Message-ID: <c91557f439854e4997e807a5215d4763@AcuMS.aculab.com>
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

There is no need to calculate the minimum number of bits needed for the
depth (stored in the low bits of the pointer to the root).
Since the root is PAGE_SIZE aligned and we can't need more than 64bits
just use the low 8 bits for the depth.
This (probably) generates better code on x86 then using (say) 6 bits.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index d5e97b51308d..12dcaf891af9 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -30,12 +30,15 @@ static inline size_t genradix_depth_size(unsigned depth)
 	return 1UL << genradix_depth_shift(depth);
 }
 
-/* depth that's needed for a genradix that can address up to ULONG_MAX: */
-#define GENRADIX_MAX_DEPTH	\
-	DIV_ROUND_UP(BITS_PER_LONG - PAGE_SHIFT, GENRADIX_ARY_SHIFT)
-
-#define GENRADIX_DEPTH_MASK				\
-	((unsigned long) (roundup_pow_of_two(GENRADIX_MAX_DEPTH + 1) - 1))
+/*
+ * The 'depth' of the tree is held in the low bits of the 'root'.
+ * Since all the buffers are allocated as pages lots of low bits are zero.
+ * To support a genradix that can address up to ULONG_MAX items the
+ * maximum depth/shift we can possibly need is 64.
+ * However using the low 8 bits for the depth may give better code
+ * on some archectures (eg x86).
+ */
+#define GENRADIX_DEPTH_MASK 0xff
 
 static inline unsigned genradix_root_to_depth(struct genradix_root *r)
 {
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

