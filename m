Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CB7F08C0
	for <lists+linux-sctp@lfdr.de>; Sun, 19 Nov 2023 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKSUK2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 19 Nov 2023 15:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSUK1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 19 Nov 2023 15:10:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BDE115;
        Sun, 19 Nov 2023 12:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13EC5C433C7;
        Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700424624;
        bh=RfcmcSJXbNshmCCmuIQ3OLjalTX/zBZa+mvG0+u9+OQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j45PWymqb1xFb4zs9J1IsJFg8HnooUak2A+BOQquFgMsnDmBkA/r2GHxyRsPbiMwz
         1tNm/mpxE8jdAzOzOV0JVzh3Jxst2rwdYWekOb0BZS79Q+FAdSbcgfP64yy/KALD48
         4icnL9dHKIgrw3/g/JXuDxTwdS2H+tl3Mp9JuplIkuE9q4gOnDksLeVWDeEsXUwRhW
         K5xrICNaBvCnx/1/YmlSa67kSdLhrRcRkVbW2Q+ewBH3dnrW4KVZ2VnUpRWJN+9yAn
         gWbzAnqavepenz6VDL01VAXVw74N1vt1X0fkZTp//ZFghNrjM3ZXsOR3tnocCGNZXB
         7r7xXBklox58g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED963C4316B;
        Sun, 19 Nov 2023 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170042462396.21508.74186037666655435.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Nov 2023 20:10:23 +0000
References: <20231119033006.442271-1-kuba@kernel.org>
In-Reply-To: <20231119033006.442271-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, dsahern@kernel.org, matttbe@kernel.org,
        martineau@kernel.org, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        jmaloy@redhat.com, ying.xue@windriver.com, sgarzare@redhat.com,
        bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, kuniyu@amazon.com,
        mptcp@lists.linux.dev, linux-sctp@vger.kernel.org,
        linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        virtualization@lists.linux.dev, bpf@vger.kernel.org
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

On Sat, 18 Nov 2023 19:30:06 -0800 you wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to all the sock diag modules in one fell swoop.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: dsahern@kernel.org
> CC: matttbe@kernel.org
> CC: martineau@kernel.org
> CC: marcelo.leitner@gmail.com
> CC: lucien.xin@gmail.com
> CC: kgraul@linux.ibm.com
> CC: wenjia@linux.ibm.com
> CC: jaka@linux.ibm.com
> CC: alibuda@linux.alibaba.com
> CC: tonylu@linux.alibaba.com
> CC: guwen@linux.alibaba.com
> CC: jmaloy@redhat.com
> CC: ying.xue@windriver.com
> CC: sgarzare@redhat.com
> CC: bjorn@kernel.org
> CC: magnus.karlsson@intel.com
> CC: maciej.fijalkowski@intel.com
> CC: kuniyu@amazon.com
> CC: mptcp@lists.linux.dev
> CC: linux-sctp@vger.kernel.org
> CC: linux-s390@vger.kernel.org
> CC: tipc-discussion@lists.sourceforge.net
> CC: virtualization@lists.linux.dev
> CC: bpf@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
    https://git.kernel.org/netdev/net/c/938dbead34cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


