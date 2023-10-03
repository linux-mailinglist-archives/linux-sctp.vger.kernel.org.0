Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E797B6BD5
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjJCOhU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjJCOhS (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 10:37:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA3AB;
        Tue,  3 Oct 2023 07:37:14 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d90da64499cso1056806276.0;
        Tue, 03 Oct 2023 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696343833; x=1696948633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDSrbor6d5vrsa4WUXcUYUUsBIxTGmw3LfKQuRqMfxg=;
        b=AUE67MRPiRoTLOgVdDB+5QdYtsEM47K9N4jCJCbZoAbSPGLI0B2/fNu9JhyWGqqwaj
         1dyiLmgFQrOok+OHF2RkLNyS7NhUXV+9QPt8pfouhHv2GRvW028G7u2L3Y4NX5UDvgE/
         6iTOS1d0fs4mK9Aik456o/UckMqVKQTfn3KoU0xXFdJGjACAh61UxP22Y3DsB3eRjh63
         8KIC3KRsvP21+eOFx3G4FC1Epnh2G8on/0HIzscXvvHg6OKeM1LjNnKquaffOkZWJ/Nd
         M8OvH5dR/emUOtqTIx64VkCGd9g14ZTLavhPWaoEKwhMio9HmGvdCd3nNMDtpWvmHefv
         m+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343833; x=1696948633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDSrbor6d5vrsa4WUXcUYUUsBIxTGmw3LfKQuRqMfxg=;
        b=MgCwcXwc9ysGgJn+Lbpqtqcs7ckA/VGp2WlARJSjm2zlc+g+hbE4eH+0bryYgUZe3L
         HbVmBTZ7ud2lXRbXwN8iEhCe1kRW9+hfcU9epFYi05QYU4OK8QTgueO0Mqq1x4VxquA+
         tq+PQnJhdWCf0RzdLydCZjAdrfBj/qpbxwwuJkMKu3w0+xhO7rAvXm+3izJegAyqJu76
         +kA2j/CuE4p3pYtb4v8g1CtISNTG0xCzhp0XLOHwdMTgjUMnp2fr9jMuND7JqvKJqYms
         VHkgpA9fUivG9xCDk3Zfyy8B9QfA+EipKom/R6AKjCPlhw48ZcAqza8KU/StBKVL3D22
         7b/g==
X-Gm-Message-State: AOJu0YytEkS/RMr4xF+/sHdPIecN+2S+kA8jrvHcprstFUFcFhAAunpm
        Io4g1ochpDLu9EcVDxuhl5dwF0c3Ucj9MR6I/ys7Ywxk
X-Google-Smtp-Source: AGHT+IFZxGTJOgKxVQG5wsIyVvQRptQFng65OIT7UDDJjnn2dGSTzmZIsyhQJdinmjW/Mf9HMf+iU2VXM9tLzzv5t7c=
X-Received: by 2002:a25:df91:0:b0:d86:2156:c314 with SMTP id
 w139-20020a25df91000000b00d862156c314mr14930517ybg.28.1696343833061; Tue, 03
 Oct 2023 07:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <ZRwOVyKQR8MBjpBh@kernel.org> <CADvbK_fK03UO3R=70J+VoGVm_LJuzZbh+_=0doceS8DCPJYBVA@mail.gmail.com>
 <20231003142343.GA8405@breakpoint.cc>
In-Reply-To: <20231003142343.GA8405@breakpoint.cc>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 3 Oct 2023 10:37:01 -0400
Message-ID: <CADvbK_cHfsGaLG5NyWo6rXBpuPvqS4yWUCEhK3TcC65gixkPTQ@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
To:     Florian Westphal <fw@strlen.de>
Cc:     Simon Horman <horms@kernel.org>,
        network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Oct 3, 2023 at 10:23=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
> > > The type of vtag is u32. But the type of ct->proto.sctp.vtag[!dir] an=
d init_tag
> > > is __be32. This doesn't seem right (and makes Sparse unhappy).
> > You're right, I will fix it and re-post with tag:
> >
> > Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
>
> I'm fine with this, the bug is likely inherited from
> ipt_conntrack_sctp.c, but that doesn't exist anymore.
ah, I see.

>
> Would you also fix up the __be32/u32 confusion?
>
> Better to not add more sparse warnings...
>
yes, I will fix the __be32 one too.

Thanks.
