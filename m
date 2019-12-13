Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023F411DB5D
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Dec 2019 01:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfLMA5b (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 12 Dec 2019 19:57:31 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38793 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfLMA5a (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 12 Dec 2019 19:57:30 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so652928ilq.5
        for <linux-sctp@vger.kernel.org>; Thu, 12 Dec 2019 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3jocdiFLzaES+h2wlJdlyw5Wx0cVcDESrSWJ0tTSLQ=;
        b=U4Mw3wT6ni2X2a7ZywEHYvmtDC4cf4X59GJr+k87YaaPynmIBGXDKn1n2e5VcE3c5P
         4ruo/dh0MoZn6yec53VhenRgsFzHDIMp9ysx1bO8ZYneDkhDTL3rxKGh4yR6jxCnLeW9
         C8j8LIfV6PUQpimRH7xsgPFat0j05xgsvEEwjS4P33qtuVbzjFrFWKhbhXnqFvcZsMOJ
         U0fqMW+7kx5ClXY13uv1OyYa7sBdZhG0Nc7vw0n1ac2zrkgyXhv6WxIgDK+wch0YNIyn
         P3WBwAKY4QDVa0Imzf7h7i7mNQj9D0WLbyoTA1xmAn4rhCJnR8nSTxOW+buAgIeGqxII
         Ahzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3jocdiFLzaES+h2wlJdlyw5Wx0cVcDESrSWJ0tTSLQ=;
        b=J3zhKH2vlIsTP7bXKdXiSW4ET1w+Dn9r7V7pLQQ0piI0h4+8Hf7WNw28DuTCMKIrZr
         Lvo2HU0OZkQo7x11d3oRVd7n9wj/LNQ4ys6Lelv/XOiTAZHLKTj6cEkehfj1o0LA00es
         fQHVCow3taYW9M5+9bJAuKwTGONsiBG0Ca1zo3B+rCOmJ4VAn1cC/WQAVo1KixZ41ze6
         nwFmjUmwAvhA1C1k1jzXQOlQi3eLSEZSKAdcZIKfoFgYo2RpeFbOodQpIahqJEbX2hYC
         FCCfZ5fAWbmSqKp/tYZJDgUyKGjoHVa29LMQmcbFd5GWxIvNU8FgB94sxZm5hvzT21LY
         wcgw==
X-Gm-Message-State: APjAAAU+DVI3gs8Cenq3Ej1lPvDttXsyscPshjcE3v8Zoz0egN4o0OVU
        kl9IoWkVFDg4D/hBKzeVqxWqa/jZ77ftOLj5lPGgFg==
X-Google-Smtp-Source: APXvYqx/dw8ihvZ31i4Natfa8mPoKCKMYZFd4QatEXTVGDoB2hpsajvTiTWjFom17ptNTJEs4qhditaWLmsOVffeDOU=
X-Received: by 2002:a92:3b10:: with SMTP id i16mr11822126ila.170.1576198649802;
 Thu, 12 Dec 2019 16:57:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHo-OowKQPQj9UhjCND5SmTOergBXMHtEctJA_T0SKLO5yebSg@mail.gmail.com>
 <20191209224530.156283-1-zenczykowski@gmail.com> <20191209154216.7e19e0c0@cakuba.netronome.com>
 <CANP3RGe8zqa2V-PBjvACAJa2Hrd8z7BXUkks0KCrAtyeDjbsYw@mail.gmail.com>
 <20191209161835.7c455fc0@cakuba.netronome.com> <CAHo-OowHek4i9Pzxn96u8U5sTH8keQmi-yMCY-OBS7CE74OGNQ@mail.gmail.com>
 <20191210093111.7f1ad05d@cakuba.netronome.com> <CAKD1Yr05=sRDTefSP6bmb-VvvDLe9=xUtAF0q3+rn8=U9UjPcA@mail.gmail.com>
 <20191212164749.4e4c8a4c@cakuba.netronome.com>
In-Reply-To: <20191212164749.4e4c8a4c@cakuba.netronome.com>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Fri, 13 Dec 2019 09:57:18 +0900
Message-ID: <CAKD1Yr1V4S3cxvTaBs6pReEZ_3LPobnxdroY+vE3-injHyGt2A@mail.gmail.com>
Subject: Re: [PATCH v2] net: introduce ip_local_unbindable_ports sysctl
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Dec 13, 2019 at 9:47 AM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
> How are the ports which get reserved communicated between the baseband
> and the AP? Is this part of the standard? Is the driver that talks to
> the base band in the user space and it knows which ports to reserve
> statically? Or does the modem dynamically request ports to
> reserve/inform the host of ports in use?

I'm not an expert in that part of the system, but my understanding is
that the primary way this is used is to pre-allocate a block of ports
to be used by the modem on boot, before other applications can bind to
ports. Subash, do you have more details?
