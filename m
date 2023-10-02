Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37917B57A1
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Oct 2023 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjJBPjR (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 2 Oct 2023 11:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjJBPjQ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Oct 2023 11:39:16 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC2B8;
        Mon,  2 Oct 2023 08:39:13 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d81afd5273eso18231359276.3;
        Mon, 02 Oct 2023 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696261153; x=1696865953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRvyABZPczFSZcoyIQXVdYUk+Ea3zUQJXaiYFDP+fxg=;
        b=JZtsgrLlHQOuijahodzMGHn0edbn9Sl5yoFxnEJZKV/jEW3i9mNox1IbwLsVLYv7Sx
         rZo4q4tvSCSaU/yHryat45AAeCznftaUP2/2nrsB2U1H98AfUM/CGPavBg+bjKDG2eXM
         8w1T8Hi/JQrjjdVJ3s0mWXfIIqoXNBhKK6BANuKsiBF9pHQZczts73nhKiLpZ+cA8Trf
         uKkQusK/nDQGqpErwqWxSOwunywwjLpM7fCtimNj9QcwotpIlMc/G3+SDapchZzfODUO
         Wm7fMLDYBb1htIi4edu+EAFZ8W6Yhh3hIhzGmBQZhB3WTGKfffQvkppXcRIo/t0Nan9z
         4mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696261153; x=1696865953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRvyABZPczFSZcoyIQXVdYUk+Ea3zUQJXaiYFDP+fxg=;
        b=kHjbyRQAHdrv7WuOaGbSyHd6mDD3StjH4Tso6gYudY77ni2RGQRmFKXQxMhv80XmU6
         1e5Gyo6LZyIk1DBXPgK6RQ2sYqpmQUjDGdcHgMYdzyICvdZzqKW5oL1u9wRkpnZubbgR
         KfJPkoYLs2xOyu7jvjpFbJxEDJeb7FcgrycygK4X0lvq8JR1CbUYKLeqRkPUNu2JtdSD
         vv0uIx46TQd8T0eGmsIurqymbaAQviSFdKvmHRsx38zMB10ARsoSnocA1Ndu0LG0729+
         aLs3VVLMXgkphQqYwK3nKASHXz+bidJp6+oxIMY1hqdNhB4WREEvt/R6/8xcpHjowBAB
         0AWQ==
X-Gm-Message-State: AOJu0YxErg3in8ZEq6U4A998QxFyg3wx9AnFeNllAEa+X+/VHP4vrWlt
        cJjjX+BtqaY0RbgRqzKkf77bUlqDtrUD+Nx4TF3u8UGwDJo=
X-Google-Smtp-Source: AGHT+IENydjMyeuzCrBdfZZdIWXIq+qgMNkij+CGVTp3pEgELoZL1wECHCLiTSbOsANLl93q/9hcAHROcfpHxEwxjOk=
X-Received: by 2002:a5b:143:0:b0:d81:87d9:6ad0 with SMTP id
 c3-20020a5b0143000000b00d8187d96ad0mr10004726ybp.28.1696261152737; Mon, 02
 Oct 2023 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <CADvbK_fE2KGLtqBxFUVikrCxkRjG_eodeHjRuMGWU=og_qk9_A@mail.gmail.com> <20231002151808.GD30843@breakpoint.cc>
In-Reply-To: <20231002151808.GD30843@breakpoint.cc>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 2 Oct 2023 11:39:01 -0400
Message-ID: <CADvbK_edFWwc3JGyyexCw+vKbpKsbftRDZD34sjRXCCWtGYLYg@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
To:     Florian Westphal <fw@strlen.de>
Cc:     network dev <netdev@vger.kernel.org>,
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

On Mon, Oct 2, 2023 at 11:18=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
> > a reproducer is attached.
> >
> > Thanks.
>
> Do you think its worth it to turn this into a selftest?
I think so, it's a typical SCTP collision scenario, if it's okay to you
I'd like to add this to:

tools/testing/selftests/netfilter/conntrack_sctp_collision.sh

should I repost this netfilter patch together with this selftest or I
can post this selftest later?

Thanks.
