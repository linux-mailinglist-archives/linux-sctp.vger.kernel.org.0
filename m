Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43345C942
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Nov 2021 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbhKXP6h (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Nov 2021 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbhKXP6g (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Nov 2021 10:58:36 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044AC061574
        for <linux-sctp@vger.kernel.org>; Wed, 24 Nov 2021 07:55:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t11so3064556qtw.3
        for <linux-sctp@vger.kernel.org>; Wed, 24 Nov 2021 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNPRAvzHRQiSHLn/cT4g8BBF0UaFRV39KtTNWBDdgrU=;
        b=h96H6htJjF+jMjGqjBzUFUr/U7nHA86WJjY4CvbUIl9cR0RNtMbHNbdtQVZ2bL7Ev4
         61LyJGrCKDs8IeBuMqUCTepLcrpHI7tNvb7VZnmAya/yNfjvDpjeVMQwpz9O5pOuCRV9
         dWuXjliKQauIoG94E4uzPPvdpNF61Sx2sO8prxdSnNJEdH1sDjfog1uSVfKI4LC6pz4L
         s+6Zzr1VPZI8bv9z0YitIXucDEZihrtFOVF6O6yfx/9DIoLnNBh3bwHMxRWw8YxvIIvV
         zrocGgNwyqtfsnxo0Zu8TBoyxfZG5T2NZRLQPmWVX5eQZGFXYnBfnZ6HJb2Yk3AmyPr2
         YXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LNPRAvzHRQiSHLn/cT4g8BBF0UaFRV39KtTNWBDdgrU=;
        b=WK2Qy5FiOQzwahrVw0ibjynlcrGEFUIYtyXjsrIeDoS/yYsw9p/Hd3mU9SyhfrIlKI
         ghRSx55934Tnhd0V6yrelxFCb3Mpmkj0bQIOguhF1khtZDu5kjrsJQZA1KVt8ovb2BLB
         APbEBkhB+PQvhKATESea0YwyxNN7A4eoYXmNiiXPrvboRexfkEEImzoDlkgMernt3GXW
         FbQXTxILHASn+qpGJ2057y7c1Rrjq4ojFxNTKBnyy4EWrwSmE+2DYz67+yCPqvDQNUpN
         zsAB1DVCwmgP6YwtIzccDE4x/C8rLUhtkunakGLxqlP8dUv46BGUQq5rZtIkCVkFs9Yg
         MSXg==
X-Gm-Message-State: AOAM532ckpmwC2Lw80Bk0u5dB64+opydm/c/+CztU2rol+R9h5ph/icF
        7DHgysogNS4SxVFjKUq9SQdQgoHYPeo=
X-Google-Smtp-Source: ABdhPJxW/CTEKiXfMDu/oEnUQscmhH1Li9LTosH73UGJ4TdPX6lVp6AzZHvThrTRp0XcCxL2ap+9uQ==
X-Received: by 2002:a05:622a:1014:: with SMTP id d20mr8852343qte.399.1637769325688;
        Wed, 24 Nov 2021 07:55:25 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i14sm62270qko.9.2021.11.24.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 07:55:25 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools] sctp_test: check strdup return in append_addr
Date:   Wed, 24 Nov 2021 10:55:24 -0500
Message-Id: <82e5a846ca8cedf06e36a83422b6cb51cb0be61b.1637769324.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

strdup() may return NULL in append_addr(), and we should do the
check for its return value before operating it.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 src/apps/sctp_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/apps/sctp_test.c b/src/apps/sctp_test.c
index e382804..59fd4ad 100644
--- a/src/apps/sctp_test.c
+++ b/src/apps/sctp_test.c
@@ -499,6 +499,9 @@ append_addr(const char *parm, struct sockaddr *addrs, int *ret_count)
 	char *ifname;
 	int ifindex = 0;
 
+	if (!ipaddr)
+		return NULL;
+
 	/* check the interface. */
 	ifname = strchr(ipaddr,'%');
 	if (ifname) {
-- 
2.27.0

