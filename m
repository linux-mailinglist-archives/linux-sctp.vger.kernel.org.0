Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB673FBA2
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Jun 2023 14:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjF0MEB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 27 Jun 2023 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjF0MEA (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 27 Jun 2023 08:04:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC21A2;
        Tue, 27 Jun 2023 05:03:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666ecb21f86so4317819b3a.3;
        Tue, 27 Jun 2023 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687867439; x=1690459439;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3gH56krg3o+MhlxD3hH4pcrR2ZlnqXpJb3pt9aQMK8=;
        b=rNwSRvie7WyEG+pwqLd6vSajpf0wrN6PYm8gTlZvVjI6ipe6Z/mFHnxmIGPzzs/n79
         mRtzEd9fdwpLJ6eRbxQ+c/hIEPiSr738JbnpgnWKSV7fiR9g84H+xlJwVsgEOBC8SvKw
         g9yvG0UkovX3y8W0uwJp459SVihQ/cy8hAzSLozpCkjDvz77CZMKTR/g7TNkQlY24qA9
         gweTLiA5vT3ITQvrtC4Ogmby+ZG6yATtjAxA6QujivGASYVxim1O/ZBlNGEH1mALkUy0
         zc3qA6JLMKL9Q/0cilpVw5ebLqdZ+qDSVFtlU175UAtfjsnF0GtGTJYvdheCkBAu3lse
         ITUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687867439; x=1690459439;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3gH56krg3o+MhlxD3hH4pcrR2ZlnqXpJb3pt9aQMK8=;
        b=DA21u2Ar7rCiC42ww6Is0QnR/DE8QwnY2jauRIbDGk0tD+1B/IhUd7Z+fWRbj1Ytop
         Z+0VG+QUO9raxzmNbRrU3BPES9hiMk1O3vdyrHiPKzkGJcyzecdbb886Y1B6mJIA2n88
         xTyRuFTzOt1IBzjJ807Mbr6CJ857pw2R/djs0ZBmf0ubV8shvpAcqJqqeZnca0+HvqpQ
         kTEY2ExpGY9elKvIk3w4GElrlXZ352guig6yc6LnbD5vd75ynCddHYwMemzunQZI6x94
         7m41Cw1I7xoboh8x73pOTwKl3v5cm8sanC9Lg4nJ+ZaCYvCwgkqzSItwhS5/AYzp6eQ+
         cRNQ==
X-Gm-Message-State: AC+VfDzIqZTlIfd6wEFfJZ6ilPCT28qiQsT7gWYdn05sLKL1pUGPTke5
        gNIZfhEioAAdEHT3eqE8JFo=
X-Google-Smtp-Source: ACHHUZ49W2zaNIcmJi8JAs2DXc8eeTd9ey71hUrdOoyhe6DkxAobvyhpyeQRaPR2fYsKwGApeg7LKA==
X-Received: by 2002:a05:6a20:54aa:b0:112:2843:b546 with SMTP id i42-20020a056a2054aa00b001122843b546mr39998128pzk.58.1687867439166;
        Tue, 27 Jun 2023 05:03:59 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b0064d27a28451sm5296018pfh.100.2023.06.27.05.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:03:58 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
Date:   Tue, 27 Jun 2023 12:03:40 +0000
Message-Id: <20230627120340.19432-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

As &net->sctp.addr_wq_lock is also acquired by the timer
sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
at sctp_auto_asconf_init() seems should disable irq since it is called
from sctp_accept() under process context.

Possible deadlock scenario:
sctp_accept()
    -> sctp_sock_migrate()
    -> sctp_auto_asconf_init()
    -> spin_lock(&net->sctp.addr_wq_lock)
        <timer interrupt>
        -> sctp_addr_wq_timeout_handler()
        -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_bh().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/sctp/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index cda8c2874691..b2c7d17ff848 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -364,9 +364,9 @@ static void sctp_auto_asconf_init(struct sctp_sock *sp)
 	struct net *net = sock_net(&sp->inet.sk);
 
 	if (net->sctp.default_auto_asconf) {
-		spin_lock(&net->sctp.addr_wq_lock);
+		spin_lock_bh(&net->sctp.addr_wq_lock);
 		list_add_tail(&sp->auto_asconf_list, &net->sctp.auto_asconf_splist);
-		spin_unlock(&net->sctp.addr_wq_lock);
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
 		sp->do_auto_asconf = 1;
 	}
 }
-- 
2.17.1

