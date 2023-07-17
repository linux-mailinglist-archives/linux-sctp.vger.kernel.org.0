Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382397568B2
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Jul 2023 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGQQHO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Jul 2023 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGQQHN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 17 Jul 2023 12:07:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82608E;
        Mon, 17 Jul 2023 09:07:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so6660751276.1;
        Mon, 17 Jul 2023 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610032; x=1692202032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JyHG1WxRQ/YqhjA8E1ld2OmrrDjAyS5clAk3lqrbII=;
        b=PMb/LYSD3v6uimQEoTI/FQOjSo7LSqst84TqtCera31pgqx8409VQATcYKVGELlaXX
         3cqN8IG92FKCY15jevi53Q2uY7IO2ErnLBPLtpVssdFh2H2YrvEwrTWDeeWdYlh4t5jk
         MCKFcwe/21FqQw/9Sj+L1yVDilSfc121oWruS9Rle6cxk/3osBoJxGJpv2J4PpRYt/R/
         aAROmeS6rnSRbW2w+KHusGTSAIICCCVOSS00X/D90vMbhq+JgBSEXR8dnmKerUH6AZie
         OH/5juxeGGCFskkfNOr60wHcJiJovi1WSfpRsFWBJi+CrJ6mOvifnUAL5GQ9zEoXfuzh
         7EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610032; x=1692202032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JyHG1WxRQ/YqhjA8E1ld2OmrrDjAyS5clAk3lqrbII=;
        b=N2/e3mBw1RZYDLQNbyFjb3aEpVfQdCIhcjKGsVskKGOr5D5dybky3O9qmWuJdcvjZW
         7wQfElWJN/Zc5lgkz9MsAjoNXbapmxhvwS5w/m1OPibUpnxohy9EYmdH24ioCKEmLzNO
         VSJLdRWSiq9TG9WcBKTPgdf7KlT/guvr++ikvMg4OPfYw7ZY1KxbA6uOR4maqMP+ej12
         WtWkd5rOdNuIaBwp1rjV0kpI4tGEKDau4uYgKswWu/24CfU9enNmhPIhkLnAiX3UTwZO
         6pkyq9iYqAiV3FHFXc9V21UJWFh0MfJ1x4MPkgzJlGihQOkV3AGe6Tulfk0MaNx6MyMR
         91sA==
X-Gm-Message-State: ABy/qLb6BO7qsavCfNOepVx8iP6cFmTLRirRH8EuU/JdCp44YV3cYsa1
        fhHKAOTbsm6HSC7q/ywgB3p2QJ3Z9VmMDMl8taRNA11ZjA0Q/ss4
X-Google-Smtp-Source: APBJJlEL01nT+AIqXSb93rTQze28AGlFbs64ZSS+6qxFH4ShqH6Gxx5K6KruzowHuwePiKMsRMmQP8XMdfDnxrkD1YU=
X-Received: by 2002:a25:2514:0:b0:bac:ada7:140e with SMTP id
 l20-20020a252514000000b00bacada7140emr10110952ybl.9.1689610031860; Mon, 17
 Jul 2023 09:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689600901.git.gnault@redhat.com> <8ecb4d62fea0ba72bc8a5525d097b36a6c6d0b32.1689600901.git.gnault@redhat.com>
In-Reply-To: <8ecb4d62fea0ba72bc8a5525d097b36a6c6d0b32.1689600901.git.gnault@redhat.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 17 Jul 2023 12:06:55 -0400
Message-ID: <CADvbK_eJB9omtsR6xBUN04Z0PHOVZ+e4BP3gr+PrTEnNa3FdqQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] sctp: Set TOS and routing scope
 independently for fib lookups.
To:     Guillaume Nault <gnault@redhat.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 17, 2023 at 9:53=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> There's no reason for setting the RTO_ONLINK flag in ->flowi4_tos as
> RT_CONN_FLAGS() does. We can easily set ->flowi4_scope properly
> instead. This makes the code more explicit and will allow to convert
> ->flowi4_tos to dscp_t in the future.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  net/sctp/protocol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 274d07bd774f..33c0895e101c 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -435,7 +435,8 @@ static void sctp_v4_get_dst(struct sctp_transport *t,=
 union sctp_addr *saddr,
>         fl4->fl4_dport =3D daddr->v4.sin_port;
>         fl4->flowi4_proto =3D IPPROTO_SCTP;
>         if (asoc) {
> -               fl4->flowi4_tos =3D RT_CONN_FLAGS_TOS(asoc->base.sk, tos)=
;
> +               fl4->flowi4_tos =3D RT_TOS(tos);
> +               fl4->flowi4_scope =3D ip_sock_rt_scope(asoc->base.sk);
>                 fl4->flowi4_oif =3D asoc->base.sk->sk_bound_dev_if;
>                 fl4->fl4_sport =3D htons(asoc->base.bind_addr.port);
>         }
> --
> 2.39.2
Reviewed-by: Xin Long <lucien.xin@gmail.com>
