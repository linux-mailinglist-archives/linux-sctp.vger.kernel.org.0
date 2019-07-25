Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390FB74359
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2019 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfGYCjl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 22:39:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44498 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389231AbfGYCjl (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 22:39:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so16613407qtg.11
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 19:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7LtBpMYBywjW4zgc/v5lWg+pOGMmbM+USRxL9ktTyiQ=;
        b=OQ9GCXRJEsII9GqRHDdz2uXhhgs250hhy5QDLknJ/yiKOpQD+5zf0HN7YGY1dHkRLs
         54VLGBqW7Rz7kmiqbDs5mYwyOgT9djIhvXULTDKE8kGkPP8qIog4zxqivWkuv/ubo7e6
         6WATc6fshHRbRLPqgpVcK03DYPj7EQ6rMLssKQkUzXHB21Q5Q61QTbiASx2FgrezKb/Y
         iuRARr4p96Y5hz9B1EvR3g1/dEjNknY9yZSiIMGyNQWex4YzYQJuQzSVqst5FAIFRCt6
         +6JTOTxRH1TCj/8bHDSVFGd1MBJuKcqe2gv/eZ91ASdFrcd2qQmjV9woVcTK0yY+2IGS
         POMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7LtBpMYBywjW4zgc/v5lWg+pOGMmbM+USRxL9ktTyiQ=;
        b=qTJJX1Xu0PiIWH6ZNCXcdocuVnraq7BLW3wAsvAMAn0OpFAjHtpAg61xGxypY0+9SE
         lf6soa0OT/bke2ifs1id7syIigF6MiFrZ4DPxm3chPntC2kKhoSwtokjYLKkzNagY5yB
         BhoIbgOOZi3DvjMJQ7x0KaLZRQlrJSPEffWTSVvwyOmgu/2d6gLCW7j8eIBUviGw5Dh2
         OEKQrTepJDAAhocslGIcrTxTWzYTA4vtriuo8l1NMGZ1BiAmYAZ8lilGq50IPvwMn15P
         YX4cmsOIuZvr8O3teidOnvK8e+OKNWmwWsHJfpcL6bM0w6uI5SlqR4RTEwlL1t7V8qk1
         bZGA==
X-Gm-Message-State: APjAAAVzXlRGMPlfJq52TznS34VjVrgLQ5PFEvP79s1Wpxq3JVGR1QNi
        tbRhrrIvNHieWiu2ubMSOHYCuFFOSeF6gQ==
X-Google-Smtp-Source: APXvYqyF2mhj+2+bODDFa9Q1ke1DdIbnCHoHXH28JKRDQoeZ5pVh1ygHKTsrGeKI7C+r7n154vq3+A==
X-Received: by 2002:ac8:32a1:: with SMTP id z30mr61057563qta.117.1564022379683;
        Wed, 24 Jul 2019 19:39:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:2135:7c3d:d61c:7f11:969d])
        by smtp.gmail.com with ESMTPSA id t2sm27913408qth.33.2019.07.24.19.39.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 19:39:38 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 7E595C0AAD; Wed, 24 Jul 2019 23:39:36 -0300 (-03)
Date:   Wed, 24 Jul 2019 23:39:36 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Ji Jianwen <jijianwen@gmail.com>
Cc:     Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 lksctp-tools] testlib: improve test_bind function
Message-ID: <20190725023936.GC4064@localhost.localdomain>
References: <20190724103930.13727-1-jijianwen@gmail.com>
 <20190724113836.GB7212@hmswarspite.think-freely.org>
 <20190724124046.GE6204@localhost.localdomain>
 <CAGWhr0BONvwwVmSLAmbnOhQhxu-HPR-e3V6xfcvTmoOxHX73Tg@mail.gmail.com>
 <20190725021243.GB4064@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725021243.GB4064@localhost.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 24, 2019 at 11:12:43PM -0300, Marcelo Ricardo Leitner wrote:
