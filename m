Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C84D3271
	for <lists+linux-sctp@lfdr.de>; Thu, 10 Oct 2019 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfJJUeX (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 10 Oct 2019 16:34:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39146 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJJUeX (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 10 Oct 2019 16:34:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so4635141pff.6
        for <linux-sctp@vger.kernel.org>; Thu, 10 Oct 2019 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qLN+ZaDKXKKqy42TKsmx8NFeuacgz7hdpKcKP23ADmI=;
        b=a8/BUQSRa5fAL7ua30472Y4U7kNqLVO+XHaBB/Rc2wmWKE9Xj04D00RKSoqyZUda8p
         AoN69CT8wMJ2+8+9xP0hKg/fExhxNp8lM/hqppiZ2eSLtMQm6/uYroSxKlTzitdKEuQz
         TwEci32h62j6hKZzmDlEOn92Ch+77FD0Fd8R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qLN+ZaDKXKKqy42TKsmx8NFeuacgz7hdpKcKP23ADmI=;
        b=UZkeOZoZ8Gq0/rCYlaTgkVZqYTY5tTR115Juytu0XQ1LWpWw4wZyLmKqde2bS0OUOS
         EMHM6NOQLxZ6SrW1e/9sCXw/BWWW/XQMXlO3aw03CXTVjDGn1ANqlIcK2a/Ls6nyVvie
         YEmrjl2WUWPbLMNMkUmb1aij4FAsOeddZSnq6OCv24Enh58Z8z2U/fvbzu2J7yAnZlNI
         jiEj+iVlJQwq4Z66K6DV7heylTzUh5ugM/AnjyvwgcB1hoO48TTdpPQqkScWIU0UvQ3P
         7CFws0SzLOSW72wNkcGS6cu0CEhNWSnCt+QuNt+ByYcMJ0coTMdCkgghIY+BMbju/7Cw
         JJQA==
X-Gm-Message-State: APjAAAXSzf/XEJhbCj2LLjsMd+3UjF06eAwyKxqL4Xqcc4DLKkr21u0o
        4JPBgh989CBID2hDjhg3meyN1A==
X-Google-Smtp-Source: APXvYqwEu3drJD2Rf13atiZCcuDu9mkLKlc6Z2P3wFQoHl4Ae6+HQ4EAmBu1c73yaqSQEBRghQ4ujA==
X-Received: by 2002:a63:311:: with SMTP id 17mr12928079pgd.327.1570739662653;
        Thu, 10 Oct 2019 13:34:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm5965017pfp.67.2019.10.10.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:34:21 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:34:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux@googlegroups.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] net: sctp: Rename fallthrough label to unhandled
Message-ID: <201910101334.22271AB@keescook>
References: <cover.1570292505.git.joe@perches.com>
 <2e0111756153d81d77248bc8356bac78925923dc.1570292505.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0111756153d81d77248bc8356bac78925923dc.1570292505.git.joe@perches.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Oct 05, 2019 at 09:46:41AM -0700, Joe Perches wrote:
> fallthrough may become a pseudo reserved keyword so this only use of
> fallthrough is better renamed to allow it.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  net/sctp/sm_make_chunk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index e41ed2e0ae7d..48d63956a68c 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2155,7 +2155,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>  	case SCTP_PARAM_SET_PRIMARY:
>  		if (ep->asconf_enable)
>  			break;
> -		goto fallthrough;
> +		goto unhandled;
>  
>  	case SCTP_PARAM_HOST_NAME_ADDRESS:
>  		/* Tell the peer, we won't support this param.  */
> @@ -2166,11 +2166,11 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>  	case SCTP_PARAM_FWD_TSN_SUPPORT:
>  		if (ep->prsctp_enable)
>  			break;
> -		goto fallthrough;
> +		goto unhandled;
>  
>  	case SCTP_PARAM_RANDOM:
>  		if (!ep->auth_enable)
> -			goto fallthrough;
> +			goto unhandled;
>  
>  		/* SCTP-AUTH: Secion 6.1
>  		 * If the random number is not 32 byte long the association
> @@ -2187,7 +2187,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>  
>  	case SCTP_PARAM_CHUNKS:
>  		if (!ep->auth_enable)
> -			goto fallthrough;
> +			goto unhandled;
>  
>  		/* SCTP-AUTH: Section 3.2
>  		 * The CHUNKS parameter MUST be included once in the INIT or
> @@ -2203,7 +2203,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>  
>  	case SCTP_PARAM_HMAC_ALGO:
>  		if (!ep->auth_enable)
> -			goto fallthrough;
> +			goto unhandled;
>  
>  		hmacs = (struct sctp_hmac_algo_param *)param.p;
>  		n_elt = (ntohs(param.p->length) -
> @@ -2226,7 +2226,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>  			retval = SCTP_IERROR_ABORT;
>  		}
>  		break;
> -fallthrough:
> +unhandled:
>  	default:
>  		pr_debug("%s: unrecognized param:%d for chunk:%d\n",
>  			 __func__, ntohs(param.p->type), cid);
> -- 
> 2.15.0
> 

-- 
Kees Cook
