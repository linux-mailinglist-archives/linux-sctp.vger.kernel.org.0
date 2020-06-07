Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7D1F0D46
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFGROo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 13:14:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33450 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbgFGROo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 13:14:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-156-T9pAPNgENpOREH5O2MOHKA-1; Sun, 07 Jun 2020 18:14:37 +0100
X-MC-Unique: T9pAPNgENpOREH5O2MOHKA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 7 Jun 2020 18:14:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 7 Jun 2020 18:14:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Tuexen' <Michael.Tuexen@lurchi.franken.de>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: packed structures used in socket options
Thread-Topic: packed structures used in socket options
Thread-Index: AQHWPLpUTq2nADe9c02l9PzEMhJDA6jNLBzwgAAGoICAAC9ugA==
Date:   Sun, 7 Jun 2020 17:14:36 +0000
Message-ID: <e67c3c6e7d634138a4e71e0e768922c6@AcuMS.aculab.com>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
 <ec8c26c792ea414dbe50bda45725d26f@AcuMS.aculab.com>
 <7B4E2F06-8FF9-4C45-8F7D-8C24028C70EF@lurchi.franken.de>
In-Reply-To: <7B4E2F06-8FF9-4C45-8F7D-8C24028C70EF@lurchi.franken.de>
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

From: Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
> Sent: 07 June 2020 16:15
> > On 7. Jun 2020, at 15:53, David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > From: Michael Tuexen
> >>
> >> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
> >> of packetdrill, which supports SCTP.
> >>
> >> Here is why:
> >>
> >>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
> >> .7
> >> contains:
> >>
> >> struct sctp_paddrparams {
> >> 	sctp_assoc_t		spp_assoc_id;
> >> 	struct sockaddr_storage	spp_address;
> >> 	__u32			spp_hbinterval;
> >> 	__u16			spp_pathmaxrxt;
> >> 	__u32			spp_pathmtu;
> >> 	__u32			spp_sackdelay;
> >> 	__u32			spp_flags;
> >> 	__u32			spp_ipv6_flowlabel;
> >> 	__u8			spp_dscp;
> >> } __attribute__((packed, aligned(4)));
> >>
> >> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
> >> Why is it packed?
> >
> > I'm guessing 'to remove holes to avoid leaking kernel data'.
> >
> > The sctp socket api defines loads of structures that will have
> > holes in them if not packed.
>
> Hi David,
> I agree that they have holes and we should have done better. The
> kernel definitely should also not leak kernel data. However, the
> way to handle this shouldn't be packing. I guess it is too late
> to change this?

Probably too late.
I've no idea how it got through the standards body either.
In fact, the standard may actually require the holes.

>  This means the corresponding fields can only be accessed via
> memcpy() or one needs to tolerate unaligned access. Dealing with
> warnings is one thing, but do you know if Linux supports
> unaligned access on all platforms it supports (I'm not familiar
> with enough with Linux)?

The compiler will generate loads shifts and ors to access misaligned
data on architectures like sparc where the hardware (quite reasonably)
doesn't allow them.
The code is horrid and you don't want to do it if it is avoidable.
But it is better that taking a fault and then emulating it.
That really shouldn't have even been allowed to happen.

I do remember a classic statement in a header from AT&T.
'All the fields are declared 'long' to ensure the same alignment
on all machines.'
AT&T had a protocol that passed the structure between machines
(without allowing for endianness).
I think it was SGI that did a 64bit interface using 'long'.
The TOG standard allowed the implementation to pick a type.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

