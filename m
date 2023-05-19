Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD34709B77
	for <lists+linux-sctp@lfdr.de>; Fri, 19 May 2023 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjESPjK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjESPjJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 11:39:09 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54C19F;
        Fri, 19 May 2023 08:39:07 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30948709b3cso1544237f8f.3;
        Fri, 19 May 2023 08:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510746; x=1687102746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+3zLRO6P1z7EWxNec705aXZXE4sUCnWuvzNCkJyTRs=;
        b=dlv5GoTaZ9MJ/6FGPXwm4eqiGfA1guakro49j+iuFuioqjgPE+IsH8hINVrocwny4r
         M11167U7oPfhEQZCHaj/tVI6Bg4rCaSnfnrMQefegouPZkhCokOrt+h3qJ+KyrQ5vBer
         XHekxQRxGhy9+t5M+obGuDosthpA7HTrXYvO7T9QlsNsEIY4e5zqwRBhiHrjEnu9p7/L
         kMi/mQ79X/fv4zuoc6m6JZqUOKpAM30Z0MQTaLZqPlgXiu83CtmZJIYMRzdYl+3Gyyt+
         r5xhya6473Sj4teBm7vVCEEW0YbES4luJkUEOruSCrX6tAkbvFMAYtngJR/HvOBuZ2AI
         ChXg==
X-Gm-Message-State: AC+VfDwCOfmKf8ofgo1JzSWTujaLEBRkKBp8xIzx8Z0LAaqIPQSUhwvG
        FQN6wT8GdxKW/9+f8PYXIOs=
X-Google-Smtp-Source: ACHHUZ7r8qvUEprMwUVyjYpon9esilwB6U0xvA31i7GU0SJAUOGNcni7PWZwPXxBEiFwiUI3A2Eo6A==
X-Received: by 2002:adf:f049:0:b0:309:3d00:7d4f with SMTP id t9-20020adff049000000b003093d007d4fmr2293928wro.28.1684510745725;
        Fri, 19 May 2023 08:39:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-041.fbsv.net. [2a03:2880:31ff:29::face:b00c])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c214c00b003f50237bd9csm2792189wml.19.2023.05.19.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:39:05 -0700 (PDT)
Date:   Fri, 19 May 2023 08:39:03 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     axboe@kernel.dk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, courmisch@gmail.com,
        nhorman@tuxdriver.com, asml.silence@gmail.com,
        alex.aring@gmail.com, dccp@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
        marcelo.leitner@gmail.com, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, leit@fb.com, David.Laight@aculab.com,
        dsahern@kernel.org
Subject: Re: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl
 callbacks
Message-ID: <ZGeYF+pp8Ukbo4p5@gmail.com>
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519135821.922326-2-leitao@debian.org>
 <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, May 19, 2023 at 11:09:29AM -0400, Willem de Bruijn wrote:
