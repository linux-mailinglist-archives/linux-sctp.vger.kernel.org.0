Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05491C9B50
	for <lists+linux-sctp@lfdr.de>; Thu,  7 May 2020 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgEGTo7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 7 May 2020 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTo7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 7 May 2020 15:44:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25950C05BD43;
        Thu,  7 May 2020 12:44:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so5900201qtv.3;
        Thu, 07 May 2020 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qoD2bZDUs9J4Y+pRwsgjWSZscZZ8lr8WrrU2ArQm1+E=;
        b=qEXnogpvMgfAUsWLQ7qJDwyJu6KxBTy6I7hkk0GyXjbtogPeqETsPqiehRQ2tUx5xG
         tTgg0FoFdT4IxC79TAkz7OMiUOunwNyx3PjSb69ThWT/70cJ+c19OKU8ZDpa3UHf4TL1
         pz/Eo28TV9RyMzmfhbuWaGw6wQYi7//E76EQnGhNw8Dqr1yak0SAys9qp4SRwRgFmH4t
         B/5nuA0H+eMO/BRrcG5uAFl7AFTdphJXcQPN83KXSFa8WSkLtfsDEv+8L2MZaF/T/lr7
         33iLWtJ2WMyTuGfWwgghtfUgwG3tB6vRfVJVUpN+7xLcj6+bgz+iwaDJmPlppn0AixSJ
         Ew3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qoD2bZDUs9J4Y+pRwsgjWSZscZZ8lr8WrrU2ArQm1+E=;
        b=ZGHpWu3ng8uIfNPrZSt4iESqktfXotE7mMw+ZuK2cD/4ytva6eMEc1rhIAoRyuqP4O
         NC9l7I4/w9hbCxBjrqP+X582N3wbyriCMaEPlrBytzkbfqvU2cOL+hjlaG2tuCz9mviw
         ZPp27XpqC4YIAVBAFjMM3r6Ea3F+ZxyyqkzBJEQ/M2RlfJRqJmQoHjzpQyBIcf2m4TuI
         mzcjkLxULdQD0L2L5DNSRqrpxJAwmasJlm3XueyMCb/xXDy8DYD9TV/YEUB/x2RgvioO
         67wx5BU99firJ+hjqL0Hg6OMI15TPqfmpujRaCdbAiYqqurq6ShR63v06tHILQQUNIev
         emyA==
X-Gm-Message-State: AGi0PuaDiL7RC5CL5MjLKeZJjKXoqw+7WgmQsx32wPOnPAOMasCi82vr
        1knN1hfLJLN02p0nw++47E4=
X-Google-Smtp-Source: APiQypIcyF3Jld2aKvC1k0TDbpMbhKyT1QR5+cOO5AKrLAab1ftN6soU+kvCX8Y8EbC1eHQN61/PVA==
X-Received: by 2002:ac8:1628:: with SMTP id p37mr15930726qtj.179.1588880697291;
        Thu, 07 May 2020 12:44:57 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.228])
        by smtp.gmail.com with ESMTPSA id z65sm5196436qka.60.2020.05.07.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:44:56 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 08D8DC1614; Thu,  7 May 2020 16:44:53 -0300 (-03)
Date:   Thu, 7 May 2020 16:44:53 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: Replace zero-length array with flexible-array
Message-ID: <20200507194453.GD2470@localhost.localdomain>
References: <20200507192152.GA16230@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507192152.GA16230@embeddedor>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, May 07, 2020 at 02:21:52PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
