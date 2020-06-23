Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC1204EBB
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbgFWKEh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Jun 2020 06:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbgFWKEh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Jun 2020 06:04:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE21C061573;
        Tue, 23 Jun 2020 03:04:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so19886953wrc.7;
        Tue, 23 Jun 2020 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9iZ53HE98jIxj16iTgxPZ/MDpRlNPMhNdthLzxHHeY=;
        b=Dzy1UUj6IJQkEPKqWKg4Gr9A4EIxsSjtktIGEXCX5WU/KU8JTPJcnQZ1FjvFugd9iu
         97XS5fRj1Ys/AX/LGsJc/CwEWQeGn8Wun2p28h0gekvTvuVqT/ySFw1jx/W/0wb9m+7o
         62XwAEanMfEChlWGmYw5MRxjtPYml/ftzJc2EbPsDKE5aSl31dldJ5rgoHRpnTbpSpB6
         1rrm81M73jfga/rLnhFRzdSW42lw0q6WY7OiU7PYPx11T9NTBYh0TJVjhWBdnLVhg9YX
         X5ID6uVlDU4abfBUbQjyqiD9BtJHGZjMCIdSflysp1YMy79uSI+C/iZDYtwqARyQyogw
         VyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9iZ53HE98jIxj16iTgxPZ/MDpRlNPMhNdthLzxHHeY=;
        b=ElqXLdXpAog0QaCeRSeUPBJdRLoe7Mo0TMoxIzbA9mYrwZrGG9x2NWelJJ28d6hH49
         icCCoANELrXGqNON9TQd0QNIwDrleNhi5AdlHQFk7Qg2f4l/WtzSydXlZe71DkKYTkTl
         yvCMFHMyLzJOMWyZwF430yLGukEpUxqeGGipkP4gMaCVbQTZ0zSvo/AIM8GhMGTd7dg2
         V9JJCdKSyzuLC2GrSsXianrg3PCByiYzpZVafX/nirZe2gIDmtptJ6Go+BvTO+UlXh/4
         vV1kXtszYJJW/uSjQj2PO/2y7XXT7vi7QT+Dh0zZa1PN80vJl0kldmvAoU9ukjRa6rY6
         7mwQ==
X-Gm-Message-State: AOAM5316lQuoFw+DqbzDU1G757S7zzB7JNHpqvEZ6ZB2y5UTu2TdvQlR
        6PXsSksnBzfchrbDznwaOr+7k6c7UOPPk6mwtGU=
X-Google-Smtp-Source: ABdhPJypjCL2IwaVPL46bWQsQdrRdGqUaXSy6QHMr0n7tpmXeiC+0uVzsCIouvJprzx6MPCFo6mPoxc9ijpAu6Tgxew=
X-Received: by 2002:adf:f34e:: with SMTP id e14mr24096924wrp.299.1592906675929;
 Tue, 23 Jun 2020 03:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200621155604.GA23135@minyard.net> <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net> <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain> <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
In-Reply-To: <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 23 Jun 2020 18:13:30 +0800
Message-ID: <CADvbK_fddQiOJUVJNkJuxkzQ9V-tpk_ATBP4NpZ2rZketHEFcg@mail.gmail.com>
Subject: Re: Strange problem with SCTP+IPv6
To:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        minyard@acm.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jun 23, 2020 at 2:34 AM Michael Tuexen
<Michael.Tuexen@lurchi.franken.de> wrote:
>
> > On 22. Jun 2020, at 20:32, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> >
> > On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> >>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> >>>
> >>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> >>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> >>>>>
> >>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> >>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> >>>>> then I make a connection to it using ::1, the connection will drop after
> >>>>> 2.5 seconds with an ECONNRESET error.
> >>>>>
> >>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
> >>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> >>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> >>>>> I tried on an ARM system and x86_64.
> >>>>>
> >>>>> I haven't dug into the kernel to see if I could find anything yet, but I
> >>>>> thought I would go ahead and report it.  I am attaching a reproducer.
> >>>>> Basically, compile the following code:
> >>>> The code only set IPV6_V6ONLY on server side, so the client side will
> >>>> still bind all the local ipv4 addresses (as you didn't call bind() to
> >>>> bind any specific addresses ). Then after the connection is created,
> >>>> the client will send HB on the v4 paths to the server. The server
> >>>> will abort the connection, as it can't support v4.
> >>>>
> >>>> So you can work around it by either:
> >>>>
> >>>> - set IPV6_V6ONLY on client side.
> >>>>
> >>>> or
> >>>>
> >>>> - bind to the specific v6 addresses on the client side.
> >>>>
> >>>> I don't see RFC said something about this.
> >>>> So it may not be a good idea to change the current behaviour
> >>>> to not establish the connection in this case, which may cause regression.
> >>>
> >>> Ok, I understand this.  It's a little strange, but I see why it works
> >>> this way.
> >> I don't. I would expect it to work as I described in my email.
> >> Could someone explain me how and why it is behaving different from
> >> my expectation?
> >
> > It looks like a bug to me. Testing with this test app here, I can see
> > the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> > that's unexpected for a v6only socket. As is, it's the server saying
> > "I'm available at these other addresses too, but not."
> I agree.
Then we need a fix in sctp_bind_addrs_to_raw():

