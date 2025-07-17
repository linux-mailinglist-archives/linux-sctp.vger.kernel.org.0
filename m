Return-Path: <linux-sctp+bounces-584-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F1B09477
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Jul 2025 20:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130F4169172
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Jul 2025 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D22F7CEC;
	Thu, 17 Jul 2025 18:52:32 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4A2F7D08
	for <linux-sctp@vger.kernel.org>; Thu, 17 Jul 2025 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778352; cv=none; b=bkq6JoL2zfC126BX//CKUzgaP4jkJclmhtKNZ8n+aKzW5JepqeCkrvaeTFetHusP/gIxUgm8JLXUbcROf22aT2kmNGq5xYxLvsuX6tyTm2be4AHI0XhXxz/ONLM/jRGyjMElwlPttboAsTsT3H0fZLvQ9BkMK/BINDlF/JQ+J0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778352; c=relaxed/simple;
	bh=xWoSQ+gngFF2TOSecNJDyH5ybGum8FZowTvwKeBUlXY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j4nQAGyXtw0ijaHbMZKCSZcNcf2N9iG7DIL3cedS7f7G4AkjBqoqy/upHSA3MXSMvleXAz5yy/nqUsAJ63GfTQ9bfHO8lyXOY/n4JOhF2AO76VJDfZyXWyTzOy6BE/VcUSNTZvJx9TldlbH8fO0fF4ANqIpS73K2zw+b9wWxcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e1618f03c9so14050375ab.2
        for <linux-sctp@vger.kernel.org>; Thu, 17 Jul 2025 11:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752778350; x=1753383150;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0a5KLpmNdbac5z+OdmlpJ82pz3wF32WpMWj2w1Vd7No=;
        b=LxWP7ZjlHA2u/55aYkzodqd481c2X2W2MvSNzhDifDAdXYYPk7JI443qohLK3ATv1X
         EMgu5Q66wxwScTnvAPiTEX+VpT5y3EtCJyDJV/KC6xHWtu3IvW6ThEJjatyulcyJ7oM0
         tcnONkuI3+Lx2WI8BtUspY8Unmeie8J8nqzv/ePXwasYynZIkz3TvsrDmoyGi+4KCD8B
         pyXmJ7QT7G38/2V9LJxdzlsN/ZRW5x7tVzND5qD/8SOKmeS8KTeKzRL7WZbl7Uz7GbEv
         utPewygsMUHDmXQ3Z1Esf1xk/yvn1xeo4p+FenY6gzEMkMrU/pUe8zh3zlOkRGEypin9
         ZeLA==
X-Forwarded-Encrypted: i=1; AJvYcCWsZjdJiRJ8MDRf38RnyzVHc6oPrny9LFINGmcTuy+vsElUfE3OXCnCa22se2xFAxzmeREUHcIOcbrc@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8D1VnGKyNlc0+hPWji2bjVcdUJGRk98MblQaFmIzy0m9I62d
	ztCNYnHvKfUDyJHzHf1wVanuej0m9iI3h9h1RiwUs+QnfWdDapQJsc9NegjQi0PTF8yrSa3JTAK
	no6KYbO+dNM1fAtG3u7/pzq5Ov97PIr86WiaNUQe5sI9wojOEPK/c1bmjQto=
X-Google-Smtp-Source: AGHT+IGHzl0aKRabmWO10kMpxI9v+rAHfaLHyRnAtNkNDSDsYAVIjbEPSCn0AH3qRkdiBrY/7A3nV1dYNHJNP2xeUHgNQ9yiQQLW
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e89:b0:3df:3afa:28d6 with SMTP id
 e9e14a558f8ab-3e282d58d74mr57187145ab.2.1752778349820; Thu, 17 Jul 2025
 11:52:29 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:52:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6879466d.a00a0220.3af5df.0022.GAE@google.com>
Subject: [syzbot] [netfilter?] [sctp?] BUG: assuming non migratable context at ./include/linux/filter.h:LINE
From: syzbot <syzbot+92c5daf9a23f04ccfc99@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, dxu@dxuuu.xyz, edumazet@google.com, fw@strlen.de, 
	horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	llvm@lists.linux.dev, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	nathan@kernel.org, ncardwell@google.com, ndesaulniers@google.com, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    155a3c003e55 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161a27d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ae63460f9c371aa
dashboard link: https://syzkaller.appspot.com/bug?extid=92c5daf9a23f04ccfc99
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a9d18c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f58382580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dcbbac96d733/disk-155a3c00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eec589968921/vmlinux-155a3c00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80e95076a622/bzImage-155a3c00.xz

The issue was bisected to:

commit 91721c2d02d3a0141df8a4787c7079b89b0d0607
Author: Daniel Xu <dxu@dxuuu.xyz>
Date:   Fri Jul 21 20:22:46 2023 +0000

    netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c1558c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c1558c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c1558c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92c5daf9a23f04ccfc99@syzkaller.appspotmail.com
Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")

BUG: assuming non migratable context at ./include/linux/filter.h:703
in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 5829, name: sshd-session
3 locks held by sshd-session/5829:
 #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x20/0x50 net/ipv4/tcp.c:1395
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x69/0x26c0 net/ipv4/ip_output.c:470
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: nf_hook+0xb2/0x680 include/linux/netfilter.h:241
CPU: 0 UID: 0 PID: 5829 Comm: sshd-session Not tainted 6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 __cant_migrate kernel/sched/core.c:8860 [inline]
 __cant_migrate+0x1c7/0x250 kernel/sched/core.c:8834
 __bpf_prog_run include/linux/filter.h:703 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 nf_hook_run_bpf+0x83/0x1e0 net/netfilter/nf_bpf_link.c:20
 nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
 nf_hook_slow+0xbb/0x200 net/netfilter/core.c:623
 nf_hook+0x370/0x680 include/linux/netfilter.h:272
 NF_HOOK_COND include/linux/netfilter.h:305 [inline]
 ip_output+0x1bc/0x2a0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:459 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x1d7d/0x26c0 net/ipv4/ip_output.c:527
 __tcp_transmit_skb+0x2686/0x3e90 net/ipv4/tcp_output.c:1479
 tcp_transmit_skb net/ipv4/tcp_output.c:1497 [inline]
 tcp_write_xmit+0x1274/0x84e0 net/ipv4/tcp_output.c:2838
 __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3021
 tcp_push+0x225/0x700 net/ipv4/tcp.c:759
 tcp_sendmsg_locked+0x1870/0x42b0 net/ipv4/tcp.c:1359
 tcp_sendmsg+0x2e/0x50 net/ipv4/tcp.c:1396
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x4aa/0x5b0 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c7/0x1150 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7d365d407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

