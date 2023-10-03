Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3D7B6945
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 14:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJCMo4 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjJCMoz (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 08:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF091;
        Tue,  3 Oct 2023 05:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7789CC433C7;
        Tue,  3 Oct 2023 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696337092;
        bh=yxVFqdrVypVYPhUgP12T4SsGPkXaA4vzqa7NeiFSR9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0i4klhBXUIXUlg47tK0NRlTedyhHHdA8YYeevRcp1em7QNl37cFoRiT09JUuHAUL
         2+M+SNVyeHFBJB83Kdwe+NgXCXeznXXPiWUkH/4O3GbcpW2iUNYxvhTI5CSYlvGggr
         TBJHhRq53IcM0BHSRxI880efmAs/RoabBsEgEA3IKd5GR4uaFSSwLI3j1ivaRhwSyc
         2DK/S0gqAmq3REMhlNcBFn100K10pcBjNF8+8van2GMGRq1ZdF+dAZroOeIEiYcnzD
         JOiVbo0QITiuBTMCjCpAtLrOkTJiB6w0dNtxsUbO5ukafcpcFRRAV2vOF/5nXKDAa3
         epvChKHD2eRrQ==
Date:   Tue, 3 Oct 2023 14:44:48 +0200
From:   Simon Horman <horms@kernel.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <ZRwMwFgCCM3nMeBG@kernel.org>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Oct 01, 2023 at 11:07:48AM -0400, Xin Long wrote:
> In Scenario A and B below, as the delayed INIT_ACK always changes the peer
> vtag, SCTP ct with the incorrect vtag may cause packet loss.
> 
> Scenario A: INIT_ACK is delayed until the peer receives its own INIT_ACK
> 
>   192.168.1.2 > 192.168.1.1: [INIT] [init tag: 1328086772]
>     192.168.1.1 > 192.168.1.2: [INIT] [init tag: 1414468151]
>     192.168.1.2 > 192.168.1.1: [INIT ACK] [init tag: 1328086772]
>   192.168.1.1 > 192.168.1.2: [INIT ACK] [init tag: 1650211246] *
>   192.168.1.2 > 192.168.1.1: [COOKIE ECHO]
>     192.168.1.1 > 192.168.1.2: [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: [COOKIE ACK]
> 
> Scenario B: INIT_ACK is delayed until the peer completes its own handshake
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *
> 
> This patch fixes it as below:
> 
> In SCTP_CID_INIT processing:
> - clear ct->proto.sctp.init[!dir] if ct->proto.sctp.init[dir] &&
>   ct->proto.sctp.init[!dir]. (Scenario E)
> - set ct->proto.sctp.init[dir].
> 
> In SCTP_CID_INIT_ACK processing:
> - drop it if !ct->proto.sctp.init[!dir] && ct->proto.sctp.vtag[!dir] &&
>   ct->proto.sctp.vtag[!dir] != ih->init_tag. (Scenario B, Scenario C)
> - drop it if ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
>   ct->proto.sctp.vtag[!dir] != ih->init_tag. (Scenario A)
> 
> In SCTP_CID_COOKIE_ACK processing:
> - clear ct->proto.sctp.init[dir] and ct->proto.sctp.init[!dir]. (Scenario D)
> 
> Also, it's important to allow the ct state to move forward with cookie_echo
> and cookie_ack from the opposite dir for the collision scenarios.
> 
> There are also other Scenarios where it should allow the packet through,
> addressed by the processing above:
> 
> Scenario C: new CT is created by INIT_ACK.
> 
> Scenario D: start INIT on the existing ESTABLISHED ct.
> 
> Scenario E: start INIT after the old collision on the existing ESTABLISHED ct.
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>   (both side are stopped, then start new connection again in hours)
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 242308742]
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Hi,

as a fix I wonder if this warrants a Fixes tag.
Perhaps our old friend:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
