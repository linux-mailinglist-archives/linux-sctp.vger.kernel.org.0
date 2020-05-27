Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C031E3693
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2020 05:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgE0DcT (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 26 May 2020 23:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DcT (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 26 May 2020 23:32:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A99C061A0F;
        Tue, 26 May 2020 20:32:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A0A7512796434;
        Tue, 26 May 2020 20:32:18 -0700 (PDT)
Date:   Tue, 26 May 2020 20:32:18 -0700 (PDT)
Message-Id: <20200526.203218.883210335462387015.davem@davemloft.net>
To:     chris.packham@alliedtelesis.co.nz
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, trivial@kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] net: sctp: Fix spelling in Kconfig help
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200525225559.13596-1-chris.packham@alliedtelesis.co.nz>
References: <20200525225559.13596-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 May 2020 20:32:19 -0700 (PDT)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Tue, 26 May 2020 10:55:59 +1200

> Change 'handeled' to 'handled' in the Kconfig help for SCTP.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.
