Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CC251B5A
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHYOxC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:53:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21571 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgHYOw4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:52:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-7-_XvlfVdZOXe9OgmpDD8wmA-3;
 Tue, 25 Aug 2020 15:52:48 +0100
X-MC-Unique: _XvlfVdZOXe9OgmpDD8wmA-3
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 10/13] lib/generic-radix-tree: Simplify offset calculation:
Thread-Topic: [PATCH 10/13] lib/generic-radix-tree: Simplify offset
 calculation:
Thread-Index: AdZ672R+peJB3QHpRkKEQyAm6F6LmA==
Date:   Tue, 25 Aug 2020 14:52:47 +0000
Message-ID: <bc04c6adae56428c9e247b0506da5f25@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Since these are equivalent:
    (idx / objs_per_page) * PAGE_SIZE + (idx % objs_per_page) * obj_size;
    idx * obj_size + (idx / objs_per_page) * (PAGE_SIZE % obj_size);
Use the latter since it is slightly faster.
It also deosn't need an extra check for obj_size being a power of 2.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/generic-radix-tree.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 53149bc1b92a..5fe1c4c5588d 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -100,14 +100,9 @@ void __genradix_free(struct __genradix *);
 
 static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
 {
-	if (!is_power_of_2(obj_size)) {
-		size_t objs_per_page = PAGE_SIZE / obj_size;
+	size_t objs_per_page = PAGE_SIZE / obj_size;
 
-		return (idx / objs_per_page) * PAGE_SIZE +
-			(idx % objs_per_page) * obj_size;
-	} else {
-		return idx * obj_size;
-	}
+	return idx * obj_size + (idx / objs_per_page) * (PAGE_SIZE % obj_size);
 }
 
 #define __genradix_cast(_radix)		(typeof((_radix)->type[0]) *)
-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

