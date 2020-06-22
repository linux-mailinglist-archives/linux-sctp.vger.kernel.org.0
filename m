Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E95203F2D
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2020 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgFVSc7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 Jun 2020 14:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgFVSc6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 Jun 2020 14:32:58 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6AC061573;
        Mon, 22 Jun 2020 11:32:58 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u17so13471830qtq.1;
        Mon, 22 Jun 2020 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qa0giDewd5/BjpzZP3fXaqaIK9XPuOo7WHB9rrHW7Rc=;
        b=UGQhvkZ1r1ORRZH8XG8Md8iinMXUxgSOlwVxWaoyFSpIFJ4Fs0f7lVrEc6Bffagvkd
         gqo1A2o04ybjHdJzoBbeYWcICrHmlFRrKTXf9+1NDAcEeZuJ95vtfYs77v37x2Gp8H+y
         XzHQkO/9w8Ru07Q5UGp0Co7YWHu2R1Z5YBMKv//UKrzN6VP0fm0x7WXx+sOc+PmI9zX6
         Ym+/+pi+IjO7H4JDJz10Vsr5hwhjK00fJTvAqorFn0XGc15TbXqPvl9EGjUqCtzMVVm0
         nFq9jxB99udJxVgcsk5tXW5c71RnAbvbrDVKibdON2sqaecDzv6eEU/GXuyWAbZvNY4F
         0cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qa0giDewd5/BjpzZP3fXaqaIK9XPuOo7WHB9rrHW7Rc=;
        b=JVBHPmAwKMHm9EfnLeuNJVsTEIa18tRK9YkXolmZYCm0g+Ww6efKxH01G/p4Uj4Arn
         40kn8eG7scJdWm/OA6xXbEIoaJXDktyfAeVoPp/r2dkBUbeJMemalM0b/IrEKc75+m6P
         009jV0vrrB6MQKIrdi/JvDxWsOIjm9+UqlJKx+Me2a4gfNNzKKF5R5SEjBpEDyurm+z9
         0dAynHJhDIPk8IZ4cLOnLJ5gLpnU9sH6xmq9Q2j8wYbyzOclxj8VUWFtGF39JGp+0BDe
         VkVtIOKQ5C1r2t0k3BRswOCU4VWOA3rsrLDfJQfUzWOrFcXP/boBF7a56fbaSlMYx3fE
         IhTg==
X-Gm-Message-State: AOAM5322yI0LHri3pXFodhUcSSeN6XlbzJ1wvEdBek4VjOX96L+IEQCf
        dpLzEPfqyNjvgebUwYhxshY=
X-Google-Smtp-Source: ABdhPJzcvtzLM0af2Wlij43SJnI0LfqrdxraiQwsLE9dNdy+NeWX5630cvYvb/BCCeA1j0D7U31NPA==
X-Received: by 2002:ac8:7b5a:: with SMTP id m26mr18248709qtu.70.1592850777527;
        Mon, 22 Jun 2020 11:32:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:65e9:974:aec1:b314:98ea])
        by smtp.gmail.com with ESMTPSA id g16sm7213811qko.5.2020.06.22.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:32:56 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id E9416C163B; Mon, 22 Jun 2020 15:32:53 -0300 (-03)
Date:   Mon, 22 Jun 2020 15:32:53 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Cc:     minyard@acm.org, Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange problem with SCTP+IPv6
Message-ID: <20200622183253.GQ2491@localhost.localdomain>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
> > On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
> > 
> > On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
> >> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
> >>> 
> >>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
> >>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
> >>> then I make a connection to it using ::1, the connection will drop after
> >>> 2.5 seconds with an ECONNRESET error.
> >>> 
> >>> It only happens on SCTP, it doesn't have the issue if you connect to a
> >>> full IPv6 address instead of ::1, and it doesn't happen if you don't
> >>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
> >>> I tried on an ARM system and x86_64.
> >>> 
> >>> I haven't dug into the kernel to see if I could find anything yet, but I
> >>> thought I would go ahead and report it.  I am attaching a reproducer.
> >>> Basically, compile the following code:
> >> The code only set IPV6_V6ONLY on server side, so the client side will
> >> still bind all the local ipv4 addresses (as you didn't call bind() to
> >> bind any specific addresses ). Then after the connection is created,
> >> the client will send HB on the v4 paths to the server. The server
> >> will abort the connection, as it can't support v4.
> >> 
> >> So you can work around it by either:
> >> 
> >>  - set IPV6_V6ONLY on client side.
> >> 
> >> or
> >> 
> >>  - bind to the specific v6 addresses on the client side.
> >> 
> >> I don't see RFC said something about this.
> >> So it may not be a good idea to change the current behaviour
> >> to not establish the connection in this case, which may cause regression.
> > 
> > Ok, I understand this.  It's a little strange, but I see why it works
> > this way.
> I don't. I would expect it to work as I described in my email.
> Could someone explain me how and why it is behaving different from
> my expectation?

