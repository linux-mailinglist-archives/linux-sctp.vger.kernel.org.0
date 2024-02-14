Return-Path: <linux-sctp+bounces-28-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5918543FE
	for <lists+linux-sctp@lfdr.de>; Wed, 14 Feb 2024 09:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE64D283CCA
	for <lists+linux-sctp@lfdr.de>; Wed, 14 Feb 2024 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADAE11CBB;
	Wed, 14 Feb 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Qg2BY/qy"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1011CB3;
	Wed, 14 Feb 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899011; cv=none; b=F2PPw/z2Ks5GLx7mK+HJenZR9/pTSYbpTHcHw306WYLWKcWfP/fjK/vwrXqJWZFTLMTsNseeoB0GTqkljyNCoVpRe9EwedEkeeGHWPzfPhcDCbGMUlj9KyStdx9taltA6y56GaHIcEUM+djp+uzLiOE5uur4o99gISvNzQTj58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899011; c=relaxed/simple;
	bh=vOup1lyDgT26CO7ZP799HSFYXN/BdJFV4caQI77Tq9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+xpVrCkQURtGfl3EyA0eb5Rw6ZJ1+w/3cbbpS2vVIxb88knTV9MQDLlY6UcXPqQW/+afGSBQYk43GspsWAO0O/K+N8d7WK1dMEItppOiLCZBxVgmF9tl6eBumwuK+8VGKFtgW9nfN8su42EhXgDEVITPbcUpfFtU8J2jlxNBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Qg2BY/qy; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b587:0:640:8986:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 891F146DA9;
	Wed, 14 Feb 2024 11:23:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HNjbWlMl4iE0-TWaSbnY9;
	Wed, 14 Feb 2024 11:23:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1707898997; bh=o0U2gKeVA7auzNi460xU9iMkCx6X7DW5O9hy4tb94fg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Qg2BY/qyTjpVTewEgNi70lxD4aamB9RNkcmDjyoZWEERzd+nDiMADA75XCoIfFBDT
	 cc8EJFTAAiW+vvZPnDoJhCYjZnjePMF185IosLF+Ke09O9LDXvkU9EAMDn5loHtpHv
	 xIIZ7At0yWDtuV4z4LdRx0lMWqnlc4UT4D2sctcE=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Xin Long <lucien.xin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Subject: [PATCH] [v3] net: sctp: fix skb leak in sctp_inq_free()
Date: Wed, 14 Feb 2024 11:22:24 +0300
Message-ID: <20240214082224.10168-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of GSO, 'chunk->skb' pointer may point to an entry from
fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
random fraglist entry (and so undefined behavior and/or memory
leak), introduce 'sctp_inq_chunk_free()' helper to ensure that
'chunk->skb' is set to 'chunk->head_skb' (i.e. fraglist head)
before calling 'sctp_chunk_free()', and use the aforementioned
helper in 'sctp_inq_pop()' as well.

Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=0d8351bbe54fd04a492c2daab0164138db008042
Fixes: 90017accff61 ("sctp: Add GSO support")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: https://lore.kernel.org/netdev/CADvbK_cjg7kd7uFWxPBpwMAxwsuCki791zQ7D01y+vk0R5wTSQ@mail.gmail.com
    - rename helper to 'sctp_inq_chunk_free()' (Xin Long)
v2: https://lore.kernel.org/netdev/20240209134703.63a9167b@kernel.org
    - factor the fix out to helper function (Jakub Kicinski)
---
 net/sctp/inqueue.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7182c5a450fb..5c1652181805 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -38,6 +38,14 @@ void sctp_inq_init(struct sctp_inq *queue)
 	INIT_WORK(&queue->immediate, NULL);
 }
 
+/* Properly release the chunk which is being worked on. */
+static inline void sctp_inq_chunk_free(struct sctp_chunk *chunk)
+{
+	if (chunk->head_skb)
+		chunk->skb = chunk->head_skb;
+	sctp_chunk_free(chunk);
+}
+
 /* Release the memory associated with an SCTP inqueue.  */
 void sctp_inq_free(struct sctp_inq *queue)
 {
@@ -53,7 +61,7 @@ void sctp_inq_free(struct sctp_inq *queue)
 	 * free it as well.
 	 */
 	if (queue->in_progress) {
-		sctp_chunk_free(queue->in_progress);
+		sctp_inq_chunk_free(queue->in_progress);
 		queue->in_progress = NULL;
 	}
 }
@@ -130,9 +138,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				goto new_skb;
 			}
 
-			if (chunk->head_skb)
-				chunk->skb = chunk->head_skb;
-			sctp_chunk_free(chunk);
+			sctp_inq_chunk_free(chunk);
 			chunk = queue->in_progress = NULL;
 		} else {
 			/* Nothing to do. Next chunk in the packet, please. */
-- 
2.43.0


