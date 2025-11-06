Return-Path: <linux-sctp+bounces-739-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F643C3D9E9
	for <lists+linux-sctp@lfdr.de>; Thu, 06 Nov 2025 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D576D188C5FA
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Nov 2025 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7C33342D;
	Thu,  6 Nov 2025 22:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj6m02xe"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC33074AC
	for <linux-sctp@vger.kernel.org>; Thu,  6 Nov 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468465; cv=none; b=UTIwb+eETgv0jjkMiRz74w38fv4IPr2057MUpZZmje6MswHLhiGX69G04kn1rsMerkd6JIHJ4/miv9SQk9DY1eu093eczACuovF349FyRA+2ZNuZchHPhz+MxCM92T301SDnjUQKmQ+cCORXnHA6DQaj1fb/ZKCUEup7ReZMFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468465; c=relaxed/simple;
	bh=kyqti1pS/iu7iHuIrRG7HhYXvuqmPftlCcRpvSx1U6I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GCVej5xufFlr97gBe45vRpZJbMI62BA4HpPBCjhG1fBk4UkmTb5vcF4cpSeECZe06Mpb41b3RJwO4ryDircF48vnDlIeHZwoXGgLQs0ONmQNRR+A+ekV3pPI9AaZiHb+cABlGRpTyvPkml9+Alo49IZLHsOGpU68dNy8Apvt4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj6m02xe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b95d06db747so104440a12.1
        for <linux-sctp@vger.kernel.org>; Thu, 06 Nov 2025 14:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762468463; x=1763073263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wZSGjMt1Kw8fTsX45N5jWnuu8usaMSJDnzmOrQObllg=;
        b=mj6m02xeppZJeFLKXno33EmBTrlqkCvy62Fl6u2A4ufP9McN6RQl2mPoR+ARMxunhr
         BuvyBFedePEYbcpYTY8+jbYuFDNnhrybuyg7T3GWa7gspsI6+QKVKc3xvLWThvT5uAgu
         nEJR54f0h1sSQ6REU97AlLUsAe+lHaBI9yVC9QSbLu+f0e+6rew2TOaA66FJKKq80/vT
         nr27jo0FzYpQd6SEwlWxqkI2DKLUgMLR5LDl3arjXOq7gPWURPx5Rk9yHjCIQT1TDKyb
         FW8N0I1dkoVVmOZEsgEA5LCSfHaHNT9ns7OjrOLPa59OVWM1zVyzp8x0FDliNWhGLCcO
         xSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468463; x=1763073263;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZSGjMt1Kw8fTsX45N5jWnuu8usaMSJDnzmOrQObllg=;
        b=rr2gfS8JSGqPiab1hfQugDdp8ZgFPw50SYaWeRys88F01E/gTcyZq56C99CFn/iHxP
         mLke68dfXBw4HbThjzvnjkYvkm/a5fbMemdIZe8ZVY8P/4+vjpc2iVAVOyIvGCVzMEaG
         bXZX2X8IaOKyUDIJabtjkA/JcutrZ0PEZwitHqkx1g+/c1Oq+3G1ALrlSqDVLSjA/nCf
         cxDeV+o2qfN4OOM6k+qi16Z0lvGOtjfdirryqxCS/Qg1W3s0ptkJurN/S+s3qomgswwU
         oYOR1H5HFP6Hh9PLjXEwhirW8yeY9xWe/xlxB74zc2rhStySy4Zkhudy/g34t2ofJSlL
         q+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa+5MMnPrMYpOu5ipJkGRFO9ByjSlTN0kHHwizFarBLn+nR8eR3MSO26Nv05QM3gUMC822BcW3Rcl0@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGOoUWQvikTqAe4Y0W7IliCAT4Z6Y5lM/Blh0DnNhxZ0CaGxR
	8GwACzpXAD1h3NvJqX07y7VqB7wvUqRVvNIGSxeqyqcCx26pD2286IFtUjjc2IAbLn3PwUTre8g
	UQxMPNA==
