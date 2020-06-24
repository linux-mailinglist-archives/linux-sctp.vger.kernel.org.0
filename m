Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB27A206FDC
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2020 11:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbgFXJSP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Wed, 24 Jun 2020 05:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388655AbgFXJSP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jun 2020 05:18:15 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DB3C061573;
        Wed, 24 Jun 2020 02:18:15 -0700 (PDT)
Received: from mb.fritz.box (ip4d15f5fc.dynamic.kabel-deutschland.de [77.21.245.252])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 1C1F37220B819;
        Wed, 24 Jun 2020 11:18:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Strange problem with SCTP+IPv6
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <CADvbK_cXsS7_kYifCqMRcedtNgG0hNmgrf33+hkkjmK7xjAP=A@mail.gmail.com>
Date:   Wed, 24 Jun 2020 11:18:09 +0200
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Corey Minyard <minyard@acm.org>,
        David Laight <David.Laight@aculab.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6EA67F12-F19A-4C60-A652-B08C78A36CBA@lurchi.franken.de>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
 <20200623161756.GE3235@minyard.net>
 <20200623212143.GR2491@localhost.localdomain>
 <C4F6EDBE-CCAE-4635-AD96-9C2E2582F1B3@lurchi.franken.de>
 <20200623213102.GS2491@localhost.localdomain>
 <42823598-7B01-4C62-B896-ACC4449F3AFF@lurchi.franken.de>
 <CADvbK_cXsS7_kYifCqMRcedtNgG0hNmgrf33+hkkjmK7xjAP=A@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 24. Jun 2020, at 09:25, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Wed, Jun 24, 2020 at 5:48 AM Michael Tuexen
