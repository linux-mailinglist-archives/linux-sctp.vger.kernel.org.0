Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3156699391
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Feb 2023 12:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBPLsf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Feb 2023 06:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBPLsc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Feb 2023 06:48:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102C5354B
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 03:48:26 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHY9C4GQTzrRsv
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 19:47:59 +0800 (CST)
Received: from huawei.com (10.136.117.208) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Feb
 2023 19:48:24 +0800
From:   Qiumiao Zhang <zhangqiumiao1@huawei.com>
To:     <linux-sctp@vger.kernel.org>, <marcelo.leitner@gmail.com>
CC:     <zhaowei23@huawei.com>, <caowangbao@huawei.com>,
        <yanan@huawei.com>, <zhangqiumiao1@huawei.com>
Subject: [PATCH lksctp-tools 4/5] fix memory leak of iov.iov_base
Date:   Thu, 16 Feb 2023 19:48:21 +0800
Message-ID: <20230216114822.1000-5-zhangqiumiao1@huawei.com>
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

Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
---
 src/apps/sctp_darn.c                  | 4 ++++
 src/func_tests/test_sctp_sendvrecvv.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/src/apps/sctp_darn.c b/src/apps/sctp_darn.c
index d7dcc73..b909d26 100644
--- a/src/apps/sctp_darn.c
+++ b/src/apps/sctp_darn.c
@@ -676,6 +676,7 @@ command_listen(char *argv0, int sk)
 				if ((recvsk = accept(sk, NULL, &len)) < 0) {
 					fprintf(stderr, "%s: error: %s.\n",
 						argv0, strerror(errno));
+					free(iov.iov_base);
 					exit(1);
 				}
 			}
@@ -716,6 +717,7 @@ command_listen(char *argv0, int sk)
 					   sizeof(msgname)) == -1) {
 					fprintf(stderr, "%s: error: %s.\n",
 						argv0, strerror(errno));
+					free(iov.iov_base);
 					exit(1);
 				}
 			}
@@ -739,6 +741,8 @@ command_listen(char *argv0, int sk)
 		}
 	}

+	free(iov.iov_base);
+
 	if (error < 0) {
 		fprintf(stderr, "%s: error: %s.\n",
 			argv0, strerror(errno));
diff --git a/src/func_tests/test_sctp_sendvrecvv.c b/src/func_tests/test_sctp_sendvrecvv.c
index 56ea20a..9dfb2cd 100644
--- a/src/func_tests/test_sctp_sendvrecvv.c
+++ b/src/func_tests/test_sctp_sendvrecvv.c
@@ -265,6 +265,7 @@ int main(int argc, char *argv[])

 	close(sk1);
 	close(sk2);
+	free(iov.iov_base);

 	return 0;
 }
--
2.27.0

