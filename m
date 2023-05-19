Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EACA709B18
	for <lists+linux-sctp@lfdr.de>; Fri, 19 May 2023 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjESPTS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjESPTR (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 11:19:17 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C313E;
        Fri, 19 May 2023 08:19:16 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so21729695e9.2;
        Fri, 19 May 2023 08:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509555; x=1687101555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/33/iB0K+c0HWtdDFSkvbCTsDDRyO08+huLchtgxtE=;
        b=WrH5zyc9jY7CA9jyY0v8ycl0MRK3X6nVRo6fpTIc32R1HU6GAU7IhMQKhSzL65kSHs
         R2WPkefxFi1HyNJstc0MWeRLV41fsWh3RfzTh4VGyHM7jUpJM1otl24SlaxsHgSqJdzz
         22nF8wOv3cbYTIrl/xhamczlyxn1ZLdEiAD3gQNk7pw9tZ1yLsHxQfDAmV4tl5Ln+6rm
         T5w+DAkS9hxT0Gx+iCfG9i5ZNwkbtIQnC3za2u475LA9u4gRh7EAVv65/RZ2+au74Kgx
         7uHA/H1y3y+/Kl1ovLr6E9XSdrfr7ZP38aRc2UHVLeWZFUCwxegp5KwLbz7e7ypkaRhc
         /x5Q==
X-Gm-Message-State: AC+VfDx6QiAmYK7ca3GFZr5PL7+CkZR/D6SaAt+QhEg2n6dUVzGwSDK/
        FAPG3LHN6qDv0A7sHNeIvLQ=
X-Google-Smtp-Source: ACHHUZ6BmpF/4RnAMLexDbjQsWxHsSwUigYDxwCSz4SPCfVnF81LzxGpUTomUn+cen0pC9+XqccXSQ==
X-Received: by 2002:a7b:c454:0:b0:3f4:ecdc:5069 with SMTP id l20-20020a7bc454000000b003f4ecdc5069mr1646165wmi.33.1684509554782;
        Fri, 19 May 2023 08:19:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b003f4289b18a7sm2724354wmj.5.2023.05.19.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:19:14 -0700 (PDT)
Date:   Fri, 19 May 2023 08:19:10 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     axboe@kernel.dk, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        courmisch@gmail.com, nhorman@tuxdriver.com, asml.silence@gmail.com,
        alex.aring@gmail.com, dccp@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
        marcelo.leitner@gmail.com, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, leit@fb.com, David.Laight@aculab.com,
        dsahern@kernel.org
Subject: Re: [PATCH 0/1] net: ioctl: Use kernel buffer on proto ioctl
 callbacks
Message-ID: <ZGeTbsnCZtkewPzu@gmail.com>
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519081526.59411533@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519081526.59411533@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, May 19, 2023 at 08:15:26AM -0700, Jakub Kicinski wrote:
> On Fri, 19 May 2023 06:58:20 -0700 Breno Leitao wrote:
> > With the implementation of network ioctl on io_uring[1], Willem
> > suggested[2] that the "struct proto" ioctls functions should be reused,
> > instead of duplicating the code.
> > For that, the ioctl callbacks need to be more flexible, and avoid
> > operating on userspace buffers (doing get/put_user()) directly on the
> > callbacks. This patch adds this flexibility, so, the io_uring plumbing
> > becomes more clean, avoiding duplicating code. This may also benefit
> > BPF.
> > 
> > For that, a wrapper is created, which will copy from/to userspace, and
> > the ioctl callback will rely on the wrapper to do userspace memory
> > copies.
> > 
> > I've tested this patch in three different ways:
> > 1) Created a simple testcase for TCP/UDP [3]
> > 2) Run relevant LTP tests, such as: sockioctl, setsockopt, bind, sendto,
> > 				    fanout, ns-udpsender, etc
> > 3) Run basics network selftests
> > 
> > PS: There are some `strcmp()` in the `sock_skprot_ioctl()`, that I was
> > not able to find a better way to deal with it. Any feedback is
> > appreciated.
> 
> Why not CC netdev@ on this?

Oops, my mistake. I will do it on V2.
