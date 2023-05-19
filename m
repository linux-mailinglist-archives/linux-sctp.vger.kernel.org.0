Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08990709D81
	for <lists+linux-sctp@lfdr.de>; Fri, 19 May 2023 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjESRGR (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 13:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjESRFs (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 13:05:48 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35F0E75;
        Fri, 19 May 2023 10:05:33 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4570b867188so268560e0c.2;
        Fri, 19 May 2023 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684515927; x=1687107927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1n4O+vlOu4SbLTPevxm0onbYElb9o3Bb/csYwfWCaI=;
        b=Z9YMzHq8VhtpM2O9otsqrd0tZdg2BAl3LqABN5m5syzJVM1lg1GV0kQ7t49DciamlA
         Paldm4xslsFsO3Zz96SA/Yiqo1iWl6LCX4EHgAyNXBVnAZNfDAlwBwi9ebTwEDz8M2yS
         Ya1ssFsQrhnlFIhxoX1ZUDdPuX7/cda8chyiqxsTt9LFOXfv9CImgSTC3FilQvyO49Kj
         l8asp5wZmZ0j6GArjCOnkAPlfrEDhpybs4QPbUIQIXlvjWTOxe6HFdDYh0W8Iq8yiFut
         KRQ6gCQj8Cl9xwULPOQ+y9EgU/SxrG/FVEwDp4hyZiWSfyui/7mmkwJMJje+mrlQucUy
         E6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515927; x=1687107927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1n4O+vlOu4SbLTPevxm0onbYElb9o3Bb/csYwfWCaI=;
        b=RMZH4XlGd5IrxdIssj8DptCVn44kYgRI/exFpKi+WD/SRo9FX46G4LroHnzm9KXJGL
         BA/UvOj2fYyO21rS13rnHMfOV9M3sI+4h3MJJSSOZwvq339n0lVurl92+1dMriRkfx5Q
         vtfPZ0iPnlAzLowOHlQaYwRVYK0jP+4dCTA4aas1q0WVBmSZV5HM4MWxpOA7FzQqEpPd
         Q2Od77t1rDesbxd6gSkT4zjh2KRU6NpgULvyYbkJupXoQRhnAorl06cD/BipR6G4dX8H
         JZSgJlsRiJj6VJLbmrI0OlQU//uhStSghuoZYSgLlBpALlLQIOjLTtCUjDXiQusgVjDx
         GeKw==
X-Gm-Message-State: AC+VfDzMEvwVzAutYR+3MRzHiwf+VuI7m57m+H4di0Lm+ySQEb3Zr/dM
        pyT14SxS2+zwapVTGtocZurHtoBL0YRRNxa2YAdu6Ifn
X-Google-Smtp-Source: ACHHUZ7he1ysiV2/BJa/IxnYP0TMe2H/1MAu1dfEC0JqOVlqIWcniS7jsLoWxFw3ZocAuNoRMWTl5P2siqcOF/nFXbw=
X-Received: by 2002:a1f:e7c1:0:b0:440:65a5:332a with SMTP id
 e184-20020a1fe7c1000000b0044065a5332amr1268332vkh.5.1684515926745; Fri, 19
 May 2023 10:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230519135821.922326-1-leitao@debian.org> <20230519135821.922326-2-leitao@debian.org>
 <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com> <ZGeYF+pp8Ukbo4p5@gmail.com>
In-Reply-To: <ZGeYF+pp8Ukbo4p5@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 19 May 2023 13:04:50 -0400
Message-ID: <CAF=yD-L0MnbofufMB_SKu+8PZ+f_QdAGYoDe-jOavdkAjFrXXg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl callbacks
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, courmisch@gmail.com,
        nhorman@tuxdriver.com, asml.silence@gmail.com,
        alex.aring@gmail.com, dccp@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
        marcelo.leitner@gmail.com, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, leit@fb.com, David.Laight@aculab.com,
        dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, May 19, 2023 at 11:39=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> On Fri, May 19, 2023 at 11:09:29AM -0400, Willem de Bruijn wrote:
> > On Fri, May 19, 2023 at 9:59=E2=80=AFAM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > Most of the ioctls to net protocols operates directly on userspace
> > > argument (arg). Usually doing get_user()/put_user() directly in the
> > > ioctl callback.  This is not flexible, because it is hard to reuse th=
ese
> > > functions without passing userspace buffers.
> > >
> > > Change the "struct proto" ioctls to avoid touching userspace memory a=
nd
> > > operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> > > adapted to operate on a kernel memory other than on userspace (so, no
> > > more {put,get}_user() and friends being called in the ioctl callback)=
.
> > >
> > > This changes the "struct proto" ioctl format in the following way:
> > >
> > >     int                     (*ioctl)(struct sock *sk, int cmd,
> > > -                                        unsigned long arg);
> > > +                                        int *karg);
> > >
> > > So, the "karg" argument, which is passed to the ioctl callback, is a
> > > pointer allocated to kernel space memory (inside a function wrapper -
> > > sock_skprot_ioctl()). This buffer (karg) may contain input argument
> > > (copied from userspace in a prep function) and it might return a
> > > value/buffer, which is copied back to userspace if necessary. There i=
s
> > > not one-size-fits-all format (that is I am using 'may' above), but
> > > basically, there are three type of ioctls:
> > >
> > > 1) Do not read from userspace, returns a result to userspace
> > > 2) Read an input parameter from userspace, and does not return anythi=
ng
> > >   to userspace
> > > 3) Read an input from userspace, and return a buffer to userspace.
> > >
> > > The default case (1) (where no input parameter is given, and an "int"=
 is
> > > returned to userspace) encompasses more than 90% of the cases, but th=
ere
> > > are two other exceptions. Here is a list of exceptions:
> > >
> > > * Protocol RAW:
> > >    * cmd =3D SIOCGETVIFCNT:
> > >      * input and output =3D struct sioc_vif_req
> > >    * cmd =3D SIOCGETSGCNT
> > >      * input and output =3D struct sioc_sg_req
> > >    * Explanation: for the SIOCGETVIFCNT case, userspace passes the in=
put
> > >      argument, which is struct sioc_vif_req. Then the callback popula=
tes
> > >      the struct, which is copied back to userspace.
> > >
> > > * Protocol RAW6:
> > >    * cmd =3D SIOCGETMIFCNT_IN6
> > >      * input and output =3D struct sioc_mif_req6
> > >    * cmd =3D SIOCGETSGCNT_IN6
> > >      * input and output =3D struct sioc_sg_req6
> > >
> > > * Protocol PHONET:
> > >   * cmd =3D=3D SIOCPNADDRESOURCE | SIOCPNDELRESOURCE
> > >      * input int (4 bytes)
> > >   * Nothing is copied back to userspace.
> > >
> > > For the exception cases, functions sock_skproto_ioctl_in{out}() will
> > > copy the userspace input, and copy it back to kernel space.
> > >
> > > The wrapper that prepares the buffer and puts the buffer back to user=
 is
