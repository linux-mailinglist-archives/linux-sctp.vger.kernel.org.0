Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA72368745
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Apr 2021 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbhDVThF (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 22 Apr 2021 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhDVThE (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 22 Apr 2021 15:37:04 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E8C061756
        for <linux-sctp@vger.kernel.org>; Thu, 22 Apr 2021 12:36:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z2so10540839qkb.9
        for <linux-sctp@vger.kernel.org>; Thu, 22 Apr 2021 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g7cwZdwPHtO98O1/vFSi4J+Xn26aWAZ2rf/uWbQBcag=;
        b=ctxVH6E1YswhB6PzwgFoxqcT135cwbf8kvY614J+GA8p6vH/WaWc4MQgbALxitfv2R
         xIj1IbbCVx/D0PqAU+MyASX1dxK/mTNJbfIhpqEQRNKgMTP+OTW25hDOyr79Ha287JK/
         DpETMBCb29P5SHsLtof0RVtLwWzEZiZ8afh8u7bkyRHYtOBy5GnA760mQMytv13vy7ut
         ljxHOoJ/m0kZNd+MSUf/sHQqiyVc8WQHjZ3cAiyHKWvBeucQ3rGpQncZQUSM47r0GiXd
         uLP7GGbWgQq7Bz3dstSTNJMg/MD1xjQDjteSId7jEtHM7ye3DKH8IKgeCUVpiI3aJEVW
         /fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7cwZdwPHtO98O1/vFSi4J+Xn26aWAZ2rf/uWbQBcag=;
        b=KnQcXjV6fHVP2DMdmJmPSbODo1kscOS7UDnli8ChOTIqtCYFQ19yc6etXGt9/CoCBr
         uWCFRYFE2KjCOurKc1FGa/4JBLmlNk/iPbC6Zz3CudgFrFD/oD4fJ9UEWeJQtRroIdkG
         eVCPVzFVXcl8yyKzprN9dk69ch9z+VnvMB23iVYXvSib+yxsZbh2hZf+8w7K99DVZcw+
         HhFXcSMIzV934Ad379elXWeame6d/F0iMIcJi7IDP3GnPHONTBg9DsLu0Yan+K88XoZ6
         yZuiuBeA7snF57ECWlxlaGDDHEKJ/lFGXRdyNm8ZKAuYlaJpfVglTC0DJ8LAh+gPbdsc
         K34Q==
X-Gm-Message-State: AOAM531Zs3Fc6p7PvoWiwapauhQfB5nlwtq/5vtmbEJQlUAqYLAX/HZJ
        tIMUntlYkxfese7z2f1L09k8cv6TTcAz/A==
X-Google-Smtp-Source: ABdhPJySdG4IMcABlb/ExLeeNz3V3MG2elQDF6aePt84h8HE86HSqhoNc5RsOhGVFQmBLDoJkYyolg==
X-Received: by 2002:a05:620a:49c:: with SMTP id 28mr382395qkr.39.1619120187938;
        Thu, 22 Apr 2021 12:36:27 -0700 (PDT)
Received: from horizon.localdomain ([2001:1284:f016:cf2c:418f:6a5d:9c7a:3723])
        by smtp.gmail.com with ESMTPSA id i5sm2885894qka.0.2021.04.22.12.36.27
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:36:27 -0700 (PDT)
Received: by horizon.localdomain (Postfix, from userid 1000)
        id 556EAC3C6F; Thu, 22 Apr 2021 16:36:25 -0300 (-03)
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     linux-sctp@vger.kernel.org
Subject: [PATCH lksctp-tools 2/2] sctp_sendv: avoid explicit memset for var initialization
Date:   Thu, 22 Apr 2021 16:36:19 -0300
Message-Id: <5cb3b02a6061b6a11dba41e4feed3d80c5afd1d6.1619119690.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619119690.git.marcelo.leitner@gmail.com>
References: <cover.1619119690.git.marcelo.leitner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 src/lib/sendmsg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/lib/sendmsg.c b/src/lib/sendmsg.c
index c2bd51029964f3bf05a512ea61d479c086f6088c..bee492134e30cbc41ecfce7117444d17c8ab9089 100644
--- a/src/lib/sendmsg.c
+++ b/src/lib/sendmsg.c
@@ -125,14 +125,12 @@ int sctp_sendv(int s, const struct iovec *iov, int iovcnt,
 {
 	char _cmsg[CMSG_SPACE(sizeof(struct sctp_sendv_spa))];
 	struct cmsghdr *cmsg = (struct cmsghdr *)_cmsg;
+	struct msghdr outmsg = {};
 	struct sockaddr *addr;
-	struct msghdr outmsg;
 	int len, cmsglen = 0;
 	int err, type, i;
 	char *addrbuf;
 
-	/* set msg_iov, msg_iovlen, msg_flags */
-	memset(&outmsg, 0x00, sizeof(outmsg));
 	outmsg.msg_iov = (struct iovec *)iov;
 	outmsg.msg_iovlen = iovcnt;
 	outmsg.msg_flags = flags;
-- 
2.30.2

