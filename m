Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C8653D6B
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Dec 2022 10:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiLVJXS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 22 Dec 2022 04:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVJXS (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 22 Dec 2022 04:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492FB1D7
        for <linux-sctp@vger.kernel.org>; Thu, 22 Dec 2022 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671700951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKaTi4+rwFLmrmyaDkBv4CqTil1Gw+F5+6xdhW+tfX8=;
        b=E8Nv0tN4wu06FFLhWAqm+DMKynRTfwJtJqKvZK03rHWS9d/o/I6LZHOj77sjdrUabxugD/
        58mK5A2QcV3ldvuzw1ktOx3g6R19JKUdwcjHJ5HUOQPDe+/v5n3Wl2umo30R4FwxeiAT74
        PVqP9WAfkNR5wTZ9jKsrki4mMhs0PTk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-uAvaUTwPO9e562o9s-N2Rw-1; Thu, 22 Dec 2022 04:22:28 -0500
X-MC-Unique: uAvaUTwPO9e562o9s-N2Rw-1
Received: by mail-wr1-f69.google.com with SMTP id n12-20020adf8b0c000000b0025d56d58653so237947wra.8
        for <linux-sctp@vger.kernel.org>; Thu, 22 Dec 2022 01:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKaTi4+rwFLmrmyaDkBv4CqTil1Gw+F5+6xdhW+tfX8=;
        b=1r5ehBv2V4GG1Ym5ZGCgJLsr4laoFlTnQbDUYr1MloAZkdkgLdLVJQ4zpR6yZbC6bc
         eUyTWKt3LuCMo2pcDnaX0vpD02431Ri64CGYtLtWjrOFuqSsGvr1KeCkxWqPxeGvM2aj
         xFA9LsTN6jIsEXcLsdRjX1n73LTxMp4KhknVRMlIgIOgCCrM5weWTwx/XAk5ezP2P6L2
         4ND2ufIOtpbS6mk6V3p79yubn4o/EaaZhKDikjnPl0X8shak7DAY0tlXZ3HwYl8Id/Sd
         W2xB7HK/N7Gu9SnRo6BGBtka7afOBXE8QYCPFyRM0k6EftDG/5oQQcok/VCDYl14ehV6
         rOsg==
X-Gm-Message-State: AFqh2kqskVk2bUkPXfNYsV0KnWeYnmvbl/Etvxz8iw8fZIG14M4txE+K
        ZX1KZOgTZCJveaU6BbJSNvQnvsuNIBJhEq+IipIjizSaEFVenVTHxb9EolQM0rwJe/nscP8huJ7
        ILzS+DiIjZvLmrquesQIzQA==
X-Received: by 2002:a5d:5268:0:b0:242:3fb4:1cb with SMTP id l8-20020a5d5268000000b002423fb401cbmr3074062wrc.43.1671700947313;
        Thu, 22 Dec 2022 01:22:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuqAV7j5VUJKiku3Oywgow89RKAM1M6mZZ+ql2pwNX/SgfVOdd/7R7TsBiSnZHH+sMEOR8ClA==
X-Received: by 2002:a5d:5268:0:b0:242:3fb4:1cb with SMTP id l8-20020a5d5268000000b002423fb401cbmr3074052wrc.43.1671700947094;
        Thu, 22 Dec 2022 01:22:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm17743533wrg.104.2022.12.22.01.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 01:22:26 -0800 (PST)
Message-ID: <6209669358d038b30e5fe20ba571f93241b5248d.camel@redhat.com>
Subject: Re: [PATCH] sctp: Make sha1 as default algorithm if fips is enabled
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ashwin Dayanand Kamat <kashwindayan@vmware.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     srivatsab@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, akaher@vmware.com
Date:   Thu, 22 Dec 2022 10:22:24 +0100
In-Reply-To: <1671513037-8958-1-git-send-email-kashwindayan@vmware.com>
References: <1671513037-8958-1-git-send-email-kashwindayan@vmware.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 2022-12-20 at 10:40 +0530, Ashwin Dayanand Kamat wrote:
> MD5 is not FIPS compliant. But still md5 was used as the default algorithm
> for sctp if fips was enabled.
> Due to this, listen() system call in ltp tests was failing for sctp
> in fips environment, with below error message.
> 
> [ 6397.892677] sctp: failed to load transform for md5: -2
> 
> Fix is to not assign md5 as default algorithm for sctp
> if fips_enabled is true. Instead make sha1 as default algorithm.
> 
> Signed-off-by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>

I don't know the fips standard in details, but it feel strange that you
get fips compliance _disabling_ the encryption. Can you please point
which part of the standard states it?

Since this is fix, you should also provide a suitable fixes tag. When
you will repost additionally include the target tree name (net) into
the subject, thanks!

> ---
>  net/sctp/protocol.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 909a89a..b6e9810 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -34,6 +34,7 @@
>  #include <linux/memblock.h>
>  #include <linux/highmem.h>
>  #include <linux/slab.h>
> +#include <linux/fips.h>
>  #include <net/net_namespace.h>
>  #include <net/protocol.h>
>  #include <net/ip.h>
> @@ -1321,14 +1322,13 @@ static int __net_init sctp_defaults_init(struct net *net)
>  	/* Whether Cookie Preservative is enabled(1) or not(0) */
>  	net->sctp.cookie_preserve_enable 	= 1;
>  
> -	/* Default sctp sockets to use md5 as their hmac alg */
> -#if defined (CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5)
> -	net->sctp.sctp_hmac_alg			= "md5";
> -#elif defined (CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1)
> -	net->sctp.sctp_hmac_alg			= "sha1";
> -#else
> -	net->sctp.sctp_hmac_alg			= NULL;
> -#endif
> +	/* Default sctp sockets to use md5 as default only if fips is not enabled */
> +	if (!fips_enabled && IS_ENABLED(CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5))
> +		net->sctp.sctp_hmac_alg = "md5";
> +	else if (IS_ENABLED(CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1))
> +		net->sctp.sctp_hmac_alg = "sha1";
> +	else
> +		net->sctp.sctp_hmac_alg = NULL;

It looks like the listener can still fail if fips mode is enabled after
that the netns is initialized. I think it would be better to take
action in sctp_listen_start() and buming a ratelimited notice the
selected hmac is changed due to fips.

Thanks,

Paolo

>  
>  	/* Max.Burst		    - 4 */
>  	net->sctp.max_burst			= SCTP_DEFAULT_MAX_BURST;

