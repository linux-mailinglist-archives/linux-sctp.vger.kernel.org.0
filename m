Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1D175B96
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Mar 2020 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCBN2a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 2 Mar 2020 08:28:30 -0500
Received: from mail-n.franken.de ([193.175.24.27]:60586 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbgCBN2a (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 2 Mar 2020 08:28:30 -0500
Received: from [IPv6:2a02:8109:1140:c3d:b1bc:6a1d:3cf1:cf30] (unknown [IPv6:2a02:8109:1140:c3d:b1bc:6a1d:3cf1:cf30])
        (Authenticated sender: lurchi)
        by drew.franken.de (Postfix) with ESMTPSA id B48D9721E2823;
        Mon,  2 Mar 2020 14:28:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Expected SCTP DATA chunk per second performance
From:   Michael Tuexen <michael.tuexen@lurchi.franken.de>
In-Reply-To: <20200302123754.GM43827@nataraja>
Date:   Mon, 2 Mar 2020 14:28:26 +0100
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C8B077E2-A9C2-423E-80BE-B5C583110735@lurchi.franken.de>
References: <20200302093532.GE43827@nataraja>
 <9CFD9C59-9602-4983-B708-A6CED6330DD1@lurchi.franken.de>
 <20200302123754.GM43827@nataraja>
To:     Harald Welte <laforge@gnumonks.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 2. Mar 2020, at 13:37, Harald Welte <laforge@gnumonks.org> wrote:
> 
> Hi Michael,
> 
> On Mon, Mar 02, 2020 at 12:41:57PM +0100, Michael Tuexen wrote:
>>> In wireshark, I can see that up to 9 DATA chunks are aggregated into each SCTP
>>> packet.  However, it typically takes the stack 203-201ms to send a SACK to each
>> 
>> That looks suspicious. It seems this is the 200ms delayed ACK timer. That is fine.
>> The question is why the sender is not sending more? I guess you can work around this
>> issue by disabling the Nagle Algorithm:
>> https://tools.ietf.org/html/rfc6458#section-8.1.5
>> Enable SCTP_NODELAY on the sender side. Does that fix the issue?
>> However, Nagle should not step into the game here...
> 
> I was thinking of SCTP_NODELAY before, but didn't do it as I thought it
> would only impact the lower latency bound in sporadic communication, but
> not throttle the transmit message rate?
> 
> I've just tried your suggestion, and indeed:
> 
> with SCTP_NODELAY=0
> 10000 DATA chunks of 150 bytes each in 19.59 seconds: 510.53 DATA chunks per second
> 
> with SCTP_NODELAY=1
> 10000 DATA chunks of 150 bytes each in  0.26 seconds: 38360.42 DATA chunks per second
> 
> So AFAICT there now is a work-around... but still I assume there is a bug in lksctp
> if it throttles the overall message rate down to 1.3% of what it could
> be when Nagle is enabled?
I consider it a bug. Nagle normally is implemented by not sending small packets.
From the numbers you provided, I guess the SCTP packets are about 1500 bytes. But
I guess Linux has an MTU on the loopback interface which is much larger.
So I guess one part of the code thinks the packet is full (you can't put another
chunk into it), so send it. Another part thinks the packet is not full, since the
MTU is much larger.

Similar bugs where in the FreeBSD stack. However, I'm not familiar with the Linux
code base. Someone else has to chime in. But it shouldn't be hard to find and fix.

Best regards
Michael
> 
> Regards,
> 	Harald
> 
> -- 
> - Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                  (ETSI EN 300 175-7 Ch. A6)

