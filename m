Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651A6753090
	for <lists+linux-sctp@lfdr.de>; Fri, 14 Jul 2023 06:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGNE2J (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 14 Jul 2023 00:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGNE2F (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 14 Jul 2023 00:28:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F62D48
        for <linux-sctp@vger.kernel.org>; Thu, 13 Jul 2023 21:28:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51fdf291330so1710200a12.2
        for <linux-sctp@vger.kernel.org>; Thu, 13 Jul 2023 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689308882; x=1691900882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHf1bw4VEpalWptJ6sYJzbTQLUqyeRRjE32ptoAxuck=;
        b=WwQTm81PifCGhzdXHwWxFJ/ZyEy6HDXKNCuPzEZXtpDnW8q5Muu8GTMaM7bPmfc53y
         mwIjXhH1ncVmbGLd2bgQq2RnH1N/6uTOwawh+Z3XiemFY3Dz4COKat3Yce3aoPrf+qYa
         tPPdsbfW9BBefcRRqo7XNhiQx0cBf1C2WLU8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689308882; x=1691900882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHf1bw4VEpalWptJ6sYJzbTQLUqyeRRjE32ptoAxuck=;
        b=UPbJZAAvVfMjQLP7VLzBe1U+m5e52wK/wtBY84JblIA8/rBQaVGIdzQwQQeYVb5zC8
         vMnC7KzFKxNlfQ2p4TrC0g7oxbFwzkplfFxG0xSexzllawRlHGYnloZ7T5F/b4uWnDCJ
         oOPnLp6obZRlUV/531e1NR1HEayRFJvYAetz/XgQ3GDyrPAEZlUgjc3amIC2j5TM43yE
         ym5zpGBOXplRwbh0X4pm0vROBXTMsJLHuBw4WvWejxmRjRxgjsJUtSXxZKihflrIl+9Y
         /InBx1rGh2j5rQ4M1l3dYDE3QRAGoNDoo0NXR3p7HlRFyACu1HQdqRj2+da6ut9VowoW
         wd1g==
X-Gm-Message-State: ABy/qLajAae7fZZDS509gtAVbeAYsDCVc1laHLMp+BqxZm4t1kNA8re/
        RbM7cb0A9tGjzE6dZ4i6LT5Pu2vJl9Z/gAm+mVFHUA==
X-Google-Smtp-Source: APBJJlF4bnf1g8fW6x42O1YXhzENyu6ohKCQGrFHpqkr2RllFBk2SW+06TBLxI8i3KzjCP1Xn3yYNiYaY5ZEP+xS7/Y=
X-Received: by 2002:a05:6402:60a:b0:51d:7fa6:62ca with SMTP id
 n10-20020a056402060a00b0051d7fa662camr3222649edv.14.1689308882567; Thu, 13
 Jul 2023 21:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZLA0ILTAZsIzxR6c@debian.debian> <CAF=yD-K-fra5nc-pjOV8Ng9sB2WWWeZA=s+-WN=O6+=8aZ-E6w@mail.gmail.com>
In-Reply-To: <CAF=yD-K-fra5nc-pjOV8Ng9sB2WWWeZA=s+-WN=O6+=8aZ-E6w@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Thu, 13 Jul 2023 23:27:51 -0500
Message-ID: <CAO3-Pbr8kypYNSJchh3b4KCe4e0XH038BU6YQm3i+u+EHt2iDw@mail.gmail.com>
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Jul 13, 2023 at 12:38=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 1:28=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> > packets.") checks DODGY bit for UDP, but for packets that can be fed
> > directly to the device after gso_segs reset, it actually falls through
> > to fragmentation:
> >
> > https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo2=
8KzYDg+A@mail.gmail.com/
> >
> > This change restores the expected behavior of GSO_UDP_L4 packets.
> >
> > Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 pack=
ets.")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> for next time: places hyperlinks in the block of tags at the bottom of
> the commit as "Link: ${URL}"

Good to learn, thanks!
--
Yan
