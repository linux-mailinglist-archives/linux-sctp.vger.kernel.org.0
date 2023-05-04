Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC936F62BC
	for <lists+linux-sctp@lfdr.de>; Thu,  4 May 2023 03:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjEDBtd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 3 May 2023 21:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDBtc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 3 May 2023 21:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A5BD;
        Wed,  3 May 2023 18:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B94611FA;
        Thu,  4 May 2023 01:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB1FC433D2;
        Thu,  4 May 2023 01:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683164969;
        bh=6SyTKbVcajyYbNLJTfLkhCT7g/RGQ6mt+51ZNxG89JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkCNopdxlGhmaXqy6jbwrBacnksKw0nWAGpajVw5/5AP/0p/6PgFN9Fqn8uDP/c8q
         uP9h7lQQgC67pEAH9Q6AiqlhqRAkcfHCwGqqv6zAMHfIc2hbb4Gi1bXuUTCeSQ1MOP
         WOjHnPXVfoZaGkRQtCDwu3mIh4BlMBfDuQWdT3fVAMbAXYTkKoG0PnbLz9FtHMw7UY
         p0M9WTq0y4b1BDNwALKhlhNvZVLnn3TmoC8rNwNRJ76fPGnSQn5H9S7QHQkF+RZ1mT
         1V67W0SqP2swwDd1SeIkSw2jQqILJclB6onfOzG2RFWzakvs3CKBoA/6ERt92PPXgt
         PTSZAX3sVrhew==
Date:   Wed, 3 May 2023 18:49:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v4] sctp: fix a potential OOB access in
 sctp_sched_set_sched()
Message-ID: <20230503184928.458eb0da@kernel.org>
In-Reply-To: <20230503133752.4176720-1-Ilia.Gavrilov@infotecs.ru>
References: <ZFJX3KLkcu4nON7l@t14s.localdomain>
        <20230503133752.4176720-1-Ilia.Gavrilov@infotecs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, 3 May 2023 13:37:59 +0000 Gavrilov Ilia wrote:
> The 'sched' index value must be checked before accessing an element
> of the 'sctp_sched_ops' array. Otherwise, it can lead to OOB access.
> 
> Note that it's harmless since the 'sched' parameter is checked before
> calling 'sctp_sched_set_sched'.

Not a fix, so it needs to wait for net-next to open, see below.
When you repost please do so separately, not in the existing thread.

## Form letter - net-next-closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after May 8th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

