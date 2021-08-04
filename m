Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08EF3E0AF4
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Aug 2021 01:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhHDXrb (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Aug 2021 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhHDXra (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Aug 2021 19:47:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70138C0613D5
        for <linux-sctp@vger.kernel.org>; Wed,  4 Aug 2021 16:47:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b128so2154232wmb.4
        for <linux-sctp@vger.kernel.org>; Wed, 04 Aug 2021 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QDv0rqgUyrJPqw0W+rCLZ6ZMyhM9KE/jmdnRmtL81g0=;
        b=V2W0uZUZnKTpCwzSVmnUoDaQjT31+tVsAo/HkEFfyWvuDCPNLDrf/ITw2d7jmnd/s0
         h1q/hoIXcx4YBpiRhNPEeyAyVVSqxmqDa2xyxd3msg9p7aR74x/3nLJeyftV5i+QoGDE
         jZWBOQsBjfXnGR/qO1djdl3DOf5z95GgZvqBlFYOWc7zEqkvs5DSixvDMgu/iDpxuNeL
         noIfjxkksJmz0HEcIfKBbtHrEgYEN16EEhb+6iwASQg3wFti0mVs1ekWaJSLN6I+Kjsc
         5CTnOF9GcptLd3tefs+EiVG1z1ClSnfYG7/L6Ww/Lm/cmt55EzjyoAXrAX1IfM05XglI
         qrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QDv0rqgUyrJPqw0W+rCLZ6ZMyhM9KE/jmdnRmtL81g0=;
        b=T7aoA3pt6i29nf3XAasibTtuWu5Y6tU0vPlw6EIC3baCeQLgEgUop6d2ouL2pZm0OU
         kCHFSiPim4HMobCdC1SYabz4EbzNjncYemdknnMUTVX7k01wiewPFKYvGGcg3YCSUdLK
         YHO3w79giThfDVm2mdCtg+pdNqIj36I64soC4GMUwaNT+Q6VNPmLuVXEoVgzRDLqhPAC
         xgTvOwdOUo0ZP9JMDUAYP0Op6XEpGPaMmcgcX6M7zsPFf/lA+tX+0HkRtVT2+lJFbrm9
         ittXwnHOi6IG3fBY6tsSevxgHo+UpE1kG5KSQf4geLz0FoG+hO5XZWbkFwS7ynoFtWbN
         TbIQ==
X-Gm-Message-State: AOAM5338KgT3C29QWP+z6xaO5NCPo2/sl970Q86k1bzO+L1JzyWJLWzE
        FA5qSSlwYo9bC7E52EZYFi6p3cUl3V/Lrd3H9pVLEERzZuKzTLsx
X-Google-Smtp-Source: ABdhPJxFmtMR5mxaiJRQ7mZQP40KlxcnjycNtIit3VUBFc3cJcRi6pqG2HZ/z+8Tq4ucJ/7SUZehtuJaQ+eOYMKPOSE=
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr1779737wmj.156.1628120833532;
 Wed, 04 Aug 2021 16:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628076531.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1628076531.git.lucien.xin@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 5 Aug 2021 07:47:02 +0800
Message-ID: <CADvbK_chOXWAj4Lr14JT2=WxqmPGK9Qndq9yyQyEX6gFsF42og@mail.gmail.com>
Subject: Re: [PATCH lksctp-tools 0/4] lksctp-tools: replace use of deprecated
 gethostbyname with getaddrinfo
To:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Aug 4, 2021 at 7:29 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> This patchset is simply to replace use of deprecated gethostbyname
> with getaddrinfo in myftp, sctp_xconnect, sctp_test and sctp_darn.
There are three ways to use this function in this patchset:

a. get IPv4 addresses by a hostname:

               hints.ai_family = AF_INET;
               hints.ai_protocol = IPPROTO_SCTP;
               getaddrinfo(remote_host, NULL, &hints, &rp)

b. get IPv6 addresses by a hostname:

               hints.ai_family = AF_INET6;
               hints.ai_protocol = IPPROTO_SCTP;
               getaddrinfo(remote_host, NULL, &hints, &rp)

c. get IPv4 and IPv6 addresses by a hostname:

               hints.ai_family = AF_UNSPEC;
               hints.ai_protocol = IPPROTO_SCTP;
               getaddrinfo(remote_host, NULL, &hints, &rp)

Note ai_protocol = IPPROTO_SCTP is necessary, especially for case c.
Otherwise, it will return many addresses with different protocol(TCP, UDP...).

>
> Xin Long (4):
>   myftp: replace use of deprecated gethostbyname with getaddrinfo
>   sctp_xconnect: replace use of deprecated gethostbyname with
>     getaddrinfo
>   sctp_test: replace use of deprecated gethostbyname with getaddrinfo
>   sctp_darn: replace use of deprecated gethostbyname with getaddrinfo
>
>  configure.ac             |   2 +-
>  src/apps/myftp.c         |  40 +++----
>  src/apps/sctp_darn.c     | 246 +++++++++++----------------------------
>  src/apps/sctp_test.c     |  63 +++-------
>  src/apps/sctp_xconnect.c |  72 +++++-------
>  5 files changed, 137 insertions(+), 286 deletions(-)
>
> --
> 2.27.0
>
