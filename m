Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6EE175E27
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Mar 2020 16:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgCBP0n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 2 Mar 2020 10:26:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53744 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbgCBP0n (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Mar 2020 10:26:43 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-40-WLaV-7VkOZGk-9jJ2RsFAg-1; Mon, 02 Mar 2020 15:26:40 +0000
X-MC-Unique: WLaV-7VkOZGk-9jJ2RsFAg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Mar 2020 15:26:39 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Mar 2020 15:26:39 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Harald Welte' <laforge@gnumonks.org>,
        Michael Tuexen <michael.tuexen@lurchi.franken.de>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: Expected SCTP DATA chunk per second performance
Thread-Topic: Expected SCTP DATA chunk per second performance
Thread-Index: AQHV8JnZZO3aqJ7SmkSot9pPWmOt8ag1a+pw
Date:   Mon, 2 Mar 2020 15:26:39 +0000
Message-ID: <473732823f1b40f2bb5d47935840696c@AcuMS.aculab.com>
References: <20200302093532.GE43827@nataraja>
 <9CFD9C59-9602-4983-B708-A6CED6330DD1@lurchi.franken.de>
 <20200302123754.GM43827@nataraja>
 <C8B077E2-A9C2-423E-80BE-B5C583110735@lurchi.franken.de>
 <20200302134743.GP43827@nataraja>
In-Reply-To: <20200302134743.GP43827@nataraja>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Harald Welte
> Sent: 02 March 2020 13:48
...
> When disabling NAGLE ('client -d' of the attached program), I'm getting
> much higher throughput, but there is no single IP packet with more than
> a single DATA chunk inside at all anymore.  The latter is expected on
> the one hand side (every syscall goes all the way to build a packet and
> send it), but given at the high sender rate I would have expected that
> every so often multiple DATA chunks arrive from userspace before a
> packet has been sent (socket send buffer)?  In any case, no complaints
> in this case.

You'd have to flow control off (ie no ack from the remote system) the
connections before data chunks get merged.

If you know you have another data chunk to send, set MSG_MORE on the send.
That should stop the packet being sent until it is full.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

