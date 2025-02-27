Return-Path: <linux-sctp+bounces-360-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF7A477AD
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6694E3B142B
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C62248AC;
	Thu, 27 Feb 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Josto2Cc"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758302206BE;
	Thu, 27 Feb 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644644; cv=none; b=kIMYGp7zObLegRVO9l6owpd4DAB4HIe9ATvQwBfsr7T6ZfbZ4YHRci0R9dF9Zf2AE90JLEHXKw5X4Pjm6y9JzaYtfotV460qjnhJcplTjurit47DF5Wg/Cqmjc1AdgHSEO8o+QKaqUUlDD56mi+OQhZZOThS00b6sdbCbUicOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644644; c=relaxed/simple;
	bh=aapUC7Cjh7EbD1HOfRjYKYZWhLoYzlc5DB+Vv2Xpk0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3DInoufZZ5hNy2Iole2kiD5oRxudkA7EEJtcFGOJOi4qYqm9knEZg3nHEp+EMVlMJUcmTKP04B1L4urgzO1jz6/U4gHXNOYDEYDC8lJsla5iwFuj8NoH2rHYhsAmDavVRwA+H+yv3b3XMizb0KKx7R97VuK1SW8BzF/TfaZR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Josto2Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71541C4CEDD;
	Thu, 27 Feb 2025 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644644;
	bh=aapUC7Cjh7EbD1HOfRjYKYZWhLoYzlc5DB+Vv2Xpk0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Josto2Ccx1mOLUsWqRO2ydXB/wxqW1InQAS2HEPcaR/tD2+B09TjDSzCXUS4cYBfg
	 Qf+kHQRkR23Tbbo93yI+Njk4FHqOj8CRwHWTbFgZBFtaXbCn3poEv6T4pbihM3Pt/p
	 kwWHJ3ntMa7OIniVfziQqPHaOlyuw0kmuYZUeFzhyxKqRsqYr7XgA8nxykKfuREnez
	 0SVTXlvymeDpWKM8mEAefhWNgtJNF/o6977VSzxiuC57qz+aZa/py4Xh6/gw471/Av
	 rYehC/tipjPcYgbL63auc/HTXAPLe+clsStpzk4PaVMeeoffWVlP0sawGhXjjipkC6
	 ZobG4gei3e9Iw==
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
Subject: [PATCH net-next 2/4] net: use sock_kmemdup for ip_options
Date: Thu, 27 Feb 2025 16:23:24 +0800
Message-ID: <d8152b5b6ef238db8acf24d3f06c0f54bb9c513f.1740643844.git.tanggeliang@kylinos.cn>
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


