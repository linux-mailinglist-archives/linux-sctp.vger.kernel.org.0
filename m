Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0421F07C
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2020 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgGNMNF (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 14 Jul 2020 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgGNMND (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 14 Jul 2020 08:13:03 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB0C061755
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2020 05:13:02 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id v26so1711292ood.1
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2020 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ghxw6xPAWyELwSPV0/9i/5LhgY2APN6g5G8kwi/b1U=;
        b=TXQCmGXVunQVZTeJRgDkOrugxJUGTlYaH3+PM4F8DS9LW6yIz6NLX+Vifw8yJ+HlMe
         FWT6R0rl7wqx4/6LOZb98ojuDCJpA0GXcq1xDySurJcUYoDbVN6H9GCChysxSww5iUq3
         cAiZurAAuSm99vaBf4P+csDPwa+SEBtuK9WR4yXMYTU4ZMjA05d5BJ0oYZ3g7AREvJFE
         6lxIcZVsKDd6AnNbp7WvoXG+Gtn5emZkrBcGKGdwvth2AI1rr/H79ZRccQ6yCe6GplyZ
         bRsuqieAYp3gD4eU2tM12zgMB26wyO3UWj8fNrJp6K+yWzKSCusDLuoWpCukFL2Bl98e
         DvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=+ghxw6xPAWyELwSPV0/9i/5LhgY2APN6g5G8kwi/b1U=;
        b=E6yNHkVRTE0y8mNguydKM8VmNIQDCrQly+VhKVfX6aa/DCOL9ngTBFib4d05C18aLW
         tCCVecIqKffshlyafT6D7OlpfkLsbXwg+HjAa0m9nlVOKLblks0cEowhu1zgLhjkihDB
         WbkuUU4CfEqX9dCIsY64pUAwdJ7X5LLyQXqwUvlqNR5THYUtV/GnTzW3oGbV+8zvxsvK
         HCebSoBF6PNF9e9jy60NaEr6KFA+KDb9qkSyLVqMKwjPlbxXHTT0SSBB4AE/8sJ+KKMo
         uJjAUs2xKU4Xx6ZjRTvCkrZ59EKBzD5D1mZE6BJw28hCZXpIkBkVA785QBeqfQP8dA4P
         wj5A==
X-Gm-Message-State: AOAM530/dcRfIfeGoWcZT20v+v7ZPW4VkeYr84noKifTAjMMqA2Tlq40
        vMr01ZNbyJB0KrXcdrtEFg==
X-Google-Smtp-Source: ABdhPJwpOfPYr6yvHt1KeTPLyCZDb3ow2oQAFsuJgEm3b3PnUkyjuf1u80lYr2lcYSanPOd6D4MrVw==
X-Received: by 2002:a4a:d1cb:: with SMTP id a11mr4185799oos.63.1594728782114;
        Tue, 14 Jul 2020 05:13:02 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id n17sm3571298ota.37.2020.07.14.05.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 05:13:00 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:716e:150c:6fea:2da2])
        by serve.minyard.net (Postfix) with ESMTPSA id E1A15180050;
        Tue, 14 Jul 2020 12:12:59 +0000 (UTC)
Date:   Tue, 14 Jul 2020 07:12:58 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Marcelo Leitner <marcelo.leitner@gmail.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
Subject: Re: 200ms delays with SCTP streaming data
Message-ID: <20200714121258.GN17797@minyard.net>
Reply-To: minyard@acm.org
References: <20200713215907.GE3235@minyard.net>
 <20200713221104.GW2491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713221104.GW2491@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 13, 2020 at 07:11:04PM -0300, Marcelo Leitner wrote:
> On Mon, Jul 13, 2020 at 04:59:07PM -0500, Corey Minyard wrote:
> > Hi, it's me again with another strange issue.  In case you didn't figure
> > it out before, I'm working on a library that supports all different
> > types of stream I/O, and SCTP is one supported building block.  I
> > noticed when I stacked a multiplexer layer on top of SCTP I started
> > getting timeouts occasionally.  It took a bit, but I finally realized
> > that I was getting 200ms delays occasionally between sending a packet
> > and receiving a packet.  I verified this with a trace right at the
> > sctp_send() and sctp_recvmsg() calls.  It doesn't seem to be regular
> > in any way I can see, but it happens often enough to cause issues.
> > 
> > If I replace the SCTP block with a TCP block, it works fine, and pretty
> > much all the code is the same except where it does the read and write
> > calls (including the epoll() usage, and I have also switched to select()
> > and it has the same issue).  The write calls don't seem to be the issue,
> > I see two back-to-back writes a few microseconds apart and see a 200ms
> > delay between the messages on the receive side.
> > 
> > The test in question sets up two connections and does a big simultaneous
> > bidirectional transfer.  The test app has 4 threads waiting on epoll()
> > handling data and writing data.
> > 
> > And the delay is always ~200ms.  Which sounds suspicious.
> 
> That can be the delayed sack timer, in kernel.
> /* Delayed sack timer - 200ms */
> #define SCTP_DEFAULT_TIMEOUT_SACK       (200)
> 
> You may tweak the sysctl net.sctp.sack_timeout and see if changes
> accordingly, or via SCTP_PEER_ADDR_PARAMS or even enable immediate ack
> (by setting SPP_SACKDELAY_DISABLE)

Ok, setting SPP_SACKDELAY_DISABLE does make the problem go away.

> 
> > 
> > It's not using sctp_sendv() at the moment, as the systems I'm running on
> > don't have that yet.  But the library does have support if it sees it is
> > available.
> > 
> > So I don't think it's my library; I've stared at it a bunch (and found a
> > few other bugs) but I can't reconcile this one.  There are no timers
> 
> Nice.
> 
> > that would cause this in the code in question.  Just basically an
> > epoll() call waiting on data and receive processing that is comparing
> > data, along with write processing that is sending the same data.
> > 
> > Anyway, I haven't tried to create a small reproducer; I thought I would
> > report it first and see if anything rang a bell.  I tried this on a
> > recent kernel and got the same issue.
> 
> I guess a combination of xmit rate, msg and buffer sizes and packet
> drops can lead to this delay. I've seen it happening, but didn't have
> the time to track it down back then.

There should be no packet drops.  It's running across localhost, and
flow control in the multiplex layer as it's set up for the tests limits
the maximum outstanding data to 1024 bytes.  With overhead and flow
control messages it's maybe 1050 bytes of data that would ever be
unacked.  (It's not really testing throughput, it's testing the inner
workings of the multiplexing protocol.)

If I understand this correctly per the RFCs, by default if there are two
messages outstanding, it will send an sack immediately.  Otherwise it
waits 200ms.  I'm guessing what is happening is that that SCTP sends a
sack and then receives one more message and the upper layer stops
because of flow control.  Then the sack comes out in 200ms and things
continue.

So I think I can figure out how to make this work smoothly.  I assume
this doesn't happen in TCP because all packets carry an ack, and there
is data flowing both ways all the time.

Thanks,

-corey

> 
> That said, remember that Linux SCTP doesn't support buffer
> auto-tuning. So considering you're running a stress test, you probably
> want to adjust them accordingly manually to avoid packet drops.
> 
>   Marcelo
> 
> > 
> > The library is at https://github.com/cminyard/gensio.  I'd need to
> > provide a patch for the tracing.
> > 
> > -corey
