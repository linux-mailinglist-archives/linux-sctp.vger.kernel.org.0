Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B120C74023D
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Jun 2023 19:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF0ReV (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 27 Jun 2023 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjF0ReR (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 27 Jun 2023 13:34:17 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B00270C;
        Tue, 27 Jun 2023 10:34:16 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5769e6a6818so38800447b3.1;
        Tue, 27 Jun 2023 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687887256; x=1690479256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFeHm9bU8RrhQ+qc5bzdZqgetskKJ+S12T31+KyGXkA=;
        b=VGiNpJNiI5vl1huK2HIJqIZy9oyI6WX52GvPhRlyA65lAmumA/7Cdo6BL654x5gYt4
         hkg16ML16rcVSw/IM9/2JfFFjsxWnD9GJPk8CoYwt+EDa3qKbcXxcmPckEslURsQz7Im
         OC3lXFjimUsF5zKKOiO1dbWS2ApoMHcXh/L5+uSlRlL7gd+lSfTn9QQ9cOYadBEi5dLA
         NDWlEcmdKSL9+gHT3yBOVVKVlf5OeepO7xGzk3GVWGB7f3MtquW83lYidsLo3MLF+oGv
         7nLIzMHpx6cpRlRCj1XxeHm120zdlBCt41P6twvM7UONy5yrCjSPpjmwSM4F+5sCCAhi
         sulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687887256; x=1690479256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFeHm9bU8RrhQ+qc5bzdZqgetskKJ+S12T31+KyGXkA=;
        b=Buaiv0FNarFOHnsb0HPrMKnyA2H5iEjZ/rfBQLzkanc0g2RjFVAY3vsGlVXG0dnA0t
         31DHmKXKozOuvEL5TCvC/E98cAcSGZVg131jZvur1L1+gW2HV858zavaIvz+bTFrhQgE
         FadkpRguTeYhdE6q/MGJYCrVQn2Ac5gNKa7TBdXyodUudG1eHm/uYr79kA2v4zKCiwdu
         qE7JPpTHgZ24d85xhPVfuh3cnJoHOwveuWuPzhIU6lRrHu7BQtn481HSTrLr5LfVTFYd
         AxUFWQFQFEu+0AdmCRKIitr0bE8BErUHh+4Yr7SL+TSZGSbMyk6JWAqWPrc0kLlTn0O0
         ODdw==
X-Gm-Message-State: AC+VfDwGicz9g8BHga2X+qiYxtWlYIoDkSAPj/tkay4oY60Vn8NC91Jd
        JR+WWBbIsusRYDH5s/JO6Q7/WNeEyKp2/YEt6V4=
X-Google-Smtp-Source: ACHHUZ5j2tTfJH47u1r+2OnRxLB2L9IIDv4z2m/c9T/LNof5iBvyRAu6YMuH+MsWvt4coYFgM3VSjpOKcas4/ckQJyw=
X-Received: by 2002:a25:d304:0:b0:bac:f398:3571 with SMTP id
 e4-20020a25d304000000b00bacf3983571mr26556774ybf.23.1687887255983; Tue, 27
 Jun 2023 10:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230627120340.19432-1-dg573847474@gmail.com>
In-Reply-To: <20230627120340.19432-1-dg573847474@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 27 Jun 2023 13:33:18 -0400
Message-ID: <CADvbK_faoh-=8AZ7s+ak9QpmGQa_GddikWvyYW_b0Lb8=mNcJA@mail.gmail.com>
Subject: Re: [PATCH] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     marcelo.leitner@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jun 27, 2023 at 8:04=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.com=
> wrote:
>
> As &net->sctp.addr_wq_lock is also acquired by the timer
> sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
> at sctp_auto_asconf_init() seems should disable irq since it is called
> from sctp_accept() under process context.
>
> Possible deadlock scenario:
> sctp_accept()
>     -> sctp_sock_migrate()
>     -> sctp_auto_asconf_init()
>     -> spin_lock(&net->sctp.addr_wq_lock)
>         <timer interrupt>
>         -> sctp_addr_wq_timeout_handler()
>         -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)
>
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
>
> The tentative patch fix the potential deadlock by spin_lock_bh().
>
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  net/sctp/socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index cda8c2874691..b2c7d17ff848 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -364,9 +364,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *s=
p)
>         struct net *net =3D sock_net(&sp->inet.sk);
>
>         if (net->sctp.default_auto_asconf) {
> -               spin_lock(&net->sctp.addr_wq_lock);
> +               spin_lock_bh(&net->sctp.addr_wq_lock);
>                 list_add_tail(&sp->auto_asconf_list, &net->sctp.auto_asco=
nf_splist);
> -               spin_unlock(&net->sctp.addr_wq_lock);
> +               spin_unlock_bh(&net->sctp.addr_wq_lock);
>                 sp->do_auto_asconf =3D 1;
>         }
>  }
> --
> 2.17.1
>
Fixes: 34e5b0118685 ("sctp: delay auto_asconf init until binding the
first addr")
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.
