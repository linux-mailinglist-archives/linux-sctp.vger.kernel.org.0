Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7236251B56
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHYOws convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:52:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25647 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgHYOwn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:52:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-79-zk8xmwPXOHmEFa64UqMB8Q-1; Tue, 25 Aug 2020 15:52:40 +0100
X-MC-Unique: zk8xmwPXOHmEFa64UqMB8Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 13/13] lib/generic-radix-tree: Simplify __genradix_ptr()
Thread-Topic: [PATCH 13/13] lib/generic-radix-tree: Simplify __genradix_ptr()
Thread-Index: AdZ6719rWD9U8XgbSzKIbUgnCK1q2w==
Date:   Tue, 25 Aug 2020 14:52:38 +0000
Message-ID: <35b7ab36369249d8bf17a04f58a0f337@AcuMS.aculab.com>
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

Now that requests for small trees are inlined there is no need
to aggressively optimise for them in __genradix_ptr().

Signed-off-by: David Laight <david.laight@aculab.com>
---
 lib/generic-radix-tree.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 7029a14eed97..497ac5effda0 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -45,9 +45,6 @@ void *__genradix_ptr(struct genradix_root *r, size_t offset)
 	unsigned int shift = __genradix_root_to_shift(r);
 	unsigned int idx;
 
-	if (likely(shift == GENRADIX_ROOT_SHIFT))
-		return offset < PAGE_SIZE ? n->data + offset : NULL;
-
 	if (unlikely(!shift))
 		return NULL;
 
@@ -56,13 +53,13 @@ void *__genradix_ptr(struct genradix_root *r, size_t offset)
 		return NULL;
 
 	for (;;) {
+		if (likely(shift == GENRADIX_ROOT_SHIFT))
+			return n->data + (offset % PAGE_SIZE);
+
 		n = READ_ONCE(n->children[idx]);
 		if (unlikely(!n))
 			return NULL;
 
-		if (shift == PAGE_SHIFT)
-			return n->data + (offset % PAGE_SIZE);
-
 		shift -= GENRADIX_ARY_SHIFT;
 		idx = (offset >> shift) % GENRADIX_ARY;
 	}
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

