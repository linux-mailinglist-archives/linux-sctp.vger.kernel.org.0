Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4F790714
	for <lists+linux-sctp@lfdr.de>; Sat,  2 Sep 2023 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjIBJfg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 2 Sep 2023 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjIBJfg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 2 Sep 2023 05:35:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67478CC
        for <linux-sctp@vger.kernel.org>; Sat,  2 Sep 2023 02:35:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26f51625d96so1878274a91.1
        for <linux-sctp@vger.kernel.org>; Sat, 02 Sep 2023 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693647331; x=1694252131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLwiit0Mxv4IXhIst8in8MxzaBF9EIw6p1kthVlmEo=;
        b=FOQVlnPtYiHm+tPHNNAop0BkPGf5wbkbRzVRReC/3JtlT2QbRG1V/PFyBFTk3bOifD
         srYHHUBRWhvxoAiXbfBGrvaGm9O9ROlM9dSO5ufXcDQvHnglh9WY+LoqzLVNA2ZYWQ4w
         g9G0v5yQafVqXOkXBzPcFvMaE4mzwAge7sVUw/VNZwbVdovJs3vpZV21d8k1j/ssxfnp
         F09RVI3H2+Vu+dIvyMJOCGxnmNtmST7/QDoigP8h6otWJfzo91oYb6VPpsKpvDSiY31+
         K9zQIp1xVb/PgtmftS0+qZgUXaXRWnvdshMLlzlCgQg9qKswOBzkvEhLxYv3Kaeap0DQ
         gLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693647331; x=1694252131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsLwiit0Mxv4IXhIst8in8MxzaBF9EIw6p1kthVlmEo=;
        b=cWaHfrnhpnCm4FRtBl9ns7Y+VVrsFg6RHt4V89Vzp16W5vLH1VRbBAqDZ5Ax/8YmpJ
         TJSc+XVGEeusxLW2Loy3k7ZBtX1DEEqyhGNAx+GaaxqO/Pz1iYyYrif68/KdwgmmIQGD
         c4umwwU1lZdUD1df2ItAOwAMJpMoazzA3fGVRD/nrJyaXUmXXuvonfQTN62UEcHmbyp1
         wMR/N3JzmtAWtn3eFWZqgxHTBgQ3B9u+2em6VvGxqAq0ci6VmsuCf+SVfL9HN5rIrVbX
         1++ZB9XXq2OZWQwjVtBxTxviuigXaFZrUeqz45j7yzdr+gluIdIsB4VHcCU0Rw7Ve6kP
         v+zw==
X-Gm-Message-State: AOJu0YwUTtkfND1LTMOWCFjFvTGSu1m3lpcLe+F8wPo8lENi1vOHM7kI
        MDOVTF8p1+z4x6loAn2QTL8uULuOkiyJcGnn
X-Google-Smtp-Source: AGHT+IF2rz3r9/2VY4+Pr2g+CuhAJUdVY05Zi0HS6I5uGcc57IsOC/xG8Fnwy70BJwIM1WFyNh/kTA==
X-Received: by 2002:a17:90a:db45:b0:271:8d4d:d047 with SMTP id u5-20020a17090adb4500b002718d4dd047mr3927019pjx.34.1693647331219;
        Sat, 02 Sep 2023 02:35:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a40d:5ac2:6bab:c627:af57:9218])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a199900b002693505391csm6359243pji.37.2023.09.02.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 02:35:30 -0700 (PDT)
From:   Shubh <shubhisroking@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Shubh <shubhisroking@gmail.com>
Subject: [PATCH] sctp: Fix spelling mistake "tranport" -> "transport"
Date:   Sat,  2 Sep 2023 15:04:57 +0530
Message-ID: <20230902093457.70049-1-shubhisroking@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Signed-off-by: Shubh <shubhisroking@gmail.com>
---
 include/net/sctp/structs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 5a24d6d85..caea9ab73 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -795,7 +795,7 @@ struct sctp_transport {
 		 */
 		hb_sent:1,
 
-		/* Is the Path MTU update pending on this tranport */
+		/* Is the Path MTU update pending on this transport */
 		pmtu_pending:1,
 
 		dst_pending_confirm:1,	/* need to confirm neighbour */
-- 
2.42.0

