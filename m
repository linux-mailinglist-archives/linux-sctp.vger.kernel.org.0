Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06126FDC86
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 13:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjEJLUY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJLUX (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 07:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723AC2;
        Wed, 10 May 2023 04:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 473E3636D4;
        Wed, 10 May 2023 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B650C433A1;
        Wed, 10 May 2023 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683717620;
        bh=R683OO2WtAMNBmdAOUEpOQQrWtiQtyN6X0UBBAnfdis=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rye+/od6uS5Z5e3XNYZSQGsGhB1XCQ/6A1GwVMQ7BbLpWXJp4K/wfy1xX1w8jhULp
         mT1SobUnJJdsAbE6a4ew/ex3D33bfAWr+okDKd+/TTNAtyXn1FIp3WyrlPBAyaPQNI
         /WMyyVLAggXI3AB1CYwPSoJteVVI/Ox2zLLVohR0wRCIj5mU6vh9B2btlNA85Uunk/
         731fl78cBTYbzL9Hf9KNqhk7bnjRRQupksVQzOWzfS5bsmOarx8PeRqaglTumT0Kv8
         9IIG1u/3MCY3RTHpesB3yevx/yOX2QpXfOglQmfyKiko5bkUSVUamSJpG3uJKCPYn/
         rs6ccKOhaaBsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 669BBE270C4;
        Wed, 10 May 2023 11:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] sctp: fix a potential OOB access in
 sctp_sched_set_sched()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168371762041.15306.11198437734133990121.git-patchwork-notify@kernel.org>
Date:   Wed, 10 May 2023 11:20:20 +0000
References: <20230510092344.1390444-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20230510092344.1390444-1-Ilia.Gavrilov@infotecs.ru>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     nhorman@tuxdriver.com, simon.horman@corigine.com,
        marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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
by David S. Miller <davem@davemloft.net>:

On Wed, 10 May 2023 09:23:40 +0000 you wrote:
> From: "Ilia.Gavrilov" <Ilia.Gavrilov@infotecs.ru>
> 
> The 'sched' index value must be checked before accessing an element
> of the 'sctp_sched_ops' array. Otherwise, it can lead to OOB access.
> 
> Note that it's harmless since the 'sched' parameter is checked before
> calling 'sctp_sched_set_sched'.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] sctp: fix a potential OOB access in sctp_sched_set_sched()
    https://git.kernel.org/netdev/net-next/c/059fa492027e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


