Return-Path: <linux-sctp+bounces-648-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD4BF8F99
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8245561B54
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AC2BE625;
	Tue, 21 Oct 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJDPZEX4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD952BE036
	for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083072; cv=none; b=Z5+b7NbYSAfgWdojNz5/mUibwVSrVVJehSLUZDmCDXpUmA9GDFz0wWwwQUumvaHLRZsj7jLKxg8KlXBweQ0EzCByecrG4YspXLO5wSupA04eHHXakAnzAl8l+dNLWNn3fVu4aZo/4OjNEyXzRHR3jEiSffwmiUfrYzcqBiZsQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083072; c=relaxed/simple;
	bh=tPI6tOx2Bnfb8N36L8RQII8lQKj5/fU4eKUBY09Xars=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uNAkDQj1Qx4mptHhfVoTd7xEhoQHdb6+oTI9e7VMPuLrA7pOzwvL5o2suTPhXB9mqADMDBGPArC2fbfoWRxAanw7qK9Yipj5Ae+RoNw9rcHqTg1vFK7X2iYnv2yKqvMkkKELRNsAoUzLbzqDDi285FoWasFeJPOiixGGQGdkAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJDPZEX4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33baf262850so6036243a91.0
        for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083071; x=1761687871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3qjK0ySS8hZEhrCqzMTCx0uVBDgzLWq2ttDSe6JLDc=;
        b=TJDPZEX4ShxZRHUQ14vTF98uMj7zInSIxo37SPgdIttkccuRCCdRQ7hnS2F6Kg9Y7R
         MHegsJ/i5zK1+jnZ7wTaSHL18aqMnMYyD5BlShkg6xtVmlNp47RVz9cHWSlTQXcNzIl+
         uXuaK/JmkrXEhkacWYHZzsRR2qtPi8EYU1tNx7jE4merChmoD9JWvG7UQd7/cBXFaeNA
         Tt4pio6AXQj/isvMEcFzSCZ9nNT1bclC+XeKkRuQ5+3A7L+Jiu/I6mkdmGCsVrEiLWMX
         Z2CeX1f/E3t4Q8/HN2kjO+C1gtFJh1/BomW0T0sLvtzcoJ5IW2zhcuYhGayzs2acrRHH
         i4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083071; x=1761687871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3qjK0ySS8hZEhrCqzMTCx0uVBDgzLWq2ttDSe6JLDc=;
        b=HEOh6GzOeQIylx6LjlcW7TeIQAL8mmexTzsiezEsWC7aBqTg1cJdTC/OwnFGsgLlo2
         p1hq3nRAKQ/wvkmHslNmqbhpoHqfMXysI9Us7ncYBb2PJTUdoz5uvYa45XrNJIswHen1
         oyIQSwSQT9gW+seVQjkSAcOspXPvNVA7YsSqpChx81dICeETw+IQRynMBAlSHxNgX+7S
         tWZSaJ826A5CfbZQwccKHNppi2JB/Tn29OsmvONzxClMzY5NcTWLiduR5++eo4oPu52N
         wdKBMgt5c0ZkBDl39gcbedDbO/mx73YqPrcmB0MEmxqeMsAHSmLO+xiLpUDANCUjoxCh
         ua2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqWALqNw2Eof2O5TG//i+m+4dr2shhHQXsb5c5B11R3OPmv8XdXSkTjByMG8gATHTQ0K9uA+wiRzLa@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVrpk+cOwW3eTaETqlNTGTOL207kXSxZQbDvcArMsAjZrUVrF
	MoKmGAlloFDSiOSTeIjLPmN0uTLnzcVIDuAReFvAGbv3BZvQ81Bkdv5l/0VAhs4OWDy+79Xun/O
	wNDUd9A==
X-Google-Smtp-Source: AGHT+IED/iav1kJwxa2ZPXDW3APsHrgabyLVwT3LlOMKasIestzyowPVCID9qcRmHVSaZEvo8RtnDJUp6Yk=
X-Received: from pjso17.prod.google.com ([2002:a17:90a:c091:b0:32e:3830:65f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2686:b0:32e:e18a:3691
 with SMTP id 98e67ed59e1d1-33bcf919f1fmr26758053a91.35.1761083070874; Tue, 21
 Oct 2025 14:44:30 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:21 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/8] net: Add sk_clone().
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
index 01ce231603db0..c7e58b8e8a907 100644
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
index a99132cc09656..0a3021f8f8c16 100644
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
2.51.0.915.g61a8936c21-goog


