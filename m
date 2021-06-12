Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3E3A50F7
	for <lists+linux-sctp@lfdr.de>; Sat, 12 Jun 2021 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFLVa2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sat, 12 Jun 2021 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFLVa2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 12 Jun 2021 17:30:28 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB6C061574
        for <linux-sctp@vger.kernel.org>; Sat, 12 Jun 2021 14:28:28 -0700 (PDT)
Received: from smtpclient.apple (unknown [212.201.121.94])
        (Authenticated sender: macmic)
        by mail-n.franken.de (Postfix) with ESMTPSA id 55C7E72246372;
        Sat, 12 Jun 2021 23:28:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC8899)
From:   tuexen@freebsd.org
In-Reply-To: <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
Date:   Sat, 12 Jun 2021 23:28:21 +0200
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3455F74D-614D-4596-9F74-DF23335BD238@freebsd.org>
References: <CADvbK_c0dmke8Ei2sLiVqZ2ExgcmZyuPwpHBgW9g6Cjdi+rzug@mail.gmail.com>
 <E64A2DFD-9D39-470C-BA32-459B34F8B410@freebsd.org>
 <CADvbK_de_SNVsTmeCUTOVZoD7A9-sB4cAiqv=0rnvgoGfhErOA@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



> On 12. Jun 2021, at 19:32, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Fri, Jun 11, 2021 at 4:42 PM <tuexen@freebsd.org> wrote:
>> 
>>> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
>>> 
>>> Hi, Michael,
>>> 
>>> In the linux implementation of RFC8899, we decided to introduce one
>>> sysctl and one socket option for users to set up the PLPMUTD probe:
>>> 
>>> 1. sysctl -w net.sctp.plpmtud_probe_interval=1
>>> 
>>> plpmtud_probe_interval - INTEGER
>>>       The interval (in milliseconds) between PLPMTUD probe chunks. These
>>>       chunks are sent at the specified interval with a variable size to
>>>       probe the mtu of a given path between 2 associations. PLPMTUD will
>> I guess you mean "between 2 end points" instead of "between 2 associations".
>> 
>> I'm not sure what it means:
>> 
>> I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.
>> 
>> Assume you sent a probe packet for 1400. Aren't you sending the
>> probe packet for 1420 as soon as you get an ACK for the probe packet
>> of size 1400? Or are you waiting for plpmtud_probe_interval ms?
> It will wait for "plpmtud_probe_interval" ms in searching state, but in
> searching complete it will be "plpmtud_probe_interval * 30" ms.
> 
> The step we are using is 32, when it fails, we turn the step to 4. For example:
> 1400, 1432, 1464, 1496, 1528 (failed), 1500(1496 + 4), 1504(failed,
> 1500 is the PMTU).
> 
> Sorry, "sysctl -w net.sctp.plpmtud_probe_interval=1" won't work.
> As plpmtud_probe_interval is the probe interval TIME for the timer.
> Apart from 0, the minimal value is 5000ms.
> 
> So it should be:
> 
> plpmtud_probe_interval - INTEGER
>        The time interval (in milliseconds) for sending PLPMTUD probe chunks.
>        These chunks are sent at the specified interval with a variable size
>        to probe the mtu of a given path between 2 endpoints. PLPMTUD will
>        be disabled when 0 is set.
> 
>        Default: 0
> 
> Thanks.
OK. Thanks for the clarification.

Best regards
Michael
>>>       be disabled when 0 is set.
>>> 
>>>       Default: 0
>>> 
>>> 2. a socket option that can be used per socket, assoc or transport
>>> 
>>> /* PLPMTUD Probe Interval socket option */
>>> struct sctp_probeinterval {
>>>       sctp_assoc_t spi_assoc_id;
>>>       struct sockaddr_storage spi_address;
>>>       __u32 spi_interval;
>>> };
>>> 
>>> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
>>> 
>>> 
>>> The value above will enable/disable the PLPMUTD probe by setting up the probe
>>> interval for the timer. When it's 0, the timer will also stop and
>>> PLPMUTD is disabled.
>>> By this way, we don't need to introduce more options.
>> OK.
>>> 
>>> We're expecting to keep consistent with BSD on this, pls check and
>>> share your thoughts.
>> Looks good to me.
>> 
>> Best regards
>> Michael
>>> 
>>> Thanks.
>> 

