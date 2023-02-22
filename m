Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3469F99D
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Feb 2023 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjBVRH0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 22 Feb 2023 12:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBVRH0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 22 Feb 2023 12:07:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C423D087;
        Wed, 22 Feb 2023 09:07:24 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id x1so8908668qtw.3;
        Wed, 22 Feb 2023 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGXNPtwwGNPiOIot7PfspErsb+4zelX+Smn7R6UMcFE=;
        b=bWmIGLB2LWpox4Vle2iW6M29PSxUoCeFh/e+5TUn9EoYdtndos73FmkYUNuF0XW6uP
         6C97sV6nhJTrCgF+0BAMg/UsJSxQi99tLR431cZWqAjLRDMK8EJdqvFY4VQWcTCHJfZU
         X/ogoQHAZVSPhvnawaLoQfHaaVDkEeznApVTN/2X7t8mwGwxObOUk+1A/mzrEJ2z6+Nd
         pWFa1zi8cIE411gEL/KpCBkoQ3gStW5wHKbbMw9fE8rb5WUJAqmdYGAJib4vsHL6N2Is
         Cmf1lZ+LbNyz75/OlIiq9fosDe9/rVw12NGGNln8cXvmy4SXnVEcNcm/RrLtHh7mM4Z6
         mlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGXNPtwwGNPiOIot7PfspErsb+4zelX+Smn7R6UMcFE=;
        b=rnb8+B0hmFv1trVkL54L2EaLIcIC9DYtcsv1Iu9nIPhD1b/wDoioWRWYGDvphcsWdU
         bde5MQSuVnDNVwdtgNslHf0XguW/M1032yHgdUyjqlsESbRD6neDPyOwDOqWv3MfwIeJ
         J8liQC8OVpxzAKLTwNX5GqgknMc9ToNaJ3OMJVbw52HQUp8aNq1UhYQoIni2u86NPGr4
         /WzHTBG7rK6bfVvPgIeW5SkamZUYkkxXRog4aH0RrHJDPL2zQWfN0v7KpX+zAy9G0nio
         wXntNAlTQDKzz50nf7RqpnF7uJ5NqHLxX3KLeeV4dWaB9LSl9X9w2t7/xPP7hG8zcAXR
         eHIQ==
X-Gm-Message-State: AO0yUKW4eikEd06S6/W3/vPJJKTCF+wII9/bh0P+FNi+Lp3IY1wARKFx
        /mwoKMJsaTEBXBlGihfHANZWe5Av3Rk0IQ==
X-Google-Smtp-Source: AK7set9ab9TEEeXV/zfC2eHTxI7c8JUNJ1pVZ5rHWriP3uZmf3Nyg9Ev5SGX6ERReFwxj8TCf7G6cw==
X-Received: by 2002:a05:622a:1a24:b0:3bf:a030:2e50 with SMTP id f36-20020a05622a1a2400b003bfa0302e50mr13014207qtb.64.1677085643586;
        Wed, 22 Feb 2023 09:07:23 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d184-20020a37b4c1000000b0073b7568d998sm558569qkf.2.2023.02.22.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:07:23 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Subject: [PATCHv2 net] sctp: add a refcnt in sctp_stream_priorities to avoid a nested loop
Date:   Wed, 22 Feb 2023 12:07:21 -0500
Message-Id: <825eb0c905cb864991eba335f4a2b780e543f06b.1677085641.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
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

With this refcnt added in sctp_stream_priorities, we don't need to
traverse all streams to check if the prio is used by other streams
when freeing one stream's prio in sctp_sched_prio_free_sid(). This
can avoid a nested loop (up to 65535 * 65535), which may cause a
stuck as Ying reported:

    watchdog: BUG: soft lockup - CPU#23 stuck for 26s! [ksoftirqd/23:136]
    Call Trace:
     <TASK>
     sctp_sched_prio_free_sid+0xab/0x100 [sctp]
     sctp_stream_free_ext+0x64/0xa0 [sctp]
     sctp_stream_free+0x31/0x50 [sctp]
     sctp_association_free+0xa5/0x200 [sctp]

Note that it doesn't need to use refcount_t type for this counter,
as its accessing is always protected under the sock lock.

v1->v2:
 - add a check in sctp_sched_prio_set to avoid the possible prio_head
   refcnt overflow.

