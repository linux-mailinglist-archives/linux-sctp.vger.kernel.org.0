Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A200D38B2CF
	for <lists+linux-sctp@lfdr.de>; Thu, 20 May 2021 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhETPPM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 20 May 2021 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhETPPL (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 20 May 2021 11:15:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3ABC061574
        for <linux-sctp@vger.kernel.org>; Thu, 20 May 2021 08:13:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r12so18068315wrp.1
        for <linux-sctp@vger.kernel.org>; Thu, 20 May 2021 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bPmHYyl8QxCLfhtZIq65woICBYsW2OqgoD7ojR90/Q=;
        b=qgFs8CFf7S/AYEgF8F1eGvEESmsFyVcZZujlNHwJQ/WWzjarGIEeJxk8K1fdN4UDwY
         YkQrJn4iGe05B/585iSSvGpXtj7y+dd4AArR5kLMtWtU6sN1XfJaOy3crn8vv8rKXN/i
         +1eNtghiCBiaG2a5PK814njS5MBIDAhQoVC6S2oaxNi3MUjjcmqdoTr9J6L0XFg+EXni
         rvtwu4HxnyzknUcNV8jEvJ9sK8FmGA+J38pPav3q6Sh8HAH4d2wc++S/3fEVKjEd4DLq
         jvd1gbNxVtrZ/V+vWWcRz8rQPKKCVFYreoFsaZ3h+IR3zHyoh2CGqBHsOmPDtakUQFDi
         FkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bPmHYyl8QxCLfhtZIq65woICBYsW2OqgoD7ojR90/Q=;
        b=UoyN/fia6f9w9Z3wSjh7126U58+Rqj+aKb5HvsUxWkzN3Zn1QqYfbYQTi1+Avv8a7v
         3t6mAX8LWLgTkB9mRtiTtMfsJCKP8TpTwn7LoqnFuFrIstTvxVvotlvLKRGvwigaiYEi
         UU5wfDzjwFe/jSDhpcTCHdUT+v+YZipkuWKHprrAIE5SiJB5Pg9TmSB6/VkLIRZtLI73
         EjYug+CsBdujOWS0bGHP7Hc3oKQmrbt1zDB2DQeQ0Kzys2bHebQRh4BZa4hGUaQdLFaR
         joRuWjjPzt7ECXsctA8BJACUUHmmiv6Ylg4V7NSY/L1+U1cU/guoYwLJdz1yK22wOrkz
         KHug==
X-Gm-Message-State: AOAM530bwpWpMcu54n4NNkDBggnDwYLF+y0yo/KjexIju0G4VrCz7h9U
        gGIc3CSFPbVaxPvwx4dDz+C0u6HHK27WBU3FPn6BYd6uafENJ4DN
X-Google-Smtp-Source: ABdhPJw4eiksYP5Wy+f4nY3ZTLwLKbaohw0C71tsZnlwhKdv7lGaQR3HNGKa1Gq1mSrdF1uzAcokp0FdV6gKEgRmrF4=
X-Received: by 2002:adf:b64b:: with SMTP id i11mr4882267wre.157.1621523627554;
 Thu, 20 May 2021 08:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org> <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <DE8A113C-DF80-412E-A5C1-C0731E1757E2@freebsd.org> <CALnP8ZZd5B-S_jDtCeqbVqZNg5snnEs1v+uiGFc06FkMSk=BdA@mail.gmail.com>
 <CADvbK_eBn7taHnLDNy9B3qbqnzh8UwTJMv8eDPDOdW0MtqOE1A@mail.gmail.com> <364C37C5-5828-401C-BDD0-F345B288CE81@freebsd.org>
In-Reply-To: <364C37C5-5828-401C-BDD0-F345B288CE81@freebsd.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 20 May 2021 11:13:35 -0400
Message-ID: <CADvbK_eBZo3u90ZXBQuVBVov6V26580yXcXH-HZSFsgGU0OT7w@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     Marcelo Ricardo Leitner <mleitner@redhat.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        =?UTF-8?B?VGltbyBWw7Zsa2Vy?= <timo.voelker@fh-muenster.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, May 20, 2021 at 3:06 AM <tuexen@freebsd.org> wrote:
>
> > On 20. May 2021, at 04:05, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Wed, May 19, 2021 at 6:24 PM <mleitner@redhat.com> wrote:
> >>
> >> On Tue, May 18, 2021 at 09:19:21PM +0200, Michael Tuexen wrote:
> >>>
> >>>
> >>>> On 18. May 2021, at 20:33, Xin Long <lucien.xin@gmail.com> wrote:
> >>>>
> >>>> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> >>>>>
> >>>>>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi, Michael,
> >>>>>>
> >>>>>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> >>>>>> and to make this be controlled by setsockopt with
> >>>>>> SCTP_PEER_ADDR_PARAMS, as in
> >>>>>>
> >>>>>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> >>>>>>
> >>>>>> we need another two flags to add for spp_flags:
> >>>>>>
> >>>>>> SPP_PLPMTUD_ENABLE
> >>>>>> SPP_PLPMTUD_DISABLE
> >>>>>>
> >>>>>> Do you think it makes sense? if yes, does the RFC6458 need to update?
> >>>>>> if not, do you have a better suggestion for it?
> >>>>> It is great new that you want to implement RFC 8899. I plan to do the
> >>>>> same for the FreeBSD stack.
> >>>>>
> >>>>> In my view, RFC 8899 is the right way to implement PMTU discovery.
> >>>>> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> >>>>> think that the user needs to control which method is used.
> >>>>> I you want to support multiple versions, I would make that
> >>>>> controllable via a sysctl variable. But I think for FreeBSD, support
> >>>>> for RFC 8899 will be the only way of doing PMTU discovery. There
> >>>>> might be multiple choices for details like how to do the searching,
> >>>>> how long to wait for some events. These will be controllable via
> >>>>> sysctl.
> >>>>>
> >>>>> So in my view, there is no need to extend the socket API. What do you think?
> >>>> OK, that makes sense to me.
> >>>>
> >>>> Another thing I want to know your opinion on is:  do you think the HB
> >>>> should be created
> >>>> separately for PLPMTUD probe, instead of reusing the old HB that
> >>>> checks the link connectivity?
> >>> Yes. I think testing for connectivity is conceptually different
> >>> from testing a particular PMTU. When testing for PMTU, I think
> >>> about sending probe packets. Not that they consist of a HB chunk
> >>> bundled with a PAD chunk.
> >>>> As the HB for PLPMTUD probe might get lost, which we don't want to
> >>>> affect the link's
> >>>> connectivity.
> >>> Yes, I agree completely.
> >>
> >> With this, Xin, seems we should have a separate timer for the
> >> PROBE_TIMER, other than the heartbeat one.
> >>
> >> Otherwise, converging the two logics into one single timer is not
> >> worth the hassle for saving a timer. For example, we would have to
> >> have it fire on the active transport but to send only the probe.
> >> Also, considering they can and (AFAIU the RFC) should have different
> >> expire timeouts from time to time.
> >>
> >> With a separate timer, we won't have issues converging the
> >> user-selectable heartbeat interval to the recommended 600s
> >> PMTU_RAISE_TIMER, for example.
> >>
> >> Maybe I am missing something. But it seems the hassle for reusing the
> >> timer here is just not worth it. Thoughts?
> > You're right, when I was doing testing, I had to set the hb_interval to 5s.
> > the common value of hb_interval really doesn't fit in the probe_interval.
> > I will try adding a new timer, but at the same time a probe_interval
> > by sysctl/sockopt may be needed, or we can use a value equal to
> > (hb_interval / n) for it?
> Yeah, this is why I did not write a socket API section for RFC 8899. I think
> when implementing it, one will find some parameters which can or should
> be controlled by the application. So I guess there will be more than this
> one.
>
> Timo (CCed) is working on some algorithmic explorations, since RFC 8899, gives
> you some freedom. Right now, his work is done in a simulation environment, but
> once that is finished and he came to some conclusions, we will implement this.
>
> So what about:
>
> * Try to implement PLPMTUD and figure out what you need as user controllable
>   parameters.
> * Bring this up for discussion and we can agree on them and also on how
>   to control them via socket options.
> * Then you get the code into the Linux tree.
>
> That way we would know what parameters are really needed in an implementation
> and we would have a common interface.
Makes sense.

>
> Does that make sense to you and sounds like an acceptable plan?
That sounds a good plan, :-)

Thanks.

>
> Best regards
> Michael
> >
> >>
> >> Best,
> >> Marcelo
> >>
> >>>
> >>> Best regards
> >>> Michael
> >>>>
> >>>>>
> >>>>> Best regards
> >>>>> Michael
> >>>>>>
> >>>>>> Thanks.
> >>>>>
> >>>
> >>
>
