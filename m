Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8120A663D0C
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Jan 2023 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjAJJhx (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 10 Jan 2023 04:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjAJJhq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 10 Jan 2023 04:37:46 -0500
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577FF48CC2;
        Tue, 10 Jan 2023 01:37:44 -0800 (PST)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id GCW00136;
        Tue, 10 Jan 2023 17:37:36 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.16; Tue, 10 Jan 2023 17:37:37 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <vyasevich@gmail.com>, <nhorman@tuxdriver.com>,
        <marcelo.leitner@gmail.com>
CC:     <linux-sctp@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] sctp: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Date:   Tue, 10 Jan 2023 04:37:33 -0500
Message-ID: <20230110093733.2398-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20231101737362e6d41f64e2f9a5dacfb37411163b93c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members instead. So, replace zero-length array
declaration in struct fid with the new DECLARE_FLEX_ARRAY()
helper macro.

This helper allows for a flexible-array member in a union.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 include/linux/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 358dc08e0831..09fdb7206f08 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -239,7 +239,7 @@ struct sctp_idatahdr {
 		__u32 ppid;
 		__be32 fsn;
 	};
-	__u8 payload[0];
+	DECLARE_FLEX_ARRAY(__u8, payload);
 };
 
 struct sctp_idata_chunk {
-- 
2.27.0

