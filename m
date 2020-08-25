Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C5B251CC3
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHYQAm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 25 Aug 2020 12:00:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22551 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbgHYQAl (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Aug 2020 12:00:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-VyA49XegPAea4GryLbHbxw-1; Tue, 25 Aug 2020 17:00:36 +0100
X-MC-Unique: VyA49XegPAea4GryLbHbxw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 25 Aug 2020 17:00:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Aug 2020 17:00:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        'Neil Horman' <nhorman@tuxdriver.com>
Subject: RE: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Thread-Topic: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Thread-Index: AdZ67b0yl7qlbV/xQHyOe3+CAeHrEgAABLWAAAIsYaA=
Date:   Tue, 25 Aug 2020 16:00:35 +0000
Message-ID: <17da427b99b444ce9d310d6542ae197e@AcuMS.aculab.com>
References: <21289d79b0474811b21ed8478c465159@AcuMS.aculab.com>
 <20200825154127.GB2444@localhost.localdomain>
In-Reply-To: <20200825154127.GB2444@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
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
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: 'Marcelo Ricardo Leitner'
> Sent: 25 August 2020 16:41
> 
> On Tue, Aug 25, 2020 at 02:52:34PM +0000, David Laight wrote:
> > The genradix code is used by SCTP for accessing per-stream data.
> > This means there are quite a lot of lookups but the code wasn't
> > really optimised at all.
> 
> My test box is down for the moment and will bring it on later today or
> tomorrow, so I can't test it yet. What should we expect as performance
> gains here?

Not sure, probably not much, but it ought to show up :-)
There'll be bigger gains on a cpu that has software ilog2().

I've only checked SCTP still works.
I've requested 32k streams on a listener - to force a level-2 tree.
I've also done at least one check with a massive pad in the sctp
stream structure.

I ought to check one of my M3UA or M2PA 'double-reflect' loopback tests.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