> On Fri, May 19, 2023 at 9:59 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Most of the ioctls to net protocols operates directly on userspace
> > argument (arg). Usually doing get_user()/put_user() directly in the
> > ioctl callback.  This is not flexible, because it is hard to reuse these
> > functions without passing userspace buffers.
> >
> > Change the "struct proto" ioctls to avoid touching userspace memory and
> > operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> > adapted to operate on a kernel memory other than on userspace (so, no
> > more {put,get}_user() and friends being called in the ioctl callback).
> >
> > This changes the "struct proto" ioctl format in the following way:
> >
> >     int                     (*ioctl)(struct sock *sk, int cmd,
> > -                                        unsigned long arg);
> > +                                        int *karg);
> >
> > So, the "karg" argument, which is passed to the ioctl callback, is a
> > pointer allocated to kernel space memory (inside a function wrapper -
> > sock_skprot_ioctl()). This buffer (karg) may contain input argument
> > (copied from userspace in a prep function) and it might return a
> > value/buffer, which is copied back to userspace if necessary. There is
> > not one-size-fits-all format (that is I am using 'may' above), but
> > basically, there are three type of ioctls:
> >
> > 1) Do not read from userspace, returns a result to userspace
> > 2) Read an input parameter from userspace, and does not return anything
> >   to userspace
> > 3) Read an input from userspace, and return a buffer to userspace.
> >
> > The default case (1) (where no input parameter is given, and an "int" is
> > returned to userspace) encompasses more than 90% of the cases, but there
> > are two other exceptions. Here is a list of exceptions:
> >
> > * Protocol RAW:
> >    * cmd = SIOCGETVIFCNT:
> >      * input and output = struct sioc_vif_req
> >    * cmd = SIOCGETSGCNT
> >      * input and output = struct sioc_sg_req
> >    * Explanation: for the SIOCGETVIFCNT case, userspace passes the input
> >      argument, which is struct sioc_vif_req. Then the callback populates
> >      the struct, which is copied back to userspace.
> >
> > * Protocol RAW6:
> >    * cmd = SIOCGETMIFCNT_IN6
> >      * input and output = struct sioc_mif_req6
> >    * cmd = SIOCGETSGCNT_IN6
> >      * input and output = struct sioc_sg_req6
> >
> > * Protocol PHONET:
> >   * cmd == SIOCPNADDRESOURCE | SIOCPNDELRESOURCE
> >      * input int (4 bytes)
> >   * Nothing is copied back to userspace.
> >
> > For the exception cases, functions sock_skproto_ioctl_in{out}() will
> > copy the userspace input, and copy it back to kernel space.
> >
> > The wrapper that prepares the buffer and puts the buffer back to user is
> > sock_skprot_ioctl(), so, instead of calling sk->sk_prot->ioctl(), the
> > callee now calls sock_skprot_ioctl().
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Overall this looks great to me.

Thanks for the guidance and quick review!

> 
> Thanks for the detailed commit message that lists all exceptions, Bruno.
> 
> Since that is a limited well understood list, I'm not in favor of the
> suggestion to add an explicit length argument that then needs to be
> checked in each callee.
> 
> > +/* Copy 'size' bytes from userspace and return `size` back to userspace */
> > +int sock_skproto_ioctl_inout(struct sock *sk, unsigned int cmd,
> > +                            void __user *arg, size_t size)
> > +{
> > +       void *ptr;
> > +       int ret;
> > +
> > +       ptr = kmalloc(size, GFP_KERNEL);
> > +       if (!ptr)
> > +               return -ENOMEM;
> 
> > +/* A wrapper around sock ioctls, which copies the data from userspace
> > + * (depending on the protocol/ioctl), and copies back the result to userspace.
> > + * The main motivation for this function is to pass kernel memory to the
> > + * protocol ioctl callsback, instead of userspace memory.
> > + */
> > +int sock_skprot_ioctl(struct sock *sk, unsigned int cmd,
> > +                     void __user *arg)
> > +{
> > +#ifdef CONFIG_IP_MROUTE
> > +       if (!strcmp(sk->sk_prot->name, "RAW")) {
> 
> This must check both sk_family and sk_protocol. That is preferable
> over string match.
> 
> For these exception cases, instead of having sock_skproto_ioctl_inout
> dynamically allocate the struct, how about stack allocating them here
> and passing to the function?

Should I stack allocate all the 4 structures sock_skprot_ioctl and pass
them to sock_skproto_ioctl_inout() together with the size? (using the
original name to avoid confusion - will rename in V2)

I mean, writing something as:

int sock_skprot_ioctl(struct sock *sk, unsigned int cmd
                     void __user *arg`
{
	struct sioc_vif_req sioc_vif_req_arg;
	struct sioc_sg_req sioc_sg_req_arg;
	struct sioc_mif_req6 sioc_mif_req6_arg;
	struct sioc_sg_req6 sioc_sg_req6_arg;

	..

	if (!strcmp(sk->sk_prot->name, "RAW6")) {
        switch (cmd) {
               case SIOCGETMIFCNT_IN6:
                       return sock_skproto_ioctl_inout(sk, cmd,
                               arg, &sioc_mif_req6_arg, sizeof(sioc_mif_req6_arg);
               case SIOCGETSGCNT_IN6:
                       return sock_skproto_ioctl_inout(sk, cmd,
                               arg, &sioc_sg_req6_arg, sizeof(sioc_sg_req6_arg));
               }
       }
       ...
}
