Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF2020651F
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393428AbgFWVbJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Jun 2020 17:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbgFWVbH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Jun 2020 17:31:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AC7C061573;
        Tue, 23 Jun 2020 14:31:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h23so88913qtr.0;
        Tue, 23 Jun 2020 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yf+Ybft+oMB9oFmQovd4sjllNdPJc5JINXxSiyPAq78=;
        b=cZ77YJjx9oqgFWGIL2Dvqn1mMbuh15jyNlXmE9iBCKegTWusfhCip22DQhEXiNSycY
         wxnfvClwJtySstWeeGxYWLxKoTI6vEfTPys413T+3BGWhnf/LYn9mVWRCgsZ35Tc0tMS
         23lL4CTJw+CLa/YGzgjBheLt6WYeynOAdZD5lveGb7JP31HxMDmMBDUcXqGFE1Rc8E9C
         O6cj59sfnshPD5j6oVJuYo1ZvJPAqSaUzYhaIwIY+WNp5p7a3XRE6mFUM4Ra73x8NF4a
         HowCqq0djxNTVKPsKuJiFAjr8eKjIpSKHYhr594PfgE19yIuxLWDaNn0mfjTgTN0kFYi
         QweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yf+Ybft+oMB9oFmQovd4sjllNdPJc5JINXxSiyPAq78=;
        b=KqDjKcz8nuPu5lT3/uZ3ZhVIedlpLf3T+hIzG+sgSX10iT57AZ2qhJIZenlylbCdXe
         oKTBeqX26lcU1d1CyK9wG87BN8oF7F0ZF5InLrTHCo8kDIstPrdEFOuMbvTfmINvLkrN
         pO80s4KYhOYtpNpNzeZwMQ3A5EQ+aHGrS46H0FEUyz62swrFLYsk/W4cfHwhDGe8/rb3
         hQwUITc/p1o3Rx4LAat91weX5affZR4p10VAZW4I+T1uYUfcaV3+rv4S7tnLWNndUOFA
         xxTELwePMPJmWiC0MqDsWc1yzS6oddwUBELvfahpx5EX7bxNtDfQ46Cxk6B0CW2csLzI
         Zopw==
X-Gm-Message-State: AOAM531KV+iDNYjWohGSA5sPU+WtU54Rh+QD/DtgmQbGUp8u4ZqQGKT2
        YUXx/M4NdlmVX3YfY4Qtue8xcYbh
X-Google-Smtp-Source: ABdhPJxzIR45jsqRbr0TVAjHZBo3U3iyl4X+3CgwRrXCVxMGC4PSO5URrwsA/tALT9u6eb6ilXobkw==
X-Received: by 2002:ac8:1991:: with SMTP id u17mr16282100qtj.93.1592947866525;
        Tue, 23 Jun 2020 14:31:06 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.113])
        by smtp.gmail.com with ESMTPSA id i205sm1608010qke.14.2020.06.23.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:31:05 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 0592EC1B81; Tue, 23 Jun 2020 18:31:03 -0300 (-03)
Date:   Tue, 23 Jun 2020 18:31:02 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Cc:     Corey Minyard <minyard@acm.org>,
        David Laight <David.Laight@aculab.com>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with SCTP+IPv6
Message-ID: <20200623213102.GS2491@localhost.localdomain>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
 <20200623161756.GE3235@minyard.net>
 <20200623212143.GR2491@localhost.localdomain>
 <C4F6EDBE-CCAE-4635-AD96-9C2E2582F1B3@lurchi.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4F6EDBE-CCAE-4635-AD96-9C2E2582F1B3@lurchi.franken.de>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jun 23, 2020 at 11:24:59PM +0200, Michael Tuexen wrote:
