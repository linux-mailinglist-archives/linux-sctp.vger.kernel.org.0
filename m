Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB722A447
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Jul 2020 03:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbgGWBFK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 22 Jul 2020 21:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733147AbgGWBFI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 22 Jul 2020 21:05:08 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA68C0619DC;
        Wed, 22 Jul 2020 18:05:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F4D7126B37F5;
        Wed, 22 Jul 2020 17:48:23 -0700 (PDT)
Date:   Wed, 22 Jul 2020 18:05:07 -0700 (PDT)
Message-Id: <20200722.180507.1824073385236482752.davem@davemloft.net>
To:     lucien.xin@gmail.com
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, nhorman@tuxdriver.com
Subject: Re: [PATCH net 0/2] sctp: shrink stream outq in the right place
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1595433039.git.lucien.xin@gmail.com>
References: <cover.1595433039.git.lucien.xin@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Jul 2020 17:48:23 -0700 (PDT)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 22 Jul 2020 23:52:10 +0800

> Patch 1 is an improvement, and Patch 2 is a bug fix.

Series applied, and queued up for -stable, thank you.
