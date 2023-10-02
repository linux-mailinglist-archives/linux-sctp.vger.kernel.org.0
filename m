Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38E7B5954
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Oct 2023 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJBRHq (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 2 Oct 2023 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBRHq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Oct 2023 13:07:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4AFAB;
        Mon,  2 Oct 2023 10:07:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA201C433C8;
        Mon,  2 Oct 2023 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696266462;
        bh=jYjBN7hUBvdHjoT7jKI5LL8GGyIxG4jttpVPeu6SGJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlUdZX3csePmoZmt3/sZKSzHo9rU2ARGplQ35OARJ9B+o5VHnqeWID+diJ8vHGAhV
         i5k3bt4aBj8JTCAW3ZDyvPgAvHkwpyCUCnTb0844A3P2Rnr1O4VdhceMxmdbymdHzH
         V37ry8WYwIWUZ7WiqQOP9+D7K6DfkdMrkf9gwfXlLpP9gnNoq4qu8vCcjKp1MJNOke
         G88iiBg7sHODTjUx76fkeql6rAgp5ZsEVYCF183kEsTulkdgRAjRlSOz7uEHvV+87J
         wE6Y3FfWiXAH5fIlWOdjk1ZtSb3cT7kZwreaBbaZT0GeXem5LqC9gdCtyBqK+Fy9th
         BqF/bGfXLZEmQ==
Date:   Mon, 2 Oct 2023 19:07:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] sctp: Spelling s/preceeding/preceding/g
Message-ID: <20231002170738.GA92317@kernel.org>
References: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Sep 28, 2023 at 02:17:48PM +0200, Geert Uytterhoeven wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>

