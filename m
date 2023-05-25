Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942C710E25
	for <lists+linux-sctp@lfdr.de>; Thu, 25 May 2023 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbjEYOTt (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 25 May 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbjEYOTs (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 25 May 2023 10:19:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58031A1
        for <linux-sctp@vger.kernel.org>; Thu, 25 May 2023 07:19:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f606e111d3so59585e9.1
        for <linux-sctp@vger.kernel.org>; Thu, 25 May 2023 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685024385; x=1687616385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3OLocOSEgHA4fLQ6+Y82/v18zp3KYq0EzJK7Sx6w4=;
        b=wHkJLBUPHnTjbEYVjNmSFBfrwTo4TZCcKmMspyHDJqkEgtEn/NrM7MabqcVul3Nqno
         Tj3bI4zoJ6l4Hg9bQmHhQQbBhAlRKcDm8amOqdotCQ9oFlP/+FfObQ0hng3dnX7Q/MZN
         zgGYdbCaPMvQmlkltsmx7FD2VjtKEhvmJCJlXmwvBZuW6dSptjbG7SRNG1Fm7qQKN4yC
         liMx8NahKkYKHcLA5WQznaj+nl+rQ5jq8bHdUqe+SiABS/vuvAbc4CowJ81V9pztluPl
         E5+xBeURqDYhzDTgK1vcmxkBvMDxMcF/cgTRWGzjM42BHCjiZvvDd2GvPhq5Nbgt/3q2
         /3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685024385; x=1687616385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3OLocOSEgHA4fLQ6+Y82/v18zp3KYq0EzJK7Sx6w4=;
        b=Mopt218cmYULkWr+1aNgcOSa7SNOkUaPOqiSw52gnVTFnGvO9lx3zwsuz+Q2/MIaUk
         NNfmSIKxZFhWWmWAxzWv2O9QHpUyjO77ppF1Comt6heqDCsDjisDqGT86j+lKmjhUKKi
         7qIihyTO2Dv6Po5wT+np9DnaGmUhcSHFjqqxvTtunYP/yna7WXUbxYjdOXRI45PfU1w0
         6R5byJyxIyZe5tbH234k137519xP36lcmC1m5arRB3CqS7GgQibbGvDem/Mac+NrFvbv
         FzZ8v9AGzgp7ui3W5t6pF9pAP835XHdFXXURVkmybkalTKL9PP+Ijb0jxHTVZpYh/GMm
         p/zA==
X-Gm-Message-State: AC+VfDwXB+pcI56f847kMvlGd7D+5YeU3prBn9jau9/L6pz8obYF29sb
        mtARDn+mOQ8mRxMxgTHQEBIoclPAAe68JwBlFrowWQ==
X-Google-Smtp-Source: ACHHUZ4KFnQzrzknp0KdGkKJEouEDAIY/mR2vIflKYoy2kK41wOoC3lIDyruRoVpOijJkXCW0hl4A17q3HS19WMLAxw=
X-Received: by 2002:a05:600c:a0e:b0:3f1:9a3d:4f7f with SMTP id
 z14-20020a05600c0a0e00b003f19a3d4f7fmr147224wmp.1.1685024384734; Thu, 25 May
 2023 07:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230525125503.400797-1-leitao@debian.org>
In-Reply-To: <20230525125503.400797-1-leitao@debian.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 25 May 2023 16:19:32 +0200
Message-ID: <CANn89i+neca0ApNxRdZCiTMkwy-5=0mnOMM=9Z3u78VPNw4_fg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
To:     Breno Leitao <leitao@debian.org>
Cc:     dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
        Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, leit@fb.com, axboe@kernel.dk,
        asml.silence@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, May 25, 2023 at 2:55=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
>
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
>

 diff --git a/include/net/phonet/phonet.h b/include/net/phonet/phonet.h
> index 862f1719b523..93705d99f862 100644
> --- a/include/net/phonet/phonet.h
> +++ b/include/net/phonet/phonet.h
> @@ -109,4 +109,23 @@ void phonet_sysctl_exit(void);
>  int isi_register(void);
>  void isi_unregister(void);
>
> +#ifdef CONFIG_PHONET
> +int phonet_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)=
;
> +
> +static inline bool phonet_is_sk(struct sock *sk)
> +{
> +       return sk->sk_family =3D=3D PF_PHONET && sk->sk_protocol =3D=3D P=
N_PROTO_PHONET;
> +}
> +#else
> +static inline bool phonet_is_sk(struct sock *sk)
> +{
> +       return 0;
> +}
> +
> +static inline int phonet_sk_ioctl(struct sock *sk, unsigned int cmd, voi=
d __user *arg)
> +{
> +       return 1;
> +}
> +#endif
> +
>

PHONET can be built as a module, so I guess the compiler would
complain if "CONFIG_PHONET=3Dm" ???
