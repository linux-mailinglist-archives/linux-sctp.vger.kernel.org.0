Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E490769915
	for <lists+linux-sctp@lfdr.de>; Mon, 31 Jul 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjGaOKm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 31 Jul 2023 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjGaOKj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 31 Jul 2023 10:10:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071618C;
        Mon, 31 Jul 2023 07:10:35 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RF0Tb3KjxzVjvT;
        Mon, 31 Jul 2023 22:08:51 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 22:10:32 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <yuehaibing@huawei.com>
CC:     <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] sctp: Remove unused function declarations
Date:   Mon, 31 Jul 2023 22:10:30 +0800
Message-ID: <20230731141030.32772-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

These declarations are never implemented since beginning of git history.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/sctp/sm.h      | 3 ---
 include/net/sctp/structs.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index f37c7a558d6d..64c42bd56bb2 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -156,7 +156,6 @@ sctp_state_fn_t sctp_sf_do_6_2_sack;
 sctp_state_fn_t sctp_sf_autoclose_timer_expire;
 
 /* Prototypes for utility support functions.  */
-__u8 sctp_get_chunk_type(struct sctp_chunk *chunk);
 const struct sctp_sm_table_entry *sctp_sm_lookup_event(
 					struct net *net,
 					enum sctp_event_type event_type,
@@ -166,8 +165,6 @@ int sctp_chunk_iif(const struct sctp_chunk *);
 struct sctp_association *sctp_make_temp_asoc(const struct sctp_endpoint *,
 					     struct sctp_chunk *,
 					     gfp_t gfp);
-__u32 sctp_generate_verification_tag(void);
-void sctp_populate_tie_tags(__u8 *cookie, __u32 curTag, __u32 hisTag);
 
 /* Prototypes for chunk-building functions.  */
 struct sctp_chunk *sctp_make_init(const struct sctp_association *asoc,
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 5c72d1864dd6..5a24d6d8522a 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1122,8 +1122,6 @@ void sctp_outq_free(struct sctp_outq*);
 void sctp_outq_tail(struct sctp_outq *, struct sctp_chunk *chunk, gfp_t);
 int sctp_outq_sack(struct sctp_outq *, struct sctp_chunk *);
 int sctp_outq_is_empty(const struct sctp_outq *);
-void sctp_outq_restart(struct sctp_outq *);
-
 void sctp_retransmit(struct sctp_outq *q, struct sctp_transport *transport,
 		     enum sctp_retransmit_reason reason);
 void sctp_retransmit_mark(struct sctp_outq *, struct sctp_transport *, __u8);
-- 
2.34.1

