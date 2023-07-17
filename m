Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB3756587
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Jul 2023 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGQNyU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Jul 2023 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGQNyQ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 17 Jul 2023 09:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66A0E4
        for <linux-sctp@vger.kernel.org>; Mon, 17 Jul 2023 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689602013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cxwNxY4JS8J6tPLEogfd2SFfXj3N8uNj2U1eKeq6+xE=;
        b=ZT0/q3Hm6A6x+fXO85NjueehKOONBOTowllaus6Dari7Gw+ILba2SlsKuJEm4Y7nV9wo6D
        Y+3FgPLkSxt++J6vcuxVQ5TBB7P/9XehKbFwzoc2jsj+3+e1xBvR6z0/YwF7i8Wes4Mvel
        y1fZIJqJyHLEDhM2td7TaQ8fbQS3hts=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-X0D_g4UPOI-g82t5uvIMxw-1; Mon, 17 Jul 2023 09:53:32 -0400
X-MC-Unique: X0D_g4UPOI-g82t5uvIMxw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765ab532883so584295785a.0
        for <linux-sctp@vger.kernel.org>; Mon, 17 Jul 2023 06:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602012; x=1692194012;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxwNxY4JS8J6tPLEogfd2SFfXj3N8uNj2U1eKeq6+xE=;
        b=JefGLRGAuPmJoPfCy9GN9AGwlcM/kP4u5nOJZmuQFNsJr2D4VCoN4eq6bH/RxX4hLY
         423craO8CMCq5KnCikh1Ybb4O2FIIngB6p/KC1HyC5zsH20+TYZZ4hddmx6jigka5OZA
         SG5X9zQ3FkdmERU3MSLc1t7BNcheMLaY6t4nPALsmjboBdvQVFshBP2zedtfS2xHQmIA
         FG+OqDZJlVRI8M0IGHtSib7BrC7FhI7z8DMnRXqiic+9rCJo27+eZS8MV+j0V33NdHVl
         XU3MSUZ/wmJyCY1ryy8AkQ1z9qO+rSKesN49emRJAymZu/u1LNQJf748ZVLpTGbezW9x
         /szg==
X-Gm-Message-State: ABy/qLYZuMI/dqAJXvr2LzV7OuErHr64X6bH9PcNAMzU1PbdeLs7ttS4
        yEdasn/Kc42euJLgU38YRif9Gz/kNlSaORVAQcsN2TOrei2Wp749VeVRog/OIHHyBpRAE3lonx0
        wzTyLqh4pq67Qa7yvU11Vlw==
X-Received: by 2002:a05:622a:104c:b0:3e3:9117:66e8 with SMTP id f12-20020a05622a104c00b003e3911766e8mr15174575qte.35.1689602012085;
        Mon, 17 Jul 2023 06:53:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQ6vap0ITLUfu8vhP2jR7nb8amW+13ht5RG1X59wHJKsZtwSGwA6x7Lps3sxW4+8YYauf9HQ==
X-Received: by 2002:a05:622a:104c:b0:3e3:9117:66e8 with SMTP id f12-20020a05622a104c00b003e3911766e8mr15174559qte.35.1689602011845;
        Mon, 17 Jul 2023 06:53:31 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id x10-20020ac87eca000000b00403b44bc230sm6250267qtj.95.2023.07.17.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:53:31 -0700 (PDT)
Date:   Mon, 17 Jul 2023 15:53:24 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Harald Welte <laforge@gnumonks.org>,
        osmocom-net-gprs@lists.osmocom.org, dccp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org
Subject: [PATCH net-next 0/3] net: Remove more RTO_ONLINK users.
Message-ID: <cover.1689600901.git.gnault@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Code that initialise a flowi4 structure manually before doing a fib
lookup can easily avoid overloading ->flowi4_tos with the RTO_ONLINK
bit. They can just set ->flowi4_scope correctly instead.

Properly separating the routing scope from ->flowi4_tos will allow to
eventually convert this field to dscp_t (to ensure proper separation
between DSCP and ECN).

Guillaume Nault (3):
  gtp: Set TOS and routing scope independently for fib lookups.
  dccp: Set TOS and routing scope independently for fib lookups.
  sctp: Set TOS and routing scope independently for fib lookups.

 drivers/net/gtp.c   | 3 ++-
 net/dccp/ipv4.c     | 3 ++-
 net/sctp/protocol.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.39.2

