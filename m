Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67BD4591
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Oct 2019 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfJKQi3 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 11 Oct 2019 12:38:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34880 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJKQi2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 11 Oct 2019 12:38:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so7502666lfl.2
        for <linux-sctp@vger.kernel.org>; Fri, 11 Oct 2019 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMiHtB5ZlwenoYg0oyx0g7MXemkZFkoKB6mCSzMxar0=;
        b=WvTdQO3PPBIwZwj1t370syw4bWNuRNNu5X9kUBY4nmpGylmSdsm9EeaCjpU7Vnv8Yx
         RIBTnDZKFaNEeN2w5TKDtE/axPzbYs2ol1oaGAlHshlDH+Wbx81Cy8oDxPhDJcEJ+mEJ
         6/WqNX914YOM138DOaNAdg7ENVxoQn93vF7Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMiHtB5ZlwenoYg0oyx0g7MXemkZFkoKB6mCSzMxar0=;
        b=sD182tjj9GvumD+j3jA45txTcbvpgIzAd0vSeES+ZuiHWAJ4jRs7P78dHjmnSjP5IH
         YSblUJeDz1snWzAbzWxAFG0AypM8MR+p9TS2TRvV+rcY9e+pclTnTBNvF6fwiA/cWVgZ
         j+At/B3hS6J6PRW+frLu958+++zQ1kYF4qraKuEJxnbXaOQieqc4pyd6inXM4Xn9Foe1
         137AzUzVLQPO0R7atmt2MyR9qvRCcWE6TUTT4+ERWLTwtOKQz91xDUsI9TGtc6B4Cg0+
         Hj59U8HSjgZUBl+bGY91F7O7MWe3Rgr6ZvARZGyrtNpnS9MhFX/biOIdF0G+qPFKPtco
         1DMA==
X-Gm-Message-State: APjAAAWAlrx2QQACKRVqhEAIleJldQbOgMEh34H5NCFW/DmqsO2kTaQc
        tpgnN0u19Ibcla2piHZaspLPwLX2xdg=
X-Google-Smtp-Source: APXvYqx2b0semmYTy/qkTwM3qdH7jMoXAF9n/ugXezZ5DAea8WiKxPwHCLCosrBJdHBX7620Zt828w==
X-Received: by 2002:ac2:414f:: with SMTP id c15mr9408080lfi.157.1570811906433;
        Fri, 11 Oct 2019 09:38:26 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n2sm2022305ljj.30.2019.10.11.09.38.26
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:38:26 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c195so7480038lfg.9
        for <linux-sctp@vger.kernel.org>; Fri, 11 Oct 2019 09:38:26 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr9294065lfi.29.1570811416172;
 Fri, 11 Oct 2019 09:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com>
In-Reply-To: <cover.1570292505.git.joe@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 09:29:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
Message-ID: <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
Subject: Re: [PATCH 0/4] treewide: Add 'fallthrough' pseudo-keyword
To:     Joe Perches <joe@perches.com>
Cc:     linux-sctp@vger.kernel.org,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Oct 5, 2019 at 9:46 AM Joe Perches <joe@perches.com> wrote:
>
> Add 'fallthrough' pseudo-keyword to enable the removal of comments
> like '/* fallthrough */'.

I applied patches 1-3 to my tree just to make it easier for people to
start doing this. Maybe some people want to do the conversion on their
own subsystem rather than with a global script, but even if not, this
looks better as a "prepare for the future" series and I feel that if
we're doing the "fallthrough" thing eventually, the sooner we do the
prepwork the better.

I'm a tiny bit worried that the actual conversion is just going to
cause lots of pain for the stable people, but I'll not worry about it
_too_ much. If the stable people decide that it's too painful for them
to deal with the comment vs keyword model, they may want to backport
these three patches too.

            Linus
