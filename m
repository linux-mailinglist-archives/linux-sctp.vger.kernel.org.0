Return-Path: <linux-sctp+bounces-359-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5961A477B1
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05934170737
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3F22371B;
	Thu, 27 Feb 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY9kQx1g"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E504223326;
	Thu, 27 Feb 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644640; cv=none; b=KJPG1elKBkUbun6f779YXJeHl28CklLkhTkzy54Rwzp++PtGre3xyzjBw913jw86U6V/VP/WHF0/Dxo7BSkIEKquIiEhRHhQk/+ZKAV57nRj/FfIdl3YBZukQRcRkVycXxU80DjLWW4rmmiK7Txr7xZKuf/oY0aucReVGDmDSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644640; c=relaxed/simple;
	bh=1mAnaS2dCdCIvjEob0nJo7BL3D3i6pJbL+2pXGgKftM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bANHF7DrU7ZI7KfRQSEVL2hRA8WdbZG+1CG2mO61MtryzamX93KmTpntFeLuVL35brpi97zzyQLZX+Vy9ypvSVmwP66BNGIJOf9z3TLgG+58iMYpLJQMv1rZa3PeWuHIH5qGE+CyBOOLwckGrGtPpIXU3Y9iC388tqTyFmm6eVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY9kQx1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4620C4CEE7;
	Thu, 27 Feb 2025 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644640;
	bh=1mAnaS2dCdCIvjEob0nJo7BL3D3i6pJbL+2pXGgKftM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZY9kQx1gSgSg6MZiuIwNNK8JeQ8RJU9nF+Dz+K+DdzCBK5RpBVYb/cb8xR0DOzf7r
	 l/wMdoGlajmK2I6m4eULtSmPJhzzsoWngd8NfD9Ffk3w9jW13rxIKcQxmAZFwPusro
	 CCrqUzlQHhBuHLDoMMVGIgMoEzGx6C2vp+6Wn9tzTuhxYJ5T1805r+PUNfxkuWAKIw
	 1lK5iQ0dmgtEcB/AA7HR5M1CDsqSqrllaWHeXE5ek5YWGLemAmlSlJlSRkP16SzE6b
	 ft4rTuy7Crjl345/rA+GZxHIskIwujh1ZPJLNQ6ppBbwKJIDpp6HQiZ2gsV/RSp6cG
	 sMi7qajmtpz0g==
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
Subject: [PATCH net-next 1/4] sock: add sock_kmemdup helper
Date: Thu, 27 Feb 2025 16:23:23 +0800
Message-ID: <a26c04cba801be45ce01a41b6a14a871246177c5.1740643844.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740643844.git.tanggeliang@kylinos.cn>
References: <cover.1740643844.git.tanggeliang@kylinos.cn>
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
 net/core/sock.c    | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index efc031163c33..1416c32c4695 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1796,6 +1796,8 @@ static inline struct sk_buff *sock_alloc_send_skb(struct sock *sk,
 }
 
 void *sock_kmalloc(struct sock *sk, int size, gfp_t priority);
+void *sock_kmemdup(struct sock *sk, const void *src,
+		   int size, gfp_t priority);
 void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 5ac445f8244b..95e81d24f4cc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2819,6 +2819,21 @@ void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
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
+
 /* Free an option memory block. Note, we actually want the inline
  * here as this allows gcc to detect the nullify and fold away the
  * condition entirely.
-- 
2.43.0


