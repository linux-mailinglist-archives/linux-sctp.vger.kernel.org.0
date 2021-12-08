Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47746D91F
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Dec 2021 18:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhLHRFt (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 8 Dec 2021 12:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhLHRFs (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 8 Dec 2021 12:05:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C16C061746
        for <linux-sctp@vger.kernel.org>; Wed,  8 Dec 2021 09:02:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so3735877wmi.1
        for <linux-sctp@vger.kernel.org>; Wed, 08 Dec 2021 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wmv1cfuLhmgRmmPI+EDJKcsb0BGLqxffNGOauuSWXFY=;
        b=NsHNZgygY8lIlXgFS8Pr4iEQQ2fGfU+ToPLIjG35El2o8GjZpM0Ii73xAju1KJziUn
         Ll4FJjaUgy6dQUnvEb/0cl0gCQjXK8T7iiSs3pHb/UGiA1sUxn7aO8loyLhk4RVryaQi
         TU6Kx5CN+ooYYzzqt58Y9c0o1aDGttWDmq8QQE+4vbXzCzPlpQk5/FY9oNkPXxt3RXdG
         K40wf8yln6wYgOpzmSbVNo8WE78y85C8oTy31N4EBngJqUI7J8Uh0JwCemb68zphgu0g
         0Y4/frrZ1iZ+6ctsfhhtgTd8rEFNc2u/R8EsLjXRJiLLYD5bJHYN3bz4cCJn8mqXRvI0
         JQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wmv1cfuLhmgRmmPI+EDJKcsb0BGLqxffNGOauuSWXFY=;
        b=OAmepFxXFG0N+YDYN99aI8w0KzMsQBsYZ70NMUeZzXxPyTf1zXPTwC0czMO9bw7ycm
         1jHp83qaPYx4Y2IGjSoo6At943t12+lO2c51nuWQKaz/gOlSs9qVLZdLehlfuenOrf9c
         Nqoql6/m0bGu52DhizeiXGpwAqOzAJf45+fevWb83SqNUWpQR1fhtTMWS0PC18VqlvHL
         NFqolKOE/PLn8GyWsvugx7NQd2JCN6C7Wo4hioImjaZQ/ae6CGNEaeOwN8VbbE7R5tnU
         lrhkklmtpn+g5p3jZsoeYjk6YjmhiwNJQsl+cWRHQXQUxpQsJolGDvjadoa1x4ShOjVG
         xeDQ==
X-Gm-Message-State: AOAM531YSfH1rBBYNJtPhbvoe6KvVfK4nAjfPmytJeZnWDrCeI6HMhi+
        gud+1OU2cIcErouKnvyJYyBvvAnl5b9Sj9Wv
X-Google-Smtp-Source: ABdhPJyC11uszuyYfzMN3TAwMjyQ8BY70HPd6Np8MU6PRZChh8NmSre1RuxvP/QVGMYWVLQUSizKUQ==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr17120991wmq.54.1638982934887;
        Wed, 08 Dec 2021 09:02:14 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id l2sm6844928wmq.42.2021.12.08.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:02:14 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:02:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        lksctp developers <linux-sctp@vger.kernel.org>,
        "H.P. Yarroll" <piggy@acm.org>,
        Karl Knutson <karl@athena.chicago.il.us>,
        Jon Grimm <jgrimm@us.ibm.com>,
        Xingang Guo <xingang.guo@intel.com>,
        Hui Huang <hui.huang@nokia.com>,
        Sridhar Samudrala <sri@us.ibm.com>,
        Daisy Chang <daisyc@us.ibm.com>,
        Ryan Layer <rmlayer@us.ibm.com>,
        Kevin Gao <kevin.gao@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] sctp: Protect cached endpoints to prevent possible
 UAF
Message-ID: <YbDlFFVPm/MYEoOQ@google.com>
References: <20211208165434.2962062-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208165434.2962062-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, 08 Dec 2021, Lee Jones wrote:

> The cause of the resultant dump_stack() reported below is a
> dereference of a freed pointer to 'struct sctp_endpoint' in
> sctp_sock_dump().
> 
> This race condition occurs when a transport is cached into its
> associated hash table then freed prior to its subsequent use in
> sctp_diag_dump() which uses sctp_for_each_transport() to walk the
> (now out of date) hash table calling into sctp_sock_dump() where the
> dereference occurs.
> 
> To prevent this from happening we need to take a reference on the
> to-be-used/dereferenced 'struct sctp_endpoint' until such a time when
> we know it can be safely released.
> 
> When KASAN is not enabled, a similar, but slightly different NULL
> pointer derefernce crash occurs later along the thread of execution in
> inet_sctp_diag_fill() this time.
> 
>   BUG: KASAN: use-after-free in sctp_sock_dump+0xa8/0x438 [sctp_diag]
>   Call trace:
>    dump_backtrace+0x0/0x2dc
>    show_stack+0x20/0x2c
>    dump_stack+0x120/0x144
>    print_address_description+0x80/0x2f4
>    __kasan_report+0x174/0x194
>    kasan_report+0x10/0x18
>    __asan_load8+0x84/0x8c
>    sctp_sock_dump+0xa8/0x438 [sctp_diag]
>    sctp_for_each_transport+0x1e0/0x26c [sctp]
>    sctp_diag_dump+0x180/0x1f0 [sctp_diag]
>    inet_diag_dump+0x12c/0x168
>    netlink_dump+0x24c/0x5b8
>    __netlink_dump_start+0x274/0x2a8
>    inet_diag_handler_cmd+0x224/0x274
>    sock_diag_rcv_msg+0x21c/0x230
>    netlink_rcv_skb+0xe0/0x1bc
>    sock_diag_rcv+0x34/0x48
>    netlink_unicast+0x3b4/0x430
>    netlink_sendmsg+0x4f0/0x574
>    sock_write_iter+0x18c/0x1f0
>    do_iter_readv_writev+0x230/0x2a8
>    do_iter_write+0xc8/0x2b4
>    vfs_writev+0xf8/0x184
>    do_writev+0xb0/0x1a8
>    __arm64_sys_writev+0x4c/0x5c
>    el0_svc_common+0x118/0x250
>    el0_svc_handler+0x3c/0x9c
>    el0_svc+0x8/0xc

This looks related (reported 3 years ago!)

  https://lore.kernel.org/all/20181122131344.GD31918@localhost.localdomain/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
