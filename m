Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90B203D44
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2020 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgFVQ6D (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 Jun 2020 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgFVQ6D (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 Jun 2020 12:58:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885FC061573;
        Mon, 22 Jun 2020 09:58:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so16235376oic.8;
        Mon, 22 Jun 2020 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+l+Wc7r3ZFJFwCHq4nS699ytoJwtaAaFD5baah39A1c=;
        b=a8fTGTu3kUS15M7IcoUCf+kAfxVphYsRyTN3Vc3Ag5sO/XbFBQlaRufSawzMGKdW2G
         8bpurzQFvfIIp3myQGZ0PL8+2L5Y6h7wqxVvXuhi2qY7f6e/61jQhRKbK/sEgH0nUEId
         Jn/NJ0QV8DmK0CihrmNi8l8NlNQ2TCpKq9ohbV8gs66GfAY1F5/mnb1NjqGm4qco0jL/
         1tjWyMVWEcVGCv+kvFS+kqHCfF9a7DBfqeQe9UdgWYHZ5I0qAuHQeq/zSDg6dJNkVfV6
         Sp3dxaQx2Z9FUSw+jahvC+KJ0+1MBIFIyKBl3EnSfxKgd9WZOqVLvP8bDn21fkO/fCib
         fdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=+l+Wc7r3ZFJFwCHq4nS699ytoJwtaAaFD5baah39A1c=;
        b=AdEDf4c1drMtj93WH2AYPBCA+XSbpq6RQdk+ThyJtCAF7QpwbhzbHYNw7R9PVxcHcb
         y81T6oDZu1oCMM8fYRxe6PzhJ3lb0dB4ZfpH9uwJef8ZG1u56BwpgPbhpUBHB3UI97vd
         yBVNYCkjD+VCAF30771iSjElvlANbJyI6d2xasQij9jCSD/F85YbEP7NUpvleak6B0gN
         kQbGw5I0vef4OwNp0N1DXDhKIFtx6slyfEMBP8H1AVhW3p+YZI2gt7OGuOHtBvg4aUzd
         mIvpzSmigedwVF5kUlQfvQMOhUBalr/uKKvftLsTTckxD58NMw+NJMTl5KoABKjBfWJ/
         ioNw==
X-Gm-Message-State: AOAM531SE/Z9G9F1G+bwJhLi8uNQewkB+eVQmHp5/hXYCkJNkortkz4p
        nLs6iL/qrfvPLTFtML/pzysP/RQ=
X-Google-Smtp-Source: ABdhPJyOiJfEJYGWN2iFHyfyoWX/sLHv8+2Kq17jW48fGc4O5a0YrLc5SyG8ntW/IXD/sLaR6QNIjw==
X-Received: by 2002:aca:1308:: with SMTP id e8mr12433059oii.119.1592845082342;
        Mon, 22 Jun 2020 09:58:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id c1sm3445226otn.81.2020.06.22.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:58:01 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:acca:171:3424:849f])
        by serve.minyard.net (Postfix) with ESMTPSA id 59F5B18003A;
        Mon, 22 Jun 2020 16:58:00 +0000 (UTC)
Date:   Mon, 22 Jun 2020 11:57:59 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with SCTP+IPv6
Message-ID: <20200622165759.GA3235@minyard.net>
Reply-To: minyard@acm.org
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> >
> > I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> > sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> > then I make a connection to it using ::1, the connection will drop after
> > 2.5 seconds with an ECONNRESET error.
> >
> > It only happens on SCTP, it doesn't have the issue if you connect to a
> > full IPv6 address instead of ::1, and it doesn't happen if you don't
> > set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> > I tried on an ARM system and x86_64.
> >
> > I haven't dug into the kernel to see if I could find anything yet, but I
> > thought I would go ahead and report it.  I am attaching a reproducer.
> > Basically, compile the following code:
> The code only set IPV6_V6ONLY on server side, so the client side will
> still bind all the local ipv4 addresses (as you didn't call bind() to
> bind any specific addresses ). Then after the connection is created,
> the client will send HB on the v4 paths to the server. The server
> will abort the connection, as it can't support v4.
> 
> So you can work around it by either:
> 
>   - set IPV6_V6ONLY on client side.
> 
> or
> 
>   - bind to the specific v6 addresses on the client side.
> 
> I don't see RFC said something about this.
> So it may not be a good idea to change the current behaviour
> to not establish the connection in this case, which may cause regression.

