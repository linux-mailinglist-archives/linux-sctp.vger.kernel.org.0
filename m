Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E558821F21E
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2020 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgGNNKY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 14 Jul 2020 09:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGNNKY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 14 Jul 2020 09:10:24 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F85C061755
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2020 06:10:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 72so12977275otc.3
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2020 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjjyUGLfh4w1XhxKP3/rCzwf/p//nQlX0kN/W3c5W4M=;
        b=CDzDBFkj+k89+Lr5U1b/TCKS+lw3KGuQXcrL2S3feZ5Zw/NlaR3YPXJ6tCbKUWKxfe
         Fr1GziU68oKJIALpiXsJY9YaG0wVQEmvD9D/GKULiXoQKtWjzO7u+fDXfGyKO9zOo0bE
         dXglleUrdE0Gv85zK7l6P8jE2sLH9+j0io2fPvZAuneUdfzJBJARo+fBISDwWFodGUy9
         JfSiahC2f14z0+hNwL9M3C4QfmWugsZytqIClNGHzNPXvwfJr5NZmtq6fCzN/iSsSLQi
         Ho04BweDFmtPFy6N5l4h6MFew9O1E9pM5cfKQGrc/Hc+gkl1h3g5VlMei5oXPAs2OUR6
         YFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=qjjyUGLfh4w1XhxKP3/rCzwf/p//nQlX0kN/W3c5W4M=;
        b=OLamjZLs0dlauJiJ9DRzG++KBycIfLhyJc3leLTOeotxdDbpXL4/Vz7xd/gG5k1FVY
         oqx4Gw4tbSdeA/HmQZEks+az4hUguyTAeVz5hHsT0ruNw6MCFgpgNzplGZMJyXLuacez
         MeTbV/GkROhbZDLGAL0t7EpPxVX3TKW9gtXj5nDpw34p4x/vVFuiwqJQvBZJX+VECaSR
         IrD+aFWSCLOVLuDdsvSQ/l5g86t1DR8KIIipFeAdwPUvaCIl7TtdbbKaNd7oC6cXJrel
         BjDIu/7ye/U+VqP7eQYM0NhL3o5sLxvbAoSJPE1USp3+Zo3K6cT4iK8M4TBBw2bC07es
         n1Gw==
X-Gm-Message-State: AOAM530eBgiM4o3KeWMZaLB8+egfqvgrEhFQX/xTt5yjgxvszymYztSU
        EQbXptZu0OBTrc8HUYlWxA==
X-Google-Smtp-Source: ABdhPJySJY54RV9doqjyuZdVW0lwRSJGtsJF2KuBByOUfH70rX4Q5ZOm5E7QL97hzMtJ5AAeZ4MqQw==
X-Received: by 2002:a05:6830:80e:: with SMTP id r14mr4118580ots.285.1594732222325;
        Tue, 14 Jul 2020 06:10:22 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id d11sm3736093oom.6.2020.07.14.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 06:10:21 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:716e:150c:6fea:2da2])
        by serve.minyard.net (Postfix) with ESMTPSA id 1920E18055F;
        Tue, 14 Jul 2020 13:10:20 +0000 (UTC)
Date:   Tue, 14 Jul 2020 08:10:18 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Marcelo Leitner <marcelo.leitner@gmail.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
Subject: Re: 200ms delays with SCTP streaming data
Message-ID: <20200714131018.GO17797@minyard.net>
Reply-To: minyard@acm.org
References: <20200713215907.GE3235@minyard.net>
 <20200713221104.GW2491@localhost.localdomain>
 <20200714121258.GN17797@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714121258.GN17797@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Jul 14, 2020 at 07:12:58AM -0500, Corey Minyard wrote:
