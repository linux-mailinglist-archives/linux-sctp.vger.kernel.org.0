Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0190277311
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Jul 2019 22:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfGZU6E (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 26 Jul 2019 16:58:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39555 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfGZU6E (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 26 Jul 2019 16:58:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so53931739qtu.6
        for <linux-sctp@vger.kernel.org>; Fri, 26 Jul 2019 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T+JEyppx4WwyW8vt6kr515/BMarQgU2ZidwlHFsaCH4=;
        b=sjzG937HSuiyLwTvyDwQITKnW5C1A27K5TgfDKlfFKx9WKVmIZHvU0R0we9yl3E42C
         0WXXmV1FmkDMKGb0duAf176X4nvOrt8lSKB8Wu8Srvbp1nWUQI9uvoXnk+ApH6mlAe7Z
         AfWfCWrXrmya2/ez4ZquT3NQ/dlHMhya6J8RPcG0QTlLnXVs9ay4wRS7QRqUIE0FCrE+
         pL0MiV69l8Z3MLGaydnP4E2U+bxW7nkU3AZGx5KmXjlZ4aDCzg57+2stWBhxSAj7nTIZ
         dFFRdFuEKPqZemEwDgCD4fNInMCE33XQu4Oqq2+g3ZnDH1h72zTQsdgkxkA+MEjsNL5C
         F+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T+JEyppx4WwyW8vt6kr515/BMarQgU2ZidwlHFsaCH4=;
        b=nP+450XdDr1y8bhy/DpwzYOp2t3CS6sGkG3XxYjZs0pAQUq+44Od2WTOTF92KjXgTE
         o+Pht+PKdK1jWCTR/qEu8RFfedo0AA3a4auJLeRjz7c6a7fPxIShkViUcfxCQOCREFJI
         4lC7ybRijPq6KvZetazYDnmrf/dAGLFrFAR+ygKUzGH3+UnXMoDDIWMssd48hHixVU1I
         XQS1TtVyL237HtydyezoTEgUzd7t12mjSDSFWwtLjqwSHMETsZTMQRECRVIXh6vPF+jx
         PRgZrX5RpTGtZBe7TpAP31Kv2ikdIC+3vU5nwz3tF/EyWRvQ3w8ft0v9te9QvLByUBWy
         +2dA==
X-Gm-Message-State: APjAAAWuYmg6NyArYvJDnqaHryeKqRCWlp2FAAG06+m/Y64qlJVOlt7F
        f4Yx+0Qs0UwGiwdgVexmFrBoQw==
X-Google-Smtp-Source: APXvYqzx6hSkUg2tgBIL41Cd4+LnvgwZ8ERZL5Oxl5OkOuLJY3+ZRAh1CzXethWuLztTE4ZsDAYO2w==
X-Received: by 2002:a0c:bec9:: with SMTP id f9mr69008326qvj.243.1564174682532;
        Fri, 26 Jul 2019 13:58:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u16sm27573183qte.32.2019.07.26.13.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 13:58:01 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com
Cc:     linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
Date:   Fri, 26 Jul 2019 16:57:39 -0400
Message-Id: <1564174659-21211-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

There are a lot of those warnings with GCC8+ 64bit,

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
Fix them by aligning the structures and fields to 8 bytes instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/uapi/linux/sctp.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
index b8f2c4d56532..e7bd71cde882 100644
--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -392,7 +392,7 @@ struct sctp_paddr_change {
 	int spc_state;
 	int spc_error;
 	sctp_assoc_t spc_assoc_id;
-} __attribute__((packed, aligned(4)));
+} __attribute__((packed, aligned(8)));
 
 /*
  *    spc_state:  32 bits (signed integer)
@@ -724,8 +724,8 @@ struct sctp_assocparams {
  */
 struct sctp_setpeerprim {
 	sctp_assoc_t            sspp_assoc_id;
-	struct sockaddr_storage sspp_addr;
-} __attribute__((packed, aligned(4)));
+	struct sockaddr_storage sspp_addr __attribute__((aligned(8)));
+} __attribute__((packed, aligned(8)));
 
 /*
  * 7.1.10 Set Primary Address (SCTP_PRIMARY_ADDR)
@@ -737,8 +737,8 @@ struct sctp_setpeerprim {
  */
 struct sctp_prim {
 	sctp_assoc_t            ssp_assoc_id;
-	struct sockaddr_storage ssp_addr;
-} __attribute__((packed, aligned(4)));
+	struct sockaddr_storage ssp_addr __attribute__((aligned(8)));
+} __attribute__((packed, aligned(8)));
 
 /* For backward compatibility use, define the old name too */
 #define sctp_setprim	sctp_prim
@@ -781,7 +781,7 @@ enum  sctp_spp_flags {
 
 struct sctp_paddrparams {
 	sctp_assoc_t		spp_assoc_id;
-	struct sockaddr_storage	spp_address;
+	struct sockaddr_storage	spp_address __attribute__((aligned(8)));
 	__u32			spp_hbinterval;
 	__u16			spp_pathmaxrxt;
 	__u32			spp_pathmtu;
@@ -789,7 +789,7 @@ struct sctp_paddrparams {
 	__u32			spp_flags;
 	__u32			spp_ipv6_flowlabel;
 	__u8			spp_dscp;
-} __attribute__((packed, aligned(4)));
+} __attribute__((packed, aligned(8)));
 
 /*
  * 7.1.18.  Add a chunk that must be authenticated (SCTP_AUTH_CHUNK)
@@ -896,13 +896,13 @@ struct sctp_stream_value {
  */
 struct sctp_paddrinfo {
 	sctp_assoc_t		spinfo_assoc_id;
-	struct sockaddr_storage	spinfo_address;
+	struct sockaddr_storage	spinfo_address __attribute__((aligned(8)));
 	__s32			spinfo_state;
 	__u32			spinfo_cwnd;
 	__u32			spinfo_srtt;
 	__u32			spinfo_rto;
 	__u32			spinfo_mtu;
-} __attribute__((packed, aligned(4)));
+} __attribute__((packed, aligned(8)));
 
 /* Peer addresses's state. */
 /* UNKNOWN: Peer address passed by the upper layer in sendmsg or connect[x]
-- 
1.8.3.1

