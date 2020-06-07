Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707761F1014
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 23:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFGVzc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFGVzc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 17:55:32 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C2C08C5C3
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 14:55:32 -0700 (PDT)
Received: from mb.fritz.box (ip4d1600c4.dynamic.kabel-deutschland.de [77.22.0.196])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id C4D0D721E280D;
        Sun,  7 Jun 2020 23:55:28 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: packed structures used in socket options
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <2213135.ChUyxVVRYb@isjsys>
Date:   Sun, 7 Jun 2020 23:55:27 +0200
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BC353F4B-8C3A-476E-B00F-B8D8F61174BA@lurchi.franken.de>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
 <B69695A1-F45B-4375-B9BB-1E50D1550C6D@lurchi.franken.de>
 <23a14b44bd5749a6b1b51150c7f3c8ba@AcuMS.aculab.com>
 <2213135.ChUyxVVRYb@isjsys>
To:     =?utf-8?Q?Ivan_Skytte_J=C3=B8rgensen?= <isj-sctp@i1.dk>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 7. Jun 2020, at 23:35, Ivan Skytte Jørgensen <isj-sctp@i1.dk> wrote:
> 
> On Sunday, 7 June 2020 22:21:41 CEST you wrote:
>> From: Michael Tuexen
>>> Sent: 07 June 2020 18:24
>>>> On 7. Jun 2020, at 19:14, David Laight <David.Laight@ACULAB.COM> wrote:
>>>> 
>>>> From: Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
>>>>> Sent: 07 June 2020 16:15
>>>>>> On 7. Jun 2020, at 15:53, David Laight <David.Laight@ACULAB.COM> wrote:
>>>>>> 
>>>>>> From: Michael Tuexen
>>>>>>> 
>>>>>>> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
>>>>>>> of packetdrill, which supports SCTP.
>>>>>>> 
>>>>>>> Here is why:
>>>>>>> 
>>>>>>> 
>>>>> 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
>>>>>>> .7
>>>>>>> contains:
>>>>>>> 
>>>>>>> struct sctp_paddrparams {
>>>>>>> 	sctp_assoc_t		spp_assoc_id;
>>>>>>> 	struct sockaddr_storage	spp_address;
>>>>>>> 	__u32			spp_hbinterval;
>>>>>>> 	__u16			spp_pathmaxrxt;
>>>>>>> 	__u32			spp_pathmtu;
>>>>>>> 	__u32			spp_sackdelay;
>>>>>>> 	__u32			spp_flags;
>>>>>>> 	__u32			spp_ipv6_flowlabel;
>>>>>>> 	__u8			spp_dscp;
>>>>>>> } __attribute__((packed, aligned(4)));
>>>>>>> 
>>>>>>> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
>>>>>>> Why is it packed?
>>>>>> 
>>>>>> I'm guessing 'to remove holes to avoid leaking kernel data'.
>>>>>> 
>>>>>> The sctp socket api defines loads of structures that will have
>>>>>> holes in them if not packed.
>>>>> 
>>>>> Hi David,
>>>>> I agree that they have holes and we should have done better. The
>>>>> kernel definitely should also not leak kernel data. However, the
>>>>> way to handle this shouldn't be packing. I guess it is too late
>>>>> to change this?
>>>> 
>>>> Probably too late.
>>>> I've no idea how it got through the standards body either.
>>>> In fact, the standard may actually require the holes.
>>> 
>>> No, it does not. Avoiding holes was not taken into account.
>> 
>> It depends on whether the rfc that describes the sockops says
>> the structures 'look like this' or 'contain the following members'.
>> 
>>> It should have been, but this was missed. Authors of all
>>> kernel implementation (FreeBSD, Linux, and Solaris) were involved.
>> 
>> Sounds like none of the right people even looked at it.
> 
> I was involved. At that time (September 2005) the SCTP API was still evolving (first finalized in 2011), and one of the major users of the API was 32-bit programs running on 64-bit kernel (on powerpc as I recall). When we realized that the structures were different between 32bit and 64bit we had to break the least number of programs, and the result were those ((packed)) structs so 32-bit programs wouldn't be broken and we didn't need a xxx_compat translation layer in the kernel.
Ahh, I see. Thanks for the explanation.
> 
> I don't have access to TSVWG mailing list archive that far back but I found I wrote this summary here:
> 
> On Sunday, 25 September 2005 21:36:05 CEST Ivan Skytte Jørgensen wrote:
>> I followed the discussion in tsvwg mailing list. My interpretation of the few 
>> answers is that this is a "quality of implementation issue" and that padding 
>> fields are allowed but won't get into the RFC because it is an implementation 
>> issue.
> 
> 
> So RFC6458 allows padding but doesn't list them.
Yepp, that is my understanding (being a co-author).
> 
> 
> Incidentally, at that time (and perhaps still) sockaddr_storage had different alignement between 32-bit programs and 64-bit programs, and the multicast structures used in setsockopt() (group_req, group_source_req and  group_filter) had/has the same problem.
If I remember it correctly, I tested (FreeBSD) stuff on Little Endian, Big Endian, 32-bit, 64-bit, but not
run one binary on another platform.

Best regards
Michael
> 
> 
> /isj
> 
> 
> 

