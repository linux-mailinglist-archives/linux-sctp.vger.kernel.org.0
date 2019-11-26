Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920B1109C3C
	for <lists+linux-sctp@lfdr.de>; Tue, 26 Nov 2019 11:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKZKYN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 26 Nov 2019 05:24:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:28608 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbfKZKYN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 26 Nov 2019 05:24:13 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-87-WyKp45gdN1u72WqNZE6WKQ-1; Tue, 26 Nov 2019 10:24:10 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 26 Nov 2019 10:24:10 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 26 Nov 2019 10:24:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: sctp protocol violation state 2 chunkid 5
Thread-Topic: sctp protocol violation state 2 chunkid 5
Thread-Index: AdWjrfwNb5OjxDeQRGScprFM2jifUQ==
Date:   Tue, 26 Nov 2019 10:24:10 +0000
Message-ID: <431b0b65c3604076bb5ef633bcac8198@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: WyKp45gdN1u72WqNZE6WKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I've a customer saying they are seeing the error ' sctp protocol violation state 2 chunkid 5'
being logged on a system where receive SCTP data isn't being processed properly.
They've only sent me a .pcap file so I'm not actually certain what the (kernel) code that
has the socket is seeing.
I think that SACK is being sent for all the receive data, but nothing is being transmitted.
Of course, that data could be on a different socket (well address quartet) than the
one generating the error.

The pcap trace is made harder to read because there are several SCTP connections,
none of which are working and, I think, some have the same port number pairs
but different remote IP addresses.

To make any sense of the error they must be using a RHEL 6 (2.6.32 based) kernel.
Which makes it erroring a HEARTBEAT_ACK in state COOKIE_WAIT.

One complication that might lead to sockets with duplicate address quartets is
that these are M3UA connections and it is typical to bind to a specific local
IP address and port number then bindx to a second local IP address before
making the outwards connection.
(We only connect to one of the remote IPs, the other is picked up by SCTP.)

I can try to persuade them it is fixed in a later kernel, but getting them to
use anything newer than the RHEL 7.7 3.10 based kernel will be very hard.

Any ideas?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

