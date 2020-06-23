Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE889205847
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWRKC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 23 Jun 2020 13:10:02 -0400
Received: from mail-n.franken.de ([193.175.24.27]:43943 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728916AbgFWRKC (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 23 Jun 2020 13:10:02 -0400
Received: from mb.fritz.box (ip4d15f5fc.dynamic.kabel-deutschland.de [77.21.245.252])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 0117A7220B819;
        Tue, 23 Jun 2020 19:09:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Strange problem with SCTP+IPv6
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
Date:   Tue, 23 Jun 2020 19:09:57 +0200
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "minyard@acm.org" <minyard@acm.org>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E5BF4DC9-7DC7-4057-8449-16F4BB49E233@lurchi.franken.de>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 23. Jun 2020, at 15:17, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Marcelo Ricardo Leitner
>> Sent: 22 June 2020 19:33
>> On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
>>>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
>>>> 
>>>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
>>>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
>>>>>> 
>>>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
>>>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
>>>>>> then I make a connection to it using ::1, the connection will drop after
>>>>>> 2.5 seconds with an ECONNRESET error.
>>>>>> 
>>>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
>>>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
>>>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
>>>>>> I tried on an ARM system and x86_64.
>>>>>> 
>>>>>> I haven't dug into the kernel to see if I could find anything yet, but I
>>>>>> thought I would go ahead and report it.  I am attaching a reproducer.
>>>>>> Basically, compile the following code:
>>>>> The code only set IPV6_V6ONLY on server side, so the client side will
>>>>> still bind all the local ipv4 addresses (as you didn't call bind() to
>>>>> bind any specific addresses ). Then after the connection is created,
>>>>> the client will send HB on the v4 paths to the server. The server
>>>>> will abort the connection, as it can't support v4.
>>>>> 
>>>>> So you can work around it by either:
>>>>> 
>>>>> - set IPV6_V6ONLY on client side.
>>>>> 
>>>>> or
>>>>> 
>>>>> - bind to the specific v6 addresses on the client side.
>>>>> 
>>>>> I don't see RFC said something about this.
>>>>> So it may not be a good idea to change the current behaviour
>>>>> to not establish the connection in this case, which may cause regression.
>>>> 
>>>> Ok, I understand this.  It's a little strange, but I see why it works
>>>> this way.
>>> I don't. I would expect it to work as I described in my email.
>>> Could someone explain me how and why it is behaving different from
>>> my expectation?
>> 
>> It looks like a bug to me. Testing with this test app here, I can see
>> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
>> that's unexpected for a v6only socket. As is, it's the server saying
>> "I'm available at these other addresses too, but not."
> 
> Does it even make sense to mix IPv4 and IPv6 addresses on the same
> connection?
Sure, if you have an IPv6 socket, which has not enabled the IPV6ONLY
socket option.
> I don't remember ever seeing both types of address in a message,
> but may not have looked.
> 
> I also wonder whether the connection should be dropped for an error
> response on a path that has never been validated.
Assuming that it is not an ERROR chunk which comes back, but an ABORT,
this should happen as long as the verification tag is OK.
> 
> OTOH the whole 'multi-homing' part of SCTP sucks.
> The IP addresses a server needs to bind to depend on where the
> incoming connection will come from.
Not sure what this means. The application can bind a wildcard
address or a specific subset. However, when an INIT comes in,
the INIT-ACK might contain only a subset of there due to
scoping.
> A local connection may be able to use a 192.168.x.x address
> but a remote connection must not - as it may be defined locally
> at the remote system.
Yepp. Not sure what you can do about it.
> But both connections can come into the public (routable) address.
> We have to tell customers to explicitly configure the local IP
> addresses - which means the application has to know what they are.
> Fortunately these apps are pretty static - usually M3UA.
Please note that in SIGRTRAN scenarios you normally not have NATs
involved as you have usually in setups used at home.

Best regards
Michael
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

