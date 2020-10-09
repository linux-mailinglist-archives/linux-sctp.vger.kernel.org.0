Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA7288987
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Oct 2020 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbgJINDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 9 Oct 2020 09:03:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:48895 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732468AbgJINDe (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Oct 2020 09:03:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-111-8JCgyyt_OzyqgOa9HFY45Q-1; Fri, 09 Oct 2020 14:03:30 +0100
X-MC-Unique: 8JCgyyt_OzyqgOa9HFY45Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 9 Oct 2020 14:03:29 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 9 Oct 2020 14:03:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andreas Fink' <afink@list.fink.org>,
        'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        'Neil Horman' <nhorman@tuxdriver.com>,
        "'Xin Long'" <lucien.xin@gmail.com>
CC:     "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>
Subject: RE: sctp discarding received data chunks
Thread-Topic: sctp discarding received data chunks
Thread-Index: AQHWng1GnBiC92Jzi0usTZn0U2V7p6mPGcdwgAAhfiA=
Date:   Fri, 9 Oct 2020 13:03:29 +0000
Message-ID: <766ffacb7d4c48df81aea64204ff37d9@AcuMS.aculab.com>
References: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
 <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org>
 <73434b87932e46a89dd1b5b5132b3196@AcuMS.aculab.com>
In-Reply-To: <73434b87932e46a89dd1b5b5132b3196@AcuMS.aculab.com>
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

From: David Laight
> Sent: 09 October 2020 12:14
> 
> From: Andreas Fink
> > Sent: 09 October 2020 08:25
> >
> > Can you see this issue with the 5.4 kernel too?
> >
> > I did yesterday some testing by upgrading kernel from 5.4 to 5.7 and I run into all sorts of links
> > going off after a while so I had to revert back.
> > 5.4 is stable for me. 5.7 is not. And I have lots of M2PA and M3UA connections like you
> 
> I've just spent hours digging through my traces.
> It is only some messages through the connection that get lost!
> 
> Now SCTP_MIN_IN_DATA_CHUNK_DISCARDS is only incremented in two
> adjacent places in sm_statefuncs.c.
> 
> Either for bad TSN (unlikely when everything is using "lo")
> and bad STREAM.
> I suspect it is the 'bad stream' case.
> I've not double-checked but I bet the discarded packets
> all have a large stream number.
...

If I dump out /proc/net/sctp/assocs and look way over to the right
(on the next monitor but 1) there are two columns INS and OUTS.
I've just realised that these are the number of streams.
Now all my connections are loopback - so I see both sockets for each.
So I'd expect the INS to match the OUTS of the peer.
This isn't true.
When the value should be negotiated down the OUTS value is unchanged.
So the kernel is sending packets with illegal stream numbers.
These are acked and then silently discarded.

I've not check a HEAD kernel.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

