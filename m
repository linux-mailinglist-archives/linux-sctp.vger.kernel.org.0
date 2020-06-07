Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0851F0B81
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 15:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgFGNqM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 09:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFGNqM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 09:46:12 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C3C08C5C3
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 06:46:11 -0700 (PDT)
Received: from [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e] (unknown [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id DF70F7220B810;
        Sun,  7 Jun 2020 15:46:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: EAGAIN
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <71776413-9870-4F91-A3BF-A3A322991428@list.fink.org>
Date:   Sun, 7 Jun 2020 15:46:04 +0200
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5B9B0EF5-653B-4AFD-99B0-41D94D480956@lurchi.franken.de>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
 <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
 <71776413-9870-4F91-A3BF-A3A322991428@list.fink.org>
To:     Andreas Fink <afink@list.fink.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 7. Jun 2020, at 14:59, Andreas Fink <afink@list.fink.org> wrote:
> 
> 
> 
>> On 7 Jun 2020, at 14:47, Michael Tuexen <Michael.Tuexen@lurchi.franken.de> wrote:
>> 
>>> On 7. Jun 2020, at 14:18, Andreas Fink <afink@list.fink.org> wrote:
>>> 
>>> Hello folks,
>>> 
>>> I run into a strange issue with SCTP under Linux and I'm not sure whats the right approach to fix this.
>>> 
>>> I have a listener thread which listens on a port for multiple inbound connections
>>> I have a sender thread which sends packets to peers by using the same socket and doing a sctp_sendv call.
>>> Sockets are always in non blocking mode.
>> So a single SOCK_SEQPACKET socket for sending and receiving, right?
> 
> correct
> 
>>> 
>>> When the remote side gets stopped (process killed),  the sctp_sendv starts returning 0 and errno is set to EAGAIN and we constantly retry.
>> When it returns 0, you can't look at errno. errno is only set to a correct value, if -1 is returned.
> 
> 
> I actually check if return value is > 0. So probably -1 applies here. Returning 0 doesnt make any sense anyway.
> 
>> 
>> If you killed the peer, I would assume that there is an SCTP message containing an
>> ABORT chunk in the wire. Is that true?
> 
> I can not currently verify that. But we have seen this happening when the remote application (which uses the same mechanism) got killed or has crashed.
> So the operating system's sctp driver should have sent ABORT I believe. We noticed that when the remote application restarts, it can not reestablish the connection somehow, probably because the main application is still busy looping sending old data in the queue.
> 
> 
>> If that is true, you could subscribe to
>> SCTP_ASSOC_CHANGE notification, which should tell you.
> 
> 
> I am subscribed to SCTP_ASSOC_CHANGE but I didnt catch anything there.
> (or I catched it in the receiver thread and the sender thread is not checking the new status in its tight sending loop)
OK.
> 
> My question is, what is the exact meaning of EAGAIN here? Does it mean that the send buffer is full?
My answer is not specific to the Linux implementation, since I don't know it. But EAGAIN is signalled,
if a request can't be fulfilled right now, but might work at some later time. Just hammering
on it in a busy loop might not be the best idea.
If you would use SOCK_STREAM socket (1-to-1), I would suggest to use select/poll to check
for writability.

So I'm wondering if the following actually works, maybe you can test it:
1. Let an association be up. Use a one-to-many style socket.
2. Call continuously sctp_sendv().
3. Kill the peer and restart it.
4. Does the association gets killed?
5. Does a new association gets established triggered by the sctp_sendv() calls?

In addition: What happens if the association times out instead of being killed by an ABORT?

Best regards
Michael
> Why am I not getting a simple error because the specified assoc is down?
> 
> 

