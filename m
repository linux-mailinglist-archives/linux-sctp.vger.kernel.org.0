Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E28387FA8
	for <lists+linux-sctp@lfdr.de>; Tue, 18 May 2021 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbhERSe6 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 18 May 2021 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbhERSe6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 May 2021 14:34:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF7C061573
        for <linux-sctp@vger.kernel.org>; Tue, 18 May 2021 11:33:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u133so5951510wmg.1
        for <linux-sctp@vger.kernel.org>; Tue, 18 May 2021 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zjq+cG2EJOiGb1Ju4wG7HKcICr5AhvDcao4aPOTAYNY=;
        b=YPNCCOiELLtB750WjhmyY9Y7xmLvTid24uvnVZBSsLJhFnMy9pd3yibr+l4qZ50+3F
         KpkvQHc03tDaInUXQYAl9i5NMbySZ2otchCdXy0z2F1L0wI+WnUD/O7elgGL43La5AyZ
         xXQYzLB6wb9Paw67uax4ykxzqBn1sK0QX9ponvfmC120pPnZXkE6kOKmYuAEuIOe/5Hp
         VHIo7F0KMCsbDD28dr24p8/K6++6MxR+6DkMv2+RZyx4kPAW3wbmOzOlCBjevDpQNaS4
         QZ1SJ9SxnCkTJ75lZfMO6x4YAibngj5E0T+4e/6sGngFUhjdiK1XUqToXaJmf2e/bwuw
         Nwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zjq+cG2EJOiGb1Ju4wG7HKcICr5AhvDcao4aPOTAYNY=;
        b=WP+2jQTz1Lx5hKb8xIfn26YHe7JiWhp7/Fmc1WU4cpomiXW550s8h6NFT9in+FE/Au
         IImV6zm7cLB2/AIfsKnnMb4lVmE7fDUHA8W2reF1+HTdV2HtZXnT5tufS7SDFg212jBS
         0TARw/BaWrKOIKjduFA2HE6DRET7p02fPBSzMPd7hrAGGePVqIGWJcPvkRKRaqQb0gF8
         tvUwVeM0nMBJE2U++UiKo7GzBxc9TdeWVKIuT05y6fxEFAO/1d3rQ+xW/lujy1slVPjq
         T44hG6olCPtyuZDloz5XXMTijwnSScPGUH7sDuchNRVUaRT3EvX3XSbhes/hchKJ8u0l
         8BqQ==
X-Gm-Message-State: AOAM532fXmfDbJyrIkEjLPrA3ao7/G0KiGXeA3RxQ7ma4P9678I6On8N
        sdxXYeu3Dq9hYUAld9KJqULpv2TZO0IdcBeng/Q=
X-Google-Smtp-Source: ABdhPJzYSwY3nfBLVSiH8alg2f8U0ejzIvAV9crJxyQTA5hkvkc4l/ZZAqIvzyXKTyyRHBygf5LwANO5DB3v6eV4XUA=
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr6921224wml.67.1621362818349;
 Tue, 18 May 2021 11:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org>
In-Reply-To: <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 18 May 2021 14:33:27 -0400
Message-ID: <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>
> > On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > Hi, Michael,
> >
> > We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> > and to make this be controlled by setsockopt with
> > SCTP_PEER_ADDR_PARAMS, as in
> >
> >  https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> >
> > we need another two flags to add for spp_flags:
> >
> >  SPP_PLPMTUD_ENABLE
> >  SPP_PLPMTUD_DISABLE
> >
> > Do you think it makes sense? if yes, does the RFC6458 need to update?
> > if not, do you have a better suggestion for it?
> It is great new that you want to implement RFC 8899. I plan to do the
> same for the FreeBSD stack.
>
> In my view, RFC 8899 is the right way to implement PMTU discovery.
> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> think that the user needs to control which method is used.
> I you want to support multiple versions, I would make that
> controllable via a sysctl variable. But I think for FreeBSD, support
> for RFC 8899 will be the only way of doing PMTU discovery. There
> might be multiple choices for details like how to do the searching,
> how long to wait for some events. These will be controllable via
> sysctl.
>
> So in my view, there is no need to extend the socket API. What do you think?
OK, that makes sense to me.

Another thing I want to know your opinion on is:  do you think the HB
should be created
separately for PLPMTUD probe, instead of reusing the old HB that
checks the link connectivity?
As the HB for PLPMTUD probe might get lost, which we don't want to
affect the link's
connectivity.

>
> Best regards
> Michael
> >
> > Thanks.
>
