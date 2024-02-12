Return-Path: <linux-sctp+bounces-25-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32455850EDE
	for <lists+linux-sctp@lfdr.de>; Mon, 12 Feb 2024 09:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C422D1F25352
	for <lists+linux-sctp@lfdr.de>; Mon, 12 Feb 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8BD516;
	Mon, 12 Feb 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Ird1MYxG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC40FBF2;
	Mon, 12 Feb 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726476; cv=none; b=u0o+rg1nP9UwAm9QBY7NB+S+pmZnBaUzy2fKuWhp5+bp3d6/FH5pXsT+PC71w76ZwJJ0uHiX9sAeDsbJmfDEHT8ienMn7D6SKAFW85/BueJCGufbJLu39+4fwK8QQn/X9/VOx8jQtLWu3X5JbRxJXYXqzZWClWYQ6k5edZqbXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726476; c=relaxed/simple;
	bh=k4703wUin1PPttsgsQ2jG9uAV9eE4pMC0XCyK22LGbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SifQB7W4nNpDjb0oMZSHg+DfNuGZ+UzuPtPEE709sID74V8Gtp/zDC9+CM/X4OliTIR8gsOWNEEozLwkNtIlD6fCT82fLJKMInAlSazhXaZ6ZnhxCTvZOxv27xFXzry6byybLe8BZO4gvwh08Qnn21huuFQ4AEdKEZfVyV8PVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Ird1MYxG; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id C99566372C;
	Mon, 12 Feb 2024 11:22:26 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5202:0:640:875:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 7116C6090D;
	Mon, 12 Feb 2024 11:22:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HMhq53ISpSw0-NHMO7lGI;
	Mon, 12 Feb 2024 11:22:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1707726137; bh=0gCklyACyZxJmfC/AYBkjy6kkNqvIen51RuMEruSzXU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Ird1MYxGFVeIeRvSO9cp2jqm1oN0zgRikwzlKBkBkpoJsGOkx69EiPTito+e44HjN
	 SNbfwcUC5xHyJxO0ClEbHFW1qV46bgEmmH1EeadiZ5ExOfA0pDlJYSEg/A5Yt9FvOf
	 1bzq84veTcb4wTeEF97i2+OmY9zrhbyJdsew6Lj8=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Subject: [PATCH] [v2] net: sctp: fix skb leak in sctp_inq_free()
Date: Mon, 12 Feb 2024 11:22:02 +0300
Message-ID: <20240212082202.17927-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209134703.63a9167b@kernel.org>
References: <20240209134703.63a9167b@kernel.org>
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
leak), introduce 'sctp_chunk_release()' helper to ensure that
'chunk->skb' is set to 'chunk->head_skb' (i.e. fraglist head)
before calling 'sctp_chunk_free()', and use the aforementioned
helper in 'sctp_inq_pop()' as well.

Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=0d8351bbe54fd04a492c2daab0164138db008042
Fixes: 90017accff61 ("sctp: Add GSO support")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: factor the fix out to helper function (Jakub Kicinski)
---
 net/sctp/inqueue.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7182c5a450fb..9ec172405ff4 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -38,6 +38,14 @@ void sctp_inq_init(struct sctp_inq *queue)
 	INIT_WORK(&queue->immediate, NULL);
 }
 
+/* Properly release the chunk which is being worked on. */
+static inline void sctp_chunk_release(struct sctp_chunk *chunk)
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
+		sctp_chunk_release(queue->in_progress);
 		queue->in_progress = NULL;
 	}
 }
@@ -130,9 +138,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				goto new_skb;
 			}
 
-			if (chunk->head_skb)
-				chunk->skb = chunk->head_skb;
-			sctp_chunk_free(chunk);
+			sctp_chunk_release(chunk);
 			chunk = queue->in_progress = NULL;
 		} else {
 			/* Nothing to do. Next chunk in the packet, please. */
-- 
2.43.0


