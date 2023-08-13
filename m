Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00177AA29
	for <lists+linux-sctp@lfdr.de>; Sun, 13 Aug 2023 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHMQzh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 13 Aug 2023 12:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMQzh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 13 Aug 2023 12:55:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9881B5;
        Sun, 13 Aug 2023 09:55:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4103c24a989so10985541cf.1;
        Sun, 13 Aug 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691945738; x=1692550538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSdA6ApZsPY7cmDtjPuprpoFVLsF4VqlO0j7jIEE/k8=;
        b=eUgEDR4HUlFf707/FHe+kfMpqXFfHL2N4hJfYyosl7pn6dP+k2IjvTJ5cO3EWsCaVI
         HWawwcQkh7KmYyJRAIQk2906THURI7CETevCa+0jImW7eMpB9qf7tDf3hLqWCJKqVGTt
         rYuiJ12myL/lV8i6sFdHibAavUO+oNH4L7RPN6JZG3bdD50obaEBKIXqhIo0bAmLlQGs
         nSaVlqm9MJxZnufbyo0rwB993Ss+C22K7+sSXoCWQ6NH0lvP85U/p4QxEhXDjwLD4F2u
         IRwzDP7vZMWfgSdIJATvBYzjZbo35m4u8GrFFoODC1/+w13JvABXHbf70KNukCehgZVu
         kW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691945738; x=1692550538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSdA6ApZsPY7cmDtjPuprpoFVLsF4VqlO0j7jIEE/k8=;
        b=Hs6OAwmahEe0sa7zXXv/pxiM5MDkGOGAA4AyTIV3e1C4N4m0kI9l7Bsg7TCuoJ8MHy
         zadD5gVORFhYuMYHPpl/POgDuztGznsp2gG76ljFe9U73gAqsukjugvL6Rng+E1Hlt9X
         iTpEH4DVq9GUYVjXacE92ucRM9nUWGh3Q7nSLDDS06/OFOpshvZkhnbV3aRpRNhP/yIm
         xFGDw/er9ZTiyACobF2MgCDlH7XZkaLqSZ0546zA54Hn/3ymYjNSuMR/RHG0qtBzRHjw
         vjBJq4G7hreJkoMmwtprQnjnOjVcgBR+mwos3lrw7g8bwKsCY0Dx0hKJmmfmIZxe6ApF
         VCdQ==
X-Gm-Message-State: AOJu0Yz8ep1IVmCs/JvP3vHSduX2AYpsUC4byux5EytuHW6rFa+YeQl4
        N+rwDsUrXerVNHjRoTJK2x3OrompnG/m6A==
X-Google-Smtp-Source: AGHT+IEoivS6R7xoE8FZ1UTfgYsYBFunLwL3dVucEh74lUWsrd6gA5Q0kqBgVhCEm/vyX47iPY4zgA==
X-Received: by 2002:ac8:7dcd:0:b0:403:b85c:2ac8 with SMTP id c13-20020ac87dcd000000b00403b85c2ac8mr9798173qte.14.1691945737903;
        Sun, 13 Aug 2023 09:55:37 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b0040554ed322dsm2504271qtp.62.2023.08.13.09.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:55:37 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH nf] netfilter: set default timeout to 3 secs for sctp shutdown send and recv state
Date:   Sun, 13 Aug 2023 12:55:35 -0400
Message-Id: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
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
---
 net/netfilter/nf_conntrack_proto_sctp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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

