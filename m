Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1E289DA4
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Oct 2020 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgJJCoh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 9 Oct 2020 22:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgJJCfg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Oct 2020 22:35:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6024C0613CF
        for <linux-sctp@vger.kernel.org>; Fri,  9 Oct 2020 19:35:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f21so11519657wml.3
        for <linux-sctp@vger.kernel.org>; Fri, 09 Oct 2020 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CF8TFg3kapIW2S+MkNZ9J56TkPBmpKUJ25XIxAx9AQ0=;
        b=VuqTZrzKBpORgGMw48Ggx/wIC4Ut9dghjl1JefAQ5ckz9Y9q1z5ANaGeSWJFDFgoMM
         5uYxHts9dEN+Ph+s/9xhHC6hqYCH371A8f9PmycTsB65WXPIOwwWAsWMdh+LueYwkfSO
         noIimFgrlchF/exatdzRg08dyHy34mphhxvjCkOcznQJiHQMTSlT2Onu+uwC6kCkAx45
         mgnM2CR4z0HQ5IM1gTY46idgLLqNVyOYYhfIFZJzK5fC2LpV8+zWkBwsJSRAPJQmUBkH
         SSCp69lzd+tQFm52KlRqnoQN7VAqFb8PXnOL8s+87JjMrspJiMdihvjyKhENo2MknZwg
         mRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CF8TFg3kapIW2S+MkNZ9J56TkPBmpKUJ25XIxAx9AQ0=;
        b=ETx5UFHNBV2c4TccJR8Bd8E/sYB84LW/KtW95vGIqwNSgFwKEpIuQpZYXhJap4dswr
         emt+QFQD++BZ1Zfl+T5ing0F4N4hwpgh8s300E48MxmA0l5Sir2ZNyQjv2aqTMatcmYI
         ulWTNCrUZ1pfqB82VOJwiSOARqzznBII4nDhnMuxr3ZIbEETcfKHZKgdfXT2gunBmjvY
         aiXfhnQFX536tb+y+FlD17fRP2KPBN3iXNvmyD5VKHBGFIyy9M1FnP4y8AK1yFLe6GEV
         c189hhb8r23am/CpOAFj8M6WuNyV/YCsPaC0NiIdMB2SjuTBN3yxqXjVIp5IKFYXtdKh
         lrcw==
X-Gm-Message-State: AOAM533cjBSexZIE48O7bHqm5G3FIvN7AMgUwjHZqp86qaT9Kp7T/EjS
        7HdTLremSZhcjRY0yIB3xQTsJ9YmpJHgExNaZeI=
X-Google-Smtp-Source: ABdhPJxtqBInF/XMY+vl246CN69RT+P4baoFaw5PWd8VmIMVUuw9HsGnb1DSeAat8TCAXZ3kC4ZgZb4pWEtoRR3VCzk=
X-Received: by 2002:a1c:1905:: with SMTP id 5mr747891wmz.32.1602297333456;
 Fri, 09 Oct 2020 19:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <e377e7e2a87e4f078e7a6d82992cfda0@AcuMS.aculab.com>
 <CC1FDC9B-F273-475A-98C5-000ADC395BB0@list.fink.org> <73434b87932e46a89dd1b5b5132b3196@AcuMS.aculab.com>
 <766ffacb7d4c48df81aea64204ff37d9@AcuMS.aculab.com>
In-Reply-To: <766ffacb7d4c48df81aea64204ff37d9@AcuMS.aculab.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 10 Oct 2020 10:35:22 +0800
Message-ID: <CADvbK_farVU-bB9NeLSDfmCgPcdG2Oe44-odeU0o+b2BwfRA0g@mail.gmail.com>
Subject: Re: sctp discarding received data chunks
To:     David Laight <David.Laight@aculab.com>
Cc:     Andreas Fink <afink@list.fink.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Oct 9, 2020 at 9:03 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: David Laight
> > Sent: 09 October 2020 12:14
> >
> > From: Andreas Fink
> > > Sent: 09 October 2020 08:25
> > >
> > > Can you see this issue with the 5.4 kernel too?
> > >
> > > I did yesterday some testing by upgrading kernel from 5.4 to 5.7 and I run into all sorts of links
> > > going off after a while so I had to revert back.
> > > 5.4 is stable for me. 5.7 is not. And I have lots of M2PA and M3UA connections like you
> >
> > I've just spent hours digging through my traces.
> > It is only some messages through the connection that get lost!
> >
> > Now SCTP_MIN_IN_DATA_CHUNK_DISCARDS is only incremented in two
> > adjacent places in sm_statefuncs.c.
> >
> > Either for bad TSN (unlikely when everything is using "lo")
> > and bad STREAM.
> > I suspect it is the 'bad stream' case.
> > I've not double-checked but I bet the discarded packets
> > all have a large stream number.
> ...
>
> If I dump out /proc/net/sctp/assocs and look way over to the right
> (on the next monitor but 1) there are two columns INS and OUTS.
> I've just realised that these are the number of streams.
> Now all my connections are loopback - so I see both sockets for each.
> So I'd expect the INS to match the OUTS of the peer.
> This isn't true.
> When the value should be negotiated down the OUTS value is unchanged.
> So the kernel is sending packets with illegal stream numbers.
> These are acked and then silently discarded.
did it do addstream reconfig or receive any duplicate COOKIE-ECHO in your case?
