Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6829CC0E
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Oct 2020 23:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832506AbgJ0WfY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 27 Oct 2020 18:35:24 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37568 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832504AbgJ0WfX (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 27 Oct 2020 18:35:23 -0400
Received: by mail-qv1-f68.google.com with SMTP id t6so1515405qvz.4;
        Tue, 27 Oct 2020 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+6EqPkxS+upEiFHF3tvQSMAgw2qIzQnOXTK/To17+kY=;
        b=SNyucDBDUkPKJgqOZFbfKItm4OfZnYC8Ul6z6WOHPrLuc9KTawUpbRNm0tU4B6oDJP
         YD/4nm2tlWRgjcKf6mvXe9TpjG513UdmmOTM35WjSPU+HyE5ZbIGqWsWcEWEkhOWR+aU
         MxaT90pgMFAbS7frrhOHbRPh3cjupAk1+epWJT9+of8bxRSKtrrih9nHy4IJfQ883Kqt
         5xt+drTAfZ1vK0DUYZdtD35M7ZvvFLZgfsJNLvqlM7U9fCuO2mu3rQxSjXrJI/otnxss
         iK0Iv4pc4NeGtTKWXsBsgjdMiASL6Ujcg27qJC/C0NwZnq40dSsS6P5RTH69V7lHk3/a
         3Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+6EqPkxS+upEiFHF3tvQSMAgw2qIzQnOXTK/To17+kY=;
        b=mcKUpvEmuQxnbxKNBWmoCjs+tBxL4zda810TFBvtZN0puXBOMoItoh8BUiOySL8rNJ
         aL68zJuOtaztlrlR3Edp89bAyHix8pSINNcZ7AkuIGHST4SotvPDJXWu7VLL3vni2tV9
         qbB8k5FLZJLjZfJ6Gdmrl1chvpef0NwbdccTVpVth+a0HWiNREBbfJ/0kIKaZGwZT2Zs
         tz8D2NktG+0a5aBjFstLgIfHpc5W2GdCdWFe3SjPp/CTprYLL/oqorHpw5DbJqBHi+T/
         gyITW4RO7BEVWBOGpiOzTxwksXU2E6mDoJ0naLQbWy6Q5cNjE+eKuNV6coHY8OirG810
         4anw==
X-Gm-Message-State: AOAM530efPGMM21OAn8Yke43NgmSBsMNt0vPeJC3jsTdaKMpUUqRWMxJ
        vJMwc1CgNHTBlop1t4bbOsgukzhS94hdRg==
X-Google-Smtp-Source: ABdhPJxIpnV9Q0G2RlTLWA2MHRww8vneSGB6xL09l4Kv3rvTZd5r5rC/C70NU7bILKd9iPEkfQb0Qg==
X-Received: by 2002:a05:6214:1586:: with SMTP id m6mr5069113qvw.15.1603838121669;
        Tue, 27 Oct 2020 15:35:21 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.74])
        by smtp.gmail.com with ESMTPSA id 63sm1757415qkn.9.2020.10.27.15.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:35:20 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 52303C3155; Tue, 27 Oct 2020 19:35:18 -0300 (-03)
Date:   Tue, 27 Oct 2020 19:35:18 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Davide Caratti <dcaratti@redhat.com>
Cc:     netdev@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        linux-sctp@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC PATCH net-next] net: use a dedicated tracepoint for
 kfree_skb_list()
Message-ID: <20201027223518.GA11029@localhost.localdomain>
References: <d4c179f46d00016ec418f6bf58ed01afedacd123.1603486318.git.dcaratti@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c179f46d00016ec418f6bf58ed01afedacd123.1603486318.git.dcaratti@redhat.com>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Oct 23, 2020 at 10:52:14PM +0200, Davide Caratti wrote:
> kfree_skb_list() calls kfree_skb(), thus triggering as many dropwatch
> events as the number of skbs in the list. This can disturb the analysis
> of packet drops, e.g. with fragmented echo requests generated by ICMP
> sockets, or with regular SCTP packets: when consume_skb() frees them,
> the kernel's drop monitor may wrongly account for several packet drops:
> 
>  consume skb()
>    skb_release_data()
>      kfree_skb_list()
>        kfree_skb() <-- false dropwatch event

Seems the problem lies with skb_release_data() calling
kfree_skb_list() while it should have been a, say, consume_skb_list(),
and not generate further kfree_skb calls.

Maybe a bool parameter on skb_release_data to signal that it should
call consume_skb_list (which doesn't exist) instead?

> 
> don't call kfree_skb() when freeing a skb list, use a dedicated
> tracepoint instead. By printing "cur" and "next", it also becomes
> possible to reconstruct the skb list from its members.

I like the new probe alone. It helps to have more visibility on drops
such as those from __dev_xmit_skb() and how they happen.

But as a solution to the problem stated, seems it can be confusing.
Say one is debugging a tx drop issue. AFAICT one would have to watch
both probe points anyway, as the drop could be on a layer below than
SCTP. So I'm not seeing how it helps much, other than possibly causing
drop_watch to miss drops (by not listening to the new trace point).

  Marcelo
