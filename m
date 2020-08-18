Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C66248F26
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Aug 2020 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHRT6N (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 18 Aug 2020 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHRT6K (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 Aug 2020 15:58:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA1C061342;
        Tue, 18 Aug 2020 12:58:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C39F1127A3533;
        Tue, 18 Aug 2020 12:41:23 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:58:08 -0700 (PDT)
Message-Id: <20200818.125808.1491339435094413330.davem@davemloft.net>
To:     David.Laight@ACULAB.COM
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com
Subject: Re: [PATCH] net: sctp: Fix negotiation of the number of data
 streams.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <46079a126ad542d380add5f9ba6ffa85@AcuMS.aculab.com>
References: <46079a126ad542d380add5f9ba6ffa85@AcuMS.aculab.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Aug 2020 12:41:24 -0700 (PDT)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 18 Aug 2020 14:36:58 +0000

> Fixes 2075e50caf5ea.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>

This is not the correct format for a Fixes tag, also it should not
be separated by empty lines from other tags such as Signed-off-by
and Acked-by.

As someone who reads netdev frequently, these patterns should be
etched into your brain by now. :-)

