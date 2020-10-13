Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE228D30C
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Oct 2020 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgJMRUk (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 13 Oct 2020 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMRUi (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 13 Oct 2020 13:20:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459FC0613D0
        for <linux-sctp@vger.kernel.org>; Tue, 13 Oct 2020 10:20:37 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id r24so458454vsp.8
        for <linux-sctp@vger.kernel.org>; Tue, 13 Oct 2020 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q881i9ci2QuprURu2T3tf48Pqp0gc9MKpu5hxYilB+g=;
        b=eFQzsiuCFyYGjk1JsFCyldI6bQWERpHPtyXAng9JAdyEsVnbOu3O82ISh/bo44+iZg
         AwEiOw2ESU3v1QP/LeAscRyl9EMM3JuI5/qw2adwBkRw2l0c7iMYsOJH5Tav7fNdKjLi
         Q00NFqPf88MLgULgyRRf76fl5ve1dSmf55z/URd+YXEm9/TeCQ2sbcYXxK4Gk2be/ewy
         5NEjj3+Kumt+8xBoXVwboNjqAWkqN5fbm3fDVqBssOwKBcCD2x7XIzM1zIK3Dx4k2eWJ
         hrsj6rgYMYNCciUXEoZnxYKQnTfvThYWppuPJxaDUjjH3Iww2dRPwm5nigHyAeJqE8i+
         e+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q881i9ci2QuprURu2T3tf48Pqp0gc9MKpu5hxYilB+g=;
        b=LMfRMwg9PH6XVNZVD/D0by8KZtsxor6tXfgBxXTpjl2/zDwkfsRAuXc1Qol8ro9d+2
         BEoY+vU7kKluEntHkSqZXb9v8omgffpAYqIqsFWgTX3aLL4izp3pMe4q3qi0s0p9M6WD
         q0OQgqDbAIfAf1aIiQlb1ymelf5XmLQTS3fIi9GcGcAlHLdrxGE6kwhqHrx79R3+9N1Q
         f0t0oUzpxt1/eFUbD8ICp50eB36KZXNx7DuSP+jGa/8u+CaYRE625yoKLSDkeGjpJy28
         MrgiwrU0O5tndp9LlRTb4n1vAoCGCIE7ZLaZpkRIHlcbneoA+JOy3bTV+1tbesa3Kzhp
         yh+A==
X-Gm-Message-State: AOAM5317G/J2ZOHq1b3gJS7zDnj+kv++wPR7Dq9q6qJr4lce04lb1ylA
        0/2iSVNMkk5232tOAMdQ3T5hC/QLnfU=
X-Google-Smtp-Source: ABdhPJyYS81LRGyvrW7YfmwoIl8Tt4AYtkmXnLgwfxO1G7Sw+VhyNrJxUXAy7F8uU3QD8js00Md2Qg==
X-Received: by 2002:a05:6102:2e8:: with SMTP id j8mr1112125vsj.4.1602609635824;
        Tue, 13 Oct 2020 10:20:35 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 64sm81749vky.4.2020.10.13.10.20.33
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 10:20:34 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id b3so477473vsc.5
        for <linux-sctp@vger.kernel.org>; Tue, 13 Oct 2020 10:20:33 -0700 (PDT)
X-Received: by 2002:a67:fb96:: with SMTP id n22mr681911vsr.13.1602609633308;
 Tue, 13 Oct 2020 10:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602574012.git.lucien.xin@gmail.com> <fae9c57767447c4fd97476807b9e029e8fda607a.1602574012.git.lucien.xin@gmail.com>
 <c01a9a09096cb1b292d461aa5a1e72aae2ca942a.1602574012.git.lucien.xin@gmail.com>
In-Reply-To: <c01a9a09096cb1b292d461aa5a1e72aae2ca942a.1602574012.git.lucien.xin@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 13 Oct 2020 13:19:56 -0400
X-Gmail-Original-Message-ID: <CA+FuTSc1FRRZS8Yt0U7bt6M9Qjvi+xrQTefvMuOxF6=FL3dPPw@mail.gmail.com>
Message-ID: <CA+FuTSc1FRRZS8Yt0U7bt6M9Qjvi+xrQTefvMuOxF6=FL3dPPw@mail.gmail.com>
Subject: Re: [PATCHv3 net-next 02/16] udp6: move the mss check after udp gso
 tunnel processing
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Michael Tuexen <tuexen@fh-muenster.de>,
        David Miller <davem@davemloft.net>, gnault@redhat.com,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Oct 13, 2020 at 3:28 AM Xin Long <lucien.xin@gmail.com> wrote:
>
> For some protocol's gso, like SCTP, it's using GSO_BY_FRAGS for
> gso_size. When using UDP to encapsulate its packet, it will
> return error in udp6_ufo_fragment() as skb->len < gso_size,
> and it will never go to the gso tunnel processing.
>
> So we should move this check after udp gso tunnel processing,
> the same as udp4_ufo_fragment() does.
>
> v1->v2:
>   - no change.
> v2->v3:
>   - not do any cleanup.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks for revising
