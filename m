Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233FB205343
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgFWNRe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 23 Jun 2020 09:17:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20352 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732594AbgFWNRe (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 23 Jun 2020 09:17:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-80-PPSv6GeNNhSUDZXNTs6kBQ-1; Tue, 23 Jun 2020 14:17:29 +0100
X-MC-Unique: PPSv6GeNNhSUDZXNTs6kBQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 23 Jun 2020 14:17:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 23 Jun 2020 14:17:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
CC:     "minyard@acm.org" <minyard@acm.org>,
        Xin Long <lucien.xin@gmail.com>,
        "Vlad Yasevich" <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: Strange problem with SCTP+IPv6
Thread-Topic: Strange problem with SCTP+IPv6
Thread-Index: AQHWSMOQnCXngLNhqU+XPiIQcbDSR6jmLNPQ
Date:   Tue, 23 Jun 2020 13:17:28 +0000
Message-ID: <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
In-Reply-To: <20200622183253.GQ2491@localhost.localdomain>
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

From: Marcelo Ricardo Leitner
> Sent: 22 June 2020 19:33
> On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> > > On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> > >> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> > >>>
> > >>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> > >>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> > >>> then I make a connection to it using ::1, the connection will drop after
> > >>> 2.5 seconds with an ECONNRESET error.
> > >>>
> > >>> It only happens on SCTP, it doesn't have the issue if you connect to a
> > >>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> > >>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> > >>> I tried on an ARM system and x86_64.
> > >>>
> > >>> I haven't dug into the kernel to see if I could find anything yet, but I
> > >>> thought I would go ahead and report it.  I am attaching a reproducer.
> > >>> Basically, compile the following code:
> > >> The code only set IPV6_V6ONLY on server side, so the client side will
> > >> still bind all the local ipv4 addresses (as you didn't call bind() to
> > >> bind any specific addresses ). Then after the connection is created,
> > >> the client will send HB on the v4 paths to the server. The server
> > >> will abort the connection, as it can't support v4.
> > >>
> > >> So you can work around it by either:
> > >>
> > >>  - set IPV6_V6ONLY on client side.
> > >>
> > >> or
> > >>
> > >>  - bind to the specific v6 addresses on the client side.
> > >>
> > >> I don't see RFC said something about this.
> > >> So it may not be a good idea to change the current behaviour
> > >> to not establish the connection in this case, which may cause regression.
> > >
> > > Ok, I understand this.  It's a little strange, but I see why it works
> > > this way.
> > I don't. I would expect it to work as I described in my email.
> > Could someone explain me how and why it is behaving different from
> > my expectation?
> 
> It looks like a bug to me. Testing with this test app here, I can see
> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> that's unexpected for a v6only socket. As is, it's the server saying
> "I'm available at these other addresses too, but not."

Does it even make sense to mix IPv4 and IPv6 addresses on the same
connection?
I don't remember ever seeing both types of address in a message,
but may not have looked.

I also wonder whether the connection should be dropped for an error
response on a path that has never been validated.

OTOH the whole 'multi-homing' part of SCTP sucks.
The IP addresses a server needs to bind to depend on where the
incoming connection will come from.
A local connection may be able to use a 192.168.x.x address
but a remote connection must not - as it may be defined locally
at the remote system.
But both connections can come into the public (routable) address.
We have to tell customers to explicitly configure the local IP
addresses - which means the application has to know what they are.
Fortunately these apps are pretty static - usually M3UA.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

