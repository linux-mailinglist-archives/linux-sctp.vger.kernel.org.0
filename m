Return-Path: <linux-sctp+bounces-13-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF8C84B142
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Feb 2024 10:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDAE2876EF
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Feb 2024 09:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4712D142;
	Tue,  6 Feb 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aOURwMCG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CE76023;
	Tue,  6 Feb 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211717; cv=none; b=A+SB4WHHcbeQ0SM0czUZaz416FFLyjsQHt2zxq8wqbxZzvOdDYkAlrMyCgMOFLjL2DovwEuu2QrbXr8k3nZss9EuedHl0OFcP/LkyAQFebOoVxq6eJY6RbSKCLg1CZjkVs3ioPYyQcmplu9IljzEJTxzmMyCtA48XLDX+4416nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211717; c=relaxed/simple;
	bh=eVUNdh6ffQILpKaUYWu6y2RSjVz8Un3wCgU4UaT7uNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqv8Rkwb78w2f9Jrppym4e5gZjGkscwKCc2OSwQ5WB3lt3IQeLwN1yfuOR/U/V/ipHPiJTSsy+Y+MIjXrRRn8Ta4UYLrWN5slLBKTwGYT5Sb15RYk3LDmgaixj/96/V+w71irjpvrVINHMEslLzXLidMYHABUma82qwY8vD9fmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aOURwMCG; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1d22:0:640:a775:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 0EF2C60AF8;
	Tue,  6 Feb 2024 12:28:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PScse5A1Ua60-zFmiTOwK;
	Tue, 06 Feb 2024 12:28:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1707211705; bh=OJBlv1YEh0pJ7hkxdGwCReOEKKH4YhVi+aPM2l9cEjA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=aOURwMCGU9Q7kSFahbsQj/SBDpQNv0UJ30bEIpLZdAbr1C/twXWwgh1gdllwGyTpR
	 npD0hZ98DzhYWCQpVxUreQpB9bULznHuT8qgR0IFqenjLgOpwCE+JNvWibNTx4rhai
	 uFi9vhsyMPzcrtbSpEigscdeHF3pKTDAJp23o+I0=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Subject: [PATCH] net: sctp: fix skb leak in sctp_inq_free()
Date: Tue,  6 Feb 2024 12:26:17 +0300
Message-ID: <20240206092619.74018-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADvbK_fn+gH=p-OhVXzZtGd+nK6QUKu+F4QLBpcx0c3Pig1oLg@mail.gmail.com>
References: <CADvbK_fn+gH=p-OhVXzZtGd+nK6QUKu+F4QLBpcx0c3Pig1oLg@mail.gmail.com>
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
leak), ensure that 'chunk->skb' is set to 'chunk->head_skb'
(i.e. fraglist head) before calling 'sctp_chunk_free()'.

Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=0d8351bbe54fd04a492c2daab0164138db008042
Fixes: 90017accff61 ("sctp: Add GSO support")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/sctp/inqueue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7182c5a450fb..dda5e1ad9cac 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -52,8 +52,11 @@ void sctp_inq_free(struct sctp_inq *queue)
 	/* If there is a packet which is currently being worked on,
 	 * free it as well.
 	 */
-	if (queue->in_progress) {
-		sctp_chunk_free(queue->in_progress);
+	chunk = queue->in_progress;
+	if (chunk) {
+		if (chunk->head_skb)
+			chunk->skb = chunk->head_skb;
+		sctp_chunk_free(chunk);
 		queue->in_progress = NULL;
 	}
 }
-- 
2.43.0


