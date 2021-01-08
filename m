Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18F32EFB2B
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Jan 2021 23:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAHWX7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 Jan 2021 17:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbhAHWX5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 8 Jan 2021 17:23:57 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51EFC061574
        for <linux-sctp@vger.kernel.org>; Fri,  8 Jan 2021 14:23:42 -0800 (PST)
Received: by sf.home (Postfix, from userid 1000)
        id 43BBD5A2208E; Fri,  8 Jan 2021 22:22:55 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-sctp@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>
Subject: [PATCH] m4/sctp.m4: make conpatible to autoconf-2.70
Date:   Fri,  8 Jan 2021 22:22:52 +0000
Message-Id: <20210108222252.95123-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On recently released `autoconf-2.70` generated `./configure`
fails as:

```
$ ./configure
...
checking for struct sctp_event_subscribe.sctp_stream_reset_event... yes
checking for gcc options needed to detect all undeclared functions... none needed
./configure: line 16464: syntax error: unexpected end of file
```

This happens becuase new autoconf generates less whitespace:

```
{
if ...
...
fi}
```

It requires at least whitespace between `fi` and `}`.

As input already has newlines the change just drops extra `{}`.

Tested on `autoconf-2.69` and `autoconf-2.70`.

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 m4/sctp.m4 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/m4/sctp.m4 b/m4/sctp.m4
index 6593517..94527a6 100644
--- a/m4/sctp.m4
+++ b/m4/sctp.m4
@@ -6,7 +6,7 @@
 
 # Macros to assist on probing kernel features
 #   Probes if a type is defined
-AC_DEFUN([LKSCTP_CHECK_TYPE], [{
+AC_DEFUN([LKSCTP_CHECK_TYPE], [
 AC_CHECK_TYPE([$1],
 	AC_DEFINE([$2], 1,
 		  [Define if $1 is present.])
@@ -22,10 +22,10 @@ AC_CHECK_TYPE([$1],
 #ifdef HAVE_LINUX_SCTP_H
 # include <linux/sctp.h>
 #endif
-])}])
+])])
 
 #   Probes if a struct has a given member
-AC_DEFUN([LKSCTP_CHECK_MEMBER], [{
+AC_DEFUN([LKSCTP_CHECK_MEMBER], [
 AC_CHECK_MEMBER([$1],
 	AC_DEFINE([$2], 1,
 		  [Define if $1 is present.])
@@ -41,10 +41,10 @@ AC_CHECK_MEMBER([$1],
 #ifdef HAVE_LINUX_SCTP_H
 # include <linux/sctp.h>
 #endif
-])}])
+])])
 
 #   Probes if a declaration is present
-AC_DEFUN([LKSCTP_CHECK_DECL], [{
+AC_DEFUN([LKSCTP_CHECK_DECL], [
 AC_CHECK_DECL([$1],
 	AC_DEFINE([$2], 1,
 		  [Define if $1 is present.])
@@ -60,4 +60,4 @@ AC_CHECK_DECL([$1],
 #ifdef HAVE_LINUX_SCTP_H
 # include <linux/sctp.h>
 #endif
-])}])
+])])
-- 
2.30.0

