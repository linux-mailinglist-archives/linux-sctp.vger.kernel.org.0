Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAEE1F0D60
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 19:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFGRbw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgFGRbw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 13:31:52 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DBC08C5C3
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 10:31:51 -0700 (PDT)
Received: from [IPv6:2a02:8109:1140:c3d:1505:a962:b027:778f] (unknown [IPv6:2a02:8109:1140:c3d:1505:a962:b027:778f])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 5FD5E7220B820;
        Sun,  7 Jun 2020 19:31:45 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: EAGAIN
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <cbdc4f6694a5417e9f40083b7778bbdf@AcuMS.aculab.com>
Date:   Sun, 7 Jun 2020 19:31:44 +0200
Cc:     Andreas Fink <afink@list.fink.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FE53A090-3927-427E-813B-B197B9833F66@lurchi.franken.de>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
 <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
 <021ba1317114431290cc2aae12a4ee64@AcuMS.aculab.com>
 <5F3CF6C8-1FE3-48C5-8E6C-2EC35E0E2FBF@lurchi.franken.de>
 <cbdc4f6694a5417e9f40083b7778bbdf@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



> On 7. Jun 2020, at 19:05, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Michael Tuexen
>> Sent: 07 June 2020 16:18
>>> On 7. Jun 2020, at 16:04, David Laight <David.Laight@ACULAB.COM> wrote:
>>> 
>>> From: Michael Tuexen
>>>> Sent: 07 June 2020 13:48
>>> ...
>>>> If you killed the peer, I would assume that there is an SCTP message containing an
>>>> ABORT chunk in the wire. Is that true? If that is true, you could subscribe to
>>>> SCTP_ASSOC_CHANGE notification, which should tell you.
>>> 
>>> Actually for TCP-style 1-1 connections you must subscribe to
>>> SCTP_ASSOC_CHANGE.
>> 
>> I guess you are referring to UDP (1-to-many) style sockets.
>> For 1-to-1 style sockets, the normal error handling should
>> work, like it does for TCP (returning -1 in a system call
>> and errno being ETIMEDOUT or ECONNRESET). At least this is
>> the way intended by the specification and I think Linux
>> does it that way.
> 
> Nope, if you take a program that will run over TCP or SCTP
> then receipt of an INIT chunk (with matching ports etc)
> goes through the connection handshake sequence and the
> application isn't given any indication.
Right. But once the association is established and you
subscribed the SCTP_ASSOC_CHANGE on the listener, the listener
should become readable, then you call accept() and the accepted
socket should become readable, because you can read a SCTP_ASSOC_CHANGE.
> 
> You might expect the incoming INIT to cause a disconnect
> indication on the old socket and a new 'listen' event. 
No, I don't expect that.
> But that isn't what happens.
I'm not sure if you are talking about a restart event. That would
actually be given (after the handshake) in an SCTP_ASSOC_CHANGE event.

But Andreas is using a 1-to-many style socket. Assume he is constantly sending
to a peer. I would assume that an sctp_sendv() call triggers the sending
of an INIT, an ABORT comes back, you clear all buffered data for that
association and the next sctp_sendv() would trigger the sending of the next INIT.
So he should observe a lot of sctp_sendv() failing, but some of them
should succeed. Andreas are you seeing such a pattern? How does it look on the wire?

Best regards
Michael 
> 
> We have to enable the ASSPC_CHANGE indication - and disconnect
> in response to it!
> 
> No idea what the standard implies should happen.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

