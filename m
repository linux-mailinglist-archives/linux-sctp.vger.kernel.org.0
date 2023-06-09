Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3EF729DFF
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Jun 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbjFIPNw (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 9 Jun 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbjFIPNv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Jun 2023 11:13:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5131BEB;
        Fri,  9 Jun 2023 08:13:50 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-569386b7861so44032547b3.0;
        Fri, 09 Jun 2023 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686323629; x=1688915629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DPJBtxyfhH74XT8mvDjXgsyibffPNAPPVAUmujTc3s=;
        b=ojRuFmc4ATHmF3WupB8O+fLJxJ3PegXIFH/a0M3KwmaFU1Yibk57J3vzpTiqRpPkDN
         Hz6Vo5/F733l4tWyJA0xwTW9CPCvDE1jWKb6XwRJ4UliGThhPm34Li1cX4THvlj0ls3k
         BS/BarIHEPuda626XB1HifKrtzDbXGCyc+RWBJKQ0vWylaTdX51GzXQd3qjrhcjF0Is4
         orseCJHAe3bzkGOBnx/907jJtsI6U/IIVV3wbno9YaLLwy3pnV1yX6BaAuT97L4Rt6gY
         wcqXosIXAQiyNZYmfErhj80j83RNTpE0PG2raDSsY0bazC/Q0uJ7ukx8qRqjRqL8OVIO
         Hnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323629; x=1688915629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DPJBtxyfhH74XT8mvDjXgsyibffPNAPPVAUmujTc3s=;
        b=DM90njtyc35PWDjzq47gHj/v41V544dwZLDdNNOlWDIT/EAmNx8xI1SvMBaMhOaeTx
         GBqjIRaVgMZ2UAO4aFSBGPNgVYYdIAmZx0ZlcVTY3MmPkR8qL+weib8bQu5j6T5CUgAn
         c+UY2SB+WfQMev0hSszm4GBut+PCkSLJ/aTXFLdzZWi7O4/3SDdE7hWEUqtWS+1OWQDQ
         XJecRN1/4HNEJz62nhltI5gtW/+0+OhOPU33QV3ygD90uKl177IKCf9RmopIOjwWdxsp
         SpDZr0JUhrUCvFUlRC0BmiCU7f+yxaxxdhTlL0B5u1W/CfuqEphv+xCQXVeywAGn+ljs
         E7lA==
X-Gm-Message-State: AC+VfDy/c+QOjuzsf/t1v+Pzz6ExigSEs+tXF7pjrKy/ZaFEx3fQzoQa
        tOJo+CYyV4y31/T6PfnvHT2tSg9QfcVIWJtRlMc=
X-Google-Smtp-Source: ACHHUZ6yRhJIYaLCl71nQBrCvJZjcrNv/C0eGFm6wXIYqOCPJ/6U0VxdHovjcDk4V0g+HOERqLHebM3c+HJfcE3DwSk=
X-Received: by 2002:a81:4e4b:0:b0:569:e92f:72a with SMTP id
 c72-20020a814e4b000000b00569e92f072amr3865083ywb.16.1686323629174; Fri, 09
 Jun 2023 08:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <4629fee1-4c9f-4930-a210-beb7921fa5b3@moroto.mountain> <bfb9c077-b9a6-47f4-8cd8-a7a86b056a21@moroto.mountain>
In-Reply-To: <bfb9c077-b9a6-47f4-8cd8-a7a86b056a21@moroto.mountain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 9 Jun 2023 11:13:03 -0400
Message-ID: <CADvbK_f25PEaR1bSuyqeGQsoOp0v1Psaeu2zPhfEi8Zcu-J5Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2 net] sctp: fix an error code in sctp_sf_eat_auth()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Vlad Yasevich <vladislav.yasevich@hp.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
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

On Fri, Jun 9, 2023 at 7:05=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The sctp_sf_eat_auth() function is supposed to enum sctp_disposition
> values and returning a kernel error code will cause issues in the
> caller.  Change -ENOMEM to SCTP_DISPOSITION_NOMEM.
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/sctp/sm_statefuns.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 97f1155a2045..08fdf1251f46 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -4482,7 +4482,7 @@ enum sctp_disposition sctp_sf_eat_auth(struct net *=
net,
>                                     SCTP_AUTH_NEW_KEY, GFP_ATOMIC);
>
>                 if (!ev)
> -                       return -ENOMEM;
> +                       return SCTP_DISPOSITION_NOMEM;
>
>                 sctp_add_cmd_sf(commands, SCTP_CMD_EVENT_ULP,
>                                 SCTP_ULPEVENT(ev));
> --
> 2.39.2
>
This one looks good to me.

But for the patch 1/2 (somehow it doesn't show up in my mailbox):

  default:
  pr_err("impossible disposition %d in state %d, event_type %d, event_id %d=
\n",
        status, state, event_type, subtype.chunk);
- BUG();
+ error =3D status;
+ if (error >=3D 0)
+ error =3D -EINVAL;
+ WARN_ON_ONCE(1);

I think from the sctp_do_sm() perspective, it expects the state_fn
status only from
enum sctp_disposition. It is a BUG to receive any other values and
must be fixed,
as you did in 2/2. It does the same thing as other functions in SCTP code, =
like
sctp_sf_eat_data_*(), sctp_retransmit() etc.

Thanks.
