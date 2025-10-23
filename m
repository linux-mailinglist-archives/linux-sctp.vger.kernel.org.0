Return-Path: <linux-sctp+bounces-688-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8043C03D27
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E281A08CBD
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD72D3A75;
	Thu, 23 Oct 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJyS4/V2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923C291C33
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261489; cv=none; b=OoXqNMatF+5vRMJKMwqK3NHy1Zh/LJxgy4uTGXGN6y/FE5YQDSWl6D8QfTeKrbwlCfG87FQYGDIBXnP2W1SJyYjveVOwlteKYpOUH6u+LubXtyZLMXBq6o7YAgukW/F2Qlfajs++FluMvaFoT8km+tr7hzkJcdCPCGJZboDQ0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261489; c=relaxed/simple;
	bh=0PfHiONiz3Grpom85rzQkqb75bJA6nEVVqf5UsChzA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=udSHogXxNkSt0uQvgbkQ16Ogat42Ni5LJS9SWp1jmgEUffbKdTyCO3W/xNEcItMuI0/Bfz1B/4hRcQb30tHPhzuPJXDR5FH6Bt7K7RDbsJkihLD6VWQyp2vXR2CU+MvJCKTaiU4c38Y4/3Q3mDO/AE/XQKVRuGJxVr73ESLuEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJyS4/V2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6a33319cb6so996843a12.2
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261486; x=1761866286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pExEr66VVW2J+70M7zAZNzEDsJqKgqLeYU1DZoxxTY=;
        b=QJyS4/V24I7DScNBedSoeDJ9+wuD3E1kQaoeTc8lPqkml9ZYy/SO9Dy1c4o0ogtXtZ
         Sa3+/1dTpG8xc7k7es0ZyQv9uniM9yomD0UclEfQmkgIu3HqNFU4IELnAPxQ7r8zPEM/
         0fFXChPJvzPZ2k52TTD4EgfNKqXouAAbpNPEth/TFYvRJCPCjmJcUYulWBsGlpDybB/X
         RdApEbArXpisoDbky38RYMy9ujMgZYjHyfDnqVfFsRDvp5jGg7qSLJtclXECzouFfzxC
         mCCRFB0wMEnYMqJCbCvclTRKTaxHQi4CKxlgFGgwTsgyxgtrdABbU5p4Z8ttw6NNgPfh
         p+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261486; x=1761866286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pExEr66VVW2J+70M7zAZNzEDsJqKgqLeYU1DZoxxTY=;
        b=Z3mgywctJse5S0vQDgFVteQuoFwj9SfhxZAf70aqgMRBtBjX9eQHtWbUzgd23aLGCt
         vBtx3NQSKBhBD/lOGkVuvhtrOemxEh5Zm0btl7QB/9Wf247UTguk3EsMBvTvY5lGxEQd
         +5UCQalLCqfJUMLMAAOPwTOx/LMp/51O9qaP/nz460pdcTCINPZLXEQzKidbv9T2nwoj
         7G0Gp//F28hipdqMbzpFEN7yGC19tSjaZJFlutcaRdHP0XnkAb+loi2FbwoG2awiopeC
         VBrxQ5BOFYcnWPyWm7zR2i8Dx6CRAr9b62t1eP703L2pQDNxZBhm82Bed2luVU5qx/zc
         vpTA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0fWn9ICzE3iMOwcawieorfJFOE5fHsxjeDVW6PXIBOZApeYzxeyC7AOB+vjnSsBtTyRjwtYlqAOZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34eAWUlxbz/QDM6LQcJHo9JAg7f/o3t/kvE6lYciu+T4yOgwk
	He9Mm/3VFHOhM0c2k93lCedsZnBVx9PII9HeUF/EBW8Tcx0/TW5nQ+DhnmCmwUAwB5wTsjciQaT
	c7/X+rw==
