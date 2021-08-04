Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB53E0025
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Aug 2021 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbhHDL3d (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Aug 2021 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhHDL3d (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Aug 2021 07:29:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF50C061798
        for <linux-sctp@vger.kernel.org>; Wed,  4 Aug 2021 04:29:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id az7so2358689qkb.5
        for <linux-sctp@vger.kernel.org>; Wed, 04 Aug 2021 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X9U53TVhI2TSRPIZYcqRLpEYvS6cEc6pNpvOFoP0zjM=;
        b=ORNxScea6FkNz6kVqKQM6C6fJkf6mgpnTsbBNetfb9YpbRnBIW7l8RhMeYzSrOvd6R
         gjQdSTjvz8UesVtdo/23B4Tn7a7h5u09/qIM0husaOLtEc+UO5vzQSlA7FYzbUJ51PUM
         ol4xZy7qCFlCvl5qLkCaX+s+ojJHikcgLiRcoRDfHh8DeWh3eVk6Io9LQnY2plZF2ZKc
         aZ9CMMJc6Bb3nF9bntb40n8uU9KdmlZnvAi4DhEvx1E31774spuqj3qfgNEH+kHlG7uf
         hxOHbL52eGDLYi6zCOSDn/zcd6/EvuooOoCIUA2h8aDVPbhbCLAkXCMM9Ym4uVaOQj4h
         2yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9U53TVhI2TSRPIZYcqRLpEYvS6cEc6pNpvOFoP0zjM=;
        b=VhyZFywk+fOacdb0dwWBtDW95yCA7LFZsCCZiYNFLS9kLBcMiRe/W1U4xPzeIt8QYU
         k8g7/RzRKNA49ML5DhpDFTa38n+Rw0k1VruEkTIbgWOCI0sYl0VnxKH6wi795oSRv60e
         19T7/p/knqB3ZnGkNFB8ovVvBremvoLMKhx7lGUNHKlkUTVglpKTZfYws4zrGP2rv2FL
         VFJNWaTUKTjCNnaE5Lt2lNtPYAoTjKOuIOLHQMv7CJPANbVibXs7i90ePorpqPIhK55p
         rO0yymYopRZyJhx9iomtgsUgunnAwJ3ZD2hKhfrUVz7r3xMeAW24tVPnyB6gWI3fqoh8
         S8mw==
X-Gm-Message-State: AOAM532KNISw8HMJXRdshPID1WwtOq3vxOb2Av00dXyr2Aq2BCadvaHy
        c/m7qNERQlP0WdfobnAc9dXPuI2YNIKfkQ==
X-Google-Smtp-Source: ABdhPJzoCgCgekc2KxoDjN07SQMhQZoHA0uw5YM8X6lrQIT4xZqFzJlj12xgPJLoS4Q9fuJvQwo6NA==
X-Received: by 2002:a37:9481:: with SMTP id w123mr25910565qkd.75.1628076559049;
        Wed, 04 Aug 2021 04:29:19 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j12sm720792qtj.21.2021.08.04.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:29:18 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools 1/4] myftp: replace use of deprecated gethostbyname with getaddrinfo
Date:   Wed,  4 Aug 2021 07:29:13 -0400
Message-Id: <95ad37e5e787189ecf8ddf38c09bf495f7bfb00a.1628076531.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1628076531.git.lucien.xin@gmail.com>
References: <cover.1628076531.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patch is to replace use of deprecated gethostbyname with
getaddrinfo in the file src/apps/myftp.c.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 configure.ac     |  2 +-
 src/apps/myftp.c | 40 ++++++++++++++++++----------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4e2f7b4..8345dab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,7 +75,7 @@ AC_FUNC_REALLOC
 AC_FUNC_SELECT_ARGTYPES
 AC_FUNC_SETVBUF_REVERSED
 AC_FUNC_VPRINTF
-AC_CHECK_FUNCS([bzero gethostbyname gettimeofday memmove memset select socket \
+AC_CHECK_FUNCS([bzero getaddrinfo gethostbyname gettimeofday memmove memset select socket \
 		strchr strerror strtol strtoul])
 
 # Support for stream reset even, added on v4.11, 35ea82d611da
diff --git a/src/apps/myftp.c b/src/apps/myftp.c
index 64fa3f2..473fa03 100644
--- a/src/apps/myftp.c
+++ b/src/apps/myftp.c
@@ -64,11 +64,11 @@ typedef enum { COMMAND_NONE, COMMAND_RECV, COMMAND_SEND } command_t;
 #define MAX_NUM_HOST	5
 static char *local_host[MAX_NUM_HOST];
 static int num_local_host = 0;
-static int local_port = 4444;
+static char *local_port = "4444";
 
 static int buffer_size = BUFSIZE;
 static char *remote_host = NULL;
-static int remote_port = 4444;
+static char *remote_port = "4444";
 static command_t command = COMMAND_NONE;
 static char *filename = NULL;
 static int interactive = 0;
@@ -133,7 +133,7 @@ static int parse_arguments(int argc, char *argv[])
 			break;
 		case 2:		/* local port */
 		case 'P':
-			local_port = atoi(optarg);
+			local_port = optarg;
 			break;
 		case 3:		/* remote host */
 		case 'h':
@@ -141,7 +141,7 @@ static int parse_arguments(int argc, char *argv[])
 			break;
 		case 4:		/* remote port */
 		case 'p':
-			remote_port = atoi(optarg);
+			remote_port = optarg;
 			break;
 		case 5:
 		case 'f':
@@ -236,6 +236,7 @@ emsg(char *prog,char *s)
 
 static int build_endpoint(char *argv0)
 {
+	struct addrinfo hints, *rp;
 	int retval,i;
 
 	/* Create the local endpoint.  */
@@ -245,22 +246,19 @@ static int build_endpoint(char *argv0)
 	}
 
 	for ( i = 0;i < num_local_host;i++ ) {
-		struct hostent *hst;
-		struct sockaddr_in laddr;
-
-		memset(&laddr, 0, sizeof(laddr));
 		/* Get the transport address for the local host name.  */
 		fprintf(stderr,"Hostname %d is %s\n",i+1,local_host[i]);
-		if ( (hst = gethostbyname(local_host[i])) == NULL ) {
+
+		memset(&hints, 0, sizeof(struct addrinfo));
+		hints.ai_family = AF_INET;
+		hints.ai_protocol = IPPROTO_SCTP;
+		if (getaddrinfo(local_host[i], local_port, &hints, &rp) != 0) {
 			fprintf(stderr, "%s: bad hostname: %s\n", argv0, local_host[i]);
 			exit(1);
 		}
-		memcpy(&laddr.sin_addr, hst->h_addr_list[0],sizeof(laddr.sin_addr));
-		laddr.sin_port = htons(local_port);
-		laddr.sin_family = AF_INET;
 
 		/* Bind this socket to the test port.  */
-		if ( bind(retval, (struct sockaddr *)&laddr, sizeof(laddr)) ) {
+		if (bind(retval, rp->ai_addr, rp->ai_addrlen)) {
 			emsg(argv0,"bind");
 			exit(-1);
 		}
@@ -339,21 +337,19 @@ command_send(char *argv0, int sk)
 {
 	struct msghdr outmsg;
 	struct iovec iov;
-	struct hostent *hst;
-	struct sockaddr_in remote_addr;
+	struct addrinfo hints, *rp;
 	int fd;
 	int msglen;
 	int ct;
 
 	/* Set up the destination.  */
-	hst = gethostbyname(remote_host);
-	if (hst == NULL || hst->h_length < 1) {
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family = AF_INET;
+	hints.ai_protocol = IPPROTO_SCTP;
+	if (getaddrinfo(remote_host, remote_port, &hints, &rp) != 0) {
 		fprintf(stderr, "%s: bad hostname: %s\n", argv0, remote_host);
 		exit(1);
 	}
-	memcpy(&remote_addr.sin_addr, hst->h_addr_list[0], sizeof(remote_addr.sin_addr));
-	remote_addr.sin_port = htons(remote_port);
-	remote_addr.sin_family = AF_INET;
 
 	/* Initialize the message struct we use to pass messages to
 	 * the remote socket.
@@ -364,8 +360,8 @@ command_send(char *argv0, int sk)
 	outmsg.msg_iovlen = 1;
 	outmsg.msg_control = NULL;
 	outmsg.msg_controllen = 0;
-	outmsg.msg_name = &remote_addr;
-	outmsg.msg_namelen = sizeof(remote_addr);
+	outmsg.msg_name = rp->ai_addr;
+	outmsg.msg_namelen = rp->ai_addrlen;
 
 	/* open the file */
 	if ( filename == NULL ) fd = 0;
-- 
2.27.0

