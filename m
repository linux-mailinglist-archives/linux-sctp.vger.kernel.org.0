Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA63895B2
	for <lists+linux-sctp@lfdr.de>; Wed, 19 May 2021 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhESSpy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 May 2021 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhESSpx (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 May 2021 14:45:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1676C06175F
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 11:44:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a4so1976496ljd.5
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flwa+RFmdEqqqMEh+dGEermcwRofrtfIPVBkQcp+g5M=;
        b=PSuP5B/d3b5bPrT8jUSU/fWXAhtJ3502ehDHm8ptVaYcZwYQeU9r9kol6yVdImXQ/2
         4zgU9KFj3AwoBVmrOieOZIL67GnR3duL/XMW6L1b648179H2yPAChixy/i5Foex687+D
         Mj/qx605b0V61NS5Dl2+shUeTqyLck5vifp1G/6aADuuYWN87zwL9bYjSt9h28yfxNsE
         866WmaNynusjq5gbszOh/s7rYZ6iv9HsivR16zcFM7yQgYsXDdGB7uzmRa+rMN687y+T
         JW5FoeQCpJVzmxZQ2KMdWOY6ByuiiufNIjGQLPqCnDXfC5t4/mxg9uHD9koKpMyiOXcT
         /xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flwa+RFmdEqqqMEh+dGEermcwRofrtfIPVBkQcp+g5M=;
        b=O7Nd8qIHg1VVPsVAHJU9vLRm1GyrWWbaR68tAbDoVpWok+gzdAkvZuNziHPXDJkQfH
         MkT2bmZf1SOgc8SYcv0EtbVY/glejO4CvtoNlgV+HOfApd0Nzy4EBHV4qRBa4rM68ksv
         eCe//IPMsBQGtDgcugvIMAIMFOHta7dOYnnQf+j8nREJHD1ntOh0K7oZB7mxd+FUsx5K
         UBx3ikjYySLztKf6HzjO1eR0zjDyTZYnd0qPX9KRoW4Fos9/CGAnGcSxeMg6yCqvs3U9
         LIRo0azZ/qeH2KXI1wIivZGU4X6JnuBxMK3doc/CtkFmEGJlXAjw9xpqkDTvemoWasNI
         A2RQ==
X-Gm-Message-State: AOAM533A2+G5FmuJjQVBmpAa6cXXRsxeqHddBODuC8sxaQqfmUeESG48
        RKaKT6GrPolZg8qjVMCO2AjzxJMl278QWvkaVKw=
X-Google-Smtp-Source: ABdhPJxVWzueJRgm/WGmU1AAe5YwpFzY71t9cQasJ1UvSS6QuJTjEYF2O231sQ4KphTgkTiB+bfp0XYMGxp8VsQxEVM=
X-Received: by 2002:a05:651c:38d:: with SMTP id e13mr420867ljp.226.1621449872020;
 Wed, 19 May 2021 11:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org> <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <CADvbK_dVWjzi-w0JqvuGz7SsBUpvhUBQ5mew3kOQ0OymCwvh=w@mail.gmail.com> <8C3219EB-1BEF-4F96-B881-8BDCA2EC98EE@freebsd.org>
In-Reply-To: <8C3219EB-1BEF-4F96-B881-8BDCA2EC98EE@freebsd.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 19 May 2021 14:44:20 -0400
Message-ID: <CADvbK_eujoHWiM88VDRHmtfXLWrBaBtUBjD2wYqQcQ=VssdaoQ@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 19, 2021 at 2:15 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>
> > On 19. May 2021, at 18:18, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Tue, May 18, 2021 at 2:33 PM Xin Long <lucien.xin@gmail.com> wrote:
> >>
> >> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> >>>
> >>>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> >>>>
> >>>> Hi, Michael,
> >>>>
> >>>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> >>>> and to make this be controlled by setsockopt with
> >>>> SCTP_PEER_ADDR_PARAMS, as in
> >>>>
> >>>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> >>>>
> >>>> we need another two flags to add for spp_flags:
> >>>>
> >>>> SPP_PLPMTUD_ENABLE
> >>>> SPP_PLPMTUD_DISABLE
> >>>>
> >>>> Do you think it makes sense? if yes, does the RFC6458 need to update?
> >>>> if not, do you have a better suggestion for it?
> >>> It is great new that you want to implement RFC 8899. I plan to do the
> >>> same for the FreeBSD stack.
> >>>
> >>> In my view, RFC 8899 is the right way to implement PMTU discovery.
> >>> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> >>> think that the user needs to control which method is used.
> >>> I you want to support multiple versions, I would make that
> >>> controllable via a sysctl variable. But I think for FreeBSD, support
> >>> for RFC 8899 will be the only way of doing PMTU discovery. There
> >>> might be multiple choices for details like how to do the searching,
> >>> how long to wait for some events. These will be controllable via
> >>> sysctl.
> >>>
> >>> So in my view, there is no need to extend the socket API. What do you think?
> > I just noticed that with multiple versions supported, and without extending
> > this API, all applications will have to use the same version as it's
> > controlled by
> > sysctl. And when switching to another version by sysctl, all
> > applications will be
> > affected and have to do the switch. that seems not nice.
> That is true, but an application can not expect any specific behaviour
> right now when they are not disabling PMTUD.
>
> What about adding a sysctl variable, which defines the default
> algorithm and a socket option, which allows to get and set
> the algorithm being used.
yes, that's also what I'm thinking.
sysctl is always used for the default value for future sockets.
and the socket option should be added for a socket/asoc's setting.

SCTP_PTMUD_METHOD?
0: PTB one
1. PLPMTUD

>
> Best regards
> Michael
> >
> >> OK, that makes sense to me.
> >>
> >> Another thing I want to know your opinion on is:  do you think the HB
> >> should be created
> >> separately for PLPMTUD probe, instead of reusing the old HB that
> >> checks the link connectivity?
> >> As the HB for PLPMTUD probe might get lost, which we don't want to
> >> affect the link's
> >> connectivity.
> >>
> >>>
> >>> Best regards
> >>> Michael
> >>>>
> >>>> Thanks.
> >>>
>
