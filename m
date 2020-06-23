Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B42206473
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 23:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393504AbgFWVVt (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Jun 2020 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbgFWVVr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Jun 2020 17:21:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BBC061573;
        Tue, 23 Jun 2020 14:21:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so42009qtf.6;
        Tue, 23 Jun 2020 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ui8fQB3APJYaznUih7pNhgAm6LkfIND4txjh+hzkfLk=;
        b=bDyAe3KmBqYUtOn2jpTaEUd551O0xWhnVDI2ujVJnTMzDhUkQreqigMEvR8vO50OaO
         grFw6Kd/+8ECCnBPmdu6gHFtfta3+HsZ8klmci+sYF0qOBuesKpTEIB18DAtCOa7V5eL
         C+H5t/lMImzwt3KHPKs7h4gUvsyPo1eYePHcp7xKB6vz5qadHTSl6wxL4VINcp/Uz/s8
         dRXIaYLEM9hFnOXABJze5j99JEXvIZDMbuHus7IZhQgz7NpT34QaLpWyFFzeNrzasGK4
         gW2cOmTY37WlE2ufcyOGG6+x/EdPQpYMinZ0VX+qmkjzp8/lBxiAQXIXfvlH0BfPNqkV
         PrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ui8fQB3APJYaznUih7pNhgAm6LkfIND4txjh+hzkfLk=;
        b=K4VgBiY2HJ6u/FmNNektSev+4m0me83Mv2u4ecfAFb1NrnlseulG50wO2nl8HR1Bvw
         JvEswEZ3MAofbQodRgZ8jNnca4rjlpkYIXqTPqJHl97Lopp5b3oE+xFov28UspCZKpZG
         FFnmVYb/EtXUgXT+c6k+7CEBqZnt9t+XM9JF300dVatweFN6rMKeFmadmK++hmp0VhPX
         jBBm7D5DXuIRzP+R2iQrud9zJCFrR4h5Q+5Y4fD0rZ1F6HPZi5OoVMK6uZqkMw4GnF+y
         qwXzrT3DYNbcdgXv9/zTHAplxCnv25k5Uw0MFbv6vzpncoA+BB0Gfo6GGB4DSFd2Lqur
         wTUw==
X-Gm-Message-State: AOAM530c0V2fIiatlwq3aE2Mb4EPZLU5/lmtWyaliGg1CVAnP5mfTuk7
        /3+vX9mq8+Qmye5jFuiMTSM=
X-Google-Smtp-Source: ABdhPJyB8imk14WxcQe8ntL2dDRXMkBus0kLhyBHS8AjEL83uqP0tjqgyJfPcKN8hHt4hPwCa2x2xQ==
X-Received: by 2002:aed:2b04:: with SMTP id p4mr11265085qtd.158.1592947306614;
        Tue, 23 Jun 2020 14:21:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:65e9:974:aec1:b314:98ea])
        by smtp.gmail.com with ESMTPSA id w45sm1835327qtj.51.2020.06.23.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:21:45 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 5487BC1B81; Tue, 23 Jun 2020 18:21:43 -0300 (-03)
Date:   Tue, 23 Jun 2020 18:21:43 -0300
From:   'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with SCTP+IPv6
Message-ID: <20200623212143.GR2491@localhost.localdomain>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
 <20200623161756.GE3235@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623161756.GE3235@minyard.net>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jun 23, 2020 at 11:17:56AM -0500, Corey Minyard wrote:
> On Tue, Jun 23, 2020 at 01:17:28PM +0000, David Laight wrote:
> > From: Marcelo Ricardo Leitner
> > > Sent: 22 June 2020 19:33
> > > On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> > > > > On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> > > > >
> > > > > On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> > > > >> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> > > > >>>
> > > > >>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> > > > >>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> > > > >>> then I make a connection to it using ::1, the connection will drop after
> > > > >>> 2.5 seconds with an ECONNRESET error.
> > > > >>>
> > > > >>> It only happens on SCTP, it doesn't have the issue if you connect to a
> > > > >>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> > > > >>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> > > > >>> I tried on an ARM system and x86_64.
> > > > >>>
> > > > >>> I haven't dug into the kernel to see if I could find anything yet, but I
> > > > >>> thought I would go ahead and report it.  I am attaching a reproducer.
> > > > >>> Basically, compile the following code:
> > > > >> The code only set IPV6_V6ONLY on server side, so the client side will
> > > > >> still bind all the local ipv4 addresses (as you didn't call bind() to
> > > > >> bind any specific addresses ). Then after the connection is created,
> > > > >> the client will send HB on the v4 paths to the server. The server
> > > > >> will abort the connection, as it can't support v4.
> > > > >>
> > > > >> So you can work around it by either:
> > > > >>
> > > > >>  - set IPV6_V6ONLY on client side.
> > > > >>
> > > > >> or
> > > > >>
> > > > >>  - bind to the specific v6 addresses on the client side.
> > > > >>
> > > > >> I don't see RFC said something about this.
> > > > >> So it may not be a good idea to change the current behaviour
> > > > >> to not establish the connection in this case, which may cause regression.
> > > > >
> > > > > Ok, I understand this.  It's a little strange, but I see why it works
> > > > > this way.
> > > > I don't. I would expect it to work as I described in my email.
> > > > Could someone explain me how and why it is behaving different from
> > > > my expectation?
> > > 
> > > It looks like a bug to me. Testing with this test app here, I can see
> > > the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> > > that's unexpected for a v6only socket. As is, it's the server saying
> > > "I'm available at these other addresses too, but not."
> > 
> > Does it even make sense to mix IPv4 and IPv6 addresses on the same
> > connection?
> > I don't remember ever seeing both types of address in a message,
> > but may not have looked.
> 
> That's an interesting question.  Do the RFCs say anything?  I would
> assume it was ok unless ipv6only was set.
> 
> > 
> > I also wonder whether the connection should be dropped for an error
> > response on a path that has never been validated.
> 
> That actually bothered me a bit more.  Shouldn't it stay up if any path
> is up?  That's kind of the whole point of multihoming.

Michael explained it on the other email. What he described is what I
observed in my tests.

> 
> > 
> > OTOH the whole 'multi-homing' part of SCTP sucks.
> 
> I don't think so.
> 
> > The IP addresses a server needs to bind to depend on where the
> > incoming connection will come from.
> > A local connection may be able to use a 192.168.x.x address
> > but a remote connection must not - as it may be defined locally
> > at the remote system.
> > But both connections can come into the public (routable) address.
> > We have to tell customers to explicitly configure the local IP
> > addresses - which means the application has to know what they are.
> > Fortunately these apps are pretty static - usually M3UA.
> 
> Umm, no,  If you have a private address, it better be behind a firewall,
> and the firewall should handle rewriting the packet to fix the addresses.
> 
> It doesn't appear that Linux netfilter does this.  There is a TODO in
> the code for this.  But that's how it *should* work.

Right, we don't support SCTP aware NAT [1].

1.https://tools.ietf.org/html/draft-stewart-behave-sctpnat-04

  Marcelo

> 
> -corey
> 
> > 
> > 	David
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> > 
