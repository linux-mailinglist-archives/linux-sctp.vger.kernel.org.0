Return-Path: <linux-sctp+bounces-683-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B8EC03D05
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4253F34E75E
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C22797AC;
	Thu, 23 Oct 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjxjJHzE"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC42C08B6
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261480; cv=none; b=dklp7fKum7BFE9L1K7gDe2PlYbpKNhOjYKsm+bGNbzIYp6+dv8y7pbuGN0lwQTxCz1gSRyqD2HeN10Y2prGXsHXJ4cf/DJyLDu9TLGQfVyOA0gpTQbPKr9UGAYG+JHmBAVn0CgrkKsraT27MNYS9LEgOVLeeAKlhlVlvCViodjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261480; c=relaxed/simple;
	bh=+hRKG9omY0Aq7FrPtGSJ7PhHS3uo5f5KziTlgQCvngs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lHUjCC3lcYpwjOibMP/DWjhheZJIvM5oY8CGFObYx+Gq29/x4InP5NHhiNlRf78XNoesBY6ZlS0MGlpz0FH3lezJdsks7JK6uRJG3jiStDNW7eySQ5L99keJ3RJESr5ly33TDpZV8TK6wuHt/NdNIL+gVf5m01fruJFdIPAZ5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjxjJHzE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so1099020a91.2
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261478; x=1761866278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBNqMuHC+hxsg/yyO/qKPrU3e816knFdIUNFx5rrobA=;
        b=pjxjJHzElg7LH5HC+mjrRZoMF97PiDsoPk5fQKZvnTF0JglS7f1hv6FXOrgm511iFt
         69SXLSnNN4gi7W4Q36bGXnRG0PWWOQdFJ3GVHc8euMJWAbR9ECO7Nk/qqWnUghb6hI7i
         1TZ3IkduDRQvqatnFnNg7zDjAvq4xOJtXjGAlC1xAstM6ElJR/1mmA0xvcjjJjrclE99
         mR7wpw6htSsSTDveJ5Mw+f2HQSg1DK99TRQdyZ/6Q152k6G5BEFeTIQIzZB7QkGAJ7Zu
         4lw2mylEehhbxgteyRlVrI7jU/7B0+E5F4/nLRaI+wDJOZ6tZVlO+nVkmpYJBw0u/9Em
         jR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261478; x=1761866278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBNqMuHC+hxsg/yyO/qKPrU3e816knFdIUNFx5rrobA=;
        b=MObys9/o7vhoJPfWX20ttHS5F1hlRtbiloD3iaCnx6xsUFjD2S2cdqS7sJ661JtcWz
         T2hefj7n1CxtycYcw0+Gro144vXg1npjr0zilCCs/ribBERwxSQZty+R3sER+FXNgU5R
         kVNOhRmVwUdPtbVVM0jQHrs4pWKHePZld8R/2LHGq5viwYw2nouG4pVjKOfZC4ZLxXv0
         8ZmQTDjVc7dQFCsNxyLTgZwVC8oV7uqhuSy1OkuFI4k+66YtOrpUGPssW4/LH+nW2DhD
         TlVA1Gqr1FnixfTznA0mpkuaDcqtP1uN5L1YsmNwyTktdcAkI5GEk4YPtJLFauXPMYc/
         APWQ==
X-Forwarded-Encrypted: i=1; AJvYcCURSDsJZydXKY4GsP+7duxdxqOzPBu9W1PErTfuLyTwiDZdJaldUsAYp464SdA8J/o6Oq0eFD6lpdfc@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOZzcZIYbTUq1y2lL9ZVoJZ4K3f+gPsd3InonsmwLpIvHGirA
	SgZEX7cepjTEdb5Xsp0q6Ate5GvLUKOgwhg5CDoUG4BUJtJYwkCCq1tL9Yr+PsQYU44KkqVoH90
	beUFgxw==
X-Google-Smtp-Source: AGHT+IFAbORmVtMDxn8zOvFrk1gxynhYIDz39bK4aVzqEZ7+of00HG6eJ9eZUcG1Fl4LHM3y3TDXJ65manw=
X-Received: from pjbqe7.prod.google.com ([2002:a17:90b:4f87:b0:329:d461:9889])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c11:b0:32b:9774:d340
 with SMTP id 98e67ed59e1d1-33bcf91909fmr38273872a91.33.1761261478290; Thu, 23
 Oct 2025 16:17:58 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:52 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 3/8] sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_accept() calls sctp_v[46]_create_accept_sk() to allocate a new
