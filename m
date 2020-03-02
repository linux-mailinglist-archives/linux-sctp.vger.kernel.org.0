Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB858175AB0
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Mar 2020 13:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgCBMkh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 2 Mar 2020 07:40:37 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:58359 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCBMkh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Mar 2020 07:40:37 -0500
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@gnumonks.org>)
        id 1j8kN9-0007bk-OQ; Mon, 02 Mar 2020 13:40:35 +0100
Received: from laforge by localhost.localdomain with local (Exim 4.93)
        (envelope-from <laforge@gnumonks.org>)
        id 1j8kKY-001Dy5-Hv; Mon, 02 Mar 2020 13:37:54 +0100
Date:   Mon, 2 Mar 2020 13:37:54 +0100
From:   Harald Welte <laforge@gnumonks.org>
To:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: Expected SCTP DATA chunk per second performance
Message-ID: <20200302123754.GM43827@nataraja>
References: <20200302093532.GE43827@nataraja>
 <9CFD9C59-9602-4983-B708-A6CED6330DD1@lurchi.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9CFD9C59-9602-4983-B708-A6CED6330DD1@lurchi.franken.de>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Michael,

On Mon, Mar 02, 2020 at 12:41:57PM +0100, Michael Tuexen wrote:
> > In wireshark, I can see that up to 9 DATA chunks are aggregated into each SCTP
> > packet.  However, it typically takes the stack 203-201ms to send a SACK to each
>
> That looks suspicious. It seems this is the 200ms delayed ACK timer. That is fine.
> The question is why the sender is not sending more? I guess you can work around this
> issue by disabling the Nagle Algorithm:
> https://tools.ietf.org/html/rfc6458#section-8.1.5
> Enable SCTP_NODELAY on the sender side. Does that fix the issue?
> However, Nagle should not step into the game here...

I was thinking of SCTP_NODELAY before, but didn't do it as I thought it
would only impact the lower latency bound in sporadic communication, but
not throttle the transmit message rate?

I've just tried your suggestion, and indeed:

with SCTP_NODELAY=0
10000 DATA chunks of 150 bytes each in 19.59 seconds: 510.53 DATA chunks per second

with SCTP_NODELAY=1
10000 DATA chunks of 150 bytes each in  0.26 seconds: 38360.42 DATA chunks per second

So AFAICT there now is a work-around... but still I assume there is a bug in lksctp
if it throttles the overall message rate down to 1.3% of what it could
be when Nagle is enabled?

Regards,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
