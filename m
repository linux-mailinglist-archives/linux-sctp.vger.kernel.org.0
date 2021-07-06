Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2F3BC488
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jul 2021 03:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhGFBPo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 5 Jul 2021 21:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhGFBPn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 5 Jul 2021 21:15:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F18C061574;
        Mon,  5 Jul 2021 18:13:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso533879wmh.4;
        Mon, 05 Jul 2021 18:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0N4qW96377LDnYOmu1AZzljNDTveYKSNvIdFPUdlig=;
        b=Y3x3AGs7sJA067LDVJVliGi+M6O7BVtzWWKCrFU3+dhMD/cZCmz6XdKFg45EWaxHm7
         i6/ubsiZ67Zy6J8Ll3c0Doe7Ilvrf6pjlckyHX+JRCIdvCJSUgSU55rmQ55KA4e6I8Gm
         Fsb9EM29DOrh2PIxTXtCH8q36OTP98+f2CyRm0T5fLdAYWtre0mWEYpcXltA6S7Wti+d
         yNPhgOLwSvG1GmDNgOgjlvsLzj/KXAY1tfgB7TsERvIR5CKPCJLup/qhzykMt8oCAlOO
         l72varmgltyHzmCYyj7KYGzqKtNTDlRhClNhKFZMszXgvM61LMHJUkbvekEk99fUGByJ
         Z16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0N4qW96377LDnYOmu1AZzljNDTveYKSNvIdFPUdlig=;
        b=g53IkR3YnXusKRFwvN5SjJ+iUFNta6fjAgaUWkhQ1i3pR2N977iw+gc/Rpo/HY267m
         B7g/4fSFyYaAVMKaxlmedAhs2wAGB1CMAF1co+0yXhWUvKwdbudU56fMqUDYdXvOFB9d
         4Yr5l1/FcjyVIsIoKFxllcwEVSget4OxssjFfVYcIVun2AzIHF4PgxbsMGMQvwUWsI9B
         8j3EDCF3+Fwl1Oc2j/6qBSmqF+i2/HPCjAysIrA3iKoM4/k7sZJZCCjQb69STiujTYUj
         rdZ6BLJeNCbIgYQ39/Aswek0vAU0JYN9aeInOFcK0pr5MypCmA1akMQjCPp6/fZurWKT
         VAhw==
X-Gm-Message-State: AOAM533EJaqauOPFP3ndU7kNZXTJaqcDuTePyeRzGBMK4c22vjS9sfbb
        f11kdKoWisnz7eXjL+79AEZy/qI2kwW+WeSa+pCJJAlRJwk=
X-Google-Smtp-Source: ABdhPJyDL99iAb7T5XgOjwgwxXQ9a81rXj2Ygh9fQ8mZJBhoq9S6AKW8VyoSJjHjhzcL7bULoUqgXH6WbqWaxeyGhZc=
X-Received: by 2002:a1c:988a:: with SMTP id a132mr1710418wme.175.1625533983814;
 Mon, 05 Jul 2021 18:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210705123405.6089-1-yajun.deng@linux.dev>
In-Reply-To: <20210705123405.6089-1-yajun.deng@linux.dev>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 5 Jul 2021 21:12:54 -0400
Message-ID: <CADvbK_dXKK4-t02hUDMPf_O=L8WD7_=aH7c9VmL0ZgtVE_4nUg@mail.gmail.com>
Subject: Re: [PATCH] net: Fix called net_enable_timestamp() in sctp_copy_sock()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        mathew.j.martineau@linux.intel.com,
        Eric Dumazet <edumazet@google.com>, aahringo@redhat.com,
        linmiaohe@huawei.com, Florian Westphal <fw@strlen.de>,
        xiangxia.m.yue@gmail.com, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 5, 2021 at 8:34 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> Add sock_needs_netstamp() judgment condition when need to call
> net_enable_timestamp().
Why do we need this when it always returns true for SCTP?

>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/net/sock.h | 1 +
>  net/core/sock.c    | 2 +-
>  net/sctp/socket.c  | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8bdd80027ffb..e36563576758 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2757,6 +2757,7 @@ int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
>  void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
>  int sock_set_timestamping(struct sock *sk, int optname, int val);
>
> +bool sock_needs_netstamp(const struct sock *sk);
>  void sock_enable_timestamps(struct sock *sk);
>  void sock_no_linger(struct sock *sk);
>  void sock_set_keepalive(struct sock *sk);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index ba1c0f75cd45..ce6ec9f8ac7c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -429,7 +429,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
>         return 0;
>  }
>
> -static bool sock_needs_netstamp(const struct sock *sk)
> +bool sock_needs_netstamp(const struct sock *sk)
>  {
>         switch (sk->sk_family) {
>         case AF_UNSPEC:
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index e64e01f61b11..30d90735beb0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9449,7 +9449,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
>         newinet->mc_index = 0;
>         newinet->mc_list = NULL;
>
> -       if (newsk->sk_flags & SK_FLAGS_TIMESTAMP)
> +       if (sock_needs_netstamp(newsk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
>                 net_enable_timestamp();
>
>         /* Set newsk security attributes from original sk and connection
> --
> 2.32.0
>
