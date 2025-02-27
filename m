Return-Path: <linux-sctp+bounces-361-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4EEA477B4
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7E2170DD4
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658982236FF;
	Thu, 27 Feb 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWCGc4ME"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31D222574;
	Thu, 27 Feb 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644649; cv=none; b=ZlFJ1ou9dSOkuiMfLPxAgbUOG3zrrWbG0c2d/NyxdteTi1pP7S7D08zniuPfhR8/Khr86HoNQzVNTZq/yKjFz7+IH2wG8vni1nu4QxRmQG1DjsTNPwNvUC0UEiKkMaeQfX4sOZjO3s7VVO1Y9rDyoMGp30tnsopiWCV0XAtRQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644649; c=relaxed/simple;
	bh=74yTkQnIWdu4oYvGKAnTJbzZweABw7andTw5FBDDA0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTuiL5G9/wwrx5lrq8KSarZvkfo9sjdRphWATO0itRSNonubW/j+Jaiq3MkkEcXKxmyyFdia/KD5WPgEGM2fxyG4IHPHsUmqFzjWcMli07ykPCRNkx/42NF69sRYfRhyodTNj/HW/10Muc/0y9J+5rPOw0rRZOcFBfVF94q4JXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWCGc4ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB090C4CEEB;
	Thu, 27 Feb 2025 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644648;
	bh=74yTkQnIWdu4oYvGKAnTJbzZweABw7andTw5FBDDA0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWCGc4MEuW3QSbpqvjWpyIRZSLCIgRpIcmUbkVcTLrvHb79RnGutD4NvJibMJWYMY
	 hmu0VeZkwjMFQMYj5Jx7TAmkDpRBqphMueNXW05BJOsO6gCgxvet2l+cShtP788zDr
	 otvIaa0xJ3VWfR6y8/QGymAUPAVP2JUPIMdrSIhiKAQLrQRYoGXF0OMw/C8q3VYpyJ
	 MsytYk/r+mvx4aauv3vkSpvHTELZnwf3XbKzohE9IlsVcRz7nZ9BJSwGWHtGtVNV2S
	 BR4YnFGjMamT3id6H1NNgQSyLzMtiAUvzR/oostbCAzUUohhmL5okmQn0onp8VZkGF
	 1J7/udNDMQhwQ==
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
Subject: [PATCH net-next 3/4] mptcp: use sock_kmemdup for address entry
Date: Thu, 27 Feb 2025 16:23:25 +0800
Message-ID: <35aeccb53a34ac50abe54dcb4e4cbaec66e3ae11.1740643844.git.tanggeliang@kylinos.cn>
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

Instead of using sock_kmalloc() to allocate an address
entry "e" and then immediately duplicate the input "entry"
to it, the newly added sock_kmemdup() helper can be used in
mptcp_userspace_pm_append_new_local_addr() to simplify the code.

More importantly, the code "*e = *entry;" that assigns "entry"
to "e" is not easy to implemented in BPF if we use the same code
to implement an append_new_local_addr() helper of a BFP path
manager. This patch avoids this type of memory assignment
operation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6bf6a20ef7f3..7e7d01bef5d4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -71,13 +71,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
+		e = sock_kmemdup(sk, entry, sizeof(*entry), GFP_ATOMIC);
 		if (!e) {
 			ret = -ENOMEM;
 			goto append_err;
 		}
 
-		*e = *entry;
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
-- 
2.43.0


