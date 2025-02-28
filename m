Return-Path: <linux-sctp+bounces-370-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8CA4967F
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 11:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47A6188CD36
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58825D8E9;
	Fri, 28 Feb 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msaZkFAQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2025D559;
	Fri, 28 Feb 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736925; cv=none; b=uXXOywi08e/ZG/8MxZujS7TtkSaZYD3fIUcglInRMDc7W/Ej7RMahqsFZzikiCp9yNJubxfkUUR4kerHM9Ox2lx2I1O45S5cDtmabfkQbasyT7er1ZsnsC9Mt6YGaBh9SNYglOgkGXylmdxm+IrYSeCwNjo8hT17cqre3ERaejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736925; c=relaxed/simple;
	bh=74yTkQnIWdu4oYvGKAnTJbzZweABw7andTw5FBDDA0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qymdGocGvZMVLjKtiZcAWFyDUyFO+fEtfIMJsAeQ1oXk+GAqOe4gi8bkaxn23I0hXdhKFxPLkrxNrRZUoVBrjkmYT535VnfhRVGSvqjJiVWeNia+CrhZ0kDX9WJzyHWq0AxhHjxQGbXigI31Jsba7zImlohETDYQGhK8eICgjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msaZkFAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2DC4CED6;
	Fri, 28 Feb 2025 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740736925;
	bh=74yTkQnIWdu4oYvGKAnTJbzZweABw7andTw5FBDDA0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msaZkFAQ05HmgjecjY/WhP+zGeTMJp4HL4248ndjfD5M08oukgGTEQRe2T8GuSe9P
	 do77QMYgbdpZ8pMI92WkCf9fCbJ0oL8jD+wlsNPg0kWDqolOXBC7+oNpSrPDyUpd6e
	 KRFUX2HmznwZghMzLRMj17g59luy05CHwSeafwVq5PvoYgYYEEElrPLZ1BDaIe71SA
	 8li0sPLUpJGDCp7OwqLSLYlJEmI7Kn6MGKRc9bUwbbjptxLK+3neswa37wflVRY+Nb
	 S6tqLlT0A6nvUoCDCr1VdUS+DtPJ1lPoJIT0mzXw2NxNlw0rbyGgdCzrcgCLC5sebd
	 0MpXDWDe6mYsA==
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
Subject: [PATCH net-next v2 3/3] mptcp: use sock_kmemdup for address entry
Date: Fri, 28 Feb 2025 18:01:33 +0800
Message-ID: <3e5a307aed213038a87e44ff93b5793229b16279.1740735165.git.tanggeliang@kylinos.cn>
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


