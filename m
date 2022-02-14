Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94624B5D84
	for <lists+linux-sctp@lfdr.de>; Mon, 14 Feb 2022 23:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiBNWOb (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 14 Feb 2022 17:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiBNWO2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 14 Feb 2022 17:14:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D958F13DE24
        for <linux-sctp@vger.kernel.org>; Mon, 14 Feb 2022 14:14:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so40244115ejc.7
        for <linux-sctp@vger.kernel.org>; Mon, 14 Feb 2022 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0Er9PU0s586qqj351/Wl2YCEXP6TU1XLfq7ouOmNCA=;
        b=6SKs+0iAcbrRFKimrSzd538mPpXpjsh/geHE/Cl38q5kPBC6B8qUaPJ643a+KN7xV/
         EmFK3EegJYYkNhAP1fQjORjLNY6EmzkrPYjfBt5EQX2630aZWSQsWPabLs/z295meZj8
         qnG108hQG2twJbLv+FzL/ikyPx4nFUNB/w7SOXmm9YcaVNY5NS3ZS9iFmKxGxcGhjQvi
         uEemueEO3wiycNTs6RQ4KBIs7QH3DGud2jH9H+yO+h7ibwbRFGYk6YcxKuq5fbXcff1O
         blM9h5Eyv8YYSJl7oFdKS6EAecfSzWcW/pPvlL65HvsZ5nfb4gHNqqvNqMZ/1XwdFlxG
         s3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0Er9PU0s586qqj351/Wl2YCEXP6TU1XLfq7ouOmNCA=;
        b=EGDBkow46xV1qNF7GHGU/AufZGlMR8b5UcoxMnQg+uyuZAC6HqVp2yC4laN2o4/69B
         +8XIlgx7cYfb+wv13pG03B96PlO1q1cXgVJrMltWcmXOGG96zgdeD15s/GTMAhIIg07G
         7sWMUruiRtF9EiX03/ZHTTfyZabo9wztxdvYyTDqr8ugAGYV+QnGTbx8M3f8xPuiCGL6
         l5L6ctSs/jCcuqukzry30LTAuj/lazoL/jluT71kc0iu8De9dLRfC34ABn3xGGmtQ+do
         00YRCERmg2uxmzzzzHnwFmvE4ETZyXzdJHVR/cIeyW17YAr3kreOuMm9MbLmFDW83ViQ
         se2A==
X-Gm-Message-State: AOAM533ejV5wOUG188fT2z3hq4TUa8kHMniQWdX0H7s3dJkO7KqRQ8Uk
        4Ej/hZ0P/vFObw3tQOhwisf+FTk1KsAJBhDd2YKL
X-Google-Smtp-Source: ABdhPJzGiYp5cTjKKRmNx3BZuObAKxt9Gb5NP26z94DZjO1BpJRUS4y8pzzpdn/2U4WR8IF+c4ZWQSr+9bBhHusaKEg=
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr718007ejc.112.1644876855348;
 Mon, 14 Feb 2022 14:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com> <20220212175922.665442-3-omosnace@redhat.com>
In-Reply-To: <20220212175922.665442-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Feb 2022 17:14:04 -0500
Message-ID: <CAHC9VhT90617FoqQJBCrDQ8gceVVA6a1h74h6T4ZOwNk6RVB3g@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] security: implement sctp_assoc_established
 hook in selinux
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        selinux@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prashanth Prahlad <pprahlad@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Feb 12, 2022 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Do this by extracting the peer labeling per-association logic from
> selinux_sctp_assoc_request() into a new helper
> selinux_sctp_process_new_assoc() and use this helper in both
> selinux_sctp_assoc_request() and selinux_sctp_assoc_established(). This
> ensures that the peer labeling behavior as documented in
> Documentation/security/SCTP.rst is applied both on the client and server
> side:
> """
> An SCTP socket will only have one peer label assigned to it. This will be
> assigned during the establishment of the first association. Any further
> associations on this socket will have their packet peer label compared to
> the sockets peer label, and only if they are different will the
> ``association`` permission be validated. This is validated by checking the
> socket peer sid against the received packets peer sid to determine whether
> the association should be allowed or denied.
> """
>
> At the same time, it also ensures that the peer label of the association
> is set to the correct value, such that if it is peeled off into a new
> socket, the socket's peer label  will then be set to the association's
> peer label, same as it already works on the server side.
>
> While selinux_inet_conn_established() (which we are replacing by
> selinux_sctp_assoc_established() for SCTP) only deals with assigning a
> peer label to the connection (socket), in case of SCTP we need to also
> copy the (local) socket label to the association, so that
> selinux_sctp_sk_clone() can then pick it up for the new socket in case
> of SCTP peeloff.
>
> Careful readers will notice that the selinux_sctp_process_new_assoc()
> helper also includes the "IPv4 packet received over an IPv6 socket"
> check, even though it hadn't been in selinux_sctp_assoc_request()
> before. While such check is not necessary in
> selinux_inet_conn_request() (because struct request_sock's family field
> is already set according to the skb's family), here it is needed, as we
> don't have request_sock and we take the initial family from the socket.
> In selinux_sctp_assoc_established() it is similarly needed as well (and
> also selinux_inet_conn_established() already has it).
>
> Fixes: 72e89f50084c ("security: Add support for SCTP security hooks")
> Reported-by: Prashanth Prahlad <pprahlad@redhat.com>
> Based-on-patch-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 90 +++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 24 deletions(-)

This patch, and patch 1/2, look good to me; I'm assuming this resolves
all of the known SELinux/SCTP problems identified before the new year?

If I can get an ACK from one of the SCTP and/or netdev folks I'll
merge this into the selinux/next branch.

-- 
paul-moore.com