Fixes: 9ed7bfc79542 ("sctp: fix memory leak in sctp_stream_outq_migrate()")
Reported-by: Ying Xu <yinxu@redhat.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/sctp/structs.h   |  1 +
 net/sctp/stream_sched_prio.c | 52 +++++++++++++++---------------------
 2 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index afa3781e3ca2..e1f6e7fc2b11 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1412,6 +1412,7 @@ struct sctp_stream_priorities {
 	/* The next stream in line */
 	struct sctp_stream_out_ext *next;
 	__u16 prio;
+	__u16 users;
 };
 
 struct sctp_stream_out_ext {
diff --git a/net/sctp/stream_sched_prio.c b/net/sctp/stream_sched_prio.c
index 42d4800f263d..4d4d9da331f4 100644
--- a/net/sctp/stream_sched_prio.c
+++ b/net/sctp/stream_sched_prio.c
@@ -25,6 +25,18 @@
 
 static void sctp_sched_prio_unsched_all(struct sctp_stream *stream);
 
+static struct sctp_stream_priorities *sctp_sched_prio_head_get(struct sctp_stream_priorities *p)
+{
+	p->users++;
+	return p;
+}
+
+static void sctp_sched_prio_head_put(struct sctp_stream_priorities *p)
+{
+	if (p && --p->users == 0)
+		kfree(p);
+}
+
 static struct sctp_stream_priorities *sctp_sched_prio_new_head(
 			struct sctp_stream *stream, int prio, gfp_t gfp)
 {
@@ -38,6 +50,7 @@ static struct sctp_stream_priorities *sctp_sched_prio_new_head(
 	INIT_LIST_HEAD(&p->active);
 	p->next = NULL;
 	p->prio = prio;
+	p->users = 1;
 
 	return p;
 }
@@ -53,7 +66,7 @@ static struct sctp_stream_priorities *sctp_sched_prio_get_head(
 	 */
 	list_for_each_entry(p, &stream->prio_list, prio_sched) {
 		if (p->prio == prio)
-			return p;
+			return sctp_sched_prio_head_get(p);
 		if (p->prio > prio)
 			break;
 	}
@@ -70,7 +83,7 @@ static struct sctp_stream_priorities *sctp_sched_prio_get_head(
 			 */
 			break;
 		if (p->prio == prio)
-			return p;
+			return sctp_sched_prio_head_get(p);
 	}
 
 	/* If not even there, allocate a new one. */
@@ -154,32 +167,21 @@ static int sctp_sched_prio_set(struct sctp_stream *stream, __u16 sid,
 	struct sctp_stream_out_ext *soute = sout->ext;
 	struct sctp_stream_priorities *prio_head, *old;
 	bool reschedule = false;
-	int i;
+
+	old = soute->prio_head;
+	if (old && old->prio == prio)
+		return 0;
 
 	prio_head = sctp_sched_prio_get_head(stream, prio, gfp);
 	if (!prio_head)
 		return -ENOMEM;
 
 	reschedule = sctp_sched_prio_unsched(soute);
-	old = soute->prio_head;
 	soute->prio_head = prio_head;
 	if (reschedule)
 		sctp_sched_prio_sched(stream, soute);
 
-	if (!old)
-		/* Happens when we set the priority for the first time */
-		return 0;
-
-	for (i = 0; i < stream->outcnt; i++) {
-		soute = SCTP_SO(stream, i)->ext;
-		if (soute && soute->prio_head == old)
-			/* It's still in use, nothing else to do here. */
-			return 0;
-	}
-
-	/* No hits, we are good to free it. */
-	kfree(old);
-
+	sctp_sched_prio_head_put(old);
 	return 0;
 }
 
@@ -206,20 +208,8 @@ static int sctp_sched_prio_init_sid(struct sctp_stream *stream, __u16 sid,
 
 static void sctp_sched_prio_free_sid(struct sctp_stream *stream, __u16 sid)
 {
-	struct sctp_stream_priorities *prio = SCTP_SO(stream, sid)->ext->prio_head;
-	int i;
-
-	if (!prio)
-		return;
-
+	sctp_sched_prio_head_put(SCTP_SO(stream, sid)->ext->prio_head);
 	SCTP_SO(stream, sid)->ext->prio_head = NULL;
-	for (i = 0; i < stream->outcnt; i++) {
-		if (SCTP_SO(stream, i)->ext &&
-		    SCTP_SO(stream, i)->ext->prio_head == prio)
-			return;
-	}
-
-	kfree(prio);
 }
 
 static void sctp_sched_prio_enqueue(struct sctp_outq *q,
-- 
2.39.1

