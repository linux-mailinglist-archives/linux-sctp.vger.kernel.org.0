Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D58697842
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Feb 2023 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjBOIee (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 15 Feb 2023 03:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjBOIec (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 15 Feb 2023 03:34:32 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403FB2DE45
        for <linux-sctp@vger.kernel.org>; Wed, 15 Feb 2023 00:34:28 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-52f0001ff8eso151553047b3.4
        for <linux-sctp@vger.kernel.org>; Wed, 15 Feb 2023 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ0Tbl1JRT8TpgT4ciKif/L2O/2dnKFAn9OEhwx1LKY=;
        b=dnoSQwsXcuOdAmTUN4n1Z54s5MXVwmWD46iY4LYXeF8GleCpym/rek4aZ46EJGOCC2
         tpJxYjOaaZo3I3Yg0xJXhInDJvR3VZjVDroIeQkfef44/m6IcE4SQj6pbzu9T7hZLJCl
         ctkZXBBVNfcSoaL0yIEc/LtxOg4wLolJ5BdMo63+PjZvA523LQEYrWJNEXij7EkoyZPX
         PdNVwOi4S2Lc3ftHXMg/DA5Cq6CQ25vtps2uDSvPMnUTLQ20DMT+osd0CRtv3JYBd2nw
         rNjNv44Kdjf0F5BzTp3GnjT003QXTijAcb4Ecw8D/Otv0QXnzBtX3UB9pj/T8HXGonvO
         SruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZ0Tbl1JRT8TpgT4ciKif/L2O/2dnKFAn9OEhwx1LKY=;
        b=1U9xRNfB2Rs+PnnFaoW5RzgdLpDDReNmCEc+LlOsL472ZQ/ZAAR+XINI3FynrCx26i
         W9JsLc0xUsnPYR+Rc7KYp129QcVi117sFhZ+5fHT9zymYjvpbhp/zGFfNv4BjNcLCLsV
         tARK76rHBDvpV38UqBUOiQhKI6oPywHnKvt20PnK4fegxWsWHpKqyU8qX6lfikC32FrK
         8gdi7dbuM5mtkBF7EPqX5NJ1/1E4ZLn7EFlUNK6I/HZD1QvS85+RG2f69iopbIXvnnK1
         VmNkDQenXJBtPBowFJ+lFyY68OScPdVNFGBfdshmV4ykLBxAp2DKl2neRbHKWpFbPucc
         iFRw==
X-Gm-Message-State: AO0yUKWwgPXDP1tNY15XbH6xrj1CP3YA/AqIVV08oKw8Hg/+IvdZMmD9
        mkBKwI58Wtrig9YJbAGKurWEvWxugnKlgsH61EqrVA==
X-Google-Smtp-Source: AK7set8ljnu+GwuUQ4bAj4hFoVW4I2+uuhh7kwq1uoEl9VQWYBAHdwy47c4ncQV8gkQG7WYcehVwSf5DBTwi77UFuEo=
X-Received: by 2002:a25:ad93:0:b0:8bd:d8e7:aace with SMTP id
 z19-20020a25ad93000000b008bdd8e7aacemr173772ybi.549.1676450067211; Wed, 15
 Feb 2023 00:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20230214041410.6295-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230214041410.6295-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 15 Feb 2023 09:34:16 +0100
Message-ID: <CANn89iLq+_0ooWU52Y8cqk=JyrYo89_4TKW4BQ3P0+naYr+z_w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: no longer support SOCK_REFCNT_DEBUG feature
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     kuniyu@amazon.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org,
        matthieu.baerts@tessares.net, willemdebruijn.kernel@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sctp@vger.kernel.org, mptcp@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Feb 14, 2023 at 5:15 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Commit e48c414ee61f ("[INET]: Generalise the TCP sock ID lookup routines")
> commented out the definition of SOCK_REFCNT_DEBUG in 2005 and later another
> commit 463c84b97f24 ("[NET]: Introduce inet_connection_sock") removed it.
> Since we could track all of them through bpf and kprobe related tools
> and the feature could print loads of information which might not be
> that helpful even under a little bit pressure, the whole feature which
> has been inactive for many years is no longer supported.
>
> Link: https://lore.kernel.org/lkml/20230211065153.54116-1-kerneljasonxing@gmail.com/
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>
