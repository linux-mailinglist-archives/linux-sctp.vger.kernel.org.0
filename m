Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298EF5ECE85
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Sep 2022 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiI0UbB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 27 Sep 2022 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiI0Ua5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 27 Sep 2022 16:30:57 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC972616
        for <linux-sctp@vger.kernel.org>; Tue, 27 Sep 2022 13:30:57 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1280590722dso14836283fac.1
        for <linux-sctp@vger.kernel.org>; Tue, 27 Sep 2022 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Ji4cPINU5rGlbrAiSzgjrOLyTvDqEXr/IQx2JlpZN6E=;
        b=ZNTYLH+iP1kWSJo2m/q3U4J/1ZBHtGPaT99+tUYrrINXo5peErNHxA3pzoQ97O1ayO
         ipn9j0T3wYxSfI3iOhPLlNNpwDWPjbFL1P/FPxt+HW/qXqOQ0biRmqUcac5dCoy4/feU
         dRymgCv+UF6/AqdN5EPe056Nx1ZZ7X3l1zcFK2fsC6V5zYsPKBCBCgm+LSazn4n6NqPw
         htLjO/kPSyDE2eJDx+QOvSLb/Buc7Lx/G/BSv2trurXFSGQlZlnDZdIdVCi+jm4lL6FC
         QdrBKjeF6owNgWoD6LsqB1KBBGuLRZV7jNDYbTJYaMmgL4YmzNBewY/hEYp5FThyYUc9
         WoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ji4cPINU5rGlbrAiSzgjrOLyTvDqEXr/IQx2JlpZN6E=;
        b=hqm4KsqngdTtQrc5GX4gPJjIxtYkTnTZLPVv7O3FGskdAKse06pEQHQhHcgAAAf297
         sFma9wEzglNM5WBZNcH1WqLeZbUYtFZStsShrhY2+gec7HnAsvZfP7yYyVoPkabm88SS
         bueqQiLexS0Om29LYX8YgJDtW9uujGtEOwcxNFqyeAzsk/jc1+wZvnZVim4J/UHxUM3Z
         6OLFaG7rACIWmSMMPzR4BfGfe6Vn9mrIYzvn/F6H6qphyB8QvibPvB0BUX+n5gwZYxo6
         WZ/+yI6qEsoWdv4z/OFfHlf6AWvwcBkVGcKi50Zrin7gR3/mwbg1S3VrLXbRNTEoBDzn
         97Nw==
X-Gm-Message-State: ACrzQf3tOcpnrRUQiaJny1cPP0hj0EURg2Rt+Oej/9B4zrXfrYSXi3fr
        fLUuXAfMX4akLueD8LpeRqs=
X-Google-Smtp-Source: AMsMyM6psAQwZ5oeG37ukW7tV3xdPOfDksdQJu8Xxnbs91TpcAmZc7bwz6VA2ntstvoLT+WTMEM8EA==
X-Received: by 2002:a05:6870:708f:b0:130:f6e6:4019 with SMTP id v15-20020a056870708f00b00130f6e64019mr3405648oae.166.1664310656227;
        Tue, 27 Sep 2022 13:30:56 -0700 (PDT)
Received: from t14s.localdomain ([200.146.228.250])
        by smtp.gmail.com with ESMTPSA id i19-20020a4adf13000000b004767df8f231sm1006589oou.39.2022.09.27.13.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:30:55 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 87E8F404F7C; Tue, 27 Sep 2022 17:30:51 -0300 (-03)
Date:   Tue, 27 Sep 2022 17:30:51 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Istvan Gyurjan <istvan.gyurjan@flex.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: lksctp-tools licensing
Message-ID: <20220927203051.35nneqjltzpysa5m@t14s.localdomain>
References: <PH0PR08MB724105AD73E9AFB3F12A0679E7419@PH0PR08MB7241.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR08MB724105AD73E9AFB3F12A0679E7419@PH0PR08MB7241.namprd08.prod.outlook.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello Istvan,

On Wed, Sep 07, 2022 at 10:32:38AM +0000, Istvan Gyurjan wrote:
> Dear lksctp-tools Maintainer team,
> 
> We are planning to develop an application where lksctp-tools would be used together with other OSS components that uses Apache License 2.0 and The OpenSSL License. Those are in conflict with the GPL-2.0-only
> license of lksctp-tools.

That's unfortunate.

> Do you have any plan to update the license to GPL-2.0-or-later?

No, but we can evaluate that. It's fine by me.
Xin, thoughts?

  Marcelo

> 
> Best Regards, Istvan Gyurjan
> 
> Legal Disclaimer :
> The information contained in this message may be privileged and confidential. 
> It is intended to be read only by the individual or entity to whom it is addressed 
> or by their designee. If the reader of this message is not the intended recipient, 
> you are on notice that any distribution of this message, in any form, 
> is strictly prohibited. If you have received this message in error, 
> please immediately notify the sender and delete or destroy any copy of this message!
> 
