Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C73E4563
	for <lists+linux-sctp@lfdr.de>; Fri, 25 Oct 2019 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfJYIN1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 25 Oct 2019 04:13:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46472 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389290AbfJYIN0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 25 Oct 2019 04:13:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so1180791wrw.13;
        Fri, 25 Oct 2019 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOL8PzVOXQeRGM4KyMz5/HoDH+aITkbqcslVg9v5Mx8=;
        b=bRMu9ZflK++UxszC/vX1x58X3j/JMEnb5F1dlLfrNe7dJ44pDy3yJbKkrwM1OG0655
         hVAF+BRm/ks4YhBnpAdkDE3iIzDYXFkNRUE6eIxZVJQwMt8h6wRpf96pGc3fPB9ittfQ
         wh8FSTZfH6B/OIbL9HA6q1fzL3P9C7T4JOMr679VZRHrYN4RRuxnW3hCBiLdQIely5JI
         83bLqtq+9CV6Gy2GsZvsHv83Xzz9vJBl26qY5PYt/UXIphbwqM/jFQ6nxRxiw23YJTDT
         QWGejxcaui+TEVz4W4IClA39Jt8K6raUxXVfla6tw1pi6qq0lyLCTZt6yK2LSfyPNDvW
         3w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOL8PzVOXQeRGM4KyMz5/HoDH+aITkbqcslVg9v5Mx8=;
        b=tNGhY6/IRPY9uPtOghAnX8oTtQ6fyH/EPWPCsjefLCWOlLR0wGy8CzOiDZH0tuIkC6
         9VUrcBOP4lGS+L8d5xLZZSmq9iCdEiPyJQxUL0uRYdr0mthoFPjOhX83NuMgAWYk5UOA
         9BZkrSu4ALAFXQbTV829qzwgf7oK4PAQJ2QLT3ZTranSIHD7m7C+ZcckyAW3F/455E2m
         4aCUeZkzMVaHrG8PM5i8ou6noWeVx2BIY3woW7c5dov7r18vyWHGvIgSj7WJ9eucQadx
         4j8ZpuONZt014UeeOBbfGlWUUULnQzYn8buFztox/jTsjBlt3HItvvaie89R89VF4Q4e
         GrbA==
X-Gm-Message-State: APjAAAXpirW7KPooDP0h4fnJ+Ljy6o+aQ2WmIGEXA+ZIcoCiLEnebxIS
        5VvpWiplbcMMbnzXHz4KxN6fiy+ExqQB1bhHNEk=
X-Google-Smtp-Source: APXvYqy+fUN+hWnb0IpLHQqeeoNBmYMA70Z5mKkkgaUnZpFSH4afe4b4Gt+jPA/hZCMvvkNiw5TU+20bkc0PbBsV/hw=
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr1651824wrn.303.1571991201981;
 Fri, 25 Oct 2019 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571033544.git.lucien.xin@gmail.com> <06d05b274999621fef3e7a006444ac76dadb7725.1571033544.git.lucien.xin@gmail.com>
 <20191025032536.GE4326@localhost.localdomain>
In-Reply-To: <20191025032536.GE4326@localhost.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 25 Oct 2019 16:13:12 +0800
Message-ID: <CADvbK_frbudLbteVm0Xra9dn66dF6-L04J8kNbX07GW2Mj3MuA@mail.gmail.com>
Subject: Re: [PATCHv3 net-next 4/5] sctp: add support for Primary Path Switchover
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        davem <davem@davemloft.net>,
        David Laight <david.laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Oct 25, 2019 at 11:25 AM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Mon, Oct 14, 2019 at 02:14:47PM +0800, Xin Long wrote:
