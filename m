Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C596D473B84
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Dec 2021 04:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhLND1S (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 13 Dec 2021 22:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhLND1R (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 13 Dec 2021 22:27:17 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52AC061574
        for <linux-sctp@vger.kernel.org>; Mon, 13 Dec 2021 19:27:17 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 84so11683717vkc.6
        for <linux-sctp@vger.kernel.org>; Mon, 13 Dec 2021 19:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pCoeuU4HQ37zPCYgCPSufNHS0S7t9m5QKjJKMGDnd4c=;
        b=bhJ/MlRJePu/CBpEf/bg0an5BzRpkZQqePEpp/mWQUqEGaG+68+4TTqGy41Clh9+MT
         X6n/qeTD5YSEQi2gbvpFBtdQ+/AaRPDaGpf+Z70IMAE4LEfB0k5ngJKiV93v2Olv9XT+
         gzpX3HoxJM9eEM2QXgdTUwDZoSel/P3GXi1jNpgwOr7/XMC8RUEYvqsJKYJjkyAQipuk
         m9L2KZvm7gZbf1dYAkWWVUWjBvQ1bXERlZ8TYo2lL85zS1ClVXIRcAXBg5X48FOaMHlc
         6WZ+MKiD/lFSJJzma5yRqvd6I2Q1uW1nStYpxigCCvyz1dRP+WVr0ecstbxRPHHJgK+z
         FTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pCoeuU4HQ37zPCYgCPSufNHS0S7t9m5QKjJKMGDnd4c=;
        b=SmyQUH+9RHPPK7efRRf7xXvs47Qp9xCsFOsEkB1CijaWksYps9ZCj4FK1F+8JiNY6H
         2NregdVri1r8K2nJTkt3iKnPbPcIy4uGA5xqTsRAs3QUMwQdl6utcD8JbFbrnf7m+8hP
         Lbmbl+Kzjx9rUztALBuGuBq2Qp7rbggco6GZ5wUEPDi5jP6Ey+wbOimRjhlyxtbaM62F
         JUaEXMrNOnd90b8Z1wLv/yN0zRzn1Re8MZcOQxgrRr9enMUsa/oEuOqwdLMd1aD/9G1g
         zYwh6rG9QoMXxPPaN9bF8lgUSyMCcnyQ7dDM+pDf5ZH41V6/pLpcE/mIBg2Vzf3HKeKq
         pvxQ==
X-Gm-Message-State: AOAM533DNXuAwzCyKFjBTnmB5GtJBfDgD2RjtoO4x0nzxdmxFEii1iKx
        YMqXMq9bZiFnuT/wvQkVD3g=
X-Google-Smtp-Source: ABdhPJz9ttAI/zjqooriK43KSX3VTWquphvPfZh1nw5zM9hSavZgTIR7l//VRmMO5OYIS5ugtZJCFg==
X-Received: by 2002:a05:6122:201e:: with SMTP id l30mr3399861vkd.10.1639452436487;
        Mon, 13 Dec 2021 19:27:16 -0800 (PST)
Received: from t14s.localdomain ([177.220.174.93])
        by smtp.gmail.com with ESMTPSA id c14sm4331078vkm.10.2021.12.13.19.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:27:15 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 1D9771070F0; Tue, 14 Dec 2021 00:27:14 -0300 (-03)
Date:   Tue, 14 Dec 2021 00:27:14 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Support sha256 as default (SCTP_DEFAULT_COOKIE_HMAC_SHA256)
Message-ID: <YbgPEqEAB2uqgSaB@t14s.localdomain>
References: <YbcreMQry03v5VmW@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbcreMQry03v5VmW@pevik>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

On Mon, Dec 13, 2021 at 12:16:08PM +0100, Petr Vorel wrote:
> Hi all,
> 
> what is the reason there is no support for sha256 as default
> (SCTP_DEFAULT_COOKIE_HMAC_SHA256)? sha256 is mentioned in RFC 4895 (2007).

I'm not aware of any particular reason. Perhaps it just wasn't
implemented. We're open to patches, btw. ;-)

  Marcelo
