Return-Path: <linux-sctp+bounces-512-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC93AB6420
	for <lists+linux-sctp@lfdr.de>; Wed, 14 May 2025 09:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C918317E374
	for <lists+linux-sctp@lfdr.de>; Wed, 14 May 2025 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492871FCFFC;
	Wed, 14 May 2025 07:22:34 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5F21B9C5
	for <linux-sctp@vger.kernel.org>; Wed, 14 May 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747207354; cv=none; b=Z0PC4rFWUpcKNbWlFPrjJmCdL2xPl3fHwvpjH3PSrm6d+CzGM734HEO+TM61AHitNhS8uwD09nUoJiB59BW5/t/nIrUhE0Y+M5UoZmCk0/F1HB4HZ+g80EIP0xt5odD2nndMWu4vt0N1PibAQTLEud5IPRU+kkfZ4ZFrqCrJHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747207354; c=relaxed/simple;
	bh=3K8+UROH2lad+1F58LcMgymw21A293jB5IQv7CVpJVU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SL6pkrZXEPu/BpmLJdoxC/ZfO/B/PAeOpdZ3tys+HLlfk8Y/NoSWu8xq0XpHQw53sAXkNMOwmR9ehl8J4OhoTzB0eBbfsr8hLIeKlHyW966agrOcw+B6pBli08pSgDBNc8uLlARSE5+MLk4LnpsumCpfN9ntl7H738wpSha3w+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86176e300fdso587088839f.1
        for <linux-sctp@vger.kernel.org>; Wed, 14 May 2025 00:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747207351; x=1747812151;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iE5bcm8mdpELr1AiyyL6gVdV++CEoXGYC5kY2cjeD8o=;
        b=X54DAriqbn/cM7gawhJes4yFbGII5BPeQlAYkewwFcSofkMd6SBsDywNHiTeVYeRMV
         3qzcbkB4qEzuEGM2ix0Z8udpX5C3o9FDnQWbB3wgGl7vkXqtSqhfXf54RT0GHjAXH1CD
         zOuddED3qgGw2yl2uTccgGu+exr1GRWw2Us3j3Erql9BqmPv89LX92f51Ma85Xe8CHsU
         5wxsWFc+xVEParEm7gEmHpEbJ0szAHtJPa22/Hg+aBVEz1PWrwEziB/FtUjhUVcniZq5
         fcwHIMAhEh8IjPTF/+Tigm309QoxaO9/UHXjnnHcugBG+ArsyVxx6HqUROM6g7G5W0nc
         w0ow==
X-Forwarded-Encrypted: i=1; AJvYcCV3zH6/b+isqQJJPYXzwmQdSeCwp2AzgyBiOLcr3K6JMOeC+GDk9oytnVhjxzB5G1AiYl96j0fKvdeS@vger.kernel.org
X-Gm-Message-State: AOJu0YyQp7j11GNfpWRWQ3eUlZqiEGoB2AQNNYY0elTYYaeN4aIYq6Mb
	PrSqiO91AL+mzTYwf7OsUH4aPtOLg5PW8LFPsnwjZ4e1ODNLtn6sqNEF8kSE1bhLValU7aCXmFZ
	aNcfenrLT/YvCOf72nqovB6pxPDn9UM0e8+dkF/lPR1z1ORq30r9V/z4=
X-Google-Smtp-Source: AGHT+IFOhi6hZg4kABvaOZ36Lya3zQr6Mh/Vtk8qSk/VsVb8yneWOLDhU5vgc19ZMfKYoZmeUY4qIzrsvIePZH8/y0LZKhA7XoO1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a86:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-86a08df32demr283701339f.7.1747207351388; Wed, 14 May 2025
 00:22:31 -0700 (PDT)
