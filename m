Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9639E76D4C8
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Aug 2023 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjHBRKD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Aug 2023 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjHBRJr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Aug 2023 13:09:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94130F0
        for <linux-sctp@vger.kernel.org>; Wed,  2 Aug 2023 10:09:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31771a876b5so30462f8f.3
        for <linux-sctp@vger.kernel.org>; Wed, 02 Aug 2023 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690996175; x=1691600975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JXyrEikc3QRlWp5ZDjTpySdvtRjTtey3fpa/M0v9NY=;
        b=geuk+efyXZZ7bJlsEuhZfXB544jaiq13WtOYQ6V5CYcHjBb8P/eXLF5AwO0V+qSh8A
         lq7n9a+FxHXrJy9SaszDJzeDo2R6OQ8roA4Bus4J9eYKE8jEiNL13YWPWr65cmNvMlp4
         NbsBhU91qq33U40eqEa8UeOs3GBNeoSXSo4ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996175; x=1691600975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JXyrEikc3QRlWp5ZDjTpySdvtRjTtey3fpa/M0v9NY=;
        b=h3q+PY+xZFPOZfv4mmSSQGC1idjUq9KYMqSkxSM01Tii42n6HMg7/8NvwTzsmu2ZGM
         AkQ0jm8ZZX4UauYF0A4xFl8PfCL2IeQWstXM5JhNu+PT4E3WvuTe82N5MkbwQn4S9Ua5
         oGBbLz0I46H43C6+2W/NhHu3PYlpMk0tCRl9PkyehyOvMu+l6T0gl1UTYWoTNgdK+Hs7
         MQHQ6+QRcw9ar9q3AiiyZhl6yvIf7NTN0DXAHFJGOKmPJ7tQV9pW18+P8JyExdnEtsiU
         wGX+I4eV6xaIH6SDq/qUok6ZIs37olnOXHJl8KWmsUBlLLavigJ57dQCeFAsR9MWef3d
         gb+w==
X-Gm-Message-State: ABy/qLYo5Qr8H56tHXyXYQv9eJOTrpx+6tFib5zVQXnXDt5NJuYKRTAU
        +YQiJr/OCem6ZAnfw288yTwr6g==
X-Google-Smtp-Source: APBJJlEHrrXECtPdvO8iK3tMF69agBXEGUdVPex6vTfKSLGX0OejbkIg0UJ3blbMa5bYKZ6k1f1rvA==
X-Received: by 2002:adf:fc90:0:b0:317:6cca:a68a with SMTP id g16-20020adffc90000000b003176ccaa68amr5572520wrr.41.1690996174731;
        Wed, 02 Aug 2023 10:09:34 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4fa6:1e54:d09:5ba3])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b003063db8f45bsm19508396wrv.23.2023.08.02.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:09:33 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        hillf.zj@alibaba-inc.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, Florent Revest <revest@chromium.org>,
        syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com,
        syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
Subject: [RFC 1/1] crypto: Defer transforms destruction to a worker function
Date:   Wed,  2 Aug 2023 19:09:23 +0200
Message-ID: <20230802170923.1151605-2-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230802170923.1151605-1-revest@chromium.org>
References: <20230802170923.1151605-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Currently, crypto spawns can be freed in a softirq context (eg: from
sctp socket destruction's rcu callbacks). In that context, grabbing the
crypto_alg_sem is dangerous and makes CONFIG_DEBUG_ATOMIC_SLEEP scream.

Defer transform destruction to a worker function so they don't use that
semaphore in a softirq.

Reported-by: syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d769eed29cc42d75e2a3
Reported-by: syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=610ec0671f51e838436e
Signed-off-by: Florent Revest <revest@chromium.org>
---
 crypto/api.c           | 26 ++++++++++++++++++--------
 include/linux/crypto.h |  3 +++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index b9cc0c906efe..f877251954d5 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -640,6 +640,21 @@ void *crypto_alloc_tfm_node(const char *alg_name,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_tfm_node);
 
+void crypto_destroy_tfm_workfn(struct work_struct *w)
+{
+	struct crypto_alg *alg;
+	struct crypto_tfm *tfm;
+
+	tfm = container_of(w, struct crypto_tfm, free_work);
+	alg = tfm->__crt_alg;
+
+	if (!tfm->exit && alg->cra_exit)
+		alg->cra_exit(tfm);
+	crypto_exit_ops(tfm);
+	crypto_mod_put(alg);
+	kfree_sensitive(tfm->to_free);
+}
+
 /*
  *	crypto_destroy_tfm - Free crypto transform
  *	@mem: Start of tfm slab
@@ -650,20 +665,15 @@ EXPORT_SYMBOL_GPL(crypto_alloc_tfm_node);
  */
 void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
 {
-	struct crypto_alg *alg;
-
 	if (IS_ERR_OR_NULL(mem))
 		return;
 
 	if (!refcount_dec_and_test(&tfm->refcnt))
 		return;
-	alg = tfm->__crt_alg;
 
-	if (!tfm->exit && alg->cra_exit)
-		alg->cra_exit(tfm);
-	crypto_exit_ops(tfm);
-	crypto_mod_put(alg);
-	kfree_sensitive(mem);
+	tfm->to_free = mem;
+	INIT_WORK(&tfm->free_work, crypto_destroy_tfm_workfn);
+	queue_work(system_unbound_wq, &tfm->free_work);
 }
 EXPORT_SYMBOL_GPL(crypto_destroy_tfm);
 
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 31f6fee0c36c..34ff2e1dca2b 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -430,6 +430,9 @@ struct crypto_tfm {
 	
 	struct crypto_alg *__crt_alg;
 
+	struct work_struct free_work;
+	void *to_free;
+
 	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-- 
2.41.0.585.gd2178a4bd4-goog

