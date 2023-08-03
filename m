Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8376DD97
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Aug 2023 03:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjHCBx6 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Aug 2023 21:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjHCBw7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Aug 2023 21:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E967549F5;
        Wed,  2 Aug 2023 18:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B1DB61BBA;
        Thu,  3 Aug 2023 01:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAEC5C433C9;
        Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691027425;
        bh=TMmuxpQZ2+VhmgcxbFZ8sMilyWCb56CyDDsFwvXvYmM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iJiGpTayK2Gneo/DIaSUloHeEtWiYpzeUWuwvdEIhv+ZnlANkmbc7IcPUFrZEIcsU
         DmuxSneEciw1sBSB3t7B5eYPOHCieGL1/Y8FOoZPLXOZVC2YwXu8S3kz8Q+QhKe0uW
         Rw1vUnxkk9Xg+5S+nVrmPvAcb6iz5fGyF7PFfFsnynkfRaQ7C4c1Rp2YZlvRje/Tpz
         Gu7IeFPKZnATTDCTeekXsvGCqk87Zmi1497w0o9zN8drS7ynsd9YEzsFG7gSs6vqiP
         e4hHNKQ+F3xaxuKWPkqEApvHuS9370egCDYG5fWIYNfzp09uwsKKKv5wkw2E5pdHiB
         CCuDLKU8rhs7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A03FFE270D7;
        Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused function declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169102742565.3352.5989101215364344178.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 01:50:25 +0000
References: <20230731141030.32772-1-yuehaibing@huawei.com>
In-Reply-To: <20230731141030.32772-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 22:10:30 +0800 you wrote:
> These declarations are never implemented since beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/sm.h      | 3 ---
>  include/net/sctp/structs.h | 2 --
>  2 files changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] sctp: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/49c467dca39d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


