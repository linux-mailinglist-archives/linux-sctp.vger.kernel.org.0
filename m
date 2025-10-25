Return-Path: <linux-sctp+bounces-704-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F8C08D6F
	for <lists+linux-sctp@lfdr.de>; Sat, 25 Oct 2025 09:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410E51C86ED6
	for <lists+linux-sctp@lfdr.de>; Sat, 25 Oct 2025 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7E72E54DA;
	Sat, 25 Oct 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="s//E3hTF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83557DDA9;
	Sat, 25 Oct 2025 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761378202; cv=none; b=KCFpF3Pl+hcXSfXnI5yJLjVtFT4kICSNRBWBI6G9L+TP2mCSjg/dMTi6v7iNVFlxqFMH4iu2SATmD7Orvocv3NzgV00k7RKFYmzaw+RIDOoG2tN9mtYlPFGceRs8IGy84URjotlwrUcWSGdc+o/+CZPutPhs9CM9BtFk0GSuwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761378202; c=relaxed/simple;
	bh=ZRMfpwIeiEBaIp3IOE1MWUX3+PUDqBU0KpRlnoaXh+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlQgJqFo/FA4kM5cpZBkGcfPMKt7nYhyxLQwyMs64FIQRH8XHLIj/ESb4c5cTW4wXxC/d3euWhtNfeY5fcvou7eTZSR3OoeUsjEKUUaH8qnD6L6C0pNqNhdsEjQ2PJnQq653rlFnDOLxjPQKULD7/pCwbG0OAao+HOcSo91lSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=s//E3hTF; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CYvev1LQVZqBKCYvevAwog; Sat, 25 Oct 2025 09:43:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761378192;
	bh=v+RrkQ9YUdsboOCqsglN3Kfef+K4bp/CGqXgH+DRYlw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=s//E3hTFwLeP74Ah9/JHDaNzhvTaqsKyvUp05oW7HyCeyi849vJh7qNzpkClr862x
	 DywX8nr/w1Vverky24pJl0bADjNpouD2ngIuQ/iWE/9i2JnWYSpdVQy/h7Wk306pJY
	 zR5g4nFETG2xlWtVjkaElUukHIZL0inapNlNpgTkSGQDyXNvwYSU97wOAy+LYsxrUn
	 6lHhmq/2cg3mcDcBg9Ico3ejrYorRb+CrcvKnIWtzPS37bSgAYs0+oDuBS4LJkm1a1
	 wWboq/WuYHfp/vJDmSPCerzH+e1cC6LKzdEidMNxy2OdVlamt6Zk4FPo6jh6DzhFJu
	 I7CTiRb0VBCDg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 25 Oct 2025 09:43:12 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] sctp: Constify struct sctp_sched_ops
Date: Sat, 25 Oct 2025 09:40:59 +0200
Message-ID: <dce03527eb7b7cc8a3c26d5cdac12bafe3350135.1761377890.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct sctp_sched_ops' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   8019	    568	      0	   8587	   218b	net/sctp/stream_sched_fc.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   8275	    312	      0	   8587	   218b	net/sctp/stream_sched_fc.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only with:
  make net/sctp/
---
 include/net/sctp/stream_sched.h |  4 ++--
 include/net/sctp/structs.h      |  2 +-
 net/sctp/stream.c               |  8 ++++----
 net/sctp/stream_sched.c         | 16 ++++++++--------
 net/sctp/stream_sched_fc.c      |  4 ++--
 net/sctp/stream_sched_prio.c    |  2 +-
 net/sctp/stream_sched_rr.c      |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/net/sctp/stream_sched.h b/include/net/sctp/stream_sched.h
index 8034bf5febbe..77806ef1cb70 100644
--- a/include/net/sctp/stream_sched.h
+++ b/include/net/sctp/stream_sched.h
@@ -52,10 +52,10 @@ void sctp_sched_dequeue_done(struct sctp_outq *q, struct sctp_chunk *ch);
 
 void sctp_sched_dequeue_common(struct sctp_outq *q, struct sctp_chunk *ch);
 int sctp_sched_init_sid(struct sctp_stream *stream, __u16 sid, gfp_t gfp);
