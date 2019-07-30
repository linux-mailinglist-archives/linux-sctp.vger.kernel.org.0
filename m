Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0A7AC71
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Jul 2019 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfG3PbH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 30 Jul 2019 11:31:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42495 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbfG3PbH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 30 Jul 2019 11:31:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so63463438qtm.9
        for <linux-sctp@vger.kernel.org>; Tue, 30 Jul 2019 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=icQ+mmUwHlGo5WrRaYExQwbod/Jz68i28SEVBs5MWe0=;
        b=TQAcMC8JLFSx1a3GX3PlPg86q7cbX6i8+ue1vGOYJkg/B7hCQb/49FmaadO8+aGcSn
         Brz9eeXm2C7YvtHtDee/XOQWV2gf2fi6RAn6CYVULtbVCzbBX6bmeT2plzcv6hfriDQR
         Vwqg9HSubXdL+SlkhQALukz6KLaaYpuzPB4Y/PxcFQ3OCus7vk169BqPcBMg2VCa//HN
         yh12pjChhhSdW7mgjIWXaVM1UCLbbRwqtC5HLX4lHzU4uEenTkXSy+im0m+pA6m54OW3
         1CSZwl9XVSavEOxFcff2NEymzqiM5IkkdfJ/yPaXf00QfHOmjVOU68U1C5l+TmyHYRQt
         7GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=icQ+mmUwHlGo5WrRaYExQwbod/Jz68i28SEVBs5MWe0=;
        b=OnZXE1HYY22kfIsoAPxteFa6iPfjWUb4CkHS7WG6KJLRmC3fNbHbfp6h1x6JTtiTyv
         7WLbA27Ph5k9nTUiLNuNGMJ/tE2/+sqlCvn1X9Nwwa78NUgDpkHg/QpK5fL55hcnvE/r
         68Cyc/HI+7cInJXXjhj4hEZkh7kJQbGJsHMSanw71Owgl5cS8cUnqxeJ3FdDYKho1uEM
         2U/dswXD9JheepqIslZwslRf38skJrv/t7iz2AlnHy1OJavc2c6wZ9DtGeLWQPXkPYzo
         SUbrBpLP4fUFEqucMkKLocgPLO0lBxg3Q8qqHX9HXN98UwiPxeV3I5R6FLwuYCi/JLYt
         zuGg==
X-Gm-Message-State: APjAAAVc4+XfxNI413LYdW6NEvw2V0trVeRxVgMsekRKOa4kLpqHKPCE
        z5UcEDB99FeSqqJSQdilGB9Pyg==
X-Google-Smtp-Source: APXvYqxWizCQ2lrtrTlT130eyj++JM/rzivWzH05iPty1SPyO9/8wH9PnKozyoEe5P7CKlh+ezMbhA==
X-Received: by 2002:a0c:8602:: with SMTP id p2mr84787456qva.111.1564500665583;
        Tue, 30 Jul 2019 08:31:05 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c5sm30023404qkb.41.2019.07.30.08.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 08:31:04 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, David.Laight@ACULAB.COM,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v3] net/socket: fix GCC8+ Wpacked-not-aligned warnings
Date:   Tue, 30 Jul 2019 11:30:33 -0400
Message-Id: <1564500633-7419-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

There are a lot of those warnings with GCC8+ 64-bit,

In file included from ./include/linux/sctp.h:42,
                 from net/core/skbuff.c:47:
./include/uapi/linux/sctp.h:395:1: warning: alignment 4 of 'struct
sctp_paddr_change' is less than 8 [-Wpacked-not-aligned]
 } __attribute__((packed, aligned(4)));
 ^
./include/uapi/linux/sctp.h:728:1: warning: alignment 4 of 'struct
sctp_setpeerprim' is less than 8 [-Wpacked-not-aligned]
 } __attribute__((packed, aligned(4)));
 ^
./include/uapi/linux/sctp.h:727:26: warning: 'sspp_addr' offset 4 in
'struct sctp_setpeerprim' isn't aligned to 8 [-Wpacked-not-aligned]
  struct sockaddr_storage sspp_addr;
                          ^~~~~~~~~
