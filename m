Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25AD77CDBE
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Aug 2023 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjHOOCm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Aug 2023 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbjHOOCR (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Aug 2023 10:02:17 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160B1BE1;
        Tue, 15 Aug 2023 07:01:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d682d2d1f0dso3575352276.1;
        Tue, 15 Aug 2023 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108114; x=1692712914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RK8C+4M3WjyGo3AT2VvtieqZ4XHthCpGP/MjkwxxLRM=;
        b=mlMQgWr/Dp5MwkbdLFShCAqd3TyV3HbRGsShw0D3S/3ERGy7RjA7AH3jHV62T7f28T
         mR+hlmouQI1yK1i7lZ/Ge8Sy7/3rSgYwAPupxe2iUr3P6CzLbkSd3ACunxowfrLLgHMs
         pLkUX8ulWVWBxcud/7iKf1whrcYfUffNrQcyqZ0a7ojf4o5Lwwg1HjP8yC6n3IGX9nRQ
         TXvbZd8IEGW0MhQycFTGO6NevlMOg1c5t0+d3d+LhFSTssPtvd/bLkQN9s/b66O1VkSQ
         EO9yvDOih9dHLWx8696BMUPsmUlbGxjkyTYCSqUTVCJLLdnufCd0DLSjiNSKgIsM8WZ3
         +jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108114; x=1692712914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK8C+4M3WjyGo3AT2VvtieqZ4XHthCpGP/MjkwxxLRM=;
        b=WWfMSQK0R+MDK68nZjxYrXUQvUaeJjUFBmpDfy2mI2rPlS5YOsiNgF4I8EXiWo2eoc
         P9KlTAflOTe7kpVwaNsXgCSmZhJJRB+uzYMyrsJ/0EYFQFbQU25w9K/SjJ7q4BaXqCBn
         WLHoK8omtSJJHbItzzPgCexdb1WX5tj4oWtKvmvvmLhqfAPmXLFPmDz1X+XoaXM6w33c
         4CEG/U+DuFX4ERamLRtRtZ7ywW7xhSDc4AgAGRSkuWfckagfisKWO7bYjukUvYhyBrxK
         8lj/t2qtzulIsdfJzWyq9Mi2U0kbKuKQ8X4ZjtorFZ8DjZ5+qREtdRwQTMCuk6+yOeeO
         Da/w==
X-Gm-Message-State: AOJu0YzYxLAkdbEOBaWj86pyfHk9vp/5h+ADySzLAeg3l/G/CH0Wnups
        LIWogGKbdBnzK2LJGH5LET/l9akQUuddNu/Wxw0=
X-Google-Smtp-Source: AGHT+IF8TUQMt1B1y90B2T47wqGqmk9jdn588FwleKe360sIPlp6Bx49haNYj+JFI0aZzeHKxURac8+OGaSiNGbqK8I=
X-Received: by 2002:a25:dad7:0:b0:ced:6134:7606 with SMTP id
 n206-20020a25dad7000000b00ced61347606mr15277728ybf.30.1692108113957; Tue, 15
 Aug 2023 07:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
 <DBBP189MB1433FD875F0B6859676196489514A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DBBP189MB1433FD875F0B6859676196489514A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 15 Aug 2023 10:01:41 -0400
Message-ID: <CADvbK_eHOU1RCRxNFYTZ9GOwkeTFmSxtzmnGqUhOh-gh82Z8nQ@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: set default timeout to 3 secs for sctp
 shutdown send and recv state
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc:     network dev <netdev@vger.kernel.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Aug 15, 2023 at 3:59=E2=80=AFAM Sriram Yagnaraman
<sriram.yagnaraman@est.tech> wrote:
>
>
>
> > -----Original Message-----
> > From: Xin Long <lucien.xin@gmail.com>
> > Sent: Sunday, 13 August 2023 18:56
> > To: network dev <netdev@vger.kernel.org>; netfilter-devel@vger.kernel.o=
rg;
> > linux-sctp@vger.kernel.org
> > Cc: davem@davemloft.net; kuba@kernel.org; Eric Dumazet
> > <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Pablo Neira
> > Ayuso <pablo@netfilter.org>; Jozsef Kadlecsik <kadlec@netfilter.org>; F=
lorian
> > Westphal <fw@strlen.de>; Marcelo Ricardo Leitner
> > <marcelo.leitner@gmail.com>
> > Subject: [PATCH nf] netfilter: set default timeout to 3 secs for sctp s=
hutdown
> > send and recv state
> >
> > In SCTP protocol, it is using the same timer (T2 timer) for SHUTDOWN an=
d
> > SHUTDOWN_ACK retransmission. However in sctp conntrack the default
> > timeout value for SCTP_CONNTRACK_SHUTDOWN_ACK_SENT state is 3 secs
> > while it's 300 msecs for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV state.
> >
> > As Paolo Valerio noticed, this might cause unwanted expiration of the c=
t entry.
> > In my test, with 1s tc netem delay set on the NAT path, after the SHUTD=
OWN is
> > sent, the sctp ct entry enters SCTP_CONNTRACK_SHUTDOWN_SEND state.
> > However, due to 300ms (too short) delay, when the SHUTDOWN_ACK is sent
> > back from the peer, the sctp ct entry has expired and been deleted, and=
 then
> > the SHUTDOWN_ACK has to be dropped.
> >
> > Also, it is confusing these two sysctl options always show 0 due to all=
 timeout
> > values using sec as unit:
> >
> >   net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd =3D 0
> >   net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent =3D 0
> >
> > This patch fixes it by also using 3 secs for sctp shutdown send and rec=
v state in
> > sctp conntrack, which is also RTO.initial value in SCTP protocol.
> >
> > Note that the very short time value for
> > SCTP_CONNTRACK_SHUTDOWN_SEND/RECV was probably used for a rare
> > scenario where SHUTDOWN is sent on 1st path but SHUTDOWN_ACK is replied
> > on 2nd path, then a new connection started immediately on 1st path. So =
this
> > patch also moves from SHUTDOWN_SEND/RECV to CLOSE when receiving INIT
> > in the ORIGINAL direction.
> >
> > Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
> > Reported-by: Paolo Valerio <pvalerio@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/netfilter/nf_conntrack_proto_sctp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/netfilter/nf_conntrack_proto_sctp.c
> > b/net/netfilter/nf_conntrack_proto_sctp.c
> > index 91eacc9b0b98..b6bcc8f2f46b 100644
> > --- a/net/netfilter/nf_conntrack_proto_sctp.c
> > +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> > @@ -49,8 +49,8 @@ static const unsigned int
> > sctp_timeouts[SCTP_CONNTRACK_MAX] =3D {
> >       [SCTP_CONNTRACK_COOKIE_WAIT]            =3D 3 SECS,
> >       [SCTP_CONNTRACK_COOKIE_ECHOED]          =3D 3 SECS,
> >       [SCTP_CONNTRACK_ESTABLISHED]            =3D 210 SECS,
> > -     [SCTP_CONNTRACK_SHUTDOWN_SENT]          =3D 300 SECS /
> > 1000,
> > -     [SCTP_CONNTRACK_SHUTDOWN_RECD]          =3D 300 SECS /
> > 1000,
> > +     [SCTP_CONNTRACK_SHUTDOWN_SENT]          =3D 3 SECS,
> > +     [SCTP_CONNTRACK_SHUTDOWN_RECD]          =3D 3 SECS,
> >       [SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]      =3D 3 SECS,
> >       [SCTP_CONNTRACK_HEARTBEAT_SENT]         =3D 30 SECS,
> >  };
> > @@ -105,7 +105,7 @@ static const u8
> > sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] =3D {
> >       {
> >  /*   ORIGINAL        */
> >  /*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS */
> > -/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW},
> > +/* init         */ {sCL, sCL, sCW, sCE, sES, sCL, sCL, sSA, sCW},
> >  /* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},
> >  /* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
> >  /* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL},
> > --
> > 2.39.1
>
> FWIW, I like this patch. Should Documentation/networking/nf_conntrack-sys=
ctl.rst be updated to reflect the new timeout values?
Good catch, will post v2 with the 0.3 -> 3 change in nf_conntrack-sysctl.rs=
t.

Thanks for the review.
