Return-Path: <linux-sctp+bounces-685-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039EC03D23
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BB21A067CB
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710D2D12F3;
	Thu, 23 Oct 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puz/puEs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81F2C21D6
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261485; cv=none; b=JQLpSVjIMZ+daWEzmIyPs0nRZjit3YQnyydQnVLSNy5wExBBewlZTtrP0K++XX5VScJqLnQEK0oKxQ2faoAsjRWJ+MfXIv1UdqWgTqhUBTo3mMf6xNGWSpgKII1VSUgF8Ejgyf45EIYBExhXiJxz91PYqYiIVHNqFAAvbOsOTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261485; c=relaxed/simple;
	bh=1iwt7aXvoiQwwrHf71gxwtQTTN9XGGEKH0es+M4m/0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uguiz8HrCQktUScEDPcGYVHj8aCH+sET5eUKN8FklimaOlRRr+BxWDRFOWJO8b3CQbbp5xZieblFnYaCjN4KSKOtP1TsLK3qh5yfUdmkKtWrFQ4tDIYA83FtpKQj/o3FfaVPKkv359dzR5m6E5x3y8fZ0GGe7H6End+fOATL8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puz/puEs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ce15aaa99so1094418a12.0
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261483; x=1761866283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTcwJFcFrZGq/VYSErxG5yG9npqamnMz+RN/i46Gn0=;
        b=puz/puEswvkD8WjxKni7OR20IY43NNarpMgv9Heg1BjCm9TNC+2trnLAFKe8t7CiEC
         DGmcVRS8+J2ddH2JmTK0UgXVlD9TRnOXewOsdpADbcXPtKoLusBbYMwXh1E+JL+9mSv+
         kJ3C3hTDs7IthgrVDUhGLqFhWdzecXtdNgLqg8x3ODfFj4DiRu+j0mXauhRiGh1ywUO+
         4N/J11R8Oip0+iqrvlBvqTi/39Rm6I+p98Npf8WN4uzaketuEw83Q1AzOxvmRCO5qWd8
         74xuR/TuHywJ4mo0CrF5H4vi6OvcuVeQ8vzLvrAz7zI8313sAjlgKYBQcOF4IXnHeP69
         RRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261483; x=1761866283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTcwJFcFrZGq/VYSErxG5yG9npqamnMz+RN/i46Gn0=;
        b=e8QjnxoOcUQ9I23wUmSueO06DvkxWm+nOA4QyExx0AuFqhE0//aMOHiGIcejfPMTd3
         ZXcqzpD2vM0ACdGN29Bxe8maz2T0+RPoHByxkHB+zFfqvNHo3elSe2SfRzBmvsm7QlRc
         8I3xAPdOoCv8BKgK+wJ+VSyVUUcFBAoFO+tJ2Lb/JEQ1XfZeI9gdC63yaEZp56M0Vdwg
         XHfjpEAxS0LF0WhDS8ur3EjNqmc5RF8aSn4pKivUFyxSCVR0hbf6Gm6eVPbAumRs5krs
         sdk37Y0dVAnHhiR9SJgrnpeezNux7T1aJPyDCcOQwsO3givFf49lbiLmRjvyFwhmR5Cn
         tJXg==
X-Forwarded-Encrypted: i=1; AJvYcCX7bLpsHW7g4iG3cGraufv4Zkj6m5zCRI1pgDsotUbsJujJs2jfFslmerwGglprA/VQUJ878XJtMV0y@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZ0h3skVzMBecSgvZlvl2e0K4atnWKYlBHNeTILP7oL0Y0q7b
	CLVs4fZ6M8fceT/G6fyNPxU/vJjtyCparPS1QQlIykR3NzuFslUCvcm3JaZzbq0YTWAxxYqIaTR
	Js5fkJQ==
