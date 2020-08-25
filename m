Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E266A251B54
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYOwj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 10:52:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:43212 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgHYOwj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 10:52:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-163-BWui7J3WNwSfPV_ZLU2-Dg-1; Tue, 25 Aug 2020 15:52:35 +0100
X-MC-Unique: BWui7J3WNwSfPV_ZLU2-Dg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 15:52:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 15:52:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "'Neil Horman'" <nhorman@tuxdriver.com>
Subject: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Thread-Topic: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Thread-Index: AdZ67b0yl7qlbV/xQHyOe3+CAeHrEg==
Date:   Tue, 25 Aug 2020 14:52:34 +0000
Message-ID: <21289d79b0474811b21ed8478c465159@AcuMS.aculab.com>
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

The genradix code is used by SCTP for accessing per-stream data.
This means there are quite a lot of lookups but the code wasn't
really optimised at all.

Patch 1 fixes a rather nasty bug that could cause all sorts of oddities
including having a loop in a tree.
Fortunately the only 2 users of the genradix code in the kernel source
tree and neither can possibly hit the bug.

Patches 2 through 11 all reduce codepath. Especially for the common
case (for both users) where all the data fits in one page.

Patch 12 inlines the common lookup function for 1 page trees.
This also remove the '% constant' calcuation from the lookups.
However it will increase code size (but not codepath) because
of the number of callers.

Patch 13 removes part of the optimisation for 1 page tress
under the assumption that the lookup will have been inlined.
The code still works even if inlining didn't happen.

David Laight (13):
    01/13: Fix potentially corrupt tree
    02/13: Optimise out ilog2(variable).
    03/13: Always use low 8 bits of 'root' for depth.
    04/13: Optimise __genradix_ptr()
    05/13: Optimise __genradix_ptr_alloc()
    06/13: Rename gfp_mask to gfp to shorten lines.
    07/13: Optimise __genradix_iter_peek()
    08/13: Save number of bits to shift instead of tree level.
    09/13: Check sizeof(_type) when defining a tree.
    10/13: Simplify offset calculation:
    11/13: Pass the root pointer to __genradix_ptr.
    12/13: Inline genradix_ptr() for simple trees.
    13/13: Simplify __genradix_ptr()

 include/linux/generic-radix-tree.h |  54 ++++---
 lib/generic-radix-tree.c           | 224 ++++++++++++++++-------------
 2 files changed, 162 insertions(+), 116 deletions(-)

-- 
2.25.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

