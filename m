Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853EB3BBCDE
	for <lists+linux-sctp@lfdr.de>; Mon,  5 Jul 2021 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhGEMhB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 5 Jul 2021 08:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGEMhB (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 5 Jul 2021 08:37:01 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47898C061574;
        Mon,  5 Jul 2021 05:34:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625488460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZS1PIRR4StBHGqOWHZpkQSqA1W4Q+CJuJDRoD0TUOxg=;
        b=u+YMoWEi9BuF/P1VE4A1Gc+A4F+8+Wo0lN6hjZrX5dRQtCY1c8ftwKU9hbyPIbqkKad6G2
        AnCjdzp37MSZUK6oG8nb98cNsfpptSgNgIOmuRdpynRZbwCuJ34XrZfuLqotROc5ESINub
        St72Q0zTDlNedk4Wo18jbOOa+E6e8io=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     davem@davemloft.net, kuba@kernel.org, vyasevich@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        pabeni@redhat.com, mathew.j.martineau@linux.intel.com,
        edumazet@google.com, aahringo@redhat.com, linmiaohe@huawei.com,
        fw@strlen.de, xiangxia.m.yue@gmail.com, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] net: Fix called net_enable_timestamp() in sctp_copy_sock()
Date:   Mon,  5 Jul 2021 20:34:05 +0800
Message-Id: <20210705123405.6089-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Add sock_needs_netstamp() judgment condition when need to call
net_enable_timestamp().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 2 +-
 net/sctp/socket.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8bdd80027ffb..e36563576758 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2757,6 +2757,7 @@ int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
 int sock_set_timestamping(struct sock *sk, int optname, int val);
 
+bool sock_needs_netstamp(const struct sock *sk);
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index ba1c0f75cd45..ce6ec9f8ac7c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -429,7 +429,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	return 0;
 }
 
-static bool sock_needs_netstamp(const struct sock *sk)
+bool sock_needs_netstamp(const struct sock *sk)
 {
 	switch (sk->sk_family) {
 	case AF_UNSPEC:
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e64e01f61b11..30d90735beb0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9449,7 +9449,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newinet->mc_index = 0;
 	newinet->mc_list = NULL;
 
-	if (newsk->sk_flags & SK_FLAGS_TIMESTAMP)
+	if (sock_needs_netstamp(newsk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
 		net_enable_timestamp();
 
 	/* Set newsk security attributes from original sk and connection
-- 
2.32.0

