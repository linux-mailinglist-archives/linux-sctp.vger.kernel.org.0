Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF9206D61
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2020 09:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbgFXHQj (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jun 2020 03:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbgFXHQi (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jun 2020 03:16:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0DC061573;
        Wed, 24 Jun 2020 00:16:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so1155477wrq.8;
        Wed, 24 Jun 2020 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7ltB2wIu9w7N6oRmPGG0O0ircJFysHeSYEyKw8UzAQ=;
        b=NQNz5rhcpnjCc7xAGe0E1vVM+aTK84C6WU740uH5mwmDz1yrTHlMRNAMjLJSP7zNSL
         JzqarpJ0yobG2oNGzM5zmviAoh/9wDe7KIyQv1Qjf0Rd5kDp5a+PGr6Z2RWlLymYZh5J
         k9OB+3KhXpj4xhJzbSO98g6Z4PsrEIrg/0VUt7sGQ0I8u8ulgZdpJYfnOMPuCKdsTBER
         8GEmFYb3k13yAYtAo/nUh4gSq05CQFs8lwCEO8E7QGDzyEvbWkuZdLfUAX7WdVDoqg5x
         WQHE8DP4vsjh1cJR8PD4MfaIX06hi/DxZTyg0PjHVYg/fOCaP6s+shBBRDHcpJ4sFtgr
         aj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7ltB2wIu9w7N6oRmPGG0O0ircJFysHeSYEyKw8UzAQ=;
        b=ZFlEm6hsiY0keEwRb/rF5S9rVpaotNLcWlAE6i8EWCtk58wWcHgKkyhUqfEBKZYnzs
         6WXZmHyezK1F5h1CVoiCFGyOFzQ27CfPrs15CZJPxQwbbdbSocuhp1T2cddMg8EY8f5V
         AzcRT683VvojzQkcAAGh31IEH1aKMPvE3HG8OaNoWOK0UaAVa4jesy+E5y1V2rxD/yBM
         Pos9l7mb8W+Sm7cQ2pGuPdfxAYJ+aStVSenaBjmKAgjBKPVyJf3myI+NdSDD4hPsMq+e
         rDLS02IeAZXpCmYongm3q43vqiP5IxnGkUyl+Vxg/ESucuKBglP0r4SPY2B+GdrwdUtf
         T6nA==
X-Gm-Message-State: AOAM530E/xQjaCwqhiNbwelBIQCyXF0rgkvVbr8KaXJc70lfT/qolIa6
        zRqd8vgSkHdvKX1E2OOJObPZA6sVAb2cf5JMAAUWI0wGtig=
X-Google-Smtp-Source: ABdhPJwXO//e8Qhk/LpBjbxdv1g00Rjo0rOjAsD9Fu0/4KwlvWFO5nckGAYTQHQcJCgedAWgsxFQQMsoWrAJ6rpZMWM=
X-Received: by 2002:a5d:4611:: with SMTP id t17mr28140393wrq.243.1592982996921;
 Wed, 24 Jun 2020 00:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200621155604.GA23135@minyard.net> <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net> <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain> <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
 <20200623161756.GE3235@minyard.net> <20200623212143.GR2491@localhost.localdomain>
 <C4F6EDBE-CCAE-4635-AD96-9C2E2582F1B3@lurchi.franken.de> <20200623213102.GS2491@localhost.localdomain>
 <42823598-7B01-4C62-B896-ACC4449F3AFF@lurchi.franken.de>
In-Reply-To: <42823598-7B01-4C62-B896-ACC4449F3AFF@lurchi.franken.de>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 24 Jun 2020 15:25:34 +0800
Message-ID: <CADvbK_cXsS7_kYifCqMRcedtNgG0hNmgrf33+hkkjmK7xjAP=A@mail.gmail.com>
Subject: Re: Strange problem with SCTP+IPv6
To:     Michael Tuexen <michael.tuexen@lurchi.franken.de>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Corey Minyard <minyard@acm.org>,
        David Laight <David.Laight@aculab.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jun 24, 2020 at 5:48 AM Michael Tuexen
<michael.tuexen@lurchi.franken.de> wrote:
>
> > On 23. Jun 2020, at 23:31, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> >
> > On Tue, Jun 23, 2020 at 11:24:59PM +0200, Michael Tuexen wrote:
> >>> On 23. Jun 2020, at 23:21, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> >>>
> >>> On Tue, Jun 23, 2020 at 11:17:56AM -0500, Corey Minyard wrote:
> >>>> On Tue, Jun 23, 2020 at 01:17:28PM +0000, David Laight wrote:
> >>>>> From: Marcelo Ricardo Leitner
> >>>>>> Sent: 22 June 2020 19:33
> >>>>>> On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> >>>>>>>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> >>>>>>>>
> >>>>>>>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> >>>>>>>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> >>>>>>>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> >>>>>>>>>> then I make a connection to it using ::1, the connection will drop after
> >>>>>>>>>> 2.5 seconds with an ECONNRESET error.
> >>>>>>>>>>
> >>>>>>>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
> >>>>>>>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> >>>>>>>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> >>>>>>>>>> I tried on an ARM system and x86_64.
> >>>>>>>>>>
> >>>>>>>>>> I haven't dug into the kernel to see if I could find anything yet, but I
> >>>>>>>>>> thought I would go ahead and report it.  I am attaching a reproducer.
> >>>>>>>>>> Basically, compile the following code:
> >>>>>>>>> The code only set IPV6_V6ONLY on server side, so the client side will
> >>>>>>>>> still bind all the local ipv4 addresses (as you didn't call bind() to
> >>>>>>>>> bind any specific addresses ). Then after the connection is created,
> >>>>>>>>> the client will send HB on the v4 paths to the server. The server
> >>>>>>>>> will abort the connection, as it can't support v4.
> >>>>>>>>>
> >>>>>>>>> So you can work around it by either:
> >>>>>>>>>
> >>>>>>>>> - set IPV6_V6ONLY on client side.
> >>>>>>>>>
> >>>>>>>>> or
> >>>>>>>>>
> >>>>>>>>> - bind to the specific v6 addresses on the client side.
> >>>>>>>>>
> >>>>>>>>> I don't see RFC said something about this.
> >>>>>>>>> So it may not be a good idea to change the current behaviour
> >>>>>>>>> to not establish the connection in this case, which may cause regression.
> >>>>>>>>
> >>>>>>>> Ok, I understand this.  It's a little strange, but I see why it works
> >>>>>>>> this way.
> >>>>>>> I don't. I would expect it to work as I described in my email.
> >>>>>>> Could someone explain me how and why it is behaving different from
> >>>>>>> my expectation?
> >>>>>>
> >>>>>> It looks like a bug to me. Testing with this test app here, I can see
> >>>>>> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> >>>>>> that's unexpected for a v6only socket. As is, it's the server saying
> >>>>>> "I'm available at these other addresses too, but not."
> >>>>>
> >>>>> Does it even make sense to mix IPv4 and IPv6 addresses on the same
> >>>>> connection?
> >>>>> I don't remember ever seeing both types of address in a message,
> >>>>> but may not have looked.
> >>>>
> >>>> That's an interesting question.  Do the RFCs say anything?  I would
> >>>> assume it was ok unless ipv6only was set.
> >>>>
> >>>>>
> >>>>> I also wonder whether the connection should be dropped for an error
> >>>>> response on a path that has never been validated.
> >>>>
> >>>> That actually bothered me a bit more.  Shouldn't it stay up if any path
> >>>> is up?  That's kind of the whole point of multihoming.
> >>>
> >>> Michael explained it on the other email. What he described is what I
> >>> observed in my tests.
> >>>
> >>>>
> >>>>>
> >>>>> OTOH the whole 'multi-homing' part of SCTP sucks.
> >>>>
> >>>> I don't think so.
> >>>>
> >>>>> The IP addresses a server needs to bind to depend on where the
> >>>>> incoming connection will come from.
> >>>>> A local connection may be able to use a 192.168.x.x address
> >>>>> but a remote connection must not - as it may be defined locally
> >>>>> at the remote system.
> >>>>> But both connections can come into the public (routable) address.
> >>>>> We have to tell customers to explicitly configure the local IP
> >>>>> addresses - which means the application has to know what they are.
> >>>>> Fortunately these apps are pretty static - usually M3UA.
> >>>>
> >>>> Umm, no,  If you have a private address, it better be behind a firewall,
> >>>> and the firewall should handle rewriting the packet to fix the addresses.
> >>>>
> >>>> It doesn't appear that Linux netfilter does this.  There is a TODO in
> >>>> the code for this.  But that's how it *should* work.
> >>>
> >>> Right, we don't support SCTP aware NAT [1].
> >>>
> >>> 1.https://tools.ietf.org/html/draft-stewart-behave-sctpnat-04
> >> The current version is: https://tools.ietf.org/html/draft-ietf-tsvwg-natsupp-16
> >
> > Thanks!
> >
> >>
> >> Another possibility for NAT traversal is UDP encapsulation...
> >
> > Also not supported.. :-]
> But maybe someone wants to implement it. It is supported by FreeBSD, if you
> need a peer for testing. Or the userland stack usrsctp supports it. Then you
> do not need root privileges to run it.
You mean SCTP_REMOTE_UDP_ENCAPS_PORT sockopt, right?
We have this in our to-do list. I mixed rfc6951 with the userland one.
Will prioritize this feature. Thanks.

>
> Best regards
> Michael
> >
> > Best regards,
> > Marcelo
> >
> >>
> >> Best regards
> >> Michael
> >>>
> >>> Marcelo
> >>>
> >>>>
> >>>> -corey
> >>>>
> >>>>>
> >>>>>   David
> >>>>>
> >>>>> -
> >>>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> >>>>> Registration No: 1397386 (Wales)
> >>>>>
> >>
>
