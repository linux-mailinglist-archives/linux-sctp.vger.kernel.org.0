Return-Path: <linux-sctp+bounces-184-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239693FE33
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jul 2024 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C8B1F212F6
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jul 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F82185E7A;
	Mon, 29 Jul 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LE/JwKL0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC984D34;
	Mon, 29 Jul 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281185; cv=none; b=Y1uOHHUPLjMc6M5QP/fDmf7flUGCBSvQmwE7G2ZxGwQYhNcZlLHNWrXArR+GPQflWGo8LzLvO4hYlbOikBkwW32H8joAiaB3tRjbjFTqcLSbMJpqMk9VHHXzGr3QYEckZ8MhuGdPj1MNYTqukUzKiKQgYb709u7K44Xe20Hq87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281185; c=relaxed/simple;
	bh=40CpBLsrRcqEeZpGBJ6PXLWui/8NGY3atdMJB0gZ2sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pfjxxpf83+SER+fCk6jSPXlT52FIhAyhY+2AamcWgioWI0CZq3o8o0MKNZSbfJCW9wVRttzQQKTjfInrTIFr0BvqcX67rnme+X1LBr0BMUbyRHJMBtw8uTk2c/lBHdk6TGyopv/N51uwtqPefTzz+kyaJUQGoDWQ9Z4EHdisPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LE/JwKL0; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722281184; x=1753817184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rsJ2G3hG4dDVZ20C3+7khJcr4H1rVFdQvAZgj6p3KCI=;
  b=LE/JwKL0Uu2WOLeR5pBanMJuQCll2MJ+jn/8S6QwxAmLXsH5XdQnQE/e
   m1Jp1P6mdzEfhrr+t1v3piw10d5BeWcjBl+tmkF5pEA+YuW9dGybqYrt6
   pssRt5tS5lBLTFToxknHKQuAxFvvfu/ee+dghsh+xbZwpP4mG7EREsd2G
   o=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="359415523"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 19:26:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:17639]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.45:2525] with esmtp (Farcaster)
 id e89ed7a4-cf46-4219-a568-b8261472f041; Mon, 29 Jul 2024 19:26:16 +0000 (UTC)
X-Farcaster-Flow-ID: e89ed7a4-cf46-4219-a568-b8261472f041
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 19:26:15 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 19:26:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
	<lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
	<syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Mon, 29 Jul 2024 12:26:01 -0700
Message-ID: <20240729192601.97316-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a null-ptr-deref while accessing sk2->sk_reuseport_cb
in reuseport_add_sock(). [0]

The repro first creates a listener with SO_REUSEPORT.  Then, it creates
another listener on the same port and concurrently close()s the first
listener.

The second listen() calls reuseport_add_sock() with the first listener as
sk2, where sk2 is not expected to be cleared concurrently, but the close()
does clear it.

The assumption in reuseport_add_sock() is correct for TCP/UDP, which
serialises the changes to sk_reuseport_cb by holding the hash bucket
lock.

However, __sctp_hash_endpoint() does not hold sctp_hashbucket.lock before
calling reuseport_add_sock() , nor __sctp_unhash_endpoint() does before
reuseport_detach_sock().

Let's fix it by acquiring the bucket lock before reuseport_add_sock() and
reuseport_detach_sock().

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 10230 Comm: syz-executor119 Not tainted 6.10.0-syzkaller-12585-g301927d2d2eb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:reuseport_add_sock+0x27e/0x5e0 net/core/sock_reuseport.c:350
Code: 00 0f b7 5d 00 bf 01 00 00 00 89 de e8 1b a4 ff f7 83 fb 01 0f 85 a3 01 00 00 e8 6d a0 ff f7 49 8d 7e 12 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 4b 02 00 00 41 0f b7 5e 12 49 8d 7e 14
RSP: 0018:ffffc9000b947c98 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8880252ddf98 RCX: ffff888079478000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000012
RBP: 0000000000000001 R08: ffffffff8993e18d R09: 1ffffffff1fef385
R10: dffffc0000000000 R11: fffffbfff1fef386 R12: ffff8880252ddac0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f24e45b96c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcced5f7b8 CR3: 00000000241be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __sctp_hash_endpoint net/sctp/input.c:762 [inline]
 sctp_hash_endpoint+0x52a/0x600 net/sctp/input.c:790
 sctp_listen_start net/sctp/socket.c:8570 [inline]
 sctp_inet_listen+0x767/0xa20 net/sctp/socket.c:8625
 __sys_listen_socket net/socket.c:1883 [inline]
 __sys_listen+0x1b7/0x230 net/socket.c:1894
 __do_sys_listen net/socket.c:1902 [inline]
 __se_sys_listen net/socket.c:1900 [inline]
 __x64_sys_listen+0x5a/0x70 net/socket.c:1900
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24e46039b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f24e45b9228 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 00007f24e468e428 RCX: 00007f24e46039b9
RDX: 00007f24e46039b9 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f24e468e420 R08: 00007f24e45b96c0 R09: 00007f24e45b96c0
R10: 00007f24e45b96c0 R11: 0000000000000246 R12: 00007f24e468e42c
R13: 00007f24e465a5dc R14: 0020000000000001 R15: 00007ffcced5f7d8
 </TASK>
Modules linked in:

Fixes: 6ba845740267 ("sctp: process sk_reuseport in sctp_get_port_local")
Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e6979a5d2f10ecb700e4
Tested-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/sctp/input.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 17fcaa9b0df9..a8a254a5008e 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -735,15 +735,19 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	struct sock *sk = ep->base.sk;
 	struct net *net = sock_net(sk);
 	struct sctp_hashbucket *head;
+	int err = 0;
 
 	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
 	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (sk->sk_reuseport) {
 		bool any = sctp_is_ep_boundall(sk);
 		struct sctp_endpoint *ep2;
 		struct list_head *list;
-		int cnt = 0, err = 1;
+		int cnt = 0;
+
+		err = 1;
 
 		list_for_each(list, &ep->base.bind_addr.address_list)
 			cnt++;
@@ -761,24 +765,24 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 			if (!err) {
 				err = reuseport_add_sock(sk, sk2, any);
 				if (err)
-					return err;
+					goto out;
 				break;
 			} else if (err < 0) {
-				return err;
+				goto out;
 			}
 		}
 
 		if (err) {
 			err = reuseport_alloc(sk, any);
 			if (err)
-				return err;
+				goto out;
 		}
 	}
 
-	write_lock(&head->lock);
 	hlist_add_head(&ep->node, &head->chain);
+out:
 	write_unlock(&head->lock);
-	return 0;
+	return err;
 }
 
 /* Add an endpoint to the hash. Local BH-safe. */
@@ -803,10 +807,9 @@ static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
 
 	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
-
-	write_lock(&head->lock);
 	hlist_del_init(&ep->node);
 	write_unlock(&head->lock);
 }
-- 
2.30.2


