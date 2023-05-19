Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2142709B04
	for <lists+linux-sctp@lfdr.de>; Fri, 19 May 2023 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjESPPd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjESPPc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 11:15:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAEBCF;
        Fri, 19 May 2023 08:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FF6E65897;
        Fri, 19 May 2023 15:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0896BC4339B;
        Fri, 19 May 2023 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684509330;
        bh=16KHEhda17R0uNXkQJHXQVrobh41ZoiUCwXJdgtxDD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p6EYn1BZXuMfM8CtTTKN7KtAAWXREvTpcAmBw49BmFLfAExk/ZJu+zT1Bcveqew3f
         4yBzHEpEFeQNIKciEdvSB+HHhL8+fUDuf+suVvtk3wnbHDHxTT29TbEI9hC9QszG7R
         9l10yRvtue+XsivRFuDgsSsm9JZDlWNuYj5sCe0eZPfoN2/TtOoT9xM1lIaFy/DDQX
         Z0QT5Z5sbqkgYAQI8objP2GG49dMUIEuUfQd8frsG5M5Kl5c7k+9iBX6y6yl4Tkdi/
         jEfC2XE07PCOrhU0wbYYoqP0JUqnaiLECjzKvze65VIfpUSSVLwjNnJGlpq/rUbngG
         gPWtmKCfyAcuA==
Date:   Fri, 19 May 2023 08:15:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     axboe@kernel.dk, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        courmisch@gmail.com, nhorman@tuxdriver.com, asml.silence@gmail.com,
        alex.aring@gmail.com, dccp@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
        marcelo.leitner@gmail.com, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, leit@fb.com, David.Laight@ACULAB.COM,
        dsahern@kernel.org
Subject: Re: [PATCH 0/1] net: ioctl: Use kernel buffer on proto ioctl
 callbacks
Message-ID: <20230519081526.59411533@kernel.org>
In-Reply-To: <20230519135821.922326-1-leitao@debian.org>
References: <20230519135821.922326-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, 19 May 2023 06:58:20 -0700 Breno Leitao wrote:
> With the implementation of network ioctl on io_uring[1], Willem
> suggested[2] that the "struct proto" ioctls functions should be reused,
> instead of duplicating the code.
> For that, the ioctl callbacks need to be more flexible, and avoid
> operating on userspace buffers (doing get/put_user()) directly on the
> callbacks. This patch adds this flexibility, so, the io_uring plumbing
> becomes more clean, avoiding duplicating code. This may also benefit
> BPF.
> 
> For that, a wrapper is created, which will copy from/to userspace, and
> the ioctl callback will rely on the wrapper to do userspace memory
> copies.
> 
> I've tested this patch in three different ways:
> 1) Created a simple testcase for TCP/UDP [3]
> 2) Run relevant LTP tests, such as: sockioctl, setsockopt, bind, sendto,
> 				    fanout, ns-udpsender, etc
> 3) Run basics network selftests
> 
> PS: There are some `strcmp()` in the `sock_skprot_ioctl()`, that I was
> not able to find a better way to deal with it. Any feedback is
> appreciated.

Why not CC netdev@ on this?
