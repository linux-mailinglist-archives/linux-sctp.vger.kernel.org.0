Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C071A20B5DB
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Jun 2020 18:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgFZQ1m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 26 Jun 2020 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgFZQ1m (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 26 Jun 2020 12:27:42 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333FC03E979;
        Fri, 26 Jun 2020 09:27:42 -0700 (PDT)
Received: from mb.fritz.box (ip4d15f5fc.dynamic.kabel-deutschland.de [77.21.245.252])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 7CF317220B813;
        Fri, 26 Jun 2020 18:27:36 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Strange problem with SCTP+IPv6
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <50b0a6ff186e408bbfe6211221cb3998@AcuMS.aculab.com>
Date:   Fri, 26 Jun 2020 18:27:35 +0200
Cc:     Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "minyard@acm.org" <minyard@acm.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <66D9D559-23D6-42B0-9401-62B00C4F748E@lurchi.franken.de>
References: <20200621155604.GA23135@minyard.net>
 <CADvbK_d9mV9rBg7oLC+9u4fg3d_5a_g8ukPe83vOAE8ZM3FhHA@mail.gmail.com>
 <20200622165759.GA3235@minyard.net>
 <4B68D06C-00F4-42C3-804A-B5531AABCE21@lurchi.franken.de>
 <20200622183253.GQ2491@localhost.localdomain>
 <E5F42909-3AB4-47FE-98B7-DEFB63968696@lurchi.franken.de>
 <CADvbK_fddQiOJUVJNkJuxkzQ9V-tpk_ATBP4NpZ2rZketHEFcg@mail.gmail.com>
 <50b0a6ff186e408bbfe6211221cb3998@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 26. Jun 2020, at 18:13, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Xin Long
>> Sent: 23 June 2020 11:14
>>>> It looks like a bug to me. Testing with this test app here, I can see
>>>> the INIT_ACK being sent with a bunch of ipv4 addresses in it and
>>>> that's unexpected for a v6only socket. As is, it's the server saying
>>>> "I'm available at these other addresses too, but not."
>>> I agree.
>> Then we need a fix in sctp_bind_addrs_to_raw():
>> 
>> @@ -238,6 +240,9 @@ union sctp_params sctp_bind_addrs_to_raw(const
>> struct sctp_bind_addr *bp,
>>        addrparms = retval;
>> 
>>        list_for_each_entry(addr, &bp->address_list, list) {
>> +               if ((PF_INET6 == sk->sk_family) && inet_v6_ipv6only(sk) &&
>> +                   (AF_INET == addr->a.sa.sa_family))
>> +                       continue;
>>                af = sctp_get_af_specific(addr->a.v4.sin_family);
>>                len = af->to_addr_param(&addr->a, &rawaddr);
>>                memcpy(addrparms.v, &rawaddr, len);
> 
> Thought.
> 
> Does it make any sense to offer addresses in the INIT_ACK that don't
> have routes to those proposed in the received INIT?
> 
> 'routes' probably isn't exactly the right word.
> You probably only want the local address that will be used
> as the source address for the probes.
> Or, at least, sources addresses that could be used for the probes.
> 
> So if the INIT only contains IPv6 addresses should the INIT_ACK
> ever contain IPv4 ones.
The client (if it not using an IPv6 socket having IPv6 only enabled) could
add an IPv4 address during the lifetime of the association by using the
address reconfiguration extension.

What could be done is to not send IPv4 addresses if the INIT contains
a Supported Address Types parameter indicating IPv6, but not IPv4 support.
As a client you might want to send this parameter, when the IPv6 socket has
enabled the IPV6_ONLY socket option.
Also if the client uses an IPv4 socket, it can indicate in the Supported
Address Parameter that it only support IPv4, and the server does not need
to list IPv6 addresses.

Best regards
Michael
> 
> 	David.
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

