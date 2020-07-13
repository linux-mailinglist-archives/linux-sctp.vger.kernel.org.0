Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6FC21E2DC
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2020 00:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGMWLJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 13 Jul 2020 18:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMWLI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 13 Jul 2020 18:11:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF496C061755
        for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2020 15:11:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so13880094qkm.3
        for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2020 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+V67vpleiOcfYTqrVBS/7etgoLTjCT695mYY0LEj3U=;
        b=QlkzFEj2kobTgKLYw6xZjDgSLNridGq8/1AEHDjJt71IAzq7DHsxDmorslzVKVJt1G
         oeH/UYZR3X656+fwgrfHNZNdNo0mfwcgbWc/JfPvjPSiwNxRVRoXuFcAmISUtBZZIjL0
         RkDSgqmDqEMK9vA3rzb4rEtikeS0iuu+PBJhxDAz8ZxqmSMS6XO7NiOOJRBaJbSRen6U
         p0ChWj43ZEgZ6pcRApHUFW4mMMWPRYBrLwl/ehfipkKA1d6a838RXoKDb/uiyrw0ylvl
         ISFE2rDuCMHmDhTFHY/XFvxEbmbRbZD+qg8UXV8XtY4CL7JV9+wxmcUU3uBRZ3DzZ748
         O7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+V67vpleiOcfYTqrVBS/7etgoLTjCT695mYY0LEj3U=;
        b=Z/VBa3PGWIXvJzM7qmJr0+kSy2azsykbDXwTX5aJhxoPE5/m751nE7bQfDG9t2ZYSK
         hrYQVn0fLNt/V21Z0HN90YrSJdunxNvk/svVJuLrEFA+WqAO4Q8xJDQL7Z2uOh6gqXmO
         bSeVTY45WubmzgqH1ow4xt8vvtfOzDjtzi88wBYC5NLsuUleopUugYBMIMyczdHM6axX
         ayCDCSEUcNudI5KyE06+BRi56BWIJV6ckZZ7/U1wQKAIyS/kg8+vvEhalTFG8D00OS6Z
         AaWsy347CRAkUsfPQWn6Ykemz2sC5kH1DiP9YXGYerPCys8MMFejynFi5LaQlG6qKB37
         RuPQ==
X-Gm-Message-State: AOAM53128XMdSPbsrzy5QI9KS1KAWQLi7gt3v0jIm6Qco4RmFQxuQWbs
        5U8SMGb47UOVCAWx9+ssi0Y=
X-Google-Smtp-Source: ABdhPJyKMPQtJHu+jdAOJmQIyisOy3bVZYIwuI5EtJ1A1A+JBJiVF0mmwJaGOZ9Aozw/l3e7kkXNZg==
X-Received: by 2002:a37:d02:: with SMTP id 2mr1681019qkn.382.1594678267837;
        Mon, 13 Jul 2020 15:11:07 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.248])
        by smtp.gmail.com with ESMTPSA id g17sm19358252qto.73.2020.07.13.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:11:06 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 5B9E7C3360; Mon, 13 Jul 2020 19:11:04 -0300 (-03)
Date:   Mon, 13 Jul 2020 19:11:04 -0300
From:   Marcelo Leitner <marcelo.leitner@gmail.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
Subject: Re: 200ms delays with SCTP streaming data
Message-ID: <20200713221104.GW2491@localhost.localdomain>
References: <20200713215907.GE3235@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713215907.GE3235@minyard.net>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 13, 2020 at 04:59:07PM -0500, Corey Minyard wrote:
> Hi, it's me again with another strange issue.  In case you didn't figure
> it out before, I'm working on a library that supports all different
> types of stream I/O, and SCTP is one supported building block.  I
> noticed when I stacked a multiplexer layer on top of SCTP I started
> getting timeouts occasionally.  It took a bit, but I finally realized
> that I was getting 200ms delays occasionally between sending a packet
> and receiving a packet.  I verified this with a trace right at the
> sctp_send() and sctp_recvmsg() calls.  It doesn't seem to be regular
> in any way I can see, but it happens often enough to cause issues.
> 
> If I replace the SCTP block with a TCP block, it works fine, and pretty
> much all the code is the same except where it does the read and write
> calls (including the epoll() usage, and I have also switched to select()
> and it has the same issue).  The write calls don't seem to be the issue,
> I see two back-to-back writes a few microseconds apart and see a 200ms
> delay between the messages on the receive side.
> 
> The test in question sets up two connections and does a big simultaneous
> bidirectional transfer.  The test app has 4 threads waiting on epoll()
> handling data and writing data.
> 
> And the delay is always ~200ms.  Which sounds suspicious.

That can be the delayed sack timer, in kernel.
/* Delayed sack timer - 200ms */
#define SCTP_DEFAULT_TIMEOUT_SACK       (200)

You may tweak the sysctl net.sctp.sack_timeout and see if changes
accordingly, or via SCTP_PEER_ADDR_PARAMS or even enable immediate ack
(by setting SPP_SACKDELAY_DISABLE)

> 
> It's not using sctp_sendv() at the moment, as the systems I'm running on
> don't have that yet.  But the library does have support if it sees it is
> available.
> 
> So I don't think it's my library; I've stared at it a bunch (and found a
> few other bugs) but I can't reconcile this one.  There are no timers

Nice.

> that would cause this in the code in question.  Just basically an
> epoll() call waiting on data and receive processing that is comparing
> data, along with write processing that is sending the same data.
> 
> Anyway, I haven't tried to create a small reproducer; I thought I would
> report it first and see if anything rang a bell.  I tried this on a
> recent kernel and got the same issue.

I guess a combination of xmit rate, msg and buffer sizes and packet
drops can lead to this delay. I've seen it happening, but didn't have
the time to track it down back then.

That said, remember that Linux SCTP doesn't support buffer
auto-tuning. So considering you're running a stress test, you probably
want to adjust them accordingly manually to avoid packet drops.

  Marcelo

> 
> The library is at https://github.com/cminyard/gensio.  I'd need to
> provide a patch for the tracing.
> 
> -corey
