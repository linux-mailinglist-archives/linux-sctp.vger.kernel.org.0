Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6457515FD
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Jul 2023 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjGMCCh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 12 Jul 2023 22:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGMCCg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 12 Jul 2023 22:02:36 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3E1FD6;
        Wed, 12 Jul 2023 19:02:34 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-444c5209861so114471137.2;
        Wed, 12 Jul 2023 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689213754; x=1691805754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiS3BGLVDtj4R25tckJIQtyqK9hOLbEea2jDynKrbjU=;
        b=KZMBpTBH33didekshXEgRJxJXueNDxLw+OpJOIIGIFg19vFpc8eHiiFgaqQzvx0eC2
         y28J42zKZ35/vfYYazEAvbf1np9k5Z2RZ7MJw1CTLZVgLIdWI9htYO+6ZMZSufdsQPS0
         T0VO1cew0ZSA8Ou/So3CxboIfYIBMoDu2mOpgQx50brRYWJEv6LgmlHKKylIm6Amzvq9
         JCXGdD7TQXYBjwQ0cBtz6rpQKcwmvT6C1osF8oPIN2qlEn/qCq+uhNSaBx+/16jUWVyP
         ugwYZ/KFo7TH83eHvL0ZXk+YlCBe9HWzpSOdU/2IPJz8sgbiqPdf5Qzxavev9KgOKEA0
         mwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689213754; x=1691805754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiS3BGLVDtj4R25tckJIQtyqK9hOLbEea2jDynKrbjU=;
        b=Fg9EW0+h2YxIk6KXPCZaKdMLZLP9aD6KyKPIb9h0iaa/uhdrx8JHJALsUhLJl/oT0r
         OrpXJyrJqiPhPY12kPNqX1QCdGLxyL7SaQ/SUaRhH/pJTB1vf8yUkCnVs7bFqhs+ucFF
         sWXH2TkfWgW/IXQtOSSd+GXE8su7AoFPOwVDyeHqDit01fY9yO8cT6/N+DIfWrF7/2kL
         pB4DVZP/+tv1FYWXTkrCdFR5hNhV96smc93wph5y2eMXjPWGzSGVKMw7M83H18qDfitI
         EybEtIi+6wQe4ePyQMXp5Wy6dwWHSSS2QVUtwEuZVRyXbamsDueZRDfqLtmShPGbsFT7
         Rg6w==
X-Gm-Message-State: ABy/qLYxrdpCGsTvvt8mbDdNDN3+voEgjkfX9iN5+5FUX6hUpdAaqk0J
        HGgX6vsamD0+Idfbs62GTiwiUyQ2pTOO7315Ycwucy0UxcQ=
X-Google-Smtp-Source: APBJJlF9aHgncchT+3cRAkCk1U/N1nOJx8LUbmT2m7uCdGfKinqaEBite8KPp6bClIsoX63QdPZ64zMhrTdsmYuYFqU=
X-Received: by 2002:a67:ef99:0:b0:443:5bec:a2fd with SMTP id
 r25-20020a67ef99000000b004435beca2fdmr270251vsp.18.1689213753738; Wed, 12 Jul
 2023 19:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZK9ZiNMsJX8+1F3N@debian.debian>
In-Reply-To: <ZK9ZiNMsJX8+1F3N@debian.debian>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 12 Jul 2023 22:01:57 -0400
Message-ID: <CAF=yD-Lb2k02TLaCQHwFSG=eQrWCnvqHVaWuK2viGqiCdwAxwg@mail.gmail.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related protocols
To:     Yan Zhai <yan@cloudflare.com>
Cc:     "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Melnychenko <andrew@daynix.com>,
        Jason Wang <jasowang@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
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

