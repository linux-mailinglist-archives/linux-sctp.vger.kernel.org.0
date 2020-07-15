Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E6220DA4
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Jul 2020 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgGONIm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Wed, 15 Jul 2020 09:08:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57823 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729900AbgGONIm (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 15 Jul 2020 09:08:42 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-63-Wtby7OnGMuGyvm_kdfZhBQ-1; Wed, 15 Jul 2020 14:08:38 +0100
X-MC-Unique: Wtby7OnGMuGyvm_kdfZhBQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jul 2020 14:08:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jul 2020 14:08:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'minyard@acm.org'" <minyard@acm.org>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
CC:     Marcelo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: 200ms delays with SCTP streaming data
Thread-Topic: 200ms delays with SCTP streaming data
Thread-Index: AQHWWfssG7qQ9OClZU6ojEcbFbjL6qkImwbA
Date:   Wed, 15 Jul 2020 13:08:37 +0000
Message-ID: <6a5d72ff775d45adacf765ea41fefbb5@AcuMS.aculab.com>
References: <20200713215907.GE3235@minyard.net>
 <20200713221104.GW2491@localhost.localdomain>
 <20200714121258.GN17797@minyard.net> <20200714131018.GO17797@minyard.net>
 <BB8FA7BE-EBE8-4525-9BE2-A5DCF40F6C2C@lurchi.franken.de>
 <20200714162349.GP17797@minyard.net>
In-Reply-To: <20200714162349.GP17797@minyard.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Corey Minyard
> Sent: 14 July 2020 17:24
...
> Well, that was a surprise, disabling Nagle caused the problem to go
> away.  Nagle generally doesn't make a difference when transferring lots
> of data.
> 
> I guess this is a bad interaction between Nagle and the SCTP
> sack algorithms.  With TCP in my test, data is flowing both ways so data
> is always being acked, and Nagle is never significantly involved.
> 
> That's happening with SCTP, too, but in some situations a sack could be
> sent, you get one more packet sent, and that packet won't be acked until
> another packet is sent.  So you have unacked data, and Nagle will hold
> any new data until it receives an ack for the outstanding packet.  So you
> get stuck until the sack delay elapses.  Bah.
> 
> This is sort of like the interaction between Nagle and TCP delayed ack.
> Which is sort of a bug, I guess, but well known.  I have a number of
> ways to work around this issue, and I can document it so users can know.

If you have an indefinite amount of data to send then even with Nagle
enabled data should get sent when enough is queued to fill an ethernet
frame.
The only proviso is that there is enough transmit window space.
Doing that in SCTP is much more horrid than TCP.

I have seen issues caused by 0 RTT, slow start and delayed acks.
But that was TCP with Nagle enabled.

If you want a 'full hands on debugging experience' enable ftrace
on 'useful' function entry points (all syscall entry/exit events
is a good start) and get the application to stop it on the 200ms
timeout.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

