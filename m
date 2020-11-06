Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0492A9364
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Nov 2020 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgKFJvd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 6 Nov 2020 04:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgKFJvc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 6 Nov 2020 04:51:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357DDC0613CF
        for <linux-sctp@vger.kernel.org>; Fri,  6 Nov 2020 01:51:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gn41so1061508ejc.4
        for <linux-sctp@vger.kernel.org>; Fri, 06 Nov 2020 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9IBtvz1xb0AHqlIyVvrG0wyMkGPT2R1uF6Ltx4fuS1Q=;
        b=SAtXTf1XTB2iVd5TsH8z3gKUSMvhnZmXeL+fzOMchO4JYyHTivLWInorPoNF1DFORj
         j8lXfXmgtXu+LcfNo4JD7X/kZD5JqBa5Sf75iYnWT1zVOVCVhwDLvnHBJQIRBo0PEPpR
         2R/cJBBtyoU1IKHW2m2J9wLN0y1SldbIzR4n6eyWustw2bynhVWuiSODN6OzGbBkequZ
         UYTantj+YB5gOLlQtB/RipsFf4kztiwyb1ksnx/etvPWbpL2Sb/hBy1qM3ryYc2fsIhr
         sv1si2l3sOINQX3318hskJopCjJYeJ7xWUMTKwi1DyB3OvrKJMzCkm66nBD9cX2p+Lrx
         jObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9IBtvz1xb0AHqlIyVvrG0wyMkGPT2R1uF6Ltx4fuS1Q=;
        b=XYUPcDD0K3/kBxuuG9leFznzp5YjR6NAsvIWAEA4fUaJStwT+0vnU0NTN0kx6JhtVF
         h0QnTLB+u0QzZTY8cCJsDpsnck0klmDNOwd4W+iRxpeZ/msg82GOrMOFGRbbfFdrajYo
         QfSk9g2rzWX4j9IlbQORT4UlcZhxx8PjW5w74dtR0gxWSRV91/Xp+vQxfpx+QMiHXoVm
         2HVKfbHPJrdBjFSWBu4AD1wZXucpRb+LZskF3JYMtGiWHqxhgwt1ilNuQfCW01IGmDpS
         u9PYUb9cRPqxsuu1MW4jrozJlzSHAb6Mdd3RTdLCZr+ZVPZRZ4YpEAGrd905oZjPyZfR
         kyPQ==
X-Gm-Message-State: AOAM530SZB50oEX+tSTQaBHBXZFHkGhmF2HRk6n65ZeWmpaBmo56jpEG
        pjvbHXB2dGh9vs4ZIyY8WulDjg==
X-Google-Smtp-Source: ABdhPJw46RbOpExLWqlAV9SWFLIsfa1kfttjTMIHD/W89boZnOgzyIxJi3jf6mmoTPl+/LfXcidpuQ==
X-Received: by 2002:a17:907:264d:: with SMTP id ar13mr1167369ejc.207.1604656290864;
        Fri, 06 Nov 2020 01:51:30 -0800 (PST)
Received: from bordel.klfree.net (bordel.klfree.cz. [81.201.48.42])
        by smtp.gmail.com with ESMTPSA id k11sm603182edh.72.2020.11.06.01.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:51:30 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:48:24 +0100
From:   Petr Malat <oss@malat.biz>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: Fix sending when PMTU is less than
 SCTP_DEFAULT_MINSEGMENT
Message-ID: <20201106094824.GA7570@bordel.klfree.net>
References: <20201105103946.18771-1-oss@malat.biz>
 <20201106084634.GA3556@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106084634.GA3556@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Nov 06, 2020 at 05:46:34AM -0300, Marcelo Ricardo Leitner wrote:
> On Thu, Nov 05, 2020 at 11:39:47AM +0100, Petr Malat wrote:
> > Function sctp_dst_mtu() never returns lower MTU than
> > SCTP_TRUNC4(SCTP_DEFAULT_MINSEGMENT) even when the actual MTU is less,
> > in which case we rely on the IP fragmentation and must enable it.
> 
> This should be being handled at sctp_packet_will_fit():

sctp_packet_will_fit() does something a little bit different, it
allows fragmentation, if the packet must be longer than the pathmtu
set in SCTP structures, which is never less than 512 (see
sctp_dst_mtu()) even when the actual mtu is less than 512.

One can test it by setting mtu of an interface to e.g. 300,
and sending a longer packet (e.g. 400B):
>           psize = packet->size;
>           if (packet->transport->asoc)
>                   pmtu = packet->transport->asoc->pathmtu;
>           else
>                   pmtu = packet->transport->pathmtu;
here the returned pmtu will be 512

> 
>           /* Decide if we need to fragment or resubmit later. */
>           if (psize + chunk_len > pmtu) {
This branch will not be taken as the packet length is less then 512

>            }
> 
And the whole function will return SCTP_XMIT_OK without setting
ipfragok.

I think the idea of never going bellow 512 in sctp_dst_mtu() is to
reduce overhead of SCTP headers, which is fine, but when we do that,
we must be sure to allow the IP fragmentation, which is currently
missing.

The other option would be to keep track of the real MTU in pathmtu
and perform max(512, pathmtu) in sctp_packet_will_fit() function.

Not sure when exactly this got broken, but using MTU less than 512
used to work in 4.9.
  Petr
