Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FD3AD3F0
	for <lists+linux-sctp@lfdr.de>; Fri, 18 Jun 2021 22:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhFRU4h (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 18 Jun 2021 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhFRU4g (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 18 Jun 2021 16:56:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57633C061574
        for <linux-sctp@vger.kernel.org>; Fri, 18 Jun 2021 13:54:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso9469760wmg.2
        for <linux-sctp@vger.kernel.org>; Fri, 18 Jun 2021 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mjseBwTKhSFuopUIinbCJOzJlL2w/Y1x9Z4xdX/XFLI=;
        b=YE1brhfvMMPJ+Wscx+QwLD7UhH/7hIwFA5ixkE/L56d0FmD8Yh1EZajnw1NClD1noO
         PCKRwWCQ8z29eVl+V2j4QJsoJLPv8zl7872MOn+eVRRftFDecCa0k5cMXfQppPepkrRq
         hDM/LQEeG8aoeeiOBHEQMzCaek4c2GBJDDFB0ESYZAD31ClGWoCXPnqd4AIzwrTH0fMQ
         BAWAOsJZ6mPaluVuyFkTS5KBZDkdWp0UpHZ+axsd+NRCjl1luXh9eR9ICBuJvc/MYhr6
         t8BeC17K+4XnagGj9ESwJmT1sgPcIuL+1EMbFNeyPhNMd8kKPg+JGTnXMToPMPPOTrVS
         XZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mjseBwTKhSFuopUIinbCJOzJlL2w/Y1x9Z4xdX/XFLI=;
        b=n+AO4zFNdF4yHd2/jwxeGK+8mKTBaJSfFAJFd7yVb/8ZdCUitQ2V9AT3Id+lw0ixPu
         x586yJ3cQ4hx53VYUIl6FM+tgH5P5c9Xk8o1qSWXOTYbzwWSsV/JtN2JK5MihRPxJy20
         6DQg882YelQnDKdzP05G0v0POl6D1QyPUUg7xn7Z5yHlrwmI3W9RIbC0IJoXBtH1lfho
         mJHbwPv7yGb3RtSXcbu8G2JD2BLO36Kz/TxugszIMnFbmVeZLh/raHK2SD3VZQPHucvc
         Em22lj9h4zgxjDS1VxyRD9KbScbNHHpgixkIJ44qzjbwRMI5NU7z9yUgKn6G2Jb/EPCb
         Zr9A==
X-Gm-Message-State: AOAM533l7LkGFHK1zYklRhZH7OGknSFhqk7ZbXKLLO5CF/GGMeKAXfrq
        8/sT58rkKKbwo7mci5j99oExdSI5MbrE6UtE9+g=
X-Google-Smtp-Source: ABdhPJx/OziEAB7+NEsQufKk2rSvUA5co4b2Sv+dvmS095KEKivwKAxvzKP+8aD8JCJ6fj3VU+IY4arHa9/oDFRaoIs=
X-Received: by 2002:a05:600c:354d:: with SMTP id i13mr13455208wmq.67.1624049663942;
 Fri, 18 Jun 2021 13:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsBEWmV+yvGQTuqm4FdFUAH5zHDPEXT+3cCUNgq1ZmZrau9Ag@mail.gmail.com>
 <CADvbK_d8=rfzObEYEG35jVdm-yDzc4gN+v4EvRRCnrh8j36h9g@mail.gmail.com> <E440156C-0164-4F55-83A9-860C1180CFDD@freebsd.org>
In-Reply-To: <E440156C-0164-4F55-83A9-860C1180CFDD@freebsd.org>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 18 Jun 2021 16:54:13 -0400
Message-ID: <CADvbK_c=LhYyPKJgVy1nitkEzD6TEO7-VviSW=Ci7rV8zJCZmA@mail.gmail.com>
Subject: Re: draft-stewart-tsvwg-sctp-ipv4 enforcement
To:     Michael Tuexen <tuexen@freebsd.org>
Cc:     =?UTF-8?Q?S=C3=A9rgio?= <surkamp@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jun 18, 2021 at 4:35 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>
> > On 18. Jun 2021, at 18:35, Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Thu, Jun 17, 2021 at 4:40 PM S=C3=A9rgio <surkamp@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> I am troubleshooting a deployment with SCTP and eventually found that
> >> the client has configured the equipment using addresses within the
> >> RFC2544 annex C.2.2 test network (198.18.0.0/15).
> >>
> >> Although I think the deployment network may be changed to use another
> >> address space in order to "solve" the issue, the restriction
> >> enforcement on the SCTP kernel driver (implemented by function
> >> sctp_v4_addr_valid -- net/sctp/protocol.c -- in expansion of
> >> IS_IPV4_UNUSABLE_ADDRESS -- include/net/sctp/consntans.h) seems odd to
> >> me, because the address is a valid unicast IPv4 address and should be
> >> acceptable as per RFC4960 clause 8.4:
> >>
> >>   The receiver of an OOTB packet MUST do the following:
> >>
> >>   1)  If the OOTB packet is to or from a non-unicast address, a
> >>       receiver SHOULD silently discard the packet.  Otherwise,
> >>
> >> The source code states that this restriction came from
> >> draft-stewart-tsvwg-sctp-ipv4, which is true, and the sysctl
> >> net.sctp.addr_scope_policy is documented in ip-sysctl.txt as a switch
> >> for the desired draft behavior, but changing the sysctl value has no
> >> effect because IS_IPV4_UNUSABLE_ADDRESS macro expansion has no
> >> verification of any sysctl configuration nor the sctp_v4_addr_valid.
> >>
> >> The draft-stewart-tsvwg-sctp-ipv4 enforcement seems like a bug or I am
> >> missing something?
> >>
> > There must be a reason for not using 198.18.0.0/24 in SCTP, as in
> >
> >  https://datatracker.ietf.org/doc/html/draft-stewart-tsvwg-sctp-ipv4-00=
#section-3.1
> >
> >   [1]  IANA, I., "Special-Use IPv4 Addresses", draft-iana-special-ipv4-
> >        03 (work in progress), April 2002.
> >
> > https://datatracker.ietf.org/doc/html/draft-iana-special-ipv4-03
> I think not allowing it at all is wrong.
> https://datatracker.ietf.org/doc/html/rfc6890
> states that it is not global. So maybe level 3 would be more appropriate.
>
I will fix it, thanks.

> Please note, the ID was never published as an RFC, so there might be more
> errors...
>
> Best regards
> Michael
>