> > On 23. Jun 2020, at 23:21, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> > 
> > On Tue, Jun 23, 2020 at 11:17:56AM -0500, Corey Minyard wrote:
> >> On Tue, Jun 23, 2020 at 01:17:28PM +0000, David Laight wrote:
> >>> From: Marcelo Ricardo Leitner
> >>>> Sent: 22 June 2020 19:33
> >>>> On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> >>>>>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> >>>>>> 
> >>>>>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> >>>>>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> >>>>>>>> 
> >>>>>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> >>>>>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> >>>>>>>> then I make a connection to it using ::1, the connection will drop after
> >>>>>>>> 2.5 seconds with an ECONNRESET error.
> >>>>>>>> 
> >>>>>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
> >>>>>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> >>>>>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> >>>>>>>> I tried on an ARM system and x86_64.
> >>>>>>>> 
> >>>>>>>> I haven't dug into the kernel to see if I could find anything yet, but I
> >>>>>>>> thought I would go ahead and report it.  I am attaching a reproducer.
> >>>>>>>> Basically, compile the following code:
> >>>>>>> The code only set IPV6_V6ONLY on server side, so the client side will
> >>>>>>> still bind all the local ipv4 addresses (as you didn't call bind() to
> >>>>>>> bind any specific addresses ). Then after the connection is created,
> >>>>>>> the client will send HB on the v4 paths to the server. The server
> >>>>>>> will abort the connection, as it can't support v4.
> >>>>>>> 
> >>>>>>> So you can work around it by either:
> >>>>>>> 
> >>>>>>> - set IPV6_V6ONLY on client side.
> >>>>>>> 
> >>>>>>> or
> >>>>>>> 
> >>>>>>> - bind to the specific v6 addresses on the client side.
> >>>>>>> 
> >>>>>>> I don't see RFC said something about this.
> >>>>>>> So it may not be a good idea to change the current behaviour
> >>>>>>> to not establish the connection in this case, which may cause regression.
> >>>>>> 
> >>>>>> Ok, I understand this.  It's a little strange, but I see why it works
> >>>>>> this way.
> >>>>> I don't. I would expect it to work as I described in my email.
> >>>>> Could someone explain me how and why it is behaving different from
> >>>>> my expectation?
> >>>> 
> >>>> It looks like a bug to me. Testing with this test app here, I can see
> >>>> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> >>>> that's unexpected for a v6only socket. As is, it's the server saying
> >>>> "I'm available at these other addresses too, but not."
> >>> 
> >>> Does it even make sense to mix IPv4 and IPv6 addresses on the same
> >>> connection?
> >>> I don't remember ever seeing both types of address in a message,
> >>> but may not have looked.
> >> 
> >> That's an interesting question.  Do the RFCs say anything?  I would
> >> assume it was ok unless ipv6only was set.
> >> 
> >>> 
> >>> I also wonder whether the connection should be dropped for an error
> >>> response on a path that has never been validated.
> >> 
> >> That actually bothered me a bit more.  Shouldn't it stay up if any path
> >> is up?  That's kind of the whole point of multihoming.
> > 
> > Michael explained it on the other email. What he described is what I
> > observed in my tests.
> > 
> >> 
> >>> 
> >>> OTOH the whole 'multi-homing' part of SCTP sucks.
> >> 
> >> I don't think so.
> >> 
> >>> The IP addresses a server needs to bind to depend on where the
> >>> incoming connection will come from.
> >>> A local connection may be able to use a 192.168.x.x address
> >>> but a remote connection must not - as it may be defined locally
> >>> at the remote system.
> >>> But both connections can come into the public (routable) address.
> >>> We have to tell customers to explicitly configure the local IP
> >>> addresses - which means the application has to know what they are.
> >>> Fortunately these apps are pretty static - usually M3UA.
> >> 
> >> Umm, no,  If you have a private address, it better be behind a firewall,
> >> and the firewall should handle rewriting the packet to fix the addresses.
> >> 
> >> It doesn't appear that Linux netfilter does this.  There is a TODO in
> >> the code for this.  But that's how it *should* work.
> > 
> > Right, we don't support SCTP aware NAT [1].
> > 
> > 1.https://tools.ietf.org/html/draft-stewart-behave-sctpnat-04
> The current version is: https://tools.ietf.org/html/draft-ietf-tsvwg-natsupp-16

Thanks!

> 
> Another possibility for NAT traversal is UDP encapsulation...

Also not supported.. :-]

Best regards,
Marcelo

> 
> Best regards
> Michael
> > 
> >  Marcelo
> > 
> >> 
> >> -corey
> >> 
> >>> 
> >>> 	David
> >>> 
> >>> -
> >>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> >>> Registration No: 1397386 (Wales)
> >>> 
> 