> On Thu, Jul 25, 2019 at 09:04:33AM +0800, Ji Jianwen wrote:
> > On Wed, Jul 24, 2019 at 8:40 PM Marcelo Ricardo Leitner
> > <marcelo.leitner@gmail.com> wrote:
> > >
> > > On Wed, Jul 24, 2019 at 07:38:36AM -0400, Neil Horman wrote:
> > > > On Wed, Jul 24, 2019 at 06:39:30PM +0800, Jianwen Ji wrote:
> > > > > Try to bind again if the errno is EADDRINUSE.
> > > > > Some tests failed to run sometimes, here is one snapshot:
> > > > >
> > > > >    ...
> > > > >
> > > > >    test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
> > > > >    test_sockopt.c 26 BROK : bind: Address already in use
> > > > >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > > > >
> > > > >    ...
> > > > >
> > > > >    test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EPIPE
> > > > >    test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
> > > > >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > > > >
> > > > > The reason is that it closed a socket and then created a new socket
> > > > > to bind the same socket address as before, which was not released
> > > > > yet.
> > > > >
> > > > > Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
> > > > > ---
> > > > >  src/testlib/sctputil.h | 24 +++++++++++++++++++++---
> > > > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> > > > > index 9dbabd4..5b807c7 100644
> > > > > --- a/src/testlib/sctputil.h
> > > > > +++ b/src/testlib/sctputil.h
> > > > > @@ -54,6 +54,7 @@
> > > > >  #endif
> > > > >
> > > > >  #include <string.h>
> > > > > +#include <unistd.h>
> > > > >
> > > > >  typedef union {
> > > > >     struct sockaddr_in v4;
> > > > > @@ -72,6 +73,10 @@ typedef union {
> > > > >  #endif
> > > > >  #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
> > > > >
> > > > > +#ifndef MAX_BIND_RETRYS
> > > > > +#define MAX_BIND_RETRYS 10
> > > > > +#endif
> > > > > +
> > > > >  #define SCTP_IP_BCAST      htonl(0xffffffff)
> > > > >  #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
> > > > >
> > > > > @@ -140,9 +145,22 @@ static inline int test_socket(int domain, int type, int protocol)
> > > > >
> > > > >  static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
> > > > >  {
> > > > > -   int error = bind(sk, addr, addrlen);
> > > > > -        if (-1 == error)
> > > > > -                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > > > +   int error = 0, i = 0;
> > > > > +
> > > > > +   do {
> > > > > +           if (i > 0) sleep(1); /* sleep a while before new try... */
> > > > > +
> > > > > +           error = bind(sk, addr, addrlen);
> > > > > +           if (-1 == error && errno != EADDRINUSE) {
> > > > > +                   tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > > > +           }
> > > > > +
> > > > > +           i++;
> > > > > +           if (i >= MAX_BIND_RETRYS) {
> > > > > +                   tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > > > +           }
> > > > > +   } while (error < 0 && i < MAX_BIND_RETRYS);
> > > > > +
> > > > >     return error;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.14.5
> > > > >
> > > > >
> > > > I don't think this is really going to do much.  If a socket isnt released then
> > > > its not likely to be released in the amount of time it takes to iterate over
> > > > this loop 10 times, and theres no guarantee that it will in the future.  If we
> > > > want to ensure avoid EADDRINUSE, the second bind should probably just use
> > > > SCTP_TESTPORT_2, instead of reusing _1
> > >
> > > Agree. I'll go farther: if the test doesn't have a strict need on a
> > > specific port number, it should let the kernel assign one. That way it
> > > will also stress the port allocator.  Most of the tests can bind
> > > without specifying a port and then ask which port it got.
> > >
> > >   Marcelo
> > 
> > That would be great if we make test not depend on specific port number.
> > Please help look into it.
> > Take test_sockopt.c for example:
> >  733
> >  734         close(udp_svr_sk);
> >  735         close(udp_clt_sk);
> >  736
> >  737
> >  738         /* TEST #6: SCTP_DEFAULT_SEND_PARAM socket option. */
> >  739         /* Create and bind 2 UDP-style sockets(udp_svr_sk, udp_clt_sk) and
> >  740          * 2 TCP-style sockets. (tcp_svr_sk, tcp_clt_sk)
> >  741          */
> >  742         udp_svr_sk = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
> >  743         udp_clt_sk = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
> > 
> >                 ...
> > 
> >  753         test_bind(udp_svr_sk, &udp_svr_loop.sa, sizeof(udp_svr_loop));
> >  754         test_bind(udp_clt_sk, &udp_clt_loop.sa, sizeof(udp_clt_loop));
> > 
> > It closes 2 sockets at line 734 and 735, then next test item binds the
> > same socket addresses again at line 753 and 754.
> 
> That's what it does now but does it have to be the same addresses?
> 
> > If run this program in a loop, the EADDRINUSE error will definitely
> > happen at some point.
> >       while true; do
> >            ./test_sockopt
> >            [ $? -ne 0 ] && exit
> >       done
> 
> Yep.
> 
> What about something like the below. In theory the getsockaddr result
> should be equivalent to what was passed to the function, and thus can
> be used by a subsequent call to connect().
> 
> (The additional include breaks the build, btw)
> 
> diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> index 9dbabd4762e0..e18d5b55110b 100644
> --- a/src/testlib/sctputil.h
> +++ b/src/testlib/sctputil.h
> @@ -54,6 +54,7 @@
>  #endif
>  
>  #include <string.h>
> +#include <arpa/inet.h>

This is not needed.. it was for a previous version on which I had used
ntohs() to return the allocated port number to the app.

>  
>  typedef union {
>  	struct sockaddr_in v4;	
> @@ -146,6 +147,28 @@ static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
>  	return error;
>  }
>  
> +static inline int test_bind_freeport(int sk, struct sockaddr *addr, socklen_t addrlen)
> +{
> +	struct sockaddr sa;
> +	int error;
> +
> +	if (sa.sa_family == AF_INET)
> +		((struct sockaddr_in *)addr)->sin_port = 0;
> +	else if (sa.sa_family == AF_INET6)
> +		((struct sockaddr_in6 *)addr)->sin6_port = 0;
> +
> +	error = test_bind(sk, addr, addrlen);
> +        if (-1 == error)
> +		return error;
> +
> +	addrlen = sizeof(sa);
> +	error = getsockname(sk, &sa, &addrlen);
> +	if (-1 == error)
> +                tst_brkm(TBROK, tst_exit, "getsockname: %s", strerror(errno));
> +
> +	return error;
> +}
> +
>  static inline int test_bindx_add(int sk, struct sockaddr *addr, int count)
>  {
>  	int error = sctp_bindx(sk, addr, count, SCTP_BINDX_ADD_ADDR);
> 
