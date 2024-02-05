Return-Path: <linux-sctp+bounces-10-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D976884A048
	for <lists+linux-sctp@lfdr.de>; Mon,  5 Feb 2024 18:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CCEB24DD7
	for <lists+linux-sctp@lfdr.de>; Mon,  5 Feb 2024 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E76241748;
	Mon,  5 Feb 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="iT7XE1Fe"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward201c.mail.yandex.net (forward201c.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF808405DE;
	Mon,  5 Feb 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153042; cv=none; b=GVaOO8xS6ShN2X44Wxny8PnqjpjzbGM2YZzaCQJFRLGnzKm78us0E5ZLWKIKb0wDc3kBAAIFJEYA77cZe7wWdUSfr7HPMDWovg7E01T40/1fJo1iOAN1Rww5gROqqaSon7BNzl3Fk3MfkOLB6MZ6yeLPycdLPvsMjS+RPcgPgRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153042; c=relaxed/simple;
	bh=d3WiyIMLPoyJatC7Ktmgik8BgwKmCKaRmxo5YbiZE0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0HccXd5/im4x6nRVPboN+i4nVc39p0RjCBPXAWcKahXgTuU4lQ6QxfntV1oGmJyzpaJYGD2aAjrsK8fddW07UVfj+Xgea4VFUzX+DYkfPeFuorSlmU089DGbNOS9b1tK+hFa/tC2hG6BP/O7lx/WyFIpddYw9uCLOKL0iH0vFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=iT7XE1Fe; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward201c.mail.yandex.net (Yandex) with ESMTPS id CFE9063B00;
	Mon,  5 Feb 2024 20:02:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1d22:0:640:a775:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id C9C2B608EF;
	Mon,  5 Feb 2024 20:02:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id X2j70O6o84Y0-fY4j2mhL;
	Mon, 05 Feb 2024 20:02:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1707152554; bh=wq9QchnGYZJEUeEA04F0SNCmLnAswhAIDhJYm0scVts=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=iT7XE1Feaqwe89scLAVPaKk8H13brYZ7yP3igCkyisjkQeH03szWQA6yy1FQAIvAM
	 5GO3jARhFXE/IoCCapqL0mRnv0QWqPSqA/B0DGL/TRZw1P10r5WnEQcCbW0HhGoYK4
	 I37oyKmvg++Xu27/Hr2mWMuc/nEKmIldiA0pMoOw=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Subject: [PATCH] net: sctp: fix memory leak in sctp_chunk_destroy()
Date: Mon,  5 Feb 2024 20:01:11 +0300
Message-ID: <20240205170117.250866-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of GSO, per-chunk 'skb' pointer may point to an entry from
fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
random fraglist entry (and so undefined behavior and/or memory
leak), consume 'head_skb' (i.e. beginning of a fraglist) instead.

Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=0d8351bbe54fd04a492c2daab0164138db008042
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/sctp/sm_make_chunk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index f80208edd6a5..30fe34743009 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1500,7 +1500,10 @@ static void sctp_chunk_destroy(struct sctp_chunk *chunk)
 	BUG_ON(!list_empty(&chunk->list));
 	list_del_init(&chunk->transmitted_list);
 
-	consume_skb(chunk->skb);
+	/* In case of GSO, 'skb' may be a pointer to fraglist entry.
+	 * Consume the read head if so.
+	 */
+	consume_skb(chunk->head_skb ? chunk->head_skb : chunk->skb);
 	consume_skb(chunk->auth_chunk);
 
 	SCTP_DBG_OBJCNT_DEC(chunk);
-- 
2.43.0


