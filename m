Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B072604F79
	for <lists+linux-sctp@lfdr.de>; Wed, 19 Oct 2022 20:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJSSUJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 Oct 2022 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJSSUI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 Oct 2022 14:20:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62190FBCE6
        for <linux-sctp@vger.kernel.org>; Wed, 19 Oct 2022 11:20:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a6so23270828ljq.5
        for <linux-sctp@vger.kernel.org>; Wed, 19 Oct 2022 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=leGn7lYjbLsCg1ruqtqQzH3i7rIADWTNWm3R6efH+Ts=;
        b=7IMbgOWr9aX9zK5Gxu2eiIoyOQgBCov0/9e28ADabZ3kz3vPaWWdtsE+KfmsirwNvl
         zgUIplAyFVcrnBWhQTzxiQCQ5RNvRe4LVUTu07lLWMdPuEIIbs5poPXVzViwe2PopWx+
         S2NRQv7xQAFbETr0CdzZhn2GxhmlookCSnrQO44Y+m83BoBVRuevSeQe9igJaNwIwn7x
         7A6EqMLIT7TmlbGTKqSvOQzt6Kg6NbFstn1GeA8iyzksyzwbB0aD0WOIDJDQM0UsIZOo
         t6t+w0m64sQCLVtq9fFUBeE7oYsc3dkap77omRWFLAxj2z1vF/6pDJLo9a/SZNgzeBgg
         r3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leGn7lYjbLsCg1ruqtqQzH3i7rIADWTNWm3R6efH+Ts=;
        b=QaPvzobi6M5DJbh7luDUsvGWYWnw2pKfzDNbm9bDJwAs8yEo1HdIfiV7emKCT7LJu2
         cbcpycagdsdRNQa3WYuflt2V0sDrlccQe6LM0M1SpIdCCYUwEqE/PvfjFdXRAz8sUMXa
         Ghz59yhrLJPG39OX1/aS3l49Bi+8kbYGFRiyWApDObRmR/KAUJJ177hIE0Trpcr04iP4
         VcHV6ZPP4DS96wbhG62dDlf6RS8g8UtM2oPMgF9eNl1Ss/xY629Cz3ukeR64JfW5+oKC
         yhYvqukfyCGF5FzqSuhxW0hZEXJcvn9dKUO4er7gdQgXS4cq7AYHLmEpCXb01aOeJt+n
         hYAA==
X-Gm-Message-State: ACrzQf3Wr3glJbKhYK3HiYXnx8+FMK8c7GUC9RmQEtQzHT1XuAa0agBR
        GQTt35KFF54nM4AQRmRFVQ8OpMCyxLP4
X-Google-Smtp-Source: AMsMyM45OeAzmZdMMd1kOsatYDjpF1Y4iE+YzFMV4oKRPzAYmMm4brFEHSt1lAOQkCcJAfznHbYpHg==
X-Received: by 2002:a2e:7019:0:b0:26f:a8a3:81de with SMTP id l25-20020a2e7019000000b0026fa8a381demr3348187ljc.530.1666203604024;
        Wed, 19 Oct 2022 11:20:04 -0700 (PDT)
Received: from localhost.localdomain ([95.161.223.113])
        by smtp.gmail.com with ESMTPSA id j23-20020ac24557000000b004a287c50c13sm2389916lfm.185.2022.10.19.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:20:03 -0700 (PDT)
From:   Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To:     linux-sctp@vger.kernel.org
Cc:     netdev@vger.kernel.org,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next 1/3] sctp: remove unnecessary NULL check in sctp_association_init()
Date:   Wed, 19 Oct 2022 21:07:33 +0300
Message-Id: <20221019180735.161388-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

'&asoc->ulpq' passed to sctp_ulpq_init() as the first argument,
then sctp_qlpq_init() initializes it and eventually returns the
address of the struct member back. Therefore, in this case, the
return pointer cannot be NULL.

Moreover, it seems sctp_ulpq_init() has always been used only in
sctp_association_init(), so there's really no need to return ulpq
anymore.

Detected using the static analysis tool - Svace.
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 include/net/sctp/ulpqueue.h | 3 +--
 net/sctp/associola.c        | 4 +---
 net/sctp/ulpqueue.c         | 5 +----
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/net/sctp/ulpqueue.h b/include/net/sctp/ulpqueue.h
index 0eaf8650e3b2..60f6641290c3 100644
--- a/include/net/sctp/ulpqueue.h
+++ b/include/net/sctp/ulpqueue.h
@@ -35,8 +35,7 @@ struct sctp_ulpq {
 };
 
 /* Prototypes. */
-struct sctp_ulpq *sctp_ulpq_init(struct sctp_ulpq *,
-				 struct sctp_association *);
+void sctp_ulpq_init(struct sctp_ulpq *ulpq, struct sctp_association *asoc);
 void sctp_ulpq_flush(struct sctp_ulpq *ulpq);
 void sctp_ulpq_free(struct sctp_ulpq *);
 
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 3460abceba44..63ba5551c13f 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -226,8 +226,7 @@ static struct sctp_association *sctp_association_init(
 	/* Create an output queue.  */
 	sctp_outq_init(asoc, &asoc->outqueue);
 
-	if (!sctp_ulpq_init(&asoc->ulpq, asoc))
-		goto fail_init;
+	sctp_ulpq_init(&asoc->ulpq, asoc);
 
 	if (sctp_stream_init(&asoc->stream, asoc->c.sinit_num_ostreams, 0, gfp))
 		goto stream_free;
@@ -277,7 +276,6 @@ static struct sctp_association *sctp_association_init(
 
 stream_free:
 	sctp_stream_free(&asoc->stream);
-fail_init:
 	sock_put(asoc->base.sk);
 	sctp_endpoint_put(asoc->ep);
 	return NULL;
diff --git a/net/sctp/ulpqueue.c b/net/sctp/ulpqueue.c
index 0a8510a0c5e6..24960dcb6a21 100644
--- a/net/sctp/ulpqueue.c
+++ b/net/sctp/ulpqueue.c
@@ -38,8 +38,7 @@ static void sctp_ulpq_reasm_drain(struct sctp_ulpq *ulpq);
 /* 1st Level Abstractions */
 
 /* Initialize a ULP queue from a block of memory.  */
-struct sctp_ulpq *sctp_ulpq_init(struct sctp_ulpq *ulpq,
-				 struct sctp_association *asoc)
+void sctp_ulpq_init(struct sctp_ulpq *ulpq, struct sctp_association *asoc)
 {
 	memset(ulpq, 0, sizeof(struct sctp_ulpq));
 
@@ -48,8 +47,6 @@ struct sctp_ulpq *sctp_ulpq_init(struct sctp_ulpq *ulpq,
 	skb_queue_head_init(&ulpq->reasm_uo);
 	skb_queue_head_init(&ulpq->lobby);
 	ulpq->pd_mode  = 0;
-
-	return ulpq;
 }
 
 
-- 
2.25.1

