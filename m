Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7DA7B6763
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbjJCLNO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbjJCLNN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 07:13:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70364A7
        for <linux-sctp@vger.kernel.org>; Tue,  3 Oct 2023 04:13:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E2C433C9;
        Tue,  3 Oct 2023 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696331586;
        bh=CoomkraAX2naxLdTJimxBFRMspUWykUSXyPCNJZ1BW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGhsXxpp6iTY5muDKClN5DvXwbzLFsDICH666+I5DWaSc2LPwmDlJ56VTN8J+R0Pd
         CMLRxJRZkx8K2EMHipevd3J+UnMXaPcXVqBALh5OqSW844JvhHL9LQzgxhXadc+hQX
         bcjDQ80VjWbsWqzpJ3ZsaPW6v8nWvoLZE71+HoIm91FnbIlj4a0dAdRZjB+YblVHaN
         hbxkOJbik7QGdXRZd0ZjTKydpC8cvN3J/k6CuIY6PRiaYXNK9KILYRtD+DxDAFs91X
         AUXDv6Og33U9AMLDlg3tdQGurcGauZFHRJ8vhYHQDoaiZ+asTG4NpUHFIJuPEqwdsx
         GE7bHM1JfUEaw==
Date:   Tue, 3 Oct 2023 13:13:02 +0200
From:   Simon Horman <horms@kernel.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xufeng Zhang <xufeng.zhang@windriver.com>
Subject: Re: [PATCH net] sctp: update hb timer immediately after users change
 hb_interval
Message-ID: <ZRv3PgGCa5v0woGh@kernel.org>
References: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Oct 01, 2023 at 11:04:20AM -0400, Xin Long wrote:
> Currently, when hb_interval is changed by users, it won't take effect
> until the next expiry of hb timer. As the default value is 30s, users
> have to wait up to 30s to wait its hb_interval update to work.
> 
> This becomes pretty bad in containers where a much smaller value is
> usually set on hb_interval. This patch improves it by resetting the
> hb timer immediately once the value of hb_interval is updated by users.
> 
> Note that we don't address the already existing 'problem' when sending
> a heartbeat 'on demand' if one hb has just been sent(from the timer)
> mentioned in:
> 
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg590224.html

Hi Xin Long,

I wonder if this warrants a fixes tag, and if so, perhaps:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
