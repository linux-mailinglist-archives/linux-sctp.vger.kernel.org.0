Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF2A707DEA
	for <lists+linux-sctp@lfdr.de>; Thu, 18 May 2023 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjERKT0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 18 May 2023 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjERKTW (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 18 May 2023 06:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCEC1BFC
        for <linux-sctp@vger.kernel.org>; Thu, 18 May 2023 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684405104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+CnYeWWG1BY3KnMSqKc6ssHtB4G9yjzydoXm28WiNI=;
        b=GUhm8yLd7vOz7xc4AmmuLZx12B/0DsS1FOdErSteB0yl4t5FO1vaNPN1v0xyQr2xHMiO65
        o8rGwq3wynDyMP8SkQwqNjnMClXi/i0iEKR/2osFYzcCoPZDiJoi8iyyT6Xv0Lbi/k0KjD
        EgS1YQUjxx4WdoAjRDwbgGiBAEFo0JM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-g5klivNEP0yebDExM94LVA-1; Thu, 18 May 2023 06:18:23 -0400
X-MC-Unique: g5klivNEP0yebDExM94LVA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b636b5f90so3599516d6.1
        for <linux-sctp@vger.kernel.org>; Thu, 18 May 2023 03:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684405102; x=1686997102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIx29nfXbRPfWiffUOHQhU7PT7ohBhqyNGs4DB0Evwg=;
        b=fYjHBpu/HdVMf1IHL17yl9oqFw/NNA86VyB/cat1LvLCyS+DEaA7aJ5EJi5aklWc5V
         dRDv3eTHw7c5lCiyju79PuXEPtMfnDOa5nnycglTrhrKfmxzYoGdw8wdYXG8ri74Ogh/
         ERO9K5Js8AN9+wVVu/lTkvVffkakHg+r4XBgEhaCZv1MMZxFMn+uIobGCpr8Erzyws55
         ig6+RBe2Deo7jLfKobmm47/eSeQiUVlLPlmLjNKhvK/R91bklcEtBTgHpioh+Mgcthyo
         zq84pfuZatU2AsKZURcl+R/O+OH00yXU6IH8+JpH+4Y2lU9p+GXfURl1TKKiTUUaVdyD
         mxeQ==
X-Gm-Message-State: AC+VfDyJKPybyR4J3E3g6S2V3+yCCB3Vu6hVKZmapowE1VuhuZad/jeV
        wTrOowdt1BPMdK0LXncvRwG5W8LT8ZKBHS6LxL+k0DKVC8lDiQeLHlLFU3cpEnyTYGchNLkrhMR
        zoT2kXhzY6uXw+n9t5pkPhw==
X-Received: by 2002:a05:6214:21a7:b0:616:73d9:b9d8 with SMTP id t7-20020a05621421a700b0061673d9b9d8mr10251793qvc.3.1684405102528;
        Thu, 18 May 2023 03:18:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nN6x3ou94K5gGUMcf7XH2IE+qjty02wfmiS8FnYgqYPo+FzQ6YWzX8smeCzbnint3EmFdIg==
X-Received: by 2002:a05:6214:21a7:b0:616:73d9:b9d8 with SMTP id t7-20020a05621421a700b0061673d9b9d8mr10251768qvc.3.1684405102221;
        Thu, 18 May 2023 03:18:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id ml7-20020a056214584700b0061a0f7fb340sm426736qvb.6.2023.05.18.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 03:18:21 -0700 (PDT)
Message-ID: <5a49aee53de52cf3c24246ccf18391aabc0c5e50.camel@redhat.com>
Subject: Re: [PATCH net] sctp: fix an issue that plpmtu can never go to
 complete state
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date:   Thu, 18 May 2023 12:18:18 +0200
In-Reply-To: <e72cc6c6ac5699659bb550fe04ec215ba393dd48.1684286522.git.lucien.xin@gmail.com>
References: <e72cc6c6ac5699659bb550fe04ec215ba393dd48.1684286522.git.lucien.xin@gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 2023-05-16 at 21:22 -0400, Xin Long wrote:
> When doing plpmtu probe, the probe size is growing every time when it
> receives the ACK during the Search state until the probe fails. When
> the failure occurs, pl.probe_high is set and it goes to the Complete
> state.
>=20
> However, if the link pmtu is huge, like 65535 in loopback_dev, the probe
> eventually keeps using SCTP_MAX_PLPMTU as the probe size and never fails.
> Because of that, pl.probe_high can not be set, and the plpmtu probe can
> never go to the Complete state.
>=20
> Fix it by setting pl.probe_high to SCTP_MAX_PLPMTU when the probe size
> grows to SCTP_MAX_PLPMTU in sctp_transport_pl_recv(). Also, increase
> the probe size only when the next is less than SCTP_MAX_PLPMTU.
>=20
> Fixes: b87641aff9e7 ("sctp: do state transition when a probe succeeds on =
HB ACK recv path")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/transport.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> index 2f66a2006517..b0ccfaa4c1d1 100644
> --- a/net/sctp/transport.c
> +++ b/net/sctp/transport.c
> @@ -324,9 +324,11 @@ bool sctp_transport_pl_recv(struct sctp_transport *t=
)
>  =09=09t->pl.probe_size +=3D SCTP_PL_BIG_STEP;
>  =09} else if (t->pl.state =3D=3D SCTP_PL_SEARCH) {
>  =09=09if (!t->pl.probe_high) {
> -=09=09=09t->pl.probe_size =3D min(t->pl.probe_size + SCTP_PL_BIG_STEP,
> -=09=09=09=09=09       SCTP_MAX_PLPMTU);
> -=09=09=09return false;
> +=09=09=09if (t->pl.probe_size + SCTP_PL_BIG_STEP < SCTP_MAX_PLPMTU) {
> +=09=09=09=09t->pl.probe_size +=3D SCTP_PL_BIG_STEP;
> +=09=09=09=09return false;
> +=09=09=09}
> +=09=09=09t->pl.probe_high =3D SCTP_MAX_PLPMTU;

It looks like this way the probed mtu can't reach SCTP_MAX_PLPMTU
anymore, while it was possible before.

What about something alike:

=09=09if (!t->pl.probe_high) {
=09=09=09if (t->pl.probe_size < SCTP_MAX_PLPMTU) {
=09=09=09=09t->pl.probe_size =3D min(t->pl.probe_size + SCTP_PL_BIG_STEP,
=09=09=09=09=09=09       SCTP_MAX_PLPMTU);
=09=09=09=09return false;
=09=09=09}
=09=09=09t->pl.probe_high =3D SCTP_MAX_PLPMTU;
>  =09=09}
>  =09=09t->pl.probe_size +=3D SCTP_PL_MIN_STEP;
>  =09=09if (t->pl.probe_size >=3D t->pl.probe_high) {
> @@ -341,7 +343,8 @@ bool sctp_transport_pl_recv(struct sctp_transport *t)
>  =09} else if (t->pl.state =3D=3D SCTP_PL_COMPLETE) {
>  =09=09/* Raise probe_size again after 30 * interval in Search Complete *=
/
>  =09=09t->pl.state =3D SCTP_PL_SEARCH; /* Search Complete -> Search */
> -=09=09t->pl.probe_size +=3D SCTP_PL_MIN_STEP;
> +=09=09if (t->pl.probe_size + SCTP_PL_MIN_STEP < SCTP_MAX_PLPMTU)
> +=09=09=09t->pl.probe_size +=3D SCTP_PL_MIN_STEP;

In a similar way, should the above check be:

=09=09if (t->pl.probe_size + SCTP_PL_MIN_STEP <=3D SCTP_MAX_PLPMTU)
=09=09=09t->pl.probe_size +=3D SCTP_PL_MIN_STEP;

or simply:
=09=09t->pl.probe_size =3D min(t->pl.probe_size + SCTP_PL_MIN_STEP, SCTP_MA=
X_PLPMTU)
>=20
Cheers,

Paolo