X-Google-Smtp-Source: AGHT+IGarXYjLpHaIuCvwZxGsrao9vzvkkWa0XlmyONjehKVDwWWj1elwmBqQu9bGrJArjkbnGP8nuyygHw=
X-Received: from pjbgv18.prod.google.com ([2002:a17:90b:11d2:b0:33d:d0a9:ff0b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1a:b0:33b:608f:2606
 with SMTP id adf61e73a8af0-33c619cf560mr5846872637.29.1761261485917; Thu, 23
 Oct 2025 16:18:05 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:57 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-9-kuniyu@google.com>
Subject: [PATCH v3 net-next 8/8] sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, sctp_accept() and sctp_do_peeloff() use sk_clone(), and
we no longer need sctp_copy_sock() and sctp_copy_descendant().

Let's remove them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_sock.h |  8 -----
 include/net/sctp/sctp.h |  3 +-
 net/sctp/socket.c       | 71 -----------------------------------------
 3 files changed, 1 insertion(+), 81 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index b6ec08072533..ac1c75975908 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -355,14 +355,6 @@ static inline struct sock *skb_to_full_sk(const struct sk_buff *skb)
 
 #define inet_sk(ptr) container_of_const(ptr, struct inet_sock, sk)
 
-static inline void __inet_sk_copy_descendant(struct sock *sk_to,
-					     const struct sock *sk_from,
-					     const int ancestor_size)
-{
-	memcpy(inet_sk(sk_to) + 1, inet_sk(sk_from) + 1,
-	       sk_from->sk_prot->obj_size - ancestor_size);
-}
-
 int inet_sk_rebuild_header(struct sock *sk);
 
 /**
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index e96d1bd087f6..bb4b80c12541 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -94,8 +94,7 @@ void sctp_data_ready(struct sock *sk);
 __poll_t sctp_poll(struct file *file, struct socket *sock,
 		poll_table *wait);
 void sctp_sock_rfree(struct sk_buff *skb);
-void sctp_copy_sock(struct sock *newsk, struct sock *sk,
-		    struct sctp_association *asoc);
+
 extern struct percpu_counter sctp_sockets_allocated;
 int sctp_asconf_mgmt(struct sctp_sock *, struct sctp_sockaddr_entry *);
 struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int *);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 60d3e340dfed..ac737e60829b 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9491,72 +9491,6 @@ static void sctp_skb_set_owner_r_frag(struct sk_buff *skb, struct sock *sk)
 	sctp_skb_set_owner_r(skb, sk);
 }
 
-void sctp_copy_sock(struct sock *newsk, struct sock *sk,
-		    struct sctp_association *asoc)
-{
-	struct inet_sock *inet = inet_sk(sk);
-	struct inet_sock *newinet;
-	struct sctp_sock *sp = sctp_sk(sk);
-
-	newsk->sk_type = sk->sk_type;
-	newsk->sk_bound_dev_if = sk->sk_bound_dev_if;
-	newsk->sk_flags = sk->sk_flags;
-	newsk->sk_tsflags = sk->sk_tsflags;
-	newsk->sk_no_check_tx = sk->sk_no_check_tx;
-	newsk->sk_no_check_rx = sk->sk_no_check_rx;
-	newsk->sk_reuse = sk->sk_reuse;
-	sctp_sk(newsk)->reuse = sp->reuse;
-
-	newsk->sk_shutdown = sk->sk_shutdown;
-	newsk->sk_destruct = sk->sk_destruct;
-	newsk->sk_family = sk->sk_family;
-	newsk->sk_protocol = IPPROTO_SCTP;
-	newsk->sk_backlog_rcv = sk->sk_prot->backlog_rcv;
-	newsk->sk_sndbuf = sk->sk_sndbuf;
-	newsk->sk_rcvbuf = sk->sk_rcvbuf;
-	newsk->sk_lingertime = sk->sk_lingertime;
-	newsk->sk_rcvtimeo = READ_ONCE(sk->sk_rcvtimeo);
-	newsk->sk_sndtimeo = READ_ONCE(sk->sk_sndtimeo);
-	newsk->sk_rxhash = sk->sk_rxhash;
-	newsk->sk_gso_type = sk->sk_gso_type;
-
-	newinet = inet_sk(newsk);
-
-	/* Initialize sk's sport, dport, rcv_saddr and daddr for
-	 * getsockname() and getpeername()
-	 */
-	newinet->inet_sport = inet->inet_sport;
-	newinet->inet_saddr = inet->inet_saddr;
-	newinet->inet_rcv_saddr = inet->inet_rcv_saddr;
-	newinet->inet_dport = htons(asoc->peer.port);
-	newinet->pmtudisc = inet->pmtudisc;
-	atomic_set(&newinet->inet_id, get_random_u16());
-
-	newinet->uc_ttl = inet->uc_ttl;
-	inet_set_bit(MC_LOOP, newsk);
-	newinet->mc_ttl = 1;
-	newinet->mc_index = 0;
-	newinet->mc_list = NULL;
-
-	if (newsk->sk_flags & SK_FLAGS_TIMESTAMP)
-		net_enable_timestamp();
-
-	/* Set newsk security attributes from original sk and connection
-	 * security attribute from asoc.
-	 */
-	security_sctp_sk_clone(asoc, sk, newsk);
-}
-
-static inline void sctp_copy_descendant(struct sock *sk_to,
-					const struct sock *sk_from)
-{
-	size_t ancestor_size = sizeof(struct inet_sock);
-
-	ancestor_size += sk_from->sk_prot->obj_size;
-	ancestor_size -= offsetof(struct sctp_sock, pd_lobby);
-	__inet_sk_copy_descendant(sk_to, sk_from, ancestor_size);
-}
-
 /* Populate the fields of the newsk from the oldsk and migrate the assoc
  * and its messages to the newsk.
  */
@@ -9573,11 +9507,6 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	struct sctp_bind_hashbucket *head;
 	int err;
 
-	/* Migrate all the socket level options to the new socket.
-	 * Brute force copy old sctp opt.
-	 */
-	sctp_copy_descendant(newsk, oldsk);
-
 	/* Restore the ep value that was overwritten with the above structure
 	 * copy.
 	 */
-- 
2.51.1.851.g4ebd6896fd-goog


