Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202317BC86A
	for <lists+linux-sctp@lfdr.de>; Sat,  7 Oct 2023 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJGOr1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 7 Oct 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJGOr0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 7 Oct 2023 10:47:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994DBD;
        Sat,  7 Oct 2023 07:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F05C433C7;
        Sat,  7 Oct 2023 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696690045;
        bh=toBbiQLzqioyx3ESZzgeMUmDaIvxlXr2inUPTTVY7VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=npVi0yxa2LNPlvtS1ysPrOCYdtE8fIhgoJ1yeYf9EZqv87t95Uk6c7uVO0YCLLM4B
         NNceouB6JIkkKaVmqZIWZ5bdgO+zJTc4TMX5IYVZUMhY8xrq/oDsqFad6NUe5LKm1V
         Ft8uERIUV5vLe6PH9QdUsaroLDYzgBlVw0nUcxGdyVnMUZpdAcX0nbqq9bA8UAaiUc
         7zVBvT56NAd2dWgjdq7dCxlVJpMb09dP5S2gUIutPOg1PVVEE9q35AX2m2kLyYSMnN
         xP62TxCInwwMqnhWqgQqmDjBFtX+HBCmQt/EG5PBJDiQGl7iJTHD6vDiT0tXTiTxJo
         hIxJAfTM9/a0g==
Date:   Sat, 7 Oct 2023 16:47:20 +0200
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
Subject: Re: [PATCHv2 nf 0/2] netfilter: handle the sctp collision properly
 and add selftest
Message-ID: <20231007144720.GA831234@kernel.org>
References: <cover.1696353375.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696353375.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Oct 03, 2023 at 01:17:52PM -0400, Xin Long wrote:
> Patch 1/2 is to fix the insufficient processing for sctp collision in netfilter
> nf_conntrack, and Patch 2/2 is to add a selftest for it, as Florian suggested.
> 
> Xin Long (2):
>   netfilter: handle the connecting collision properly in
>     nf_conntrack_proto_sctp
>   selftests: netfilter: test for sctp collision processing in
>     nf_conntrack

For series,

Reviewed-by: Simon Horman <horms@kernel.org>

