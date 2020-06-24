Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E946A206CFE
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2020 08:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389133AbgFXGuA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jun 2020 02:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbgFXGt7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jun 2020 02:49:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA0C061573;
        Tue, 23 Jun 2020 23:49:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so1098483wru.6;
        Tue, 23 Jun 2020 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nilaAGZMvb6+HKhad+/LvyWqOhj7qxSUkR0bZtCLV0g=;
        b=gmJjhSrmiC4LDj12aIm/+OKhwPMFSU0PebLRii1CChCfJ9jJdRkY9L3jmsovQJS6bp
         8H220/kaG/XXXquKW8djV65nDQieOPuFeAqOTUr5GyenTcC3eLSmDTZvhS6b32+L2Jg0
         DySZ5eHcbxZQP5ukpgSuI53BWpxTHhkDKA572WAcO+CXtFfUom5qwGAIfhlmLynwqmBG
         axWorKxpY1OlCo9mWcXL/WsDWXvKieft5wznrK6sapfDhaHSkDqleS82caOHJmJGbfqa
         oouRvGaiWYnQcthzuGh5kMM25DPEaSBkqDD+PAOsTD09SfUZu/uJuVNEfmoKb9bqwYc3
         c/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nilaAGZMvb6+HKhad+/LvyWqOhj7qxSUkR0bZtCLV0g=;
        b=aKjMa9qVwPb6ODgI3O3ZlsZ7oTN5tSkJnix3lSMbbczEHSHWu1pVO0waf5i6tAq3QT
         Fwu6iUjD+CVIOntlVgmiJfjl4bfVzmSXpAldsEPeh75uiDwyAoVCrtx/Hhp4E3MTXBh9
         VbdT40qcY5+btvfvyRsipZrX70RzpHU8rOBA9+0g2dR5WlC4GPgQoq6TxAR1z0rwqXDI
         2oTA+86flWkit+37Fqz69MfsjhWjCKwLItnFfBxtybFKYcmzizt+/yrStmRTKRYoscuM
         Enhx2JTnZN01MncARlYfL/deQq04wPhs90WlwZNFyTvcmAK/nRm2NGPTTCAr61LIo9GE
         mgLw==
X-Gm-Message-State: AOAM5320TxthYHS4rstcQjmfkOml5zxY26by7P5v8qGRBJmIeZSf1WjP
        yG1jEZptv9QVijs7VAIBRY+qLQGNE1BCSWVlmFA=
X-Google-Smtp-Source: ABdhPJxUQow8ly0wMzlr5GWSR9kSidJCZ6dIAMFUflEAIuOd3a0CgwkN5/k2K86u2LAA9ipC5QzN5Q0v+jsVvN3rzc4=
X-Received: by 2002:adf:fa89:: with SMTP id h9mr28978156wrr.120.1592981397900;
 Tue, 23 Jun 2020 23:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200621155604.GA23135@minyard.net> <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net> <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain> <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
 <CADvbK_fddQiOJUVJNkJuxkzQ9V-tpk_ATBP4NpZ2rZketHEFcg@mail.gmail.com>
 <20200623132936.GC3235@minyard.net> <CADvbK_cmFXPcKRNcnNLx3at=yaO53E=6dvzqwvC6UoS+Q2tMJg@mail.gmail.com>
 <20200623160036.GD3235@minyard.net>
