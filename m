Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B33742BD
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2019 03:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGYBEr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 21:04:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42542 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGYBEr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 21:04:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so46295473lje.9
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 18:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yixvdcrj94wZXhNDWKbNKYQtb5quYsGFgzceMwzFWE=;
        b=UuEbVCgLipB2YTaLneGFM0k9rQLI4gQWb+klvExvamZCiByNvf6od823OaeYN/C95z
         CRLGPlhnV4VaLv9QeyEA2z6B5OIFObDkUVbVMA38MvAS8k6b+H29ho79gqte1Ck1CpAK
         XlLq8Cd1SSyLeFzAxIh7X1mBb0eex73p79EXFy1z/iMHCThp12Ql13H2TZZGce4/Vxyh
         fIRPv4pNgncsDqIQqAeTdZ8rSpH491oFX8cVQj1ZL6zEenSHxaq2z7T/n3sV8i/o/JYc
         Y8n7i7XHc3qi7FiLXH8wdcK/NiNaJsk2uUrCYijfXaDH1oCz0yYLOeBcIshzvnF5577h
         gjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yixvdcrj94wZXhNDWKbNKYQtb5quYsGFgzceMwzFWE=;
        b=dEsLKLGSK8Qk0R4cuVx/FOB60+9iv8E2uA20i9tb4t1HkE95J+oZKPlSbdurNaZGe3
         8iHHOYe34c1zDi/s4G9h92d7afddJNxCTaPLZiHBQj3e5ueoEFO6ORFEPCFSWp5ry3Ap
         iyJLgBHB6Uvg1YQrD3wTGWMnYx8aNzfolTW4UDBMvC2ekgUcwfoioNVN3Tle65rJG9CA
         jV+LNRUkzHx2Wr7GLjQ+OR98sP7rJCz9L5jEXBTYG+VqZcnzS0tH76XYnjQj7KhyHOU6
         rDc5bJBdfMxgV0hnGQRkCyoVwKYe8UN/TFXu4jWt2KPufrp6zn6WbMkhlc6wGffsYXtK
         OxQQ==
X-Gm-Message-State: APjAAAUwnOWpNxrNI4g4gdAs92mzaXmPLeuK++Imj6ud5RBlKKT+kaVg
        MCj6KgKmjYa+QpeSISW07EH6VMLcVXgUerXvNvY=
X-Google-Smtp-Source: APXvYqxruJTnRle4vaAWUh80XFNcouBG24mGvXATm1ssq+sJnl/4DqonW1w2ZHlfuYb8i/XFPCgyIdpG4TepL5arBuI=
X-Received: by 2002:a2e:988b:: with SMTP id b11mr43907516ljj.110.1564016684487;
 Wed, 24 Jul 2019 18:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190724103930.13727-1-jijianwen@gmail.com> <20190724113836.GB7212@hmswarspite.think-freely.org>
 <20190724124046.GE6204@localhost.localdomain>
In-Reply-To: <20190724124046.GE6204@localhost.localdomain>
From:   Ji Jianwen <jijianwen@gmail.com>
Date:   Thu, 25 Jul 2019 09:04:33 +0800
Message-ID: <CAGWhr0BONvwwVmSLAmbnOhQhxu-HPR-e3V6xfcvTmoOxHX73Tg@mail.gmail.com>
Subject: Re: [PATCH v2 lksctp-tools] testlib: improve test_bind function
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 24, 2019 at 8:40 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Wed, Jul 24, 2019 at 07:38:36AM -0400, Neil Horman wrote:
> > On Wed, Jul 24, 2019 at 06:39:30PM +0800, Jianwen Ji wrote:
> > > Try to bind again if the errno is EADDRINUSE.
> > > Some tests failed to run sometimes, here is one snapshot:
> > >
> > >    ...
> > >
> > >    test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
> > >    test_sockopt.c 26 BROK : bind: Address already in use
> > >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > >
> > >    ...
> > >
> > >    test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EPIPE
> > >    test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
> > >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > >
> > > The reason is that it closed a socket and then created a new socket
> > > to bind the same socket address as before, which was not released
> > > yet.
> > >
> > > Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
> > > ---
> > >  src/testlib/sctputil.h | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> > > index 9dbabd4..5b807c7 100644
> > > --- a/src/testlib/sctputil.h
> > > +++ b/src/testlib/sctputil.h
> > > @@ -54,6 +54,7 @@
> > >  #endif
> > >
> > >  #include <string.h>
> > > +#include <unistd.h>
> > >
> > >  typedef union {
> > >     struct sockaddr_in v4;
> > > @@ -72,6 +73,10 @@ typedef union {
> > >  #endif
> > >  #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
> > >
> > > +#ifndef MAX_BIND_RETRYS
> > > +#define MAX_BIND_RETRYS 10
> > > +#endif
> > > +
> > >  #define SCTP_IP_BCAST      htonl(0xffffffff)
> > >  #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
> > >
> > > @@ -140,9 +145,22 @@ static inline int test_socket(int domain, int type, int protocol)
> > >
> > >  static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
> > >  {
> > > -   int error = bind(sk, addr, addrlen);
> > > -        if (-1 == error)
> > > -                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > +   int error = 0, i = 0;
> > > +
> > > +   do {
> > > +           if (i > 0) sleep(1); /* sleep a while before new try... */
> > > +
> > > +           error = bind(sk, addr, addrlen);
> > > +           if (-1 == error && errno != EADDRINUSE) {
> > > +                   tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > +           }
> > > +
> > > +           i++;
> > > +           if (i >= MAX_BIND_RETRYS) {
> > > +                   tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > +           }
> > > +   } while (error < 0 && i < MAX_BIND_RETRYS);
> > > +
> > >     return error;
> > >  }
> > >
> > > --
> > > 2.14.5
> > >
> > >
> > I don't think this is really going to do much.  If a socket isnt released then
> > its not likely to be released in the amount of time it takes to iterate over
> > this loop 10 times, and theres no guarantee that it will in the future.  If we
> > want to ensure avoid EADDRINUSE, the second bind should probably just use
> > SCTP_TESTPORT_2, instead of reusing _1
>
> Agree. I'll go farther: if the test doesn't have a strict need on a
> specific port number, it should let the kernel assign one. That way it
> will also stress the port allocator.  Most of the tests can bind
> without specifying a port and then ask which port it got.
>
>   Marcelo

That would be great if we make test not depend on specific port number.
Please help look into it.
Take test_sockopt.c for example:
 733
 734         close(udp_svr_sk);
 735         close(udp_clt_sk);
 736
 737
 738         /* TEST #6: SCTP_DEFAULT_SEND_PARAM socket option. */
 739         /* Create and bind 2 UDP-style sockets(udp_svr_sk, udp_clt_sk) and
 740          * 2 TCP-style sockets. (tcp_svr_sk, tcp_clt_sk)
 741          */
 742         udp_svr_sk = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
 743         udp_clt_sk = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);

                ...

 753         test_bind(udp_svr_sk, &udp_svr_loop.sa, sizeof(udp_svr_loop));
 754         test_bind(udp_clt_sk, &udp_clt_loop.sa, sizeof(udp_clt_loop));

It closes 2 sockets at line 734 and 735, then next test item binds the
same socket addresses again at line 753 and 754.
If run this program in a loop, the EADDRINUSE error will definitely
happen at some point.
      while true; do
           ./test_sockopt
           [ $? -ne 0 ] && exit
      done

Br,
Jianwen
