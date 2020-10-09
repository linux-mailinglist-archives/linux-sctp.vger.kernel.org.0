Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC5288A2D
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Oct 2020 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbgJIOAG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 9 Oct 2020 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbgJIOAG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Oct 2020 10:00:06 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D4C0613D5
        for <linux-sctp@vger.kernel.org>; Fri,  9 Oct 2020 07:00:05 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id 91so3085513uas.7
        for <linux-sctp@vger.kernel.org>; Fri, 09 Oct 2020 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdNA5viYIui8ZzEO9qDR8W/EDw5cr7ptrkpo2/OQ1wI=;
        b=f2gEMnOH5Jv1cz2jPzX1L9PLVIhxgB5FTNzWc7B6gh79QPB9BDDTkOamVbClFj4ewP
         KUywmOTGZOL00COdFkmG+UUycL3eXbsGjEbNPXybiNe5WN2L9JTxblIbse2Ab+7/R799
         sdMkJC0faI5Yeg3KU6NxwTDyL0iQW3U63HAJrD07z9R1LcGlM6IIth+yXEJiCHImhkbd
         jRBfG2eiyT5ZG66Iy6b21Um28PLlyvF8yuQA71KzCj74Ly7y5mORzTjm3IiJV/hYjFYH
         uwlMBHa0Y+yCQdpwHxkzgZ+OjbJJZHF/gz4Ez7mu69f9dzJslxnvIKFkJnHTDvFFlV/s
         ptsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdNA5viYIui8ZzEO9qDR8W/EDw5cr7ptrkpo2/OQ1wI=;
        b=ZCY2/GYL+PL9yH7M0y/+6rQdjl4jSEoskpNPF3tTphStiM383eQcPA/U/sV6F64EdK
         bHig5PweJNskUTGaj0A3t5/h3DafHFjODSjShhDriTz0I8bmWkIN/j5kpjFWTyoKF2Ll
         wABS59kT1ffxrdWjMHbDWPfhPMUsYLX7/4vXRKUlZkfSCC4EB9U/t/dv6FJswGfQf0vs
         1Zt5UW0rYkvq3MhpodL90E16ujQL/o4rJyG03BfQ5E91bUbD+irVnMpWPsyYVlInGaCq
         DtJfDOvI8SmmlpXxOhER1/OQKh5ViTn7sbCay0lGXy5VqJgkTZBwg57uc+0QHihJCu3T
         MoMg==
X-Gm-Message-State: AOAM532ph9eWonJCSsysKVQKWHevF5RA1NvIxfKZgQUJcR6MYeV7lDZs
        eG+uL7SNdd9VTbEgnewwNlKKWKDqB1M=
X-Google-Smtp-Source: ABdhPJxy5Oy5R4VrAwVS0v8tys/vSaF8Oevttw/xFFNLv0Dz7k2FkEKV91BFwBlwEC4yjEozLf+s4A==
X-Received: by 2002:a9f:2343:: with SMTP id 61mr7530572uae.84.1602252004728;
        Fri, 09 Oct 2020 07:00:04 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 102sm1032573uad.3.2020.10.09.07.00.03
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 07:00:03 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id j15so3081747uaa.8
        for <linux-sctp@vger.kernel.org>; Fri, 09 Oct 2020 07:00:03 -0700 (PDT)
X-Received: by 2002:ab0:668a:: with SMTP id a10mr1008616uan.108.1602252003000;
 Fri, 09 Oct 2020 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602150362.git.lucien.xin@gmail.com> <052acb63198c44df41c5db17f8397eeb7c8bacfe.1602150362.git.lucien.xin@gmail.com>
 <c36b016ee429980b9585144f4f9af31bcda467ee.1602150362.git.lucien.xin@gmail.com>
 <CA+FuTScNHkYu2F2xPBjLj9ivfLRXVbTPypgjvtEZrebatpJJfQ@mail.gmail.com> <CADvbK_en7mePKdmMaLr9V8hTdmjf2bSVpSrid2CjharJtvD6YQ@mail.gmail.com>
In-Reply-To: <CADvbK_en7mePKdmMaLr9V8hTdmjf2bSVpSrid2CjharJtvD6YQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 09:59:26 -0400
X-Gmail-Original-Message-ID: <CA+FuTSd1MZusO_9W8tkn99jGCu94o3K+6e8zROz_FNEMWt6Crg@mail.gmail.com>
Message-ID: <CA+FuTSd1MZusO_9W8tkn99jGCu94o3K+6e8zROz_FNEMWt6Crg@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 02/17] udp6: move the mss check after udp gso
 tunnel processing
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Michael Tuexen <tuexen@fh-muenster.de>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Oct 8, 2020 at 9:49 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> On Thu, Oct 8, 2020 at 8:45 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Oct 8, 2020 at 5:48 AM Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > For some protocol's gso, like SCTP, it's using GSO_BY_FRAGS for
> > > gso_size. When using UDP to encapsulate its packet, it will
> > > return error in udp6_ufo_fragment() as skb->len < gso_size,
> > > and it will never go to the gso tunnel processing.
> > >
> > > So we should move this check after udp gso tunnel processing,
> > > the same as udp4_ufo_fragment() does. While at it, also tidy
> > > the variables up.
> >
> > Please don't mix a new feature and code cleanup.
> Hi, Willem,
>
> Tidying up variables are not worth a single patch, that's what I was
> thinking. I can leave the variables as it is if you wish in this patch.
>
> >
> > This patch changes almost every line of the function due to
> > indentation changes. But the only relevant part is
> >
> > "
> >         mss = skb_shinfo(skb)->gso_size;
> >         if (unlikely(skb->len <= mss))
> >                 goto out;
> >
> >         if (skb->encapsulation && skb_shinfo(skb)->gso_type &
> >             (SKB_GSO_UDP_TUNNEL|SKB_GSO_UDP_TUNNEL_CSUM))
> >                 segs = skb_udp_tunnel_segment(skb, features, true);
> >         else {
> >                 /* irrelevant here */
> >         }
> >
> > out:
> >         return segs;
> > }
> > "
> >
> > Is it a sufficient change to just skip the mss check if mss == GSO_BY_FRAGS?
> It is sufficient.
>
> But I think we'd better keep the code here consistent with ipv4's if
> there's no other reason to do 'skb->len <= mss' check at the first.
>
> We can go with if-else as you showed above now, then do a cleanup in
> the future. What do you think?

I do think that's a better approach, thanks.

Mixing in feature changes with 150+ lines of code refactoring makes it
hard to spot the behavioral change.

Too often the additional purportedly noop refactoring proves to have
subtle behavioral changes after all. It's easier to review for this if
that patch is separate. Not saying it's the case here, of course.

Refactoring also adds a layer of indirection when using git blame to
understand code or for people who have the existing code memorized, so
has a fairly high bar imho.
