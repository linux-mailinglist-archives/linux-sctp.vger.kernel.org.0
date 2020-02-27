Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655F81722A8
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2020 16:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgB0P5J (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 27 Feb 2020 10:57:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36007 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgB0P5J (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 27 Feb 2020 10:57:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so2472404wrt.3
        for <linux-sctp@vger.kernel.org>; Thu, 27 Feb 2020 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOVyRvfZ76r+jqmFksmOuYDkjetu8x1ScEyoriaUWDE=;
        b=HilPewvYHQ2f75uPWATPmrDvC9c6JX4U7Kg/4t1+E3qzwYgqgKHW0wm6QsU9/+S+wD
         RGOqDnNcf6qnXmWa76ZHUD6GbPJz4knwguNqgMxT34QicQX4GXtEtPoZh/EhWXls4DYb
         8xag470HMDDhv+xot1EmR9Tx/1GSaJ4pgz7kgprWnx+4qnmAapY9hbbhgVDfbArwTEXb
         JmT3/NAPrLOBzCwhVOGm7WyNTMpSjgjBpfni0bJaOUhqV5L2xfrhuDMcgOrXGL3YOJ3z
         t6cAv85W6DErubuwR/WOJufkbMvJhp/zc6+eoXFD7cFnk6nurBeKqZpB6zYojgpwcRle
         +FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOVyRvfZ76r+jqmFksmOuYDkjetu8x1ScEyoriaUWDE=;
        b=XIgS/1bPDFqagPlgxkmcx57Z9i26TTKEzLi9lSOKy+9AfbIRnlZRcQyurB7fVkupbW
         RN915KFYWj+V4GwROMtrz4DKFxMgIEdub3YF389dVGoQ6r/JH5yVVyp7WoQplpA5Dexd
         qni6lazCrE0VTShTxGrjx8346HlVef/eCDmNA8NtM6vOzZq8jrWjtUAtEOEdZWtrz/Tf
         T5rnq6Ab3rJTc8HDwMI6ZxfEd7goGP7Y4I6Hwu2/A0fO0dmkU6xj6D2TmYF/wSol72+D
         29TCJV1RPaeh1xN7mJmWTczQxUASQLRNJeUzPQrRiU8fxDJDY4JSI/T2M/tmK4DfJXzN
         fp3A==
X-Gm-Message-State: APjAAAXYVywppFSzh3j37M049aVghlrkZZZLCNPzAGjaFIGntgdJGP4+
        HDNyYYgX9Yttm6NiBAJMDlqWTnZVBe7sEIlx8E2bx49u
X-Google-Smtp-Source: APXvYqwXR/JCp6/dawvybGWE8KJP6oYjhis+uEd0VudQmjS0ljPohkFimyJSaw7LIFxV+MuOrD85f9NeliLlPEJMB/Y=
X-Received: by 2002:adf:fac7:: with SMTP id a7mr5501279wrs.299.1582819027716;
 Thu, 27 Feb 2020 07:57:07 -0800 (PST)
MIME-Version: 1.0
References: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com> <HE1PR0702MB361028B4B8C2E4D03AA23B4EECEC0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0702MB361028B4B8C2E4D03AA23B4EECEC0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 27 Feb 2020 23:58:43 +0800
Message-ID: <CADvbK_f=COyrHh+17pdBq=acmR+cbv08quK6qbpHCg7FbwTsNw@mail.gmail.com>
Subject: Re: Problems with peeled-off sockets
To:     "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Feb 25, 2020 at 3:28 AM Leppanen, Jere (Nokia - FI/Espoo)
<jere.leppanen@nokia.com> wrote:
>
> On Sat, 22 Feb 2020, Xin Long wrote:
>
> > On Thu, Feb 20, 2020 at 5:18 PM Leppanen, Jere (Nokia - FI/Espoo)
> > <jere.leppanen@nokia.com> wrote:
> >>
> >> Hello All,
> >>
> >> According to the RFC, a peeled-off socket is a one-to-one socket. But
> >> in lksctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDTH
> >> style. Because of this, shutdown() doesn't work, linger probably
> >> doesn't work, and so on.
> >>
> >> For example, in sctp_shutdown():
> >>
> >> static void sctp_shutdown(struct sock *sk, int how)
> >> {
> >>         struct net *net = sock_net(sk);
> >>         struct sctp_endpoint *ep;
> >>
> >>         if (!sctp_style(sk, TCP))
> >>                 return;
> >>
> >> Here we just bail out, because a peeled-off socket is not TCP style.
> >>
> >> Is this just a bug, or am I missing something? Asking mostly out of
> >> personal curiosity.
> > I would say, it's because .shutdown is tcp_prot thing and udp_prot doesn't
> > have. sctp doesn't have to implement it for UDP style socket. But for TCP-
> > style socket, sctp is trying to be compatible with TCP protocol user API.
> > But even though,  sctp's .shutdown is still not fully compatible with TCP
> > protocol due to sctp's 3-way shakehands for finishing a connection.
>
> Thanks a bunch for replying, Xin Long. I'm not quite sure what you mean.
> The actual association shutdown doesn't even come into play here, since
> shutdown() doesn't do anything with peeled-off sockets.
Hi,  Leppanen,
sorry for late.

SCTP has two types of sockets: UDP and TCP styles.
TCP style associations are not allowed to be peeled off.
only UDP style associations can be peeled off.

Then shutdown can only work for TCP style, this explains
why peeled-off sk can use shutdown.


>
> If you mean that the current implementation of shutdown() might have
> some problems with peeled-off sockets; well, that's true, but I suppose
> that means that there's something to fix somewhere.
I think it returns for peeled-off sockets (UDP style sockets) on purpose.
it's like why you want to use shutdown on a UDP socket?

>
> It looks like the reason for the peculiar socket style of peeled-off
> sockets is that they're created by copying from a one-to-many socket and
> modified a little to resemble a one-to-one socket. But this leads to
> problems in several places in the code. Is this just implementation that
> was never finalized?
Right, peeled-off will allow users to use a new sk to control that asoc.
but again, it's a feature UDP style socket.
any other problems have you seen?
