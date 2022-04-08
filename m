Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD54F9AAF
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Apr 2022 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiDHQfv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Apr 2022 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiDHQfu (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Apr 2022 12:35:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13C15D051
        for <linux-sctp@vger.kernel.org>; Fri,  8 Apr 2022 09:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35DAFB82C01
        for <linux-sctp@vger.kernel.org>; Fri,  8 Apr 2022 16:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB4EC385A6;
        Fri,  8 Apr 2022 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649435624;
        bh=YIooipO84+zrwuquMG8xaB/YQbvMPS7g6Hhz+D2aajE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KZV8N7cGkWt5Xyer8Q+RRSHGOqKzrlJDDsgZAW1cpnMZFBAlIbp3TQ7aMNP5iFLiv
         kx7zNpOQeuTj7BlMPzftnvQuGi9PAmMGYSWs64owUpWBxbEVBa4oGkksl6uJi2MBtU
         V60Zm6EnnliJJlGZgNFuEmb82rhE8Uqig81wNR8HriiwRBob3BRDonaEbs/vai2/BK
         8LtQUlPp48gjYSsmORnfGWmndGwKVj7PbDmq69XxIPa9FIHpGLnyHCoC4uUOTxS4RY
         LrgSCILitG/7YxSRkAnbymnEzYExi8kZ8qKL9HJYJFqkBOv+8hsgKtx9yWtolg8pEO
         j1jmSyiw3k+Bg==
Date:   Fri, 8 Apr 2022 09:33:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] sctp: Initialize daddr on peeled off socket
Message-ID: <20220408093342.022431f7@kernel.org>
In-Reply-To: <YlAsCio+PCnuSmeK@ntb.petris.klfree.czf>
References: <20220307195929.621359-1-oss@malat.biz>
        <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <YlAsCio+PCnuSmeK@ntb.petris.klfree.czf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, 8 Apr 2022 14:35:22 +0200 Petr Malat wrote:
> On Mon, Mar 07, 2022 at 01:33:21PM -0800, Jakub Kicinski wrote:
> > On Mon,  7 Mar 2022 20:59:29 +0100 Petr Malat wrote:  
> > > Function sctp_do_peeloff() wrongly initializes daddr of the original
> > > socket instead of the peeled off one, which makes getpeername() return
> > > zeroes instead of the primary address. Initialize the new socket
> > > instead.  
> > 
> > Could you add a Fixes tag?  
> 
> Hi Jakub,
> have you got some time to review the updated version with "Fixes" tag
> added?

Thanks for adding the tag. Long story short if you got no replies from
SCTP folks on the posting to linux-sctp@ repost with netdev@ added.
That way it'll get into general networking patchwork / patch processing
queue.

> The issue has been in the kernel for a while, because my app is using
> peer addresses for storing sockets in a hash table and the hash table can
> handle collisions, thus I haven't noticed it's broken until I dumped
> the hash table while working on another problem.