./include/uapi/linux/sctp.h:741:1: warning: alignment 4 of 'struct
sctp_prim' is less than 8 [-Wpacked-not-aligned]
 } __attribute__((packed, aligned(4)));
 ^
./include/uapi/linux/sctp.h:740:26: warning: 'ssp_addr' offset 4 in
'struct sctp_prim' isn't aligned to 8 [-Wpacked-not-aligned]
  struct sockaddr_storage ssp_addr;
                          ^~~~~~~~
./include/uapi/linux/sctp.h:792:1: warning: alignment 4 of 'struct
sctp_paddrparams' is less than 8 [-Wpacked-not-aligned]
 } __attribute__((packed, aligned(4)));
 ^
./include/uapi/linux/sctp.h:784:26: warning: 'spp_address' offset 4 in
'struct sctp_paddrparams' isn't aligned to 8 [-Wpacked-not-aligned]
  struct sockaddr_storage spp_address;
                          ^~~~~~~~~~~
./include/uapi/linux/sctp.h:905:1: warning: alignment 4 of 'struct
sctp_paddrinfo' is less than 8 [-Wpacked-not-aligned]
 } __attribute__((packed, aligned(4)));
 ^
./include/uapi/linux/sctp.h:899:26: warning: 'spinfo_address' offset 4
in 'struct sctp_paddrinfo' isn't aligned to 8 [-Wpacked-not-aligned]
  struct sockaddr_storage spinfo_address;
                          ^~~~~~~~~~~~~~

This is because the commit 20c9c825b12f ("[SCTP] Fix SCTP socket options
to work with 32-bit apps on 64-bit kernels.") added "packed, aligned(4)"
GCC attributes to some structures but one of the members, i.e, "struct
sockaddr_storage" in those structures has the attribute,
"aligned(__alignof__ (struct sockaddr *)" which is 8-byte on 64-bit
systems, so the commit overwrites the designed alignments for
"sockaddr_storage".

To fix this, "struct sockaddr_storage" needs to be aligned to 4-byte as
it is only used in those packed sctp structure which is part of UAPI,
and "struct __kernel_sockaddr_storage" is used in some other
places of UAPI that need not to change alignments in order to not
breaking userspace.

Use an implicit alignment for "struct __kernel_sockaddr_storage" so it
can keep the same alignments as a member in both packed and un-packed
structures without breaking UAPI.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Add some comments and rearrange the public member first per David.
v2: Use an implicit alignment for "struct __kernel_sockaddr_storage".

 include/uapi/linux/socket.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index 8eb96021709c..c3409c8ec0dd 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -6,17 +6,24 @@
  * Desired design of maximum size and alignment (see RFC2553)
  */
 #define _K_SS_MAXSIZE	128	/* Implementation specific max size */
-#define _K_SS_ALIGNSIZE	(__alignof__ (struct sockaddr *))
-				/* Implementation specific desired alignment */
 
 typedef unsigned short __kernel_sa_family_t;
 
+/*
+ * The definition uses anonymous union and struct in order to control the
+ * default alignment.
+ */
 struct __kernel_sockaddr_storage {
-	__kernel_sa_family_t	ss_family;		/* address family */
-	/* Following field(s) are implementation specific */
-	char		__data[_K_SS_MAXSIZE - sizeof(unsigned short)];
+	union {
+		struct {
+			__kernel_sa_family_t	ss_family; /* address family */
+			/* Following field(s) are implementation specific */
+			char __data[_K_SS_MAXSIZE - sizeof(unsigned short)];
 				/* space to achieve desired size, */
 				/* _SS_MAXSIZE value minus size of ss_family */
-} __attribute__ ((aligned(_K_SS_ALIGNSIZE)));	/* force desired alignment */
+		};
+		void *__align; /* implementation specific desired alignment */
+	};
+};
 
 #endif /* _UAPI_LINUX_SOCKET_H */
-- 
1.8.3.1

