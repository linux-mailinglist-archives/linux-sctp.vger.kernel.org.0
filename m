Return-Path: <linux-sctp+bounces-368-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24DAA49678
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 11:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C0164B2E
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580825D53E;
	Fri, 28 Feb 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkEgypt5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1D2561DE;
	Fri, 28 Feb 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736913; cv=none; b=ahJ8RGmi6TdYfSNWy+C4+qDaMlH+ELQvoHtFxgsu9MBvGNSA13dczhqayuDYg13GiNhbUZaLKRqLNrBFYacdbrwEP6jT4eeYHmaVylB/ZvrZIk0Xf+D/5gGmcCrCl5pNFegp2KsUOURM9AbZ+i0e2puntf+AxrTgwGrR/uETx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736913; c=relaxed/simple;
	bh=DmbSIkOjD/LlT1o10zy3tU/eSic7bXpF/O0NJUnRgck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0L2pLahhDE8uQVfL+Fg8CWbaXgGe9fBczJjK78EXZgoqTkiSGjpxFwz6iW5Vhvh9py8OhF1CA/CEjY+vwNcWtyWRq0FQmPwQbgb5DFVik2/TlBx7694SA1QRQ9S6N1mYyGvNfo0p8KufkLGQ+W+hLglblFJwqXnEjslFytdPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkEgypt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117FEC4CED6;
	Fri, 28 Feb 2025 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740736912;
	bh=DmbSIkOjD/LlT1o10zy3tU/eSic7bXpF/O0NJUnRgck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkEgypt5q6eaPbWIL3ULLUb2XSQIK7g81eBZd/gneEcaBXRaREyRRo3UbE2yxegLA
	 Jeu6NPsuNUdJjZvMdPmvEIRPl3HH8IE0/T47Hx8tZv96E64WBd7ofMLXROY3cYVIVo
	 e8llWtCRC+evYW4SAnrdfuVdKJjG1wFVmeq06oTIxf8AdAmDGzY+5CxYHbJhEj0hDM
	 T9fJqGgv8hOmx4vcGeI8s1HX+30cLPE2Ebwx5D6QtyYl5VYHv9hkr9OuMiGpjDBcLx
	 iP9Lb7qMFIm549oErvOIxq4NUEpSb32S69/6Var76Dqz+vC972KsEdQFyehuhHafk7
	 CZgIPy/wVVwcw==
From: Geliang Tang <geliang@kernel.org>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-sctp@vger.kernel.org
Subject: [PATCH net-next v2 1/3] sock: add sock_kmemdup helper
Date: Fri, 28 Feb 2025 18:01:31 +0800
Message-ID: <f828077394c7d1f3560123497348b438c875b510.1740735165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740735165.git.tanggeliang@kylinos.cn>
References: <cover.1740735165.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds the sock version of kmemdup() helper, named sock_kmemdup(),
to duplicate the input "src" memory block using the socket's option memory
buffer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index e771d99f81b0..8daf1b3b12c6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1797,6 +1797,8 @@ static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
 }
 
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 23bce41f7f1f..a0598518ce89 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2836,6 +2836,22 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
 }
 EXPORT_SYMBOL(sock_kmalloc);
 
+/*
+ * Duplicate the input "src" memory block using the socket's
+ * option memory buffer.
+ */
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority)
+{
+	void *mem;
+
+	mem = sock_kmalloc(sk, size, priority);
+	if (mem)
+		memcpy(mem, src, size);
+	return mem;
+}
+EXPORT_SYMBOL(sock_kmemdup);
+
 /* Free an option memory block. Note, we actually want the inline
  * here as this allows gcc to detect the nullify and fold away the
  * condition entirely.
-- 
2.43.0


