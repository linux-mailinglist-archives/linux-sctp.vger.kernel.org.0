Return-Path: <linux-sctp+bounces-290-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D9B9F1F86
	for <lists+linux-sctp@lfdr.de>; Sat, 14 Dec 2024 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B629162A72
	for <lists+linux-sctp@lfdr.de>; Sat, 14 Dec 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122E192D8C;
	Sat, 14 Dec 2024 15:03:23 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCD1E502
	for <linux-sctp@vger.kernel.org>; Sat, 14 Dec 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734188603; cv=none; b=EZ5OAkXlM0gBjb0JQMDR1FstSa/KxpkBUTlT2g7cR5egXDAkMz1MKERCqh3mkRQ/kypSZoVetTyiTf21I2sV9rU8Clhlm+tDXf+C20lnksUpP94mTtnQwa7H1zslkMPLyeWyiWMpmVivkABm9SDy/NVKSK0OqC9jvAVXs908TjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734188603; c=relaxed/simple;
	bh=DdLOM1qHzPfeoVfGflR2fskNrH89lMWL9H6iCSrftbY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uyY2qAdNi95Of6AheyTn1bKl4UfxsW3jAfmpLAnJUpa02r6JZJ+hN+aKeoMV4of8FaGhm6WUl77IWZHBza5KxhB9Ppy6sgezCMXGjNAGZVkT2NyfJCRd0XWxlGOaCWVOO5Wozk/N7dWddMAVitGUEp6uH326+psSeQBQReTNJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844e9b9233eso125517439f.2
        for <linux-sctp@vger.kernel.org>; Sat, 14 Dec 2024 07:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734188600; x=1734793400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cp9X4RABKxUCFpngYxzOhWEwmB3ji+aITki0Zr2D5es=;
        b=cn+W2RZASsAn/IAYOq/BvSFS17VLfaCDanGPEEN3sjqYzeVUGHELEbFraMRsHBAVDT
         oGSs+w6Zoj0mAh3QmjHD1b8oHj82IUHH1I0FtUiWKyPa34yxlf6GOTP9DdEcC7hgLbVM
         OTlE3kebgl/8lUzui4/ibM51FsY+vvGX3pv+itj4wMo6CBa4uD7e/FPcWlLK+o44bl0k
         YzZt15Y2ylKrha9ltVr1DA4tuhBONTG4PruSQFZxnq7oNXVvCgFr9U+BDFlBkVMMKwBR
         ocLo1WpIKRNMFG/BElz2SpqrD79Kh1U2wUsgqT131MphNhiC/c2kx2W/TePqnR6p4TZb
         HrMA==
X-Forwarded-Encrypted: i=1; AJvYcCXsT0VkwC3jNjjLVlZ6aWuBa6FZoPVqto+PgB5egGPM565LCXhp3KrJZ7WQLD4ZRM87QL+C7JLncSA5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qK0+IZhawm7BsquMSl3GtJ1kdQwGvvLT9oJxAkFKVLqSK5Ev
	vPaocgEa9vfd599Sc1coeu5mbVi7JfMvjZs/JJr4LEUSlcdVvayv++KbUbCLKeJzq00a6mQzl20
	jEiTDmz3FHkc7y+qa7ImHrCAgfBH2phHSZTk7DHhjthLNaGyaIUB8aq8=
X-Google-Smtp-Source: AGHT+IF9oifGX1EiocYuP6wsmB2qjMZL1qVQ4UWxVJyddk8bmy+bacAicmXcnsdY8cojK3p3VwfR+/hG/GpjO55mWyt4J7iIva2V
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3aff039a554mr77439225ab.13.1734188600419; Sat, 14 Dec 2024
 07:03:20 -0800 (PST)
Date: Sat, 14 Dec 2024 07:03:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675d9e38.050a0220.37aaf.00ca.GAE@google.com>
Subject: [syzbot] [sctp?] possible deadlock in sctp_sock_migrate
From: syzbot <syzbot+95ba71e75926e4a97806@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1617eb30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=95ba71e75926e4a97806
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d137a327f35/disk-7cb1b466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14581a57cb27/vmlinux-7cb1b466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22586b0e9bbc/bzImage-7cb1b466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95ba71e75926e4a97806@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0 Not tainted
------------------------------------------------------
syz.5.1757/14440 is trying to acquire lock:
ffff88807f80c658 (sk_lock-AF_INET/1){+.+.}-{0:0}, at: sctp_sock_migrate+0x987/0x1270 net/sctp/socket.c:9655

