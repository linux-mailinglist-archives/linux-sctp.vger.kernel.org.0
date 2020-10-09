Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEF2887A1
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Oct 2020 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387987AbgJILNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 9 Oct 2020 07:13:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52189 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbgJILNg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Oct 2020 07:13:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-79-KVbpIWCVOmipEKP1P7nCQg-1; Fri, 09 Oct 2020 12:13:32 +0100
X-MC-Unique: KVbpIWCVOmipEKP1P7nCQg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 9 Oct 2020 12:13:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 9 Oct 2020 12:13:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andreas Fink' <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        'Neil Horman' <nhorman@tuxdriver.com>,
        "'Xin Long'" <lucien.xin@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: sctp discarding received data chunks
Thread-Topic: sctp discarding received data chunks
Thread-Index: AQHWng1GnBiC92Jzi0usTZn0U2V7p6mPGcdw
Date:   Fri, 9 Oct 2020 11:13:31 +0000
Message-ID: <73434b87932e46a89dd1b5b5132b3196@AcuMS.aculab.com>
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
> 
> I did yesterday some testing by upgrading kernel from 5.4 to 5.7 and I run into all sorts of links
> going off after a while so I had to revert back.
> 5.4 is stable for me. 5.7 is not. And I have lots of M2PA and M3UA connections like you

I've just spent hours digging through my traces.
It is only some messages through the connection that get lost!

Now SCTP_MIN_IN_DATA_CHUNK_DISCARDS is only incremented in two
adjacent places in sm_statefuncs.c.

Either for bad TSN (unlikely when everything is using "lo")
and bad STREAM.
I suspect it is the 'bad stream' case.
I've not double-checked but I bet the discarded packets
all have a large stream number.

So it is likely that the addition of 'sctp streams' broke
the negotiation of the maximum stream number, and the reporting
of that value back to the application in getsockopt().

I've probably recently changed my test to request 17 streams
(not 5). Since the default number of streams is 10 that may
be why it worked on this kernel before.

There was a similar bug that got fixed very recently.
Ah yes, I wrote this on 14th August:

    At some point the negotiation of the number of SCTP streams
    seems to have got broken.
    I've definitely tested it in the past (probably 10 years ago!)
    but on a 5.8.0 kernel getsockopt(SCTP_INFO) seems to be
    returning the 'num_ostreams' set by setsockopt(SCTP_INIT)
    rather than the smaller of that value and that configured
    at the other end of the connection.

Although I though that stopped packets being set, not received.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