> > > sock_skprot_ioctl(), so, instead of calling sk->sk_prot->ioctl(), the
> > > callee now calls sock_skprot_ioctl().
> > >
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> >
> > Overall this looks great to me.
>
> Thanks for the guidance and quick review!
>
> >
> > Thanks for the detailed commit message that lists all exceptions, Bruno=
.
> >
> > Since that is a limited well understood list, I'm not in favor of the
> > suggestion to add an explicit length argument that then needs to be
> > checked in each callee.
> >
> > > +/* Copy 'size' bytes from userspace and return `size` back to usersp=
ace */
> > > +int sock_skproto_ioctl_inout(struct sock *sk, unsigned int cmd,
> > > +                            void __user *arg, size_t size)
> > > +{
> > > +       void *ptr;
> > > +       int ret;
> > > +
> > > +       ptr =3D kmalloc(size, GFP_KERNEL);
> > > +       if (!ptr)
> > > +               return -ENOMEM;
> >
> > > +/* A wrapper around sock ioctls, which copies the data from userspac=
e
> > > + * (depending on the protocol/ioctl), and copies back the result to =
userspace.
> > > + * The main motivation for this function is to pass kernel memory to=
 the
> > > + * protocol ioctl callsback, instead of userspace memory.
> > > + */
> > > +int sock_skprot_ioctl(struct sock *sk, unsigned int cmd,
> > > +                     void __user *arg)
> > > +{
> > > +#ifdef CONFIG_IP_MROUTE
> > > +       if (!strcmp(sk->sk_prot->name, "RAW")) {
> >
> > This must check both sk_family and sk_protocol. That is preferable
> > over string match.
> >
> > For these exception cases, instead of having sock_skproto_ioctl_inout
> > dynamically allocate the struct, how about stack allocating them here
> > and passing to the function?
>
> Should I stack allocate all the 4 structures sock_skprot_ioctl and pass
> them to sock_skproto_ioctl_inout() together with the size? (using the
> original name to avoid confusion - will rename in V2)
>
> I mean, writing something as:
>
> int sock_skprot_ioctl(struct sock *sk, unsigned int cmd
>                      void __user *arg`
> {
>         struct sioc_vif_req sioc_vif_req_arg;
>         struct sioc_sg_req sioc_sg_req_arg;
>         struct sioc_mif_req6 sioc_mif_req6_arg;
>         struct sioc_sg_req6 sioc_sg_req6_arg;
>
>         ..
>
>         if (!strcmp(sk->sk_prot->name, "RAW6")) {
>         switch (cmd) {
>                case SIOCGETMIFCNT_IN6:
>                        return sock_skproto_ioctl_inout(sk, cmd,
>                                arg, &sioc_mif_req6_arg, sizeof(sioc_mif_r=
eq6_arg);
>                case SIOCGETSGCNT_IN6:
>                        return sock_skproto_ioctl_inout(sk, cmd,
>                                arg, &sioc_sg_req6_arg, sizeof(sioc_sg_req=
6_arg));
>                }
>        }
>        ...
> }

Slight preference for using braces in the individual case statements
and defining the variables in that block scope. See for instance
do_tcp_setsockopt.

Btw, no need for a cover letter for a single patch.
