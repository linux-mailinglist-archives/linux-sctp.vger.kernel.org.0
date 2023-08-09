Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095A776257
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Aug 2023 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjHIOX2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 9 Aug 2023 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHIOX1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 9 Aug 2023 10:23:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED291FF5;
        Wed,  9 Aug 2023 07:23:26 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLXLs0qP2z15NRg;
        Wed,  9 Aug 2023 22:22:13 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:23:24 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH net-next] sctp: Remove unused declaration sctp_backlog_migrate()
Date:   Wed, 9 Aug 2023 22:23:23 +0800
Message-ID: <20230809142323.9428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Commit 61c9fed41638 ("[SCTP]: A better solution to fix the race between sctp_peeloff()
and sctp_rcv().") removed the implementation but left declaration in place. Remove it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/sctp/sctp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 2a67100b2a17..a2310fa995f6 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -148,8 +148,6 @@ void sctp_icmp_redirect(struct sock *, struct sctp_transport *,
 void sctp_icmp_proto_unreachable(struct sock *sk,
 				 struct sctp_association *asoc,
 				 struct sctp_transport *t);
-void sctp_backlog_migrate(struct sctp_association *assoc,
-			  struct sock *oldsk, struct sock *newsk);
 int sctp_transport_hashtable_init(void);
 void sctp_transport_hashtable_destroy(void);
 int sctp_hash_transport(struct sctp_transport *t);
-- 
2.34.1

