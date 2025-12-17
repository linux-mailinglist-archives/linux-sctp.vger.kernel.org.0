Return-Path: <linux-sctp+bounces-765-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10370CC8201
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Dec 2025 15:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D9130F786B
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Dec 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9335772D;
	Wed, 17 Dec 2025 13:49:24 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C5324712
	for <linux-sctp@vger.kernel.org>; Wed, 17 Dec 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979364; cv=none; b=AAW2jUcxRh1JJUFxAPyQjfGKVVJKn5f/KpJYF5CPwXX0/EwFLr/8FS2O7c7KjlraNxAZbpfs9x6oeJMZ96b2ZnCsOEY/uXaaI8G/3BjoOf3ru6QW71JeHjDSHmk3B1v2MRbPDBSf9gJgFPTr/tkIUD1B5pLTzIY/uTitVANOnNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979364; c=relaxed/simple;
	bh=5Vwwy7hL1uhdo8IHPU9L/moNqREhRtoG6iohSgZOW0c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uvEajfHnbJbABU+Toc3P/zdH/BbpVb5W5dd292WVCawa2ROqxnwl8Phzm1oWzjK9PNXI0V370WszFta9Du33bJJMUwdLyC1s+oUoCxm5p0gLA9C+NF2M7gNLyYwhdKZhvr4ebdlprl4vcKgq7AD1RdPHI9gaKdECv46zJb5L0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-450aff06525so5665669b6e.0
        for <linux-sctp@vger.kernel.org>; Wed, 17 Dec 2025 05:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979361; x=1766584161;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06BWFj+ZWS2ge2WI899eyKp7jOw541WF5gUg5w7TR7U=;
        b=Cb/wuQ34ZuKaBWxCpJguq3pOE3rqkI/77oVFKUPc3/QYrGU1Hd/OIVKoJDvPPOs/u7
         99N3P1zpuhoW2wp4sHXNGapwLxqSeNEmD5JOGpAw5HLXiZ5i/XbVmrlCNZuIAQffnmFN
         tGncxube1w94F908NtQBpxwjpwWkn03NRv/oaA9JMHy/GZswBz1zuNcyE17lf77ZF81e
         T6XE4P4JA+mZFJsWgp2rhofhkchjsi7RTnZJNIXoqnKacKwkqYgIL+NN/2lg08sQ4scI
         6O1Y+esnOfb8I+odbZP3KCrfeEiRegkzThmyFkvgy4BjNzArY8Lo4SN13sRjg+ydgYrM
         9JVA==
X-Forwarded-Encrypted: i=1; AJvYcCUtS3rcxJUz0Vlc/5fwf12CxWSXHpt3m57cqKYU2vUeg3burp+Moj14Wp4gtohQCA2VcjkAc6iTOkQO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mzhTCT+Wgprp8gYK/qVZnN+pXhH+ytC/f46PzDHPlxp30rzH
	heT3PNF3V598UaCoF0Ssmt8e7g7K7Y27NCTUe6ov3T2s5pci3B8fwW4/qZb2XIRKljYIfJ0LCfm
	dbBrscemd/20cXNUmrraIwwlzsaZt2sIC24gfj668/fUY+hPXNDkw/acYPAc=
X-Google-Smtp-Source: AGHT+IHHOhnagbZQhsbBXe1CwfKzGk+4jy262Ev57Vbg8JEw3PW0CcPAidVcZiuzpytWIWykPt/JO9jS19aQdi56YNS7ys3wp/6J
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81ca:b0:659:9a49:8dff with SMTP id
 006d021491bc7-65b4524c904mr7747148eaf.65.1765979361191; Wed, 17 Dec 2025
 05:49:21 -0800 (PST)
