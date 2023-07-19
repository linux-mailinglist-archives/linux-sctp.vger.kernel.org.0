Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2757759476
	for <lists+linux-sctp@lfdr.de>; Wed, 19 Jul 2023 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGSLks (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 Jul 2023 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGSLkq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 Jul 2023 07:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1BD1FC1;
        Wed, 19 Jul 2023 04:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32E1B6164F;
        Wed, 19 Jul 2023 11:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C881C433C8;
        Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689766820;
        bh=O7KE6QURVyG2deYSiL5ojlS/R2PfvC0hv2Gs+IrY7Rs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SM9HlMi7I0VLwP3EQW15edoyGCWkpKwaeHJi4bIXhmZkYQcIDjBgHb/7Jak7n5bFS
         CyCkOqV4zi2haiMnI+3xG1kIKn96Zv5YFgLp4A1N6ikTxWt75ZT2e5MPKiuw0xdGk9
         fLwyr40vmJKeBNs0L5MRrwKptRLsxuTI0PpgiY5EUocQq5QSbtEn1FWTM9Zx629fYG
         TONpweJHqoRh9hI4LJeo4Hldz+pOrVKPnSPLk/AA34esMprz2YvgGo3CD4xVkev4e2
         R5G509oCwCJAkVR6irYLIr4rCqQ2CMQ7qRNyPR1/9Dw7gNZyCeqitfgWTfl3ET7+8d
         GUNvmoG0K+Q7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A891E21EFA;
        Wed, 19 Jul 2023 11:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: Remove more RTO_ONLINK users.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168976682016.23748.15879521041642434800.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 11:40:20 +0000
References: <cover.1689600901.git.gnault@redhat.com>
In-Reply-To: <cover.1689600901.git.gnault@redhat.com>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org, pablo@netfilter.org,
        laforge@gnumonks.org, osmocom-net-gprs@lists.osmocom.org,
        dccp@vger.kernel.org, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, linux-sctp@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 15:53:24 +0200 you wrote:
> Code that initialise a flowi4 structure manually before doing a fib
> lookup can easily avoid overloading ->flowi4_tos with the RTO_ONLINK
> bit. They can just set ->flowi4_scope correctly instead.
> 
> Properly separating the routing scope from ->flowi4_tos will allow to
> eventually convert this field to dscp_t (to ensure proper separation
> between DSCP and ECN).
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] gtp: Set TOS and routing scope independently for fib lookups.
    https://git.kernel.org/netdev/net-next/c/b16b50476714
  - [net-next,2/3] dccp: Set TOS and routing scope independently for fib lookups.
    https://git.kernel.org/netdev/net-next/c/2d6c85ca3eb8
  - [net-next,3/3] sctp: Set TOS and routing scope independently for fib lookups.
    https://git.kernel.org/netdev/net-next/c/ba80e20d7f3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


