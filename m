Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245081F0F85
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFGUVq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 16:21:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53149 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbgFGUVq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 16:21:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-114-falapY6nNU-QXRDhXOLrIw-1; Sun, 07 Jun 2020 21:21:42 +0100
X-MC-Unique: falapY6nNU-QXRDhXOLrIw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 7 Jun 2020 21:21:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 7 Jun 2020 21:21:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Tuexen' <Michael.Tuexen@lurchi.franken.de>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: packed structures used in socket options
Thread-Topic: packed structures used in socket options
Thread-Index: AQHWPLpUTq2nADe9c02l9PzEMhJDA6jNLBzwgAAGoICAAC9ugP//9FcAgABAGeA=
Date:   Sun, 7 Jun 2020 20:21:41 +0000
Message-ID: <23a14b44bd5749a6b1b51150c7f3c8ba@AcuMS.aculab.com>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
 <ec8c26c792ea414dbe50bda45725d26f@AcuMS.aculab.com>
 <7B4E2F06-8FF9-4C45-8F7D-8C24028C70EF@lurchi.franken.de>
 <e67c3c6e7d634138a4e71e0e768922c6@AcuMS.aculab.com>
 <B69695A1-F45B-4375-B9BB-1E50D1550C6D@lurchi.franken.de>
In-Reply-To: <B69695A1-F45B-4375-B9BB-1E50D1550C6D@lurchi.franken.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Michael Tuexen
> Sent: 07 June 2020 18:24
> > On 7. Jun 2020, at 19:14, David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > From: Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
> >> Sent: 07 June 2020 16:15
> >>> On 7. Jun 2020, at 15:53, David Laight <David.Laight@ACULAB.COM> wrote:
> >>>
> >>> From: Michael Tuexen
> >>>>
> >>>> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
> >>>> of packetdrill, which supports SCTP.
> >>>>
> >>>> Here is why:
> >>>>
> >>>>
> >>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
> >>>> .7
> >>>> contains:
> >>>>
> >>>> struct sctp_paddrparams {
> >>>> 	sctp_assoc_t		spp_assoc_id;
> >>>> 	struct sockaddr_storage	spp_address;
> >>>> 	__u32			spp_hbinterval;
> >>>> 	__u16			spp_pathmaxrxt;
> >>>> 	__u32			spp_pathmtu;
> >>>> 	__u32			spp_sackdelay;
> >>>> 	__u32			spp_flags;
> >>>> 	__u32			spp_ipv6_flowlabel;
> >>>> 	__u8			spp_dscp;
> >>>> } __attribute__((packed, aligned(4)));
> >>>>
> >>>> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
> >>>> Why is it packed?
> >>>
> >>> I'm guessing 'to remove holes to avoid leaking kernel data'.
> >>>
> >>> The sctp socket api defines loads of structures that will have
> >>> holes in them if not packed.
> >>
> >> Hi David,
> >> I agree that they have holes and we should have done better. The
> >> kernel definitely should also not leak kernel data. However, the
> >> way to handle this shouldn't be packing. I guess it is too late
> >> to change this?
> >
> > Probably too late.
> > I've no idea how it got through the standards body either.
> > In fact, the standard may actually require the holes.
>
> No, it does not. Avoiding holes was not taken into account.

It depends on whether the rfc that describes the sockops says
the structures 'look like this' or 'contain the following members'.

> It should have been, but this was missed. Authors of all
> kernel implementation (FreeBSD, Linux, and Solaris) were involved.

Sounds like none of the right people even looked at it.

> >> This means the corresponding fields can only be accessed via
> >> memcpy() or one needs to tolerate unaligned access. Dealing with
> >> warnings is one thing, but do you know if Linux supports
> >> unaligned access on all platforms it supports (I'm not familiar
> >> with enough with Linux)?
> >
> > The compiler will generate loads shifts and ors to access misaligned
> > data on architectures like sparc where the hardware (quite reasonably)
> > doesn't allow them.
> > The code is horrid and you don't want to do it if it is avoidable.
> > But it is better that taking a fault and then emulating it.
>
> OK, so there is no functional problem on Linux. The code will run
> slower, but it will work. At some time using FreeBSD on arm, you would
> read interesting values and on Sparc with Solaris you would get a core.

Only if you try taking the addresses of the members.
If you access the structure members the compiler will avoid
faults on all architectures.

One problem with using 'packed' is that some applications may
use their own copies of the structures (even though they probably
shouldn't).
In that case the kernel will pull out the wrong fields.

> This means developers have to use  -Wno-address-of-packed-member when
> compiling a program on Linux.

I think that will only DTRT if the architecture handles misaligned
accesses (or the kernel emulates them).

Or don't write code that takes the addresses of the structure members.
The compiler warning is there for a purpose.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

