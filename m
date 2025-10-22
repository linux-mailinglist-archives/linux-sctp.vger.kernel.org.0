Return-Path: <linux-sctp+bounces-663-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F0BFE491
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 23:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88173A8C9D
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29055304BB3;
	Wed, 22 Oct 2025 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7+WJTEg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6323016EA
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167857; cv=none; b=LSMu94q+yqPEBDEyAtZJ3d1pWC5BawcthodS3FkWPdi5W3onpf9qLs/58hx1tOHZ0B/feHnQW/IySYnIdO2KnFZ0cCWFcNFuLYPZhA8HRC6uhMc3W+qAOW/djFIc/DGqo8PMMLZwwJvmfRDuAZxj7NbQBpAJXBFCUCOReHjZ1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167857; c=relaxed/simple;
	bh=UuMd2OTJefDUKgBkZYoOv7gStJXI5KVluP9A6P5szKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FS8vq1RLk1GD6uwGzVG5MtikvowHOlAoz4kvkSqxlBHT+JYAxoinvIwZdmVXJzMy5wHmn/qaB8Qf7LJ8hkOLRzeHydB+0pHeRYLuPkPZ0k2Vrmwa3HVz/7wC3KQ2mTcFArlOd/miIlGNvYcrdqAj4YLTU4wU6dLzkRWdGCgLmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7+WJTEg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso184883a91.3
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167855; x=1761772655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLWnxlEdhdbUcPTmZe5W16gh6OG94B9z1RfA2ZybH/E=;
        b=J7+WJTEgWEjGG4LSej6Mu0t8S71qVm1TSArFh//98dGl0di6f2R3ZDJXnK+lbFm6rT
         vA75faxZpYj8/ff/SKb8SxuuF8BdWFvAkADI+Gqk7bNPgfK1pIHoswZBWLCE0kt6VbiI
         YlkzIN2K7YewxGA+r6t3knZZTawn1oM8HYh8TPMHJHpg9TZCTb1p8vLMViaL5WQoZzfI
         1Mm7ipQekuSgPrLF16qLCEMhK6o0HmrzfNV/i4MWwg9/guqJjPZlAAs1uvfJbdy8HWpi
         dgg8TBqURkrVCHPL6YUAunhDxVog3q7y7ublJ4VMGtamCYp+chlho+bKqE43OkR8aMqC
         WJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167855; x=1761772655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLWnxlEdhdbUcPTmZe5W16gh6OG94B9z1RfA2ZybH/E=;
        b=URet4XRipbxIe/5x3nCOCnoXFmJ1J3Lpi5fq3m1KJ1H0206yEyLq7mkJctAaP7DAD9
         PhHFy5u2DbsnclH9m/+4GLdCN7Vsg/wxd+NuVHEnOM+AwojiVXMIzVw9FEXUkkFG0K4G
         Bwb2r9ICVTvhJ/a51cf3UpflgMrg55stVtA4G10GlnLRCMJUaqSm4PEdWYviZB5ESj3l
         dKYhSEY+jNqtGT201w7a1ZBgvzkxddMguObYGKhaF6jzV33dvm66+qc9wAabQq3IzRNf
         xDMFOtuohlXKNNI6RWDbuDUx+e1HMukOZ6LW4ku8MOUoTbe28GGKr0YO9ApJ9nQ+sf8S
         panw==
X-Forwarded-Encrypted: i=1; AJvYcCUUvcIva5mKQ+x/eb76JiQPjOI7QybQQ1sn7MirJrDCcNYIjJMVMU07kyhrY4lupxG8myxZlnKya+S/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2Re3I6XXXwQJO4eeL+gnPpHzCJsGiMYHDAChooBupAwNmCif
	493lWfFQY1jc3GMbLvUQ6/WRTlwUQw8sbQ7WGwpWXT+qZ5fcdZ0OhkJ8cMZ7w1olPz1OL355chm
	BvIUSWw==
X-Google-Smtp-Source: AGHT+IHRHOkJdMhRC3hmy5HtOqY6ctmihaYzgt2SOcGRDZ+hg56Yj4GN5PTY4vIZ168Iov0RigaW2n9kFkk=
X-Received: from pjbbh20.prod.google.com ([2002:a17:90b:494:b0:327:50fa:eff9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec6:b0:33b:be31:8194
 with SMTP id 98e67ed59e1d1-33bcf90ca94mr27272462a91.34.1761167854818; Wed, 22
 Oct 2025 14:17:34 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:07 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_do_peeloff() calls sock_create() to allocate and initialise
struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
and sctp_sock_migrate() overwrite most fields.

What sctp_do_peeloff() does is more like accept().

Let's use sock_create_lite() and sctp_clone_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Export __inet_accept()
---
 net/ipv4/af_inet.c |  1 +
 net/sctp/socket.c  | 36 +++++++++++++++---------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 77f6ae0fc231..0784e2a873a1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -788,6 +788,7 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 
 	newsock->state = SS_CONNECTED;
 }
+EXPORT_SYMBOL_GPL(__inet_accept);
 
 /*
  *	Accept a pending connection. The TCP layer now gives BSD semantics.
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 826f17747f17..60d3e340dfed 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5671,11 +5671,11 @@ static int sctp_getsockopt_autoclose(struct sock *sk, int len, char __user *optv
 
 /* Helper routine to branch off an association to a new socket.  */
 static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
-		struct socket **sockp)
+			   struct socket **sockp)
 {
 	struct sctp_association *asoc = sctp_id2assoc(sk, id);
-	struct sctp_sock *sp = sctp_sk(sk);
 	struct socket *sock;
+	struct sock *newsk;
 	int err = 0;
 
 	/* Do not peel off from one netns to another one. */
@@ -5691,30 +5691,24 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
 	if (!sctp_style(sk, UDP))
 		return -EINVAL;
 
-	/* Create a new socket.  */
-	err = sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
-	if (err < 0)
+	err = sock_create_lite(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
+	if (err)
 		return err;
 
-	sctp_copy_sock(sock->sk, sk, asoc);
-
-	/* Make peeled-off sockets more like 1-1 accepted sockets.
-	 * Set the daddr and initialize id to something more random and also
-	 * copy over any ip options.
-	 */
-	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
-	sp->pf->copy_ip_options(sk, sock->sk);
-
-	/* Populate the fields of the newsk from the oldsk and migrate the
-	 * asoc to the newsk.
-	 */
-	err = sctp_sock_migrate(sk, sock->sk, asoc,
-				SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
-	if (err) {
+	newsk = sctp_clone_sock(sk, asoc, SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
+	if (IS_ERR(newsk)) {
 		sock_release(sock);
-		sock = NULL;
+		*sockp = NULL;
+		return PTR_ERR(newsk);
 	}
 
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	__inet_accept(sk->sk_socket, sock, newsk);
+	release_sock(newsk);
+
+	sock->ops = sk->sk_socket->ops;
+	__module_get(sock->ops->owner);
+
 	*sockp = sock;
 
 	return err;
-- 
2.51.1.814.gb8fa24458f-goog


