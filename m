Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1548288410
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Oct 2020 09:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbgJIH5b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 9 Oct 2020 03:57:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:36616 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732239AbgJIH5a (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Oct 2020 03:57:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-189-YOSLEv6hM0O7gDVf7DZkYA-1; Fri, 09 Oct 2020 08:57:26 +0100
X-MC-Unique: YOSLEv6hM0O7gDVf7DZkYA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 9 Oct 2020 08:57:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 9 Oct 2020 08:57:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andreas Fink' <afink@list.fink.org>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: sctp discarding received data chunks
Thread-Topic: sctp discarding received data chunks
Thread-Index: AQHWng1GnBiC92Jzi0usTZn0U2V7p6mO4W5Q
Date:   Fri, 9 Oct 2020 07:57:25 +0000
Message-ID: <8f19b022753c4c3e9a3a34a36e0c8fd3@AcuMS.aculab.com>
References: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
 <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org>
In-Reply-To: <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Andreas Fink
> Sent: 09 October 2020 08:25
> 
> Can you see this issue with the 5.4 kernel too?

I've never seen anything like it before.
I've probably run the same tests quite a few times on a post 5.4 kernel.
I'll have run them on the same 5.6.0-rc7 (from April 2020) a few times as well.
 
> I did yesterday some testing by upgrading kernel from 5.4 to 5.7 and I run
> into all sorts of links going off after a while so I had to revert back.
> 5.4 is stable for me. 5.7 is not.
> And I have lots of M2PA and M3UA connections like you

Glad it's just not me...

I've only had it go horribly wrong once.
I've kept in it the failed state to do further tests.
Regressing is hard, my SCCP and MTP3 code is in a big driver
and I'd need to find the correct kernel headers to rebuild it.

If it is still broken now I'll push some single packets through
while running ftrace.

Actual test is TCAP test app connected to a 'local' dual pair of
ss7 protocol stacks (MTP3 has a MTPA-like link to its peer).
The traffic from SCCP is directed to M3UA (not MTP3) into a pair
of M3UA connections (from each half the dual) to a second MTP3
dual, each of which has an MTP2 signalling link to the other pointcode.
The other system is the same.
So I have 4 SS7 protocol stacks on each of 2 pointcodes.
Eight M3UA connections - 16 SCTP sockets.
Normally this would require 8 computers in 4 geographically
separated locations - but they are all piled up on a single system!
Oh - and the tcap app connects by TCP - so that could be on yet
another system!

	David

> 
> > On 8 Oct 2020, at 23:46, David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > One of my local tests (that I run quite often) failed in a 'new and exciting way'.
> > I sent 510 messages through an M3UA-MTP2-M3UA link and only got ~350 at the far end.
> > (This is part of my SS7+TCAP regression test - gets run a lot.)
> > Usually I can find 'lost' messages logged as discarded due to my own flow control.
> > In this case there is no sign of any error traces.
> > I expect to have each message traced 6 times (on each send and receive)
> > but the missing messages are only traced 5 times.
> >
> > Now /proc/net/sctp/snmp has SctpInDataChunksDiscards set to 163,
> > this matches the number of messages I'm missing.
> > Any idea how I can find out why one (or more) the SCTP connections (which are still
> > connected - unless there is a power cut) has discarded a lot of receive packets?
> >
> > Each M3UA link is actually 4 SCTP connections (TCP style 1-1).
> > All are loopback connected to 127.0.0.1 or ::1 (the assocs print is 'interesting').
> > The local port is 'random' the listening port 2905 or 2906.
> > I'd expect the data to loadshare evenly between them but I've not checked the actual
> > distribution.
> > The packet data contains a sequence number, I'm missing all the x1, x2, x9, xa
> > and half the x6 and xe packets - so I think at least one of the sctp connections
> > is just discarding the receive chunks.
> > (I'll sort out which one tomorrow.)
> >
> > This is a 5.6.0-rc7 kernel.
> > I've not seen anything like this before - I've run this same test for
> > over 10 years, probably going back to at least 2.6.28.
> >
> > Data chunks will have gone though all the connections when they were
> > initialised.
> >
> > Is there anything anywhere that indicates why a data chunk was dropped?
> >
> > 	David
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> >
> 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

