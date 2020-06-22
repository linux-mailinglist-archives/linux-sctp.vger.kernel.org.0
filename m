Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864A42036DD
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2020 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgFVMdI (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 Jun 2020 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFVMdI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 Jun 2020 08:33:08 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A88AC061794
        for <linux-sctp@vger.kernel.org>; Mon, 22 Jun 2020 05:33:08 -0700 (PDT)
Received: from mb.fritz.box (ip4d15f5fc.dynamic.kabel-deutschland.de [77.21.245.252])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 44BD27220C6C8;
        Mon, 22 Jun 2020 14:33:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Strange problem with SCTP+IPv6
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
Date:   Mon, 22 Jun 2020 14:32:57 +0200
Cc:     minyard@acm.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BCB69E7B-240A-4ED3-B434-0186B573E4D1@lurchi.franken.de>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



> On 22. Jun 2020, at 14:01, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
>> 
>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
>> then I make a connection to it using ::1, the connection will drop after
>> 2.5 seconds with an ECONNRESET error.
>> 
>> It only happens on SCTP, it doesn't have the issue if you connect to a
>> full IPv6 address instead of ::1, and it doesn't happen if you don't
>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
>> I tried on an ARM system and x86_64.
>> 
>> I haven't dug into the kernel to see if I could find anything yet, but I
>> thought I would go ahead and report it.  I am attaching a reproducer.
>> Basically, compile the following code:
> The code only set IPV6_V6ONLY on server side, so the client side will
> still bind all the local ipv4 addresses (as you didn't call bind() to
> bind any specific addresses ). Then after the connection is created,
Let's focus on the loopback addresses ::1 and 127.0.0.1.

So the server will only use ::1. The client will send an INIT from
::1 to ::1 and lists 127.0.0.1 and ::1. That is what I would expect.
Is that happening?

The server would respond with an INIT-ACK from ::1 to ::1 and would
not list any IP addresses. Especially not 127.0.0.1, since it is IPv6 only.

After the association has beed established, the client can't send
any IPv4 packet to the server, since the server did not announce
any. The server can't send any IPv4 packets since it is IPv6 only.

This is what I would expect and this scenario should just work.
What am I missing?

Best regards
Michael
> the client will send HB on the v4 paths to the server. The server
> will abort the connection, as it can't support v4.
> 
> So you can work around it by either:
> 
>  - set IPV6_V6ONLY on client side.
> 
> or
> 
>  - bind to the specific v6 addresses on the client side.
> 
> I don't see RFC said something about this.
> So it may not be a good idea to change the current behaviour
> to not establish the connection in this case, which may cause regression.
> 
>> 
>>  gcc -g -o sctptest -Wall sctptest.c
>> 
>> and run it in one window as a server:
>> 
>>  ./sctptest a
>> 
>> (Pass in any option to be the server) and run the following in another
>> window as the client:
>> 
>>  ./sctptest
>> 
>> It disconnects after about 2.5 seconds.  If it works, it should just sit
>> there forever.
>> 
>> -corey
>> 
>> 
>> #include <stdio.h>
>> #include <stdbool.h>
>> #include <string.h>
>> #include <unistd.h>
>> #include <fcntl.h>
>> #include <sys/select.h>
>> #include <arpa/inet.h>
>> #include <netinet/sctp.h>
>> #include <sys/types.h>
>> #include <sys/socket.h>
>> #include <netdb.h>
>> 
>> static int
>> getaddr(const char *addr, const char *port, bool listen,
>>        struct addrinfo **rai)
>> {
>>    struct addrinfo *ai, hints;
>> 
>>    memset(&hints, 0, sizeof(hints));
>>    hints.ai_flags = AI_ADDRCONFIG;
>>    if (listen)
>>        hints.ai_flags |= AI_PASSIVE;
>>    hints.ai_family = AF_UNSPEC;
>>    hints.ai_socktype = SOCK_STREAM;
>>    hints.ai_protocol = IPPROTO_SCTP;
>>    if (getaddrinfo(addr, port, &hints, &ai)) {
>>        perror("getaddrinfo");
>>        return -1;
>>    }
>> 
>>    *rai = ai;
>>    return 0;
>> }
>> 
>> static int
>> waitread(int s)
>> {
>>    char data[1];
>>    ssize_t rv;
>> 
>>    rv = read(s, data, sizeof(data));
>>    if (rv == -1) {
>>        perror("read");
>>        return -1;
>>    }
>>    printf("Read %d bytes\n", (int) rv);
>>    return 0;
>> }
>> 
>> static int
>> do_server(void)
>> {
>>    int err, ls, s, optval;
>>    struct addrinfo *ai;
>> 
>>    printf("Server\n");
>> 
>>    err = getaddr("::", "3023", true, &ai);
>>    if (err)
>>        return err;
>> 
>>    ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>>    if (ls == -1) {
>>        perror("socket");
>>        return -1;
>>    }
>> 
>>    optval = 1;
>>    if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
>>                   (void *)&optval, sizeof(optval)) == -1) {
>>        perror("setsockopt reuseaddr");
>>        return -1;
>>    }
>> 
>>    /* Comment this out and it will work. */
>>    if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
>>                   sizeof(optval)) == -1) {
>>        perror("setsockopt ipv6 only");
>>        return -1;
>>    }
>> 
>>    err = bind(ls, ai->ai_addr, ai->ai_addrlen);
>>    if (err == -1) {
>>        perror("bind");
>>        return -1;
>>    }
>> 
>>    err = listen(ls, 5);
>>    if (err == -1) {
>>        perror("listen");
>>        return -1;
>>    }
>> 
>>    s = accept(ls, NULL, NULL);
>>    if (s == -1) {
>>        perror("accept");
>>        return -1;
>>    }
>> 
>>    close(ls);
>> 
>>    err = waitread(s);
>>    close(s);
>>    return err;
>> }
>> 
>> static int
>> do_client(void)
>> {
>>    int err, s;
>>    struct addrinfo *ai;
>> 
>>    printf("Client\n");
>> 
>>    err = getaddr("::1", "3023", false, &ai);
>>    if (err)
>>        return err;
>> 
>>    s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>>    if (s == -1) {
>>        perror("socket");
>>        return -1;
>>    }
>> 
>>    err = connect(s, ai->ai_addr, ai->ai_addrlen);
>>    if (err == -1) {
>>        perror("connect");
>>        return -1;
>>    }
>> 
>>    err = waitread(s);
>>    close(s);
>>    return err;
>> }
>> 
>> int
>> main(int argc, char *argv[])
>> {
>>    int err;
>> 
>>    if (argc > 1)
>>        err = do_server();
>>    else
>>        err = do_client();
>>    return !!err;
>> }
>> 

