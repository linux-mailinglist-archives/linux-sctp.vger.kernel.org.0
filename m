Return-Path: <linux-sctp+bounces-369-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5CA4967D
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C918A17312A
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1425D8E0;
	Fri, 28 Feb 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psRWxM52"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26725D8E2;
	Fri, 28 Feb 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736919; cv=none; b=UFqel+powIA6rA1zQBKKfO/rx4IsjHsk4dtaUaLTryQvH3Xm8Jdv4LkaQEbdm1XTrnx/bSBFFCdk3pjEj55ESmbnJS5CKp8z0oy2axAFDS1zllvhopg7OjtnPibcnucvXzTL5W2LQDYV41DQt0OuC3ckS575Z9manIFNq6ZLXcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736919; c=relaxed/simple;
	bh=aapUC7Cjh7EbD1HOfRjYKYZWhLoYzlc5DB+Vv2Xpk0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV+6GK4OVuyrp7aEk53tWLXo4J+sToJEBJKOJLms90OCt7aY6RXfRp39t6LXhw9/z8wvwyMhaei8Oxho3tsDN3371mwdbuQSdr3Ii0lTX9+cllAfZ9pq8LC2fXLGWcWKAAg33EU2Y6MegGk6ADIAsOuB/dbMKuwH56xovwODgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psRWxM52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377EBC4CEE5;
	Fri, 28 Feb 2025 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740736918;
	bh=aapUC7Cjh7EbD1HOfRjYKYZWhLoYzlc5DB+Vv2Xpk0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psRWxM52LXrkkNIPgNcl6ruBNaJ48Y2q2X9vDBU4JP2M53lzsHuR7A3C83ElRAdqw
	 ENnf36/TUaauNrj02Eze62CO/5ntfk4kJZr9lXobgVEqKu43gkNYmufa23bYBnC1Ag
	 uoxQEopFk5nr/SYeT881ETbYTNsXsr855+ZOJ4S4MTa46+rMo+hzHQM8/hoHWe+2/P
	 NQmp95Uz7R9qSZSJjQlpcBnsfbj/17/ie0puOz5Ct7NPWMkGflCAVAZfh01p6d/30t
	 sMnhNHo9PRzSozj0RAai2BuVNrk+zYpTDfFqaHrD73cWaqLEevyicz+Ubtq2DXuvEO
	 ylMAAmX0A0wwQ==
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
Subject: [PATCH net-next v2 2/3] net: use sock_kmemdup for ip_options
Date: Fri, 28 Feb 2025 18:01:32 +0800
Message-ID: <91ae749d66600ec6fb679e0e518fda6acb5c3e6f.1740735165.git.tanggeliang@kylinos.cn>
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

Instead of using sock_kmalloc() to allocate an ip_options and then
immediately duplicate another ip_options to the newly allocated one in
ipv6_dup_options(), mptcp_copy_ip_options() and sctp_v4_copy_ip_options(),
the newly added sock_kmemdup() helper can be used to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv6/exthdrs.c   | 3 +--
 net/mptcp/protocol.c | 7 ++-----
 net/sctp/protocol.c  | 7 ++-----
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 6789623b2b0d..457de0745a33 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1204,10 +1204,9 @@ ipv6_dup_options(struct sock *sk, struct ipv6_txoptions *opt)
 {
 	struct ipv6_txoptions *opt2;
 
-	opt2 = sock_kmalloc(sk, opt->tot_len, GFP_ATOMIC);
+	opt2 = sock_kmemdup(sk, opt, opt->tot_len, GFP_ATOMIC);
 	if (opt2) {
 		long dif = (char *)opt2 - (char *)opt;
-		memcpy(opt2, opt, opt->tot_len);
 		if (opt2->hopopt)
 			*((char **)&opt2->hopopt) += dif;
 		if (opt2->dst0opt)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b61b7dee33b..ec23e65ef0f1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3178,12 +3178,9 @@ static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
 	rcu_read_lock();
 	inet_opt = rcu_dereference(inet->inet_opt);
 	if (inet_opt) {
-		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
+		newopt = sock_kmemdup(newsk, inet_opt, sizeof(*inet_opt) +
 				      inet_opt->opt.optlen, GFP_ATOMIC);
-		if (newopt)
-			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
-			       inet_opt->opt.optlen);
-		else
+		if (!newopt)
 			net_warn_ratelimited("%s: Failed to copy ip options\n", __func__);
 	}
 	RCU_INIT_POINTER(newinet->inet_opt, newopt);
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 29727ed1008e..5407a3922101 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -185,12 +185,9 @@ static void sctp_v4_copy_ip_options(struct sock *sk, struct sock *newsk)
 	rcu_read_lock();
 	inet_opt = rcu_dereference(inet->inet_opt);
 	if (inet_opt) {
-		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
+		newopt = sock_kmemdup(newsk, inet_opt, sizeof(*inet_opt) +
 				      inet_opt->opt.optlen, GFP_ATOMIC);
-		if (newopt)
-			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
-			       inet_opt->opt.optlen);
-		else
+		if (!newopt)
 			pr_err("%s: Failed to copy ip options\n", __func__);
 	}
 	RCU_INIT_POINTER(newinet->inet_opt, newopt);
-- 
2.43.0


