Return-Path: <linux-sctp+bounces-187-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D3942791
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jul 2024 09:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837E01C213F0
	for <lists+linux-sctp@lfdr.de>; Wed, 31 Jul 2024 07:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D21A4F12;
	Wed, 31 Jul 2024 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="IWt4rKN0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2316A39E;
	Wed, 31 Jul 2024 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409895; cv=none; b=ZA0J828uvYg0ib6LVlNbnP4McLseUFknyd9PFPpik11EeGRIYzrZPvHOIrCQBf5zj8TawYwkoPJvkNgEd1zHidS5Z6V+jLkOGusLrHHvLiKOX8Stv1s+QUYv8jkxL9dISFK/pP3Ee+gdcqvZ3Wq4bnbRkFWIxNfyquW67DW4H9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409895; c=relaxed/simple;
	bh=mQPzskGBo/MvH3EZFs6LsZHtVeNNKE66UM9PwvB6dLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgif6CPoFFb9dWCLFTHM60l4j+gOYhLCp5/u+z865WHPC/5CgJ4qlFABUDlPBNX82miTCi6+iExI0IIt25nSRclcwpzDNuDWMKL5IpbOId/JjkNjw+UI7uiN/DpHmLrxUaodBZQPfqiBgIkMLERlTvqGZtC6ODKuhKRqjDB1qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=IWt4rKN0; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 0001166D36;
	Wed, 31 Jul 2024 10:05:47 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a92:0:640:6d97:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 1DFBE47188;
	Wed, 31 Jul 2024 10:05:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id b5Q9apL8Pa60-QASJPI5t;
	Wed, 31 Jul 2024 10:05:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722409539; bh=QA+F9WxQGYQxRp9VbhvN0DdD46GfU36qyFfi1epjGOU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=IWt4rKN0CTnjw7EX92nn3UdovTNy+U6doGpy3/+uX+8CAa2JBLxvUzqSkBmt4fEU2
	 gcnf0QqHv4IEkV/LjV++M82fABU+DNruxkJmnbAXrcQtH4rerwvTh9VRnAzglUjGxm
	 zwmujxefN7IOq66/7ldAtpyl3xUGAUxtvft9ofGg=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: kuniyu@amazon.com
Cc: davem@davemloft.net,
	dmantipov@yandex.ru,
	edumazet@google.com,
	kuba@kernel.org,
	kuni1840@gmail.com,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Subject: Re: Re: [PATCH v1 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Wed, 31 Jul 2024 10:05:37 +0300
Message-ID: <20240731070537.303533-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730170646.62951-1-kuniyu@amazon.com>
References: <20240730170646.62951-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What happens if two sockets matching each other reach here ?

Not sure. In general, an attempt to use rather external thing (struct
sctp_hashbucket) to implement extra synchronization for reuse innards
looks somewhat weird.

So let's look at reuseport_add_sock() again. Note extra comments:

int reuseport_add_sock(struct sock *sk, struct sock *sk2, bool bind_inany)
{
	struct sock_reuseport *old_reuse, *reuse;

	/* RCU access _outside_ of reuseport_lock'ed section */
	if (!rcu_access_pointer(sk2->sk_reuseport_cb)) {
		int err = reuseport_alloc(sk2, bind_inany);

		if (err)
			return err;
	}

	spin_lock_bh(&reuseport_lock);
	reuse = rcu_dereference_protected(sk2->sk_reuseport_cb,
					  lockdep_is_held(&reuseport_lock));
	old_reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
					      lockdep_is_held(&reuseport_lock));
	if (old_reuse && old_reuse->num_closed_socks) {
		/* sk was shutdown()ed before */
		int err = reuseport_resurrect(sk, old_reuse, reuse, reuse->bind_inany);

		spin_unlock_bh(&reuseport_lock);
		return err;
	}

	if (old_reuse && old_reuse->num_socks != 1) {
		spin_unlock_bh(&reuseport_lock);
		return -EBUSY;
	}

	if (reuse->num_socks + reuse->num_closed_socks == reuse->max_socks) {
		reuse = reuseport_grow(reuse);
		if (!reuse) {
			spin_unlock_bh(&reuseport_lock);
			return -ENOMEM;
		}
	}

	__reuseport_add_sock(sk, reuse);
	/* RCU access _inside_ of reuseport_lock'ed section */
	rcu_assign_pointer(sk->sk_reuseport_cb, reuse);

	spin_unlock_bh(&reuseport_lock);

	if (old_reuse)
		call_rcu(&old_reuse->rcu, reuseport_free_rcu);
	return 0;
}

Why this is so? I've tried to extend reuseport_lock'ed section to include the
first rcu_access_pointer() in subject as well, e.g.:

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 5a165286e4d8..39a353ab8ff8 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -186,16 +186,11 @@ static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
 	return reuse;
 }
 
-int reuseport_alloc(struct sock *sk, bool bind_inany)
+static int reuseport_alloc_unlocked(struct sock *sk, bool bind_inany)
 {
 	struct sock_reuseport *reuse;
 	int id, ret = 0;
 
-	/* bh lock used since this function call may precede hlist lock in
-	 * soft irq of receive path or setsockopt from process context
-	 */
-	spin_lock_bh(&reuseport_lock);
-
 	/* Allocation attempts can occur concurrently via the setsockopt path
 	 * and the bind/hash path.  Nothing to do when we lose the race.
 	 */
@@ -236,8 +231,19 @@ int reuseport_alloc(struct sock *sk, bool bind_inany)
 	reuse->num_socks = 1;
 	reuseport_get_incoming_cpu(sk, reuse);
 	rcu_assign_pointer(sk->sk_reuseport_cb, reuse);
-
 out:
+	return ret;
+}
+
+int reuseport_alloc(struct sock *sk, bool bind_inany)
+{
+	int ret;
+
+	/* bh lock used since this function call may precede hlist lock in
+	 * soft irq of receive path or setsockopt from process context
+	 */
+	spin_lock_bh(&reuseport_lock);
+	ret = reuseport_alloc_unlocked(sk, bind_inany);
 	spin_unlock_bh(&reuseport_lock);
 
 	return ret;
@@ -322,14 +328,17 @@ int reuseport_add_sock(struct sock *sk, struct sock *sk2, bool bind_inany)
 {
 	struct sock_reuseport *old_reuse, *reuse;
 
+	spin_lock_bh(&reuseport_lock);
+
 	if (!rcu_access_pointer(sk2->sk_reuseport_cb)) {
-		int err = reuseport_alloc(sk2, bind_inany);
+		int err = reuseport_alloc_unlocked(sk2, bind_inany);
 
-		if (err)
+		if (err) {
+			spin_unlock_bh(&reuseport_lock);
 			return err;
+		}
 	}
 
-	spin_lock_bh(&reuseport_lock);
 	reuse = rcu_dereference_protected(sk2->sk_reuseport_cb,
 					  lockdep_is_held(&reuseport_lock));
 	old_reuse = rcu_dereference_protected(sk->sk_reuseport_cb,

and this seems fixes the original crash as well.

Dmitry

