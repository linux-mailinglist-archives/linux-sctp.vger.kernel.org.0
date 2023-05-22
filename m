Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2463170B9A5
	for <lists+linux-sctp@lfdr.de>; Mon, 22 May 2023 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjEVKKY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 May 2023 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjEVKKX (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 May 2023 06:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A27BB
        for <linux-sctp@vger.kernel.org>; Mon, 22 May 2023 03:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F883612D5
        for <linux-sctp@vger.kernel.org>; Mon, 22 May 2023 10:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB8B4C433EF;
        Mon, 22 May 2023 10:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684750219;
        bh=zSEv+8VIY7xLjnhHnCLKiR1wt9gxKCwgdbTZIJjIbYA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EUxXtOL5bUMTZR9tE88iZqGO4j/lqpKY5tEe4Aluj4FdgTQEgqIsElkstPk6/QJv8
         NTg2jr2ZkOBp/NYXceyigJKX1d7X3heaYDHJ81dHZBz0bBjNdgylSKaEdQAQNfZF/i
         Q+0+y6iCOb7MztSaxM166okPbb8g5FFAfOoQC8Zi8dF8lQLCtReZ82+wKpYQrunwIg
         OM7XXJWarxJx76qEUE+dDARGf/VJ9DeGq5Xn8Sz+oQN8ziWM7gxdmJJ3kqEj6LgTja
         MVk9euZpr+BRjBAXV4kmk7J4KjIniCtmUpt0++aAaNxU8jqlTflgcGlh5C0oyorvGK
         TorSJLMOMTk9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA89DE22AEC;
        Mon, 22 May 2023 10:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] sctp: fix an issue that plpmtu can never go to complete
 state
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168475021969.5966.8685765477153236866.git-patchwork-notify@kernel.org>
Date:   Mon, 22 May 2023 10:10:19 +0000
References: <79f4da2e037fb14258865db606a102bf587404f0.1684440180.git.lucien.xin@gmail.com>
In-Reply-To: <79f4da2e037fb14258865db606a102bf587404f0.1684440180.git.lucien.xin@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, marcelo.leitner@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 May 2023 16:03:00 -0400 you wrote:
> When doing plpmtu probe, the probe size is growing every time when it
> receives the ACK during the Search state until the probe fails. When
> the failure occurs, pl.probe_high is set and it goes to the Complete
> state.
> 
> However, if the link pmtu is huge, like 65535 in loopback_dev, the probe
> eventually keeps using SCTP_MAX_PLPMTU as the probe size and never fails.
> Because of that, pl.probe_high can not be set, and the plpmtu probe can
> never go to the Complete state.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] sctp: fix an issue that plpmtu can never go to complete state
    https://git.kernel.org/netdev/net/c/6ca328e985cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


