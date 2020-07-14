Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A063721F73B
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2020 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGNQXy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 14 Jul 2020 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgGNQXy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 14 Jul 2020 12:23:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE73C061755
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2020 09:23:54 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h17so14397593oie.3
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2020 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kG4h1F/TYo6Sh3D1BOnd2xrFqyuvyqTTwEM904KrhAM=;
        b=iZxrFjh2tO6CNHTJUWTK1l4pT3EBxnk310oYKbRkrZm65VN2Ghw4MjFL+WA0+rtSfW
         MpBtCmdFjKePgyVDeoMS5JoeK+EPXpoA8TlmjxqpHCoaZPLxtKGIQNunyYOj6d/+MEx+
         yytfmqss98L41q5iBrwJT0PgC17vq5toOQqHnl5JD80jEcrYvyEtL71r/LxaliHX/57x
         srBpH6JTJETU3UPghW1816iE8Vz2TuFcgTnbDEgEsL9naIOqdxo2KnOPwAxxU/XmCUhq
         tip2EHmjApcgi/UOP+TP3f9Vxe4k/R2ro+badfOTtytwW4mmwsqcWID2NpMWnB3N6xvj
         kiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=kG4h1F/TYo6Sh3D1BOnd2xrFqyuvyqTTwEM904KrhAM=;
        b=ZJ7gGx7B6uJU6eqPbaRGN7edf9vfoM4TpN/KvQVYtWnZI86LmF5WI/2m1ycbZyCC5K
         t2D6qyQUInl3xcx6qkuUrG5JyyyKKnkO+MQqZ6sSmHGY6yhSmI1eFft4BfF8W4LbjcSz
         oEoo9wNeqGdjX+vb6SXVLJ7e0+qLqx1bBcn4UZOyqz2H82gTKkwkHS5W0243PUGXCkWC
         F4i7T8p3cGBSS6Rew/yJzVH/bcavULDxTUouQziutsDnTVL1DyF/X5aST+Nu9kuWr78A
         OggOi+lECy54p31lpqSx3xnv317Zoq2ilfZ6bo7Cm7N3XyYoNNMgPVzXy9tqsO6FuFjn
         7ZMQ==
X-Gm-Message-State: AOAM532dLIW83zvSJo74PWLjkQstFAkcPPlD9bvSdrI+a3RUi1E51KxC
        d412w8cAbf7bOqtYCdpRew==
X-Google-Smtp-Source: ABdhPJxNkKFNZU/5tSgH2JxMaSc1r8S702PcSd8aMdOXL60bBKSjZbSlVknVA0xBiZUJ9u8ATnIaaQ==
X-Received: by 2002:aca:ab90:: with SMTP id u138mr4195051oie.132.1594743832550;
        Tue, 14 Jul 2020 09:23:52 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id t5sm3424491oih.19.2020.07.14.09.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 09:23:51 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:716e:150c:6fea:2da2])
        by serve.minyard.net (Postfix) with ESMTPSA id 71192180050;
        Tue, 14 Jul 2020 16:23:50 +0000 (UTC)
Date:   Tue, 14 Jul 2020 11:23:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Cc:     Marcelo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
Subject: Re: 200ms delays with SCTP streaming data
Message-ID: <20200714162349.GP17797@minyard.net>
Reply-To: minyard@acm.org
References: <20200713215907.GE3235@minyard.net>
 <20200713221104.GW2491@localhost.localdomain>
 <20200714121258.GN17797@minyard.net>
 <20200714131018.GO17797@minyard.net>
 <BB8FA7BE-EBE8-4525-9BE2-A5DCF40F6C2C@lurchi.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB8FA7BE-EBE8-4525-9BE2-A5DCF40F6C2C@lurchi.franken.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jul 14, 2020 at 03:51:49PM +0200, Michael Tuexen wrote:
