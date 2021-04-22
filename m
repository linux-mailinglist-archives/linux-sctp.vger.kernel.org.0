Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8825368746
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Apr 2021 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhDVThF (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 22 Apr 2021 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhDVThE (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 22 Apr 2021 15:37:04 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237D5C06138B
        for <linux-sctp@vger.kernel.org>; Thu, 22 Apr 2021 12:36:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y12so34750080qtx.11
        for <linux-sctp@vger.kernel.org>; Thu, 22 Apr 2021 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yeCJzxRFnlAyOkNeZrJmuKBSn9qTwsc1Vd+Im2AaaA0=;
        b=U4/je8Dmf8YEpsUo4agwaHwAwcrMHajfJf0aYks0ABrUrPCLUMkb+Prhr6La8ppyHK
         gf0KdHnjKSCJzGo66B0VUnTrhsl4SaM68R0uFcx4FdAMhDRGnfpsUljrKkNQQR3lOWnb
         /Mz1tUA5VqEzzeefyYoeUFh4uDV3qnJMO41sR01n9il4+Nm1zRDMKm9L5b7Yaqw7xAcZ
         JD0no4TPzpAL/OYpd8SmoellPdsoqBboHZCOIMk9xxeq6cKQcJXXUibJ6HLAqggfjbBh
         gLyBjFKsw/LUTfscfFPKdlL2N1E/w5frpkTpgBFIYEHUVbpYuHVbp3MiWwZiBBo+zpSX
         LF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeCJzxRFnlAyOkNeZrJmuKBSn9qTwsc1Vd+Im2AaaA0=;
        b=iU2ji844srMPw6Jx5gXnDmfPNb/0rWMxJha+5u+iInad/9p9a74FvCObXzaI26UxzU
         m2u7FFJ8DFtGF7muimFmUxAuSntrfGQx/n1C2uqzGtixVJILn/kP7P4t/Fl7Y2PPBDAb
         7MvBoATVbM/1wsnINoVb76lng8pGbEbwVTKMBPR7I0VGUU4splGHT+XZvzQs/875fv3T
         rkiyCjKEdkWGCvGSnEvR4ArisbsJFB53UOgLJUP8qCUOV5UnEMYzB6mmWCQyciIIV33A
         M3Y4h8+W9+d7ANG6gQc1QMpb8FeEp+6Ih99ilSXN/Cf08P/qdYFLmUnPfaP+h/CknCft
         JDVA==
X-Gm-Message-State: AOAM530a9T8loo8M7ZdkWyJqIaV59xKzs/FWvvXAeaL0tVDKEha/S+JM
        wt/0nsNUqWRFLq1IIj53rCChfogOuhI1mA==
X-Google-Smtp-Source: ABdhPJy1GXCG0Cvk7KvILuUQzLmuZTADnOeVAxnwGtdheF/Y7uUR97qUvSbRFR9qAGb5hnuVh9vOkQ==
X-Received: by 2002:a05:622a:4d3:: with SMTP id q19mr77664qtx.55.1619120188169;
        Thu, 22 Apr 2021 12:36:28 -0700 (PDT)
Received: from horizon.localdomain ([177.220.172.96])
        by smtp.gmail.com with ESMTPSA id r25sm2902426qtm.18.2021.04.22.12.36.27
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:36:27 -0700 (PDT)
Received: by horizon.localdomain (Postfix, from userid 1000)
        id 526D4C3C54; Thu, 22 Apr 2021 16:36:25 -0300 (-03)
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     linux-sctp@vger.kernel.org
Subject: [PATCH lksctp-tools 1/2] sctp_send: fix ignored flags parameter
Date:   Thu, 22 Apr 2021 16:36:18 -0300
Message-Id: <0394d84584498d5551c5e630500a2cbb48491dc4.1619119690.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619119690.git.marcelo.leitner@gmail.com>
References: <cover.1619119690.git.marcelo.leitner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

CovScan noticed that outmsg.msg_flags was being used uninitialized
if sinfo was not provided. Lets fix it by initializing it with the flags
parameter, like sctp_sendv does.

Fixes: 91239acfc91f ("Add sctp_send() API support and testcases")
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 src/lib/sendmsg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/lib/sendmsg.c b/src/lib/sendmsg.c
index 4c90b0757f4bb1a337de44cfa974a356fef031e6..c2bd51029964f3bf05a512ea61d479c086f6088c 100644
--- a/src/lib/sendmsg.c
+++ b/src/lib/sendmsg.c
@@ -77,25 +77,21 @@ int
 sctp_send(int s, const void *msg, size_t len,
           const struct sctp_sndrcvinfo *sinfo, int flags)
 {
-	struct msghdr outmsg;
+	struct msghdr outmsg = {};
 	struct iovec iov;
 	char outcmsg[CMSG_SPACE(sizeof(struct sctp_sndrcvinfo))];
 
-	outmsg.msg_name = NULL;
-	outmsg.msg_namelen = 0;
 	outmsg.msg_iov = &iov;
 	iov.iov_base = (void *)msg;
 	iov.iov_len = len;
 	outmsg.msg_iovlen = 1;
-	outmsg.msg_control = NULL;
-	outmsg.msg_controllen = 0;
+	outmsg.msg_flags = flags;
 
 	if (sinfo) {	
 		struct cmsghdr *cmsg;
 
 		outmsg.msg_control = outcmsg;
 		outmsg.msg_controllen = sizeof(outcmsg);
-		outmsg.msg_flags = 0;
 
 		cmsg = CMSG_FIRSTHDR(&outmsg);
 		cmsg->cmsg_level = IPPROTO_SCTP;
-- 
2.30.2

