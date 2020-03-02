Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8711759AD
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Mar 2020 12:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCBLmD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 2 Mar 2020 06:42:03 -0500
Received: from mail-n.franken.de ([193.175.24.27]:51552 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbgCBLmD (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 2 Mar 2020 06:42:03 -0500
Received: from [IPv6:2a02:8109:1140:c3d:16d:83a6:11e5:aaf8] (unknown [IPv6:2a02:8109:1140:c3d:16d:83a6:11e5:aaf8])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 0EDD7721E2823;
        Mon,  2 Mar 2020 12:41:59 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Expected SCTP DATA chunk per second performance
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <20200302093532.GE43827@nataraja>
Date:   Mon, 2 Mar 2020 12:41:57 +0100
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9CFD9C59-9602-4983-B708-A6CED6330DD1@lurchi.franken.de>
References: <20200302093532.GE43827@nataraja>
To:     Harald Welte <laforge@gnumonks.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 2. Mar 2020, at 10:35, Harald Welte <laforge@gnumonks.org> wrote:
> 
> Hi!
> 
> I've been trying to implement some DIAMETER load testing, and I discovered that
> it's apparently not my application layer code that is throttling the rate,
> but the kernel SCTP stack.  I currently cannot get to more than 500 SCTP data
> chunks per second on a 5.4.19 kernel (happy to try other versions).
> 
> The most simplistic setup to reproduce is:
> * run a single-threaded SCTP server and SCTP client on the same machine
> * use loopback / localhost for communication
> * have the transmitter continuously transmit sctp_sendmsg() of 100-200 bytes
> * have the receiver just sctp_recvmsg() and discard the data
> * use a single stream in a single association for now to establish a base-line
> 
> Whether I use a complex diameter stack and test framework or whether I use a
> simplistic 120 line C program that just transmits small data chunks, the
> rate always is limited to about 500 DATA chunks per second.
> 
> In wireshark, I can see that up to 9 DATA chunks are aggregated into each SCTP
> packet.  However, it typically takes the stack 203-201ms to send a SACK to each
That looks suspicious. It seems this is the 200ms delayed ACK timer. That is fine.
The question is why the sender is not sending more? I guess you can work around this
issue by disabling the Nagle Algorithm:
https://tools.ietf.org/html/rfc6458#section-8.1.5
Enable SCTP_NODELAY on the sender side. Does that fix the issue?
However, Nagle should not step into the game here...

Best regards
Michael
> of those packets.  Only after that SACK is received, it seems the sender is
> transmitting more DATA chunks in the next packet.
> 
> I wonder if this is expected behavior?  As far as I understand, SCTP only has
> a congestion window based on number of bytes, and not on number of chunks. The
> windows as per INIT/INIT_ACK is at 160496 bytes, while 144 bytes * 9 chunks is
> only 1296 bytes, i.e. the window cannot be full at all.
> 
> Any ideas what's happening here and how to increase the throughput in terms of
> number of DATA chunks per second?
> 
> A demo program is attached for your reference
> 
> Thanks in advance.
> 
> Regards,
> 	Harald
> 
> -- 
> - Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                  (ETSI EN 300 175-7 Ch. A6)
> <sctptest.c>

