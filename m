Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67579203633
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2020 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgFVLwg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 Jun 2020 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgFVLwf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 Jun 2020 07:52:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFFBC061794;
        Mon, 22 Jun 2020 04:52:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so16364833wrr.10;
        Mon, 22 Jun 2020 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpISVvTd+xTFlOhxXYk2rxJp9Tf23LI+hiS/XMYhlaE=;
        b=LL7y/3bBHsBy8jPRmjTggK9Pvd01H/yOq66iVIm2Opquoot/8TcE06Ao3A8/uJWcQd
         lJaRu4pC5lYwFULa/npFmMVugDfQzHyaiXpPZ6AZxF3PL2LURRAp5rzc6qiJR0GTb2sN
         tVxJQX06LYiMHgtvkC4bZVxDh9eK/XUDjMDlgwCeYq5xljFeCYhW/uqUqflrU9pvjFuU
         MAAW+cGFE0Ta9Y89q5LYtHhcwHfnAQK1t71U4Y9zK3KPD+QwkNqF1MFf9iDdJt2IBV/I
         dhAliS7PiZW5aK/vou0ORVY0iaz5+qgk0dj4poC9nPH2LJ3d4EUtk93KU6t9t/TMURFz
         wuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpISVvTd+xTFlOhxXYk2rxJp9Tf23LI+hiS/XMYhlaE=;
        b=nc4G/R51oCRSMqaBim85zLHh3570E2VopMB+LhczLWVxIsoNHGZJcrkGdGjmhABus6
         GRXi86j3vpVFkw2SVy4LY7PRSKTzo3ms/Z9Lx/NMBTNt4H2rgIkochdskSQb+hpY1cNm
         Eat6ZBe18v1QZAkKeNvKa6kEjAlI8udzyfYRwfMgA5B5KyjPas3Z7f6de1zAhEba2s5V
         L3+IMf/FPJGp530/3dBWNbWrw/4X/Yhtd2KoSsdB1up4rhOU/6RLfMNIJMDxLBAQlmoZ
         G3lXGBaSGKtN2OxkqN9oBzRG57BzjT814ou+w6UuWrn3u4QNRN7VgPPH20+Lo8lHh191
         6lsw==
X-Gm-Message-State: AOAM530c3kziJvyyiPJs9YEEbcPDJEwPV0YhlC6sSMQvJg4NATYaYQ+k
        EdeH2FVyVmrK0g7vZYeZA5izA6I8T7MMSa/4XBM=
X-Google-Smtp-Source: ABdhPJyW2RGo9rZ6V9lPpTnyfAl+eUSvxaW/791PK/ud8ZQMhs7ZcidhU52nJICwCl7H2Ec0QtM5AZFExqLsydUa/6w=
X-Received: by 2002:adf:f34e:: with SMTP id e14mr18634041wrp.299.1592826753104;
 Mon, 22 Jun 2020 04:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200621155604.GA23135@minyard.net>
In-Reply-To: <20200621155604.GA23135@minyard.net>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 22 Jun 2020 20:01:23 +0800
Message-ID: <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
Subject: Re: Strange problem with SCTP+IPv6
To:     minyard@acm.org
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
>
> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> then I make a connection to it using ::1, the connection will drop after
> 2.5 seconds with an ECONNRESET error.
>
> It only happens on SCTP, it doesn't have the issue if you connect to a
> full IPv6 address instead of ::1, and it doesn't happen if you don't
> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> I tried on an ARM system and x86_64.
>
> I haven't dug into the kernel to see if I could find anything yet, but I
> thought I would go ahead and report it.  I am attaching a reproducer.
> Basically, compile the following code:
The code only set IPV6_V6ONLY on server side, so the client side will
still bind all the local ipv4 addresses (as you didn't call bind() to
bind any specific addresses ). Then after the connection is created,
the client will send HB on the v4 paths to the server. The server
will abort the connection, as it can't support v4.

So you can work around it by either:

  - set IPV6_V6ONLY on client side.

or

  - bind to the specific v6 addresses on the client side.

I don't see RFC said something about this.
So it may not be a good idea to change the current behaviour
to not establish the connection in this case, which may cause regression.

>
>   gcc -g -o sctptest -Wall sctptest.c
>
> and run it in one window as a server:
>
>   ./sctptest a
>
> (Pass in any option to be the server) and run the following in another
> window as the client:
>
>   ./sctptest
>
> It disconnects after about 2.5 seconds.  If it works, it should just sit
> there forever.
>
> -corey
>
>
> #include <stdio.h>
> #include <stdbool.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/select.h>
> #include <arpa/inet.h>
> #include <netinet/sctp.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <netdb.h>
>
> static int
> getaddr(const char *addr, const char *port, bool listen,
>         struct addrinfo **rai)
> {
>     struct addrinfo *ai, hints;
>
>     memset(&hints, 0, sizeof(hints));
>     hints.ai_flags = AI_ADDRCONFIG;
>     if (listen)
>         hints.ai_flags |= AI_PASSIVE;
>     hints.ai_family = AF_UNSPEC;
>     hints.ai_socktype = SOCK_STREAM;
>     hints.ai_protocol = IPPROTO_SCTP;
>     if (getaddrinfo(addr, port, &hints, &ai)) {
>         perror("getaddrinfo");
>         return -1;
>     }
>
>     *rai = ai;
>     return 0;
> }
>
> static int
> waitread(int s)
> {
>     char data[1];
>     ssize_t rv;
>
>     rv = read(s, data, sizeof(data));
>     if (rv == -1) {
>         perror("read");
>         return -1;
>     }
>     printf("Read %d bytes\n", (int) rv);
>     return 0;
> }
>
> static int
> do_server(void)
> {
>     int err, ls, s, optval;
>     struct addrinfo *ai;
>
>     printf("Server\n");
>
>     err = getaddr("::", "3023", true, &ai);
>     if (err)
>         return err;
>
>     ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>     if (ls == -1) {
>         perror("socket");
>         return -1;
>     }
>
>     optval = 1;
>     if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
>                    (void *)&optval, sizeof(optval)) == -1) {
>         perror("setsockopt reuseaddr");
>         return -1;
>     }
>
>     /* Comment this out and it will work. */
>     if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
>                    sizeof(optval)) == -1) {
>         perror("setsockopt ipv6 only");
>         return -1;
>     }
>
>     err = bind(ls, ai->ai_addr, ai->ai_addrlen);
>     if (err == -1) {
>         perror("bind");
>         return -1;
>     }
>
>     err = listen(ls, 5);
>     if (err == -1) {
>         perror("listen");
>         return -1;
>     }
>
>     s = accept(ls, NULL, NULL);
>     if (s == -1) {
>         perror("accept");
>         return -1;
>     }
>
>     close(ls);
>
>     err = waitread(s);
>     close(s);
>     return err;
> }
>
> static int
> do_client(void)
> {
>     int err, s;
>     struct addrinfo *ai;
>
>     printf("Client\n");
>
>     err = getaddr("::1", "3023", false, &ai);
>     if (err)
>         return err;
>
>     s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>     if (s == -1) {
>         perror("socket");
>         return -1;
>     }
>
>     err = connect(s, ai->ai_addr, ai->ai_addrlen);
>     if (err == -1) {
>         perror("connect");
>         return -1;
>     }
>
>     err = waitread(s);
>     close(s);
>     return err;
> }
>
> int
> main(int argc, char *argv[])
> {
>     int err;
>
>     if (argc > 1)
>         err = do_server();
>     else
>         err = do_client();
>     return !!err;
> }
>
