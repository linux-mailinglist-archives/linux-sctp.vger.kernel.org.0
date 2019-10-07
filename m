Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D70CEB78
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Oct 2019 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfJGSI7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 7 Oct 2019 14:08:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33445 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSI6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 7 Oct 2019 14:08:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so7262392pls.0
        for <linux-sctp@vger.kernel.org>; Mon, 07 Oct 2019 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwC6F2GJvmhpWHGCr7xF/n4f6KLR7+2yf2OOH5GEsgU=;
        b=uRm/bFYPsstoaYyKukSFhdRLDpzni7itu2EEZfLPwBlxu+qsX3FN7N7lVTsrFB6a6K
         vt7+5nD3qCBr++/ITUQKwWu6K1dnnVKEt8by7hgTzUOMuW8aSJmqfpxVW8GC6fnd69ap
         1pnD3I89VMIFfNvvpwCzdpEh/qO1Od6mzoyPAlHrefC1wGCje/aK5MwPIXZ6chgkFXhK
         KsuQVX0urhlgK8mFNDKZcv7vS+scCHKzOFH+oTcfTWojqCVkR+D+/dCzZmS4njEVH2Bl
         PtJO3eKNJwpLPfTs5A30TwFHfGYk+h+QE5LMOVXSkqZiGpYH1O9FH2LEOwp4700pX9OZ
         2g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwC6F2GJvmhpWHGCr7xF/n4f6KLR7+2yf2OOH5GEsgU=;
        b=QKsvBU+nefyw5eMA/AQD1IKwkPr/h6U6t2bKT1GVAwVcX8y1/T8aQu0bPXpVgn+j8a
         RpEU/P6oFbGpPBqW1mw/SyYgqcZ5S7xjmg8T25IvNotv6YAAjW/R2KqkmNYfPNQBvTY7
         0IiY1FZLeqwxIjO44cMfa0hDJjCF8NafvSrPUbNycix76sL0lbcc2zi5oqrEYwm4Rp29
         rIXviQuVhgoBS6FsruzP7E5wmXeIsHw4bBSVRYl+vijqZEVvoXV84LOWRrqHDrgOhbjW
         LjKS7pXlHptDVkVhbGXjtM2PA8Hsz27+unfrkXaXX08EEidkF2UBSM1auXmKSnbT/5Nj
         vAWw==
X-Gm-Message-State: APjAAAUxsDJoUAyPLYUIvw5zK8umApH1/PTjjhd3Nf/m5HPw/8TrbrzE
        4jYcUPMI1ANrnk6Lf31VX0DOWvDR3pT2IWWiyxu1dw==
X-Google-Smtp-Source: APXvYqzOl3JXsj4sTtvjvilp+o9GzSCOZkl0A9M3zcxvheER0viyb3/IMPpVI+XWTbKtuhaCp0QRNTl7H6IBggmcCXE=
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr29403977pll.119.1570471736235;
 Mon, 07 Oct 2019 11:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <2e0111756153d81d77248bc8356bac78925923dc.1570292505.git.joe@perches.com>
In-Reply-To: <2e0111756153d81d77248bc8356bac78925923dc.1570292505.git.joe@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 11:08:45 -0700
Message-ID: <CAKwvOdmtfUfpGhKODa=UBtq7AKDaJa9cndf7fkjJw1R37SsR6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: sctp: Rename fallthrough label to unhandled
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
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
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-sctp@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Oct 5, 2019 at 9:46 AM Joe Perches <joe@perches.com> wrote:
>
> fallthrough may become a pseudo reserved keyword so this only use of
> fallthrough is better renamed to allow it.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  net/sctp/sm_make_chunk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index e41ed2e0ae7d..48d63956a68c 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2155,7 +2155,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>         case SCTP_PARAM_SET_PRIMARY:
>                 if (ep->asconf_enable)
>                         break;
> -               goto fallthrough;
> +               goto unhandled;
>
>         case SCTP_PARAM_HOST_NAME_ADDRESS:
>                 /* Tell the peer, we won't support this param.  */
> @@ -2166,11 +2166,11 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>         case SCTP_PARAM_FWD_TSN_SUPPORT:
>                 if (ep->prsctp_enable)
>                         break;
> -               goto fallthrough;
> +               goto unhandled;
>
>         case SCTP_PARAM_RANDOM:
>                 if (!ep->auth_enable)
> -                       goto fallthrough;
> +                       goto unhandled;
>
>                 /* SCTP-AUTH: Secion 6.1
>                  * If the random number is not 32 byte long the association
> @@ -2187,7 +2187,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>
>         case SCTP_PARAM_CHUNKS:
>                 if (!ep->auth_enable)
> -                       goto fallthrough;
> +                       goto unhandled;
>
>                 /* SCTP-AUTH: Section 3.2
>                  * The CHUNKS parameter MUST be included once in the INIT or
> @@ -2203,7 +2203,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>
>         case SCTP_PARAM_HMAC_ALGO:
>                 if (!ep->auth_enable)
> -                       goto fallthrough;
> +                       goto unhandled;
>
>                 hmacs = (struct sctp_hmac_algo_param *)param.p;
>                 n_elt = (ntohs(param.p->length) -
> @@ -2226,7 +2226,7 @@ static enum sctp_ierror sctp_verify_param(struct net *net,
>                         retval = SCTP_IERROR_ABORT;
>                 }
>                 break;
> -fallthrough:
> +unhandled:
>         default:

Interesting control flow (goto from one case to the default case, not
sure "fallthrough" was ever the right word for that).  Thanks for the
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                 pr_debug("%s: unrecognized param:%d for chunk:%d\n",
>                          __func__, ntohs(param.p->type), cid);
> --
> 2.15.0
>


-- 
Thanks,
~Nick Desaulniers
