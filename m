Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC163329A
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Nov 2022 03:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiKVCEC (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 21 Nov 2022 21:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiKVCD6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 21 Nov 2022 21:03:58 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0682BDEAC8;
        Mon, 21 Nov 2022 18:03:57 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3938dc90ab0so112022607b3.4;
        Mon, 21 Nov 2022 18:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ptI+nYITeW1gKXUBABTe9iXK3+s6B6YR5hHe/uuAEk=;
        b=aMtTD3FN91QuunzdQeJlDFtrgk7U61gYOsbhNxGjRp6qOvuSQkBew+G4nOb+I9lvjF
         Gvs0dtTw0XcjDq6vXXhmaX9VsIHd8e463rPOH0Bxk4Sy1KIy/nR86RLTDqLLbgDLiX5M
         1pT48i0anCd7RZ9HovhykDcZM0SUo2HaZUolkcviIdE4jWp2J2ei7J4oEwWyAwscRAXa
         c9n8fcZoX4lvlZTtKRqv0PdoMhIrwHqCj0a8OByHjz8muMqyBbx/19CCSAPsRWSUkt86
         JtyywhmXW6PofLaTX0Bq3IZxMJ8SNpQwsI2rz1fS+ygF4ST18Skr2SvqYXLiYZwIzIA8
         xO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ptI+nYITeW1gKXUBABTe9iXK3+s6B6YR5hHe/uuAEk=;
        b=B7uz6hV7HoonPjutfh+7FRl/+3a7EOI+PmZ2Gz5bjDDtNpYyFntXNWfKQnc9rgpIQF
         r0GJbXDaBaNTeK+n+kKclyf3ssevdL9sLKAnY6HhwzhWJ3DuSajrstyl3K2Kmh1yjSK7
         t+yobEKa1pfLm+tZwxxi+e9IVwSsUIv6uG+2iuV2OiofOtA0kcJ4DMmuOIGQ7hpdmRLX
         YVJAlgVf9/S17MP+9nY2M1hqMr/MNwr8OKw20/2XRulqSsvTbfr3IuVSBLccbB8Qwrw4
         nFSbGfxIbGOvJTJzB8cu59EEa0U1U9bFf1pi3IQOgTycfXEaDq6UVp1x2PhEIefxK3pl
         rpxw==
X-Gm-Message-State: ANoB5pm6qRT6tWp00zsNKXuassLG8V5FdWh8Ey2rbDF//mElEi5rea7e
        5Wpww4WwjgKIek9IkCt1waJZ3RJ0jrWG+NtKUGtsJWQaW1TeW2+R
X-Google-Smtp-Source: AA0mqf4J/yGvWf07lle42oLrKocwEUTgOWE6vyJjrwDumrKphjCqlctEtjZfGzrbCQNvzw7Tn4wd9zgCPP+0RJOZyRU=
X-Received: by 2002:a81:574f:0:b0:39b:4c23:9cf0 with SMTP id
 l76-20020a81574f000000b0039b4c239cf0mr1397275ywb.185.1669082636235; Mon, 21
 Nov 2022 18:03:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:9f88:0:0:0:0:0 with HTTP; Mon, 21 Nov 2022 18:03:55
 -0800 (PST)
From:   Felipe Bedetti <felipebedetticosta@gmail.com>
Date:   Mon, 21 Nov 2022 23:03:55 -0300
Message-ID: <CAFO8uswgpf01EKXfi6ULE_481mMCLr737E1sRuq29jQf1yQ=4Q@mail.gmail.com>
Subject: Norah Colly
To:     linux rdma <linux-rdma@vger.kernel.org>,
        linux s390 <linux-s390@vger.kernel.org>,
        linux samsung soc <linux-samsung-soc@vger.kernel.org>,
        linux scsi <linux-scsi@vger.kernel.org>,
        linux sctp <linux-sctp@vger.kernel.org>,
        linux security module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,BODY_SINGLE_URI,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,TVD_SPACE_RATIO autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.5 SUSPICIOUS_RECIPS Similar addresses in recipient list
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [felipebedetticosta[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 TVD_SPACE_RATIO No description available.
        *  1.6 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  0.7 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

https://bit.ly/3gk1Aho
