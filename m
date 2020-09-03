Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC51325C041
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Sep 2020 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgICLY3 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 3 Sep 2020 07:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgICLWj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 3 Sep 2020 07:22:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3918EC06125C
        for <linux-sctp@vger.kernel.org>; Thu,  3 Sep 2020 04:21:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so2769278wrm.9
        for <linux-sctp@vger.kernel.org>; Thu, 03 Sep 2020 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hbNg0lhyPXp69bpZHsx7gZI55ROs64ocYKP1AbhwAMk=;
        b=jPbIFL3Cxz8mezbzV5ci3K6P8wxEZ+Z5ETFl7ZodsHQYdgW9se9y6RQ7nZTzgRj9dH
         kX7BWvNLF/sShvWqhEj4QVTDitNRMLmdqVGd/nxg5uaa98kBa1fwtsZ9115KsxKhvETh
         S3Xi/DAV16NjNhbXsXMjl+lg+Nukv2XEfpa5ua+VLM0m40otR1kWHLeydWld1zXTtBPP
         9YY2zmn3gc8mIBiVN/0/zHSZZeoYX9Zo5Svoxv1pwtCe0wtm8JXv1nVObEqK6ZMt0ryJ
         3WVPB0li51X9mRYfKWiyBLZD/4DCoqntiWmlCcno8A6NOkcPldpC/CPOqbmnwStQbbpS
         0QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hbNg0lhyPXp69bpZHsx7gZI55ROs64ocYKP1AbhwAMk=;
        b=cq2nRvAX+d/hhctxtrkWzKghPOul/Z4eIfEDRK0SxbvsA2CK4wvxwxf45KZmsZSKIE
         G5Xk7L/PVm8VFqAd+DcWKcZnpT4BHab14q+hDofYLV2spFfvzDfmy2ikv1OrP0bFA7nh
         I81KYV9mw25KtkeuvRpi4hpGWvFIY07l6HCSERlHgDvT7vavVNy3LyYlsQTMmrT6fTyK
         13or577yeTDITPjmvlDzz8EIQh2ZyfGGfVqAfT/+blB+2PB3UIMkyeP4VjXU103AD6eK
         yOYkXvQG6KzmbI/2juVrTb8cYIpS3JvybFLsUUX6BzZqlahm51tSO49SpDZdskAC8z3z
         tj5w==
X-Gm-Message-State: AOAM530ttW6Y5z4Qpt5kLk6+n8MuUp5Wx2bfMBGIN+ht77D/oVnt6gBj
        G/EmhiVHzQIUW0aT8ApDTSl74LI69lpBMg==
X-Google-Smtp-Source: ABdhPJyMNtNHfX6PRWjWh2bWV5FHyFx3wX54Okf3jOP1Zdv1fMZPJ10ybryF0lr29QT5RMlcWVUhKA==
X-Received: by 2002:adf:a443:: with SMTP id e3mr1847298wra.146.1599132114371;
        Thu, 03 Sep 2020 04:21:54 -0700 (PDT)
Received: from bordel.klfree.net (bordel.klfree.cz. [81.201.48.42])
        by smtp.gmail.com with ESMTPSA id y1sm4012236wru.87.2020.09.03.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:21:53 -0700 (PDT)
Date:   Thu, 3 Sep 2020 13:21:48 +0200
From:   Petr Malat <oss@malat.biz>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, vyasevich@gmail.com,
        nhorman@tuxdriver.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] sctp: Honour SCTP_PARTIAL_DELIVERY_POINT even under
 memory pressure
Message-ID: <20200903112147.GA17627@bordel.klfree.net>
References: <20200901090007.31061-1-oss@malat.biz>
 <20200902145835.GC2444@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902145835.GC2444@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi!
On Wed, Sep 02, 2020 at 11:58:35AM -0300, Marcelo Ricardo Leitner wrote:
> On Tue, Sep 01, 2020 at 11:00:07AM +0200, Petr Malat wrote:
> > Command SCTP_CMD_PART_DELIVER issued under memory pressure calls
> > sctp_ulpq_partial_delivery(), which tries to fetch and partially deliver
> > the first message it finds without checking if the message is longer than
> > SCTP_PARTIAL_DELIVERY_POINT. According to the RFC 6458 paragraph 8.1.21.
> > such a behavior is invalid. Fix it by returning the first message only if
> > its part currently available is longer than SCTP_PARTIAL_DELIVERY_POINT.
> 
> Okay but AFAICT this patch then violates the basic idea behind partial
> delivery. It will cause such small message to just not be delivered
> anymore, and keep using the receive buffer which it is trying to free
> some bits at this moment.
By default the pd_point is set to 0, so there will not be a change in the
behavior, but if the user changes it to some other value, it should be
respected by the stack - for example when the largest message the user
exchanges is 1kB and the user sets it to 1kB, his application is not
prepared to handle fragmented messages at all and it's not a good idea to
pass such a message to the app.
 
> Btw, you also need to Cc netdev@vger.kernel.org for patches to
> actually get applied by DaveM.
Thanks, I will add it to this message and bounce the original patch message
as well.
  Petr
