Return-Path: <linux-sctp+bounces-185-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FE94137A
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Jul 2024 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391031F245BE
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Jul 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1B21A01D2;
	Tue, 30 Jul 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TEJ95ez/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA619580A;
	Tue, 30 Jul 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347180; cv=none; b=s4KWFZlw41xerOEUA7QR2yuE8xpqqztKnAxeiVyhs9UZweskpZD/gAJBjJXDqG//7SVYVXzlKyFAnZBagGeFgvmEnaKo8MhhMggW4bwLF0wFUw2WIubCF3sTSeJhdlXlQc4q9/OABBihbLkbmx4qedUtu8mlPZ7kkIs/MDotQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347180; c=relaxed/simple;
	bh=0twCM7R8EFnGwq6klPjKqYhXlDLq4rpn3rruylOGtyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBtUAxWKQaJx0Oqsag+WqU5SeAlTzQI1LAbPF/sldXN+8I4PgW4Ns+68utIiAxth9Zj6IN7TXsDV2soylBNLtHDWHcJZW3eOobAris+F54H16gLYwXX7aBs5c3bqh+qC+/3UVVWVIMwD1d8aEVW4QZGPKvK0iD9EreAHD+iVm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TEJ95ez/; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:89:0:640:35fc:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id 7507C6172A;
	Tue, 30 Jul 2024 16:46:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5kVgr1fRiW20-G9zNp8hQ;
	Tue, 30 Jul 2024 16:46:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722347166; bh=QPFQTMJkq2pUrbYvNInrEU8b4+IEhiOtEO50dORbNRw=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=TEJ95ez/+SeJ6AmZyBGLubN3t0SbVo2mNvk6aZNWGT+Kx/8Xx357lA5tfpPUFr04V
	 XrdwclhYT7Cp04isNoNcfU636iXjw/bTSx79l88y7v/8pr5Luud1sGHOsg8lykAfEg
	 5Vr2m0ssWDJcdUow3Pla7A+CKRbEGaI4Ii8XahO0=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kuni1840@gmail.com,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Tue, 30 Jul 2024 16:46:05 +0300
Message-ID: <20240730134605.297494-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729192601.97316-1-kuniyu@amazon.com>
References: <20240729192601.97316-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hm. Note both 'reuseport_add_sock()' and 'reuseport_detach_sock()' uses
global 'reuseport_lock' internally. So what about using read lock to protect
'sctp_for_each_entry()' loop and upgrade to write lock only if hash bucket
should be actually updated? E.g.:

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 17fcaa9b0df9..4fbff388b1b4 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -735,6 +735,7 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	struct sock *sk = ep->base.sk;
 	struct net *net = sock_net(sk);
 	struct sctp_hashbucket *head;
+	int err = 0;
 
 	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
 	head = &sctp_ep_hashtable[ep->hashent];
@@ -743,11 +744,14 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 		bool any = sctp_is_ep_boundall(sk);
 		struct sctp_endpoint *ep2;
 		struct list_head *list;
-		int cnt = 0, err = 1;
+		int cnt = 0;
+
+		err = 1;
 
 		list_for_each(list, &ep->base.bind_addr.address_list)
 			cnt++;
 
+		read_lock(&head->lock);
 		sctp_for_each_hentry(ep2, &head->chain) {
 			struct sock *sk2 = ep2->base.sk;
 
@@ -760,25 +764,30 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 						    sctp_sk(sk), cnt);
 			if (!err) {
 				err = reuseport_add_sock(sk, sk2, any);
-				if (err)
-					return err;
+				if (err) {
+					read_unlock(&head->lock);
+					goto out;
+				}
 				break;
 			} else if (err < 0) {
-				return err;
+				read_unlock(&head->lock);
+				goto out;
 			}
 		}
+		read_unlock(&head->lock);
 
 		if (err) {
 			err = reuseport_alloc(sk, any);
 			if (err)
-				return err;
+				goto out;
 		}
 	}
 
 	write_lock(&head->lock);
 	hlist_add_head(&ep->node, &head->chain);
 	write_unlock(&head->lock);
-	return 0;
+out:
+	return err;
 }
 
 /* Add an endpoint to the hash. Local BH-safe. */

Dmitry

