Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7D1F0B36
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgFGNAD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 09:00:03 -0400
Received: from mail.fink.org ([79.134.252.20]:38906 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgFGNAD (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 7 Jun 2020 09:00:03 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sun, 7 Jun 2020 14:59:46 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: EAGAIN
From:   Andreas Fink <afink@list.fink.org>
In-Reply-To: <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
Date:   Sun, 7 Jun 2020 14:59:45 +0200
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <71776413-9870-4F91-A3BF-A3A322991428@list.fink.org>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
 <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
To:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



> On 7 Jun 2020, at 14:47, Michael Tuexen <Michael.Tuexen@lurchi.franken.de> wrote:
> 
>> On 7. Jun 2020, at 14:18, Andreas Fink <afink@list.fink.org> wrote:
>> 
>> Hello folks,
>> 
>> I run into a strange issue with SCTP under Linux and I'm not sure whats the right approach to fix this.
>> 
>> I have a listener thread which listens on a port for multiple inbound connections
>> I have a sender thread which sends packets to peers by using the same socket and doing a sctp_sendv call.
>> Sockets are always in non blocking mode.
> So a single SOCK_SEQPACKET socket for sending and receiving, right?

correct

>> 
>> When the remote side gets stopped (process killed),  the sctp_sendv starts returning 0 and errno is set to EAGAIN and we constantly retry.
> When it returns 0, you can't look at errno. errno is only set to a correct value, if -1 is returned.


I actually check if return value is > 0. So probably -1 applies here. Returning 0 doesnt make any sense anyway.

> 
> If you killed the peer, I would assume that there is an SCTP message containing an
> ABORT chunk in the wire. Is that true?

I can not currently verify that. But we have seen this happening when the remote application (which uses the same mechanism) got killed or has crashed.
So the operating system's sctp driver should have sent ABORT I believe. We noticed that when the remote application restarts, it can not reestablish the connection somehow, probably because the main application is still busy looping sending old data in the queue.


> If that is true, you could subscribe to
> SCTP_ASSOC_CHANGE notification, which should tell you.


I am subscribed to SCTP_ASSOC_CHANGE but I didnt catch anything there.
(or I catched it in the receiver thread and the sender thread is not checking the new status in its tight sending loop)

My question is, what is the exact meaning of EAGAIN here? Does it mean that the send buffer is full?
Why am I not getting a simple error because the specified assoc is down?


