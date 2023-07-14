Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37929753680
	for <lists+linux-sctp@lfdr.de>; Fri, 14 Jul 2023 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjGNJag (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 14 Jul 2023 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjGNJae (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 14 Jul 2023 05:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9AD359E;
        Fri, 14 Jul 2023 02:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A989661CC7;
        Fri, 14 Jul 2023 09:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B67AC433C7;
        Fri, 14 Jul 2023 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689327021;
        bh=IIWAe0NQt7hQ52AYeH7Fl8uRHTVIRV1HOhISTeoKp4k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JJL43PYwtuw22nfaCtzyQV901socAiuVhOT4jCeHewKIpKvLtasXZ00VnnweXy088
         JwVV23M1nzjEP3DojBGqNyOiChphOlYH4Orh6ALso35jneLiZgr6aSjeRhRoZ6GcDZ
         eYpoBNFuJ2Hl9NCKx4b2o9NTzmsjOqvHnWwKMVXvH4MTpIBzpcaJMAjme0F2Bc5weW
         rTtvIGh3aVRKz4waeygyPaIkVRCoyakXdagqvR7i9gbGKC2RC0DXxdO386GCRIIN3K
         mUykM0pYhdPMjiPsuuGiB+qYPZcY41+sE/pKWDVw7pjtsxT98I0yctJgMH+1xb2a4u
         nUF94pLyvYcBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E45F4E49BBF;
        Fri, 14 Jul 2023 09:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932702093.18845.9473507199122445355.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 09:30:20 +0000
References: <ZLA0ILTAZsIzxR6c@debian.debian>
In-Reply-To: <ZLA0ILTAZsIzxR6c@debian.debian>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, herbert@gondor.apana.org.au,
        andrew@daynix.com, jasowang@redhat.com,
        willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 10:28:00 -0700 you wrote:
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation:
> 
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [v2,net] gso: fix dodgy bit handling for GSO_UDP_L4
    https://git.kernel.org/netdev/net/c/9840036786d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


