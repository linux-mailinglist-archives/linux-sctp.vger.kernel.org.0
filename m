Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6DC8FDC
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Oct 2019 19:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJBR0S (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Oct 2019 13:26:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfJBR0S (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Oct 2019 13:26:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so8097343wmg.0;
        Wed, 02 Oct 2019 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poeJhjv1LRQ4+28mdL5BQ7IqVdigLcgeKsPM6KugG0M=;
        b=J+jzmaJfHJfmjoha6d1YP8o4I4nEEAZSPjyq7xyWfXvN3oAI0Bu3JnUWcii7VP+1Cz
         j28DOWlcix6zzOxDNrXnHMXySYlRaem3BlXEiarlQzXHubrnIb+wi8vOAa5vprpZ6Nz+
         sW+bCj08hQwe4kgS7kh0Kxe6RN5kCQ0QoTSlssc0NkD6NVrgDbIrouLAGNBR4yWU/H/h
         hGEtCA9cp6yx5iFCgaT6N2OuOJ9WllvtitNC0wliRt8UNiO+b8rxWhXZnzHbQlfaz46i
         ksrMrI7Ne9+9IyuFaDnb6g8UWWvRYFTduPM1effzHFfBQQ/SIkk6wJ93Mq3pT0BpzfKg
         dI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poeJhjv1LRQ4+28mdL5BQ7IqVdigLcgeKsPM6KugG0M=;
        b=A7tBb7d8rBViRHFB6FNwsKxMqP9iOBCwlYWpDhYuNJe9WMDTD6cI/Lm43TIXBWJWr/
         7njBJ6AaFnD2LOj+LQTSV8VxERu/ORT7Sy2Qa9P+8X7LGzzy1mdCRhEF9YOPk2OLkl+N
         3camM7vhwHdZ42xnPRp80IzDACyA2sKs1uPHjJpCqg94GrOXZuT5KjbJ00sSc55FvPXk
         aaskVR1zsvw2WIHlgVvRWwGqGymWRM+cLgN7o+/2vE5+n9d+WRD/3KUo7a4dpSILUc/U
         2BSMjL7iEydvUSCQ2UO9+Qo+ILqbnDRX5dIt2E+GVBoqTLt9xoWeB8UbsRF0G2ISdJwW
         WIuw==
X-Gm-Message-State: APjAAAVRDglxtILknrID931mlGfjJI8ZNWcWFoMsN9j+6hoo2A7VVMaN
        yc7vo34JesaukI3SQsWy0yOM+6PL2/9kY+eeh+h6G3rV
X-Google-Smtp-Source: APXvYqyg0g7m9O35EJyCl0MjhIEgUTHhx5H/5WRplrPKMlQZ+DqZxY2EnQy3jnzSuGn/abAsSoS8/owmisTpy8a1iXs=
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr3834111wmc.140.1570037175533;
 Wed, 02 Oct 2019 10:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <acd60f4797143dc6e9817b3dce38e1408caf65e5.1569849018.git.lucien.xin@gmail.com>
 <20191002010356.GG3499@localhost.localdomain> <CADvbK_ctLG+vnhmWwN=cWmZV7FgZreVRmoU+23PExdk=goF8cQ@mail.gmail.com>
 <20191002125511.GH3499@localhost.localdomain>
In-Reply-To: <20191002125511.GH3499@localhost.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 3 Oct 2019 01:26:46 +0800
Message-ID: <CADvbK_fD+yuCCUTf41n+3oVwVjLUdT8+-wfwppVL8ZmbJegTWA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: set newsk sk_socket before processing listening
 sk backlog
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem <davem@davemloft.net>, Neil Horman <nhorman@tuxdriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Oct 2, 2019 at 8:55 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Wed, Oct 02, 2019 at 04:23:52PM +0800, Xin Long wrote:
> > On Wed, Oct 2, 2019 at 9:04 AM Marcelo Ricardo Leitner
> > <marcelo.leitner@gmail.com> wrote:
> > >
> > > On Mon, Sep 30, 2019 at 09:10:18PM +0800, Xin Long wrote:
> > > > This patch is to fix a NULL-ptr deref crash in selinux_sctp_bind_connect:
> > > >
> > > >   [...] kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > >   [...] RIP: 0010:selinux_sctp_bind_connect+0x16a/0x230
> > > >   [...] Call Trace:
> > > >   [...]  security_sctp_bind_connect+0x58/0x90
> > > >   [...]  sctp_process_asconf+0xa52/0xfd0 [sctp]
> > > >   [...]  sctp_sf_do_asconf+0x782/0x980 [sctp]
> > > >   [...]  sctp_do_sm+0x139/0x520 [sctp]
> > > >   [...]  sctp_assoc_bh_rcv+0x284/0x5c0 [sctp]
> > > >   [...]  sctp_backlog_rcv+0x45f/0x880 [sctp]
> > > >   [...]  __release_sock+0x120/0x370
> > > >   [...]  release_sock+0x4f/0x180
> > > >   [...]  sctp_accept+0x3f9/0x5a0 [sctp]
> > > >   [...]  inet_accept+0xe7/0x6f0
> > > >
> > > > It was caused by that the 'newsk' sk_socket was not set before going to
> > > > security sctp hook when doing accept() on a tcp-type socket:
> > > >
> > > >   inet_accept()->
> > > >     sctp_accept():
> > > >       lock_sock():
> > > >           lock listening 'sk'
> > > >                                           do_softirq():
> > > >                                             sctp_rcv():  <-- [1]
> > > >                                                 asconf chunk arrived and
> > > >                                                 enqueued in 'sk' backlog
> > > >       sctp_sock_migrate():
> > > >           set asoc's sk to 'newsk'
> > > >       release_sock():
> > > >           sctp_backlog_rcv():
> > > >             lock 'newsk'
> > > >             sctp_process_asconf()  <-- [2]
> > > >             unlock 'newsk'
> > > >     sock_graft():
> > > >         set sk_socket  <-- [3]
> > > >
> > > > As it shows, at [1] the asconf chunk would be put into the listening 'sk'
> > > > backlog, as accept() was holding its sock lock. Then at [2] asconf would
> > > > get processed with 'newsk' as asoc's sk had been set to 'newsk'. However,
> > > > 'newsk' sk_socket is not set until [3], while selinux_sctp_bind_connect()
> > > > would deref it, then kernel crashed.
> > >
> > > Note that sctp will migrate such incoming chunks from sk to newsk in
> > > sctp_rcv() if they arrived after the mass-migration performed at
> > > sctp_sock_migrate().
> > >
> > > That said, did you explore changing inet_accept() so that
> > > sk1->sk_prot->accept() would return sk2 still/already locked?
> > > That would be enough to block [2] from happening as then it would be
> > > queued on newsk backlog this time and avoid nearly duplicating
> > > inet_accept(). (too bad for this chunk, hit 2 backlogs..)
> > We don't have to bother inet_accept() for it. I had this one below,
> > and I was just thinking the locks order doesn't look nice. Do you
> > think this is more acceptable?
> >
> > @@ -4963,15 +4963,19 @@ static struct sock *sctp_accept(struct sock
> > *sk, int flags, int *err, bool kern)
> >          * asoc to the newsk.
> >          */
> >         error = sctp_sock_migrate(sk, newsk, asoc, SCTP_SOCKET_TCP);
> > -       if (error) {
> > -               sk_common_release(newsk);
> > -               newsk = NULL;
> > +       if (!error) {
> > +               lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
> > +               release_sock(sk);
>
> Interesting. It fixes the backlog processing, ok. Question:
>
> > +               release_sock(newsk);
>
> As newsk is hashed already and unlocked here to be locked again later
> on inet_accept(), it could receive a packet in between (thus before
> sock_graft() could have a chance to run), no?

You're right, it explains another call trace happened once in our testing.

The way to changing inet_accept() will also have to change all protocols'
.accept(). Given that this issue is only triggered in a very small moment,
can we just silently discard this asconf chunk if sk->sk_socket is NULL?
and let peer's T4-timer retransmit it.

@@ -3709,6 +3709,9 @@ enum sctp_disposition sctp_sf_do_asconf(struct net *net,
        struct sctp_addiphdr *hdr;
        __u32 serial;

+       if (asoc->base.sk->sk_socket)
+               return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+

Note we can't do this in sctp_process_asconf_param(), as an asconf_ack
will be sent back.

>
> > +               *err = error;
> > +
> > +               return newsk;
> >         }
> >
> >  out:
> >         release_sock(sk);
> >         *err = error;
> > -       return newsk;
> > +       return NULL;
> >  }
> >
> > >
> > > AFAICT TCP code would be fine with such change. Didn't check other
> > > protocols.
> > >
> >
