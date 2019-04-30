Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79DEFB52
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Apr 2019 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfD3OXK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 30 Apr 2019 10:23:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37460 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3OXK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 30 Apr 2019 10:23:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id e2so15567195qtb.4
        for <linux-sctp@vger.kernel.org>; Tue, 30 Apr 2019 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QPGko4YxTKru9Tnog/qOyZ8vvOGOOtDnRDZMbd3V4E=;
        b=dehdcOOZnDl0O/bthSoMPMPxa/bY2+vv5qUgr36itPrc9t6Sk0bGwl7AE1lGuAe/DM
         fd4WaU+NYNQvx+Csex7j4G4IUvNSk0f6j54hXZlaH8YXEI/2d4fxpFTyd+58Jn2zZN3g
         +vK2tcVvH3+mGxbJsfbeBCDjNuCsHeUGLKnLp506/ndnF7G7IH2cPne/TSppY3Jn7Vl4
         Sr+Dpnuk9eGdqGtrPDn3pkANwQGgPVLCS9h6gBi0IA2Ana/W8JHdkycwpmh9622Q7ltJ
         z+1nkbi3b2ctrs3kx3qMVrHBU3oyiKDeIPyvsofggApWIwNUo8h8uvTCOhAp5sgKXLeo
         AP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QPGko4YxTKru9Tnog/qOyZ8vvOGOOtDnRDZMbd3V4E=;
        b=dSMP4/P27p1LQyQspkKcIKG5WOLtTsiidEUHrcnV6cAm1RYKWR/jinzjRAfkJ9EZlW
         gKpZct08ip85pdmsbsD5ipPbc8zCIYkjYWcS2UPemGgnhp+n1D4t0aBUErSXFl7h7xJS
         dcj1WDjhDDpGRAqM9OYksZm37SVVpKCAHE1w9XRK/RPr9GHhJFJgfQCawnUxYiAJBx+k
         eMOkwvYrqrWfJ9bUMBAMmX/91gVnmIb6EJ8oXtoV6AU/Z9gKdQF/2ZINtsGgwcCpt4eK
         ARQKJsVTgWZhayym3PDJicithpU72+vlTXwwLZbTUbml10YNvP7hQ2zw8Zv/bFf2Da3F
         DsHg==
X-Gm-Message-State: APjAAAXIlt41sFeoiNOlDqz4yaYSnEUNS/GbaNVycJgVDjq2s0dDYJRC
        rJxFsoQKIVfeGjlwFm1cRc4=
X-Google-Smtp-Source: APXvYqxCVA+tSpfx89SY8PIKqrA3b4he2FEc97sf2rE4f0tEiY4Sf6/UHsoEGNHAGwXwc4/c7i1HTA==
X-Received: by 2002:ac8:2291:: with SMTP id f17mr55578888qta.330.1556634189187;
        Tue, 30 Apr 2019 07:23:09 -0700 (PDT)
Received: from localhost.localdomain ([168.181.49.3])
        by smtp.gmail.com with ESMTPSA id s42sm10208676qth.45.2019.04.30.07.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 07:23:08 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C9047180CF7; Tue, 30 Apr 2019 11:23:05 -0300 (-03)
Date:   Tue, 30 Apr 2019 11:23:05 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     damir.franusic@gmail.com
Cc:     linux-sctp@vger.kernel.org
Subject: Re: [PATCH] sctp_recvmsg man update
Message-ID: <20190430142305.GA15616@localhost.localdomain>
References: <20190426193943.30628-1-damir.franusic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426193943.30628-1-damir.franusic@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Apr 26, 2019 at 09:39:43PM +0200, damir.franusic@gmail.com wrote:
> From: Damir Franusic <damir.franusic@gmail.com>
> 
> * fixes issue #31
> ---
>  man/sctp_recvmsg.3 | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/man/sctp_recvmsg.3 b/man/sctp_recvmsg.3
> index a7dede1..7854aec 100644
> --- a/man/sctp_recvmsg.3
> +++ b/man/sctp_recvmsg.3
> @@ -44,7 +44,16 @@ message.
>  .I msg_flags
>  is a pointer to a integer that is filled with any message flags like
>  .B MSG_NOTIFICATION or
> -.B MSG_EOR.
> +.B MSG_EOR. 
> +The value of 
> +.I msg_flags 
> +pointer should be initialized to 0 to avoid unexpected behavior;
> +.I msg_flags
> +is also used as an input 
> +.I flags 
> +argument to 
> +.I recvmsg
> +function.
>  .SH "RETURN VALUE"
>  On success,
>  .BR sctp_recvmsg
> -- 
> 2.21.0
> 

Applied, thanks Damir.
