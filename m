Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED4270459
	for <lists+linux-sctp@lfdr.de>; Fri, 18 Sep 2020 20:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRStD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 18 Sep 2020 14:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgIRStD (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 18 Sep 2020 14:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600454941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4+ZF05WY4dPUCcgrjX91HKnfPEVSP++uIh0CVFrL8Jk=;
        b=St0b4VcRWFvuabK+8x7/ripkoJX9ozXjYbQx7zoiFFK7ftvs8UPqyXmlwsq+BAP/nCDjgb
        RvKgk3uYUFupLR34GFDuHC8dmC3zf1BdIo55AJnUxusYPuRmDXJu8+hsrdoNFPZSMqUJdb
        eel+XFlRAmarYvkBhFlz63LEKEOcxOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-UxQXIpsEO0K1norap5g-2A-1; Fri, 18 Sep 2020 14:48:44 -0400
X-MC-Unique: UxQXIpsEO0K1norap5g-2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 804551084C9D
        for <linux-sctp@vger.kernel.org>; Fri, 18 Sep 2020 18:48:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABFEE60FC2;
        Fri, 18 Sep 2020 18:48:42 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     linux-sctp@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH lksctp-tools] Use symvmer attribute, not asms for symbol versioning
Date:   Fri, 18 Sep 2020 20:48:30 +0200
Message-Id: <20200918184830.469979-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This project could not be built with LTO as it uses ASMs to implement
symbol versioning. ASMs like this are fundamentally incompatible with
LTO because GCC does not look inside the ASM string to find symbol
references. Starting with gcc-10 there is a new symbol attribute for
implementing symbol versioning.

A fallback to the old way of implementing symbol versioning via asms is
included, so it should work with clang as well as gcc-9 and
earlier.

Fixes: https://github.com/sctp/lksctp-tools/issues/35

Author: Jeff Law <law@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 configure.ac       |  8 ++++++++
 src/lib/connectx.c | 25 ++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5de5c763005e..d3e31c35e6bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -130,4 +130,12 @@ AC_ARG_ENABLE(tests,
 	[enable_tests=yes])
 AM_CONDITIONAL(BUILD_TESTS, [test $enable_tests != no])
 
+# GCC tries to be "helpful" and only issue a warning for unrecognized
+# attributes.  So we compile the test with Werror, so that if the
+# attribute is not recognized the compilation fails
+AC_LANG(C)
+AC_LANG_WERROR
+AC_COMPILE_IFELSE([AC_LANG_SOURCE([[__attribute__ ((symver ("foo@foo_1"))) void frob (void) { }]])],
+                  [AC_DEFINE([HAVE_ATTRIBUTE_SYMVER], [1], [Checking for symver attribute])], [])
+
 AC_OUTPUT
diff --git a/src/lib/connectx.c b/src/lib/connectx.c
index 5f4552bd011b..2a21e3abe58d 100644
--- a/src/lib/connectx.c
+++ b/src/lib/connectx.c
@@ -26,6 +26,18 @@
 #include <stdlib.h>
 #include <string.h>
 #include <fcntl.h>
+#include "config.h"
+
+#define __SYMPFX(pfx, sym) #pfx sym
+#define _SYMPFX(pfx, sym) __SYMPFX(pfx, sym)
+#define SYMPFX(sym) _SYMPFX(__USER_LABEL_PREFIX__, #sym)
+
+#if HAVE_ATTRIBUTE_SYMVER
+#define SYMVER(name, name2) __attribute__ ((symver (SYMPFX(name2))))
+#else
+#define SYMVER(name, name2) __asm__(".symver " SYMPFX(name) "," SYMPFX(name2));
+#endif
+
 
 /* Support the sctp_connectx() interface.
  *
@@ -64,6 +76,7 @@ static int __connectx_addrsize(const struct sockaddr *addrs,
 }
 			
 
+SYMVER(__sctp_connectx, sctp_connectx@)
 int __sctp_connectx(int fd, struct sockaddr *addrs, int addrcnt)
 {
 	int addrs_size = __connectx_addrsize(addrs, addrcnt);
@@ -75,6 +88,7 @@ int __sctp_connectx(int fd, struct sockaddr *addrs, int addrcnt)
 			    addrs_size);
 }
 
+SYMVER(sctp_connectx_orig, sctp_connectx@VERS_1)
 extern int sctp_connectx_orig (int)
 	__attribute ((alias ("__sctp_connectx")));
 
@@ -114,6 +128,7 @@ static int __connectx(int fd, struct sockaddr *addrs, socklen_t addrs_size,
 			  addrs, addrs_size);
 }
 
+SYMVER(sctp_connectx2, sctp_connectx@VERS_2)
 int sctp_connectx2(int fd, struct sockaddr *addrs, int addrcnt,
 		      sctp_assoc_t *id)
 {
@@ -125,6 +140,7 @@ int sctp_connectx2(int fd, struct sockaddr *addrs, int addrcnt,
 	return __connectx(fd, addrs, addrs_size, id);
 }
 
+SYMVER(sctp_connectx3, sctp_connectx@@VERS_3)
 int sctp_connectx3(int fd, struct sockaddr *addrs, int addrcnt,
 		      sctp_assoc_t *id)
 {
@@ -179,12 +195,3 @@ int sctp_connectx3(int fd, struct sockaddr *addrs, int addrcnt,
 	return __connectx(fd, addrs, addrs_size, id);
 }
 
-#define __SYMPFX(pfx, sym) #pfx sym
-#define _SYMPFX(pfx, sym) __SYMPFX(pfx, sym)
-#define SYMPFX(sym) _SYMPFX(__USER_LABEL_PREFIX__, #sym)
-#define SYMVER(name, name2) __asm__(".symver " SYMPFX(name) "," SYMPFX(name2))
-
-SYMVER(__sctp_connectx, sctp_connectx@);
-SYMVER(sctp_connectx_orig, sctp_connectx@VERS_1);
-SYMVER(sctp_connectx2, sctp_connectx@VERS_2);
-SYMVER(sctp_connectx3, sctp_connectx@@VERS_3);
-- 
2.28.0

