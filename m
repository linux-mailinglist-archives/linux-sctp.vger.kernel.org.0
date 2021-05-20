Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4729389B25
	for <lists+linux-sctp@lfdr.de>; Thu, 20 May 2021 04:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhETCG5 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 May 2021 22:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhETCG5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 May 2021 22:06:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659D9C061574
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 19:05:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r12so15926240wrp.1
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 19:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4r6i+1zAV8HmWkJNeWD/ldpQokWsuL5+0dLjJv55fM=;
        b=SiBx+RewcGxPWg1arwhkpCypbTY+kIVwWGIfVScdXd6iqSfDQQVfwKt05svO3y+PBZ
         4z6ReTBf7IrPlrW93pTlnG5pyrrK6oY1BhpON6kxknlyxpDfWbD2TEB2HX54JAEJjio9
         sui9Pq6wggFgkqWMe5ghTRZlNrPG0PY5LU4HE9knOd51iFwA2cb6vYXtjEzEda5Z3tiw
         FTWgdZ8DqB2H7O+EtnP7syU0xFjjShZQhvgTe4K5z1hnb5J5d+am0KjcyB+9pQf5N5Jm
         /pvVazAo08+m1VZYM0afWhaXGhA3uYXqTZ4FLP01M6/Nw+bDiz98rATi/lXiEqskTMsj
         vGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4r6i+1zAV8HmWkJNeWD/ldpQokWsuL5+0dLjJv55fM=;
        b=Nnm+bUYRkqZXOqNdcCqA9NTcI5qsgolindNIH4aVIuC8G+mDWo6+eZLPWn6NlNn0y7
         hlf08P2vmwHd0p9KEybdSb2ABzUEdwG9PqbjpVDfUnjw70922J9u6Tci5o0gqinGuAgv
         pcF3ikj06X7axufmgDEeVVkU4t0hKSB1eXRx4R6sAdXD3G3/0Bj9KwbxuCCId5x2HHOq
         p5JSRtoacjeM+wJJhQ/GfwjfSjT2q4TC4bND2eI9rFkYl+CgSCp+o53F6AH5dAlS6SNG
         lTr/u2eM/tcwcmjEOb/kMCCgb/shcO3FNuZ3Lq71Hi/li6oBKEt0WhijTY7hL1neH8bj
         ldRw==
X-Gm-Message-State: AOAM530ylL9/MByjVSUsUDAPe5cobF16JGLgm2if9JliJPmu4LvWLSJ6
        lJvDDT42TmWxcv1s9hFzDLrf1thtBNO3o0wX3wBxxi03nGjdlQ==
X-Google-Smtp-Source: ABdhPJy9DERmDw4gkZUlkrDU4agfq+2veHMrHcBDz7n9pH2CpcJFj5jIWpEPTEVbs/OYZIPXjUiQVuhc7UQ1fxXU94w=
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr1659053wry.243.1621476334965;
 Wed, 19 May 2021 19:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org> <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <DE8A113C-DF80-412E-A5C1-C0731E1757E2@freebsd.org> <CALnP8ZZd5B-S_jDtCeqbVqZNg5snnEs1v+uiGFc06FkMSk=BdA@mail.gmail.com>
In-Reply-To: <CALnP8ZZd5B-S_jDtCeqbVqZNg5snnEs1v+uiGFc06FkMSk=BdA@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 19 May 2021 22:05:22 -0400
Message-ID: <CADvbK_eBn7taHnLDNy9B3qbqnzh8UwTJMv8eDPDOdW0MtqOE1A@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc:     Michael Tuexen <tuexen@freebsd.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 19, 2021 at 6:24 PM <mleitner@redhat.com> wrote:
>
> On Tue, May 18, 2021 at 09:19:21PM +0200, Michael Tuexen wrote:
> >
> >
> > > On 18. May 2021, at 20:33, Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> > >>
> > >>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> > >>>
> > >>> Hi, Michael,
> > >>>
> > >>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> > >>> and to make this be controlled by setsockopt with
> > >>> SCTP_PEER_ADDR_PARAMS, as in
> > >>>
> > >>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> > >>>
> > >>> we need another two flags to add for spp_flags:
> > >>>
> > >>> SPP_PLPMTUD_ENABLE
> > >>> SPP_PLPMTUD_DISABLE
> > >>>
> > >>> Do you think it makes sense? if yes, does the RFC6458 need to update?
> > >>> if not, do you have a better suggestion for it?
> > >> It is great new that you want to implement RFC 8899. I plan to do the
> > >> same for the FreeBSD stack.
> > >>
> > >> In my view, RFC 8899 is the right way to implement PMTU discovery.
> > >> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> > >> think that the user needs to control which method is used.
> > >> I you want to support multiple versions, I would make that
> > >> controllable via a sysctl variable. But I think for FreeBSD, support
> > >> for RFC 8899 will be the only way of doing PMTU discovery. There
> > >> might be multiple choices for details like how to do the searching,
> > >> how long to wait for some events. These will be controllable via
> > >> sysctl.
> > >>
> > >> So in my view, there is no need to extend the socket API. What do you think?
> > > OK, that makes sense to me.
> > >
> > > Another thing I want to know your opinion on is:  do you think the HB
> > > should be created
> > > separately for PLPMTUD probe, instead of reusing the old HB that
> > > checks the link connectivity?
> > Yes. I think testing for connectivity is conceptually different
> > from testing a particular PMTU. When testing for PMTU, I think
> > about sending probe packets. Not that they consist of a HB chunk
> > bundled with a PAD chunk.
> > > As the HB for PLPMTUD probe might get lost, which we don't want to
> > > affect the link's
> > > connectivity.
> > Yes, I agree completely.
>
> With this, Xin, seems we should have a separate timer for the
> PROBE_TIMER, other than the heartbeat one.
>
> Otherwise, converging the two logics into one single timer is not
> worth the hassle for saving a timer. For example, we would have to
> have it fire on the active transport but to send only the probe.
> Also, considering they can and (AFAIU the RFC) should have different
> expire timeouts from time to time.
>
> With a separate timer, we won't have issues converging the
> user-selectable heartbeat interval to the recommended 600s
> PMTU_RAISE_TIMER, for example.
>
> Maybe I am missing something. But it seems the hassle for reusing the
> timer here is just not worth it. Thoughts?
You're right, when I was doing testing, I had to set the hb_interval to 5s.
the common value of hb_interval really doesn't fit in the probe_interval.
I will try adding a new timer, but at the same time a probe_interval
by sysctl/sockopt may be needed, or we can use a value equal to
(hb_interval / n) for it?

>
> Best,
> Marcelo
>
> >
> > Best regards
> > Michael
> > >
> > >>
> > >> Best regards
> > >> Michael
> > >>>
> > >>> Thanks.
> > >>
> >
>
