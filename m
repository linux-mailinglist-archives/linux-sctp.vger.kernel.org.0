Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8C168CFD
	for <lists+linux-sctp@lfdr.de>; Sat, 22 Feb 2020 07:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgBVGyh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 22 Feb 2020 01:54:37 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34927 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgBVGyh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 22 Feb 2020 01:54:37 -0500
Received: by mail-wr1-f52.google.com with SMTP id w12so4461278wrt.2
        for <linux-sctp@vger.kernel.org>; Fri, 21 Feb 2020 22:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aj4So34nUkJ0DHyLAYrJ4ZwvmtAMnQBnP0+bTbONxhk=;
        b=m7sRubYW5qSGaVT9MnSaeRqmjxDtRrrl5jz3upffmZg7wn37BioQqQYg0REFraxVoe
         GhumnJCxtlR12kHyeboJkihb1VIO6EzvKjWzuwSJWJp/Kj7ehI+ess7LFQfgw61fX+k3
         E+L4Ym0V4Og1x9uIC4PdXTtH+wgPqvafdpdTgicadBqTuzWqHYtu186Z7oy6F7/Exxmk
         5eBAcZlStnoxVhs5eN5wyI8RfDAOkMexwqvmU1X6YRHphOC2sJoXtZqLENe7chngbe2i
         yy/+DKjfxbGkfSDHpV7soXVrhlukgzsgKwtVc+Cdc9OgI/4LNi35FOyq2KUD09YMZgmm
         59FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aj4So34nUkJ0DHyLAYrJ4ZwvmtAMnQBnP0+bTbONxhk=;
        b=aHqrMyw1qnMDrs0q7u+eoWfS2wZbOJleK26z/E6eCgfZ6Iue8QNZxDrPrKY2IQ5MTv
         Cpo/Kv14blOcIk/XaHkB47RznPiIIAK0MRiNiJDdClXoEbfrepLq2jV9ut3XRQ3w/bT5
         cDaeFit0houx5xvqAe+7p7F0RKJzZC9CotfiEb9/ejozdhRgc1/RpC5T9KUsSR+F/TJW
         LOKgO8c01v1nQNdjT7UxofOst7Mz00n5rrdqPJcaaThcG6t5fv18okhbX+XGvmZ6AOS5
         D1d1hWArUTcRJsi24OYHoB98yfQr2NPLjvve5TrOQQxVup/pd2CgZaqNryTK/MAqkowi
         7Qeg==
X-Gm-Message-State: APjAAAV5avfWtVJr50TCYMJ2BXm8Bz6sG9uUUpkYMJAewrhMZ24+a5Ig
        8RUUmeCewyxqnF7ZQHyHXVaoo+tbXziS+UtWd3U=
X-Google-Smtp-Source: APXvYqzxCnlFcEKnz4Q8kOWRDY01jkDM+FELYm6FgSE4tSMHwpG8igMdNFHtGPxmDWpYsgA9cMKhyWpBwY/ilqWoTOs=
X-Received: by 2002:adf:fac7:: with SMTP id a7mr25359414wrs.299.1582354474451;
 Fri, 21 Feb 2020 22:54:34 -0800 (PST)
MIME-Version: 1.0
References: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
In-Reply-To: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 22 Feb 2020 14:55:50 +0800
Message-ID: <CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com>
Subject: Re: Problems with peeled-off sockets
To:     "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Feb 20, 2020 at 5:18 PM Leppanen, Jere (Nokia - FI/Espoo)
<jere.leppanen@nokia.com> wrote:
>
> Hello All,
>
> According to the RFC, a peeled-off socket is a one-to-one socket. But in lksctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDTH style. Because of this, shutdown() doesn't work, linger probably doesn't work, and so on.
>
> For example, in sctp_shutdown():
>
> static void sctp_shutdown(struct sock *sk, int how)
> {
>         struct net *net = sock_net(sk);
>         struct sctp_endpoint *ep;
>
>         if (!sctp_style(sk, TCP))
>                 return;
>
> Here we just bail out, because a peeled-off socket is not TCP style.
>
> Is this just a bug, or am I missing something? Asking mostly out of personal curiosity.
I would say, it's because .shutdown is tcp_prot thing and udp_prot doesn't
have. sctp doesn't have to implement it for UDP style socket. But for TCP-
style socket, sctp is trying to be compatible with TCP protocol user API.
But even though,  sctp's .shutdown is still not fully compatible with TCP
protocol due to sctp's 3-way shakehands for finishing a connection.