X-Google-Smtp-Source: AGHT+IELFjqiOhYzJtQPJi83GurzhMZjUszfoBRWsW9ystcLY03Me8W0XbtwPWs3W8rSDmDZ3b3wJD+ztbE=
X-Received: from pjtv11.prod.google.com ([2002:a17:90a:c90b:b0:341:4c7:aacc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d8a:b0:32e:72bd:6d5a
 with SMTP id 98e67ed59e1d1-3434a19fcc1mr1662189a91.1.1762468463051; Thu, 06
 Nov 2025 14:34:23 -0800 (PST)
Date: Thu,  6 Nov 2025 22:34:06 +0000
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106223418.1455510-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] sctp: Don't inherit do_auto_asconf in sctp_clone_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	syzbot+ba535cb417f106327741@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported list_del(&sp->auto_asconf_list) corruption
in sctp_destroy_sock().

The repro calls setsockopt(SCTP_AUTO_ASCONF, 1) to a SCTP
listener, calls accept(), and close()s the child socket.

setsockopt(SCTP_AUTO_ASCONF, 1) sets sp->do_auto_asconf
to 1 and links sp->auto_asconf_list to a per-netns list.

Both fields are placed after sp->pd_lobby in struct sctp_sock,
and sctp_copy_descendant() did not copy the fields before the
cited commit.

Also, sctp_clone_sock() did not set them explicitly.

In addition, sctp_auto_asconf_init() is called from
sctp_sock_migrate(), but it initialises the fields only
conditionally.

The two fields relied on __GFP_ZERO added in sk_alloc(),
but sk_clone() does not use it.

Let's clear newsp->do_auto_asconf in sctp_clone_sock().

[0]:
list_del corruption. prev->next should be ffff8880799e9148, but was ffff8880799e8808. (prev=ffff88803347d9f8)
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6008 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 7b 26 71 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 7c ee 92 fd 49 8b 17 48 c7 c7 80 0a bf 8b 48 89 de 4c 89 f9 e8 07 c6 94 fc 90 <0f> 0b 4c 89 f7 e8 4c 26 71 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 4d
RSP: 0018:ffffc90003067ad8 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff8880799e9148 RCX: b056988859ee6e00
RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffc90003067807 R09: 1ffff9200060cf00
R10: dffffc0000000000 R11: fffff5200060cf01 R12: 1ffff1100668fb3f
R13: dffffc0000000000 R14: ffff88803347d9f8 R15: ffff88803347d9f8
FS:  00005555823e5500(0000) GS:ffff88812613e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000480 CR3: 00000000741ce000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:132 [inline]
 __list_del_entry include/linux/list.h:223 [inline]
 list_del include/linux/list.h:237 [inline]
 sctp_destroy_sock+0xb4/0x370 net/sctp/socket.c:5163
 sk_common_release+0x75/0x310 net/core/sock.c:3961
 sctp_close+0x77e/0x900 net/sctp/socket.c:1550
 inet_release+0x144/0x190 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
Reported-by: syzbot+ba535cb417f106327741@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/690d2185.a70a0220.22f260.000e.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sctp/structs.h | 4 ----
 net/sctp/socket.c          | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 5900196d65fd..affee44bd38e 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -228,10 +228,6 @@ struct sctp_sock {
 
 	atomic_t pd_mode;
 
-	/* Fields after this point will be skipped on copies, like on accept
-	 * and peeloff operations
-	 */
-
 	/* Receive to here while partial delivery is in effect. */
 	struct sk_buff_head pd_lobby;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 38d2932acebf..d808096f5ab1 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4885,6 +4885,7 @@ static struct sock *sctp_clone_sock(struct sock *sk,
 	}
 #endif
 
+	newsp->do_auto_asconf = 0;
 	skb_queue_head_init(&newsp->pd_lobby);
 
 	newsp->ep = sctp_endpoint_new(newsk, GFP_KERNEL);
-- 
2.51.2.1041.gc1ab5b90ca-goog


