Return-Path: <linux-sctp+bounces-1215-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H9HARSBFmq7mwcAu9opvQ
	(envelope-from <linux-sctp+bounces-1215-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 07:28:52 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6C15DF713
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 07:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13B86302DE14
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673892C11F9;
	Wed, 27 May 2026 05:28:49 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A092260580;
	Wed, 27 May 2026 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859729; cv=none; b=GZJco0XZbYbIQ9WNivuZSAcb2CoRNUXsnoWKAdlCKRahYe+P71x81rEEdC6nUiDoPLpS+MDlbdWDCSDioX1DbySY3QvQX8I+DBqQY0z+Yomat0nlP6Y0UY4iagBuQi2TsA5m14C0WvMnYH2qIX0Y2mkmLeYhlII2IwgMwHh8Y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859729; c=relaxed/simple;
	bh=1Vm/oHLYdJCBJKp6w80vvBtR103wVB2NVH+QpJoI+IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM5EaYepxv33rguBKpuj8BuC2fJQgUpkug0zMVSQPhCPBTTAWLfdCvd+RUZmwavvKHFgt+sLa6yrSJjvhf3MRqbQXF07VInb3uS6e93QjcOvIKnWQDV5sZXUqC4Ed/eeJ3BBb9zXrJP4tziKFuQc1uv+MNrX6ek+zgX5ktOZizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnwLr_gBZqxlMzAA--.21498S3;
	Wed, 27 May 2026 13:28:34 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	xuyq21@lenovo.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] sctp: stream: rebind out_curr when updating streams
Date: Wed, 27 May 2026 13:28:26 +0800
Message-ID: <8049cf6a7d4e62a002397cf289c09ff373b19f7f.1779635498.git.xuyq21@lenovo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779635498.git.xuyq21@lenovo.com>
References: <cover.1779635498.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnwLr_gBZqxlMzAA--.21498S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try8uFy5JFWfurWDGr13twb_yoW8uw1xpa
	9a93yrta4xJF12gr4xCw1rKF15Kr4kAw47KF98Kw1DZr4DJFyFqF17tFZ7JrykGF40vrW2
	yrn0qwsI9w4UArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0ACWoVV86CkwAAsy
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-1215-lists,linux-sctp=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.779];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 3A6C15DF713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyq21@lenovo.com>

sctp_stream_update() replaces the outbound stream table while
out_curr may still point to the current stream selected for an
unfinished fragmented message.

Remember the current stream id before freeing the old table and
rebind out_curr after the new table is installed. If that stream
no longer exists, clear the cached pointer instead.

This keeps the scheduler cursor valid across stream table
replacement without losing the current stream when it still
survives the update.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sctp/stream.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index c2247793c88b..fcb6c688f61d 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -208,6 +208,16 @@ void sctp_stream_clear(struct sctp_stream *stream)
 void sctp_stream_update(struct sctp_stream *stream, struct sctp_stream *new)
 {
 	const struct sctp_sched_ops *sched = sctp_sched_ops_from_stream(stream);
+	__u16 sid = SCTP_MAX_STREAM;
+
+	/* Preserve the current stream if its sid survives the table swap. */
+	if (stream->out_curr) {
+		for (sid = 0; sid < stream->outcnt; sid++)
+			if (SCTP_SO(stream, sid) == stream->out_curr)
+				break;
+		if (sid == stream->outcnt)
+			sid = SCTP_MAX_STREAM;
+	}
 
 	sched->unsched_all(stream);
 	sctp_stream_outq_migrate(stream, new, new->outcnt);
@@ -217,6 +227,7 @@ void sctp_stream_update(struct sctp_stream *stream, struct sctp_stream *new)
 	stream->in  = new->in;
 	stream->outcnt = new->outcnt;
 	stream->incnt  = new->incnt;
+	stream->out_curr = sid < stream->outcnt ? SCTP_SO(stream, sid) : NULL;
 
 	sched->sched_all(stream);
 
-- 
2.54.0


