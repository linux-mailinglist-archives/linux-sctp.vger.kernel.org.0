Return-Path: <linux-sctp+bounces-659-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC1BFE461
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 23:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75111A07044
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D1302CB4;
	Wed, 22 Oct 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZbPdAFF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98863302141
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167851; cv=none; b=AEhs+m0x2hTtOAqYtsqOQ0a6cOaof6+d1R6oTMLOcLFKaXgcaqgENVgXJ1n4WKsAF6PiLNRwTQm5UTEVLcI5enCPea/rKkxXl/CnIvFHjWEyb6Tp1KmDVoFaOY3B90INjUUGvrtwpec60rmpdxNv62FH6UTElx1w7Z3kX31JurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167851; c=relaxed/simple;
	bh=5G6ocPQtcQrEViq+aZdMhFhtzT/7RrtpLGIjidquU4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+NC3iGwpEatSFJ7C0bPIOgsCWJjcyDs9FgG6afsrdQe35sidUMWc9c1HrG8Dcd4DAq8KJ0thocKVCAmOBQ0+eR0Bm6a9XQJR5wSZukUMqb95Kz3aG4YTHvEOwmXLJdA/0ps5NKdfkOL8V09d5MEQVvoQyvNG6SS5R1REcqcmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZbPdAFF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso60416a91.2
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167849; x=1761772649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyqL9OsvOLL6aN1++JqIoHWIm6QhqUqulXh7SjTzH4Y=;
        b=XZbPdAFFmbAUSfZlxS1U0FBmhSa4ZaV1hKadnCVOfzXR/JS7Vz3MQQOnLlRLlgUoEN
         QXVH1XK0u6ZPJxXWNGlKdyCPQNZD1FUMxI2IvvKL4I+F8iMo2gQDvcxTlTCbbM2zCgIc
         VJwT1ZZ1p8UMbCPFEsx+9yWrkJl0228/piSNHrQtb0mEVppsCb1ctHvX74zeI4En2pQs
         uLrSYypsSzpjGMe6/irivhqLe+bqHu38K9H6++RIMYjTXU16NoyiO2DhsOZFqgpCTvJa
         txP2u7cxzsIA/8dOy9RvyP8y8jXdNUxw/5ao4dgQqHwEPX5MQQJ7uERkNWuSpuQ9GvZu
         yQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167849; x=1761772649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyqL9OsvOLL6aN1++JqIoHWIm6QhqUqulXh7SjTzH4Y=;
        b=ne96+R3HZLh4rOPekPVmBTECnM390FPgJBfsjO6mYg1Or98fLeFkthtzLsXuAAvCeC
         teVnWfiQtfGwNGSaLVSL5uPThaRL8EAHfhzQNZ5K9k5rwWzaR5Ml2bxrqE0oiP8VfCS4
         FmbQ8reHrVr7WxzNJ228vS9cj3tSyTx424WYdeGJja9dEupep6fnb6LTYzSCkqBRLLg3
         fcAlwrqriQYt9+6/f+5dh8X184XZTwQSWpL3M6YWCtIV5F8/Q/z6feEdVKJJwpOlS+BO
         0lQN+n6PDA0vEL1VmHR3DJ82C7SFmUdgfHbb1w7riq9zd5jAe6oW8ypKJy1e63QC1Ql2
         zE9A==
X-Forwarded-Encrypted: i=1; AJvYcCXVNZjh+4udeHVckpT3ZQsmMWkPMZrAIEvo4Zev/5B/PlXEsyDfzrZoZ6HxPdzN6wLg28TR+WMpa0mZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++u+DLkoeyfOQZkQ5X/OIGVSdAHdZTAcLlOkkERNavPPS52/0
	zGoysmlw2vwm+i2IqpXPerAn+3juQ8uqbhsFBWX3PS/gzK8hg7hjlNBxjWK+TwKKdfY3riqSzmm
	tsP/vRQ==
X-Google-Smtp-Source: AGHT+IFnJhkhSlkvVYHrNddldM85bQGf27HN2bAiDWhf8krSpsv3tdV8J4WrgMMuoWWIFIRm4KZxSShVoYU=
X-Received: from pjbnm19.prod.google.com ([2002:a17:90b:19d3:b0:33d:cdb9:9adf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:514e:b0:32e:7270:94a1
 with SMTP id 98e67ed59e1d1-33fafc1bcccmr381044a91.17.1761167848869; Wed, 22
 Oct 2025 14:17:28 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:03 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 3/8] sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
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
2.51.1.814.gb8fa24458f-goog


