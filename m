Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B972B21E2BD
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2020 23:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGMV7M (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 13 Jul 2020 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMV7L (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 13 Jul 2020 17:59:11 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A555EC061755
        for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2020 14:59:11 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id x2so2736830oog.5
        for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2020 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=W+WQI/ChAOUHHuyMgNk+DIT7E0EEyJB0ZmFOlACh3ew=;
        b=XwdGfdfn1mKfX5KWyYdlq7h0Cu9+RQgvz3pL6gZTiA8ln1Ls6Vx6aDt70Omg0YQw1L
         dIL0HO5fw9qA/Ys8jnlN3LYHF8TxZ5z+rWsvXi9ilHJIo/HfN5r9g48NNSmATefeMgYQ
         FKB/3YY1EB63CWuKdEXhZJdGiAX2+yGt+OR/xjSs36b2gKUqBQNlWlth+DCy743tQrAa
         lR4vap7/pwNcDT4KBHiORNWM1vyGNdfXs/3Bs7xX7akgBBvs5GQJIlRVnnNnt4++qnBc
         bKNB4zb6wo8OAhN+R+QBQTiTw4KOgi7YS6bqIl+KeeIE51j0xM7SyQ5j2DUhUDblHkpJ
         gi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=W+WQI/ChAOUHHuyMgNk+DIT7E0EEyJB0ZmFOlACh3ew=;
        b=UJoF6w928B/sISbCky8cpffbMLWaQlmJpmF8wdTGuTKR6AG5RDaFEVqm2TmvAm8O6T
         tbK/8xcozZuQinUGrWRApsxnGmBoQtV8xCnkNe0UW3vB9SKliDVYpf3uvDSeOUIa8dtJ
         hsuEP1mfgB8Km/Juqp6iTMRY0h5l8gX3um2M2vpavhcJsaEuA4pgzq319AB6A3wsINSm
         mge9xNB7eH+8Ot3Xar9TE1/Ha0PuAMfleeLq1Ru/qd2Z66jsyoiQW5lsdkFWMgJxexmF
         sI1ese7vRt5LXYZodh2WNREfYDSOlxubv9vK6Lg/h9yKVXqJgOzXcytWZXLd5jlsjCs5
         1fLQ==
X-Gm-Message-State: AOAM533crbZEN7gs6K9oZ/CnbFoNHOgnLb8Eg50GgOdLURKwtRiLFZuL
        akSztLsD9w3RVhuMCJ1+6w==
X-Google-Smtp-Source: ABdhPJzc+fQoBV2lT16gBbIqtaFuBMqWCTKtOs8PCJYY7mvyB6XAfk0qjEUHRzfKQpL+0Grdnqg92A==
X-Received: by 2002:a05:6820:54c:: with SMTP id n12mr1860741ooj.73.1594677550835;
        Mon, 13 Jul 2020 14:59:10 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id n6sm3250635otq.33.2020.07.13.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:59:09 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:39bb:a3d6:481a:933c])
        by serve.minyard.net (Postfix) with ESMTPSA id 3B474180050;
        Mon, 13 Jul 2020 21:59:08 +0000 (UTC)
Date:   Mon, 13 Jul 2020 16:59:07 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: 200ms delays with SCTP streaming data
Message-ID: <20200713215907.GE3235@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi, it's me again with another strange issue.  In case you didn't figure
it out before, I'm working on a library that supports all different
types of stream I/O, and SCTP is one supported building block.  I
noticed when I stacked a multiplexer layer on top of SCTP I started
getting timeouts occasionally.  It took a bit, but I finally realized
that I was getting 200ms delays occasionally between sending a packet
and receiving a packet.  I verified this with a trace right at the
sctp_send() and sctp_recvmsg() calls.  It doesn't seem to be regular
in any way I can see, but it happens often enough to cause issues.

If I replace the SCTP block with a TCP block, it works fine, and pretty
much all the code is the same except where it does the read and write
calls (including the epoll() usage, and I have also switched to select()
and it has the same issue).  The write calls don't seem to be the issue,
I see two back-to-back writes a few microseconds apart and see a 200ms
delay between the messages on the receive side.

The test in question sets up two connections and does a big simultaneous
bidirectional transfer.  The test app has 4 threads waiting on epoll()
handling data and writing data.

And the delay is always ~200ms.  Which sounds suspicious.

It's not using sctp_sendv() at the moment, as the systems I'm running on
don't have that yet.  But the library does have support if it sees it is
available.

So I don't think it's my library; I've stared at it a bunch (and found a
few other bugs) but I can't reconcile this one.  There are no timers
that would cause this in the code in question.  Just basically an
epoll() call waiting on data and receive processing that is comparing
data, along with write processing that is sending the same data.

Anyway, I haven't tried to create a small reproducer; I thought I would
report it first and see if anything rang a bell.  I tried this on a
recent kernel and got the same issue.

The library is at https://github.com/cminyard/gensio.  I'd need to
provide a patch for the tracing.

-corey
