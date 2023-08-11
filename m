Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8689877858E
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Aug 2023 04:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHKCkZ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 10 Aug 2023 22:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjHKCkY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 10 Aug 2023 22:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643362D65
        for <linux-sctp@vger.kernel.org>; Thu, 10 Aug 2023 19:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037AD62891
        for <linux-sctp@vger.kernel.org>; Fri, 11 Aug 2023 02:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C939C433CB;
        Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691721622;
        bh=dlLx6L5zKOsRJgI7/v+ZzPVU4r2Gh7u9HezzxdL/GK4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ew0WDR08VfoOw2mBWogc3VsHmARwr2CO8kpYeRTF7mUup2BxKW1EIB1llS19YpAbb
         c5Pd+dKpjSGgndk6BsylUJaGGCUFFZAoQQgZdQaf6zsaErWixGd2wYxlFm+Y5ypJT2
         v5nwMI4Guz+CXl/LbI2n5TA9FBWmHsj2pjd1t5hXrcxrPtX+SL+jtcQQHmcQSLt1eG
         pVywyfkG/BP0fbUdO3Bk2hLg2yxOeHvH40aER7xhsjcm0CVmyZ7Cp34bmE7wAs4rdd
         o/duRI0c4c0LuVHfObfKKvoQuWVRClDYIn16ylygNPkHvA1UvQU5GDvkhLBbsS5YAL
         j96BI5Fs9D5nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41076E21ECC;
        Fri, 11 Aug 2023 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused declaration
 sctp_backlog_migrate()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169172162226.18522.10036459431907109450.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 02:40:22 +0000
References: <20230809142323.9428-1-yuehaibing@huawei.com>
In-Reply-To: <20230809142323.9428-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Aug 2023 22:23:23 +0800 you wrote:
> Commit 61c9fed41638 ("[SCTP]: A better solution to fix the race between sctp_peeloff()
> and sctp_rcv().") removed the implementation but left declaration in place. Remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/sctp.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] sctp: Remove unused declaration sctp_backlog_migrate()
    https://git.kernel.org/netdev/net-next/c/afa2420cff54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


