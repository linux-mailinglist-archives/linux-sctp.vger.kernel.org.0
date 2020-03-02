Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54023175C3D
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Mar 2020 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCBNwi (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 2 Mar 2020 08:52:38 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:41355 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCBNwh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Mar 2020 08:52:37 -0500
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@gnumonks.org>)
        id 1j8lUp-0002k5-6y; Mon, 02 Mar 2020 14:52:35 +0100
Received: from laforge by localhost.localdomain with local (Exim 4.93)
        (envelope-from <laforge@gnumonks.org>)
        id 1j8lQ7-001FI7-Ei; Mon, 02 Mar 2020 14:47:43 +0100
Date:   Mon, 2 Mar 2020 14:47:43 +0100
From:   Harald Welte <laforge@gnumonks.org>
To:     Michael Tuexen <michael.tuexen@lurchi.franken.de>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: Expected SCTP DATA chunk per second performance
Message-ID: <20200302134743.GP43827@nataraja>
References: <20200302093532.GE43827@nataraja>
 <9CFD9C59-9602-4983-B708-A6CED6330DD1@lurchi.franken.de>
 <20200302123754.GM43827@nataraja>
 <C8B077E2-A9C2-423E-80BE-B5C583110735@lurchi.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8B077E2-A9C2-423E-80BE-B5C583110735@lurchi.franken.de>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Michael,

On Mon, Mar 02, 2020 at 02:28:26PM +0100, Michael Tuexen wrote:

> I consider it a bug. 

Agreed.

> Nagle normally is implemented by not sending small packets.
> From the numbers you provided, I guess the SCTP packets are about 1500 bytes. But
> I guess Linux has an MTU on the loopback interface which is much larger.

Actually, it depends on the type of sender code I use.  With Eclipse TITAN IPL4asp
(my ultimate target for writing the tests), the packets indeed are pnly 1500 bytes
in size.

When using the small C program attached, I'm seeing ~34 kByte sized IP
packets on loopback, but only at 500-510 DATA chunks per second overall
rate.

When disabling NAGLE ('client -d' of the attached program), I'm getting
much higher throughput, but there is no single IP packet with more than
a single DATA chunk inside at all anymore.  The latter is expected on
the one hand side (every syscall goes all the way to build a packet and
send it), but given at the high sender rate I would have expected that
every so often multiple DATA chunks arrive from userspace before a
packet has been sent (socket send buffer)?  In any case, no complaints
in this case.

Also interesting: With the application code (TITAN) in place, I am
seeing higher DATA chunk throughput over actual Ethernet than I'm seeing
over loopback.

I'd appreciate any feedback from the lksctp hackers here if I should
open a bugzilla issue about the poor performance with Nagle.

Regards,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
