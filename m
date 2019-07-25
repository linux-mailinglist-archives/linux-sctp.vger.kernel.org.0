Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1B74320
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2019 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfGYCMs (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 22:12:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43798 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbfGYCMs (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 22:12:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so9645187qka.10
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1O8NAYWvHR9DuGnkHE7NLjcMqFjIzljIAE32UQA9n48=;
        b=aOF07qUNrS2+BNLVCauANUhVSjXDDUsauULqqPRULbA1aCVMRfTlpl2NGJ1pH218jG
         Py010qR/bSh6Dyh4qJu8T+BjEZTmy7VZmdea1HAihepr3Nb4NlC+pjDjRp3E85473xxj
         7UjlZ7TJnygtMSemtcM+caCJuh3lmPUrlZkKWbs/aojH4pmmbRV4+w+HZyUwCQZ6N24v
         h8DamBQzEJ6iF/2qwpoMEXb9LLaFIDP7efUxYigyJzqPBYJe/GJR1eQBCrl9AqFN4Ats
         l3/d8jZ6O3b5lVyF5tqub6c5U6rfT+PiqCNqlzAnNzVFE9Es/kdcE9VxRaqaKwrcWITA
         mM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1O8NAYWvHR9DuGnkHE7NLjcMqFjIzljIAE32UQA9n48=;
        b=aEzR6WJ0RtM7TuSbkm3atW7vYulEgFyiLEYl7R1zbzyvrlWG1N36am798Hi/KvMRw/
         QvLcRieYPn83c+b3KcbUT016H3kfBv/uCLrvD33GktgCtgc22v/L6GPc1qxIID9mncrP
         0XKgs4UgSMuoSvuYDShm1g8ozOqssjmGEX37jYA2Nc3HxUh3T0E3IK7larpYg7YqI1Y+
         vX3qvWFzTaQlnchVez2i21yZVIYxLtvW4uz4WZaqfx6LOJklTRruwhJ8O8SfnO3GOheb
         S1H6h9rEpmXMUn7V3KyjVHq0sWZIhNTmzXwJn81sG7j6Z6mfSiAlpC5+BNVJvrBLBWLZ
         Fw0Q==
X-Gm-Message-State: APjAAAXT0dd0Cj0uQFHTKLHPsm738qKXh77CuhA27QHvlb0MI9NMZ0ds
        0SaPRprgqxFZMcBlWdBeKbA=
X-Google-Smtp-Source: APXvYqyHS9WAiuDPi0cSS5aIGJMO0BAOfqPJ/6qwYYldKls95iZ3Uwc/Q8REMZ6FN8ezMaeOKzfh5A==
X-Received: by 2002:ae9:ed4f:: with SMTP id c76mr56483552qkg.154.1564020767121;
        Wed, 24 Jul 2019 19:12:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:2135:7c3d:d61c:7f11:969d])
        by smtp.gmail.com with ESMTPSA id z19sm22385187qtu.43.2019.07.24.19.12.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 19:12:46 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id E1070C0AAD; Wed, 24 Jul 2019 23:12:43 -0300 (-03)
Date:   Wed, 24 Jul 2019 23:12:43 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Ji Jianwen <jijianwen@gmail.com>
Cc:     Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 lksctp-tools] testlib: improve test_bind function
Message-ID: <20190725021243.GB4064@localhost.localdomain>
References: <20190724103930.13727-1-jijianwen@gmail.com>
 <20190724113836.GB7212@hmswarspite.think-freely.org>
 <20190724124046.GE6204@localhost.localdomain>
 <CAGWhr0BONvwwVmSLAmbnOhQhxu-HPR-e3V6xfcvTmoOxHX73Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWhr0BONvwwVmSLAmbnOhQhxu-HPR-e3V6xfcvTmoOxHX73Tg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Jul 25, 2019 at 09:04:33AM +0800, Ji Jianwen wrote:
