Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660B53E0026
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Aug 2021 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhHDL3e (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Aug 2021 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhHDL3e (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Aug 2021 07:29:34 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E21AC0613D5
        for <linux-sctp@vger.kernel.org>; Wed,  4 Aug 2021 04:29:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w10so1146482qtj.3
        for <linux-sctp@vger.kernel.org>; Wed, 04 Aug 2021 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g1q5nRRzmazFsYQ0mGzhluH1J2pkTsgobmZx2hQrwE8=;
        b=EcDIVhh9Cj8bQrRZGydUrRYPt7c1+FA4jlh0sHhgu0m/Yr3iQPIqk7ec5RDi0ftf0U
         ogWmHWfu515pT4ZA1iFle4mTT5AHEuAcf/nXp5X1V9H6pObexJJbjfs39LRumSX6aP8j
         1HWmqNIqaHdzrTjmkdw2vEyaW0n0vcw/ZZnOt7PZTxQjEntVfgp94xQ/hEqu/mXWvWQ8
         116/JvwauNMlDYI7KVkoGFgsmjZWElJ1786EVK1Yr+j1pcVNM9GVvzi+sov1haCj/T3N
         IvnzELTd6+/1A2UsYGnBVT8TNC5adNrRcmCCI37HPE15eWkzzUTzaV0V3pjk6UJRREtJ
         Cfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1q5nRRzmazFsYQ0mGzhluH1J2pkTsgobmZx2hQrwE8=;
        b=UXWwVrKQyaPjsntGkw7VFLOxsVtP5pxz/F9QnWxp8qE4OiiTwcCmsKgVlKmPNiciT2
         LSu0sQi7iw65O1WVSRscICaaq1Fd3YmnXNl34jda4wZYyTZv6UgA+hLtEBva/69X7lJj
         /84yl14ZftqjWjiKkO8RE/xDXDX0GH6+f1w7JIzr0lWcHQIuyw01W8tG2wLPRJNXFUpb
         ckxzwxlCJvDmq2yKIwSCu6oQxCVIvLKrP3JcM+YXFu+4CTiyLqp7M4rI21bIlQeqZmJP
         oiaEdibMS2FkKV8vztIED1r3+TuVigNLtvaJlzkKOndjzc4T8sUcZHuoQjiwDjUs2IGN
         6ppA==
X-Gm-Message-State: AOAM531DXIeI44aEbdaSQOSeFBsGuFpcNjnQe7PGuvuIbSm3EEuN/cOL
        dj7voAjaCWuWCINC6YQLzMtMOvGVB1cXqA==
X-Google-Smtp-Source: ABdhPJyg21XuP1uHmeGVhQ9oZcMH+fNvpmHn2lZdbEUwCpoDyGrUTT46BKbb7Y1FEywsRlkGBlNlvw==
X-Received: by 2002:ac8:4a19:: with SMTP id x25mr22522307qtq.389.1628076560206;
        Wed, 04 Aug 2021 04:29:20 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m6sm1050705qki.47.2021.08.04.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:29:19 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools 2/4] sctp_xconnect: replace use of deprecated gethostbyname with getaddrinfo
Date:   Wed,  4 Aug 2021 07:29:14 -0400
Message-Id: <f87f6193e51e371e62f45aa7fbd2d1cb4dabd73a.1628076531.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1628076531.git.lucien.xin@gmail.com>
References: <cover.1628076531.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patch is to replace use of deprecated gethostbyname with
getaddrinfo in the file src/apps/sctp_xconnect.c.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 src/apps/sctp_xconnect.c | 72 +++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/src/apps/sctp_xconnect.c b/src/apps/sctp_xconnect.c
index 6759c0e..5cd1049 100644
--- a/src/apps/sctp_xconnect.c
+++ b/src/apps/sctp_xconnect.c
@@ -63,13 +63,13 @@ int TST_CNT = 0;
 
 int mode = NOT_DEFINED;
 
-int	assoc_num,
-	remote_port,
-	local_port;
+int assoc_num;
 int active = 0;
 
-char *local_host = NULL;
-char *remote_host = NULL;
+char *local_host;
+char *remote_host;
+char *local_port;
+char *remote_port;
 sockaddr_storage_t client_loop,
 		server_loop;
 struct hostent *hst;
@@ -102,6 +102,7 @@ void usage(char *argv0)
 
 /* Parse command line options */
 void parse_arguments(int argc, char*argv[]) {
+	struct addrinfo hints, *rp;
 	int c;
 
 	while ((c = getopt(argc, argv, ":H:P:ach:ln:p:")) >= 0) {
@@ -110,7 +111,7 @@ void parse_arguments(int argc, char*argv[]) {
 				local_host = optarg;
 				break;
 			case 'P':
-				local_port = atoi(optarg);
+				local_port = optarg;
 				break;
 			case 'c':
 			    if (mode == NOT_DEFINED)
@@ -138,7 +139,7 @@ void parse_arguments(int argc, char*argv[]) {
 				assoc_num = atoi(optarg);
 				break;
 			case 'p':
-				remote_port = atoi(optarg);
+				remote_port = optarg;
 				break;
 			default:
 				usage(argv[0]);
@@ -146,6 +147,9 @@ void parse_arguments(int argc, char*argv[]) {
 		}
 	} /* while() */
 
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family = AF_INET;
+	hints.ai_protocol = IPPROTO_SCTP;
 	if (mode == CLIENT) {
 		if (assoc_num) {
 			if (assoc_num > MAXCLIENTNUM) {
@@ -160,13 +164,13 @@ void parse_arguments(int argc, char*argv[]) {
 			assoc_num = 1;
 
 		if (remote_host && remote_port) {
-			hst = gethostbyname(remote_host);
-
-			memcpy(&server_loop.v4.sin_addr, hst->h_addr_list[0],
-				   sizeof(server_loop.v4.sin_addr));
-
-			server_loop.v4.sin_family = AF_INET;
-server_loop.v4.sin_port = htons(remote_port);
+			if (getaddrinfo(remote_host, remote_port, &hints, &rp) != 0) {
+				printf("%s: bad remote hostname or port: %s, %s\n",
+				       argv[0], remote_host, remote_port);
+				usage(argv[0]);
+				exit(0);
+			}
+			memcpy(&server_loop, rp->ai_addr, rp->ai_addrlen);
 		} else {
 			printf("Remote host and remote port must be defined "
 				"in client mode\n");
@@ -174,20 +178,12 @@ server_loop.v4.sin_port = htons(remote_port);
 			exit(0);
 		}
 
-		if (local_host) {
-			hst = gethostbyname(local_host);
-
-			memcpy(&client_loop.v4.sin_addr, hst->h_addr_list[0],
-				   sizeof(client_loop.v4.sin_addr));
-		} else
-			client_loop.v4.sin_addr.s_addr = INADDR_ANY;
-
-		if (local_port)
-			client_loop.v4.sin_port = htons(local_port);
-		else
-			client_loop.v4.sin_port = 0;
-
-		client_loop.v4.sin_family = AF_INET;
+		if (getaddrinfo(local_host, local_port, &hints, &rp) != 0) {
+			printf("%s: bad local hostname or port: %s, %s\n",
+			       argv[0], local_host, local_port);
+			exit(0);
+		}
+		memcpy(&client_loop, rp->ai_addr, rp->ai_addrlen);
 	} else if (mode == SERVER) {
 		if (active) {
 			printf("This option if for client use only");
@@ -201,23 +197,17 @@ server_loop.v4.sin_port = htons(remote_port);
 			exit(0);
 		}
 
-		if (local_host) {
-			hst = gethostbyname(local_host);
-
-			memcpy(&server_loop.v4.sin_addr, hst->h_addr_list[0],
-				   sizeof(server_loop.v4.sin_addr));
-		} else
-			server_loop.v4.sin_addr.s_addr = INADDR_ANY;
-
-		if (local_port)
-			server_loop.v4.sin_port = htons(local_port);
-		else {
+		if (!local_port) {
 			printf("Specify a local port in server mode.\n");
 			usage(argv[0]);
 			exit(0);
 		}
-
-		server_loop.v4.sin_family = AF_INET;
+		if (getaddrinfo(local_host, local_port, &hints, &rp) != 0) {
+			printf("%s: bad local hostname or port: %s, %s\n",
+			       argv[0], local_host, local_port);
+			exit(0);
+		}
+		memcpy(&server_loop, rp->ai_addr, rp->ai_addrlen);
 	} else {
 		printf("Must assisgn a client or server mode.\n");
 		usage(argv[0]);
-- 
2.27.0

