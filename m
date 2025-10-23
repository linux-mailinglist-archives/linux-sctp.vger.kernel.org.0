Return-Path: <linux-sctp+bounces-684-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DFDC03D0E
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FB63B5ABB
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE92C21F7;
	Thu, 23 Oct 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU94jje9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6602C21D6
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261483; cv=none; b=TXT2dedgTYbeBg5xECEl4hP1oQn+l85jXJaMnfzPpokw5sqfg3se4zO5EQ7PYC59JynSxgv5axjIxmwY0WpxpIgWjd7A3U8GdO1qoh34qpbH0juafEAhXMRKjUiB4XoAPHkQq1kK8rW3gXRDjg29xd+2XWIqbH5GOrzl/mCwSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261483; c=relaxed/simple;
	bh=6rwbuac3gNgBbkj6Sd2BmJoBBMEjemK4B3VYq4on/60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jI4Wik9xRbo3xRwOSb+qWCowC+TngYZuZHJ2FpKhwfhsfxh3G6wCGh58QFSw9ikQKGu1Mce1JfkcEsnM6sbOyUQykiD7ngoZCeF12Gi6as3voJNtFQXJPhWfK01/BqvdjX00Ll3cf46DJvWY+hP7yx+TQGfDh2LfIVFoOTjKVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU94jje9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so2807917a91.0
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261480; x=1761866280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uVUwAa/FpVfjqwBskmNBroZUDoDv09TNyZorhuCnkg=;
        b=hU94jje9+IJ0Wh1KYMGoE9PhHnTfIJ1kBRaLqsQV3PPQTEWy+PSIzACHfHtS4UaDhP
         dXLwUsgJA0bO5oW23V0YV8lWohCRMvDiP8WjhbVZReQ0bTswd/BZNek0O+LzxalABcen
         xuHuEoloMNF/cV8k1lpLo54SRdtkLCeIZL5xygLiLTLp4Y28umUwssEK4TD6cj/paLnz
         bBhDgJCTw1uemxXx06mjD0AHpa/5qdDquCEYjRkkVKDnHhPxE3bF/P7PwFssdfEUQRm8
         VHBLRj4Og9qSDFmG6YYIB1U2VBVQc5XnG0S4X4UmjiJZw6lhEbffocMcf0VEYwU94fVs
         aVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261480; x=1761866280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uVUwAa/FpVfjqwBskmNBroZUDoDv09TNyZorhuCnkg=;
        b=NLab4RfRi9JzcVGdLZ53VHNsiYqmxtO7RbIeg7oE9ACwUJ8jdidRYuguTdZqLYpybn
         RAl1rEmDUOsdKllbBj/cRPrAo/Q8OsAzFbyfVFDAlKtQVyeaQD3NJ7UTimnCvbPnka82
         N4tzmADYXR5G5D6g0/Z/cW5Ga7vgsmB1Jv2ONIUtJrPjqOiRLM8mRR/6OGLSrQnUgoUF
         uyxifPZXlgKOATkHssSlM97lZXyCbyrTjSQkt6qCv3VrWc9+KoQBa7b+QrwSfh8K/kQl
         BF5IB1IaKk7KVfD9t65uGgjL2E0FmmOv+2CEtWW8tPzJe/TDaueF14qd3Ej5tnGGDLQK
         p5sg==
X-Forwarded-Encrypted: i=1; AJvYcCWdV3Vahfmpda/wFf0IMr31oZmH8ZLeK70aTcDm6+O2MPC728kDVJ8GiE3ePwarSJGqEx26fPdSzARz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxej2XSKByiUDaajwrmxznffL4tiCbpSx2iui1qW/47YDVDt9pV
	rAdPlSGj8AcOS7o4cZ5/ECy605nxlgtoo2cdSMvFqQxtjsW/hOqbq/q1TNnKsevA/KlFttvNKbQ
	WUifrsQ==
X-Google-Smtp-Source: AGHT+IF5dZqUv6nmwu+wY0jCEaMSjp+KPvrTJORHwkMfz5kigOX0Hsp5tTaOTx79/BSTFB4LTTGDOWCGcYc=
X-Received: from pjbch10.prod.google.com ([2002:a17:90a:f40a:b0:33b:ba24:b204])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:530f:b0:330:6c5a:4af4
 with SMTP id 98e67ed59e1d1-33fd662e554mr248299a91.35.1761261479988; Thu, 23
 Oct 2025 16:17:59 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:53 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 4/8] net: Add sk_clone().
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
v3: Check if (lock) for bh_unlock_sock(). (Xin Long)
---
 include/net/sock.h |  7 ++++++-
 net/core/sock.c    | 24 ++++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

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
index a99132cc0965..7a9bbc2afcf0 100644
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
 
@@ -2590,12 +2597,13 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	 * destructor and make plain sk_free()
 	 */
 	newsk->sk_destruct = NULL;
-	bh_unlock_sock(newsk);
+	if (lock)
+		bh_unlock_sock(newsk);
 	sk_free(newsk);
 	newsk = NULL;
 	goto out;
 }
-EXPORT_SYMBOL_GPL(sk_clone_lock);
+EXPORT_SYMBOL_GPL(sk_clone);
 
 static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device *dev)
 {
-- 
2.51.1.851.g4ebd6896fd-goog