Date: Wed, 17 Dec 2025 05:49:21 -0800
In-Reply-To: <682444b7.a00a0220.104b28.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6942b4e1.050a0220.2a2f17.0000.GAE@google.com>
Subject: Re: [syzbot] [sctp?] INFO: rcu detected stall in inet6_rtm_newaddr (3)
From: syzbot <syzbot+3e17d9c9a137bb913b61@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    12b95d29eb97 Add linux-next specific files for 20251217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c69d92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b21d95ed921dffe
dashboard link: https://syzkaller.appspot.com/bug?extid=3e17d9c9a137bb913b61
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10974a2a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1003177c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9fb4b501730c/disk-12b95d29.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc92d98fa8d2/vmlinux-12b95d29.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f25cfc55950a/bzImage-12b95d29.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e17d9c9a137bb913b61@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6135/1:b..l P5964/2:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=14189, q=315 ncpus=2)
task:syz-executor    state:R  running task     stack:19496 pid:5964  tgid:5964  ppid:5963   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:228 [inline]
RIP: 0010:unwind_next_frame+0x214/0x23d0 arch/x86/kernel/unwind_orc.c:510
Code: ef 08 8b 15 6e 32 47 0c 8d 42 ff 44 39 f8 0f 86 78 04 00 00 44 89 f8 4c 8d 2c 85 f8 f5 e0 90 4c 89 e8 48 c1 e8 03 0f b6 04 28 <84> c0 48 89 eb 0f 85 2c 1c 00 00 45 8b 6d 00 44 89 f8 ff c0 48 8d
RSP: 0018:ffffc900043eed38 EFLAGS: 00000a03
RAX: 0000000000000000 RBX: 0000000000000001 RCX: a87a6bbecf920600
RDX: 00000000000a60ce RSI: ffffffff8be075c0 RDI: ffffffff8be07580
RBP: dffffc0000000000 R08: ffffffff81742f85 R09: ffffffff8e13f8a0
R10: ffffc900043eee58 R11: ffffffff81ad9f20 R12: ffffffff8aa4f9ce
R13: ffffffff910789dc R14: ffffc900043eee08 R15: 000000000009a4f9
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3e2/0x700 mm/slub.c:5780
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 sctp_inet6addr_event+0x37f/0x740 net/sctp/ipv6.c:86
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 ipv6_add_addr+0xda9/0x1090 net/ipv6/addrconf.c:1186
 inet6_addr_add+0x3c3/0xce0 net/ipv6/addrconf.c:3050
 inet6_rtm_newaddr+0x93d/0xd20 net/ipv6/addrconf.c:5059
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6958
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
 __sock_sendmsg net/socket.c:752 [inline]
 __sys_sendto+0x3ce/0x540 net/socket.c:2221
 __do_sys_sendto net/socket.c:2228 [inline]
 __se_sys_sendto net/socket.c:2224 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2224
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f30ce1915dc
RSP: 002b:00007ffc905dd720 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f30cef14620 RCX: 00007f30ce1915dc
RDX: 0000000000000040 RSI: 00007f30cef14670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc905dd774 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f30cef14670 R15: 0000000000000000
 </TASK>
task:sed             state:R  running task     stack:24312 pid:6135  tgid:6135  ppid:6134   task_flags:0x400000 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_atomic64_read arch/x86/include/asm/atomic64_64.h:-1 [inline]
RIP: 0010:raw_atomic64_read include/linux/atomic/atomic-arch-fallback.h:2583 [inline]
RIP: 0010:atomic64_read include/linux/atomic/atomic-instrumented.h:1611 [inline]
RIP: 0010:ktime_get_coarse_real_ts64_mg+0x37/0x1e0 kernel/time/timekeeping.c:2445
Code: 53 48 83 ec 10 48 89 fb e8 36 04 12 00 48 c7 c7 c0 12 e1 8d be 08 00 00 00 e8 65 62 78 00 48 8b 05 5e 4d 31 0c 48 89 44 24 08 <4c> 8d 73 08 49 89 dd 49 c1 ed 03 4c 89 f0 48 c1 e8 03 48 89 04 24
RSP: 0018:ffffc900034d75b8 EFLAGS: 00000256
RAX: 000000261054af24 RBX: ffffc900034d7640 RCX: ffffffff81afc55b
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8de112c0
RBP: ffffc900034d76b8 R08: ffffffff8de112c7 R09: 1ffffffff1bc2258
R10: dffffc0000000000 R11: fffffbfff1bc2259 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffc900034d7640 R15: dffffc0000000000
 current_time+0x8e/0x360 fs/inode.c:2343
 atime_needs_update+0x320/0x6d0 fs/inode.c:2206
 pick_link+0x549/0xfa0 fs/namei.c:1983
 step_into_slowpath+0x53b/0x7d0 fs/namei.c:2066
 step_into fs/namei.c:2091 [inline]
 walk_component fs/namei.c:2227 [inline]
 link_path_walk+0xd50/0x18d0 fs/namei.c:2589
 path_openat+0x2b0/0x3840 fs/namei.c:4782
 do_filp_open+0x1fa/0x410 fs/namei.c:4813
 do_sys_openat2+0x121/0x200 fs/open.c:1391
 do_sys_open fs/open.c:1397 [inline]
 __do_sys_openat fs/open.c:1413 [inline]
 __se_sys_openat fs/open.c:1408 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1408
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fabfcd360ba
RSP: 002b:00007fff94803a88 EFLAGS: 00000206 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fff94803b00 RCX: 00007fabfcd360ba
RDX: 0000000000080000 RSI: 00007fff94803b00 RDI: 00000000ffffff9c
RBP: 00007fff94803af0 R08: 00007fff94803cf7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000017
R13: 00007fabfcd0a000 R14: 00007fff94803d10 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10598 jiffies! g14189 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27168 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 4e 2b 00 f3 0f 1e fa fb f4 <e9> 48 ee 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: fcd00228fb9d7700 RBX: ffffffff8197888a RCX: fcd00228fb9d7700
RDX: 0000000000000001 RSI: ffffffff8d99597b RDI: ffffffff8be075e0
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8fa20e70
R13: 1ffff11003adcb70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d2d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fabfca09a10 CR3: 0000000076504000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

