Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0A7251C76
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYPlg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 25 Aug 2020 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYPld (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 25 Aug 2020 11:41:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACAC061574;
        Tue, 25 Aug 2020 08:41:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so11317759qkn.4;
        Tue, 25 Aug 2020 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oingoz6Frqg2SQRAjjCpZonRfq5vy9M9TOZAsFU+QTQ=;
        b=HnbIHLdznZEhj5FyyQQtndeXrdnwHnv+24GTDPoTYMpFbo6q86P02qs6c5vCxCm0tI
         xhW8JMR45zXRL5TpMnepCjbWZH1c3WHpWVYfkuLtI2ZeNUJOtrThuk00rc2LrnqM2PFR
         yh2VUfSUNvzAudIwDA2s3AsgkwcDv67xfJJ3pgNEaa3yu3Xqg/OhS3RbPWAdvxIW94Q7
         NsBArqOH4KfMUTVq+i37Y6uMHVea8YeTtwiDmXO9fSK1xs0dQqT4374porZN3HAjZj6p
         F0ybDjVe9BCt6quZNAnL7LHm+DxfRhFQoe5NrRr0/3aVD/6ZH9lgmF/lEYjP+RZbjbp0
         bSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oingoz6Frqg2SQRAjjCpZonRfq5vy9M9TOZAsFU+QTQ=;
        b=rXn3iTXOJ2cNJBL28LQ3vRIhjqW2inRS7tdq51wX1Xd+lHQXoF3h+thIetL1C7QW1B
         u5DOVy0ZsadNpMzvCAYKn2KL5Pna3ZwbEZ9rI7j0COIAcm7B9P476H+iQLPaROc1U27e
         x0OTrX3swR3PFYiwxtKmwdy/9EyxgMKSVAyHn1pOlTaBaQx2suRub0i0ZiXMywZgSizY
         ujCPLSKF5yJ22UgaXN+mOBAJVebfCwuqH+5xqxbQJuiw7KPe/HZG2OSDs8+MkaxZ/2iR
         CidxaaprpvPAnKiL4LCZcqMseIjv4zYZHa+hMHjvDnCibCCWxg1wgNP8n6w7C4qrH45c
         TkHQ==
X-Gm-Message-State: AOAM530wRw440HmXwDNzcjsEF8PIAeWmAV1pYddlpfwaznMz5g7vjNsO
        hVLMqh3RlrZSZ1sOLMoxaiw=
X-Google-Smtp-Source: ABdhPJxGM3dreknMCsSUoQUGt4iji2RSu+2ULCfK+U+iIMegceSfZvMPRBtgDvJSrOC+fhnHdMbVCw==
X-Received: by 2002:a37:8b01:: with SMTP id n1mr7072338qkd.62.1598370091385;
        Tue, 25 Aug 2020 08:41:31 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.63])
        by smtp.gmail.com with ESMTPSA id r6sm13827277qtu.93.2020.08.25.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:41:30 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id B3A12C4BDE; Tue, 25 Aug 2020 12:41:27 -0300 (-03)
Date:   Tue, 25 Aug 2020 12:41:27 -0300
From:   'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'kent.overstreet@gmail.com'" <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        'Neil Horman' <nhorman@tuxdriver.com>
Subject: Re: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Message-ID: <20200825154127.GB2444@localhost.localdomain>
References: <21289d79b0474811b21ed8478c465159@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21289d79b0474811b21ed8478c465159@AcuMS.aculab.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Aug 25, 2020 at 02:52:34PM +0000, David Laight wrote:
> The genradix code is used by SCTP for accessing per-stream data.
> This means there are quite a lot of lookups but the code wasn't
> really optimised at all.

My test box is down for the moment and will bring it on later today or
tomorrow, so I can't test it yet. What should we expect as performance
gains here?

  Marcelo
