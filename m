Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9852B203F30
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2020 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgFVSeH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 22 Jun 2020 14:34:07 -0400
Received: from mail-n.franken.de ([193.175.24.27]:55891 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730139AbgFVSeH (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 22 Jun 2020 14:34:07 -0400
Received: from [10.0.3.1] (unknown [212.201.121.94])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id EC0A87220C6C8;
        Mon, 22 Jun 2020 20:34:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Strange problem with SCTP+IPv6
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <20200622183253.GQ2491@localhost.localdomain>
Date:   Mon, 22 Jun 2020 20:34:00 +0200
Cc:     minyard@acm.org, Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 22. Jun 2020, at 20:32, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> 
> On Mon, Jun 22, 2020 at 08:01:24PM +0200, Michael Tuexen wrote:
>>> On 22. Jun 2020, at 18:57, Corey Minyard <minyard@acm.org> wrote:
>>> 
>>> On Mon, Jun 22, 2020 at 08:01:23PM +0800, Xin Long wrote:
>>>> On Sun, Jun 21, 2020 at 11:56 PM Corey Minyard <minyard@acm.org> wrote:
>>>>> 
>>>>> I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
>>>>> sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
>>>>> then I make a connection to it using ::1, the connection will drop after
>>>>> 2.5 seconds with an ECONNRESET error.
>>>>> 
>>>>> It only happens on SCTP, it doesn't have the issue if you connect to a
>>>>> full IPv6 address instead of ::1, and it doesn't happen if you don't
>>>>> set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
>>>>> I tried on an ARM system and x86_64.
>>>>> 
>>>>> I haven't dug into the kernel to see if I could find anything yet, but I
>>>>> thought I would go ahead and report it.  I am attaching a reproducer.
>>>>> Basically, compile the following code:
>>>> The code only set IPV6_V6ONLY on server side, so the client side will
>>>> still bind all the local ipv4 addresses (as you didn't call bind() to
>>>> bind any specific addresses ). Then after the connection is created,
>>>> the client will send HB on the v4 paths to the server. The server
>>>> will abort the connection, as it can't support v4.
>>>> 
>>>> So you can work around it by either:
>>>> 
>>>> - set IPV6_V6ONLY on client side.
>>>> 
>>>> or
>>>> 
>>>> - bind to the specific v6 addresses on the client side.
>>>> 
>>>> I don't see RFC said something about this.
>>>> So it may not be a good idea to change the current behaviour
>>>> to not establish the connection in this case, which may cause regression.
>>> 
>>> Ok, I understand this.  It's a little strange, but I see why it works
>>> this way.
>> I don't. I would expect it to work as I described in my email.
>> Could someone explain me how and why it is behaving different from
>> my expectation?
> 
> It looks like a bug to me. Testing with this test app here, I can see
> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
> that's unexpected for a v6only socket. As is, it's the server saying
> "I'm available at these other addresses too, but not."
I agree.

Best regards
Michael
> 
> Thanks,
> Marcelo
> 
>> 
>> Best regards
>> Michael
>>> 
>>> Thanks,
>>> 
>>> -corey
>>> 
>>>> 
>>>>> 
>>>>> gcc -g -o sctptest -Wall sctptest.c
>>>>> 
>>>>> and run it in one window as a server:
>>>>> 
>>>>> ./sctptest a
>>>>> 
>>>>> (Pass in any option to be the server) and run the following in another
>>>>> window as the client:
>>>>> 
>>>>> ./sctptest
>>>>> 
>>>>> It disconnects after about 2.5 seconds.  If it works, it should just sit
>>>>> there forever.
>>>>> 
>>>>> -corey
>>>>> 
>>>>> 
>>>>> #include <stdio.h>
>>>>> #include <stdbool.h>
>>>>> #include <string.h>
>>>>> #include <unistd.h>
>>>>> #include <fcntl.h>
>>>>> #include <sys/select.h>
>>>>> #include <arpa/inet.h>
>>>>> #include <netinet/sctp.h>
>>>>> #include <sys/types.h>
>>>>> #include <sys/socket.h>
>>>>> #include <netdb.h>
>>>>> 
>>>>> static int
>>>>> getaddr(const char *addr, const char *port, bool listen,
>>>>>       struct addrinfo **rai)
>>>>> {
>>>>>   struct addrinfo *ai, hints;
>>>>> 
>>>>>   memset(&hints, 0, sizeof(hints));
>>>>>   hints.ai_flags = AI_ADDRCONFIG;
>>>>>   if (listen)
>>>>>       hints.ai_flags |= AI_PASSIVE;
>>>>>   hints.ai_family = AF_UNSPEC;
>>>>>   hints.ai_socktype = SOCK_STREAM;
>>>>>   hints.ai_protocol = IPPROTO_SCTP;
>>>>>   if (getaddrinfo(addr, port, &hints, &ai)) {
>>>>>       perror("getaddrinfo");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   *rai = ai;
>>>>>   return 0;
>>>>> }
>>>>> 
>>>>> static int
>>>>> waitread(int s)
>>>>> {
>>>>>   char data[1];
>>>>>   ssize_t rv;
>>>>> 
>>>>>   rv = read(s, data, sizeof(data));
>>>>>   if (rv == -1) {
>>>>>       perror("read");
>>>>>       return -1;
>>>>>   }
>>>>>   printf("Read %d bytes\n", (int) rv);
>>>>>   return 0;
>>>>> }
>>>>> 
>>>>> static int
>>>>> do_server(void)
>>>>> {
>>>>>   int err, ls, s, optval;
>>>>>   struct addrinfo *ai;
>>>>> 
>>>>>   printf("Server\n");
>>>>> 
>>>>>   err = getaddr("::", "3023", true, &ai);
>>>>>   if (err)
>>>>>       return err;
>>>>> 
>>>>>   ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>>>>>   if (ls == -1) {
>>>>>       perror("socket");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   optval = 1;
>>>>>   if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
>>>>>                  (void *)&optval, sizeof(optval)) == -1) {
>>>>>       perror("setsockopt reuseaddr");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   /* Comment this out and it will work. */
>>>>>   if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
>>>>>                  sizeof(optval)) == -1) {
>>>>>       perror("setsockopt ipv6 only");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   err = bind(ls, ai->ai_addr, ai->ai_addrlen);
>>>>>   if (err == -1) {
>>>>>       perror("bind");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   err = listen(ls, 5);
>>>>>   if (err == -1) {
>>>>>       perror("listen");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   s = accept(ls, NULL, NULL);
>>>>>   if (s == -1) {
>>>>>       perror("accept");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   close(ls);
>>>>> 
>>>>>   err = waitread(s);
>>>>>   close(s);
>>>>>   return err;
>>>>> }
>>>>> 
>>>>> static int
>>>>> do_client(void)
>>>>> {
>>>>>   int err, s;
>>>>>   struct addrinfo *ai;
>>>>> 
>>>>>   printf("Client\n");
>>>>> 
>>>>>   err = getaddr("::1", "3023", false, &ai);
>>>>>   if (err)
>>>>>       return err;
>>>>> 
>>>>>   s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>>>>>   if (s == -1) {
>>>>>       perror("socket");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   err = connect(s, ai->ai_addr, ai->ai_addrlen);
>>>>>   if (err == -1) {
>>>>>       perror("connect");
>>>>>       return -1;
>>>>>   }
>>>>> 
>>>>>   err = waitread(s);
>>>>>   close(s);
>>>>>   return err;
>>>>> }
>>>>> 
>>>>> int
>>>>> main(int argc, char *argv[])
>>>>> {
>>>>>   int err;
>>>>> 
>>>>>   if (argc > 1)
>>>>>       err = do_server();
>>>>>   else
>>>>>       err = do_client();
>>>>>   return !!err;
>>>>> }
>>>>> 
>> 

