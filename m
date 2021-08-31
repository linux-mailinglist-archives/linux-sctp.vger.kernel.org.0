Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FF3FC2B6
	for <lists+linux-sctp@lfdr.de>; Tue, 31 Aug 2021 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhHaGT1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 31 Aug 2021 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhHaGT1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 31 Aug 2021 02:19:27 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599CBC061575
        for <linux-sctp@vger.kernel.org>; Mon, 30 Aug 2021 23:18:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s10so11355769lfr.11
        for <linux-sctp@vger.kernel.org>; Mon, 30 Aug 2021 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=kS74wE2T1WndU0C9yewIILwqzwXLl+zyYvuGKjmG3LbLnedFOmgoeS3CuLsolOuV4D
         WPkGsdkgde4lkwtMR+Bn/R9zL4eud1Q6vu2GZV6MXsv1Ye0dZMAbGWHvuqAG3fFTzi4V
         EUGSc5itVstByKb9dUPkMYUISZCJWPH5zXOdvo3/Z5c3daiv4J2dmx/yo4rziEbS6n+4
         Q91KwK/1V+YREhCBAWZG5l47Uvp6PWPcUrC501EyctlHNuOvsVaPI2UnxPo8oykiNm0u
         j7J6oeF1t1Lk00v49p0wEgKBkiPlheB7AS5R5tIyvM9yuRqJrwztk+a3wjMooFlwqxnv
         U2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=p3RiFKnDOXA5dJiqetlt84rnTKyQrPehYJ5pi6eMNXnT3Eo2ar9niDxFmoCZoAzS4C
         Aq6FVWb5ww26exafbPHN9WYlyyyla4FFE4XjsjmxbrpQDoj2TiJDCCiR9EhK8MZSfcE+
         KfzkuWCJWV1uoi87OIkDyqF2PfnKUmG6XXXtIFFgxat0/gpCkZ1cGn+miP2o5QXYVS0n
         N3xTAE6bji1+N97tOttM+YDPUGht3gaTHd7EZ2SnUh2n6hBwWseYtHv2fMVjVSZ4q4rP
         UVy7N3RMutt4ti8ZtjfYVY6+BV/AC7Qq9aLvRNDFRQPcKjuWevFBmTLxqbt/QCd5QG8s
         Fruw==
X-Gm-Message-State: AOAM533e759BluzvwY+BcaVkO9MNVNTSsy3t688gwYHbCSZO4vWpjs2K
        7DV4h4Tay7qlE3/CjUN/cAWCidlAzHwKAXWf3TU=
X-Google-Smtp-Source: ABdhPJx0kXHhL+PfwBzh5WGLj5HKrJglzjhz3MHVEIOXHT4LT4fothK22uMk4Iyk1FhNDj/FpFxr421maFI0iypXYXw=
X-Received: by 2002:a05:6512:10d3:: with SMTP id k19mr20097936lfg.481.1630390710452;
 Mon, 30 Aug 2021 23:18:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: anitaholdings1860@gmail.com
Received: by 2002:a9a:7407:0:b029:c8:dbb9:6b13 with HTTP; Mon, 30 Aug 2021
 23:18:29 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Tue, 31 Aug 2021 08:18:29 +0200
X-Google-Sender-Auth: _WdLxXfqSUHaYsKywBP9wd2AZ9Y
Message-ID: <CAJ9gDnchdqV_3wp2DehMMJUgdHBV6DdxrO_=EbwWo+xDerKcLg@mail.gmail.com>
Subject: I just want to furnish you with this good news
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

I just want to use this little opportunity to inform you about my
success towards the transfer. I'm currently out of the country for an
investment with part of my share, after completing the transfer with
an Indian business man. But i will visit your country, next year.
After the completion of my project. Please, contact my secretary to
send you the (ATM) card which I've already credited with the sum of
($500,000.00). Just contact her to help you in receiving the (ATM)
card. I've explained everything to her before my trip. This is what I
can do for you because, you couldn't help in the transfer, but for the
fact that you're the person whom I've contacted initially, for the
transfer. I decided to give this ($500,000.00) as a compensation for
being contacted initially for the transfer. I always try to make the
difference, in dealing with people any time I come in contact with
them. I'm also trying to show that I'm quite a different person from
others whose may have a different purpose within them. I believe that
you will render some help to me when I, will visit your country, for
another investment there. So contact my secretary for the card, Her
contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,
