Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2B7B8E9B
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Oct 2023 23:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjJDVU3 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Oct 2023 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjJDVU3 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Oct 2023 17:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098DBF;
        Wed,  4 Oct 2023 14:20:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C55C433C8;
        Wed,  4 Oct 2023 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696454425;
        bh=vCDsYJ5xVt4Ez1p0mhyJNNL2hHtuRq9Cdm7oVL9/si4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vr7s+8HYyFIb18fcAc+MHva+cwZWo8xcMCMK2/9jmbFz+0Ua1wTo2XWy4OcoRrb6P
         XIjz6m35VpZF0bA2IL4GhUyf4jQhupzmSntEE8xue7j7+9RrmnwEsbCDfZm6SIMIBI
         kcji3HiB+KRfXhqsao2Oqn58R/WIZdOAAV8Jw/59DzgQHtf5HycBgair0uzT41coyK
         oig2HWVbnQO1xv1j8DovY0VeoK0zNPNoxeEMzTMUDUj670gppBirCe4kSTTlpkpNQ7
         FZ9hsgVbBrLp1c2bLvS69/kTtUdCKRF8+ZB+7jRYILuvNZHF/Fvm/WgM/IwLTw5uIk
         NcbkUUhmqIJAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B61FE632D7;
        Wed,  4 Oct 2023 21:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next] sctp: Spelling s/preceeding/preceding/g
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169645442543.1877.367473311797088363.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 21:20:25 +0000
References: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
In-Reply-To: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Sep 2023 14:17:48 +0200 you wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  net/sctp/sm_make_chunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] sctp: Spelling s/preceeding/preceding/g
    https://git.kernel.org/netdev/net-next/c/2b464cc2fd57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


