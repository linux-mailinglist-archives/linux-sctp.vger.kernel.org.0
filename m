Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2581739D8
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2020 15:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1Oae (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 28 Feb 2020 09:30:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36805 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgB1Oae (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 28 Feb 2020 09:30:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id j16so3197799wrt.3
        for <linux-sctp@vger.kernel.org>; Fri, 28 Feb 2020 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+a0z0knsurhgtGFe99Dhly7b9VFWy0V9mH1wa1xElnQ=;
        b=Sj8LPxaRmyAuCNGpPrxzSRI0uPjmYU6IuC2F+GZX8/tFyfTdYK1p3X7kgagACLxQJ/
         Qdn5pbfhj/xqlHzBAYfVV8ZlzNYa8dL8Jet2xgNIQhH1hc5iqIXXPn+NDZBCyiztlxnp
         MHwCwmicIDPY3Jjr0n97l1Mam54/2fyuu4BCoJAXSvc4djflQibR1RPDEwDhTu0FdOmf
         EgFc3qtb+klrrhNVwnrWEPfRMSXRps43fBKfFbXEkwCcbDLKv6QEL0LRnoqkIQvxushM
         1x+3a6R66P2Wf86KOOIHRB5a1CIbHsscUhPhFudM8DAl1oJsBNvmFxRmYcSLmWGIJCZa
         Ug3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a0z0knsurhgtGFe99Dhly7b9VFWy0V9mH1wa1xElnQ=;
        b=gdOw1huNct2OynOG1sUXIDNM1RnIcSsOdYDznFjdO6zYDx3pdk8nqxnmzOrLE7mFx/
         1ZNOsPp37d6quz3zpKFDZgeWjmsuR26AqOr9UZEpG91Lu4rB8wmv5dJToIzd2BbVMzeE
         bH0sHhS6yeAUOya/QWardWwZJ6/lGUOxZpoVnwRdD3znSZ3BcmE2Fd3oDPsNxgkrtg7X
         pg470M/9PeRtF587MlHGXz8WFQuXou5vDpPO5WW38OdV3iivAlKdKpTfezD7NUkCJhf4
         VYrMg+pClVo1N3Jc5EWXwKDsgiFa29rTRJVOAw0Q5+X2ekIF3khHF5ar/qAsA4jJ+b0K
         2AXg==
X-Gm-Message-State: APjAAAVFGEG4F7Qso+loj5GaJE57OTlg00DxUYormNcfj20AYo1wNPaK
        5KzPtCaMH8r3wQv0jqtWT1jQSJUjmyAQN+MwvVWN/Q3eIk8=
X-Google-Smtp-Source: APXvYqz8HTLN5KfVbZErGSFU2iPIZCrHAHFOTIra5Q13uAYFgOWuTjBHEXKlSQk9PUcmJytiSTrO69kF8JIlv2Yj1Qg=
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr5042541wrs.395.1582900231455;
 Fri, 28 Feb 2020 06:30:31 -0800 (PST)
MIME-Version: 1.0
References: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com>
 <HE1PR0702MB361028B4B8C2E4D03AA23B4EECEC0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_f=COyrHh+17pdBq=acmR+cbv08quK6qbpHCg7FbwTsNw@mail.gmail.com>
 <HE1PR0702MB3610F8DFB115DA9D35D71A76ECEB0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_dh1GjDmso9vfHmLEvYhgx3cQ1ajNjafAyyx6hz04_KTg@mail.gmail.com>
In-Reply-To: <CADvbK_dh1GjDmso9vfHmLEvYhgx3cQ1ajNjafAyyx6hz04_KTg@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 28 Feb 2020 22:32:09 +0800
Message-ID: <CADvbK_f8B_-d9XoBvmXFVeBc1xCukSxqOR6Uy+1E-sp+5OBd3w@mail.gmail.com>
Subject: Re: Problems with peeled-off sockets
To:     "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Feb 28, 2020 at 10:31 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 9:57 PM Leppanen, Jere (Nokia - FI/Espoo)
> <jere.leppanen@nokia.com> wrote:
> >
> > On Thu, 27 Feb 2020, Xin Long wrote:
> >
> > > On Tue, Feb 25, 2020 at 3:28 AM Leppanen, Jere (Nokia - FI/Espoo)
> > > <jere.leppanen@nokia.com> wrote:
> > >>
> > >> On Sat, 22 Feb 2020, Xin Long wrote:
> > >>
> > >>> On Thu, Feb 20, 2020 at 5:18 PM Leppanen, Jere (Nokia - FI/Espoo)
> > >>> <jere.leppanen@nokia.com> wrote:
> > >>>>
> > >>>> Hello All,
> > >>>>
> > >>>> According to the RFC, a peeled-off socket is a one-to-one socket. But
> > >>>> in lksctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDTH
> > >>>> style. Because of this, shutdown() doesn't work, linger probably
> > >>>> doesn't work, and so on.
> > >>>>
> > >>>> For example, in sctp_shutdown():
> > >>>>
> > >>>> static void sctp_shutdown(struct sock *sk, int how)
> > >>>> {
> > >>>>         struct net *net = sock_net(sk);
> > >>>>         struct sctp_endpoint *ep;
> > >>>>
> > >>>>         if (!sctp_style(sk, TCP))
> > >>>>                 return;
> > >>>>
> > >>>> Here we just bail out, because a peeled-off socket is not TCP style.
> > >>>>
> > >>>> Is this just a bug, or am I missing something? Asking mostly out of
> > >>>> personal curiosity.
> > >>> I would say, it's because .shutdown is tcp_prot thing and udp_prot doesn't
> > >>> have. sctp doesn't have to implement it for UDP style socket. But for TCP-
> > >>> style socket, sctp is trying to be compatible with TCP protocol user API.
> > >>> But even though,  sctp's .shutdown is still not fully compatible with TCP
> > >>> protocol due to sctp's 3-way shakehands for finishing a connection.
> > >>
> > >> Thanks a bunch for replying, Xin Long. I'm not quite sure what you mean.
> > >> The actual association shutdown doesn't even come into play here, since
> > >> shutdown() doesn't do anything with peeled-off sockets.
> > > Hi,  Leppanen,
> > > sorry for late.
> > >
> > > SCTP has two types of sockets: UDP and TCP styles.
> > > TCP style associations are not allowed to be peeled off.
> > > only UDP style associations can be peeled off.
> > >
> > > Then shutdown can only work for TCP style, this explains
> > > why peeled-off sk can use shutdown.
> > >
> > >
> > >>
> > >> If you mean that the current implementation of shutdown() might have
> > >> some problems with peeled-off sockets; well, that's true, but I suppose
> > >> that means that there's something to fix somewhere.
> > > I think it returns for peeled-off sockets (UDP style sockets) on purpose.
> > > it's like why you want to use shutdown on a UDP socket?
> > >
> > >>
> > >> It looks like the reason for the peculiar socket style of peeled-off
> > >> sockets is that they're created by copying from a one-to-many socket and
> > >> modified a little to resemble a one-to-one socket. But this leads to
> > >> problems in several places in the code. Is this just implementation that
> > >> was never finalized?
> > > Right, peeled-off will allow users to use a new sk to control that asoc.
> > > but again, it's a feature UDP style socket.
> > > any other problems have you seen?
> >
> > To clarify, by "peeled-off socket" I mean a socket returned by
> > sctp_peeloff(). sctp_peeloff() takes as an argument a
> > one-to-many socket, and returns a one-to-one socket.
> >
> > The RFC (https://tools.ietf.org/html/rfc6458#section-9.2)
> > clearly states about the socket returned by sctp_peeloff() that
> > "[...] the new socket is a one-to-one style socket."
> OK, I got you now.
> Linux creates a TCP/one-to-many style socket there actually.
sorry, UDP/one-to-many style.
> Interesting, BSD seems to do the same.
> I will double check and make a patch for this once confirmed.
>
> Thanks.
