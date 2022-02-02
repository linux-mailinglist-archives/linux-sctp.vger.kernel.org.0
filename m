Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514E4A70C3
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Feb 2022 13:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiBBM2k (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Feb 2022 07:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbiBBM2j (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Feb 2022 07:28:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0235DC06173E
        for <linux-sctp@vger.kernel.org>; Wed,  2 Feb 2022 04:28:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q8so24870498oiw.7
        for <linux-sctp@vger.kernel.org>; Wed, 02 Feb 2022 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A76yyw9UJb8ccr7GEhV/fkx49nII9NKEbWjRWQJKsfs=;
        b=hYJB5XK8SxWPibqpiqVToiBYiXQZ2n4B9lZhJA5lEWILFkXJTFFbs1M7StbR6wT7Sa
         BHxo+hKYkukaJ+aZHN5OAldcRwjJlmYP8q3HlXM+KF0G5xyLdaiQDTNlgcaKS61Cu2YQ
         PIOF+Gvm7j1Wl/ZhIn4n35j8zw2Ffok6sss9RQUnGEzJSQ9pOXMNVK+c3yCN0SNASMui
         vyPNW44Hag9EvVPz+hzPDQYOOYLtxLA1tP1T7+OuWJzq+u2qV08JPUqAPQWJc9BIqmr4
         jrJdG2hbwRTqmT+efS7HKF15bSPamvUI6inFK9srcf0XAala9Rv+RNvwls9IZtpNFMNv
         uLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A76yyw9UJb8ccr7GEhV/fkx49nII9NKEbWjRWQJKsfs=;
        b=If43iuquwbShMchOvVTVgVMNkD3Z+uM2+Jp/6Fvuc+N66iCkSxak5H6s4lOCCXqyPN
         JC7kb45E/Y7WyK/tMtr/le14Cn/SWQZIDs6U7NSXm0KhO3Qq8gR8gMlJRJenP33M7vRw
         qM31reeE+PeWlvayOhSMfz3Qed3naPxfv9KVRJ5a0LF/lFc6iCJpCRDZBK31Yj/7euUP
         MlMzBrMy9CBunSpm1wBmZwIawQFpubr6DXJ/xFbFccLLAymSImPweixl94YJmjiE2GOb
         vOj5jIsBkPTrKUG7phMz1x1XfBDsgCRgLm7rX2Fm2zqfNUP0evn7Ii9GCJ2GKUyQ6ild
         QuuQ==
X-Gm-Message-State: AOAM533FEwfEf7EklkK1o6R1QwsGDBIDnYvvvJ6KZ/eh8bA0qttgoLEj
        ph2Ng20XML62pB5Re68b33A=
X-Google-Smtp-Source: ABdhPJznYX+bdEvvOMVAeIwLUbTl0pXVE1FjZNnhVlmx8o4nYUaMv4YiujFXaMb8g9VC5hQQwCDUKQ==
X-Received: by 2002:a05:6808:5c8:: with SMTP id d8mr4211661oij.251.1643804918254;
        Wed, 02 Feb 2022 04:28:38 -0800 (PST)
Received: from t14s.localdomain ([2001:1284:f016:4a2a:cb7b:9b09:85a6:b020])
        by smtp.gmail.com with ESMTPSA id n67sm12261968oib.31.2022.02.02.04.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 04:28:38 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 5B8C015AC2C; Wed,  2 Feb 2022 09:28:36 -0300 (-03)
Date:   Wed, 2 Feb 2022 09:28:36 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-sctp@vger.kernel.org, ltp@lists.linux.it,
        Cyril Hrubis <chrubis@suse.cz>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Martin Doucha <martin.doucha@suse.com>
Subject: Re: [RFC] SCTP tests in LTP vs. on github.com/sctp
Message-ID: <Yfp49PCW9Res5gXG@t14s.localdomain>
References: <YfpnVfrto4Elshy5@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfpnVfrto4Elshy5@pevik>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Petr,

On Wed, Feb 02, 2022 at 12:13:25PM +0100, Petr Vorel wrote:
> Hi all,
> 
> SCTP tests lksctp-tools [1] are also in LTP [2].
> IMHO it's not worth to have it on both places.

Agree. I wasn't aware of the copy in LTP, btw.

A question I have now is, is getting more exposure because it is in
LTP? As in, does it get executed periodically by bots somewhere?

> 
> lksctp-tools looks like to be the official ones [3] so maybe drop it from LTP?
> 
> Version in LTP was updated to 1.0.15 some time ago (upstream has 1.0.19, containing various fixes [4],
> maybe worth to be backported to lksctp-tools? Frankly speaking even being older
> version the LTP code looks to me better. One test was even rewritten to LTP new
> C API [5] in order to apply more improvements [6].
> 
> BTW I'd really recommend lksctp-tools project to take new LTP C API [7] and
> rewrite tests into it. But are these tests still relevant? (is it worth of
> work?)

These are nice tips, thanks. We certainly can have a take on them.

Best regards,
Marcelo

> 
> Kind regards,
> Petr
> 
> [1] https://github.com/sctp/lksctp-tools
> [2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
> [3] https://github.com/sctp
> [4] https://github.com/linux-test-project/ltp/commits/master/utils/sctp
> [5] https://github.com/linux-test-project/ltp/commit/fcd43b3dd7a8e8fab2b03ec9fa659f21ff5cecb2
> [6] https://github.com/linux-test-project/ltp/commit/fcd43b3dd7a8e8fab2b03ec9fa659f21ff5cecb2
> [7] https://github.com/linux-test-project/ltp/wiki/C-Test-API
