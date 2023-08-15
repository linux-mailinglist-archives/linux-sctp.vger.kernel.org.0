Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7177C907
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Aug 2023 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjHOIAC (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Aug 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjHOH7j (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Aug 2023 03:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DE1991;
        Tue, 15 Aug 2023 00:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 843E2650A6;
        Tue, 15 Aug 2023 07:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D7EC433C9;
        Tue, 15 Aug 2023 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692086376;
        bh=Ra/ZRooFm1RD+Jr8UIyTrZhtdGZen+1qL54uTgC2ytA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTqDcDBIDp3+pAs5NnnnJF8IGh8S19hb95fCQtt8zw2d/mjgvRnYefIMjQ44uxDr0
         G9EKilyGklBkcvAOIOOfDxK1wxPPTFlz/R3XjQBJC9BpsCGwInMYrzNgY1PbQjb30B
         AJlYRtS5xx/PET35GycyWklofmCO4jxXOp5rsP1TsSF+ZuIaL+Rkk6oHE6D5PCBg2u
         Iw1K8sGpU1MKNX3Jp5RAX76ZeOzwm6tPID8qygJbVga5Gb+GfmCyCzuQJR+T9dGhF/
         Y2rEejPI57IEqk7K2PsSbO6IROHT6ouMY/w7MdGx3psB4wklKlRUCGWLhC1bsgbP4L
         6nvMqom9I/HJQ==
Date:   Tue, 15 Aug 2023 09:59:32 +0200
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
Subject: Re: [PATCH nf] netfilter: set default timeout to 3 secs for sctp
 shutdown send and recv state
Message-ID: <ZNswZDSxsFHbrq/5@vergenet.net>
References: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Aug 13, 2023 at 12:55:35PM -0400, Xin Long wrote:
> In SCTP protocol, it is using the same timer (T2 timer) for SHUTDOWN and
> SHUTDOWN_ACK retransmission. However in sctp conntrack the default timeout
> value for SCTP_CONNTRACK_SHUTDOWN_ACK_SENT state is 3 secs while it's 300
> msecs for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV state.
> 
> As Paolo Valerio noticed, this might cause unwanted expiration of the ct
> entry. In my test, with 1s tc netem delay set on the NAT path, after the
> SHUTDOWN is sent, the sctp ct entry enters SCTP_CONNTRACK_SHUTDOWN_SEND
> state. However, due to 300ms (too short) delay, when the SHUTDOWN_ACK is
> sent back from the peer, the sctp ct entry has expired and been deleted,
> and then the SHUTDOWN_ACK has to be dropped.
> 
> Also, it is confusing these two sysctl options always show 0 due to all
> timeout values using sec as unit:
> 
>   net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd = 0
>   net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent = 0
> 
> This patch fixes it by also using 3 secs for sctp shutdown send and recv
> state in sctp conntrack, which is also RTO.initial value in SCTP protocol.
> 
> Note that the very short time value for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV
> was probably used for a rare scenario where SHUTDOWN is sent on 1st path
> but SHUTDOWN_ACK is replied on 2nd path, then a new connection started
> immediately on 1st path. So this patch also moves from SHUTDOWN_SEND/RECV
> to CLOSE when receiving INIT in the ORIGINAL direction.
> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
> Reported-by: Paolo Valerio <pvalerio@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

