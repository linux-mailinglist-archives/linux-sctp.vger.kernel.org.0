Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F214377D182
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Aug 2023 20:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjHOSJU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Aug 2023 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbjHOSIw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Aug 2023 14:08:52 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C7106;
        Tue, 15 Aug 2023 11:08:50 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76c845dc5beso349174685a.1;
        Tue, 15 Aug 2023 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122930; x=1692727730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Vxb3z1IyIN9TwyIHVuiJGwsFwB19zV9fp6dkcldmjA=;
        b=qRpYBpjBwulpss0QRfUXJOB9fnOl/4njSUxgWt8Z0iLYXxrSEvpm9Luw07J/wSUsJ7
         UshR1GlpAjpuG2jJ+9bjQ0Wo2vqMsuIFbA9I7I+wfs9u6wF4XDXdu4dKE/hmi5De4fPP
         mDExX4qTnkdP47pprV0E4cXII6lcqyD2cJD1jmcKIU3yucmQl0IL90RlWkLGbj0UGlww
         jBmXwoKd/+wndytZKpCks2hmR6YTdmqZm0vOis5CdJJRrURWiPbgGbH3gCNU9l5ckGgl
         EVqS1vWPhFkSLhJ2/yFuDpCpywkcBldC7IHjYuZpihFQ8mgbUQTuSykAFO4nhztRWVw/
         mIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122930; x=1692727730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Vxb3z1IyIN9TwyIHVuiJGwsFwB19zV9fp6dkcldmjA=;
        b=Oom5/jTgxw/V5Ts2W57QL/CeW3eU9dMLblbkD8NrnbJN9iWRy0M5FfTgT8Js7UIk0Z
         lfF6Je1wLbJGoQwde96j9/3COftmLyve/+3q80ARgcRI+FPQHe5Rj35Xe9HCWsRCMcYl
         sHpHbr2HGSQ5zJEcO//+3cklrU4Za8jvQGeJXnRt2SquUbtCMFpexhqOWg7ydh8HyjGv
         UqNWv88qFijVs0FtbGNBhY/d3DGrJxhzHnAS675gClwIognfKFofNh2NhEjFszQHTRZ+
         KYMGzeVdbHn5oJ/KgpPbVxANIx+puqku7UzfMZL6D2G8jEZxOS/n1zjsuZSuwcfdW5Yd
         GCxg==
X-Gm-Message-State: AOJu0YxLrMe2LvMm8606Z4qXoPm1h+0jTOH040kRea4VBaXzou57TJKV
        O8dovG2293yZV8PW2vbyJ61lrYqsoNNLVg==
X-Google-Smtp-Source: AGHT+IHRA5lORqlA0Yf1DFvIYlvudekPcuFkO7x81IuuWMG6eZd+uQwGVZuHRUwp/XUz0Iu9zmcepw==
X-Received: by 2002:a05:620a:4712:b0:76c:cb3c:30c with SMTP id bs18-20020a05620a471200b0076ccb3c030cmr13889648qkb.52.1692122929813;
        Tue, 15 Aug 2023 11:08:49 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w7-20020ae9e507000000b00767d572d651sm3907916qkf.87.2023.08.15.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:08:49 -0700 (PDT)
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
        Simon Horman <horms@kernel.org>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCHv2 nf] netfilter: set default timeout to 3 secs for sctp shutdown send and recv state
Date:   Tue, 15 Aug 2023 14:08:47 -0400
Message-Id: <4f2f3f3e0402c41ed46483dc9254dc6d71f06ceb.1692122927.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

In SCTP protocol, it is using the same timer (T2 timer) for SHUTDOWN and
SHUTDOWN_ACK retransmission. However in sctp conntrack the default timeout
value for SCTP_CONNTRACK_SHUTDOWN_ACK_SENT state is 3 secs while it's 300
msecs for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV state.

As Paolo Valerio noticed, this might cause unwanted expiration of the ct
entry. In my test, with 1s tc netem delay set on the NAT path, after the
SHUTDOWN is sent, the sctp ct entry enters SCTP_CONNTRACK_SHUTDOWN_SEND
state. However, due to 300ms (too short) delay, when the SHUTDOWN_ACK is
sent back from the peer, the sctp ct entry has expired and been deleted,
and then the SHUTDOWN_ACK has to be dropped.

Also, it is confusing these two sysctl options always show 0 due to all
timeout values using sec as unit:

  net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd = 0
  net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent = 0

This patch fixes it by also using 3 secs for sctp shutdown send and recv
state in sctp conntrack, which is also RTO.initial value in SCTP protocol.

Note that the very short time value for SCTP_CONNTRACK_SHUTDOWN_SEND/RECV
was probably used for a rare scenario where SHUTDOWN is sent on 1st path
but SHUTDOWN_ACK is replied on 2nd path, then a new connection started
immediately on 1st path. So this patch also moves from SHUTDOWN_SEND/RECV
to CLOSE when receiving INIT in the ORIGINAL direction.

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Reported-by: Paolo Valerio <pvalerio@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1->v2:
- fix sysctl nf_conntrack_sctp_timeout_shutdown_sent default value
  described in nf_conntrack-sysctl.rst, as Sriram noticed.
---
 Documentation/networking/nf_conntrack-sysctl.rst | 4 ++--
 net/netfilter/nf_conntrack_proto_sctp.c          | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index 8b1045c3b59e..c383a394c665 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -178,10 +178,10 @@ nf_conntrack_sctp_timeout_established - INTEGER (seconds)
 	Default is set to (hb_interval * path_max_retrans + rto_max)
 
 nf_conntrack_sctp_timeout_shutdown_sent - INTEGER (seconds)
-	default 0.3
+	default 3
 
 nf_conntrack_sctp_timeout_shutdown_recd - INTEGER (seconds)
-	default 0.3
+	default 3
 
 nf_conntrack_sctp_timeout_shutdown_ack_sent - INTEGER (seconds)
 	default 3
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 91eacc9b0b98..b6bcc8f2f46b 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -49,8 +49,8 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_COOKIE_WAIT]		= 3 SECS,
 	[SCTP_CONNTRACK_COOKIE_ECHOED]		= 3 SECS,
 	[SCTP_CONNTRACK_ESTABLISHED]		= 210 SECS,
-	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 300 SECS / 1000,
-	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 300 SECS / 1000,
+	[SCTP_CONNTRACK_SHUTDOWN_SENT]		= 3 SECS,
+	[SCTP_CONNTRACK_SHUTDOWN_RECD]		= 3 SECS,
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT]	= 3 SECS,
 	[SCTP_CONNTRACK_HEARTBEAT_SENT]		= 30 SECS,
 };
@@ -105,7 +105,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 	{
 /*	ORIGINAL	*/
 /*                  sNO, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS */
-/* init         */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCW},
+/* init         */ {sCL, sCL, sCW, sCE, sES, sCL, sCL, sSA, sCW},
 /* init_ack     */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},
 /* abort        */ {sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL, sCL},
 /* shutdown     */ {sCL, sCL, sCW, sCE, sSS, sSS, sSR, sSA, sCL},
-- 
2.39.1

