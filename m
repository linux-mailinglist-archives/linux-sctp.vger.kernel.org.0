Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4038247653
	for <lists+linux-sctp@lfdr.de>; Sun, 16 Jun 2019 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfFPSRZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 16 Jun 2019 14:17:25 -0400
Received: from mail-n.franken.de ([193.175.24.27]:58610 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfFPSRZ (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 16 Jun 2019 14:17:25 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jun 2019 14:17:24 EDT
Received: from [IPv6:2a02:8109:1140:c3d:3d9d:31bf:dad0:3571] (unknown [IPv6:2a02:8109:1140:c3d:3d9d:31bf:dad0:3571])
        (Authenticated sender: lurchi)
        by drew.franken.de (Postfix) with ESMTPSA id 07407721E2828;
        Sun, 16 Jun 2019 20:11:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: sctp_sendmsg does not accept flags
From:   Michael Tuexen <michael.tuexen@lurchi.franken.de>
In-Reply-To: <CAPkQJpRMFuF=hYyVNAcfzhkzaVAUwnsSfMW7KGffsa=c1tkirw@mail.gmail.com>
Date:   Sun, 16 Jun 2019 20:11:05 +0200
Cc:     Linux SCTP <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FEC710C5-2407-422E-AF8C-A85483646EDE@lurchi.franken.de>
References: <e863ee11-9e1f-71b9-1f61-b4b71d9f0945@elstel.org>
 <CAPkQJpRMFuF=hYyVNAcfzhkzaVAUwnsSfMW7KGffsa=c1tkirw@mail.gmail.com>
To:     malc <mlashley@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 16. Jun 2019, at 19:56, malc <mlashley@gmail.com> wrote:
> 
> I think you want 'man 3 sctp_sendmsg' [1] and one of the flags
> supported there... namely SCTP_UNORDERED. SCTP_ADDR_OVER, SCTP_ABORT,
> SCTP_EOF
> See also [2] which I'm guessing is relevant to what you're /trying/ to achieve.
Using MSG_NOSIGNAL is definitely not what should be usedin this context,
but the first question is:
If the user provides an invalid flag, does this result in sctp_sendmsg() to
return -1 and errno to be set to EINVAL?
The more relevant question is:
Assume sendmsg() returns -1. Shouldn't then no message be sent out?
This send call is atomic.
So I would expect
* either no error is indicated and the message is accepted by the kernel
* or an error is indicated and the message is not accepted by the kernel.
Do we agree on this? Does the linux implementation follows this rule?

Best regards
Michael
> 
> Cheers,
> malc.
> 
> [1] https://linux.die.net/man/3/sctp_sendmsg
> [2] https://sourceforge.net/p/lksctp/mailman/message/11557899/
> 
> 
> On Sun, Jun 16, 2019 at 2:40 PM Elmar Stellnberger <estellnb@elstel.org> wrote:
>> 
>>    While sctp_send works well at me, sctp_sendmsg gives me an EINVAL as
>> soon as I pass in some flags. Nonetheless it still sends the message in
>> spite of returning the EINVAL. That looks like an error to me. Please
>> investigate the issue.
>> 
>> while( len > 0 && ( ( ret = sctp_sendmsg( sid, bufp, len, NULL, 0, 0,
>> MSG_NOSIGNAL, (0), 1000, 0 ) ) >= 0 || ( ret==-1 && ( errno == EINTR ||
>> errno == ENOBUFS ) ) ) ) {  // returns EINVAL if flags are passed
>>     if( ret >= 0 ) { bufp += ret; len -= ret; } else if( errno ==
>> ENOBUFS ) { struct timespec ts; ts.tv_sec=0; ts.tv_nsec=10000;
>> nanosleep(&ts,NULL); } }
>> if( ret == -1 ) perror ("error sending request to stream #(0)");
>> 
>>   If you should be interested I can send the whole sctp test client
>> program.
>> 
>> 
>> 
>> 
>> 
>> 

