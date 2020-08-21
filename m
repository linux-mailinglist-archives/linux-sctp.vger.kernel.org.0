Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4767E24E261
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Aug 2020 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHUVDw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 21 Aug 2020 17:03:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24363 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgHUVDv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 21 Aug 2020 17:03:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-187-gUvL8McVPIOXIZEftXaLtA-1; Fri, 21 Aug 2020 22:03:47 +0100
X-MC-Unique: gUvL8McVPIOXIZEftXaLtA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 21 Aug 2020 22:03:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 21 Aug 2020 22:03:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Tuexen' <Michael.Tuexen@lurchi.franken.de>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: 64k streams not supported
Thread-Topic: 64k streams not supported
Thread-Index: AdZ304CTRD4hQQAhQWucKVTj4yro3gAGzXQAAAPjOoA=
Date:   Fri, 21 Aug 2020 21:03:46 +0000
Message-ID: <8737d07930a34da3b0c91f8268793ce1@AcuMS.aculab.com>
References: <bedd13a72afd427ca4dbbdfa61985533@AcuMS.aculab.com>
 <B2A8B53A-9704-4C42-84C7-05CD9615FC28@lurchi.franken.de>
In-Reply-To: <B2A8B53A-9704-4C42-84C7-05CD9615FC28@lurchi.franken.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Michael Tuexen
> Sent: 21 August 2020 21:10
> > On 21. Aug 2020, at 17:59, David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > Isn't SCTP supposed to support 65536 data streams?
>
> Since the number of streams is exchanged in the INIT and INIT-ACK chunks
> and encoded in a uint16_t, the number is 65535, not 65536.
> So an implementation should be able to use up to 65535 incoming and
> outgoing streams.

Ah, I'd assumed that because the stream number was encoded
in 16 bits you could use stream numbers 0 through 65535.

At least no one needs to write the patch :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