Ok, I understand this.  It's a little strange, but I see why it works
this way.

Thanks,

-corey

> 
> >
> >   gcc -g -o sctptest -Wall sctptest.c
> >
> > and run it in one window as a server:
> >
> >   ./sctptest a
> >
> > (Pass in any option to be the server) and run the following in another
> > window as the client:
> >
> >   ./sctptest
> >
> > It disconnects after about 2.5 seconds.  If it works, it should just sit
> > there forever.
> >
> > -corey
> >
> >
> > #include <stdio.h>
> > #include <stdbool.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <sys/select.h>
> > #include <arpa/inet.h>
> > #include <netinet/sctp.h>
> > #include <sys/types.h>
> > #include <sys/socket.h>
> > #include <netdb.h>
> >
> > static int
> > getaddr(const char *addr, const char *port, bool listen,
> >         struct addrinfo **rai)
> > {
> >     struct addrinfo *ai, hints;
> >
> >     memset(&hints, 0, sizeof(hints));
> >     hints.ai_flags = AI_ADDRCONFIG;
> >     if (listen)
> >         hints.ai_flags |= AI_PASSIVE;
> >     hints.ai_family = AF_UNSPEC;
> >     hints.ai_socktype = SOCK_STREAM;
> >     hints.ai_protocol = IPPROTO_SCTP;
> >     if (getaddrinfo(addr, port, &hints, &ai)) {
> >         perror("getaddrinfo");
> >         return -1;
> >     }
> >
> >     *rai = ai;
> >     return 0;
> > }
> >
> > static int
> > waitread(int s)
> > {
> >     char data[1];
> >     ssize_t rv;
> >
> >     rv = read(s, data, sizeof(data));
> >     if (rv == -1) {
> >         perror("read");
> >         return -1;
> >     }
> >     printf("Read %d bytes\n", (int) rv);
> >     return 0;
> > }
> >
> > static int
> > do_server(void)
> > {
> >     int err, ls, s, optval;
> >     struct addrinfo *ai;
> >
> >     printf("Server\n");
> >
> >     err = getaddr("::", "3023", true, &ai);
> >     if (err)
> >         return err;
> >
> >     ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> >     if (ls == -1) {
> >         perror("socket");
> >         return -1;
> >     }
> >
> >     optval = 1;
> >     if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
> >                    (void *)&optval, sizeof(optval)) == -1) {
> >         perror("setsockopt reuseaddr");
> >         return -1;
> >     }
> >
> >     /* Comment this out and it will work. */
> >     if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
> >                    sizeof(optval)) == -1) {
> >         perror("setsockopt ipv6 only");
> >         return -1;
> >     }
> >
> >     err = bind(ls, ai->ai_addr, ai->ai_addrlen);
> >     if (err == -1) {
> >         perror("bind");
> >         return -1;
> >     }
> >
> >     err = listen(ls, 5);
> >     if (err == -1) {
> >         perror("listen");
> >         return -1;
> >     }
> >
> >     s = accept(ls, NULL, NULL);
> >     if (s == -1) {
> >         perror("accept");
> >         return -1;
> >     }
> >
> >     close(ls);
> >
> >     err = waitread(s);
> >     close(s);
> >     return err;
> > }
> >
> > static int
> > do_client(void)
> > {
> >     int err, s;
> >     struct addrinfo *ai;
> >
> >     printf("Client\n");
> >
> >     err = getaddr("::1", "3023", false, &ai);
> >     if (err)
> >         return err;
> >
> >     s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> >     if (s == -1) {
> >         perror("socket");
> >         return -1;
> >     }
> >
> >     err = connect(s, ai->ai_addr, ai->ai_addrlen);
> >     if (err == -1) {
> >         perror("connect");
> >         return -1;
> >     }
> >
> >     err = waitread(s);
> >     close(s);
> >     return err;
> > }
> >
> > int
> > main(int argc, char *argv[])
> > {
> >     int err;
> >
> >     if (argc > 1)
> >         err = do_server();
> >     else
> >         err = do_client();
> >     return !!err;
> > }
> >
