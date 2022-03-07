Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61744D095F
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Mar 2022 22:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiCGVeT (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 7 Mar 2022 16:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiCGVeS (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 7 Mar 2022 16:34:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8EE3EBB7
        for <linux-sctp@vger.kernel.org>; Mon,  7 Mar 2022 13:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 978BD614E2
        for <linux-sctp@vger.kernel.org>; Mon,  7 Mar 2022 21:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B730C340E9;
        Mon,  7 Mar 2022 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646688802;
        bh=e9XCIzxNJrH9rBloPlQiPH1yaYR08lCM0oLm7uD8O0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RWAqa4B9o1v8bWCG2CjnEXR4GGQbssSHkMbwIYNYZeS+TuVLf0Q70KljIdjeBgnLe
         DjmLjsDba3sIjRRrVKWSu/qiCWGpZXa0GKFmjc1GoG2nRaFfg/vdDAPGB8Rm+5u6TE
         aRsA5Eaa00nJWzah8Ty2sl6pGlXKMvlnGQwYNZX4KnarPs1b7fcEHHYh3cHE8Dqtlz
         VtQmho72UlqNd8WwQdiK2iihCWtGqI0NmtalhNkNsBaLR16o+abbFli8yhstgIgfpU
         86QwRpTH7hP+Ev0+bL6ojmfbtuiBsg8BLzd26AWMvNhN+04S8EkSsQGLfoFXQ2pf/J
         QWvTsJ9rp3eXg==
Date:   Mon, 7 Mar 2022 13:33:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] sctp: Initialize daddr on peeled off socket
Message-ID: <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220307195929.621359-1-oss@malat.biz>
References: <20220307195929.621359-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon,  7 Mar 2022 20:59:29 +0100 Petr Malat wrote:
> Function sctp_do_peeloff() wrongly initializes daddr of the original
> socket instead of the peeled off one, which makes getpeername() return
> zeroes instead of the primary address. Initialize the new socket
> instead.

Could you add a Fixes tag?
