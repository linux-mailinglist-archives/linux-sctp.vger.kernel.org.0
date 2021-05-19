Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DA38937E
	for <lists+linux-sctp@lfdr.de>; Wed, 19 May 2021 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhESQUI (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 May 2021 12:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhESQUI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 May 2021 12:20:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A7C06175F
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 09:18:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so14642255wrq.6
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1+kW6CJnf+tOAGUbaMfrS4u2BAk31hSIJnV/FBW45U=;
        b=hfYrkQjc71e6qX2LE0HNvo1x95laKEK0GDDwEmpThGHW/vmEX2QYZdyqnONrIuNDLo
         f6bxPKaWVBo/HO0ERv7FeDHt0Z0hoA743mLFGz6fF1QAyJNv8aYXWGY4rceKiWb0vB8p
         TL/PSLjoLlMv4AP1d4h0pBlpYekl8VG+dzwBP0GkCOOnNkI51oOpbCinbyURgBK6i5YK
         BjkLn+8n+oKFENUcD8mm99ChjDIttGq21xVYw7kAhi2ZgqGsLejgJSo6pEc9tCrHdL9c
         J2e2iDJTUh+MYb91e/dInltvniBqXjYj99uqIOMC1hL+ptYUoXw4lx8fx0G1+e52bBR+
         I1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1+kW6CJnf+tOAGUbaMfrS4u2BAk31hSIJnV/FBW45U=;
        b=DPy/zojX+flwEk6Qqj/F5cDcsSwPCJJuQG52Z7Dp3yh6khMm/gJXvVjNuMTL/v52/9
         BLFn271413JCkhmbaSyy2GntpFa40udbL3SNBKIHi9puHnlcU7sl4vIZDx3JJjpzyUuy
         FAWsCXph/lbXvt+seS9SQqItOvzKRgfb4o5SYgqB6Csn+L/TG/0TlFCBa31JwYW6G7+Y
         4olOP2O2yLZTD+BbgReq04dPLPupuzJJvzDqzaOwpaJU59YDVtOvTucoaU4ikA43a5y0
         1sia+3LqZ06FHi+wMRrTPtKNPYGJKSMX0CgmOdg94zqg9oki9S+THhCiT5iBrqLVV538
         /meQ==
X-Gm-Message-State: AOAM532LCOoHC+vzgWHiMsg0vM3MPXnr4k7YK0lDJ5tWQlk+PWNfD84P
        wCdeN/bS0spXuDcohUzroVyZb95+kOHjmQitpjY=
X-Google-Smtp-Source: ABdhPJwSK+cqFfQWis4dHJZ1ZIxgYmUXP2PlDJXdY2Y32M/ZfBgAbjUAq+K8JdPIZXjQlzbQkDKPd6OZ+MOSZxPn2wY=
X-Received: by 2002:adf:b64b:: with SMTP id i11mr15763188wre.157.1621441127303;
 Wed, 19 May 2021 09:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org> <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
In-Reply-To: <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 19 May 2021 12:18:35 -0400
Message-ID: <CADvbK_dVWjzi-w0JqvuGz7SsBUpvhUBQ5mew3kOQ0OymCwvh=w@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, May 18, 2021 at 2:33 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> >
> > > On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > Hi, Michael,
> > >
> > > We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> > > and to make this be controlled by setsockopt with
> > > SCTP_PEER_ADDR_PARAMS, as in
> > >
> > >  https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> > >
> > > we need another two flags to add for spp_flags:
> > >
> > >  SPP_PLPMTUD_ENABLE
> > >  SPP_PLPMTUD_DISABLE
> > >
> > > Do you think it makes sense? if yes, does the RFC6458 need to update?
> > > if not, do you have a better suggestion for it?
> > It is great new that you want to implement RFC 8899. I plan to do the
> > same for the FreeBSD stack.
> >
> > In my view, RFC 8899 is the right way to implement PMTU discovery.
> > So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> > think that the user needs to control which method is used.
> > I you want to support multiple versions, I would make that
> > controllable via a sysctl variable. But I think for FreeBSD, support
> > for RFC 8899 will be the only way of doing PMTU discovery. There
> > might be multiple choices for details like how to do the searching,
> > how long to wait for some events. These will be controllable via
> > sysctl.
> >
> > So in my view, there is no need to extend the socket API. What do you think?
I just noticed that with multiple versions supported, and without extending
this API, all applications will have to use the same version as it's
controlled by
sysctl. And when switching to another version by sysctl, all
applications will be
affected and have to do the switch. that seems not nice.

> OK, that makes sense to me.
>
> Another thing I want to know your opinion on is:  do you think the HB
> should be created
> separately for PLPMTUD probe, instead of reusing the old HB that
> checks the link connectivity?
> As the HB for PLPMTUD probe might get lost, which we don't want to
> affect the link's
> connectivity.
>
> >
> > Best regards
> > Michael
> > >
> > > Thanks.
> >