-struct sctp_sched_ops *sctp_sched_ops_from_stream(struct sctp_stream *stream);
+const struct sctp_sched_ops *sctp_sched_ops_from_stream(struct sctp_stream *stream);
 
 void sctp_sched_ops_register(enum sctp_sched_type sched,
-			     struct sctp_sched_ops *sched_ops);
+			     const struct sctp_sched_ops *sched_ops);
 void sctp_sched_ops_prio_init(void);
 void sctp_sched_ops_rr_init(void);
 void sctp_sched_ops_fc_init(void);
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 2ae390219efd..57cd5746bd0d 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1076,7 +1076,7 @@ struct sctp_outq {
 	struct list_head out_chunk_list;
 
 	/* Stream scheduler being used */
-	struct sctp_sched_ops *sched;
+	const struct sctp_sched_ops *sched;
 
 	unsigned int out_qlen;	/* Total length of queued data chunks. */
 
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index f205556c5b24..0615e4426341 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -54,7 +54,7 @@ static void sctp_stream_shrink_out(struct sctp_stream *stream, __u16 outcnt)
 
 static void sctp_stream_free_ext(struct sctp_stream *stream, __u16 sid)
 {
-	struct sctp_sched_ops *sched;
+	const struct sctp_sched_ops *sched;
 
 	if (!SCTP_SO(stream, sid)->ext)
 		return;
@@ -130,7 +130,7 @@ static int sctp_stream_alloc_in(struct sctp_stream *stream, __u16 incnt,
 int sctp_stream_init(struct sctp_stream *stream, __u16 outcnt, __u16 incnt,
 		     gfp_t gfp)
 {
-	struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
+	const struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
 	int i, ret = 0;
 
 	gfp |= __GFP_NOWARN;
@@ -182,7 +182,7 @@ int sctp_stream_init_ext(struct sctp_stream *stream, __u16 sid)
 
 void sctp_stream_free(struct sctp_stream *stream)
 {
-	struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
+	const struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
 	int i;
 
 	sched->unsched_all(stream);
@@ -207,7 +207,7 @@ void sctp_stream_clear(struct sctp_stream *stream)
 
 void sctp_stream_update(struct sctp_stream *stream, struct sctp_stream *new)
 {
-	struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
+	const struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
 
 	sched->unsched_all(stream);
 	sctp_stream_outq_migrate(stream, new, new->outcnt);
diff --git a/net/sctp/stream_sched.c b/net/sctp/stream_sched.c
index 54afbe4fb087..50f8b5240359 100644
--- a/net/sctp/stream_sched.c
+++ b/net/sctp/stream_sched.c
@@ -91,7 +91,7 @@ static void sctp_sched_fcfs_unsched_all(struct sctp_stream *stream)
 {
 }
 
-static struct sctp_sched_ops sctp_sched_fcfs = {
+static const struct sctp_sched_ops sctp_sched_fcfs = {
 	.set = sctp_sched_fcfs_set,
 	.get = sctp_sched_fcfs_get,
 	.init = sctp_sched_fcfs_init,
@@ -111,10 +111,10 @@ static void sctp_sched_ops_fcfs_init(void)
 
 /* API to other parts of the stack */
 
-static struct sctp_sched_ops *sctp_sched_ops[SCTP_SS_MAX + 1];
+static const struct sctp_sched_ops *sctp_sched_ops[SCTP_SS_MAX + 1];
 
 void sctp_sched_ops_register(enum sctp_sched_type sched,
-			     struct sctp_sched_ops *sched_ops)
+			     const struct sctp_sched_ops *sched_ops)
 {
 	sctp_sched_ops[sched] = sched_ops;
 }
@@ -130,7 +130,7 @@ void sctp_sched_ops_init(void)
 
 static void sctp_sched_free_sched(struct sctp_stream *stream)
 {
-	struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
+	const struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
 	struct sctp_stream_out_ext *soute;
 	int i;
 
@@ -148,9 +148,9 @@ static void sctp_sched_free_sched(struct sctp_stream *stream)
 int sctp_sched_set_sched(struct sctp_association *asoc,
 			 enum sctp_sched_type sched)
 {
-	struct sctp_sched_ops *old = asoc->outqueue.sched;
+	const struct sctp_sched_ops *old = asoc->outqueue.sched;
 	struct sctp_datamsg *msg = NULL;
-	struct sctp_sched_ops *n;
+	const struct sctp_sched_ops *n;
 	struct sctp_chunk *ch;
 	int i, ret = 0;
 
@@ -263,14 +263,14 @@ void sctp_sched_dequeue_common(struct sctp_outq *q, struct sctp_chunk *ch)
 
 int sctp_sched_init_sid(struct sctp_stream *stream, __u16 sid, gfp_t gfp)
 {
-	struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
+	const struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
 	struct sctp_stream_out_ext *ext = SCTP_SO(stream, sid)->ext;
 
 	INIT_LIST_HEAD(&ext->outq);
 	return sched->init_sid(stream, sid, gfp);
 }
 
-struct sctp_sched_ops *sctp_sched_ops_from_stream(struct sctp_stream *stream)
+const struct sctp_sched_ops *sctp_sched_ops_from_stream(struct sctp_stream *stream)
 {
 	struct sctp_association *asoc;
 
diff --git a/net/sctp/stream_sched_fc.c b/net/sctp/stream_sched_fc.c
index 4bd18a497a6d..776c6de46c22 100644
--- a/net/sctp/stream_sched_fc.c
+++ b/net/sctp/stream_sched_fc.c
@@ -188,7 +188,7 @@ static void sctp_sched_fc_unsched_all(struct sctp_stream *stream)
 		list_del_init(&soute->fc_list);
 }
 
-static struct sctp_sched_ops sctp_sched_fc = {
+static const struct sctp_sched_ops sctp_sched_fc = {
 	.set = sctp_sched_fc_set,
 	.get = sctp_sched_fc_get,
 	.init = sctp_sched_fc_init,
@@ -206,7 +206,7 @@ void sctp_sched_ops_fc_init(void)
 	sctp_sched_ops_register(SCTP_SS_FC, &sctp_sched_fc);
 }
 
-static struct sctp_sched_ops sctp_sched_wfq = {
+static const struct sctp_sched_ops sctp_sched_wfq = {
 	.set = sctp_sched_wfq_set,
 	.get = sctp_sched_wfq_get,
 	.init = sctp_sched_fc_init,
diff --git a/net/sctp/stream_sched_prio.c b/net/sctp/stream_sched_prio.c
index 4d4d9da331f4..fb6c55e5615d 100644
--- a/net/sctp/stream_sched_prio.c
+++ b/net/sctp/stream_sched_prio.c
@@ -300,7 +300,7 @@ static void sctp_sched_prio_unsched_all(struct sctp_stream *stream)
 			sctp_sched_prio_unsched(soute);
 }
 
-static struct sctp_sched_ops sctp_sched_prio = {
+static const struct sctp_sched_ops sctp_sched_prio = {
 	.set = sctp_sched_prio_set,
 	.get = sctp_sched_prio_get,
 	.init = sctp_sched_prio_init,
diff --git a/net/sctp/stream_sched_rr.c b/net/sctp/stream_sched_rr.c
index 1f235e7f643a..9157b653f196 100644
--- a/net/sctp/stream_sched_rr.c
+++ b/net/sctp/stream_sched_rr.c
@@ -171,7 +171,7 @@ static void sctp_sched_rr_unsched_all(struct sctp_stream *stream)
 		sctp_sched_rr_unsched(stream, soute);
 }
 
-static struct sctp_sched_ops sctp_sched_rr = {
+static const struct sctp_sched_ops sctp_sched_rr = {
 	.set = sctp_sched_rr_set,
 	.get = sctp_sched_rr_get,
 	.init = sctp_sched_rr_init,
-- 
2.51.0


