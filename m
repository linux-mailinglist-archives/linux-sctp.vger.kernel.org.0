Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6536287E49
	for <lists+linux-sctp@lfdr.de>; Thu,  8 Oct 2020 23:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJHVqr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 8 Oct 2020 17:46:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42091 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgJHVqr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 8 Oct 2020 17:46:47 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-64-5gG0o-ZQMn2I78boUDQzsw-1; Thu, 08 Oct 2020 22:46:43 +0100
X-MC-Unique: 5gG0o-ZQMn2I78boUDQzsw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 8 Oct 2020 22:46:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 8 Oct 2020 22:46:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: sctp discarding received data chunks
Thread-Topic: sctp discarding received data chunks
Thread-Index: AdaduDOYdQMD/eoOT0iWvqbIPHch4w==
Date:   Thu, 8 Oct 2020 21:46:42 +0000
Message-ID: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
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

One of my local tests (that I run quite often) failed in a 'new and exciting way'.
I sent 510 messages through an M3UA-MTP2-M3UA link and only got ~350 at the far end.
(This is part of my SS7+TCAP regression test - gets run a lot.)
Usually I can find 'lost' messages logged as discarded due to my own flow control.
In this case there is no sign of any error traces.
I expect to have each message traced 6 times (on each send and receive)
but the missing messages are only traced 5 times.

Now /proc/net/sctp/snmp has SctpInDataChunksDiscards set to 163,
this matches the number of messages I'm missing.
Any idea how I can find out why one (or more) the SCTP connections (which are still
connected - unless there is a power cut) has discarded a lot of receive packets?

Each M3UA link is actually 4 SCTP connections (TCP style 1-1).
All are loopback connected to 127.0.0.1 or ::1 (the assocs print is 'interesting').
The local port is 'random' the listening port 2905 or 2906.
I'd expect the data to loadshare evenly between them but I've not checked the actual
distribution.
The packet data contains a sequence number, I'm missing all the x1, x2, x9, xa
and half the x6 and xe packets - so I think at least one of the sctp connections
is just discarding the receive chunks.
(I'll sort out which one tomorrow.)

This is a 5.6.0-rc7 kernel.
I've not seen anything like this before - I've run this same test for
over 10 years, probably going back to at least 2.6.28.

Data chunks will have gone though all the connections when they were
initialised.

Is there anything anywhere that indicates why a data chunk was dropped?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

