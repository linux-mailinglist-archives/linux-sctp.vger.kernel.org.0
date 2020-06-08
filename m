Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41AC1F12B0
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Jun 2020 08:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFHGN4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 8 Jun 2020 02:13:56 -0400
Received: from mail.fink.org ([79.134.252.20]:36670 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHGN4 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 8 Jun 2020 02:13:56 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 8 Jun 2020 08:13:31 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: EAGAIN
From:   Andreas Fink <afink@list.fink.org>
In-Reply-To: <FE53A090-3927-427E-813B-B197B9833F66@lurchi.franken.de>
Date:   Mon, 8 Jun 2020 08:13:31 +0200
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B35C6E8E-7AB4-40FA-ADE9-FDD5B5C8D0FE@list.fink.org>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
 <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
 <021ba1317114431290cc2aae12a4ee64@AcuMS.aculab.com>
 <5F3CF6C8-1FE3-48C5-8E6C-2EC35E0E2FBF@lurchi.franken.de>
 <cbdc4f6694a5417e9f40083b7778bbdf@AcuMS.aculab.com>
 <FE53A090-3927-427E-813B-B197B9833F66@lurchi.franken.de>
To:     Michael Tuexen <michael.tuexen@lurchi.franken.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



> On 7 Jun 2020, at 19:31, Michael Tuexen <michael.tuexen@lurchi.franken.de> wrote:
> 
> 
> 
>> On 7. Jun 2020, at 19:05, David Laight <David.Laight@ACULAB.COM> wrote:
>> 
>> From: Michael Tuexen
>>> Sent: 07 June 2020 16:18
>>>> On 7. Jun 2020, at 16:04, David Laight <David.Laight@ACULAB.COM> wrote:
>>>> 
>>>> From: Michael Tuexen
>>>>> Sent: 07 June 2020 13:48
>>>> ...
>>>>> If you killed the peer, I would assume that there is an SCTP message containing an
>>>>> ABORT chunk in the wire. Is that true? If that is true, you could subscribe to
>>>>> SCTP_ASSOC_CHANGE notification, which should tell you.
>>>> 
>>>> Actually for TCP-style 1-1 connections you must subscribe to
>>>> SCTP_ASSOC_CHANGE.
>>> 
>>> I guess you are referring to UDP (1-to-many) style sockets.
>>> For 1-to-1 style sockets, the normal error handling should
>>> work, like it does for TCP (returning -1 in a system call
>>> and errno being ETIMEDOUT or ECONNRESET). At least this is
>>> the way intended by the specification and I think Linux
>>> does it that way.
>> 
>> Nope, if you take a program that will run over TCP or SCTP
>> then receipt of an INIT chunk (with matching ports etc)
>> goes through the connection handshake sequence and the
>> application isn't given any indication.
> Right. But once the association is established and you
> subscribed the SCTP_ASSOC_CHANGE on the listener, the listener
> should become readable, then you call accept() and the accepted
> socket should become readable, because you can read a SCTP_ASSOC_CHANGE.
>> 
>> You might expect the incoming INIT to cause a disconnect
>> indication on the old socket and a new 'listen' event. 
> No, I don't expect that.
>> But that isn't what happens.
> I'm not sure if you are talking about a restart event. That would
> actually be given (after the handshake) in an SCTP_ASSOC_CHANGE event.
> 
> But Andreas is using a 1-to-many style socket. Assume he is constantly sending
> to a peer. I would assume that an sctp_sendv() call triggers the sending
> of an INIT, an ABORT comes back, you clear all buffered data for that
> association and the next sctp_sendv() would trigger the sending of the next INIT.
> So he should observe a lot of sctp_sendv() failing, but some of them
> should succeed. Andreas are you seeing such a pattern? How does it look on the wire?

I have to reproduce this in my lab to get a trace.

As far as I remember we ended up having the server side trying to send old data while the client side tries to establish a new connection and gets association up while the old side has no trace of this new connection. I definitively catch all SCTP_ASSOC_CHANGE events but I did not process it until after the send loop sending one single packet.
The connections are nailed down ones. Meaning the sender uses the same source port to connect. I guess this might be important to know.

I currently worked around the issue by breaking my sendloop if we get assoc change (which is read in a different thread) or when EAGAIN is received more than 100 times in a row.
I will try to simulate this with a small test programm to see how it looks on the wire.




