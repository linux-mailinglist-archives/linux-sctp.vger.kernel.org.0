Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C7173B17
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2020 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgB1PMu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 28 Feb 2020 10:12:50 -0500
Received: from mail-n.franken.de ([193.175.24.27]:33881 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbgB1PMu (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 28 Feb 2020 10:12:50 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2020 10:12:49 EST
Received: from [IPv6:2a02:8109:1140:c3d:d27:d546:be49:ed77] (unknown [IPv6:2a02:8109:1140:c3d:d27:d546:be49:ed77])
        (Authenticated sender: lurchi)
        by drew.franken.de (Postfix) with ESMTPSA id 57325721E280D;
        Fri, 28 Feb 2020 16:03:38 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Problems with peeled-off sockets
From:   Michael Tuexen <michael.tuexen@lurchi.franken.de>
In-Reply-To: <CADvbK_dh1GjDmso9vfHmLEvYhgx3cQ1ajNjafAyyx6hz04_KTg@mail.gmail.com>
Date:   Fri, 28 Feb 2020 16:03:37 +0100
Cc:     "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B0B70C1F-50C0-40E6-B59F-19CA67682C6E@lurchi.franken.de>
References: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com>
 <HE1PR0702MB361028B4B8C2E4D03AA23B4EECEC0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_f=COyrHh+17pdBq=acmR+cbv08quK6qbpHCg7FbwTsNw@mail.gmail.com>
 <HE1PR0702MB3610F8DFB115DA9D35D71A76ECEB0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_dh1GjDmso9vfHmLEvYhgx3cQ1ajNjafAyyx6hz04_KTg@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 28. Feb 2020, at 15:31, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Fri, Feb 28, 2020 at 9:57 PM Leppanen, Jere (Nokia - FI/Espoo)
> <jere.leppanen@nokia.com> wrote:
>> 
>> On Thu, 27 Feb 2020, Xin Long wrote:
>> 
>>> On Tue, Feb 25, 2020 at 3:28 AM Leppanen, Jere (Nokia - FI/Espoo)
>>> <jere.leppanen@nokia.com> wrote:
>>>> 
>>>> On Sat, 22 Feb 2020, Xin Long wrote:
>>>> 
>>>>> On Thu, Feb 20, 2020 at 5:18 PM Leppanen, Jere (Nokia - FI/Espoo)
>>>>> <jere.leppanen@nokia.com> wrote:
>>>>>> 
>>>>>> Hello All,
>>>>>> 
>>>>>> According to the RFC, a peeled-off socket is a one-to-one socket. But
>>>>>> in lksctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDTH
>>>>>> style. Because of this, shutdown() doesn't work, linger probably
>>>>>> doesn't work, and so on.
>>>>>> 
>>>>>> For example, in sctp_shutdown():
>>>>>> 
>>>>>> static void sctp_shutdown(struct sock *sk, int how)
>>>>>> {
>>>>>>        struct net *net = sock_net(sk);
>>>>>>        struct sctp_endpoint *ep;
>>>>>> 
>>>>>>        if (!sctp_style(sk, TCP))
>>>>>>                return;
>>>>>> 
>>>>>> Here we just bail out, because a peeled-off socket is not TCP style.
>>>>>> 
>>>>>> Is this just a bug, or am I missing something? Asking mostly out of
>>>>>> personal curiosity.
>>>>> I would say, it's because .shutdown is tcp_prot thing and udp_prot doesn't
>>>>> have. sctp doesn't have to implement it for UDP style socket. But for TCP-
>>>>> style socket, sctp is trying to be compatible with TCP protocol user API.
>>>>> But even though,  sctp's .shutdown is still not fully compatible with TCP
>>>>> protocol due to sctp's 3-way shakehands for finishing a connection.
>>>> 
>>>> Thanks a bunch for replying, Xin Long. I'm not quite sure what you mean.
>>>> The actual association shutdown doesn't even come into play here, since
>>>> shutdown() doesn't do anything with peeled-off sockets.
>>> Hi,  Leppanen,
>>> sorry for late.
>>> 
>>> SCTP has two types of sockets: UDP and TCP styles.
>>> TCP style associations are not allowed to be peeled off.
>>> only UDP style associations can be peeled off.
>>> 
>>> Then shutdown can only work for TCP style, this explains
>>> why peeled-off sk can use shutdown.
>>> 
>>> 
>>>> 
>>>> If you mean that the current implementation of shutdown() might have
>>>> some problems with peeled-off sockets; well, that's true, but I suppose
>>>> that means that there's something to fix somewhere.
>>> I think it returns for peeled-off sockets (UDP style sockets) on purpose.
>>> it's like why you want to use shutdown on a UDP socket?
>>> 
>>>> 
>>>> It looks like the reason for the peculiar socket style of peeled-off
>>>> sockets is that they're created by copying from a one-to-many socket and
>>>> modified a little to resemble a one-to-one socket. But this leads to
>>>> problems in several places in the code. Is this just implementation that
>>>> was never finalized?
>>> Right, peeled-off will allow users to use a new sk to control that asoc.
>>> but again, it's a feature UDP style socket.
>>> any other problems have you seen?
>> 
>> To clarify, by "peeled-off socket" I mean a socket returned by
>> sctp_peeloff(). sctp_peeloff() takes as an argument a
>> one-to-many socket, and returns a one-to-one socket.
>> 
>> The RFC (https://tools.ietf.org/html/rfc6458#section-9.2)
>> clearly states about the socket returned by sctp_peeloff() that
>> "[...] the new socket is a one-to-one style socket."
> OK, I got you now.
> Linux creates a TCP/one-to-many style socket there actually.
> Interesting, BSD seems to do the same.
> I will double check and make a patch for this once confirmed.
I would expect that the socket returned by sctp_peeloff() is
a one-to-one style socket and behave like one. If BSD is not
like this, it is a bug and I would like to know.

Best regards
Michael
> 
> Thanks.

