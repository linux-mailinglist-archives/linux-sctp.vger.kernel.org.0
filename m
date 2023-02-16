Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34568699390
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Feb 2023 12:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBPLsf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Feb 2023 06:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBPLsc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Feb 2023 06:48:32 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D465C3
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 03:48:26 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHY6j3w8bzRs0C
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 19:45:49 +0800 (CST)
Received: from huawei.com (10.136.117.208) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Feb
 2023 19:48:24 +0800
From:   Qiumiao Zhang <zhangqiumiao1@huawei.com>
To:     <linux-sctp@vger.kernel.org>, <marcelo.leitner@gmail.com>
CC:     <zhaowei23@huawei.com>, <caowangbao@huawei.com>,
        <yanan@huawei.com>, <zhangqiumiao1@huawei.com>
Subject: [PATCH lksctp-tools 3/5] use valid conversion specifiers in printf()
Date:   Thu, 16 Feb 2023 19:48:20 +0800
Message-ID: <20230216114822.1000-4-zhangqiumiao1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20230216114822.1000-1-zhangqiumiao1@huawei.com>
References: <20230216114822.1000-1-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.136.117.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

For printf(), unsigned integers should use %u as the valid
conversion specifier instead of %d.

Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
---
 src/testlib/sctputil.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/testlib/sctputil.c b/src/testlib/sctputil.c
index 97a04f0..87f2099 100644
--- a/src/testlib/sctputil.c
+++ b/src/testlib/sctputil.c
@@ -60,13 +60,13 @@ test_print_cmsg(sctp_cmsg_t type, sctp_cmsg_data_t *data)
 	switch(type) {
 	case SCTP_INIT:
 		printf("INIT\n");
-		printf("   sinit_num_ostreams %d\n",
+		printf("   sinit_num_ostreams %u\n",
 		       data->init.sinit_num_ostreams);
-		printf("   sinit_max_instreams %d\n",
+		printf("   sinit_max_instreams %u\n",
 		       data->init.sinit_max_instreams);
-		printf("   sinit_max_attempts %d\n",
+		printf("   sinit_max_attempts %u\n",
 		       data->init.sinit_max_attempts);
-		printf("   sinit_max_init_timeo %d\n",
+		printf("   sinit_max_init_timeo %u\n",
 		       data->init.sinit_max_init_timeo);
 		
 		break;
@@ -196,15 +196,15 @@ test_check_buf_notification(void *buf, int datalen, int msg_flags,
 		
 	sn = (union sctp_notification *)buf;
 	if (sn->sn_header.sn_type != expected_sn_type)
-		tst_brkm(TBROK, tst_exit, "Unexpected notification:%d"
-			 "expected:%d", sn->sn_header.sn_type,
+		tst_brkm(TBROK, tst_exit, "Unexpected notification:%u"
+			 "expected:%u", sn->sn_header.sn_type,
 			  expected_sn_type);
 	
 	switch(sn->sn_header.sn_type){
 	case SCTP_ASSOC_CHANGE:
 		if (sn->sn_assoc_change.sac_state != expected_additional)
-			tst_brkm(TBROK, tst_exit, "Unexpected sac_state:%d "
-				 "expected:%d", sn->sn_assoc_change.sac_state,
+			tst_brkm(TBROK, tst_exit, "Unexpected sac_state:%u "
+				 "expected:%u", sn->sn_assoc_change.sac_state,
 				  expected_additional);
 		break;
 	default:
--
2.27.0

