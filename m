Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1CB76E524
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Aug 2023 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjHCKAQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 3 Aug 2023 06:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjHCJ7l (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 3 Aug 2023 05:59:41 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305FC3A9A;
        Thu,  3 Aug 2023 02:59:36 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qRV7A-003BTH-4d; Thu, 03 Aug 2023 17:59:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 03 Aug 2023 17:59:28 +0800
Date:   Thu, 3 Aug 2023 17:59:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        hillf.zj@alibaba-inc.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com
Subject: crypto: api - Use work queue in crypto_destroy_instance
Message-ID: <ZMt6gH4FSHsDetkU@gondor.apana.org.au>
References: <20230802170923.1151605-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802170923.1151605-1-revest@chromium.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Aug 02, 2023 at 07:09:22PM +0200, Florent Revest wrote:
> 
> I found that the following program reliably reproduces a "BUG: sleeping function
> called from invalid context" backtrace in crypto code:

Great detective work! And thanks for cc'ing me :)

This is definitely a bug in the Crypto API.  Although it's hard to
trigger because you need to unregister the instance before the last
user frees it in atomic context.  The fact that it triggers for your
test program probably means that we're not creating the template
correctly and it gets unregistered as soon as it's created.

As to the fix I think we should move the work into crypto_destroy_instance
since that's the function that is being called from atomic context
and then does something that should only be done from process context.

So here's my patch based on your work:

---8<---
The function crypto_drop_spawn expects to be called in process
context.  However, when an instance is unregistered while it still
has active users, the last user may cause the instance to be freed
in atomic context.

Fix this by delaying the freeing to a work queue.

Fixes: 6bfd48096ff8 ("[CRYPTO] api: Added spawns")
Reported-by: Florent Revest <revest@chromium.org>
Reported-by: syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com
Reported-by: syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 5e7cd603d489..4fe95c448047 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -17,6 +17,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "internal.h"
 
@@ -74,15 +75,26 @@ static void crypto_free_instance(struct crypto_instance *inst)
 	inst->alg.cra_type->free(inst);
 }
 
-static void crypto_destroy_instance(struct crypto_alg *alg)
+static void crypto_destroy_instance_workfn(struct work_struct *w)
 {
-	struct crypto_instance *inst = (void *)alg;
+	struct crypto_instance *inst = container_of(w, struct crypto_instance,
+						    free_work);
 	struct crypto_template *tmpl = inst->tmpl;
 
 	crypto_free_instance(inst);
 	crypto_tmpl_put(tmpl);
 }
 
+static void crypto_destroy_instance(struct crypto_alg *alg)
+{
+	struct crypto_instance *inst = container_of(alg,
+						    struct crypto_instance,
+						    alg);
+
+	INIT_WORK(&inst->free_work, crypto_destroy_instance_workfn);
+	schedule_work(&inst->free_work);
+}
+
 /*
  * This function adds a spawn to the list secondary_spawns which
  * will be used at the end of crypto_remove_spawns to unregister
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 6156161b181f..ca86f4c6ba43 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -12,6 +12,7 @@
 #include <linux/cache.h>
 #include <linux/crypto.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 /*
  * Maximum values for blocksize and alignmask, used to allocate
@@ -82,6 +83,8 @@ struct crypto_instance {
 		struct crypto_spawn *spawns;
 	};
 
+	struct work_struct free_work;
+
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
