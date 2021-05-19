Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D094038996E
	for <lists+linux-sctp@lfdr.de>; Thu, 20 May 2021 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhESWpY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 May 2021 18:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhESWpX (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 19 May 2021 18:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621464243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hdpSqZeMdO6HPTdykNwiENuCmcFvu9nA6NxcdmPIDK4=;
        b=CRF7goNathOBD2DXlWsm+roYHgPUitENfvBcZ8aGP6nVNh88kvLsudiLrrkh6lqXlMy2QW
        A4bXfD19DRhiLNy3fdA+DNeKKJJ9xJCnTFOqJht3Y1/chazBiYtwR/66VtOyacyLs/zE1U
        CdpDNGr1IAE04bBm7ZejPS0AFeV1hSo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-c9gcmyJBM66-NdAe3cwncw-1; Wed, 19 May 2021 18:44:01 -0400
X-MC-Unique: c9gcmyJBM66-NdAe3cwncw-1
Received: by mail-il1-f199.google.com with SMTP id h8-20020a92c2680000b02901646ecac1e5so14312569ild.20
        for <linux-sctp@vger.kernel.org>; Wed, 19 May 2021 15:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=hdpSqZeMdO6HPTdykNwiENuCmcFvu9nA6NxcdmPIDK4=;
        b=kuDF5Rf1gX58xph11oVy+P51amwyyBLXUmwPy6toFN0dYmQ0aaQQ1oPSYDbszqyctb
         S7/IDHnsxCemTxc/u68yINOI4k21FvWgbBp0p7LW3JVREa5Q+LATR3YEZFlMPPMSFMp1
         fFmvdHT99qf8brsgoQrrtUiHpEM5vQEQi7ZNZGrCLki2CavYHrNaFBqDsgl5FFEKxs1G
         pSQvhJ/SjEGtY5M7sYhxj2rJ1tfE25dDxCG5GKJPaAojD8WwuWSwDvf7FsOYStrYY00T
         5UHDeqRKN5t17qsSFALuNzxkidjgPyA0lHsaS6Qbvv6f+9nkz9GuDshrOCrynda5scMn
         2UXg==
X-Gm-Message-State: AOAM532xQA0Po2b8DThorCABBJOiCZRoc045U8TmgomcqpXwT+o0TO/v
        fIAj5rzV1i2lFrsPccKPcSBwWh8p9xATWVEo6BfwMlWNXef36OrA7L2MN0dYRYZaPPyA8/CRc8K
        +C2mtSc04MFRxuC5KkL7rUbLtNjHBDLtYFete+Q==
X-Received: by 2002:a92:c909:: with SMTP id t9mr1583725ilp.184.1621464240834;
        Wed, 19 May 2021 15:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAULbz1cvSGht3sWqnVJvDd2yxtvhfZUPjS7shH6So4w1l3BsqM0OO+5024QyUFPdR3SRcqSamudGfWm3V56Q=
X-Received: by 2002:a92:c909:: with SMTP id t9mr1583701ilp.184.1621464240620;
 Wed, 19 May 2021 15:44:00 -0700 (PDT)
Received: from 868169051519 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 May 2021 22:44:00 +0000
From:   mleitner@redhat.com
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org> <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
 <CADvbK_dVWjzi-w0JqvuGz7SsBUpvhUBQ5mew3kOQ0OymCwvh=w@mail.gmail.com>
 <8C3219EB-1BEF-4F96-B881-8BDCA2EC98EE@freebsd.org> <CADvbK_eujoHWiM88VDRHmtfXLWrBaBtUBjD2wYqQcQ=VssdaoQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADvbK_eujoHWiM88VDRHmtfXLWrBaBtUBjD2wYqQcQ=VssdaoQ@mail.gmail.com>
Date:   Wed, 19 May 2021 22:44:00 +0000
Message-ID: <CALnP8ZZ6k25kL+hZfiCNXEXffHH=jyUb4SYDtuE3oG7_Kp6asw@mail.gmail.com>
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Michael Tuexen <tuexen@freebsd.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mleitner@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 19, 2021 at 02:44:20PM -0400, Xin Long wrote:
> On Wed, May 19, 2021 at 2:15 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> >
> > > On 19. May 2021, at 18:18, Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > On Tue, May 18, 2021 at 2:33 PM Xin Long <lucien.xin@gmail.com> wrote:
> > >>
> > >> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
> > >>>
> > >>>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
> > >>>>
> > >>>> Hi, Michael,
> > >>>>
> > >>>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
> > >>>> and to make this be controlled by setsockopt with
> > >>>> SCTP_PEER_ADDR_PARAMS, as in
> > >>>>
> > >>>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
> > >>>>
> > >>>> we need another two flags to add for spp_flags:
> > >>>>
> > >>>> SPP_PLPMTUD_ENABLE
> > >>>> SPP_PLPMTUD_DISABLE
> > >>>>
> > >>>> Do you think it makes sense? if yes, does the RFC6458 need to update?
> > >>>> if not, do you have a better suggestion for it?
> > >>> It is great new that you want to implement RFC 8899. I plan to do the
> > >>> same for the FreeBSD stack.
> > >>>
> > >>> In my view, RFC 8899 is the right way to implement PMTU discovery.
> > >>> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
> > >>> think that the user needs to control which method is used.
> > >>> I you want to support multiple versions, I would make that
> > >>> controllable via a sysctl variable. But I think for FreeBSD, support
> > >>> for RFC 8899 will be the only way of doing PMTU discovery. There
> > >>> might be multiple choices for details like how to do the searching,
> > >>> how long to wait for some events. These will be controllable via
> > >>> sysctl.
> > >>>
> > >>> So in my view, there is no need to extend the socket API. What do you think?
> > > I just noticed that with multiple versions supported, and without extending
> > > this API, all applications will have to use the same version as it's
> > > controlled by
> > > sysctl. And when switching to another version by sysctl, all
> > > applications will be
> > > affected and have to do the switch. that seems not nice.
> > That is true, but an application can not expect any specific behaviour
> > right now when they are not disabling PMTUD.
> >
> > What about adding a sysctl variable, which defines the default
> > algorithm and a socket option, which allows to get and set
> > the algorithm being used.
> yes, that's also what I'm thinking.

+1

> sysctl is always used for the default value for future sockets.
> and the socket option should be added for a socket/asoc's setting.

Speaking of inheritance, it should also use the SCTP_FUTURE_ASSOC /
SCTP_CURRENT_ASSOC / SCTP_ALL_ASSOC mechanism. Like
SCTP_PEER_ADDR_PARAMS, for example.

The system can provide defaults but if the application requires
something, it should have a good way of requesting it.

Speaking of SCTP_PEER_ADDR_PARAMS, maybe reuse spp_pathmtu field?
As in, if SPP_PMTUD_ENABLE is enabled, spp_pathmtu of "1" or "2" bytes
doesn't make sense, and it could mean the algorithm used. Thing is,
the field is currently ignored, and it could lead to some unexpected
behavior change. It's probably safer to just add another sockopt, but
wanted to share the idea anyway.

>
> SCTP_PTMUD_METHOD?

s/PTMUD/PMTUD/ :-)

> 0: PTB one
> 1. PLPMTUD
>
> >
> > Best regards
> > Michael
> > >
> > >> OK, that makes sense to me.
> > >>
> > >> Another thing I want to know your opinion on is:  do you think the HB
> > >> should be created
> > >> separately for PLPMTUD probe, instead of reusing the old HB that
> > >> checks the link connectivity?
> > >> As the HB for PLPMTUD probe might get lost, which we don't want to
> > >> affect the link's
> > >> connectivity.
> > >>
> > >>>
> > >>> Best regards
> > >>> Michael
> > >>>>
> > >>>> Thanks.
> > >>>
> >
>

