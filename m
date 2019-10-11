Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8178D46E0
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Oct 2019 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfJKRqy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 11 Oct 2019 13:46:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45938 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfJKRqy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 11 Oct 2019 13:46:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so10609634ljb.12
        for <linux-sctp@vger.kernel.org>; Fri, 11 Oct 2019 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgOWyC4KuQvhExdqsSsy/AfsFX2Dxg7AbZdsgfAmHWQ=;
        b=Q2UkfBZSP0S9e/7OB3SF+XNURSwl+NMXpb0vpdXJQjsdW/6qutIw5uECnuvQSRhIfS
         ceZtY1Swy2zbGPAzUqBps7PsUDeS/0EuPPnU0Fy92rdos/7lz0dqKIiPx08pFFvzsTUD
         k3cf62WY2m182EbDTriMmjsXhjGoXoDCawAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgOWyC4KuQvhExdqsSsy/AfsFX2Dxg7AbZdsgfAmHWQ=;
        b=bse+W106o/HnSwhrvpgcmrKgdOhI1CFvZ/KRHJV3yYQyhlBLYrKhUGEQX4CF/lEVQd
         CSPC0MQCZXVrXugAVxO0jxPBvB5ITGaubQNvNAOLkvnLUDjDimnbL4TgPt1qLYMpDzO6
         6vzG+p56++HbG9D4qWY5JCvS82CixeK9GzyXCKEJtwvVZJIwOD/kHVj2WUQ5nqazAPv5
         JXK7ezKkaFOPaLcZHMhoTs8KFsOzX2Zin9oMMLSq2c0R6AbvGzmr4hYdK2vzwrTiv9Kx
         wEqHkrEw852wo5ax035OHejw8K6I4O88IC8yQTqwV8eBtDPyUb+mwPMlRBWwg21uRCsl
         918w==
X-Gm-Message-State: APjAAAWQeFRezm11aSfIjw7+YVi6Co1VBU1sBpx+dbnAohpo1ULnPVHW
        50eXKGHQASCtUGU/9VyenyZV+cBr4bU=
X-Google-Smtp-Source: APXvYqz4+t4xRBtaiIUDs+//x2ZwQsHSF9tfXoq29sOzI39cPGuDwD82WbtGVkilOJcxiYtBii1vmA==
X-Received: by 2002:a05:651c:209:: with SMTP id y9mr9820689ljn.134.1570816010376;
        Fri, 11 Oct 2019 10:46:50 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id g21sm2202245lje.67.2019.10.11.10.46.46
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:46:47 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id n14so10621191ljj.10
        for <linux-sctp@vger.kernel.org>; Fri, 11 Oct 2019 10:46:46 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr9892356ljc.97.1570816006661;
 Fri, 11 Oct 2019 10:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
 <9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com>
In-Reply-To: <9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 10:46:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1T1m-su8zK5LeESoz_Pgf1-4hnjr516NiDLNyb4USug@mail.gmail.com>
Message-ID: <CAHk-=wi1T1m-su8zK5LeESoz_Pgf1-4hnjr516NiDLNyb4USug@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 10:43 AM Joe Perches <joe@perches.com> wrote:
>
> Shouldn't a conversion script be public somewhere?

I feel the ones that might want to do the conversion on their own are
the ones that don't necessarily trust the script.

But I don't even know if anybody does want to, I just feel it's an option.

              Linus