On Wed, Jul 12, 2023 at 9:55=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> SKB_GSO_DODGY bit indicates a GSO packet comes from an untrusted source.
> The canonical way is to recompute the gso_segs to avoid device driver
> issues. Afterwards, the DODGY bit can be removed to avoid re-check at the
> egress of later devices, e.g. packets can egress to a vlan device backed
> by a real NIC.
>
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation [1].
>
> Commit 90017accff61 ("sctp: Add GSO support") and commit 3820c3f3e417
> ("[TCP]: Reset gso_segs if packet is dodgy") both didn't remove the DODGY
> bit after recomputing gso_segs.
>
> This change fixes the GSO_UDP_L4 handling case, and remove the DODGY bit
> at other places.

These two things should not be conflated.

Only the USO fix is strictly needed to fix the reported issue.

> Fixes: 90017accff61 ("sctp: Add GSO support")
> Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
> Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packet=
s.")

Link: https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaD=
o28KzYDg+A@mail.gmail.com/

> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> ---
> [1]:
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28K=
zYDg+A@mail.gmail.com/
>
> ---
>  net/ipv4/tcp_offload.c |  1 +
>  net/ipv4/udp_offload.c | 19 +++++++++++++++----
>  net/ipv6/udp_offload.c | 19 +++++++++++++++----
>  net/sctp/offload.c     |  2 ++
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 8311c38267b5..f9b93708c22e 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -87,6 +87,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>                 /* Packet is from an untrusted source, reset gso_segs. */
>
>                 skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, mss)=
;
> +               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
>
>                 segs =3D NULL;
>                 goto out;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 75aa4de5b731..bd29cf19bb6b 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -388,11 +388,22 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_=
buff *skb,
>         if (!pskb_may_pull(skb, sizeof(struct udphdr)))
>                 goto out;
>
> -       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> -           !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> -               return __udp_gso_segment(skb, features, false);
> -
>         mss =3D skb_shinfo(skb)->gso_size;

Why move the block below this line?

> +
> +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> +               if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> +                       /* Packet is from an untrusted source, reset actu=
al gso_segs */
> +                       skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->l=
en - sizeof(*uh),
> +                                                                mss);
> +                       skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
> +
> +                       segs =3D NULL;
> +                       goto out;
> +               } else {
> +                       return __udp_gso_segment(skb, features, false);
> +               }
> +       }
> +

The validation should take place inside __udp_gso_segment.

Revert the previous patch to always enter that function for USO packets:

       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
                return __udp_gso_segment(skb, features, false);

And in that function decide to return NULL after validation.


>         if (unlikely(skb->len <=3D mss))
>                 goto out;
>
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index ad3b8726873e..6857d9f7bd06 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -43,11 +43,22 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_bu=
ff *skb,
>                 if (!pskb_may_pull(skb, sizeof(struct udphdr)))
>                         goto out;
>
> -               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> -                   !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> -                       return __udp_gso_segment(skb, features, true);
> -
>                 mss =3D skb_shinfo(skb)->gso_size;
> +
> +               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> +                       if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST=
)) {
> +                               /* Packet is from an untrusted source, re=
set actual gso_segs */
> +                               skb_shinfo(skb)->gso_segs =3D DIV_ROUND_U=
P(skb->len - sizeof(*uh),
> +                                                                        =
mss);
> +                               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_D=
ODGY;
> +
> +                               segs =3D NULL;
> +                               goto out;
> +                       } else {
> +                               return __udp_gso_segment(skb, features, t=
rue);
> +                       }
> +               }
> +
>                 if (unlikely(skb->len <=3D mss))
>                         goto out;
>
> diff --git a/net/sctp/offload.c b/net/sctp/offload.c
> index 502095173d88..3d2b44db0d42 100644
> --- a/net/sctp/offload.c
> +++ b/net/sctp/offload.c
> @@ -65,6 +65,8 @@ static struct sk_buff *sctp_gso_segment(struct sk_buff =
*skb,
>                 skb_walk_frags(skb, frag_iter)
>                         pinfo->gso_segs++;
>
> +               pinfo->gso_type &=3D ~SKB_GSO_DODGY;
> +
>                 segs =3D NULL;
>                 goto out;
>         }
> --
> 2.30.2
>
