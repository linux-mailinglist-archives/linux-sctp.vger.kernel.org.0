Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD6742D7
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2019 03:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGYBVU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 21:21:20 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:37824 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGYBVU (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 21:21:20 -0400
Received: by mail-qt1-f169.google.com with SMTP id y26so47499076qto.4
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 18:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fGXsZ3vKKNd0s7b3rBnsntm1q73Y6A7QjBnwRxcPRR4=;
        b=s7xvo+FEEYXAQVI6RW/tY2Y8rDWCoYSmRMCPKSxA0IUTDp0pcqNGtxQZ/N6q3YwEn/
         TRGYWcw5dcODJSZnSxA7raDaU+fQqGwxqteeU//DarHVmE4AYejUwZHZeRBnszn62GhT
         a92yUbQPE9DaT32ZnXw+c0bkFCclLrqRAuNzDWFfeGvWS+m1dBBUzCTpYR/MTUqbylHL
         4VTkL8O/zxmo9IDK+rlSRUgswxJpXTxeIW+B96gBoaW5Fi1bMC7a9UtRS4bgaf7O7LRY
         Bgn3fUVxApecumBDQrBS1+zC60xx0OqaxPF34uNom76yG19fJ/dj6PxjAchGIEI6vjqk
         jp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fGXsZ3vKKNd0s7b3rBnsntm1q73Y6A7QjBnwRxcPRR4=;
        b=ZRYfHfilh4q+CzCr7EVXScEPYPVks/Ejym28d0M6LGdNoGyYlvn1+Bp+neBhVKlf/R
         B1bZXyzWZ5fBR5kyhvI++/093ftimFANKK38iRy3qTgJMAkbM/XNxf400+a4AywqDipS
         46kxRoG+k/4QaXCyY/u6NI4OPDJSm9LS/Qpz6eGfqGE7c6WhzF3WqQrNvBzVfzcl6nDQ
         u96JRsb/xUV1YxNkPGvfxOSn88FoWoFG4U+UNCMD3/ErGrVxB0V/hC3f9ivPkjwo2CEP
         P1aRYb3qDCrlPhV+YkAAOZk1PRdBaKk9/fLSp1IILh8iTFMlsdRKOeEojmvVxDaVO3hX
         +KhQ==
X-Gm-Message-State: APjAAAU8sVy4Gwd/RwAq+hC7BrOn4CH/xyTaRJ0Xm9S5rUETMMmbKHdc
        SvmniZ7t8QFbcWV8ryymXvt9hH7yKVw=
X-Google-Smtp-Source: APXvYqwG0oneIJKJ/5razNz9buiA7YeFDHdLPO6rKhrz3v+ONzYN6ZFCjcTrOmJHCSoNfA3oDQKZFw==
X-Received: by 2002:a0c:b0a8:: with SMTP id o37mr61885788qvc.76.1564017678880;
        Wed, 24 Jul 2019 18:21:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:2135:7c3d:d61c:7f11:969d])
        by smtp.gmail.com with ESMTPSA id n18sm20579255qtr.28.2019.07.24.18.21.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 18:21:18 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id AA256C0AAD; Wed, 24 Jul 2019 22:21:15 -0300 (-03)
Date:   Wed, 24 Jul 2019 22:21:15 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Luci Stanescu <luci@cnix.ro>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: SCTP recvmsg MSG_TRUNC or something similar
Message-ID: <20190725012115.GA4064@localhost.localdomain>
References: <D588EC18-6A7B-4D2B-AB0A-2961A247DC3B@cnix.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D588EC18-6A7B-4D2B-AB0A-2961A247DC3B@cnix.ro>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 24, 2019 at 02:46:09PM +0100, Luci Stanescu wrote:
> Hi,

Hi,

> 
> I’m not sure this is the right place to ask this kind of question,
> but, having not found a better forum, I’m trying my luck. Apologies

Considering you're programming for Linux, it is. :-)

> in advance if this is outside the scope of the mailing list.
> 
> That being said, my question is: given a successful return of
> recvmsg() for a SOCK_SEQPACKET SCTP socket, is there no stateless
> way to determine if the read data, for which the MSG_EOR flag is
> set, is the trailing “fragment” of a larger record (either due to
> partial delivery or an insufficient buffer passed to a prior call to
> recvmsg() which returned with the MSG_EOR flag cleared), rather than
> a “full” message?

Stateless, I'm not aware of a way.
We do have SCTP_PARTIAL_DELIVERY_EVENT, though, and RCVINFO. But these
would require some state to be preserved.
MSG_PEEK also, but also requires some state.

> 
> From what I can tell, MSG_TRUNC, which would’ve solved my issue,
> isn’t implemented for SCTP. Regarding this topic, I’ve only found

Agreed, but MSG_TRUNC would cause information loss.

What about using a larger buf?

> old discussions, including some suggestions to add SOCK_RDM, which
> never materialised.
> 
> Many thanks for your time!
> 
> Luci

Regards,
Marcelo
