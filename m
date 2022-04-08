Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748304F9BC1
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Apr 2022 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiDHRgM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Apr 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiDHRgL (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Apr 2022 13:36:11 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6D1EAE0
        for <linux-sctp@vger.kernel.org>; Fri,  8 Apr 2022 10:34:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t21so9497777oie.11
        for <linux-sctp@vger.kernel.org>; Fri, 08 Apr 2022 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFjWoApz0UztoJCdhlYcRubg04qOOzzDBrTBaHLd63U=;
        b=K3uEi0LtGb2Tatn4hICtUi54xFZiOax4luKt5U3yVXZcOTNs/48IMjMxP+mnKrmVmf
         aM2uEi/3+mdrUKRmG1jmeo+F5CXRHaolJS3EwbSNtbBRHMcua0uaIjS68nPVP6eIPBkr
         a8xb5SnjaRnDxAZxH6YhmXfYppcB5V+iUTD1+ZDi79dlk023USFjEcp7erMC5ratPIZZ
         BltG436gIzoLmUJ2TWVEpA6wW42sSwVbwJTyts4YXM23ct3p+5b5kNsDwRV1Bgw0bN7s
         NHshsj3moa5dmJQzj1L9pMz9MCpyOEuCcXOKTzlyLpPGEBOGFnhBOuX+QCWa/GHdhwNj
         FL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFjWoApz0UztoJCdhlYcRubg04qOOzzDBrTBaHLd63U=;
        b=zg9Z4h+JUlG63qyeCNzIN5c4mGojsE2jaKKmLxhiwPRNIiZW6+XkYGd/j/EuLrx3MT
         1pThCV8a6OjnXbJaVNY4LegQY/7BK5SaI7YLyrHQOLdVyvj+ihQw8sE8ssyuZn2fn0sw
         2465DqW8UjNZoCfGifjkdqzla0d0Ws/CXiBP/p3C8uEV2i2Y1HRsqvrTOd/LvzlnwYtO
         exM7dEf1e6DaNf5Z68gNnZhnCdo2JLMwtYRyh0EPByE9E7C0OfmxK6c9EvkjHHrkc/Xo
         JrguAQlH+FruYvql3AgRkcYbAW5Eke8HSm6NnAFN4xtAgbwfPqLqFJL7LSy9TyYZVQMT
         idqw==
X-Gm-Message-State: AOAM531U+X4t2oY2PO/M5OgoZHu0fViTFBlpcvgjbmhImdeWuJ8/ad44
        nuYdIR2rktM524KG5XUEBQoflsBM/+E=
X-Google-Smtp-Source: ABdhPJw7qGbf+GQbzWEMmUfqRwXRLDUHu/sMf2yYclpTMcAzQ4j/+wPd/ldNsmHn63PTIEee5t/FDA==
X-Received: by 2002:a05:6808:1526:b0:2ec:f5ea:39a7 with SMTP id u38-20020a056808152600b002ecf5ea39a7mr414348oiw.175.1649439247096;
        Fri, 08 Apr 2022 10:34:07 -0700 (PDT)
Received: from t14s.localdomain ([2001:1284:f016:143b:c097:5c23:9732:767c])
        by smtp.gmail.com with ESMTPSA id j12-20020a9d190c000000b005e6c6bf4db5sm694008ota.34.2022.04.08.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:34:06 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 238E31DFDD0; Fri,  8 Apr 2022 14:34:05 -0300 (-03)
Date:   Fri, 8 Apr 2022 14:34:05 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2] sctp: Initialize daddr on peeled off socket
Message-ID: <YlByDe3YttU5K8dU@t14s.localdomain>
References: <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20220307220220.652293-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307220220.652293-1-oss@malat.biz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Mar 07, 2022 at 11:02:21PM +0100, Petr Malat wrote:
> Function sctp_do_peeloff() wrongly initializes daddr of the original
> socket instead of the peeled off socket, which makes getpeername()
> return zeroes instead of the primary address. Initialize the new socket
> instead.
> 
> Fixes: d570ee490fb1 ("[SCTP]: Correctly set daddr for IPv6 sockets during peeloff")
> Signed-off-by: Petr Malat <oss@malat.biz>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

You need to re-post it to netdev@, btw, but please feel free to carry
the tag above on it.

> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 3e1a9600be5e..7b0427658056 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -5636,7 +5636,7 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
>  	 * Set the daddr and initialize id to something more random and also
>  	 * copy over any ip options.
>  	 */
> -	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sk);
> +	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
>  	sp->pf->copy_ip_options(sk, sock->sk);
>  
>  	/* Populate the fields of the newsk from the oldsk and migrate the
> -- 
> 2.30.2
> 
