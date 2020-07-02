Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB62123BE
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Jul 2020 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgGBMzo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 2 Jul 2020 08:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgGBMzn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 2 Jul 2020 08:55:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF19C08C5C1
        for <linux-sctp@vger.kernel.org>; Thu,  2 Jul 2020 05:55:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so21087619qtf.6
        for <linux-sctp@vger.kernel.org>; Thu, 02 Jul 2020 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OtPXXuV99eYMS1IQ6mruaKLX7IhvCU07hLGKTpJqBsU=;
        b=OtjcwKXTYJ5/Ui0PrDC9/Qu49KloAWiBh7aeliPw1OCCO5IoaambJf98LjBRziAKpb
         6li2x5VHpYeHWR5QoF/Kl+IVZ7bMD78GJ4K4ikClqUth5IOApLQytEL5iJATUKSwqKB5
         67SNrtO3/K/nS3b9/0M0UYl6cWOYsQVTcRSfP2rDAR1RsmW8DEoQn1XEDwp9Hwptu8ig
         UG41CCz3hhpyiEtubLAdb4EgBOtZSPNG9nE5iyYg58UI6RpBowYWgSFXPUw0YGoFGhbK
         bm0FIWBB+unOsjQN8OcK7XX/dcpiN3K+xPRUP+ibxSS/2LhxgXwtoKox5ZcE/GG4r6X9
         oMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OtPXXuV99eYMS1IQ6mruaKLX7IhvCU07hLGKTpJqBsU=;
        b=fn7Y5TqtcTNGjie0fRhdReln6NqboHIlz1nuJsRmowJOfUysDat27gFrpVK3efDe1D
         JW4B4Oxbmuy2vJrFMUtt1Gw6FdTeHedRdb5kc5dVPcXdhGYjTqL47NfctaGSnPYwIi4v
         NruZ2YVKbDbh9JE4x0qBd/YIqWZLABDpHosN5en7VSMvroYpfHw8Y/pYpGr+uLg1z1X8
         4WeTAU/pWzmp41gCWux+nCJA6fByzbi/9wPJZEVfsFHExqPeES80skdfmB665cIDdsKw
         +XrnnM6z7z7GwP+j+oGErl7rcLdmkh54Zz/eipFDCYHR9ZfMjdUhSQOglLZt/mjtoEmu
         Ndbg==
X-Gm-Message-State: AOAM532Y+rO0ZSKvwSp6ix/xosDxIEKna4+phWmsUm0EOP9oTfd4QhiV
        7wX0fQ6cuYr97K9iLtiJKJY=
X-Google-Smtp-Source: ABdhPJxYTb6YaTutcEih1h3SNYRHdDHUa8rUYBBPPxOFkTi/wvrgX+IggoXFlXEAQn9P1X4cb21xig==
X-Received: by 2002:ac8:4408:: with SMTP id j8mr23524990qtn.46.1593694542780;
        Thu, 02 Jul 2020 05:55:42 -0700 (PDT)
Received: from localhost.localdomain ([138.204.24.66])
        by smtp.gmail.com with ESMTPSA id k45sm9629340qtc.62.2020.07.02.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:55:42 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 70C81C08D9; Thu,  2 Jul 2020 09:55:39 -0300 (-03)
Date:   Thu, 2 Jul 2020 09:55:39 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Petr Malat <oss@malat.biz>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, trivial@kernel.org,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH] sctp: Wake up all processes after closing the connection
Message-ID: <20200702125539.GT2491@localhost.localdomain>
References: <20200702080126.8951-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702080126.8951-1-oss@malat.biz>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Jul 02, 2020 at 10:01:26AM +0200, Petr Malat wrote:
> All waiters need to be woken up after a state change to ESTABLISHED,
> CLOSED or SHUTDOWN_RECEIVED, as that's the time when they all should
> react - for example all threads blocked in send() must return an
> error when the connection is closed, not only one of them.
> 
> This solves the problem of threads sleeping indefinitely in
> sctp_sendmsg_to_asoc() when the connection was closed while multiple
> threads were waiting for SNDBUF.
> 
> Signed-off-by: Petr Malat <oss@malat.biz>

Thanks.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
