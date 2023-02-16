Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB469938E
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Feb 2023 12:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjBPLse (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Feb 2023 06:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBPLsb (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Feb 2023 06:48:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CE521D1
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 03:48:25 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHY7b3ZCbzGnyv
        for <linux-sctp@vger.kernel.org>; Thu, 16 Feb 2023 19:46:35 +0800 (CST)
Received: from huawei.com (10.136.117.208) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 16 Feb
 2023 19:48:23 +0800
From:   Qiumiao Zhang <zhangqiumiao1@huawei.com>
To:     <linux-sctp@vger.kernel.org>, <marcelo.leitner@gmail.com>
CC:     <zhaowei23@huawei.com>, <caowangbao@huawei.com>,
        <yanan@huawei.com>, <zhangqiumiao1@huawei.com>
Subject: [PATCH lksctp-tools 1/5] fix memory leak in sctp_status
Date:   Thu, 16 Feb 2023 19:48:18 +0800
Message-ID: <20230216114822.1000-2-zhangqiumiao1@huawei.com>
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
 src/apps/sctp_status.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/apps/sctp_status.c b/src/apps/sctp_status.c
index 7c18ab1..5a52165 100644
--- a/src/apps/sctp_status.c
+++ b/src/apps/sctp_status.c
@@ -266,6 +266,7 @@ int main(int argc, char *argv[]) {
 		}
 		if ((serv_s = malloc(NI_MAXSERV)) == NULL) {
 			fprintf(stderr, "\n*** serv_s malloc failed!!! ***\n");
+			free(host_s);
 			exit(1);
 		}

@@ -273,6 +274,8 @@ int main(int argc, char *argv[]) {
 		if (error) {
 			printf("%s.\n", gai_strerror(error));
 			usage(argv[0]);
+			free(host_s);
+			free(serv_s);
 			exit(1);
 		}

@@ -315,6 +318,8 @@ int main(int argc, char *argv[]) {
 			    host_s, serv_s, res->ai_family);

 		freeaddrinfo(res);
+		free(host_s);
+		free(serv_s);
         }

 	if (local_host != NULL) {
@@ -330,6 +335,7 @@ int main(int argc, char *argv[]) {
 		}
 		if ((serv_s = malloc(NI_MAXSERV)) == NULL) {
 			fprintf(stderr, "\n*** serv_s malloc failed!!! ***\n");
+			free(host_s);
 			exit(1);
 		}

@@ -340,6 +346,8 @@ int main(int argc, char *argv[]) {
 		if (error) {
 			printf("%s.\n", gai_strerror(error));
 			usage(argv[0]);
+			free(host_s);
+			free(serv_s);
 			exit(1);
 		}

@@ -385,6 +393,8 @@ int main(int argc, char *argv[]) {
 			    host_s, serv_s, res->ai_family);

 		freeaddrinfo(res);
+		free(host_s);
+		free(serv_s);
         }

 	/* Let the testing begin. */
@@ -403,6 +413,7 @@ int bind_r(int sk, struct sockaddr_storage *saddr) {
 	}
 	if ((serv_s = malloc(NI_MAXSERV)) == NULL) {
 		fprintf(stderr, "\n\t\t*** serv_s malloc failed!!! ***\n");
+		free(host_s);
 		exit(1);
 	}

@@ -427,6 +438,8 @@ int bind_r(int sk, struct sockaddr_storage *saddr) {
 				fprintf(stderr, "\n\n\t\t***bind: can "
 					"not bind to %s:%s: %s ****\n",
 					host_s, serv_s, strerror(errno));
+				free(host_s);
+				free(serv_s);
 				exit(1);
 			}
 		}
@@ -434,6 +447,8 @@ int bind_r(int sk, struct sockaddr_storage *saddr) {
 		if (i >= MAX_BIND_RETRYS) {
 			fprintf(stderr, "Maximum bind() attempts. "
 				"Die now...\n\n");
+			free(host_s);
+			free(serv_s);
 			exit(1);
 		}
 	} while (error < 0 && i < MAX_BIND_RETRYS);
--
2.27.0