but task is already holding lock:
ffff88807f80dfd8 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
ffff88807f80dfd8 (sk_lock-AF_INET){+.+.}-{0:0}, at: sctp_accept+0x90/0x800 net/sctp/socket.c:4863

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3622
       lock_sock include/net/sock.h:1617 [inline]
       sockopt_lock_sock net/core/sock.c:1126 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1117
       do_ip_getsockopt+0x115c/0x2bf0 net/ipv4/ip_sockglue.c:1703
       ip_getsockopt+0x9c/0x1e0 net/ipv4/ip_sockglue.c:1765
       raw_getsockopt+0x4d/0x1e0 net/ipv4/raw.c:865
       do_sock_getsockopt+0x3fe/0x870 net/socket.c:2374
       __sys_getsockopt+0x12f/0x260 net/socket.c:2403
       __do_sys_getsockopt net/socket.c:2410 [inline]
       __se_sys_getsockopt net/socket.c:2407 [inline]
       __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2407
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       smc_vlan_by_tcpsk+0x251/0x620 net/smc/smc_core.c:1898
       __smc_connect+0x466/0x4890 net/smc/af_smc.c:1517
       smc_connect+0x2fc/0x760 net/smc/af_smc.c:1693
       __sys_connect_file+0x13e/0x1a0 net/socket.c:2055
       __sys_connect+0x14f/0x170 net/socket.c:2074
       __do_sys_connect net/socket.c:2080 [inline]
       __se_sys_connect net/socket.c:2077 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2077
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_SMC){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3622
       lock_sock include/net/sock.h:1617 [inline]
       smc_close_non_accepted+0x80/0x200 net/smc/af_smc.c:1832
       smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
       smc_close_active+0xc3c/0x1070 net/smc/smc_close.c:225
       __smc_release+0x634/0x880 net/smc/af_smc.c:277
       smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
       __sock_release+0xb0/0x270 net/socket.c:640
       sock_close+0x1c/0x30 net/socket.c:1408
       __fput+0x3f8/0xb60 fs/file_table.c:450
       task_work_run+0x14e/0x250 kernel/task_work.c:239
       exit_task_work include/linux/task_work.h:43 [inline]
       do_exit+0xadd/0x2d70 kernel/exit.c:938
       do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
       get_signal+0x2576/0x2610 kernel/signal.c:3017
       arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET/1){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3622
       sctp_sock_migrate+0x987/0x1270 net/sctp/socket.c:9655
       sctp_accept+0x654/0x800 net/sctp/socket.c:4899
       inet_accept+0xc4/0x180 net/ipv4/af_inet.c:781
       do_accept+0x337/0x530 net/socket.c:1941
       __sys_accept4_file net/socket.c:1981 [inline]
       __sys_accept4+0xfe/0x1b0 net/socket.c:2010
       __do_sys_accept net/socket.c:2023 [inline]
       __se_sys_accept net/socket.c:2020 [inline]
       __x64_sys_accept+0x74/0xb0 net/socket.c:2020
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET/1 --> rtnl_mutex --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
  lock(sk_lock-AF_INET/1);

 *** DEADLOCK ***

1 lock held by syz.5.1757/14440:
 #0: ffff88807f80dfd8 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88807f80dfd8 (sk_lock-AF_INET){+.+.}-{0:0}, at: sctp_accept+0x90/0x800 net/sctp/socket.c:4863

stack backtrace:
CPU: 1 UID: 0 PID: 14440 Comm: syz.5.1757 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3622
 sctp_sock_migrate+0x987/0x1270 net/sctp/socket.c:9655
 sctp_accept+0x654/0x800 net/sctp/socket.c:4899
 inet_accept+0xc4/0x180 net/ipv4/af_inet.c:781
 do_accept+0x337/0x530 net/socket.c:1941
 __sys_accept4_file net/socket.c:1981 [inline]
 __sys_accept4+0xfe/0x1b0 net/socket.c:2010
 __do_sys_accept net/socket.c:2023 [inline]
 __se_sys_accept net/socket.c:2020 [inline]
 __x64_sys_accept+0x74/0xb0 net/socket.c:2020
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f530297ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f530381f058 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
RAX: ffffffffffffffda RBX: 00007f5302b46080 RCX: 00007f530297ff19
RDX: 0000000020000140 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f53029f3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5302b46080 R15: 00007fff22fccd28
 </TASK>
can: request_module (can-proto-4) failed.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

