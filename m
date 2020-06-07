Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891571F0D53
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFGRXh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 13:23:37 -0400
Received: from mail-n.franken.de ([193.175.24.27]:43119 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgFGRXh (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 7 Jun 2020 13:23:37 -0400
Received: from mb.fritz.box (ip4d1600c4.dynamic.kabel-deutschland.de [77.22.0.196])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 4821E7220B820;
        Sun,  7 Jun 2020 19:23:32 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: packed structures used in socket options
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <e67c3c6e7d634138a4e71e0e768922c6@AcuMS.aculab.com>
Date:   Sun, 7 Jun 2020 19:23:30 +0200
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B69695A1-F45B-4375-B9BB-1E50D1550C6D@lurchi.franken.de>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
 <ec8c26c792ea414dbe50bda45725d26f@AcuMS.aculab.com>
 <7B4E2F06-8FF9-4C45-8F7D-8C24028C70EF@lurchi.franken.de>
 <e67c3c6e7d634138a4e71e0e768922c6@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 7. Jun 2020, at 19:14, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
>> Sent: 07 June 2020 16:15
>>> On 7. Jun 2020, at 15:53, David Laight <David.Laight@ACULAB.COM> wrote:
>>> 
>>> From: Michael Tuexen
>>>> 
>>>> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
>>>> of packetdrill, which supports SCTP.
>>>> 
>>>> Here is why:
>>>> 
>>>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
>>>> .7
>>>> contains:
>>>> 
>>>> struct sctp_paddrparams {
>>>> 	sctp_assoc_t		spp_assoc_id;
>>>> 	struct sockaddr_storage	spp_address;
>>>> 	__u32			spp_hbinterval;
>>>> 	__u16			spp_pathmaxrxt;
>>>> 	__u32			spp_pathmtu;
>>>> 	__u32			spp_sackdelay;
>>>> 	__u32			spp_flags;
>>>> 	__u32			spp_ipv6_flowlabel;
>>>> 	__u8			spp_dscp;
>>>> } __attribute__((packed, aligned(4)));
>>>> 
>>>> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
>>>> Why is it packed?
>>> 
>>> I'm guessing 'to remove holes to avoid leaking kernel data'.
>>> 
>>> The sctp socket api defines loads of structures that will have
>>> holes in them if not packed.
>> 
>> Hi David,
>> I agree that they have holes and we should have done better. The
>> kernel definitely should also not leak kernel data. However, the
>> way to handle this shouldn't be packing. I guess it is too late
>> to change this?
> 
> Probably too late.
> I've no idea how it got through the standards body either.
> In fact, the standard may actually require the holes.
No, it does not. Avoiding holes was not taken into account.
It should have been, but this was missed. Authors of all
kernel implementation (FreeBSD, Linux, and Solaris) were involved.
> 
>> This means the corresponding fields can only be accessed via
>> memcpy() or one needs to tolerate unaligned access. Dealing with
>> warnings is one thing, but do you know if Linux supports
>> unaligned access on all platforms it supports (I'm not familiar
>> with enough with Linux)?
> 
> The compiler will generate loads shifts and ors to access misaligned
> data on architectures like sparc where the hardware (quite reasonably)
> doesn't allow them.
> The code is horrid and you don't want to do it if it is avoidable.
> But it is better that taking a fault and then emulating it.
OK, so there is no functional problem on Linux. The code will run
slower, but it will work. At some time using FreeBSD on arm, you would
read interesting values and on Sparc with Solaris you would get a core.

This means developers have to use  -Wno-address-of-packed-member when
compiling a program on Linux.

Best regards
Michael
> That really shouldn't have even been allowed to happen.
> 
> I do remember a classic statement in a header from AT&T.
> 'All the fields are declared 'long' to ensure the same alignment
> on all machines.'
> AT&T had a protocol that passed the structure between machines
> (without allowing for endianness).
> I think it was SGI that did a 64bit interface using 'long'.
> The TOG standard allowed the implementation to pick a type.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

