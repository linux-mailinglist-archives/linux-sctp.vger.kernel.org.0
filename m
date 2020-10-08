Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB4287090
	for <lists+linux-sctp@lfdr.de>; Thu,  8 Oct 2020 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgJHINn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 8 Oct 2020 04:13:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:49686 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728582AbgJHINn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 8 Oct 2020 04:13:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-220-abNrefnSNwGE1ljHTujGSA-1; Thu, 08 Oct 2020 09:13:38 +0100
X-MC-Unique: abNrefnSNwGE1ljHTujGSA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 8 Oct 2020 09:13:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 8 Oct 2020 09:13:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andreas Fink' <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: Heartbeat on closed SCTP sockets?
Thread-Topic: Heartbeat on closed SCTP sockets?
Thread-Index: AQHWnT3hskjJg57Xhk2drrB4q9pRL6mNWmKg
Date:   Thu, 8 Oct 2020 08:13:38 +0000
Message-ID: <3600af6969d14fcfbe33e05cef8beac2@AcuMS.aculab.com>
References: <1FB70B30-857C-4CD9-A05C-4BA15F57B1D2@list.fink.org>
 <20201005171643.GK70998@localhost.localdomain>
 <A95BC0CF-7C1D-4BB2-B9EF-8222C5BE9B49@list.fink.org>
In-Reply-To: <A95BC0CF-7C1D-4BB2-B9EF-8222C5BE9B49@list.fink.org>
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
> Sent: 08 October 2020 07:40
> 
> by reading the linux diver source I discovered this code segment in input.c around line 188
> 
> 
> /*
> 	 * RFC 2960, 8.4 - Handle "Out of the blue" Packets.
> 	 * An SCTP packet is called an "out of the blue" (OOTB)
> 	 * packet if it is correctly formed, i.e., passed the
> 	 * receiver's checksum check, but the receiver is not
> 	 * able to identify the association to which this
> 	 * packet belongs.
> 	 */
> 
> if (!asoc) {
> 	if (sctp_rcv_ootb(skb)) {
> 		__SCTP_INC_STATS(net, SCTP_MIB_OUTOFBLUES);
> 		goto discard_release;
> 	}
> }
> 
> This means out of the blue packets are always ignored and dropped.
> 
> the RFC however says:
> 
>    8) The receiver should respond to the sender of the OOTB packet with
>       an ABORT.  When sending the ABORT, the receiver of the OOTB packet
>       MUST fill in the Verification Tag field of the outbound packet
>       with the value found in the Verification Tag field of the OOTB
>       packet and set the T-bit in the Chunk Flags to indicate that no
>       TCB was found.  After sending this ABORT, the receiver of the OOTB
>       packet shall discard the OOTB packet and take no further action.
> 
> I think this is what I am seeing. The remote sends OOTB messages, we dont reply with abort which means
> the remote doesnt reset the connection.
> There must be a second issue that the socket structures are not in sync up.

But I'm not sure sending an ABORT is right.
You need to stop the remote sending messages to your IP address
not abort the SCTP connection itself.
Especially on an unverified path.

It is pretty easy to get an IP address that is just 'wrong'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

