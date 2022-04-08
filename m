Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54F04F9B79
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Apr 2022 19:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiDHRU1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Apr 2022 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiDHRU0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Apr 2022 13:20:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466B410242D
        for <linux-sctp@vger.kernel.org>; Fri,  8 Apr 2022 10:18:22 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id b188so9457546oia.13
        for <linux-sctp@vger.kernel.org>; Fri, 08 Apr 2022 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f/fF07zfJAJ+pEDSAOaPf8CfotVhGllGtUlJHdKcpnQ=;
        b=QXRI1mlcAou0FYEwUkbX47t/NUoaw94a/N/EWK1OPhGKOC37zA33NX5EkzNr281yc6
         tSXSJNPQXqYV++bQdJFzCsNotppOtxcaRSHKsodboKmMH7k+4CwDVRkW5qYmTs85ittA
         0lbN9BT88apt+aX33r+2RmqC51NSvG2XFBnu0dvMbYFqTJu2WLDjgKpaVicRO79JiSv8
         FLiUJ8KH5Wfuj/T3RxKzCRLNGwvlDlhwq4Fwc0cAkJ6KU/yEWLc6DlY01bdvbO0MaNsV
         5c9wMzChPrnn4/Vi2bdri/4M2C6rISuCCDy8+H3U28GBFyJWkmKqAEve605rRs62UOGy
         sw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/fF07zfJAJ+pEDSAOaPf8CfotVhGllGtUlJHdKcpnQ=;
        b=K2NxxGLJJNJsHNIpE4fBClPYOwoY11IFnyznuG7hAfURfg2ge52XhjTbznV9ejCQhV
         iljtLwLAVdJPGx1cITEsOy3pbTIvLIQtv00CW/bb1z27xCSVd8szuU4y+ryKmrI7Wbs3
         M9VmqAvVR4lkJvIqyvJHPo9443TNYWQ60+K0xscFTH5Q/vOLR/07mPM5O224hGkQD23o
         wURo2Eiyka/6yo1a3+v1WXd0PSH/dwhtOjcScS/LCKcvOUq/hLZc7taiBAS5hiSxxBLP
         8lVjsVOifQGlvbxd8cL1JeAoInYmNjuewqmCfkVGRtYZLpBcZl5c2+lEIBSFJbsH4aS7
         GviQ==
X-Gm-Message-State: AOAM5334oxXOajgIH3ZhNGTEUtWhSZ6pUATrG63wpiViV02E1XxyYDxW
        B0gSdFwmwwBdFwM7HAw2mno=
X-Google-Smtp-Source: ABdhPJzEHtJSfLcJBG//KSYOiNdgb7appsLnI0Q16MP5zb/f+FRkMrK/CRPyb9PWoi9QF4D9dd438A==
X-Received: by 2002:a05:6808:d51:b0:2ec:b129:1197 with SMTP id w17-20020a0568080d5100b002ecb1291197mr401318oik.12.1649438300199;
        Fri, 08 Apr 2022 10:18:20 -0700 (PDT)
Received: from t14s.localdomain ([177.220.172.117])
        by smtp.gmail.com with ESMTPSA id u16-20020a056808151000b002f734da0881sm9216951oiw.57.2022.04.08.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:18:19 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id D44151DFDC1; Fri,  8 Apr 2022 14:18:17 -0300 (-03)
Date:   Fri, 8 Apr 2022 14:18:17 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Petr Malat <oss@malat.biz>, linux-sctp@vger.kernel.org,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] sctp: Initialize daddr on peeled off socket
Message-ID: <YlBuWfEg/njGjSkt@t14s.localdomain>
References: <20220307195929.621359-1-oss@malat.biz>
 <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YlAsCio+PCnuSmeK@ntb.petris.klfree.czf>
 <20220408093342.022431f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408093342.022431f7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Apr 08, 2022 at 09:33:42AM -0700, Jakub Kicinski wrote:
> On Fri, 8 Apr 2022 14:35:22 +0200 Petr Malat wrote:
> > On Mon, Mar 07, 2022 at 01:33:21PM -0800, Jakub Kicinski wrote:
> > > On Mon,  7 Mar 2022 20:59:29 +0100 Petr Malat wrote:  
> > > > Function sctp_do_peeloff() wrongly initializes daddr of the original
> > > > socket instead of the peeled off one, which makes getpeername() return
> > > > zeroes instead of the primary address. Initialize the new socket
> > > > instead.  
> > > 
> > > Could you add a Fixes tag?  
> > 
> > Hi Jakub,
> > have you got some time to review the updated version with "Fixes" tag
> > added?
> 
> Thanks for adding the tag. Long story short if you got no replies from
> SCTP folks on the posting to linux-sctp@ repost with netdev@ added.
> That way it'll get into general networking patchwork / patch processing
> queue.

Yup. Also, the patch itself always need to be posted to netdev@
anyway, because we can't take patches directly from linux-sctp@. Well,
unless you mean to not officially submit the patch at a given time for
some reason, that is.

> 
> > The issue has been in the kernel for a while, because my app is using
> > peer addresses for storing sockets in a hash table and the hash table can
> > handle collisions, thus I haven't noticed it's broken until I dumped
> > the hash table while working on another problem.