socket and calls sctp_sock_migrate() to copy fields from the parent
socket to the new socket.

sctp_v[46]_create_accept_sk() calls sctp_init_sock() to initialise
sctp_sock, but most fields are overwritten by sctp_copy_descendant()
called from sctp_sock_migrate().

Things done in sctp_init_sock() but not in sctp_sock_migrate() are
the following:

  1. Copy sk->sk_gso
  2. Copy sk->sk_destruct (sctp_v6_init_sock())
  3. Allocate sctp_sock.ep
  4. Initialise sctp_sock.pd_lobby
  5. Count sk_sockets_allocated_inc(), sock_prot_inuse_add(),
     and SCTP_DBG_OBJCNT_INC()

Let's do these in sctp_copy_sock() and sctp_sock_migrate() and avoid
calling sk->sk_prot->init() in sctp_v[46]_create_accept_sk().

Note that sk->sk_destruct is already copied in sctp_copy_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/ipv6.c     |  8 +-------
 net/sctp/protocol.c |  8 +-------
 net/sctp/socket.c   | 27 ++++++++++++++++++++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d725b2158758..c0762424a854 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -789,7 +789,7 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 
 	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
 	if (!newsk)
-		goto out;
+		return NULL;
 
 	sock_init_data(NULL, newsk);
 
@@ -818,12 +818,6 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 
 	newsk->sk_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 
-	if (newsk->sk_prot->init(newsk)) {
-		sk_common_release(newsk);
-		newsk = NULL;
-	}
-
-out:
 	return newsk;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 9dbc24af749b..ad2722d1ec15 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -590,7 +590,7 @@ static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 	struct inet_sock *newinet;
 
 	if (!newsk)
-		goto out;
+		return NULL;
 
 	sock_init_data(NULL, newsk);
 
@@ -603,12 +603,6 @@ static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 
 	newinet->inet_daddr = asoc->peer.primary_addr.v4.sin_addr.s_addr;
 
-	if (newsk->sk_prot->init(newsk)) {
-		sk_common_release(newsk);
-		newsk = NULL;
-	}
-
-out:
 	return newsk;
 }
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 735b1222af95..70c75ac8da55 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4851,7 +4851,7 @@ static int sctp_disconnect(struct sock *sk, int flags)
  */
 static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 {
-	struct sctp_sock *sp;
+	struct sctp_sock *sp, *newsp;
 	struct sctp_endpoint *ep;
 	struct sock *newsk = NULL;
 	struct sctp_association *asoc;
@@ -4891,19 +4891,35 @@ static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 		goto out;
 	}
 
+	newsp = sctp_sk(newsk);
+	newsp->ep = sctp_endpoint_new(newsk, GFP_KERNEL);
+	if (!newsp->ep) {
+		error = -ENOMEM;
+		goto out_release;
+	}
+
+	skb_queue_head_init(&newsp->pd_lobby);
+
+	sk_sockets_allocated_inc(newsk);
+	sock_prot_inuse_add(sock_net(sk), newsk->sk_prot, 1);
+	SCTP_DBG_OBJCNT_INC(sock);
+
 	/* Populate the fields of the newsk from the oldsk and migrate the
 	 * asoc to the newsk.
 	 */
 	error = sctp_sock_migrate(sk, newsk, asoc, SCTP_SOCKET_TCP);
-	if (error) {
-		sk_common_release(newsk);
-		newsk = NULL;
-	}
+	if (error)
+		goto out_release;
 
 out:
 	release_sock(sk);
 	arg->err = error;
 	return newsk;
+
+out_release:
+	sk_common_release(newsk);
+	newsk = NULL;
+	goto out;
 }
 
 /* The SCTP ioctl handler. */
@@ -9469,6 +9485,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newsk->sk_rcvtimeo = READ_ONCE(sk->sk_rcvtimeo);
 	newsk->sk_sndtimeo = READ_ONCE(sk->sk_sndtimeo);
 	newsk->sk_rxhash = sk->sk_rxhash;
+	newsk->sk_gso_type = sk->sk_gso_type;
 
 	newinet = inet_sk(newsk);
 
-- 
2.51.1.851.g4ebd6896fd-goog


