Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8D790587
	for <lists+linux-sctp@lfdr.de>; Sat,  2 Sep 2023 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351640AbjIBGIi (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 2 Sep 2023 02:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351646AbjIBGIf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 2 Sep 2023 02:08:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C4D1706
        for <linux-sctp@vger.kernel.org>; Fri,  1 Sep 2023 23:08:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26d63b608d4so1873630a91.2
        for <linux-sctp@vger.kernel.org>; Fri, 01 Sep 2023 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693634906; x=1694239706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLwiit0Mxv4IXhIst8in8MxzaBF9EIw6p1kthVlmEo=;
        b=OoXZikdRX9OWksfd/uckMcUS12HfM36w3H3vEtPd6nA/Fvhmn1Z1CoWXcZ7buqmQxG
         DC3jZhGpPgm8p0qyL5k37lQO9Che63GS/cOjFxx/xc6o+Q1mqf4GQlJGTJNAxT78BxNE
         kTPonq98POj2KN99Cg/RiEWKhOyCu3qbdAlQ+oVLpaSaiuPI8hkgUA2MhKhJ+EPQSHmY
         +I+eq86NsuBOJMw3tdEbKnvcnsn4o+xd5trsT5lQFBqz17aX2eU9Ct19VIVobp6HuFaK
         Jzwb8fAC+KBi8wpSe2waMctQykOb0xED1DT9NkCJmkgpGc3Vw5HtcOCuHEC7YMeEtqm/
         8KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693634906; x=1694239706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsLwiit0Mxv4IXhIst8in8MxzaBF9EIw6p1kthVlmEo=;
        b=My83XN4CWxvgFc0ZbnfTZBGdAl5P0vX3qNdtqdR14oi/+jgHoQNi3qzwmRRCkX200u
         35pRTfnUC2lJJRbplQR1iEDEvGqoqPC2NLY654KE+ewcx3aYOnswLXi/h3OMSaK3uPod
         hcFKHl6KVh7lfssJADSzui3Eej5gsCoTIAPa5ueqp7ndi1KyifP+mMp+IOvNbdXkLziW
         YCHI61l8VdWmx2wPyTHKbhyXUNfKfSGwbR35QzNfBESabdGdqHalEXCIKlZi46iRmpFU
         z3D/jLYk8uZtS86eAF/ovm7JsYXaLlUEFCfO4KA/fEKIaVDYHPM5cWkeciqOX5lBXKlN
         YHTQ==
X-Gm-Message-State: AOJu0YyDPM8+9hp00455kIP+Zx8NaiLnGJ3XFaGc5yC8a1eskS83KCTW
        8jZDAyHi9XpO/P9xOQNUNcJ6jjKeR0gleQ==
X-Google-Smtp-Source: AGHT+IG8Waf7z+LCRguvFIq7lAdmVZga7Di0UTMkc9uBH12IYG9ezIm3g5AlThlnUifNkewKkV0wZA==
X-Received: by 2002:a17:90a:4a90:b0:271:7ce5:2575 with SMTP id f16-20020a17090a4a9000b002717ce52575mr3645772pjh.22.1693634906140;
        Fri, 01 Sep 2023 23:08:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a40d:5ac2:6bab:c627:af57:9218])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b00271c5811019sm4208916pja.38.2023.09.01.23.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 23:08:25 -0700 (PDT)
From:   Shubh <shubhisroking@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Shubh <shubhisroking@gmail.com>
Subject: [PATCH] sctp: Fix spelling mistake "tranport" -> "transport"
Date:   Sat,  2 Sep 2023 11:38:18 +0530
Message-ID: <20230902060818.35184-1-shubhisroking@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

