Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13233288369
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Oct 2020 09:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgJIHY6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 9 Oct 2020 03:24:58 -0400
Received: from mail.fink.org ([79.134.252.20]:45852 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgJIHY6 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 9 Oct 2020 03:24:58 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 9 Oct 2020 09:24:42 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: sctp discarding received data chunks
From:   Andreas Fink <afink@list.fink.org>
In-Reply-To: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
Date:   Fri, 9 Oct 2020 09:24:41 +0200
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org>
References: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Can you see this issue with the 5.4 kernel too?

I did yesterday some testing by upgrading kernel from 5.4 to 5.7 and I run into all sorts of links going off after a while so I had to revert back.
5.4 is stable for me. 5.7 is not. And I have lots of M2PA and M3UA connections like you

> On 8 Oct 2020, at 23:46, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> One of my local tests (that I run quite often) failed in a 'new and exciting way'.
> I sent 510 messages through an M3UA-MTP2-M3UA link and only got ~350 at the far end.
> (This is part of my SS7+TCAP regression test - gets run a lot.)
> Usually I can find 'lost' messages logged as discarded due to my own flow control.
> In this case there is no sign of any error traces.
> I expect to have each message traced 6 times (on each send and receive)
> but the missing messages are only traced 5 times.
> 
> Now /proc/net/sctp/snmp has SctpInDataChunksDiscards set to 163,
> this matches the number of messages I'm missing.
> Any idea how I can find out why one (or more) the SCTP connections (which are still
> connected - unless there is a power cut) has discarded a lot of receive packets?
> 
> Each M3UA link is actually 4 SCTP connections (TCP style 1-1).
> All are loopback connected to 127.0.0.1 or ::1 (the assocs print is 'interesting').
> The local port is 'random' the listening port 2905 or 2906.
> I'd expect the data to loadshare evenly between them but I've not checked the actual
> distribution.
> The packet data contains a sequence number, I'm missing all the x1, x2, x9, xa
> and half the x6 and xe packets - so I think at least one of the sctp connections
> is just discarding the receive chunks.
> (I'll sort out which one tomorrow.)
> 
> This is a 5.6.0-rc7 kernel.
> I've not seen anything like this before - I've run this same test for
> over 10 years, probably going back to at least 2.6.28.
> 
> Data chunks will have gone though all the connections when they were
> initialised.
> 
> Is there anything anywhere that indicates why a data chunk was dropped?
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