Date: Wed, 14 May 2025 00:22:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682444b7.a00a0220.104b28.0009.GAE@google.com>
Subject: [syzbot] [sctp?] INFO: rcu detected stall in inet6_rtm_newaddr (3)
From: syzbot <syzbot+3e17d9c9a137bb913b61@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e9565e23cd89 Merge tag 'sched_ext-for-6.15-rc6-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bd4af4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc44e21a0b824ef8
dashboard link: https://syzkaller.appspot.com/bug?extid=3e17d9c9a137bb913b61
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a572f4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35d8c0778a31/disk-e9565e23.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f73f5f4ca4c/vmlinux-e9565e23.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad13ba9fecea/bzImage-e9565e23.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e17d9c9a137bb913b61@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (2 ticks this GP) idle=4c1c/1/0x4000000000000000 softirq=17820/17820 fqs=0
rcu: 	(detected by 1, t=10502 jiffies, g=13441, q=130 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5964 Comm: syz-executor Not tainted 6.15.0-rc6-syzkaller-00047-ge9565e23cd89 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:lock_release+0x2a2/0x3e0 kernel/locking/lockdep.c:5890
Code: b8 09 b8 ff ff ff ff 65 0f c1 05 49 79 d7 10 83 f8 01 75 51 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f7 44 24 20 00 02 00 00 <75> 56 f7 c3 00 02 00 00 74 01 fb 65 48 8b 05 fb 3c d7 10 48 3b 44
RSP: 0018:ffffc90000007bf8 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000006 RCX: 51a5468642bc5400
RDX: 0000000000000002 RSI: ffffffff8d936f16 RDI: ffffffff8bc1d820
RBP: ffff8880269f8b40 R08: ffff88802cf3bc83 R09: 1ffff110059e7790
R10: dffffc0000000000 R11: ffffed10059e7791 R12: 0000000000000002
R13: 0000000000000002 R14: ffff88805a967300 R15: ffff8880269f8000
FS:  0000555587b64500(0000) GS:ffff8881260c7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000600 CR3: 000000007d574000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 advance_sched+0x99f/0xc90 net/sched/sch_taprio.c:981
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x180c/0x2390 arch/x86/kernel/unwind_orc.c:665
Code: 85 f4 08 00 00 b3 01 8b 84 24 84 00 00 00 41 39 06 4c 8b 7c 24 48 48 8b 7c 24 70 0f 85 54 01 00 00 48 8b 44 24 58 80 3c 28 00 <74> 05 e8 7d 05 b0 00 4d 8b 66 38 49 8d 7e 08 48 89 f8 48 c1 e8 03
RSP: 0018:ffffc90003fceeb8 EFLAGS: 00000246
RAX: 1ffff920007f9df8 RBX: ffffffff90b37101 RCX: 0000000000000001
RDX: ffffc90003fcefc8 RSI: dffffc0000000000 RDI: ffffc90003fcefc0
RBP: dffffc0000000000 R08: ffffc90003fcff48 R09: 0000000000000000
R10: ffffc90003fcefd8 R11: fffff520007f9dfd R12: ffffc90003fcff48
R13: ffffc90003fcefd8 R14: ffffc90003fcef88 R15: ffffffff8171ca05
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 fib6_info_alloc+0x30/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x4b3/0x1360 net/ipv6/route.c:3802
 ip6_route_add+0x28/0x160 net/ipv6/route.c:3896
 addrconf_prefix_route net/ipv6/addrconf.c:2487 [inline]
 inet6_addr_add+0x6b2/0xc00 net/ipv6/addrconf.c:3052
 inet6_rtm_newaddr+0x93d/0xd20 net/ipv6/addrconf.c:5063
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x21c/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 __sys_sendto+0x3bd/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f281bd907fc
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007f281c0df670 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f281cae4620 RCX: 00007f281bd907fc
RDX: 0000000000000040 RSI: 00007f281cae4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f281c0df6c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f281cae4670 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g13441 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=8937
rcu: rcu_preempt kthread starved for 10502 jiffies! g13441 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27496 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2046
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2248
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

