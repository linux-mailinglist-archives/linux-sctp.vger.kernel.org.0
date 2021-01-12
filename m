Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36EC2F262E
	for <lists+linux-sctp@lfdr.de>; Tue, 12 Jan 2021 03:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbhALCS4 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 11 Jan 2021 21:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbhALCSz (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 11 Jan 2021 21:18:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F494C061575
        for <linux-sctp@vger.kernel.org>; Mon, 11 Jan 2021 18:18:15 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id y15so692581qtv.5
        for <linux-sctp@vger.kernel.org>; Mon, 11 Jan 2021 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32AmM+qBABeVUD37ELNJ3R8T9CwvieE4sxIcwjl7PNU=;
        b=GQQuY8RSpWBc3h52L3n9f7JhWPRM9OcgMsOSz3I4P+0Sb7YwtJGvnRaKH0SIbF9p7/
         9ipTgQcUWElo8onw7EfZ+a7o9JQXW/RsZMMvP8pygOvXnElN7DE+DDrQqojsmp5pHhgb
         +zkoN1H4uD95LZq0EpSPaE9tD/6H9FMXz2UM5BfEkHKI7ymsagMdPAydV1Z4gZj2r+d0
         mYUVy9+goYpSSCme+SCTHJ83QTa1YTGvDLWzP+CkWj0gcc5VNLk6lokirAVWu9xqFkRl
         p+QtkCUv49u+u95mTBQT9J7mXWASEyDMTcCg1ELuHr14s1lrQzHJOgkv18UENiOaLVJL
         Nhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32AmM+qBABeVUD37ELNJ3R8T9CwvieE4sxIcwjl7PNU=;
        b=PXLCYhZr1fjzwcUZP8tpTmn/iMkh9EgVTIoVb1VLbx/xXe/ZJgAj8B85NgvbOxIoE1
         DfLI1Wh5dLgfxRYIKsOyW5ZHm18dJ7HxkQ6B9qMUmsFtS7C/P8TZNge/G9rO9w/PR+MF
         ZenKXoDfVxCTfU3J4fTgCRH2XJFRWym3hBQtVXt2PjjTJ836ziDyDdip+Ud8JWqq84c2
         G3f3NY4EA5HYl9CVuBoAZ8oKIvbPuNfUGu2J13pmueZzYhz1ImIJF6/z8RMKHMqakjSc
         4ZSP7440uKaz+2tBqzrW9Ift7hXY/ASdrIkCuzWwTrSyoU5Dn8OXRAr8ObUKog2nfGfO
         zoXw==
X-Gm-Message-State: AOAM531tnrV7G/N0uGaLJ+FgKUOxtsPYPap3+BEQ6zs1JOgmG0ZMwEYb
        /DAZ+c/wkRZTlPCWidX7Dk0=
X-Google-Smtp-Source: ABdhPJxWUCga0Z76wfNrqGOV2+ZrSPFpShINNegk0ytkxdpfQxSDjeS47Nrk7ZBLLaB07iZoEfCU9A==
X-Received: by 2002:ac8:5359:: with SMTP id d25mr2669754qto.132.1610417894684;
        Mon, 11 Jan 2021 18:18:14 -0800 (PST)
Received: from horizon.localdomain ([2001:1284:f016:2182:69ea:afba:d188:e39c])
        by smtp.gmail.com with ESMTPSA id i17sm620008qtg.77.2021.01.11.18.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 18:18:14 -0800 (PST)
Received: by horizon.localdomain (Postfix, from userid 1000)
        id EA0E9C085D; Mon, 11 Jan 2021 23:18:11 -0300 (-03)
Date:   Mon, 11 Jan 2021 23:18:11 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: [PATCH] m4/sctp.m4: make conpatible to autoconf-2.70
Message-ID: <20210112021811.GA2677@horizon.localdomain>
References: <20210108222252.95123-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108222252.95123-1-slyfox@gentoo.org>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jan 08, 2021 at 10:22:52PM +0000, Sergei Trofimovich wrote:
> On recently released `autoconf-2.70` generated `./configure`
> fails as:
> 
> ```
> $ ./configure
> ...
> checking for struct sctp_event_subscribe.sctp_stream_reset_event... yes
> checking for gcc options needed to detect all undeclared functions... none needed
> ./configure: line 16464: syntax error: unexpected end of file
> ```
> 
> This happens becuase new autoconf generates less whitespace:
> 
> ```
> {
> if ...
> ...
> fi}
> ```
> 
> It requires at least whitespace between `fi` and `}`.
> 
> As input already has newlines the change just drops extra `{}`.
> 
> Tested on `autoconf-2.69` and `autoconf-2.70`.
> 
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Applied. Thanks Sergei.

  Marcelo
