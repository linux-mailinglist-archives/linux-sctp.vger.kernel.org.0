Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73CB25AE12
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Sep 2020 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBO6z (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Sep 2020 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBO6k (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Sep 2020 10:58:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E409C061244
        for <linux-sctp@vger.kernel.org>; Wed,  2 Sep 2020 07:58:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so4608498qka.5
        for <linux-sctp@vger.kernel.org>; Wed, 02 Sep 2020 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1RiOa55yyVLjjH/PtR3Ei3JtyaYp4I2Cs/IjJAIRZ8=;
        b=KVIco+kIEDJ0xT2+dTU/S5fz3T70uezeOIxxHLfmEdQCe4m/8lItM5/I3sXl0IAnUb
         K0RP9dbLaU//bH8/HKQt5YEuxD8rdXaFGYs6bdQlHdemXoxcD5p8yAHO3pf4UryoNTZx
         qivODFvExD3mFRWdLaidMx3eJZjXgWt5mbMzLEkLBx431FJxSTz3eAO8G7XcgLpx2ERo
         KDuv0Y946Yox2K5LylE9kvI4m+p1hb4FlbtJQ+JrX+v4Q2i/p2K6hDXxsNRCT5as4I+Y
         Wj+7A5ZNnZpBnZETv7nYgnxu/tDSDGbTpqbu66Tj/dqxa/w1fz4P23DAHX9T4BsnMFY0
         4ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1RiOa55yyVLjjH/PtR3Ei3JtyaYp4I2Cs/IjJAIRZ8=;
        b=gOsgOk1CUhKaZS3tCwoMw/k2EKSm5uWwwL7WJQ7+Ai+nPo3GFP1IFN7ClqFgeIPVuC
         fvxldaO+9DLYXmEqVF5ZVlmepgTyQOBPuiwyQoohzcqeDmzXiAelop/eGClWRb43gP/B
         vMiYpONuE3sUw0zAolAkqA0jWpwCoGZYuKfh8q2wxD49NY8BcCXKO+lxf9I61JokqUwe
         4HXEYTztGhpifoi++as/6eHxzUgT8KxAv7er3ma2JzwpLcYw39XSD5mWQI86RgXg2NSl
         dh0tsntQxkPPA2+RpryoSgE1NwzzUMf5YEjkG4jOOhA8BJzknBplKIDkysnZIOCPZRDg
         VhcA==
X-Gm-Message-State: AOAM532jUtOzyoWmutuv9CMceP9kWGyM7KgcK982WT4IbxQhAth0d7jT
        NR/Kbm+tW1gtKY3EXqEcNbY=
X-Google-Smtp-Source: ABdhPJwfELS8T6WF+LdWrhaeM3XBiErRTJJ5YBD9jgGXg9aXvWqUvc4LlXJ0uCOelRa4NAk0ZBoVww==
X-Received: by 2002:a05:620a:7e9:: with SMTP id k9mr7581350qkk.415.1599058718186;
        Wed, 02 Sep 2020 07:58:38 -0700 (PDT)
Received: from localhost.localdomain ([177.220.174.181])
        by smtp.gmail.com with ESMTPSA id r21sm4571617qtj.80.2020.09.02.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:58:37 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 48C44C5F36; Wed,  2 Sep 2020 11:58:35 -0300 (-03)
Date:   Wed, 2 Sep 2020 11:58:35 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-sctp@vger.kernel.org, vyasevich@gmail.com,
        nhorman@tuxdriver.com, davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH] sctp: Honour SCTP_PARTIAL_DELIVERY_POINT even under
 memory pressure
Message-ID: <20200902145835.GC2444@localhost.localdomain>
References: <20200901090007.31061-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901090007.31061-1-oss@malat.biz>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Sep 01, 2020 at 11:00:07AM +0200, Petr Malat wrote:
> Command SCTP_CMD_PART_DELIVER issued under memory pressure calls
> sctp_ulpq_partial_delivery(), which tries to fetch and partially deliver
> the first message it finds without checking if the message is longer than
> SCTP_PARTIAL_DELIVERY_POINT. According to the RFC 6458 paragraph 8.1.21.
> such a behavior is invalid. Fix it by returning the first message only if
> its part currently available is longer than SCTP_PARTIAL_DELIVERY_POINT.

Okay but AFAICT this patch then violates the basic idea behind partial
delivery. It will cause such small message to just not be delivered
anymore, and keep using the receive buffer which it is trying to free
some bits at this moment.

Btw, you also need to Cc netdev@vger.kernel.org for patches to
actually get applied by DaveM.

  Marcelo
