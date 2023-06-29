Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76917423A1
	for <lists+linux-sctp@lfdr.de>; Thu, 29 Jun 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjF2KDl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 29 Jun 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjF2KBk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 29 Jun 2023 06:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B73582;
        Thu, 29 Jun 2023 03:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1369D6150C;
        Thu, 29 Jun 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E0E1C433C9;
        Thu, 29 Jun 2023 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688032821;
        bh=6BSYODeXAvBc1bYzqyJYg+UUhE64/mpp9Tu40F5CwoU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oDHVOrr/5JM70o8y0DmxBWIVGGiaWWXfzS94TATG7gX18UJiEXtcnfnbjgS14itYd
         RjDupaiQALNLc4zEyV9ElOhba0fYXYHoDfJ8tZlsfgOg1DJaaeZZK48ThBknPuQxOc
         /7gEQdxojynYXj5ZWNDMbsuGzHRw6KBoX5a+8Wna1pZuuPXLPuKXxMndlqBCyoRav7
         mGuQVJGE6lMiPKEWQdF9qjiHgVRjXoivbJ/ASo3o5t76qKE40VFbLNBe5mw9QHMw4u
         5oN9H5Ihhy4pdzSmD/s49gZuNXWuInDrpEWATZHph7ul1/wK8ZNnhRUc3KEzn2s27h
         gp9+ZfzIrhcnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40A04C395D8;
        Thu, 29 Jun 2023 10:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168803282125.4865.3870530612120862542.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jun 2023 10:00:21 +0000
References: <20230627120340.19432-1-dg573847474@gmail.com>
In-Reply-To: <20230627120340.19432-1-dg573847474@gmail.com>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Jun 2023 12:03:40 +0000 you wrote:
> As &net->sctp.addr_wq_lock is also acquired by the timer
> sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
> at sctp_auto_asconf_init() seems should disable irq since it is called
> from sctp_accept() under process context.
> 
> Possible deadlock scenario:
> sctp_accept()
>     -> sctp_sock_migrate()
>     -> sctp_auto_asconf_init()
>     -> spin_lock(&net->sctp.addr_wq_lock)
>         <timer interrupt>
>         -> sctp_addr_wq_timeout_handler()
>         -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)
> 
> [...]

Here is the summary with links:
  - sctp: fix potential deadlock on &net->sctp.addr_wq_lock
    https://git.kernel.org/netdev/net/c/6feb37b3b06e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


