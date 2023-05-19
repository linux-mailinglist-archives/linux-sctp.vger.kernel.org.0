Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B347098DB
	for <lists+linux-sctp@lfdr.de>; Fri, 19 May 2023 15:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjESN7D (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjESN7C (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 09:59:02 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D9CA;
        Fri, 19 May 2023 06:59:01 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so21023895e9.2;
        Fri, 19 May 2023 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504739; x=1687096739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNNTSmDF5hoxZc6Cm4zVAKpPl3Q28uUZPYvZrQqvG48=;
        b=N08NTWcQB4ndqmxxGLwpx5AFvK6YGNepW5KW1yRRIt6pUTly8sobBMBN+3EhBZhUyb
         VGargE/R/EVm5xPwLSeJsDMVSJrULV77y5R83XTw8kQYg6bDkfBRjGw1Ou2aYPJs8KhD
         S1J++HCFSe8dAUGRht3qykQW8ycwJyl/z/F/MlscltHXN1DTmhmGtOQgRNIqh+50AuXO
         /c5kL1fdeK4gCfgIqUN/pb43XNXR5cgXVwvdqfQC3JbgpR0X3xHIWCy0OKU8C57iRVB5
         hIV4NKydXo+VsnjVXjpmka4MIFFF/e/19MDjirz5cnflYWrBV0pQJDLi7PtU9x0BkN/2
         Mc5w==
X-Gm-Message-State: AC+VfDy6OvKu3AQGv8EitisvPqHs+zEJ+SROYa9ryuhRNMzavCVsevjk
        W3CyL/H0Sqj6JsJNK0fi6A0=
X-Google-Smtp-Source: ACHHUZ7uK3Bd+wLiFS/lL5Nx8KB6UDUuDPZ+UyAMBBlZ+UeI7TsvR0YLV5Vw5rLK210PhKfDeTlVhw==
X-Received: by 2002:a05:600c:2150:b0:3f5:d0ba:3c1a with SMTP id v16-20020a05600c215000b003f5d0ba3c1amr1323232wml.4.1684504739239;
        Fri, 19 May 2023 06:58:59 -0700 (PDT)
Received: from localhost (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c218b00b003f09d7b6e20sm2542918wme.2.2023.05.19.06.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 06:58:58 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     axboe@kernel.dk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, courmisch@gmail.com,
        nhorman@tuxdriver.com
Cc:     asml.silence@gmail.com, alex.aring@gmail.com, dccp@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
        matthieu.baerts@tessares.net, marcelo.leitner@gmail.com,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        leit@fb.com, David.Laight@ACULAB.COM, dsahern@kernel.org
Subject: [PATCH 0/1] net: ioctl: Use kernel buffer on proto ioctl callbacks
Date:   Fri, 19 May 2023 06:58:20 -0700
Message-Id: <20230519135821.922326-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

With the implementation of network ioctl on io_uring[1], Willem
suggested[2] that the "struct proto" ioctls functions should be reused,
instead of duplicating the code.
For that, the ioctl callbacks need to be more flexible, and avoid
operating on userspace buffers (doing get/put_user()) directly on the
callbacks. This patch adds this flexibility, so, the io_uring plumbing
becomes more clean, avoiding duplicating code. This may also benefit
BPF.

For that, a wrapper is created, which will copy from/to userspace, and
the ioctl callback will rely on the wrapper to do userspace memory
copies.

I've tested this patch in three different ways:
1) Created a simple testcase for TCP/UDP [3]
2) Run relevant LTP tests, such as: sockioctl, setsockopt, bind, sendto,
				    fanout, ns-udpsender, etc
3) Run basics network selftests

PS: There are some `strcmp()` in the `sock_skprot_ioctl()`, that I was
not able to find a better way to deal with it. Any feedback is
appreciated.

[1] Link: https://lore.kernel.org/all/GV1P193MB200533CC9A694C4066F4807CEA6F9@GV1P193MB2005.EURP193.PROD.OUTLOOK.COM/
[2] Link: https://lore.kernel.org/all/6436c01979c9b_163b6294b4@willemb.c.googlers.com.notmuch/
[3] Link: https://github.com/leitao/liburing/blob/master/test/ioctl.c

Breno Leitao (1):
  net: ioctl: Use kernel memory on protocol ioctl callbacks

 include/linux/mroute.h  |   4 +-
 include/linux/mroute6.h |   4 +-
 include/net/sock.h      |   4 +-
 include/net/tcp.h       |   2 +-
 include/net/udp.h       |   2 +-
 net/core/sock.c         | 107 ++++++++++++++++++++++++++++++++++++++++
 net/dccp/dccp.h         |   2 +-
 net/dccp/proto.c        |  12 ++---
 net/ieee802154/socket.c |  15 +++---
 net/ipv4/af_inet.c      |   2 +-
 net/ipv4/ipmr.c         |  41 +++++++--------
 net/ipv4/raw.c          |  16 +++---
 net/ipv4/tcp.c          |   5 +-
 net/ipv4/udp.c          |  12 ++---
 net/ipv6/af_inet6.c     |   2 +-
 net/ipv6/ip6mr.c        |  43 +++++++---------
 net/ipv6/raw.c          |  16 +++---
 net/l2tp/l2tp_core.h    |   2 +-
 net/l2tp/l2tp_ip.c      |   9 ++--
 net/mptcp/protocol.c    |  11 ++---
 net/phonet/datagram.c   |  11 ++---
 net/phonet/pep.c        |  11 ++---
 net/phonet/socket.c     |   2 +-
 net/sctp/socket.c       |   8 +--
 24 files changed, 214 insertions(+), 129 deletions(-)

-- 
2.34.1

