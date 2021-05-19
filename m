Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5D389941
	for <lists+linux-sctp@lfdr.de>; Thu, 20 May 2021 00:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhESW0S (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 May 2021 18:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhESW0S (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 19 May 2021 18:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621463097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WbDlMEEF0JdqHmTUuHZhRYI4AztNlwbEAQUTdHbKzns=;
        b=WWYyrUt1ekbEt1dPVhC+XxVYG/QEUXrYSH117jDKipBkD+M12zo/qXtnFCXuqnjsAYdXVr
        seFVZllhWricL5qsM+cHRDKDHOJukfxBJvzV6Y72r8+Gy9VhPeumO3DwHL96jIRDkZH/US
        LpCalSP/9Ro8XyVX2BYywDi3X6A2c/0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-ErVoemb2O-6feIIUjKMMaQ-1; Wed, 19 May 2021 18:24:54 -0400
X-MC-Unique: ErVoemb2O-6feIIUjKMMaQ-1
Received: by mail-il1-f198.google.com with SMTP id d3-20020a9287430000b0290181f7671fa1so14325643ilm.9
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 15:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=WbDlMEEF0JdqHmTUuHZhRYI4AztNlwbEAQUTdHbKzns=;
        b=Yau3JWye7xhsp1Fxok7UDV6YrMuoTXHgnKDvj5sLgzHmrj7EjeLEsmcC9BYzkx3s2f
         KuWiRD0H08pH3IJ/yS86Rm6RTThgsTlO4BzNgYT0pwE+FmKKD8wIQb7Hwx1F4ZX1eFWJ
         HNz7LN14RJz7LB3CuY7eMe1mVMSBaeNuVXVn1Vci+NiO0F9b2hoT97cwe7c4gMLryiwf
         VDWfPXDx6N/8gSAjerD8wtX1KLNZ6aPsf8lHqfWOi3nzGNBuyOLXJDPL5XO04Ls9oQA5
         7QKNvJygn0DgJzS/oVn0yOIHNyntzkp+LRr1fZwNFAvt8HZYDmdY6dMViPKs3ECVFPsT
         e5aA==
X-Gm-Message-State: AOAM5338cDodh33yX9+gSn8jERHZ9XpgdlUMsEQfXfHKDW7YzfjfGv18
        XwO8fQ9N5qprrCayBOQZ0aBlyh8wW/vuTRvDmfzbwiulbNLXRgPOkinpLSeySPOUuVec75U7ZEi
        ONV1p07M+m3bg4CdKEvLSvmT5cWXObZ5/iUK7AA==
X-Received: by 2002:a92:c909:: with SMTP id t9mr1505648ilp.184.1621463094343;
        Wed, 19 May 2021 15:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc/ZvzDE3av0P6Yu3haQ3BMjllGNyiWBpNMfKydqL6LH9EPVAmNk+QLNMe8PXL9FkERJr7ww9VKVYiDuEg8JA=
X-Received: by 2002:a92:c909:: with SMTP id t9mr1505637ilp.184.1621463094142;
 Wed, 19 May 2021 15:24:54 -0700 (PDT)
Received: from 868169051519 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 May 2021 22:24:53 +0000
From:   mleitner@redhat.com
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org> <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <DE8A113C-DF80-412E-A5C1-C0731E1757E2@freebsd.org>
MIME-Version: 1.0
In-Reply-To: <DE8A113C-DF80-412E-A5C1-C0731E1757E2@freebsd.org>
Date:   Wed, 19 May 2021 22:24:53 +0000
Message-ID: <CALnP8ZZd5B-S_jDtCeqbVqZNg5snnEs1v+uiGFc06FkMSk=BdA@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     Xin Long <lucien.xin@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mleitner@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, May 18, 2021 at 09:19:21PM +0200, Michael Tuexen wrote:
>
>
> > On 18. May 2021, at 20:33, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> >>
> >>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> >>>
> >>> Hi, Michael,
> >>>
> >>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> >>> and to make this be controlled by setsockopt with
> >>> SCTP_PEER_ADDR_PARAMS, as in
> >>>
> >>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> >>>
> >>> we need another two flags to add for spp_flags:
> >>>
> >>> SPP_PLPMTUD_ENABLE
> >>> SPP_PLPMTUD_DISABLE
> >>>
> >>> Do you think it makes sense? if yes, does the RFC6458 need to update?
> >>> if not, do you have a better suggestion for it?
> >> It is great new that you want to implement RFC 8899. I plan to do the
> >> same for the FreeBSD stack.
> >>
> >> In my view, RFC 8899 is the right way to implement PMTU discovery.
> >> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> >> think that the user needs to control which method is used.
> >> I you want to support multiple versions, I would make that
> >> controllable via a sysctl variable. But I think for FreeBSD, support
> >> for RFC 8899 will be the only way of doing PMTU discovery. There
> >> might be multiple choices for details like how to do the searching,
> >> how long to wait for some events. These will be controllable via
> >> sysctl.
> >>
> >> So in my view, there is no need to extend the socket API. What do you think?
> > OK, that makes sense to me.
> >
> > Another thing I want to know your opinion on is:  do you think the HB
> > should be created
> > separately for PLPMTUD probe, instead of reusing the old HB that
> > checks the link connectivity?
> Yes. I think testing for connectivity is conceptually different
> from testing a particular PMTU. When testing for PMTU, I think
> about sending probe packets. Not that they consist of a HB chunk
> bundled with a PAD chunk.
> > As the HB for PLPMTUD probe might get lost, which we don't want to
> > affect the link's
> > connectivity.
> Yes, I agree completely.

With this, Xin, seems we should have a separate timer for the
PROBE_TIMER, other than the heartbeat one.

Otherwise, converging the two logics into one single timer is not
worth the hassle for saving a timer. For example, we would have to
have it fire on the active transport but to send only the probe.
Also, considering they can and (AFAIU the RFC) should have different
expire timeouts from time to time.

With a separate timer, we won't have issues converging the
user-selectable heartbeat interval to the recommended 600s
PMTU_RAISE_TIMER, for example.

Maybe I am missing something. But it seems the hassle for reusing the
timer here is just not worth it. Thoughts?

Best,
Marcelo

>
> Best regards
> Michael
> >
> >>
> >> Best regards
> >> Michael
> >>>
> >>> Thanks.
> >>
>