> > This is a new feature defined in section 5 of rfc7829: "Primary Path
> > Switchover". By introducing a new tunable parameter:
> >
> >   Primary.Switchover.Max.Retrans (PSMR)
> >
> > The primary path will be changed to another active path when the path
> > error counter on the old primary path exceeds PSMR, so that "the SCTP
> > sender is allowed to continue data transmission on a new working path
> > even when the old primary destination address becomes active again".
> >
> > This patch is to add this tunable parameter, 'ps_retrans' per netns,
> > sock, asoc and transport. It also allows a user to change ps_retrans
> > per netns by sysctl, and ps_retrans per sock/asoc/transport will be
> > initialized with it.
> >
> > The check will be done in sctp_do_8_2_transport_strike() when this
> > feature is enabled.
> >
> > Note this feature is disabled by initializing 'ps_retrans' per netns
> > as 0xffff by default, and its value can't be less than 'pf_retrans'
> > when changing by sysctl.
> >
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  include/net/netns/sctp.h   |  6 ++++++
> >  include/net/sctp/structs.h | 11 ++++++++---
> >  net/sctp/associola.c       |  3 +++
> >  net/sctp/protocol.c        |  3 +++
> >  net/sctp/sm_sideeffect.c   |  5 +++++
> >  net/sctp/socket.c          |  1 +
> >  net/sctp/sysctl.c          |  9 +++++++++
> >  7 files changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/netns/sctp.h b/include/net/netns/sctp.h
> > index f97d342..c41ffdf 100644
> > --- a/include/net/netns/sctp.h
> > +++ b/include/net/netns/sctp.h
> > @@ -89,6 +89,12 @@ struct netns_sctp {
> >        */
> >       int pf_retrans;
> >
> > +     /* Primary.Switchover.Max.Retrans sysctl value
> > +      * taken from:
> > +      * https://tools.ietf.org/html/rfc7829
> > +      */
> > +     int ps_retrans;
> > +
> >       /*
> >        * Disable Potentially-Failed feature, the feature is enabled by default
> >        * pf_enable    -  0  : disable pf
> > diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
> > index 9a43738..3cc913f 100644
> > --- a/include/net/sctp/structs.h
> > +++ b/include/net/sctp/structs.h
> > @@ -184,7 +184,8 @@ struct sctp_sock {
> >       __u32 flowlabel;
> >       __u8  dscp;
> >
> > -     int pf_retrans;
> > +     __u16 pf_retrans;
> > +     __u16 ps_retrans;
> >
> >       /* The initial Path MTU to use for new associations. */
> >       __u32 pathmtu;
> > @@ -897,7 +898,9 @@ struct sctp_transport {
> >        * and will be initialized from the assocs value.  This can be changed
> >        * using the SCTP_PEER_ADDR_THLDS socket option
> >        */
> > -     int pf_retrans;
> > +     __u16 pf_retrans;
> > +     /* Used for primary path switchover. */
> > +     __u16 ps_retrans;
> >       /* PMTU       : The current known path MTU.  */
> >       __u32 pathmtu;
> >
> > @@ -1773,7 +1776,9 @@ struct sctp_association {
> >        * and will be initialized from the assocs value.  This can be
> >        * changed using the SCTP_PEER_ADDR_THLDS socket option
> >        */
> > -     int pf_retrans;
> > +     __u16 pf_retrans;
> > +     /* Used for primary path switchover. */
> > +     __u16 ps_retrans;
> >
> >       /* Maximum number of times the endpoint will retransmit INIT  */
> >       __u16 max_init_attempts;
> > diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> > index 46763c5..a839244 100644
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -86,6 +86,7 @@ static struct sctp_association *sctp_association_init(
> >        */
> >       asoc->max_retrans = sp->assocparams.sasoc_asocmaxrxt;
> >       asoc->pf_retrans  = sp->pf_retrans;
> > +     asoc->ps_retrans  = sp->ps_retrans;
> >       asoc->pf_expose   = sp->pf_expose;
> >
> >       asoc->rto_initial = msecs_to_jiffies(sp->rtoinfo.srto_initial);
> > @@ -628,6 +629,8 @@ struct sctp_transport *sctp_assoc_add_peer(struct sctp_association *asoc,
> >
> >       /* And the partial failure retrans threshold */
> >       peer->pf_retrans = asoc->pf_retrans;
> > +     /* And the primary path switchover retrans threshold */
> > +     peer->ps_retrans = asoc->ps_retrans;
> >
> >       /* Initialize the peer's SACK delay timeout based on the
> >        * association configured value.
> > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > index a18c7c4..ea1de9b 100644
> > --- a/net/sctp/protocol.c
> > +++ b/net/sctp/protocol.c
> > @@ -1217,6 +1217,9 @@ static int __net_init sctp_defaults_init(struct net *net)
> >       /* Max.Burst                - 4 */
> >       net->sctp.max_burst                     = SCTP_DEFAULT_MAX_BURST;
> >
> > +     /* Disable of Primary Path Switchover by default */
> > +     net->sctp.ps_retrans = 0xffff;
> > +
> >       /* Enable pf state by default */
> >       net->sctp.pf_enable = 1;
> >
> > diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> > index e52b212..acd737d 100644
> > --- a/net/sctp/sm_sideeffect.c
> > +++ b/net/sctp/sm_sideeffect.c
> > @@ -567,6 +567,11 @@ static void sctp_do_8_2_transport_strike(struct sctp_cmd_seq *commands,
> >                                            SCTP_FAILED_THRESHOLD);
> >       }
> >
> > +     if (transport->error_count > transport->ps_retrans &&
> > +         asoc->peer.primary_path == transport &&
> > +         asoc->peer.active_path != transport)
> > +             sctp_assoc_set_primary(asoc, asoc->peer.active_path);
> > +
> >       /* E2) For the destination address for which the timer
> >        * expires, set RTO <- RTO * 2 ("back off the timer").  The
> >        * maximum value discussed in rule C7 above (RTO.max) may be
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index eccd689..38d102b 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -5078,6 +5078,7 @@ static int sctp_init_sock(struct sock *sk)
> >       sp->hbinterval  = net->sctp.hb_interval;
> >       sp->pathmaxrxt  = net->sctp.max_retrans_path;
> >       sp->pf_retrans  = net->sctp.pf_retrans;
> > +     sp->ps_retrans  = net->sctp.ps_retrans;
> >       sp->pf_expose   = net->sctp.pf_expose;
> >       sp->pathmtu     = 0; /* allow default discovery */
> >       sp->sackdelay   = net->sctp.sack_timeout;
> > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > index 5d1ad44..adf264a 100644
> > --- a/net/sctp/sysctl.c
> > +++ b/net/sctp/sysctl.c
> > @@ -213,6 +213,15 @@ static struct ctl_table sctp_net_table[] = {
> >               .mode           = 0644,
> >               .proc_handler   = proc_dointvec_minmax,
> >               .extra1         = SYSCTL_ZERO,
> > +             .extra2         = &init_net.sctp.ps_retrans,
> > +     },
> > +     {
> > +             .procname       = "ps_retrans",
> > +             .data           = &init_net.sctp.ps_retrans,
> > +             .maxlen         = sizeof(int),
> > +             .mode           = 0644,
> > +             .proc_handler   = proc_dointvec_minmax,
> > +             .extra1         = &init_net.sctp.pf_retrans,
> >               .extra2         = SYSCTL_INT_MAX,
>
> pf_retrans got shrunk to 16 bits on other structs (why? I'm thinking
> it was just to keep the structs size in check). INT_MAX doesn't make
> sense anymore then and in fact it can lead to unexpected behavior.
> Like, setting 0x10000 becoming effectively 0.
> (yes, usage of >16bits values are probably unreasoable, but..)
I'll add "#define SCTP_PS_RETRANS_MAX 0xffff", which will be used
by both initializaion and sysctl extra2.

>
> >       },
> >       {
> > --
> > 2.1.0
> >
