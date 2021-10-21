Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAC4366CE
	for <lists+linux-sctp@lfdr.de>; Thu, 21 Oct 2021 17:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJUPys (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 21 Oct 2021 11:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231777AbhJUPyr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 21 Oct 2021 11:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7h6CP1iZoH++rJfQu43toMYIm9p0CArXFcUD4a+mt4=;
        b=jKFZl/Y+hNkDTmpKFjJ5IYKwHRlR5bKwP0YLbmQQhaykrAM+TgLMkDwKxjHV7WfQZXseWb
        bfp5Hn9bSbnnzNnqYZs+ceUmUwLcdvfjwWprMTS2x5pH4lGLhIW2XDgbCNpprqFteD1kuP
        /5dMkh5WosD/YwowmmzcZl9AiI5FV5A=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-L0cLTOF_OKCnxbcstC4RJw-1; Thu, 21 Oct 2021 11:52:28 -0400
X-MC-Unique: L0cLTOF_OKCnxbcstC4RJw-1
Received: by mail-yb1-f198.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso102876ybr.19
        for <linux-sctp@vger.kernel.org>; Thu, 21 Oct 2021 08:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7h6CP1iZoH++rJfQu43toMYIm9p0CArXFcUD4a+mt4=;
        b=cesS4z6SkMSQbiTiE4uQMqRri013jRxjip0fYFuqSTyzDqZIZC1xDROXuu6a12mvTD
         loWI3gp1fQkRzyzF08AGluIgSUJJMzgtYVyfWn82siDix0WdmIvDseT5jXk/2cuW62I/
         SQsYYiQxXxA8ILTDNCOTncg4OQdt7u7ktskxxANf744Cc5m/ud9bu8J6/v2d9ykoCKKW
         rxeVBtY5213OUDk5QJI6lw8qnH6l5UVk4jnmsutH/BeVcL/4vJYI5ZmURBqryq2wZjgX
         BxAuQ2cjiUs3+cOsJca2n/qeikvU/HMava5GMBV6OsrHOvP1h7jClX7uAYwk2+dHlQuA
         Dxhw==
X-Gm-Message-State: AOAM533xESSErvXGxjTXaKZgTAHgBtMoCnEn4zLejGbSVqQ7Vz3YVItZ
        CCk56Py8x+XJDO1/TUcmjeZDrskGt5ksVYmxwU8pxT1dx71gBeZ78wMWPCgVEWxbAD3ejoN4N4m
        +xBkZXaEAIIfCtmDKGOuZCGTu0z4M+MBAB+oYpA==
X-Received: by 2002:a25:2e01:: with SMTP id u1mr6673480ybu.363.1634831547745;
        Thu, 21 Oct 2021 08:52:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy27uUID+lLlBiqKHvlEE6KxfKgN8yPdWQOxRRSfT9oJQpKzm3Ac+QRvUgdxZBvXZjmtDOmQxN9XUlcv0jiejM=
X-Received: by 2002:a25:2e01:: with SMTP id u1mr6673450ybu.363.1634831547455;
 Thu, 21 Oct 2021 08:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211021153846.745289-1-omosnace@redhat.com>
In-Reply-To: <20211021153846.745289-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 Oct 2021 17:52:16 +0200
Message-ID: <CAFqZXNs6xPm-2FU=2mSqMSCivmjP-mDcnGf+FB7tqY1-H=GPgg@mail.gmail.com>
Subject: Re: [PATCH] sctp: initialize endpoint LSM labels also on the client side
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Oct 21, 2021 at 5:38 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The secid* fields in struct sctp_endpoint are used to initialize the
> labels of a peeloff socket created from the given association. Currently
> they are initialized properly when a new association is created on the
> server side (upon receiving an INIT packet), but not on the client side.
>
> As a result, when the client obtains a peeloff socket via
> sctp_peeloff(3) under SELinux, it ends up unlabeled, leading to
> unexpected denials.
>
> Fix this by calling the security_sctp_assoc_request() hook also upon
> receiving a valid INIT-ACK response from the server, so that the
> endpoint labels are properly initialized also on the client side.
>
> Fixes: 2277c7cd75e3 ("sctp: Add LSM hooks")
> Cc: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/net/sctp/structs.h | 11 ++++++-----
>  net/sctp/sm_statefuns.c    |  5 +++++
>  2 files changed, 11 insertions(+), 5 deletions(-)

See also the selinux-testsuite [1] patch [2] that verifies this fix
(i.e. the new tests fail without this patch and pass with it). Not
being very familiar with SCTP, I'm not 100% sure if this fix is
correct or complete, so reviews are very much welcome.

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/

>
> diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
> index 651bba654d77..033a955592dd 100644
> --- a/include/net/sctp/structs.h
> +++ b/include/net/sctp/structs.h
> @@ -1356,11 +1356,12 @@ struct sctp_endpoint {
>
>         __u8  strreset_enable;
>
> -       /* Security identifiers from incoming (INIT). These are set by
> -        * security_sctp_assoc_request(). These will only be used by
> -        * SCTP TCP type sockets and peeled off connections as they
> -        * cause a new socket to be generated. security_sctp_sk_clone()
> -        * will then plug these into the new socket.
> +       /* Security identifiers from incoming (INIT/INIT-ACK). These
> +        * are set by security_sctp_assoc_request(). These will only
> +        * be used by SCTP TCP type sockets and peeled off connections
> +        * as they cause a new socket to be generated.
> +        * security_sctp_sk_clone() will then plug these into the new
> +        * socket.
>          */
>
>         u32 secid;
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 32df65f68c12..cb291c7f5fb7 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -521,6 +521,11 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
>         if (!sctp_vtag_verify(chunk, asoc))
>                 return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
>
> +       /* Update socket peer label if first association. */
> +       if (security_sctp_assoc_request((struct sctp_endpoint *)ep,
> +                                       chunk->skb))
> +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
> +
>         /* 6.10 Bundling
>          * An endpoint MUST NOT bundle INIT, INIT ACK or
>          * SHUTDOWN COMPLETE with any other chunks.
> --
> 2.31.1
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