> > On 14. Jul 2020, at 15:10, Corey Minyard <minyard@acm.org> wrote:
> > 
> > On Tue, Jul 14, 2020 at 07:12:58AM -0500, Corey Minyard wrote:
> >> On Mon, Jul 13, 2020 at 07:11:04PM -0300, Marcelo Leitner wrote:
> >>> On Mon, Jul 13, 2020 at 04:59:07PM -0500, Corey Minyard wrote:
> >>>> Hi, it's me again with another strange issue.  In case you didn't figure
> >>>> it out before, I'm working on a library that supports all different
> >>>> types of stream I/O, and SCTP is one supported building block.  I
> >>>> noticed when I stacked a multiplexer layer on top of SCTP I started
> >>>> getting timeouts occasionally.  It took a bit, but I finally realized
> >>>> that I was getting 200ms delays occasionally between sending a packet
> >>>> and receiving a packet.  I verified this with a trace right at the
> >>>> sctp_send() and sctp_recvmsg() calls.  It doesn't seem to be regular
> >>>> in any way I can see, but it happens often enough to cause issues.
> >>>> 
> >>>> If I replace the SCTP block with a TCP block, it works fine, and pretty
> >>>> much all the code is the same except where it does the read and write
> >>>> calls (including the epoll() usage, and I have also switched to select()
> >>>> and it has the same issue).  The write calls don't seem to be the issue,
> >>>> I see two back-to-back writes a few microseconds apart and see a 200ms
> >>>> delay between the messages on the receive side.
> >>>> 
> >>>> The test in question sets up two connections and does a big simultaneous
> >>>> bidirectional transfer.  The test app has 4 threads waiting on epoll()
> >>>> handling data and writing data.
> >>>> 
> >>>> And the delay is always ~200ms.  Which sounds suspicious.
> >>> 
> >>> That can be the delayed sack timer, in kernel.
> >>> /* Delayed sack timer - 200ms */
> >>> #define SCTP_DEFAULT_TIMEOUT_SACK       (200)
> >>> 
> >>> You may tweak the sysctl net.sctp.sack_timeout and see if changes
> >>> accordingly, or via SCTP_PEER_ADDR_PARAMS or even enable immediate ack
> >>> (by setting SPP_SACKDELAY_DISABLE)
> >> 
> >> Ok, setting SPP_SACKDELAY_DISABLE does make the problem go away.
> >> 
> >>> 
> >>>> 
> >>>> It's not using sctp_sendv() at the moment, as the systems I'm running on
> >>>> don't have that yet.  But the library does have support if it sees it is
> >>>> available.
> >>>> 
> >>>> So I don't think it's my library; I've stared at it a bunch (and found a
> >>>> few other bugs) but I can't reconcile this one.  There are no timers
> >>> 
> >>> Nice.
> >>> 
> >>>> that would cause this in the code in question.  Just basically an
> >>>> epoll() call waiting on data and receive processing that is comparing
> >>>> data, along with write processing that is sending the same data.
> >>>> 
> >>>> Anyway, I haven't tried to create a small reproducer; I thought I would
> >>>> report it first and see if anything rang a bell.  I tried this on a
> >>>> recent kernel and got the same issue.
> >>> 
> >>> I guess a combination of xmit rate, msg and buffer sizes and packet
> >>> drops can lead to this delay. I've seen it happening, but didn't have
> >>> the time to track it down back then.
> >> 
> >> There should be no packet drops.  It's running across localhost, and
> >> flow control in the multiplex layer as it's set up for the tests limits
> >> the maximum outstanding data to 1024 bytes.  With overhead and flow
> >> control messages it's maybe 1050 bytes of data that would ever be
> >> unacked.  (It's not really testing throughput, it's testing the inner
> >> workings of the multiplexing protocol.)
> >> 
> >> If I understand this correctly per the RFCs, by default if there are two
> >> messages outstanding, it will send an sack immediately.  Otherwise it
> >> waits 200ms.  I'm guessing what is happening is that that SCTP sends a
> >> sack and then receives one more message and the upper layer stops
> >> because of flow control.  Then the sack comes out in 200ms and things
> >> continue.
> > 
> > Actually, that still doesn't make sense.  The lack of a sack shouldn't
> > keep anything from sending unless the congestion window is closed, which
> > shouldn't happen in this case.  Am I correct?
> I guess you still have the Nagle algorithm enabled. Try enabled the SCTP_NODELAY
> socket option: https://tools.ietf.org/html/rfc6458#section-8.1.5 at the sender side.
> 
> It is enabled by default and will delay the sending of packet if they are
> not large enough (an implementation decision) and there is outstanding data.

Well, that was a surprise, disabling Nagle caused the problem to go
away.  Nagle generally doesn't make a difference when transferring lots
of data.

I guess this is a bad interaction between Nagle and the SCTP
sack algorithms.  With TCP in my test, data is flowing both ways so data
is always being acked, and Nagle is never significantly involved.

That's happening with SCTP, too, but in some situations a sack could be
sent, you get one more packet sent, and that packet won't be acked until
another packet is sent.  So you have unacked data, and Nagle will hold
any new data until it receives an ack for the outstanding packet.  So you
get stuck until the sack delay elapses.  Bah.

This is sort of like the interaction between Nagle and TCP delayed ack.
Which is sort of a bug, I guess, but well known.  I have a number of
ways to work around this issue, and I can document it so users can know.

Thanks for your help.

-corey

> 
> Best regards
> Michael
> > 
> > -corey
> > 
> >> 
> >> So I think I can figure out how to make this work smoothly.  I assume
> >> this doesn't happen in TCP because all packets carry an ack, and there
> >> is data flowing both ways all the time.
> >> 
> >> Thanks,
> >> 
> >> -corey
> >> 
> >>> 
> >>> That said, remember that Linux SCTP doesn't support buffer
> >>> auto-tuning. So considering you're running a stress test, you probably
> >>> want to adjust them accordingly manually to avoid packet drops.
> >>> 
> >>>  Marcelo
> >>> 
> >>>> 
> >>>> The library is at https://github.com/cminyard/gensio.  I'd need to
> >>>> provide a patch for the tracing.
> >>>> 
> >>>> -corey
> 
