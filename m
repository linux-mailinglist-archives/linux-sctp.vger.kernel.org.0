Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945A276ADA1
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Aug 2023 11:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjHAJbE (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 1 Aug 2023 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjHAJan (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 1 Aug 2023 05:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B73F4202;
        Tue,  1 Aug 2023 02:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCFD614B2;
        Tue,  1 Aug 2023 09:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C59C433C7;
        Tue,  1 Aug 2023 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690882165;
        bh=kG7SZXNiyzexHlcARYSO8y3yfKIQTqbHV/gn8ppwj7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qp1vf7zbWCj83RAWtH4zS6s5sN7zmoIO1oVXN/wXUdICldHhd+o/PzI0CwttdB09b
         6iuS57v6Uc1frELDjlWj/XRDZjNl+RpDh/Zv3ITCidaAY37rMgqy8dnm/5v675KirV
         t7Q7eMKwCg5NQdl4cww4n8izCutfzX9sInFZed/h+rmiAHjwZVIEBc8l55OOyxxyaf
         RourzjLYRlvCcBhbN5OUJJhLAJYhFVkTvMT1ZR6yDpQSGKWjqPEm0OhYVpupj0E6NX
         gjm6dxZ6vzNPfgLF8zDDXBueY+wmwgSwwYa/R53NBkyHFeqHWrn6as907XM2PhbaWb
         9tyLHq/4Ss5Mw==
Date:   Tue, 1 Aug 2023 11:29:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Remove unused function declarations
Message-ID: <ZMjQceSII+1AukF1@kernel.org>
References: <20230731141030.32772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731141030.32772-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 31, 2023 at 10:10:30PM +0800, Yue Haibing wrote:
> These declarations are never implemented since beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

