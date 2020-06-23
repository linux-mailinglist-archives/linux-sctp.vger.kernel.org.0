Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179302056AE
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgFWQAm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Jun 2020 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732988AbgFWQAk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Jun 2020 12:00:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D1C061573;
        Tue, 23 Jun 2020 09:00:39 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so2450754otv.6;
        Tue, 23 Jun 2020 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eip/xlixgvzKCgojaqpJHsQJzey6PhkEiClQfOT+Lmk=;
        b=UC+9OIGUiYUP7LACCpwagFKlAt71IvQB1PnsB6O0CE1cdljSXqoZV9OGGNlssFBqbn
         As/d5O6vPrCE/fqEA3kk/nw2DOcJP/ttVxt628MLOsj0T8boDqkelmphFlS54DKFLasC
         cujowXT+y+sTe1Ge3nm0o2C11A3kbOal44zQMOGnvyB2iMwgT6a7bnY4BklAYFk5Otts
         W13T/f7XjRzx0rTdTbslztFBlIF7kXyzBvD/XNRZAZMyzjW92u90Fush8FlKGdEXhfSH
         PmU8zMg2v5a/aCAx/i2Xzmt0c2P/g9XgN/yE/Ae6Jrl3TzEZVGEf+CD8LsSkY3o/waFj
         Gasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Eip/xlixgvzKCgojaqpJHsQJzey6PhkEiClQfOT+Lmk=;
        b=FEV0htDg8YmWIB9xDHzXSYKGLglObNS21WBfRE8m0FX4M1N+5OZotIBR9C+wVCoIe2
         SuRGPbQyIAc7JFbJb+2IMh9Q2N6Xk/ktDGZs+GJLHqEbmI3IuNVCnZ6Px/33PBBxyKew
         9fSTT3s5YANuWcI3d/2d2Y9vddFtbqi8KK113DCK11sGcTPzSLKXgRaNxIQ8Yz5I5yO+
         Fiw+sgO3zLJkkhCaZHtMa9aCEYR6Zr0MMaN9wqRmrl4bvmfJKh/8TNZCuS3o6yz/EkNJ
         xBRMg5as2kpp3rwR5xW6xrPUKR/O0d94NNMUtJILppKcyyl1lPrp9pgNfwU2Hk1dM42F
         QQ0A==
X-Gm-Message-State: AOAM531bFfUpJqkaEiYS+nNVecCpxEWwHq83Y+EU5LSLXITHHg7FieRP
        YsCQfO5NkfX5WlcFNJglmA==
X-Google-Smtp-Source: ABdhPJx8TY2ntBLBeMttSnqmHGPNTdA+gSufa+DHgQXXVmsZXvK00VYQOc57HF2K4TrhKzw8lOO+Sw==
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr6056699otp.160.1592928038941;
        Tue, 23 Jun 2020 09:00:38 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id d72sm1781651oob.15.2020.06.23.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:00:38 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6d79:306:b4b0:35c1])
        by serve.minyard.net (Postfix) with ESMTPSA id 50DFD1800CC;
        Tue, 23 Jun 2020 16:00:37 +0000 (UTC)
Date:   Tue, 23 Jun 2020 11:00:36 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with SCTP+IPv6
Message-ID: <20200623160036.GD3235@minyard.net>
Reply-To: minyard@acm.org
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
 <CADvbK_fddQiOJUVJNkJuxkzQ9V-tpk_ATBP4NpZ2rZketHEFcg@mail.gmail.com>
 <20200623132936.GC3235@minyard.net>
 <CADvbK_cmFXPcKRNcnNLx3at=yaO53E=6dvzqwvC6UoS+Q2tMJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_cmFXPcKRNcnNLx3at=yaO53E=6dvzqwvC6UoS+Q2tMJg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jun 23, 2020 at 11:40:21PM +0800, Xin Long wrote:
> On Tue, Jun 23, 2020 at 9:29 PM Corey Minyard <minyard@acm.org> wrote:
> >
> > On Tue, Jun 23, 2020 at 06:13:30PM +0800, Xin Long wrote:
> > > On Tue, Jun 23, 2020 at 2:34 AM Michael Tuexen
> > > <Michael.Tuexen@lurchi.franken.de> wrote:
> > > >
> > > > > On 22. Jun 2020, at 20:32, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> > > > >
> > > > > On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> > > > >>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> > > > >>>
> > > > >>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> > > > >>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> > > > >>>>>
> > > > >>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> > > > >>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> > > > >>>>> then I make a connection to it using ::1, the connection will drop after
> > > > >>>>> 2.5 seconds with an ECONNRESET error.
> > > > >>>>>
> > > > >>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
> > > > >>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> > > > >>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> > > > >>>>> I tried on an ARM system and x86_64.
> > > > >>>>>
> > > > >>>>> I haven't dug into the kernel to see if I could find anything yet, but I
> > > > >>>>> thought I would go ahead and report it.  I am attaching a reproducer.
> > > > >>>>> Basically, compile the following code:
> > > > >>>> The code only set IPV6_V6ONLY on server side, so the client side will
> > > > >>>> still bind all the local ipv4 addresses (as you didn't call bind() to
> > > > >>>> bind any specific addresses ). Then after the connection is created,
> > > > >>>> the client will send HB on the v4 paths to the server. The server
> > > > >>>> will abort the connection, as it can't support v4.
> > > > >>>>
> > > > >>>> So you can work around it by either:
> > > > >>>>
> > > > >>>> - set IPV6_V6ONLY on client side.
> > > > >>>>
> > > > >>>> or
> > > > >>>>
> > > > >>>> - bind to the specific v6 addresses on the client side.
> > > > >>>>
> > > > >>>> I don't see RFC said something about this.
> > > > >>>> So it may not be a good idea to change the current behaviour
> > > > >>>> to not establish the connection in this case, which may cause regression.
> > > > >>>
> > > > >>> Ok, I understand this.  It's a little strange, but I see why it works
> > > > >>> this way.
> > > > >> I don't. I would expect it to work as I described in my email.
> > > > >> Could someone explain me how and why it is behaving different from
> > > > >> my expectation?
> > > > >
> > > > > It looks like a bug to me. Testing with this test app here, I can see
> > > > > the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> > > > > that's unexpected for a v6only socket. As is, it's the server saying
> > > > > "I'm available at these other addresses too, but not."
> > > > I agree.
> > > Then we need a fix in sctp_bind_addrs_to_raw():
> > >
> > > @@ -238,6 +240,9 @@ union sctp_params sctp_bind_addrs_to_raw(const
> > > struct sctp_bind_addr *bp,
> > >         addrparms = retval;
> > >
> > >         list_for_each_entry(addr, &bp->address_list, list) {
> > > +               if ((PF_INET6 == sk->sk_family) && inet_v6_ipv6only(sk) &&
> > > +                   (AF_INET == addr->a.sa.sa_family))
> > > +                       continue;
> >
> > This does not compile in the latest mainline.  sk is not defined.
> > Also, if you could send a normal git patch, that would be easier to
> > manage.
> sorry, that was just the code to show the idea.
> 
> For the compilable one, pls see:
> https://paste.centos.org/view/49f5ff5a

The kernel community runs on patches.  It's hard to talk about changes
if you put things in pastbin type of stuff.  Please send full complete
patches in emails.  I will do that in a moment.

Anyway, are use sure every bp passed into sctp_bind_addrs_to_raw()
is &asoc->base.bind_addr?  It's passed in to sctp_make_init() and the
passed to sctp_bind_addrs_to_raw().  If this is the case, you can remove
it from the parameters of sctp_make_init().  But I suspect it's passed
in for a reason.

Anyway, I have a patch I have compiled and tested, I will send that.

-corey

> 
> Thanks.
> >
> > Thanks,
> >
> > -corey
> >
> > >                 af = sctp_get_af_specific(addr->a.v4.sin_family);
> > >                 len = af->to_addr_param(&addr->a, &rawaddr);
> > >                 memcpy(addrparms.v, &rawaddr, len);
> > >
> > > >
> > > > Best regards
> > > > Michael
> > > > >
> > > > > Thanks,
> > > > > Marcelo
> > > > >
> > > > >>
> > > > >> Best regards
> > > > >> Michael
> > > > >>>
> > > > >>> Thanks,
> > > > >>>
> > > > >>> -corey
> > > > >>>
> > > > >>>>
> > > > >>>>>
> > > > >>>>> gcc -g -o sctptest -Wall sctptest.c
> > > > >>>>>
> > > > >>>>> and run it in one window as a server:
> > > > >>>>>
> > > > >>>>> ./sctptest a
> > > > >>>>>
> > > > >>>>> (Pass in any option to be the server) and run the following in another
> > > > >>>>> window as the client:
> > > > >>>>>
> > > > >>>>> ./sctptest
> > > > >>>>>
> > > > >>>>> It disconnects after about 2.5 seconds.  If it works, it should just sit
> > > > >>>>> there forever.
> > > > >>>>>
> > > > >>>>> -corey
> > > > >>>>>
> > > > >>>>>
> > > > >>>>> #include <stdio.h>
> > > > >>>>> #include <stdbool.h>
> > > > >>>>> #include <string.h>
> > > > >>>>> #include <unistd.h>
> > > > >>>>> #include <fcntl.h>
> > > > >>>>> #include <sys/select.h>
> > > > >>>>> #include <arpa/inet.h>
> > > > >>>>> #include <netinet/sctp.h>
> > > > >>>>> #include <sys/types.h>
> > > > >>>>> #include <sys/socket.h>
> > > > >>>>> #include <netdb.h>
> > > > >>>>>
> > > > >>>>> static int
> > > > >>>>> getaddr(const char *addr, const char *port, bool listen,
> > > > >>>>>       struct addrinfo **rai)
> > > > >>>>> {
> > > > >>>>>   struct addrinfo *ai, hints;
> > > > >>>>>
> > > > >>>>>   memset(&hints, 0, sizeof(hints));
> > > > >>>>>   hints.ai_flags = AI_ADDRCONFIG;
> > > > >>>>>   if (listen)
> > > > >>>>>       hints.ai_flags |= AI_PASSIVE;
> > > > >>>>>   hints.ai_family = AF_UNSPEC;
> > > > >>>>>   hints.ai_socktype = SOCK_STREAM;
> > > > >>>>>   hints.ai_protocol = IPPROTO_SCTP;
> > > > >>>>>   if (getaddrinfo(addr, port, &hints, &ai)) {
> > > > >>>>>       perror("getaddrinfo");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   *rai = ai;
> > > > >>>>>   return 0;
> > > > >>>>> }
> > > > >>>>>
> > > > >>>>> static int
> > > > >>>>> waitread(int s)
> > > > >>>>> {
> > > > >>>>>   char data[1];
> > > > >>>>>   ssize_t rv;
> > > > >>>>>
> > > > >>>>>   rv = read(s, data, sizeof(data));
> > > > >>>>>   if (rv == -1) {
> > > > >>>>>       perror("read");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>   printf("Read %d bytes\n", (int) rv);
> > > > >>>>>   return 0;
> > > > >>>>> }
> > > > >>>>>
> > > > >>>>> static int
> > > > >>>>> do_server(void)
> > > > >>>>> {
> > > > >>>>>   int err, ls, s, optval;
> > > > >>>>>   struct addrinfo *ai;
> > > > >>>>>
> > > > >>>>>   printf("Server\n");
> > > > >>>>>
> > > > >>>>>   err = getaddr("::", "3023", true, &ai);
> > > > >>>>>   if (err)
> > > > >>>>>       return err;
> > > > >>>>>
> > > > >>>>>   ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> > > > >>>>>   if (ls == -1) {
> > > > >>>>>       perror("socket");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   optval = 1;
> > > > >>>>>   if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
> > > > >>>>>                  (void *)&optval, sizeof(optval)) == -1) {
> > > > >>>>>       perror("setsockopt reuseaddr");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   /* Comment this out and it will work. */
> > > > >>>>>   if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
> > > > >>>>>                  sizeof(optval)) == -1) {
> > > > >>>>>       perror("setsockopt ipv6 only");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   err = bind(ls, ai->ai_addr, ai->ai_addrlen);
> > > > >>>>>   if (err == -1) {
> > > > >>>>>       perror("bind");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   err = listen(ls, 5);
> > > > >>>>>   if (err == -1) {
> > > > >>>>>       perror("listen");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   s = accept(ls, NULL, NULL);
> > > > >>>>>   if (s == -1) {
> > > > >>>>>       perror("accept");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   close(ls);
> > > > >>>>>
> > > > >>>>>   err = waitread(s);
> > > > >>>>>   close(s);
> > > > >>>>>   return err;
> > > > >>>>> }
> > > > >>>>>
> > > > >>>>> static int
> > > > >>>>> do_client(void)
> > > > >>>>> {
> > > > >>>>>   int err, s;
> > > > >>>>>   struct addrinfo *ai;
> > > > >>>>>
> > > > >>>>>   printf("Client\n");
> > > > >>>>>
> > > > >>>>>   err = getaddr("::1", "3023", false, &ai);
> > > > >>>>>   if (err)
> > > > >>>>>       return err;
> > > > >>>>>
> > > > >>>>>   s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> > > > >>>>>   if (s == -1) {
> > > > >>>>>       perror("socket");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   err = connect(s, ai->ai_addr, ai->ai_addrlen);
> > > > >>>>>   if (err == -1) {
> > > > >>>>>       perror("connect");
> > > > >>>>>       return -1;
> > > > >>>>>   }
> > > > >>>>>
> > > > >>>>>   err = waitread(s);
> > > > >>>>>   close(s);
> > > > >>>>>   return err;
> > > > >>>>> }
> > > > >>>>>
> > > > >>>>> int
> > > > >>>>> main(int argc, char *argv[])
> > > > >>>>> {
> > > > >>>>>   int err;
> > > > >>>>>
> > > > >>>>>   if (argc > 1)
> > > > >>>>>       err = do_server();
> > > > >>>>>   else
> > > > >>>>>       err = do_client();
> > > > >>>>>   return !!err;
> > > > >>>>> }
> > > > >>>>>
> > > > >>
> > > >