X-Google-Smtp-Source: AGHT+IE74OioyAGV55yXxO4l0QlMdNZuJTUm1zFT4p54j2viGgCfjKH71P7ogA1msNFpuOlnI1OnDXZ/Vgs=
X-Received: from pjza10.prod.google.com ([2002:a17:90a:e20a:b0:33b:ba58:40a6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a1:b0:2fc:a1a1:480a
 with SMTP id adf61e73a8af0-334a86070acmr34641213637.38.1761261483017; Thu, 23
 Oct 2025 16:18:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:55 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 6/8] sctp: Remove sctp_pf.create_accept_sk().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_v[46]_create_accept_sk() are no longer used.

Let's remove sctp_pf.create_accept_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sctp/structs.h |  3 ---
 net/sctp/ipv6.c            | 45 --------------------------------------
 net/sctp/protocol.c        | 27 -----------------------
 3 files changed, 75 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 2ae390219efd..3dd304e411d0 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -497,9 +497,6 @@ struct sctp_pf {
 	int  (*bind_verify) (struct sctp_sock *, union sctp_addr *);
 	int  (*send_verify) (struct sctp_sock *, union sctp_addr *);
 	int  (*supported_addrs)(const struct sctp_sock *, __be16 *);
-	struct sock *(*create_accept_sk) (struct sock *sk,
-					  struct sctp_association *asoc,
-					  bool kern);
 	int (*addr_to_user)(struct sctp_sock *sk, union sctp_addr *addr);
 	void (*to_sk_saddr)(union sctp_addr *, struct sock *sk);
 	void (*to_sk_daddr)(union sctp_addr *, struct sock *sk);
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index c0762424a854..069b7e45d8bd 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -777,50 +777,6 @@ static enum sctp_scope sctp_v6_scope(union sctp_addr *addr)
 	return retval;
 }
 
-/* Create and initialize a new sk for the socket to be returned by accept(). */
-static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
-					     struct sctp_association *asoc,
-					     bool kern)
-{
-	struct ipv6_pinfo *newnp, *np = inet6_sk(sk);
-	struct sctp6_sock *newsctp6sk;
-	struct inet_sock *newinet;
-	struct sock *newsk;
-
-	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
-	if (!newsk)
-		return NULL;
-
-	sock_init_data(NULL, newsk);
-
-	sctp_copy_sock(newsk, sk, asoc);
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	newsctp6sk = (struct sctp6_sock *)newsk;
-	newinet = inet_sk(newsk);
-	newinet->pinet6 = &newsctp6sk->inet6;
-	newinet->ipv6_fl_list = NULL;
-
-	sctp_sk(newsk)->v4mapped = sctp_sk(sk)->v4mapped;
-
-	newnp = inet6_sk(newsk);
-
-	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
-	newnp->ipv6_mc_list = NULL;
-	newnp->ipv6_ac_list = NULL;
-
-	sctp_v6_copy_ip_options(sk, newsk);
-
-	/* Initialize sk's sport, dport, rcv_saddr and daddr for getsockname()
-	 * and getpeername().
-	 */
-	sctp_v6_to_sk_daddr(&asoc->peer.primary_addr, newsk);
-
-	newsk->sk_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
-
-	return newsk;
-}
-
 /* Format a sockaddr for return to user space. This makes sure the return is
  * AF_INET or AF_INET6 depending on the SCTP_I_WANT_MAPPED_V4_ADDR option.
  */
@@ -1167,7 +1123,6 @@ static struct sctp_pf sctp_pf_inet6 = {
 	.bind_verify   = sctp_inet6_bind_verify,
 	.send_verify   = sctp_inet6_send_verify,
 	.supported_addrs = sctp_inet6_supported_addrs,
-	.create_accept_sk = sctp_v6_create_accept_sk,
 	.addr_to_user  = sctp_v6_addr_to_user,
 	.to_sk_saddr   = sctp_v6_to_sk_saddr,
 	.to_sk_daddr   = sctp_v6_to_sk_daddr,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ad2722d1ec15..2c3398f75d76 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -580,32 +580,6 @@ static int sctp_v4_is_ce(const struct sk_buff *skb)
 	return INET_ECN_is_ce(ip_hdr(skb)->tos);
 }
 
-/* Create and initialize a new sk for the socket returned by accept(). */
-static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
-					     struct sctp_association *asoc,
-					     bool kern)
-{
-	struct sock *newsk = sk_alloc(sock_net(sk), PF_INET, GFP_KERNEL,
-			sk->sk_prot, kern);
-	struct inet_sock *newinet;
-
-	if (!newsk)
-		return NULL;
-
-	sock_init_data(NULL, newsk);
-
-	sctp_copy_sock(newsk, sk, asoc);
-	sock_reset_flag(newsk, SOCK_ZAPPED);
-
-	sctp_v4_copy_ip_options(sk, newsk);
-
-	newinet = inet_sk(newsk);
-
-	newinet->inet_daddr = asoc->peer.primary_addr.v4.sin_addr.s_addr;
-
-	return newsk;
-}
-
 static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
 	/* No address mapping for V4 sockets */
@@ -1113,7 +1087,6 @@ static struct sctp_pf sctp_pf_inet = {
 	.bind_verify   = sctp_inet_bind_verify,
 	.send_verify   = sctp_inet_send_verify,
 	.supported_addrs = sctp_inet_supported_addrs,
-	.create_accept_sk = sctp_v4_create_accept_sk,
 	.addr_to_user  = sctp_v4_addr_to_user,
 	.to_sk_saddr   = sctp_v4_to_sk_saddr,
 	.to_sk_daddr   = sctp_v4_to_sk_daddr,
-- 
2.51.1.851.g4ebd6896fd-goog