> On Mon, Jul 13, 2020 at 07:11:04PM -0300, Marcelo Leitner wrote:
> > On Mon, Jul 13, 2020 at 04:59:07PM -0500, Corey Minyard wrote:
> > > Hi, it's me again with another strange issue.  In case you didn't figure
> > > it out before, I'm working on a library that supports all different
> > > types of stream I/O, and SCTP is one supported building block.  I
> > > noticed when I stacked a multiplexer layer on top of SCTP I started
> > > getting timeouts occasionally.  It took a bit, but I finally realized
> > > that I was getting 200ms delays occasionally between sending a packet
> > > and receiving a packet.  I verified this with a trace right at the
> > > sctp_send() and sctp_recvmsg() calls.  It doesn't seem to be regular
> > > in any way I can see, but it happens often enough to cause issues.
> > > 
> > > If I replace the SCTP block with a TCP block, it works fine, and pretty
> > > much all the code is the same except where it does the read and write
> > > calls (including the epoll() usage, and I have also switched to select()
> > > and it has the same issue).  The write calls don't seem to be the issue,
> > > I see two back-to-back writes a few microseconds apart and see a 200ms
> > > delay between the messages on the receive side.
> > > 
> > > The test in question sets up two connections and does a big simultaneous
> > > bidirectional transfer.  The test app has 4 threads waiting on epoll()
> > > handling data and writing data.
> > > 
> > > And the delay is always ~200ms.  Which sounds suspicious.
> > 
> > That can be the delayed sack timer, in kernel.
> > /* Delayed sack timer - 200ms */
> > #define SCTP_DEFAULT_TIMEOUT_SACK       (200)
> > 
> > You may tweak the sysctl net.sctp.sack_timeout and see if changes
> > accordingly, or via SCTP_PEER_ADDR_PARAMS or even enable immediate ack
> > (by setting SPP_SACKDELAY_DISABLE)
> 
> Ok, setting SPP_SACKDELAY_DISABLE does make the problem go away.
> 
> > 
> > > 
> > > It's not using sctp_sendv() at the moment, as the systems I'm running on
> > > don't have that yet.  But the library does have support if it sees it is
> > > available.
> > > 
> > > So I don't think it's my library; I've stared at it a bunch (and found a
> > > few other bugs) but I can't reconcile this one.  There are no timers
> > 
> > Nice.
> > 
> > > that would cause this in the code in question.  Just basically an
> > > epoll() call waiting on data and receive processing that is comparing
> > > data, along with write processing that is sending the same data.
> > > 
> > > Anyway, I haven't tried to create a small reproducer; I thought I would
> > > report it first and see if anything rang a bell.  I tried this on a
> > > recent kernel and got the same issue.
> > 
> > I guess a combination of xmit rate, msg and buffer sizes and packet
> > drops can lead to this delay. I've seen it happening, but didn't have
> > the time to track it down back then.
> 
> There should be no packet drops.  It's running across localhost, and
> flow control in the multiplex layer as it's set up for the tests limits
> the maximum outstanding data to 1024 bytes.  With overhead and flow
> control messages it's maybe 1050 bytes of data that would ever be
> unacked.  (It's not really testing throughput, it's testing the inner
> workings of the multiplexing protocol.)
> 
> If I understand this correctly per the RFCs, by default if there are two
> messages outstanding, it will send an sack immediately.  Otherwise it
> waits 200ms.  I'm guessing what is happening is that that SCTP sends a
> sack and then receives one more message and the upper layer stops
> because of flow control.  Then the sack comes out in 200ms and things
> continue.

Actually, that still doesn't make sense.  The lack of a sack shouldn't
keep anything from sending unless the congestion window is closed, which
shouldn't happen in this case.  Am I correct?

-corey

> 
> So I think I can figure out how to make this work smoothly.  I assume
> this doesn't happen in TCP because all packets carry an ack, and there
> is data flowing both ways all the time.
> 
> Thanks,
> 
> -corey
> 
> > 
> > That said, remember that Linux SCTP doesn't support buffer
> > auto-tuning. So considering you're running a stress test, you probably
> > want to adjust them accordingly manually to avoid packet drops.
> > 
> >   Marcelo
> > 
> > > 
> > > The library is at https://github.com/cminyard/gensio.  I'd need to
> > > provide a patch for the tracing.
> > > 
> > > -corey