> <michael.tuexen@lurchi.franken.de> wrote:
>> 
>>> On 23. Jun 2020, at 23:31, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
>>> 
>>> On Tue, Jun 23, 2020 at 11:24:59PM +0200, Michael Tuexen wrote:
>>>>> On 23. Jun 2020, at 23:21, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
>>>>> 
>>>>> On Tue, Jun 23, 2020 at 11:17:56AM -0500, Corey Minyard wrote:
>>>>>> On Tue, Jun 23, 2020 at 01:17:28PM +0000, David Laight wrote:
>>>>>>> From: Marcelo Ricardo Leitner
>>>>>>>> Sent: 22 June 2020 19:33
>>>>>>>> On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
>>>>>>>>>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
>>>>>>>>>> 
>>>>>>>>>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
>>>>>>>>>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
>>>>>>>>>>>> 
>>>>>>>>>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
>>>>>>>>>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
>>>>>>>>>>>> then I make a connection to it using ::1, the connection will drop after
>>>>>>>>>>>> 2.5 seconds with an ECONNRESET error.
>>>>>>>>>>>> 
>>>>>>>>>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
>>>>>>>>>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
>>>>>>>>>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
>>>>>>>>>>>> I tried on an ARM system and x86_64.
>>>>>>>>>>>> 
>>>>>>>>>>>> I haven't dug into the kernel to see if I could find anything yet, but I
>>>>>>>>>>>> thought I would go ahead and report it.  I am attaching a reproducer.
>>>>>>>>>>>> Basically, compile the following code:
>>>>>>>>>>> The code only set IPV6_V6ONLY on server side, so the client side will
>>>>>>>>>>> still bind all the local ipv4 addresses (as you didn't call bind() to
>>>>>>>>>>> bind any specific addresses ). Then after the connection is created,
>>>>>>>>>>> the client will send HB on the v4 paths to the server. The server
>>>>>>>>>>> will abort the connection, as it can't support v4.
>>>>>>>>>>> 
>>>>>>>>>>> So you can work around it by either:
>>>>>>>>>>> 
>>>>>>>>>>> - set IPV6_V6ONLY on client side.
>>>>>>>>>>> 
>>>>>>>>>>> or
>>>>>>>>>>> 
>>>>>>>>>>> - bind to the specific v6 addresses on the client side.
>>>>>>>>>>> 
>>>>>>>>>>> I don't see RFC said something about this.
>>>>>>>>>>> So it may not be a good idea to change the current behaviour
>>>>>>>>>>> to not establish the connection in this case, which may cause regression.
>>>>>>>>>> 
>>>>>>>>>> Ok, I understand this.  It's a little strange, but I see why it works
>>>>>>>>>> this way.
>>>>>>>>> I don't. I would expect it to work as I described in my email.
>>>>>>>>> Could someone explain me how and why it is behaving different from
>>>>>>>>> my expectation?
>>>>>>>> 
>>>>>>>> It looks like a bug to me. Testing with this test app here, I can see
>>>>>>>> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
>>>>>>>> that's unexpected for a v6only socket. As is, it's the server saying
>>>>>>>> "I'm available at these other addresses too, but not."
>>>>>>> 
>>>>>>> Does it even make sense to mix IPv4 and IPv6 addresses on the same
>>>>>>> connection?
>>>>>>> I don't remember ever seeing both types of address in a message,
>>>>>>> but may not have looked.
>>>>>> 
>>>>>> That's an interesting question.  Do the RFCs say anything?  I would
>>>>>> assume it was ok unless ipv6only was set.
>>>>>> 
>>>>>>> 
>>>>>>> I also wonder whether the connection should be dropped for an error
>>>>>>> response on a path that has never been validated.
>>>>>> 
>>>>>> That actually bothered me a bit more.  Shouldn't it stay up if any path
>>>>>> is up?  That's kind of the whole point of multihoming.
>>>>> 
>>>>> Michael explained it on the other email. What he described is what I
>>>>> observed in my tests.
>>>>> 
>>>>>> 
>>>>>>> 
>>>>>>> OTOH the whole 'multi-homing' part of SCTP sucks.
>>>>>> 
>>>>>> I don't think so.
>>>>>> 
>>>>>>> The IP addresses a server needs to bind to depend on where the
>>>>>>> incoming connection will come from.
>>>>>>> A local connection may be able to use a 192.168.x.x address
>>>>>>> but a remote connection must not - as it may be defined locally
>>>>>>> at the remote system.
>>>>>>> But both connections can come into the public (routable) address.
>>>>>>> We have to tell customers to explicitly configure the local IP
>>>>>>> addresses - which means the application has to know what they are.
>>>>>>> Fortunately these apps are pretty static - usually M3UA.
>>>>>> 
>>>>>> Umm, no,  If you have a private address, it better be behind a firewall,
>>>>>> and the firewall should handle rewriting the packet to fix the addresses.
>>>>>> 
>>>>>> It doesn't appear that Linux netfilter does this.  There is a TODO in
>>>>>> the code for this.  But that's how it *should* work.
>>>>> 
>>>>> Right, we don't support SCTP aware NAT [1].
>>>>> 
>>>>> 1.https://tools.ietf.org/html/draft-stewart-behave-sctpnat-04
>>>> The current version is: https://tools.ietf.org/html/draft-ietf-tsvwg-natsupp-16
>>> 
>>> Thanks!
>>> 
>>>> 
>>>> Another possibility for NAT traversal is UDP encapsulation...
>>> 
>>> Also not supported.. :-]
>> But maybe someone wants to implement it. It is supported by FreeBSD, if you
>> need a peer for testing. Or the userland stack usrsctp supports it. Then you
>> do not need root privileges to run it.
> You mean SCTP_REMOTE_UDP_ENCAPS_PORT sockopt, right?
> We have this in our to-do list. I mixed rfc6951 with the userland one.
> Will prioritize this feature. Thanks.
Great to hear. When implementing RFC 6951 support, please take
https://tools.ietf.org/html/draft-tuexen-tsvwg-sctp-udp-encaps-cons-02
into account. It is still valid and will be pushed further after RFC 4960bis
is done.

Best regards
Michael
> 
>> 
>> Best regards
>> Michael
>>> 
>>> Best regards,
>>> Marcelo
>>> 
>>>> 
>>>> Best regards
>>>> Michael
>>>>> 
>>>>> Marcelo
>>>>> 
>>>>>> 
>>>>>> -corey
>>>>>> 
>>>>>>> 
>>>>>>>  David
>>>>>>> 
>>>>>>> -
>>>>>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>>>>>>> Registration No: 1397386 (Wales)
>>>>>>> 
>>>> 
>> 

