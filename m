Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78E47B6738
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjJCLH6 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 07:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbjJCLH5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 07:07:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC293D8
        for <linux-sctp@vger.kernel.org>; Tue,  3 Oct 2023 04:07:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B01C433C7;
        Tue,  3 Oct 2023 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696331274;
        bh=TKTRuzbZsAq7tIREecfAg4xCUdtaJQmSFDV+y5mv320=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXcJOda5aQVaKB8JPkmr685VZQx3u8jEYb2yWvI+dJrpiHuCs9sMlJbQgZ0sROc0W
         M5MhlSBxigyQLIISmMrHuRCFPPoZGSXjp4ir9b0VjOTxnpqXdLlzxgG43T0MGL/HD5
         7MomRAQEbuOvZjDRwVvQHRNDw1cs2eW3hIeogH0TjuQSLYsXOwUGUX5n2klFVdCXbt
         WNFyobDIxZ32L90aYOeewFD1h2vVx/aym62FAYzNEfQS4LCow243rKaS4UFfj6hKPm
         ICxrieF2rLJT4UC/gb4uaURo6H99HXknZFkhrODddKmCfl5PdAEpJNvZX7GHJREldT
         B4COIW97Upuaw==
Date:   Tue, 3 Oct 2023 13:07:50 +0200
From:   Simon Horman <horms@kernel.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sctp: update transport state when processing a
 dupcook packet
Message-ID: <ZRv2BhAVBcR36Ilm@kernel.org>
References: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Oct 01, 2023 at 10:58:45AM -0400, Xin Long wrote:
> During the 4-way handshake, the transport's state is set to ACTIVE in
> sctp_process_init() when processing INIT_ACK chunk on client or
> COOKIE_ECHO chunk on server.
> 
> In the collision scenario below:
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]
> 
> when processing COOKIE_ECHO on 192.168.1.2, as it's in COOKIE_WAIT state,
> sctp_sf_do_dupcook_b() is called by sctp_sf_do_5_2_4_dupcook() where it
> creates a new association and sets its transport to ACTIVE then updates
> to the old association in sctp_assoc_update().
> 
> However, in sctp_assoc_update(), it will skip the transport update if it
> finds a transport with the same ipaddr already existing in the old asoc,
> and this causes the old asoc's transport state not to move to ACTIVE
> after the handshake.
> 
> This means if DATA retransmission happens at this moment, it won't be able
> to enter PF state because of the check 'transport->state == SCTP_ACTIVE'
> in sctp_do_8_2_transport_strike().
> 
> This patch fixes it by updating the transport in sctp_assoc_update() with
> sctp_assoc_add_peer() where it updates the transport state if there is
> already a transport with the same ipaddr exists in the old asoc.

Hi Xin Long,

I wonder if this warrants a fixes tag, and if so, perhaps:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")


> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
