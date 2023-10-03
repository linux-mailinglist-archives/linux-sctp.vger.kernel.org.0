Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA97B6F69
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJCRSA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRSA (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 13:18:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD595;
        Tue,  3 Oct 2023 10:17:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77432add7caso81359885a.2;
        Tue, 03 Oct 2023 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696353476; x=1696958276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rilJqYgfCUDdfqLBW4lWYkPrV16f8nh/2/f/h5185tc=;
        b=myfVcrmHxLWsdebfUqoSkpKjNfMB6cswg9iDnPbKlk7YsZA/UeohttjXKxtXfEphjK
         8NpK8yYqfuntjwmG4bjIUl/VWU2sp+uN4WP9OiK7u9AeFwnNhShaiPUALgd9j+8ANUAu
         cdd6aJqSt7a9mfkkMei4dT4efnuCF++p/hgmkbOGnNGoL5B0xAVY9Def0WROUrvBfjcp
         pMpxkfvO4Q8pH3o1Moyd3ztwCD4S+myGN5h+gSIQ2icpA6e9aTMV6FstR9yyKarbRfb7
         bsmdj+P4+WrCp1T9X7RvD6UvDvxRJdyQiVxMvBcmHki8LDUxD1UkVgXFwcPPVxtcB4oN
         2BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353476; x=1696958276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rilJqYgfCUDdfqLBW4lWYkPrV16f8nh/2/f/h5185tc=;
        b=B3wQ0bGMncDXj2WXdRWYrEc1QTM0yR6y/Io53OJdtDRvSpqQVoWruSDl+/FQck/L0I
         cwz6n0Ib9GDUs0gZetav9qgOXT+dep+Vtam594MMD++lc4qP/HB4DOmizB1ucRnPt+It
         ikDRF6luhmJ0khbssuiMChZfyAYh49bfnl4tFWage97EDPFZSuUOzeJI2U7zrILPkKvt
         Z16LNAGzaqLQP12ryDJQJGhstORY8yuv1UQQCLFaR07+K46+N9xIIAFbbrxdPEBQg9Hs
         fN8UhJb6+n/x3NmZDpoTErVWRouYn8JqLOWlC1+xwcYHa2zwq7ySYsg9vjbF3JCo5z7S
         ibUg==
X-Gm-Message-State: AOJu0Yx/1oumNmbLOXmKS5aHRoxZvZgPDuq8q6HE3aeiej9mh6n4iypf
        N6jR4zmN3ktOwj7vqYBQsQKq+8eeT8FZkQ==
X-Google-Smtp-Source: AGHT+IEJ2dzvfICdpLPVbmE1BbOJ8vrtDvucR+t6HSgAAbpruzbKuw7YdejsIFZCcf9idnCUNfv7fg==
X-Received: by 2002:a0c:eb07:0:b0:64f:3795:c10 with SMTP id j7-20020a0ceb07000000b0064f37950c10mr14195qvp.10.1696353476418;
        Tue, 03 Oct 2023 10:17:56 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h1-20020a0cf401000000b0065d0dcc28e3sm633041qvl.73.2023.10.03.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:17:55 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCHv2 nf 0/2] netfilter: handle the sctp collision properly and add selftest
Date:   Tue,  3 Oct 2023 13:17:52 -0400
Message-Id: <cover.1696353375.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Patch 1/2 is to fix the insufficient processing for sctp collision in netfilter
nf_conntrack, and Patch 2/2 is to add a selftest for it, as Florian suggested.

Xin Long (2):
  netfilter: handle the connecting collision properly in
    nf_conntrack_proto_sctp
  selftests: netfilter: test for sctp collision processing in
    nf_conntrack

 include/linux/netfilter/nf_conntrack_sctp.h   |  1 +
 net/netfilter/nf_conntrack_proto_sctp.c       | 43 ++++++--
 tools/testing/selftests/netfilter/Makefile    |  5 +-
 .../netfilter/conntrack_sctp_collision.sh     | 89 +++++++++++++++++
 .../selftests/netfilter/sctp_collision.c      | 99 +++++++++++++++++++
 5 files changed, 225 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
 create mode 100644 tools/testing/selftests/netfilter/sctp_collision.c

-- 
2.39.1

