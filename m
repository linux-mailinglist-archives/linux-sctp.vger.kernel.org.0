Return-Path: <linux-sctp+bounces-362-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97AA477B2
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7EE3B195C
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8E224894;
	Thu, 27 Feb 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcyepKSc"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41CD222574;
	Thu, 27 Feb 2025 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644654; cv=none; b=Jwr6J/cPmJ8plAQwnRpTJdEr5cWwZnXqdyTB7wF47oC1j2R9gphv8qsII6I10z1aziyILqLS570Fb71d7klV+y270REywhJY9xQ6P0R8KbLIX/IfgzmEO/ErqBdOhsPmDiQrpwXNb3SjV+ifEm9yTmZDzkvIbY7nbuzcaC/qiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644654; c=relaxed/simple;
	bh=0GwyfvPZJn3bBvAUj0HXY0BKgt3S89HLTvK3DfNGxcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTuALEZjGabE2zIHdTw+V1OhjoXOu94MrCDbiAQgWi1ITAHrMboy1nPlMo+6myT9SSkXJnlwGYdBLvM46QHkpxjMheM4Jl+JRIt5It8YpaIwYn8rXA5/w+Rkpvwi8kfNKn5gjoh0AsLryM8o/TYSU4FEbiQtr63ilTcSirguh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcyepKSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36156C4CEDD;
	Thu, 27 Feb 2025 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644653;
	bh=0GwyfvPZJn3bBvAUj0HXY0BKgt3S89HLTvK3DfNGxcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcyepKScv7I2bZPHYPxlwHmowLkAnN16Fj8SK3XrS5Me9awpoqjYNXNQDvx4wBFqV
	 Gp0C2SaH3ekRyfWLDkYv2/iXzdBdlvGwn8o+HPlp0ijQJEMOx2/irJUWm/D4qtCR1B
	 1OkzG+8zABhUZtKroj1QL5IIkC84fYvx6cYoHBDBQFmwg7VV8tuIO7fGZQxg+z1Fwu
	 Z2HUc6/m4on+Fn6aiA4ph1LWTSQ3zdz9SIzPOPUB4BJah48NLiThtOcz4haRc1KMjD
	 rWi4BWIB1T/G7Iu8lLOWriq14JOh5SkNsAWoVLAeaUJ7B0mtDGRD1UN7kAqHbZgdTO
	 TKuanVKvAbgww==
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
Subject: [PATCH net-next 4/4] net/tcp_ao: use sock_kmemdup for tcp_ao_key
Date: Thu, 27 Feb 2025 16:23:26 +0800
Message-ID: <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
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

Instead of using sock_kmalloc() to allocate a tcp_ao_key "new_key" and
then immediately duplicate the input "key" to it in tcp_ao_copy_key(),
the newly added sock_kmemdup() helper can be used to simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp_ao.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bbb8d5f0eae7..d21412d469cc 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -246,12 +246,11 @@ static struct tcp_ao_key *tcp_ao_copy_key(struct sock *sk,
 {
 	struct tcp_ao_key *new_key;
 
-	new_key = sock_kmalloc(sk, tcp_ao_sizeof_key(key),
+	new_key = sock_kmemdup(sk, key, tcp_ao_sizeof_key(key),
 			       GFP_ATOMIC);
 	if (!new_key)
 		return NULL;
 
-	*new_key = *key;
 	INIT_HLIST_NODE(&new_key->node);
 	tcp_sigpool_get(new_key->tcp_sigpool_id);
 	atomic64_set(&new_key->pkt_good, 0);
-- 
2.43.0


