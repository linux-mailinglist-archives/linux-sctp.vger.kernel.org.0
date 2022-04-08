Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B294F95E5
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Apr 2022 14:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbiDHMhv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Apr 2022 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiDHMhj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Apr 2022 08:37:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64CA27160
        for <linux-sctp@vger.kernel.org>; Fri,  8 Apr 2022 05:35:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n6so16968695ejc.13
        for <linux-sctp@vger.kernel.org>; Fri, 08 Apr 2022 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/p7J0JatOLfOpGrcJDRASqxFzDSUNasj69j1HcOhYJk=;
        b=TDWcRAJnQ2MctKQUUzyRclQhrSl7jgnnxMWOmZOI8SZC6XB6im5+JUdbB3hlVD419C
         MlqW4t+otJu2tXbpDIwQpdUsDrun4CndeRhuSn/2kz4yeH7B7mxVUvWaeBdA8Ytg4WJB
         uUf8nDKrSHe8yAkAFLR+Z/Il4zXmr+epqcZyPZfk0dLuLjO258qgAF0qFH9wu/R72Ghs
         Dstci3RvGK+sXRi9eYTTgUgVUBCr6rc+SwY+NBJqhuQZAdbyBrTM8qa+He187616NvTR
         0TE7Xah4/8lg791fKU0iPc3aVBxQzB6vdPPC2bAOSoh16SIcxZx7UKiHG9dGF2fu+k1L
         2U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/p7J0JatOLfOpGrcJDRASqxFzDSUNasj69j1HcOhYJk=;
        b=TUiiM/ySFLQGo/9vGCkBZozBpzUwiEH+Usy6no/tCzw8MRlBN5kcFpx4lr5UT6vE3h
         OQnH2dhqEpk6GccNqRb3SIjFcvpastlWkS3NwHztDO3UrUXKcEvoCB1dtZpjCXPOOwOI
         m8qUi85SEq/twFPLZ6sMKqPxCGogP4RR92a1rs3nhaLkI872vAOWtOmdzLyY7rLezWa8
         nwsfuxtvSSzPFtQ+vsB4/P1SkGU9wvqW7Rh2cWabEyzceEgTwfAINkNP3ofiFtwHS88k
         zemoVAtno6xpmOGL6jhI4Ez2Lgrk8wWfUB2FqQTFyRN9RZBkAAW4eDGWKRA6sBzHdajD
         jQWg==
X-Gm-Message-State: AOAM533YGzXr5P066ot+VZ6iHUqHG+d5LiDHNgk+vN1JpVjYBfVHPOYG
        9NauTvJabpR+5pDN1WTYZ7JBQw==
X-Google-Smtp-Source: ABdhPJybC6EAwGj8kRX5Vx8irHGZ7aNPOs1vP+pnmJsA9GUz7AkUyUKMSUjMwoiHsTC0xJE0rAkSmg==
X-Received: by 2002:a17:907:6d96:b0:6e8:67da:6c17 with SMTP id sb22-20020a1709076d9600b006e867da6c17mr139204ejc.258.1649421330263;
        Fri, 08 Apr 2022 05:35:30 -0700 (PDT)
Received: from ntb.petris.klfree.czf ([2a02:8070:d4c1:3a00:ceb5:41c:b517:660f])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b006e05929e66csm8625122ejp.20.2022.04.08.05.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 05:35:29 -0700 (PDT)
Date:   Fri, 8 Apr 2022 14:35:22 +0200
From:   Petr Malat <oss@malat.biz>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] sctp: Initialize daddr on peeled off socket
Message-ID: <YlAsCio+PCnuSmeK@ntb.petris.klfree.czf>
References: <20220307195929.621359-1-oss@malat.biz>
 <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Mar 07, 2022 at 01:33:21PM -0800, Jakub Kicinski wrote:
> On Mon,  7 Mar 2022 20:59:29 +0100 Petr Malat wrote:
> > Function sctp_do_peeloff() wrongly initializes daddr of the original
> > socket instead of the peeled off one, which makes getpeername() return
> > zeroes instead of the primary address. Initialize the new socket
> > instead.
> 
> Could you add a Fixes tag?

Hi Jakub,
have you got some time to review the updated version with "Fixes" tag
added?

The issue has been in the kernel for a while, because my app is using
peer addresses for storing sockets in a hash table and the hash table can
handle collisions, thus I haven't noticed it's broken until I dumped
the hash table while working on another problem.
BR,
  Petr
