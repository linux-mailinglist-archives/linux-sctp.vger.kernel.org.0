Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901896CA81
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Jul 2019 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfGRH7x (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 18 Jul 2019 03:59:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34881 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389285AbfGRH7w (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 18 Jul 2019 03:59:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so6200283pgr.2
        for <linux-sctp@vger.kernel.org>; Thu, 18 Jul 2019 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MYr25ICKkv1t7BC8YBBDKUKobIWwbTrIct0yPExjIwY=;
        b=NVzcXRGlpisvoRFehzlfFJT+k8/aOSsM0VQfZCb+e68Y9YxHL7v3ohLJciVaGv1fKy
         23HzqmJ8dAr94oHi8rvylEyEiauZz6iAG5dZqPy6UxdFdh2iV2jbzVLLmbBU8CiWTNbS
         kgc2e1kY7zgpcN4f06y3cb3P7/ijJusiRmNxJ9LtGUW6oUH7EmGrNJtZqxiacfDLwXwa
         7gep+vzJbHkk6Iok+wWIouNtbDaTnuP+NZNaQUeXYCYQBSFmoVzoH92yvNPri05Xu7Jn
         4V+EH+3u9QEsmdqEyfABb6uuuDf0AVf5kyzKs/RVo9gyYaIa3aKgFlUNqYalBOVJNKMg
         6sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MYr25ICKkv1t7BC8YBBDKUKobIWwbTrIct0yPExjIwY=;
        b=mmCRIei1Wqfeexdprkw7i3UhxYn8rQJRRvqUf6SpIBjLq+n5riZxiT521irrE9xHpq
         E29Ic1QSvRuK4+4dH8gLaW2wHV3/73fNrniF+NtcrGOHn52vU1rKMxIweyju1nTo1C1/
         c92jEQCTlUX9jLOSQEHnVvmZunyWJSzYonZyPflBakbYEz+lbdzRA4Z0LGckTU5VY9Ow
         URIFwup69mBw27uaxO44SahlbVfCNhFwWN99xshKVJq8PtFSZdoJRvYm2p5toE78Oeh1
         ZTQT10cj9vAKM6hkshBUs9F9xoTBT/It/w/ishwIhQtK70YcEk6H99Eb+OHbl8f6/bts
         QGOw==
X-Gm-Message-State: APjAAAU1SKwc6EE4CpYx64CPgCfK9KAtaJq4SSjfjbTGGw8KRGSQ1SnX
        7Pz4ovAnvf1BsNvMPWfGlIHtvtR9
X-Google-Smtp-Source: APXvYqy8X1UrG2Y4LRwWzGmKuX7BCH/MfKnoY+KgCcgi7DO9M3SO3Yvvl5JAJd6V+G5yVc6LwEbAPA==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr49972176pjp.62.1563436791638;
        Thu, 18 Jul 2019 00:59:51 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b30sm39911358pfr.117.2019.07.18.00.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 00:59:50 -0700 (PDT)
From:   Jianwen Ji <jijianwen@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools] testlib: improve test_bind function
Date:   Thu, 18 Jul 2019 15:59:32 +0800
Message-Id: <20190718075932.32323-1-jijianwen@gmail.com>
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
 src/testlib/sctputil.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
index 9dbabd4..c03ff78 100644
--- a/src/testlib/sctputil.h
+++ b/src/testlib/sctputil.h
@@ -72,6 +72,10 @@ typedef union {
 #endif
 #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
 
+#ifndef MAX_BIND_RETRYS
+#define MAX_BIND_RETRYS 10
+#endif
+
 #define SCTP_IP_BCAST  	htonl(0xffffffff)
 #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
 
@@ -140,9 +144,22 @@ static inline int test_socket(int domain, int type, int protocol)
 
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

