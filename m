Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65852056F4
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbgFWQSB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Jun 2020 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbgFWQSB (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Jun 2020 12:18:01 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6FC061573;
        Tue, 23 Jun 2020 09:18:01 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t25so19296891oij.7;
        Tue, 23 Jun 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8kS+p2B98IcZ0DKHH6bGHBzlHBukklTo3te+GpuWHrw=;
        b=fwk2GFv/oNKryY3pnvflFbNwLd5lN2atjIMk7zdevCcKj1F2EeJcTWRDUZ60/ifNUN
         Wj15Yd1bh5CHrB8s8CZHQ3kZh6qjGC7V3Idw6HGWhiVRWqMqWKDXcFeqw5/D+6aMpt8s
         5KStMJYiPP7zywQcWmPhIV+M1gz/ZiIMMF4J0G3qYVTZOK77nw2dbbklL6H84Qi/H6Fk
         ul1PY6Verpvm9cf9evztaB6HfeadPVXBqtJ3FkT6+aN89rH+qojIB1UruiCp38aIz0kP
         AaCosr8qHKaSxPo/f8R59+eNwA1J9+ojPOY/k1QI6kA2uYAZyQzv49io9YolZwZ579Wh
         tIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=8kS+p2B98IcZ0DKHH6bGHBzlHBukklTo3te+GpuWHrw=;
        b=PT4UP3TMNVP/6wqx5BeOu83otzFWoDFyZcJHw8PDVEnXwRqXtuoJq6DNCWFstGXhs7
         zbBP6HQHoNtlOuo59biZ/fpNVnYGj2G/av1SZAcMUk0FK4ZHdONZwZmk9tsCizyFf4tQ
         rYWq5onJfh6KSO14DKk3FaXdliaJiyhFSzeU17H4+ENUmYFt8AQpW+LF9okvqEXzLDnt
         tP6T+BudMPqWOImR3a9LcShUGWdYlqzLYzGsj/tJXJprn+5WS5bVil1FEENEvVLEsXP2
         x3hCcoGkWjwm/F7nvS2na9zZ+6M1uoh4qq6Jblti3oj1Qf0VW9QXH9yed9zXGhYq4dvQ
         iShw==
X-Gm-Message-State: AOAM533dh9hmOkE8SMgAL8Z8Jzb9Gb26pPKxe1C1ljTU+Skm/8PcyNS9
        lcxSkMaAZCZvlzZ4PhUKdQ==
X-Google-Smtp-Source: ABdhPJyp+26+EXVN9ZfYA7vkccvFu//lDHju4ffpArfw4UQtdP/wJAl81f9KxvP51qM4xOZIi5yS3Q==
X-Received: by 2002:aca:902:: with SMTP id 2mr16140942oij.151.1592929079748;
        Tue, 23 Jun 2020 09:17:59 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id w10sm4147433otp.44.2020.06.23.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:17:58 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6d79:306:b4b0:35c1])
        by serve.minyard.net (Postfix) with ESMTPSA id D42CB18003A;
        Tue, 23 Jun 2020 16:17:57 +0000 (UTC)
Date:   Tue, 23 Jun 2020 11:17:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with SCTP+IPv6
Message-ID: <20200623161756.GE3235@minyard.net>
Reply-To: minyard@acm.org
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jun 23, 2020 at 01:17:28PM +0000, David Laight wrote:
> From: Marcelo Ricardo Leitner
> > Sent: 22 June 2020 19:33
> > On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> > > > On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> > > >
> > > > On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> > > >> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> > > >>>
> > > >>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> > > >>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> > > >>> then I make a connection to it using ::1, the connection will drop after
> > > >>> 2.5 seconds with an ECONNRESET error.
> > > >>>
> > > >>> It only happens on SCTP, it doesn't have the issue if you connect to a
> > > >>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> > > >>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> > > >>> I tried on an ARM system and x86_64.
> > > >>>
> > > >>> I haven't dug into the kernel to see if I could find anything yet, but I
> > > >>> thought I would go ahead and report it.  I am attaching a reproducer.
> > > >>> Basically, compile the following code:
> > > >> The code only set IPV6_V6ONLY on server side, so the client side will
> > > >> still bind all the local ipv4 addresses (as you didn't call bind() to
> > > >> bind any specific addresses ). Then after the connection is created,
> > > >> the client will send HB on the v4 paths to the server. The server
> > > >> will abort the connection, as it can't support v4.
> > > >>
> > > >> So you can work around it by either:
> > > >>
> > > >>  - set IPV6_V6ONLY on client side.
> > > >>
> > > >> or
> > > >>
> > > >>  - bind to the specific v6 addresses on the client side.
> > > >>
> > > >> I don't see RFC said something about this.
> > > >> So it may not be a good idea to change the current behaviour
> > > >> to not establish the connection in this case, which may cause regression.
> > > >
> > > > Ok, I understand this.  It's a little strange, but I see why it works
> > > > this way.
> > > I don't. I would expect it to work as I described in my email.
> > > Could someone explain me how and why it is behaving different from
> > > my expectation?
> > 
> > It looks like a bug to me. Testing with this test app here, I can see
> > the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> > that's unexpected for a v6only socket. As is, it's the server saying
> > "I'm available at these other addresses too, but not."
> 
> Does it even make sense to mix IPv4 and IPv6 addresses on the same
> connection?
> I don't remember ever seeing both types of address in a message,
> but may not have looked.

That's an interesting question.  Do the RFCs say anything?  I would
assume it was ok unless ipv6only was set.

> 
> I also wonder whether the connection should be dropped for an error
> response on a path that has never been validated.

That actually bothered me a bit more.  Shouldn't it stay up if any path
is up?  That's kind of the whole point of multihoming.

> 
> OTOH the whole 'multi-homing' part of SCTP sucks.

I don't think so.

> The IP addresses a server needs to bind to depend on where the
> incoming connection will come from.
> A local connection may be able to use a 192.168.x.x address
> but a remote connection must not - as it may be defined locally
> at the remote system.
> But both connections can come into the public (routable) address.
> We have to tell customers to explicitly configure the local IP
> addresses - which means the application has to know what they are.
> Fortunately these apps are pretty static - usually M3UA.

Umm, no,  If you have a private address, it better be behind a firewall,
and the firewall should handle rewriting the packet to fix the addresses.

It doesn't appear that Linux netfilter does this.  There is a TODO in
the code for this.  But that's how it *should* work.

-corey

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
