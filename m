Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BBF7B994F
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Oct 2023 02:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjJEAkh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Oct 2023 20:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjJEAkg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Oct 2023 20:40:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F80CE
        for <linux-sctp@vger.kernel.org>; Wed,  4 Oct 2023 17:40:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF8BC433C8;
        Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696466427;
        bh=GurQxuIsxPqA7aUBoeYQZ/c+GTIWGiw7bAc0qNwQJJc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IKDtNREQOHWiCFEv/rxEPHxMVZs576br6eANNosTQ2xxEScOudV3FtdzY7km5LCka
         u1nuTyN6MSu5psose10mBBmJHXmZMwfUPG1V4ND857egNstrGKzNDVbYBq63AFh814
         g4m+PhY6KC9CbU7v8ymmNCOxxRwBC7hGdbuHYh03oUUymmiM+eueNAbUZuGlD0FUJp
         /NgelFbI2l3LXq2UplwQY7MKgCiwugXNVYSTPD4vXN1/OY+c9wgiteg2EpmTRU8ytg
         wkDvVhIwEnnXI0bMtJzbQLCBAEo5NEjx23JiJwftrahon7r13zCb7dgAwlFVCmsiMk
         rCqctjSwin1GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3A59E632D6;
        Thu,  5 Oct 2023 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: update hb timer immediately after users change
 hb_interval
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169646642773.7507.5611400283325453928.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 00:40:27 +0000
References: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
In-Reply-To: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, marcelo.leitner@gmail.com,
        xufeng.zhang@windriver.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Oct 2023 11:04:20 -0400 you wrote:
> Currently, when hb_interval is changed by users, it won't take effect
> until the next expiry of hb timer. As the default value is 30s, users
> have to wait up to 30s to wait its hb_interval update to work.
> 
> This becomes pretty bad in containers where a much smaller value is
> usually set on hb_interval. This patch improves it by resetting the
> hb timer immediately once the value of hb_interval is updated by users.
> 
> [...]

Here is the summary with links:
  - [net] sctp: update hb timer immediately after users change hb_interval
    https://git.kernel.org/netdev/net/c/1f4e803cd9c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


