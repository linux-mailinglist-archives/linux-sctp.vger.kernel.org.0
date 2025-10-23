Return-Path: <linux-sctp+bounces-687-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A11C03D1A
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73ACD4E2024
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25732C2358;
	Thu, 23 Oct 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6AU34N/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B862D2384
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261486; cv=none; b=C+FCwRPxHmQFa/MVyp5wo+df7vyW68MdenXZ/P3FHaWInnVsqE9tky0FMHIxTH4i+tcHz9CDkTkk9xW3NMxlxGK4lLLYDfDJoYEaCFdcv+M6aHwJnh1D2j6jrXfB0G1BTA/4GWNyP6bwrcOHG5jpf0A/hl4m9I8x3Acv5y8RFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261486; c=relaxed/simple;
	bh=cLOWzPckiljsvk+s9zeTQ2d6X+gpFhd9lvDyduJUFZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqlG+iCV+484MqmgJfvncbiTP7SjGkNoLNBDXazKQUaFQHb3UvsJt9XAd/hp/AbVCGvyCR3yetCRnZGr9akDksqsDHo3OqCX2g9v+wgLXYRuNNo7QjA7qgeZXnRhV94a9BpXGyDY5isFhlku42Pch766ryMRhGgWyiQuv4mnLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6AU34N/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33c6140336eso2941549a91.3
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261484; x=1761866284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHveIE9Rl1G45KitM9v7ANlIHiL7Ar/r1bbAanaqd+0=;
        b=d6AU34N/n8hFZDK2fcZapQ/fL0x1iwJrKbfHh9bnyCww2U4BAkKMVbdLZrSfByyULo
         RYwWk50Of8WV7fRce4KIEXHihZx2J/WCRyOd13t3iTugayzmOiQPeBNWp6Xi6s6BuFQr
         tkc2WSQveGUpL/G2hSICBeswLKFOewbsqinLniMHRpkpdQ6bALLGpKQaj2X76TgFaxak
         i/LIBtco9IamIKn2HFZvsidJ+jEGDDOuwQ62K6cVV+jGwrr3muchkn1N9ImX6Q/WchNi
         j+KW35OaXNrEG+DSm4Oihu/AXYWIhH5QCE737q0yNjIAxgSEtBCT/AAVxP5XB0nBIVLc
         Os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261484; x=1761866284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHveIE9Rl1G45KitM9v7ANlIHiL7Ar/r1bbAanaqd+0=;
        b=efhBVOv52zv1IFzNnvY3bwV0+Eq3R1gm/cCKejZgWHCu+LS2nttYViYgS+3d3nzU6J
         CuRTqHY15kmq6Rz4njS6zqLymQb0WWDQxvTp2vnTnoB2q8jA7px/KS1l3yHQTVA0YDWO
         ck0BvW4fH7sBYPlEDtWLBY386ur8Yaf3PeHQTznERlSWjpCe3M7/GFMcmvpLL/7fFshP
         mrm1lQZ+sLsv3c5hIw3b8R+NSbtVhmw6KMIVTFwstW04Wz/FSphsxSeAagGV3fBpVSDW
         d8yV6MpDjICpvK9yNPSSA9V5VpUGcO85SotWF01ZOaKkBXeifpuQWVGGvnVJFaFdxCqe
         /NsA==
X-Forwarded-Encrypted: i=1; AJvYcCVGZzDIOWfSad7TBOMrNRLEIzteW5FrtWOObzlCMI3B6qsiHo7AGhYEg4BBzSy/k4a4YnxggEgBhhIn@vger.kernel.org
X-Gm-Message-State: AOJu0YwhQY1FXe6Z+KrRtik9qkK7mIEvSKn01fcdiUAatAcxkwyy/q9R
	t3cGUF4DwUO1u/m1PoZVdLnXW+dAK+MXtqoUjO0dMwhDCiUb6g6sRZ6JjVE+tvQbg9RCw1tEilJ
	dGTJVtQ==
X-Google-Smtp-Source: AGHT+IHtfkscoVZkLNWPLydZnkiQ/+P/fJOiDgdpD0POy5Es8Ze/V2LxxJguAyXw+CDiW9OJWRj5XY9oX6o=
X-Received: from pjbsd4.prod.google.com ([2002:a17:90b:5144:b0:33b:51fe:1a93])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d89:b0:32e:18f2:7a59
 with SMTP id 98e67ed59e1d1-33fd6502727mr251987a91.11.1761261484431; Thu, 23
 Oct 2025 16:18:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:56 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-8-kuniyu@google.com>
Subject: [PATCH v3 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
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
2.51.1.851.g4ebd6896fd-goog


