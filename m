Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDB6FE0BA
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjEJOri (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjEJOri (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 10:47:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A91711
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 07:47:35 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E5643F4A5
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683730054;
        bh=JjIUi7jBNspmRga1n5cvGl2/nqkm6+K5dZzGhpmb1Bo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rn1hoDknTtm4pd/7y7lo6ZLsllSBkEcd8GZdXuPTRuUOQfLXtk0EBXoU2BBgxyeM9
         YdNvIdDXyKwtnpD1Ay7FruaokDVT5LRZ9gVXKGr0zG3pZMZ1LORBbDgD0jl6eMkZ8/
         HQf7XcikrDz53Uf2IlR6rSBQ2hUjBQ95lzIU52of8wQCNbF4yk80zaR68ylWjplDym
         4krBKHAp+fnCUKqWZQT3W0VdnRdKEHlACcUiloKA8rBb2gEOCFKljscgtrF/LKxgZT
         FfhFwUa347O62Xipt/AlyL1ILuW08b21pwLQO85SFBsGeOmxV1So1/jFVvwyKWGENh
         vtg7VZDQSrihQ==
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-b9e2b65f2eeso13260175276.2
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 07:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730053; x=1686322053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjIUi7jBNspmRga1n5cvGl2/nqkm6+K5dZzGhpmb1Bo=;
        b=C0i6PlSnGAPMXg4s0Ch5A3HhTyy0pTKGTkC2m0l94o/V8nErTrfpX6EkK06TJgWszZ
         7dB2wzFcaGzYIeTVqHiQV4FQJsGMmTEZ1obnu+Fp3iS4k0W6kNa4i0zH8DMAOfqq/OZg
         wLPFp3zEv9zb+oZnCjg7qVI3uyJp2dH8dGtEOHSYerdXMXMe5OoJkS+H9LeBGh78CAHe
         DifbURD8lEEPDwaSpd000BSZAssN3ArjYKv1BEr+RVwDfX1wzQcw6JioTmZOkgE35X3s
         qG/196uU/sgsXa2uLSQPkHZCVtmIRW+nrb8A3zEH1dxwPozKmqnt3C+g7q3d2fJHKS8o
         OGxw==
X-Gm-Message-State: AC+VfDxvt3l1ILxYY2zlQAFYxl6+wBvrPHiIfOPofurVaoTLYmFEjd8R
        R7Eaga1mUywSgKecDYFr4vkNcOGs6pmemgoCRKnCGrYwsDk7m4bNLNpHTa7Hd5cwSbGGfVgig6i
        C5p0Ec5WPImjhbj1VvxyRrHFu/PIYX7k4gcrGj/drosDXkR476AshK973rT0zXxct4A==
X-Received: by 2002:a25:50c1:0:b0:ba1:b7e4:e0dd with SMTP id e184-20020a2550c1000000b00ba1b7e4e0ddmr18740729ybb.56.1683730053278;
        Wed, 10 May 2023 07:47:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BvjS8N0bb9sG5W4XddT53p706jOzztHM9E/9C8JuNAkUBBSRRA3HmYJNVEaL9ADLicLIha3aVU6xa+N0EDKQ=
X-Received: by 2002:a25:50c1:0:b0:ba1:b7e4:e0dd with SMTP id
 e184-20020a2550c1000000b00ba1b7e4e0ddmr18740710ybb.56.1683730053000; Wed, 10
 May 2023 07:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230510131527.1244929-1-aleksandr.mikhalitsyn@canonical.com> <CAKH8qBuzWHoEiABvTgM2qnx5Av127VMHnncGtU5EZq+ffT9eGg@mail.gmail.com>
In-Reply-To: <CAKH8qBuzWHoEiABvTgM2qnx5Av127VMHnncGtU5EZq+ffT9eGg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 10 May 2023 16:47:21 +0200
Message-ID: <CAEivzxd5a8qykjbi03dyPD4hfBMsbKNTr=b0MEd2gamjC-stZA@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: add bpf_bypass_getsockopt proto callback
To:     Stanislav Fomichev <sdf@google.com>
Cc:     nhorman@tuxdriver.com, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 10, 2023 at 4:32=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Wed, May 10, 2023 at 6:15=E2=80=AFAM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Add bpf_bypass_getsockopt proto callback and filter out
> > SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
> > from running eBPF hook on them.
> >
> > These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
> > hook returns an error after success of the original handler
> > sctp_getsockopt(...), userspace will receive an error from getsockopt
> > syscall and will be not aware that fd was successfully installed into f=
dtable.
> >
> > This patch was born as a result of discussion around a new SCM_PIDFD in=
terface:
> > https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalits=
yn@canonical.com/
> >
> > Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Neil Horman <nhorman@tuxdriver.com>
> > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Cc: Xin Long <lucien.xin@gmail.com>
> > Cc: linux-sctp@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> with a small nit below

Hi Stanislav!

Thanks for your review.

I've also added a Suggested-by tag with your name in -v2, because
you've given me this idea to use bpf_bypass_getsockopt.
Hope that you are comfortable with it.

>
> > ---
> >  net/sctp/socket.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index cda8c2874691..a9a0ababea90 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -8281,6 +8281,29 @@ static int sctp_getsockopt(struct sock *sk, int =
level, int optname,
> >         return retval;
> >  }
> >
>
> [...]
>
> > +bool sctp_bpf_bypass_getsockopt(int level, int optname)
>
> static bool ... ? You're not making it indirect-callable, so seems
> fine to keep private to this compilation unit?

Sure, my bad. Fixed in v2.

Kind regards,
Alex

>
> > +{
> > +       /*
> > +        * These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GE=
TSOCKOPT
> > +        * hook returns an error after success of the original handler
> > +        * sctp_getsockopt(...), userspace will receive an error from g=
etsockopt
> > +        * syscall and will be not aware that fd was successfully insta=
lled into fdtable.
> > +        *
> > +        * Let's prevent bpf cgroup hook from running on them.
> > +        */
> > +       if (level =3D=3D SOL_SCTP) {
> > +               switch (optname) {
> > +               case SCTP_SOCKOPT_PEELOFF:
> > +               case SCTP_SOCKOPT_PEELOFF_FLAGS:
> > +                       return true;
> > +               default:
> > +                       return false;
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static int sctp_hash(struct sock *sk)
> >  {
> >         /* STUB */
> > @@ -9650,6 +9673,7 @@ struct proto sctp_prot =3D {
> >         .shutdown    =3D  sctp_shutdown,
> >         .setsockopt  =3D  sctp_setsockopt,
> >         .getsockopt  =3D  sctp_getsockopt,
> > +       .bpf_bypass_getsockopt  =3D sctp_bpf_bypass_getsockopt,
> >         .sendmsg     =3D  sctp_sendmsg,
> >         .recvmsg     =3D  sctp_recvmsg,
> >         .bind        =3D  sctp_bind,
> > @@ -9705,6 +9729,7 @@ struct proto sctpv6_prot =3D {
> >         .shutdown       =3D sctp_shutdown,
> >         .setsockopt     =3D sctp_setsockopt,
> >         .getsockopt     =3D sctp_getsockopt,
> > +       .bpf_bypass_getsockopt  =3D sctp_bpf_bypass_getsockopt,
> >         .sendmsg        =3D sctp_sendmsg,
> >         .recvmsg        =3D sctp_recvmsg,
> >         .bind           =3D sctp_bind,
> > --
> > 2.34.1
> >
