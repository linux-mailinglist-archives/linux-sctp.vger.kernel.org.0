Return-Path: <linux-sctp+bounces-660-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06EBFE467
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921A31A071B0
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B5280327;
	Wed, 22 Oct 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hhk3RQPo"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206E30275C
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167852; cv=none; b=HCjCOaPhfWmlj3MeIPyLDXgHu54YZFdtKdvLl3SUUXcP7qI3bvJ8qKD38uGk4sV15S2PYoWZedz41HQy6Pjs6ZjCrv3u1CmK2XIDBysm1WipMy2F5jXPgDPWKErkGexNXfrYuPTcSUA+zldHmvbbq/iBnAcf9RktK9+UG6CElRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167852; c=relaxed/simple;
	bh=LWnpLIWF97+SS4VAjlmaPpO/VHTVwNpw+u1QfDH7Hzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dZ9JF+XFxYRnZnGyGbiNzHEpr5e9nqLRUxLEWuqdx7OfsdA3rQqVFJf0Ny341euMUI2Rl+Ipk+On3hOxo99XUxsWyroYpYvJp+j01uuBIkK01Uf1MzAdiXrNhvvBPZt2qGhbeyiL9oAx9t0NX4IhYqEW4M0AVQzbJT8QKK3HtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hhk3RQPo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2697410e7f9so878555ad.2
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167850; x=1761772650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuxXw67SFnQh5qIqjTagWP/ARX5V73KITF1xMCPSBV8=;
        b=Hhk3RQPoPQSUUQ4NrQM9wnwvAI2/uvqfkS4rHfYKCD1/Wuw80mZ+NX/nW1aA4BgmOa
         bIXKVZLcGmQuv9hJe8no/48GdiaTHD23xaSq2oXxV+uRbNNoGC2NWUZxreglxeY7xWxR
         PbD3L/p1OH0xDJ3M2QcE79loisC1HzZt4/DBLED0KWxscdHA+lt3HYTO1EbZ6CTf1q7T
         agM7fvntydZ3lzSQfVg/+oZ1x+Munrhgiydx8Oi2td9l6VIvu7CfCjst/VwGy0U1tXhF
         hRZICHP1teeEKLj4tuzVBWs1/fHvIztLvjmveabH0dkp0v5su3vszaLL2lHhGLmr+Ewm
         fsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167850; x=1761772650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuxXw67SFnQh5qIqjTagWP/ARX5V73KITF1xMCPSBV8=;
        b=FtJJtosoctPTg+zbUjkWewD3slceT9OBnabHEVR7aPIfUj5hC9blIYPwDJw3amwdHJ
         U3OZOP6z9nRyETbzFsOuXHwizOCZc5kc2EfDergJWxZdMGH7zQJ023Km8B2+kPC6ljnU
         GM+LiSmeRrkXiEBEzYT4DbTBZf+NzX68ktJq4UMPO1TsyI8IZVq/2TWw3oVwetC9tlLZ
         OIKffJy57i5QUcMH8Akh90TVE7geaqMtr0YZcjpoawmKyDsRlT2BjWuBkwRmQHtIC3la
         njpL8WeFJ+6iDvKmxLKzdIjEvKBEkWfLOfMEoM61JP0hqW3uBfhgDW+JwK4MEy3xh4uW
         tvyg==
X-Forwarded-Encrypted: i=1; AJvYcCXUSm2QRLldPe6BUfPf1Beoh+EzRtcdnnAi6uOzxEtdhiX85PbIimZTRn2W2cF0SEkQGtBIUeYfbql2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/zqamBMe/8WeJZ5jmXHr7C9tHP7HB73almBBQnfA0jQCIvAi
	lzLqH/zGLOSLIg6L8Svz9yqY4hwv7jW+Q15IitDBrODUYPQ7vtVhgp9i0LO6pLpIQG1aPiafoBd
	/o4LdvQ==
X-Google-Smtp-Source: AGHT+IEBZL0h7u5BjR6GvnkEG0MslX4HR4Xwf5QmPRdACaNqJEmG7G0Gc/7jup5HLX4WS+m6fWdZrrGLfFo=
X-Received: from pjbsq12.prod.google.com ([2002:a17:90b:530c:b0:33d:4297:184e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4b:b0:335:28ee:eebe
 with SMTP id 98e67ed59e1d1-33bcf908bc8mr27006300a91.30.1761167850266; Wed, 22
 Oct 2025 14:17:30 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:04 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/8] net: Add sk_clone().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_accept() will use sk_clone_lock(), but it will be called
with the parent socket locked, and sctp_migrate() acquires the
child lock later.

Let's add no lock version of sk_clone_lock().

Note that lockdep complains if we simply use bh_lock_sock_nested().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h |  7 ++++++-
 net/core/sock.c    | 21 ++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 01ce231603db..c7e58b8e8a90 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 void sk_free(struct sock *sk);
 void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
-struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
+struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool lock);
+
+static inline struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
+{
+	return sk_clone(sk, priority, true);
+}
 
 struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int force,
 			     gfp_t priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index a99132cc0965..0a3021f8f8c1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
 }
 
 /**
- *	sk_clone_lock - clone a socket, and lock its clone
- *	@sk: the socket to clone
- *	@priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
+ * sk_clone - clone a socket
+ * @sk: the socket to clone
+ * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
+ * @lock: if true, lock the cloned sk
  *
- *	Caller must unlock socket even in error path (bh_unlock_sock(newsk))
+ * If @lock is true, the clone is locked by bh_lock_sock(), and
+ * caller must unlock socket even in error path by bh_unlock_sock().
  */
-struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
+struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
+		      bool lock)
 {
 	struct proto *prot = READ_ONCE(sk->sk_prot);
 	struct sk_filter *filter;
@@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		__netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker,
 				      false, priority);
 	}
+
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
-	bh_lock_sock(newsk);
+
+	if (lock)
+		bh_lock_sock(newsk);
+
 	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
 	newsk->sk_backlog.len = 0;
 
@@ -2595,7 +2602,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	newsk = NULL;
 	goto out;
 }
-EXPORT_SYMBOL_GPL(sk_clone_lock);
+EXPORT_SYMBOL_GPL(sk_clone);
 
 static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device *dev)
 {
-- 
2.51.1.814.gb8fa24458f-goog


