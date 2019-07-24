Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FA72C72
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jul 2019 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfGXKjv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 06:39:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGXKjv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 06:39:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id c73so20737008pfb.13
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o/RKSSh659MoXoIRvP2Wc0nlwAkw0Rr9O9h5yLfbG0M=;
        b=logYo6cOMUH4rA2A4xX9rVy03nKT/0Xx3fmoQX6wYK5i4Tf9wDpSRID9bycGF1X9H/
         pxTjt60WrbzDg1Qv6wOOGR5ka5lhtGXr2dUlDyfh3/YauXGfqiySKJ8CLnglslGEEU3d
         mxOETp1iNV2nBgMjtAxtTSkOgxRvTGDtP1T9SnhAhRISZ0P50WSniALwhShFJVIBZ5lF
         2Bw83Tsp/dVFMc7ZYYf7XGPFnvSzOOWy5DAw8XajRU8/RR/GhWIvxCEX8pIZOcogiyAi
         hflbHgJ13QEW+NVIutX4DYgUV8NdSAkr25MuIO8gwhfeFT7YAZhcjjZUz0MFefc9kjHl
         fseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o/RKSSh659MoXoIRvP2Wc0nlwAkw0Rr9O9h5yLfbG0M=;
        b=QFsNRCrXZmsroZzhmZlrYl6ZqKHNDcR9S7ssKvga4M2NGCTp0aZJ0zOXSL87xqesBO
         v3ye9ijNNhN0pFDA0t3SHFh2ohk0ziV2H1SPYg9tmHC3wI0PJNYhQyjdyFXsUfhfQ3qT
         WmMGvoQ/E3XpuwaP5dMtKxdjAz5CnfF30nW/26SGABzp9wB48ZWZRHKl7BNLp47dKa23
         XnxFm3ow0U76SDFiKpLPngs40wuJC43shA7bVkMt3UFb6bLMO2MRqcgRMGnP/trf38Xy
         +4Dp5byQwi8Ps3LgcksLQIqcNOgfYuWgCKt7JPG/YeX/gkgYwVB8UTNVrLfvqNoDYWcG
         WcXg==
X-Gm-Message-State: APjAAAWUIH33Y8vyUukBi1rpafUdnCsprgde5rvHxbrYpiNWS3cVi+t7
        l4NzEpnLrpipRsxuUObsOboRgkqJjSg=
X-Google-Smtp-Source: APXvYqzvPos0yZrJzIA+RWUsoIxQbRKeS9aqCtG02vTSd5ZjOqYVChWd18FxyRMz708Aj7LF70MWvw==
X-Received: by 2002:a62:584:: with SMTP id 126mr10730776pff.73.1563964790636;
        Wed, 24 Jul 2019 03:39:50 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm48792018pfn.6.2019.07.24.03.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 03:39:49 -0700 (PDT)
From:   Jianwen Ji <jijianwen@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: [PATCH v2 lksctp-tools] testlib: improve test_bind function
Date:   Wed, 24 Jul 2019 18:39:30 +0800
Message-Id: <20190724103930.13727-1-jijianwen@gmail.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Try to bind again if the errno is EADDRINUSE.
Some tests failed to run sometimes, here is one snapshot:

   ...

   test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
   test_sockopt.c 26 BROK : bind: Address already in use
   DUMP_CORE ../../src/testlib/sctputil.h: 145

   ...

   test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EPIPE
   test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
   DUMP_CORE ../../src/testlib/sctputil.h: 145

The reason is that it closed a socket and then created a new socket
to bind the same socket address as before, which was not released
yet.

Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
---
 src/testlib/sctputil.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
index 9dbabd4..5b807c7 100644
--- a/src/testlib/sctputil.h
+++ b/src/testlib/sctputil.h
@@ -54,6 +54,7 @@
 #endif
 
 #include <string.h>
+#include <unistd.h>
 
 typedef union {
 	struct sockaddr_in v4;	
@@ -72,6 +73,10 @@ typedef union {
 #endif
 #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
 
+#ifndef MAX_BIND_RETRYS
+#define MAX_BIND_RETRYS 10
+#endif
+
 #define SCTP_IP_BCAST  	htonl(0xffffffff)
 #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
 
@@ -140,9 +145,22 @@ static inline int test_socket(int domain, int type, int protocol)
 
 static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
 {
-	int error = bind(sk, addr, addrlen);
-        if (-1 == error)
-                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
+	int error = 0, i = 0;
+
+	do {
+		if (i > 0) sleep(1); /* sleep a while before new try... */
+
+		error = bind(sk, addr, addrlen);
+		if (-1 == error && errno != EADDRINUSE) {
+			tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
+		}
+
+		i++;
+		if (i >= MAX_BIND_RETRYS) {
+			tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
+		}
+	} while (error < 0 && i < MAX_BIND_RETRYS);
+
 	return error;
 }
 
-- 
2.14.5