It looks like a bug to me. Testing with this test app here, I can see
the INIT_ACK being sent with a bunch of ipv4 addresses in it and
that's unexpected for a v6only socket. As is, it's the server saying
"I'm available at these other addresses too, but not."

Thanks,
Marcelo

> 
> Best regards
> Michael
> > 
> > Thanks,
> > 
> > -corey
> > 
> >> 
> >>> 
> >>>  gcc -g -o sctptest -Wall sctptest.c
> >>> 
> >>> and run it in one window as a server:
> >>> 
> >>>  ./sctptest a
> >>> 
> >>> (Pass in any option to be the server) and run the following in another
> >>> window as the client:
> >>> 
> >>>  ./sctptest
> >>> 
> >>> It disconnects after about 2.5 seconds.  If it works, it should just sit
> >>> there forever.
> >>> 
> >>> -corey
> >>> 
> >>> 
> >>> #include <stdio.h>
> >>> #include <stdbool.h>
> >>> #include <string.h>
> >>> #include <unistd.h>
> >>> #include <fcntl.h>
> >>> #include <sys/select.h>
> >>> #include <arpa/inet.h>
> >>> #include <netinet/sctp.h>
> >>> #include <sys/types.h>
> >>> #include <sys/socket.h>
> >>> #include <netdb.h>
> >>> 
> >>> static int
> >>> getaddr(const char *addr, const char *port, bool listen,
> >>>        struct addrinfo **rai)
> >>> {
> >>>    struct addrinfo *ai, hints;
> >>> 
> >>>    memset(&hints, 0, sizeof(hints));
> >>>    hints.ai_flags = AI_ADDRCONFIG;
> >>>    if (listen)
> >>>        hints.ai_flags |= AI_PASSIVE;
> >>>    hints.ai_family = AF_UNSPEC;
> >>>    hints.ai_socktype = SOCK_STREAM;
> >>>    hints.ai_protocol = IPPROTO_SCTP;
> >>>    if (getaddrinfo(addr, port, &hints, &ai)) {
> >>>        perror("getaddrinfo");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    *rai = ai;
> >>>    return 0;
> >>> }
> >>> 
> >>> static int
> >>> waitread(int s)
> >>> {
> >>>    char data[1];
> >>>    ssize_t rv;
> >>> 
> >>>    rv = read(s, data, sizeof(data));
> >>>    if (rv == -1) {
> >>>        perror("read");
> >>>        return -1;
> >>>    }
> >>>    printf("Read %d bytes\n", (int) rv);
> >>>    return 0;
> >>> }
> >>> 
> >>> static int
> >>> do_server(void)
> >>> {
> >>>    int err, ls, s, optval;
> >>>    struct addrinfo *ai;
> >>> 
> >>>    printf("Server\n");
> >>> 
> >>>    err = getaddr("::", "3023", true, &ai);
> >>>    if (err)
> >>>        return err;
> >>> 
> >>>    ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> >>>    if (ls == -1) {
> >>>        perror("socket");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    optval = 1;
> >>>    if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
> >>>                   (void *)&optval, sizeof(optval)) == -1) {
> >>>        perror("setsockopt reuseaddr");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    /* Comment this out and it will work. */
> >>>    if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
> >>>                   sizeof(optval)) == -1) {
> >>>        perror("setsockopt ipv6 only");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    err = bind(ls, ai->ai_addr, ai->ai_addrlen);
> >>>    if (err == -1) {
> >>>        perror("bind");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    err = listen(ls, 5);
> >>>    if (err == -1) {
> >>>        perror("listen");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    s = accept(ls, NULL, NULL);
> >>>    if (s == -1) {
> >>>        perror("accept");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    close(ls);
> >>> 
> >>>    err = waitread(s);
> >>>    close(s);
> >>>    return err;
> >>> }
> >>> 
> >>> static int
> >>> do_client(void)
> >>> {
> >>>    int err, s;
> >>>    struct addrinfo *ai;
> >>> 
> >>>    printf("Client\n");
> >>> 
> >>>    err = getaddr("::1", "3023", false, &ai);
> >>>    if (err)
> >>>        return err;
> >>> 
> >>>    s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> >>>    if (s == -1) {
> >>>        perror("socket");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    err = connect(s, ai->ai_addr, ai->ai_addrlen);
> >>>    if (err == -1) {
> >>>        perror("connect");
> >>>        return -1;
> >>>    }
> >>> 
> >>>    err = waitread(s);
> >>>    close(s);
> >>>    return err;
> >>> }
> >>> 
> >>> int
> >>> main(int argc, char *argv[])
> >>> {
> >>>    int err;
> >>> 
> >>>    if (argc > 1)
> >>>        err = do_server();
> >>>    else
> >>>        err = do_client();
> >>>    return !!err;
> >>> }
> >>> 
> 
