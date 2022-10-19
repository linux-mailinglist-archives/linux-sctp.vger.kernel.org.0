Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D6604F7C
	for <lists+linux-sctp@lfdr.de>; Wed, 19 Oct 2022 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJSSUL (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 Oct 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiJSSUJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 Oct 2022 14:20:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FE318352
        for <linux-sctp@vger.kernel.org>; Wed, 19 Oct 2022 11:20:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a6so23270909ljq.5
        for <linux-sctp@vger.kernel.org>; Wed, 19 Oct 2022 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdMe4wNLlPasVGo4Wb6xEZk50ae59ENm+PGbWOO1sik=;
        b=wEhRvLVVZEBCd5wkc5IQBPn0f047oHR5qiQtC5mDtGtN0eXPqe5Y6TCjm+87hoPEqY
         UzoLnxtkPfzHq6cGsUGgPih1LRrDamQT5y0L04jA8nFy5m7nnH7ub/gde8+AW4MOkNo2
         8Cw3klgCQgMyR/0gPbl/xElZb6S/suy5cUENQq3FCzBn3FH60KQ0lS2ta8iWiSLvAREv
         QLzjxBRa2PX7Qk4bMu8axOvIgsgjXnfQW4b6GPGsAd2K8slL4HxWEa1nujzzpgjpsLpA
         9OFjeW2Hpyfqpgzh5KPxnAEjC+y+n3Zsw/86ZApNvbRSb5wx4yT/eLj10lfHYjrNcmxE
         BL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdMe4wNLlPasVGo4Wb6xEZk50ae59ENm+PGbWOO1sik=;
        b=yhuRUO0lqdxvy0lAPib+jkXiezroxtZTsgHLFIg27V6zalzsjSrmNxCW6RANcDQVUy
         srweN6sS90Xs+QFNemCQtH42ssxPzPmVv0IWZulxZE+WNdJIA2gU7VwLcfIZmUxLs9wN
         +FTzaH5/RI8dg5uM+N3aM6UAGr69O5ubdAsZVlnC/4mwISLdB6qEfoAQU892daLm9FpT
         l24Gt0fs7/pqCJlGg3k7XB6X0lnP2wt61CguRXa+21U99k2gBK3wKIR3skdIidqW9jQW
         io/2R87ruaK3sswkKqZm/8LlTyfa+bXXaWgRfZ7m2LklCmQRaxH2PwR4i5Trqzq700Iv
         ygGw==
X-Gm-Message-State: ACrzQf36BuDCfaulLFrW8xm7dDA96qgCQEcvmMrAgDGkc8dNArBpzBId
        grTjXAz8e0w3fh/CHmFb7uX8qhMMt9wp
X-Google-Smtp-Source: AMsMyM7fUlk+9j02IdUBW1dVtCtdvm2N294zOE1+6/rsqQUY4kzQ1RcCT9GNGF/YGNF2Gty6jWU52w==
X-Received: by 2002:a05:651c:1609:b0:26e:93e8:b6e with SMTP id f9-20020a05651c160900b0026e93e80b6emr3605472ljq.456.1666203605608;
        Wed, 19 Oct 2022 11:20:05 -0700 (PDT)
Received: from localhost.localdomain ([95.161.223.113])
        by smtp.gmail.com with ESMTPSA id j23-20020ac24557000000b004a287c50c13sm2389916lfm.185.2022.10.19.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:20:05 -0700 (PDT)
From:   Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To:     linux-sctp@vger.kernel.org
Cc:     netdev@vger.kernel.org,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next 3/3] sctp: remove unnecessary NULL checks in sctp_enqueue_event()
Date:   Wed, 19 Oct 2022 21:07:35 +0300
Message-Id: <20221019180735.161388-3-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019180735.161388-1-aleksei.kodanev@bell-sw.com>
References: <20221019180735.161388-1-aleksei.kodanev@bell-sw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

After commit 178ca044aa60 ("sctp: Make sctp_enqueue_event tak an
skb list."), skb_list cannot be NULL.

Detected using the static analysis tool - Svace.
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 net/sctp/stream_interleave.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index bb22b71df7a3..94727feb07b3 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -490,11 +490,8 @@ static int sctp_enqueue_event(struct sctp_ulpq *ulpq,
 	if (!sctp_ulpevent_is_enabled(event, ulpq->asoc->subscribe))
 		goto out_free;
 
-	if (skb_list)
-		skb_queue_splice_tail_init(skb_list,
-					   &sk->sk_receive_queue);
-	else
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
+	skb_queue_splice_tail_init(skb_list,
+				   &sk->sk_receive_queue);
 
 	if (!sp->data_ready_signalled) {
 		sp->data_ready_signalled = 1;
@@ -504,10 +501,7 @@ static int sctp_enqueue_event(struct sctp_ulpq *ulpq,
 	return 1;
 
 out_free:
-	if (skb_list)
-		sctp_queue_purge_ulpevents(skb_list);
-	else
-		sctp_ulpevent_free(event);
+	sctp_queue_purge_ulpevents(skb_list);
 
 	return 0;
 }
-- 
2.25.1