> On Wed, Jul 24, 2019 at 8:40 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Wed, Jul 24, 2019 at 07:38:36AM -0400, Neil Horman wrote:
> > > On Wed, Jul 24, 2019 at 06:39:30PM +0800, Jianwen Ji wrote:
> > > > Try to bind again if the errno is EADDRINUSE.
> > > > Some tests failed to run sometimes, here is one snapshot:
> > > >
> > > >    ...
> > > >
> > > >    test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
> > > >    test_sockopt.c 26 BROK : bind: Address already in use
> > > >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > > >
> > > >    ...
> > > >
> > > >    test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EPIPE
> > > >    test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
> > > >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > > >
> > > > The reason is that it closed a socket and then created a new socket
> > > > to bind the same socket address as before, which was not released
> > > > yet.
> > > >
> > > > Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
> > > > ---
> > > >  src/testlib/sctputil.h | 24 +++++++++++++++++++++---
> > > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> > > > index 9dbabd4..5b807c7 100644
> > > > --- a/src/testlib/sctputil.h
> > > > +++ b/src/testlib/sctputil.h
> > > > @@ -54,6 +54,7 @@
> > > >  #endif
> > > >
> > > >  #include <string.h>
> > > > +#include <unistd.h>
> > > >
> > > >  typedef union {
> > > >     struct sockaddr_in v4;
> > > > @@ -72,6 +73,10 @@ typedef union {
> > > >  #endif
> > > >  #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
> > > >
> > > > +#ifndef MAX_BIND_RETRYS
> > > > +#define MAX_BIND_RETRYS 10
> > > > +#endif
> > > > +
> > > >  #define SCTP_IP_BCAST      htonl(0xffffffff)
> > > >  #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
> > > >
> > > > @@ -140,9 +145,22 @@ static inline int test_socket(int domain, int type, int protocol)
> > > >
> > > >  static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
> > > >  {
> > > > -   int error = bind(sk, addr, addrlen);
> > > > -        if (-1 == error)
> > > > -                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > > +   int error = 0, i = 0;
> > > > +
> > > > +   do {
> > > > +           if (i > 0) sleep(1); /* sleep a while before new try... */
> > > > +
> > > > +           error = bind(sk, addr, addrlen);
> > > > +           if (-1 == error && errno != EADDRINUSE) {
> > > > +                   tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > > +           }
> > > > +
> > > > +           i++;
> > > > +           if (i >= MAX_BIND_RETRYS) {
> > > > +                   tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > > > +           }
> > > > +   } while (error < 0 && i < MAX_BIND_RETRYS);
> > > > +
> > > >     return error;
> > > >  }
> > > >
> > > > --
> > > > 2.14.5
> > > >
> > > >
> > > I don't think this is really going to do much.  If a socket isnt released then
> > > its not likely to be released in the amount of time it takes to iterate over
> > > this loop 10 times, and theres no guarantee that it will in the future.  If we
> > > want to ensure avoid EADDRINUSE, the second bind should probably just use
> > > SCTP_TESTPORT_2, instead of reusing _1
> >
> > Agree. I'll go farther: if the test doesn't have a strict need on a
> > specific port number, it should let the kernel assign one. That way it
> > will also stress the port allocator.  Most of the tests can bind
> > without specifying a port and then ask which port it got.
> >
> >   Marcelo
> 
> That would be great if we make test not depend on specific port number.
> Please help look into it.
> Take test_sockopt.c for example:
>  733
>  734         close(udp_svr_sk);
>  735         close(udp_clt_sk);
>  736
>  737
>  738         /* TEST #6: SCTP_DEFAULT_SEND_PARAM socket option. */
>  739         /* Create and bind 2 UDP-style sockets(udp_svr_sk, udp_clt_sk) and
>  740          * 2 TCP-style sockets. (tcp_svr_sk, tcp_clt_sk)
>  741          */
>  742         udp_svr_sk = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
>  743         udp_clt_sk = test_socket(pf_class, SOCK_SEQPACKET, IPPROTO_SCTP);
> 
>                 ...
> 
>  753         test_bind(udp_svr_sk, &udp_svr_loop.sa, sizeof(udp_svr_loop));
>  754         test_bind(udp_clt_sk, &udp_clt_loop.sa, sizeof(udp_clt_loop));
> 
> It closes 2 sockets at line 734 and 735, then next test item binds the
> same socket addresses again at line 753 and 754.

That's what it does now but does it have to be the same addresses?

> If run this program in a loop, the EADDRINUSE error will definitely
> happen at some point.
>       while true; do
>            ./test_sockopt
>            [ $? -ne 0 ] && exit
>       done

Yep.

What about something like the below. In theory the getsockaddr result
should be equivalent to what was passed to the function, and thus can
be used by a subsequent call to connect().

(The additional include breaks the build, btw)

diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
index 9dbabd4762e0..e18d5b55110b 100644
--- a/src/testlib/sctputil.h
+++ b/src/testlib/sctputil.h
@@ -54,6 +54,7 @@
 #endif
 
 #include <string.h>
+#include <arpa/inet.h>
 
 typedef union {
 	struct sockaddr_in v4;	
@@ -146,6 +147,28 @@ static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
 	return error;
 }
 
+static inline int test_bind_freeport(int sk, struct sockaddr *addr, socklen_t addrlen)
+{
+	struct sockaddr sa;
+	int error;
+
+	if (sa.sa_family == AF_INET)
+		((struct sockaddr_in *)addr)->sin_port = 0;
+	else if (sa.sa_family == AF_INET6)
+		((struct sockaddr_in6 *)addr)->sin6_port = 0;
+
+	error = test_bind(sk, addr, addrlen);
+        if (-1 == error)
+		return error;
+
+	addrlen = sizeof(sa);
+	error = getsockname(sk, &sa, &addrlen);
+	if (-1 == error)
+                tst_brkm(TBROK, tst_exit, "getsockname: %s", strerror(errno));
+
+	return error;
+}
+
 static inline int test_bindx_add(int sk, struct sockaddr *addr, int count)
 {
 	int error = sctp_bindx(sk, addr, count, SCTP_BINDX_ADD_ADDR);