@@ -238,6 +240,9 @@ union sctp_params sctp_bind_addrs_to_raw(const
struct sctp_bind_addr *bp,
        addrparms = retval;

        list_for_each_entry(addr, &bp->address_list, list) {
+               if ((PF_INET6 == sk->sk_family) && inet_v6_ipv6only(sk) &&
+                   (AF_INET == addr->a.sa.sa_family))
+                       continue;
                af = sctp_get_af_specific(addr->a.v4.sin_family);
                len = af->to_addr_param(&addr->a, &rawaddr);
                memcpy(addrparms.v, &rawaddr, len);

>
> Best regards
> Michael
> >
> > Thanks,
> > Marcelo
> >
> >>
> >> Best regards
> >> Michael
> >>>
> >>> Thanks,
> >>>
> >>> -corey
> >>>
> >>>>
> >>>>>
> >>>>> gcc -g -o sctptest -Wall sctptest.c
> >>>>>
> >>>>> and run it in one window as a server:
> >>>>>
> >>>>> ./sctptest a
> >>>>>
> >>>>> (Pass in any option to be the server) and run the following in another
> >>>>> window as the client:
> >>>>>
> >>>>> ./sctptest
> >>>>>
> >>>>> It disconnects after about 2.5 seconds.  If it works, it should just sit
> >>>>> there forever.
> >>>>>
> >>>>> -corey
> >>>>>
> >>>>>
> >>>>> #include <stdio.h>
> >>>>> #include <stdbool.h>
> >>>>> #include <string.h>
> >>>>> #include <unistd.h>
> >>>>> #include <fcntl.h>
> >>>>> #include <sys/select.h>
> >>>>> #include <arpa/inet.h>
> >>>>> #include <netinet/sctp.h>
> >>>>> #include <sys/types.h>
> >>>>> #include <sys/socket.h>
> >>>>> #include <netdb.h>
> >>>>>
> >>>>> static int
> >>>>> getaddr(const char *addr, const char *port, bool listen,
> >>>>>       struct addrinfo **rai)
> >>>>> {
> >>>>>   struct addrinfo *ai, hints;
> >>>>>
> >>>>>   memset(&hints, 0, sizeof(hints));
> >>>>>   hints.ai_flags = AI_ADDRCONFIG;
> >>>>>   if (listen)
> >>>>>       hints.ai_flags |= AI_PASSIVE;
> >>>>>   hints.ai_family = AF_UNSPEC;
> >>>>>   hints.ai_socktype = SOCK_STREAM;
> >>>>>   hints.ai_protocol = IPPROTO_SCTP;
> >>>>>   if (getaddrinfo(addr, port, &hints, &ai)) {
> >>>>>       perror("getaddrinfo");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   *rai = ai;
> >>>>>   return 0;
> >>>>> }
> >>>>>
> >>>>> static int
> >>>>> waitread(int s)
> >>>>> {
> >>>>>   char data[1];
> >>>>>   ssize_t rv;
> >>>>>
> >>>>>   rv = read(s, data, sizeof(data));
> >>>>>   if (rv == -1) {
> >>>>>       perror("read");
> >>>>>       return -1;
> >>>>>   }
> >>>>>   printf("Read %d bytes\n", (int) rv);
> >>>>>   return 0;
> >>>>> }
> >>>>>
> >>>>> static int
> >>>>> do_server(void)
> >>>>> {
> >>>>>   int err, ls, s, optval;
> >>>>>   struct addrinfo *ai;
> >>>>>
> >>>>>   printf("Server\n");
> >>>>>
> >>>>>   err = getaddr("::", "3023", true, &ai);
> >>>>>   if (err)
> >>>>>       return err;
> >>>>>
> >>>>>   ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> >>>>>   if (ls == -1) {
> >>>>>       perror("socket");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   optval = 1;
> >>>>>   if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
> >>>>>                  (void *)&optval, sizeof(optval)) == -1) {
> >>>>>       perror("setsockopt reuseaddr");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   /* Comment this out and it will work. */
> >>>>>   if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
> >>>>>                  sizeof(optval)) == -1) {
> >>>>>       perror("setsockopt ipv6 only");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   err = bind(ls, ai->ai_addr, ai->ai_addrlen);
> >>>>>   if (err == -1) {
> >>>>>       perror("bind");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   err = listen(ls, 5);
> >>>>>   if (err == -1) {
> >>>>>       perror("listen");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   s = accept(ls, NULL, NULL);
> >>>>>   if (s == -1) {
> >>>>>       perror("accept");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   close(ls);
> >>>>>
> >>>>>   err = waitread(s);
> >>>>>   close(s);
> >>>>>   return err;
> >>>>> }
> >>>>>
> >>>>> static int
> >>>>> do_client(void)
> >>>>> {
> >>>>>   int err, s;
> >>>>>   struct addrinfo *ai;
> >>>>>
> >>>>>   printf("Client\n");
> >>>>>
> >>>>>   err = getaddr("::1", "3023", false, &ai);
> >>>>>   if (err)
> >>>>>       return err;
> >>>>>
> >>>>>   s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> >>>>>   if (s == -1) {
> >>>>>       perror("socket");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   err = connect(s, ai->ai_addr, ai->ai_addrlen);
> >>>>>   if (err == -1) {
> >>>>>       perror("connect");
> >>>>>       return -1;
> >>>>>   }
> >>>>>
> >>>>>   err = waitread(s);
> >>>>>   close(s);
> >>>>>   return err;
> >>>>> }
> >>>>>
> >>>>> int
> >>>>> main(int argc, char *argv[])
> >>>>> {
> >>>>>   int err;
> >>>>>
> >>>>>   if (argc > 1)
> >>>>>       err = do_server();
> >>>>>   else
> >>>>>       err = do_client();
> >>>>>   return !!err;
> >>>>> }
> >>>>>
> >>
>
