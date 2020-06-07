Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC771F100F
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFGVvM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 17:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGVvM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 17:51:12 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E586C08C5C3
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 14:51:12 -0700 (PDT)
Received: from [IPv6:2a02:8109:1140:c3d:1505:a962:b027:778f] (unknown [IPv6:2a02:8109:1140:c3d:1505:a962:b027:778f])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 7D343721E280D;
        Sun,  7 Jun 2020 23:51:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: packed structures used in socket options
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <23a14b44bd5749a6b1b51150c7f3c8ba@AcuMS.aculab.com>
Date:   Sun, 7 Jun 2020 23:51:06 +0200
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F68C9FD5-2F94-4782-9EFF-9EA1153EBE3E@lurchi.franken.de>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
 <ec8c26c792ea414dbe50bda45725d26f@AcuMS.aculab.com>
 <7B4E2F06-8FF9-4C45-8F7D-8C24028C70EF@lurchi.franken.de>
 <e67c3c6e7d634138a4e71e0e768922c6@AcuMS.aculab.com>
 <B69695A1-F45B-4375-B9BB-1E50D1550C6D@lurchi.franken.de>
 <23a14b44bd5749a6b1b51150c7f3c8ba@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 7. Jun 2020, at 22:21, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Michael Tuexen
>> Sent: 07 June 2020 18:24
>>> On 7. Jun 2020, at 19:14, David Laight <David.Laight@ACULAB.COM> wrote:
>>> 
>>> From: Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
>>>> Sent: 07 June 2020 16:15
>>>>> On 7. Jun 2020, at 15:53, David Laight <David.Laight@ACULAB.COM> wrote:
>>>>> 
>>>>> From: Michael Tuexen
>>>>>> 
>>>>>> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
>>>>>> of packetdrill, which supports SCTP.
>>>>>> 
>>>>>> Here is why:
>>>>>> 
>>>>>> 
>>>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
>>>>>> .7
>>>>>> contains:
>>>>>> 
>>>>>> struct sctp_paddrparams {
>>>>>> 	sctp_assoc_t		spp_assoc_id;
>>>>>> 	struct sockaddr_storage	spp_address;
>>>>>> 	__u32			spp_hbinterval;
>>>>>> 	__u16			spp_pathmaxrxt;
>>>>>> 	__u32			spp_pathmtu;
>>>>>> 	__u32			spp_sackdelay;
>>>>>> 	__u32			spp_flags;
>>>>>> 	__u32			spp_ipv6_flowlabel;
>>>>>> 	__u8			spp_dscp;
>>>>>> } __attribute__((packed, aligned(4)));
>>>>>> 
>>>>>> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
>>>>>> Why is it packed?
>>>>> 
>>>>> I'm guessing 'to remove holes to avoid leaking kernel data'.
>>>>> 
>>>>> The sctp socket api defines loads of structures that will have
>>>>> holes in them if not packed.
>>>> 
>>>> Hi David,
>>>> I agree that they have holes and we should have done better. The
>>>> kernel definitely should also not leak kernel data. However, the
>>>> way to handle this shouldn't be packing. I guess it is too late
>>>> to change this?
>>> 
>>> Probably too late.
>>> I've no idea how it got through the standards body either.
>>> In fact, the standard may actually require the holes.
>> 
>> No, it does not. Avoiding holes was not taken into account.
> 
> It depends on whether the rfc that describes the sockops says
> the structures 'look like this' or 'contain the following members'.
It uses "is defined as"... Using "contain the following members" 
would have been a better way. But is wasn't used. So yes, we could
have minimised the number of holes. But also other structure have
them. So when passing them from kernel land to user land one has
to zero out the padding. Not optimal, but doable.
> 
>> It should have been, but this was missed. Authors of all
>> kernel implementation (FreeBSD, Linux, and Solaris) were involved.
> 
> Sounds like none of the right people even looked at it.
Possible. At least the implementers were and it is an open process.
However, the rfc does not tell you to use packed structures.
So if you would follow the rfc, deal with the holes (which is
suboptimal, but doable), everything would be fine.
> 
>>>> This means the corresponding fields can only be accessed via
>>>> memcpy() or one needs to tolerate unaligned access. Dealing with
>>>> warnings is one thing, but do you know if Linux supports
>>>> unaligned access on all platforms it supports (I'm not familiar
>>>> with enough with Linux)?
>>> 
>>> The compiler will generate loads shifts and ors to access misaligned
>>> data on architectures like sparc where the hardware (quite reasonably)
>>> doesn't allow them.
>>> The code is horrid and you don't want to do it if it is avoidable.
>>> But it is better that taking a fault and then emulating it.
>> 
>> OK, so there is no functional problem on Linux. The code will run
>> slower, but it will work. At some time using FreeBSD on arm, you would
>> read interesting values and on Sparc with Solaris you would get a core.
> 
> Only if you try taking the addresses of the members.
> If you access the structure members the compiler will avoid
> faults on all architectures.
Ahh, OK. Thanks for the clarification.
> 
> One problem with using 'packed' is that some applications may
> use their own copies of the structures (even though they probably
> shouldn't).
> In that case the kernel will pull out the wrong fields.
Sure, if the kernel and userland don't agree on the structure,
that is a bad thing.
> 
>> This means developers have to use  -Wno-address-of-packed-member when
>> compiling a program on Linux.
> 
> I think that will only DTRT if the architecture handles misaligned
> accesses (or the kernel emulates them).
> 
> Or don't write code that takes the addresses of the structure members.
> The compiler warning is there for a purpose.
Sure. The point is that I wasn't expecting the structures to be packed,
since this is not specified in the rfc, not done in FreeBSD and Solaris.
And I do not see a reason for it (holes should be handled differently).
But I should have read the header file to be sure...

Best regards
Michael
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