In-Reply-To: <20200623160036.GD3235@minyard.net>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 24 Jun 2020 14:58:46 +0800
Message-ID: <CADvbK_d96rr7pyC8Czm4ovQvP6nu7W6mY_g83h6xf8QsCk1saA@mail.gmail.com>
Subject: Re: Strange problem with SCTP+IPv6
To:     minyard@acm.org
Cc:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jun 24, 2020 at 12:00 AM Corey Minyard <minyard@acm.org> wrote:
>
> On Tue, Jun 23, 2020 at 11:40:21PM +0800, Xin Long wrote:
> > On Tue, Jun 23, 2020 at 9:29 PM Corey Minyard <minyard@acm.org> wrote:
> > >
> > > On Tue, Jun 23, 2020 at 06:13:30PM +0800, Xin Long wrote:
> > > > On Tue, Jun 23, 2020 at 2:34 AM Michael Tuexen
> > > > <Michael.Tuexen@lurchi.franken.de> wrote:
> > > > >
> > > > > > On 22. Jun 2020, at 20:32, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> > > > > >>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> > > > > >>>
> > > > > >>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> > > > > >>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> > > > > >>>>>
> > > > > >>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> > > > > >>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> > > > > >>>>> then I make a connection to it using ::1, the connection will drop after
> > > > > >>>>> 2.5 seconds with an ECONNRESET error.
> > > > > >>>>>
> > > > > >>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
> > > > > >>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> > > > > >>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> > > > > >>>>> I tried on an ARM system and x86_64.
> > > > > >>>>>
> > > > > >>>>> I haven't dug into the kernel to see if I could find anything yet, but I
> > > > > >>>>> thought I would go ahead and report it.  I am attaching a reproducer.
> > > > > >>>>> Basically, compile the following code:
> > > > > >>>> The code only set IPV6_V6ONLY on server side, so the client side will
> > > > > >>>> still bind all the local ipv4 addresses (as you didn't call bind() to
> > > > > >>>> bind any specific addresses ). Then after the connection is created,
> > > > > >>>> the client will send HB on the v4 paths to the server. The server
> > > > > >>>> will abort the connection, as it can't support v4.
> > > > > >>>>
> > > > > >>>> So you can work around it by either:
> > > > > >>>>
> > > > > >>>> - set IPV6_V6ONLY on client side.
> > > > > >>>>
> > > > > >>>> or
> > > > > >>>>
> > > > > >>>> - bind to the specific v6 addresses on the client side.
> > > > > >>>>
> > > > > >>>> I don't see RFC said something about this.
> > > > > >>>> So it may not be a good idea to change the current behaviour
> > > > > >>>> to not establish the connection in this case, which may cause regression.
> > > > > >>>
> > > > > >>> Ok, I understand this.  It's a little strange, but I see why it works
> > > > > >>> this way.
> > > > > >> I don't. I would expect it to work as I described in my email.
> > > > > >> Could someone explain me how and why it is behaving different from
> > > > > >> my expectation?
> > > > > >
> > > > > > It looks like a bug to me. Testing with this test app here, I can see
> > > > > > the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> > > > > > that's unexpected for a v6only socket. As is, it's the server saying
> > > > > > "I'm available at these other addresses too, but not."
> > > > > I agree.
> > > > Then we need a fix in sctp_bind_addrs_to_raw():
> > > >
> > > > @@ -238,6 +240,9 @@ union sctp_params sctp_bind_addrs_to_raw(const
> > > > struct sctp_bind_addr *bp,
> > > >         addrparms = retval;
> > > >
> > > >         list_for_each_entry(addr, &bp->address_list, list) {
> > > > +               if ((PF_INET6 == sk->sk_family) && inet_v6_ipv6only(sk) &&
> > > > +                   (AF_INET == addr->a.sa.sa_family))
> > > > +                       continue;
> > >
> > > This does not compile in the latest mainline.  sk is not defined.
> > > Also, if you could send a normal git patch, that would be easier to
> > > manage.
> > sorry, that was just the code to show the idea.
> >
> > For the compilable one, pls see:
> > https://paste.centos.org/view/49f5ff5a
>
> The kernel community runs on patches.  It's hard to talk about changes
> if you put things in pastbin type of stuff.  Please send full complete
> patches in emails.  I will do that in a moment.
I thought you wanted a temporary patch to run your test.

The final patch still needs some change, like drop the *bp param
even from sctp_make_init().

>
> Anyway, are use sure every bp passed into sctp_bind_addrs_to_raw()
> is &asoc->base.bind_addr?  It's passed in to sctp_make_init() and the
> passed to sctp_bind_addrs_to_raw().  If this is the case, you can remove
> it from the parameters of sctp_make_init().  But I suspect it's passed
> in for a reason.
This is not difficult to track.
path 1:
sctp_sf_do_5_2_6_stale()/sctp_sf_do_prm_asoc()/
sctp_sf_t1_init_timer_expire() ->
  sctp_make_init() -> sctp_bind_addrs_to_raw()

path 2:
sctp_make_init_ack() -> sctp_bind_addrs_to_raw().

If you think there must be a reason for this,
I think it's they may just pass a minimal-structure pointer.

>
> Anyway, I have a patch I have compiled and tested, I will send that.
>
> -corey
>
> >
> > Thanks.
> > >
> > > Thanks,
> > >
> > > -corey
> > >
> > > >                 af = sctp_get_af_specific(addr->a.v4.sin_family);
> > > >                 len = af->to_addr_param(&addr->a, &rawaddr);
> > > >                 memcpy(addrparms.v, &rawaddr, len);
> > > >
> > > > >
> > > > > Best regards
> > > > > Michael
> > > > > >
> > > > > > Thanks,
> > > > > > Marcelo
> > > > > >
> > > > > >>
> > > > > >> Best regards
> > > > > >> Michael
> > > > > >>>
> > > > > >>> Thanks,
> > > > > >>>
> > > > > >>> -corey
> > > > > >>>
> > > > > >>>>
> > > > > >>>>>
> > > > > >>>>> gcc -g -o sctptest -Wall sctptest.c
> > > > > >>>>>
> > > > > >>>>> and run it in one window as a server:
> > > > > >>>>>
> > > > > >>>>> ./sctptest a
> > > > > >>>>>
> > > > > >>>>> (Pass in any option to be the server) and run the following in another
> > > > > >>>>> window as the client:
> > > > > >>>>>
> > > > > >>>>> ./sctptest
> > > > > >>>>>
> > > > > >>>>> It disconnects after about 2.5 seconds.  If it works, it should just sit
> > > > > >>>>> there forever.
> > > > > >>>>>
> > > > > >>>>> -corey
> > > > > >>>>>
> > > > > >>>>>
> > > > > >>>>> #include <stdio.h>
> > > > > >>>>> #include <stdbool.h>
> > > > > >>>>> #include <string.h>
> > > > > >>>>> #include <unistd.h>
> > > > > >>>>> #include <fcntl.h>
> > > > > >>>>> #include <sys/select.h>
> > > > > >>>>> #include <arpa/inet.h>
> > > > > >>>>> #include <netinet/sctp.h>
> > > > > >>>>> #include <sys/types.h>
> > > > > >>>>> #include <sys/socket.h>
> > > > > >>>>> #include <netdb.h>
> > > > > >>>>>
> > > > > >>>>> static int
> > > > > >>>>> getaddr(const char *addr, const char *port, bool listen,
> > > > > >>>>>       struct addrinfo **rai)
> > > > > >>>>> {
> > > > > >>>>>   struct addrinfo *ai, hints;
> > > > > >>>>>
> > > > > >>>>>   memset(&hints, 0, sizeof(hints));
> > > > > >>>>>   hints.ai_flags = AI_ADDRCONFIG;
> > > > > >>>>>   if (listen)
> > > > > >>>>>       hints.ai_flags |= AI_PASSIVE;
> > > > > >>>>>   hints.ai_family = AF_UNSPEC;
> > > > > >>>>>   hints.ai_socktype = SOCK_STREAM;
> > > > > >>>>>   hints.ai_protocol = IPPROTO_SCTP;
> > > > > >>>>>   if (getaddrinfo(addr, port, &hints, &ai)) {
> > > > > >>>>>       perror("getaddrinfo");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   *rai = ai;
> > > > > >>>>>   return 0;
> > > > > >>>>> }
> > > > > >>>>>
> > > > > >>>>> static int
> > > > > >>>>> waitread(int s)
> > > > > >>>>> {
> > > > > >>>>>   char data[1];
> > > > > >>>>>   ssize_t rv;
> > > > > >>>>>
> > > > > >>>>>   rv = read(s, data, sizeof(data));
> > > > > >>>>>   if (rv == -1) {
> > > > > >>>>>       perror("read");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>   printf("Read %d bytes\n", (int) rv);
> > > > > >>>>>   return 0;
> > > > > >>>>> }
> > > > > >>>>>
> > > > > >>>>> static int
> > > > > >>>>> do_server(void)
> > > > > >>>>> {
> > > > > >>>>>   int err, ls, s, optval;
> > > > > >>>>>   struct addrinfo *ai;
> > > > > >>>>>
> > > > > >>>>>   printf("Server\n");
> > > > > >>>>>
> > > > > >>>>>   err = getaddr("::", "3023", true, &ai);
> > > > > >>>>>   if (err)
> > > > > >>>>>       return err;
> > > > > >>>>>
> > > > > >>>>>   ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> > > > > >>>>>   if (ls == -1) {
> > > > > >>>>>       perror("socket");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   optval = 1;
> > > > > >>>>>   if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
> > > > > >>>>>                  (void *)&optval, sizeof(optval)) == -1) {
> > > > > >>>>>       perror("setsockopt reuseaddr");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   /* Comment this out and it will work. */
> > > > > >>>>>   if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
> > > > > >>>>>                  sizeof(optval)) == -1) {
> > > > > >>>>>       perror("setsockopt ipv6 only");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   err = bind(ls, ai->ai_addr, ai->ai_addrlen);
> > > > > >>>>>   if (err == -1) {
> > > > > >>>>>       perror("bind");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   err = listen(ls, 5);
> > > > > >>>>>   if (err == -1) {
> > > > > >>>>>       perror("listen");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   s = accept(ls, NULL, NULL);
> > > > > >>>>>   if (s == -1) {
> > > > > >>>>>       perror("accept");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   close(ls);
> > > > > >>>>>
> > > > > >>>>>   err = waitread(s);
> > > > > >>>>>   close(s);
> > > > > >>>>>   return err;
> > > > > >>>>> }
> > > > > >>>>>
> > > > > >>>>> static int
> > > > > >>>>> do_client(void)
> > > > > >>>>> {
> > > > > >>>>>   int err, s;
> > > > > >>>>>   struct addrinfo *ai;
> > > > > >>>>>
> > > > > >>>>>   printf("Client\n");
> > > > > >>>>>
> > > > > >>>>>   err = getaddr("::1", "3023", false, &ai);
> > > > > >>>>>   if (err)
> > > > > >>>>>       return err;
> > > > > >>>>>
> > > > > >>>>>   s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> > > > > >>>>>   if (s == -1) {
> > > > > >>>>>       perror("socket");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   err = connect(s, ai->ai_addr, ai->ai_addrlen);
> > > > > >>>>>   if (err == -1) {
> > > > > >>>>>       perror("connect");
> > > > > >>>>>       return -1;
> > > > > >>>>>   }
> > > > > >>>>>
> > > > > >>>>>   err = waitread(s);
> > > > > >>>>>   close(s);
> > > > > >>>>>   return err;
> > > > > >>>>> }
> > > > > >>>>>
> > > > > >>>>> int
> > > > > >>>>> main(int argc, char *argv[])
> > > > > >>>>> {
> > > > > >>>>>   int err;
> > > > > >>>>>
> > > > > >>>>>   if (argc > 1)
> > > > > >>>>>       err = do_server();
> > > > > >>>>>   else
> > > > > >>>>>       err = do_client();
> > > > > >>>>>   return !!err;
> > > > > >>>>> }
> > > > > >>>>>
> > > > > >>
> > > > >
