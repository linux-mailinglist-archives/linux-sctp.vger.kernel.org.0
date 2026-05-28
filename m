Return-Path: <linux-sctp+bounces-1220-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HDRBWkFGGo8aQgAu9opvQ
	(envelope-from <linux-sctp+bounces-1220-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 11:05:45 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0A65EF30B
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 11:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53E46301BB8D
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F0377559;
	Thu, 28 May 2026 08:59:07 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36F37E2F7;
	Thu, 28 May 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958747; cv=none; b=P8hZJKXIYVJXEMGaE/6R9/AGpD16oW2vSV0kjWUpHiTFVsBSHMMdWPeNmFeoqewIFwiGKguzDsgGxBC3E95OmOT6NtEvdXW3bU+bRE7JQt7RGFwIbEEfRsXvl3FAf0pD5yYMjungplCN9CyyK9V/cwZ/FXaWaG0fdiPgAo3krFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958747; c=relaxed/simple;
	bh=s/P5s0Vhyy0BHBsMyMc4XZVfOxWlxmPxjQQFWnMA+do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFrynfgs4FJbYvRb5qeqhgXDOE0b5lsGnoeH3QYwmcmL1dsshINwobvYfdsHFGCvuDLvCFOiQslj8yEOzTCEYFFCqTCszExa0c9o63zDrOLlKuPwIT67tFlvboUCdSP/7cTEsselJgUxGLMfb25/sbREo649+7ashNOwdNMbg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnv7nOAxhqMDw4AA--.22942S3;
	Thu, 28 May 2026 16:58:57 +0800 (CST)
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
Subject: [PATCH net 1/1] sctp: stream: clear current stream on stream teardown
Date: Thu, 28 May 2026 16:58:49 +0800
Message-ID: <ad9d7027579442c6c9498e7af84f836747a7620e.1779644468.git.xuyq21@lenovo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779644468.git.xuyq21@lenovo.com>
References: <cover.1779644468.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnv7nOAxhqMDw4AA--.22942S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8AFyrur4rKrW3JryxZrb_yoW8Xr1rpF
	ZxurWrtr97JF18Grn7Cw1Fqr4fKan7Gw47KFyYkF4DZr4DJF1FqFyvgrWkJr1kCr4F9FWY
	vrn0vw12vw4UCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQABCWoX+s4AogAAsi
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-1220-lists,linux-sctp=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.922];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lenovo.com:mid,lenovo.com:email]
X-Rspamd-Queue-Id: AC0A65EF30B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyq21@lenovo.com>

out_curr caches the outbound stream currently being dequeued. When the
stream table is replaced, the old stream entries and their ext state
are freed, so keeping out_curr leaves scheduler state pointing at
released stream storage.

Clear out_curr in sctp_stream_free(), where the backing stream entries
are torn down. This keeps the cached scheduler state aligned with the
lifetime of the stream table for stream updates and any other full
stream teardown paths.

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
 net/sctp/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index c2247793c88b..207e0a77f9af 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -186,6 +186,7 @@ void sctp_stream_free(struct sctp_stream *stream)
 	int i;
 
 	sched->unsched_all(stream);
+	stream->out_curr = NULL;
 	for (i = 0; i < stream->outcnt; i++)
 		sctp_stream_free_ext(stream, i);
 	genradix_free(&stream->out);
-- 
2.54.0


