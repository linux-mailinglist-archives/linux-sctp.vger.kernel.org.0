Return-Path: <linux-sctp+bounces-635-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00764BE3C3C
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Oct 2025 15:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8255882C4
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Oct 2025 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F51B0437;
	Thu, 16 Oct 2025 13:42:34 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695B339B30
	for <linux-sctp@vger.kernel.org>; Thu, 16 Oct 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622154; cv=none; b=hvVBonjaskqQpqoGluZiGvrd80qcolKi/vtgCyrpG2jbbOsHk1HnraNTXzqHz1NMyT5DYpbmbTEm3BXpCZOznngBec+n8niH0B88hXzsraIB48RqS3bY+z3PZURXcHFmlBOWJiSxgGrE7ilCBMwGWpadcnJbVHzBSa1uZ/Cm80U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622154; c=relaxed/simple;
	bh=syBv9aUWt6fTD0PgmuZNZhyjnIaJyirxDywJ86Rl2To=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SXuZI224SExNrKRy/E7fWx7gZS9g+mT/xFDh4IFUwz46PzdXoRcxeuIbacQcA9wM50+QH/0MZQv/sj2pENVecnaZcpQrjuLIwd/wFKa5RTzI4fOZeuovn/qMVDihyE+vkR4NGyXD8NGcoCac6EBLx75MO5CbrIxAANJwn4ZxKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f9bf61913so10780225ab.3
        for <linux-sctp@vger.kernel.org>; Thu, 16 Oct 2025 06:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760622151; x=1761226951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2DHqrwsD+9Fr2vMh115bEQ2Fp4/zXqmJxFksIglg0g=;
        b=gbVRdxKAiwyoV4CFPG5rr/6IeNTG2SLSJSfqCxLYLM8oQB/2iR4yY7ZpM0J9+BdKOE
         P7QMws7Wf7pLMySps3uUhy1lE9jR/VWIUK1OGVfMTB1ZgTHp59w3lx7oHeLicWHBL3t/
         k6z+SVACwNwrzOUd4Z9Zszv51Qe2O6gJVD8eS1dNskfUZ5vL4jXuduMXMwH4hSXZBTeP
         GL2R6WGk9wKpwLCrHJxhz4im7bIccYIaUbhWTxn2nzTHKYdb+8AXZ64Wi8uyumG0tYpG
         YsrcnEjkCfRE2RX50xPoh/gSlWWpHTg2HuuO+X5X48IwBLnz145i5h+nW8TklPDfnJrT
         9Akw==
X-Forwarded-Encrypted: i=1; AJvYcCUkzUcwVG7gz3d/7EDB2PjgvwgvFRI+qc9tdCedykPKI0d1mBoacp2TSTV5hiSBn8QoxcMj4SMc/nmg@vger.kernel.org
X-Gm-Message-State: AOJu0YzaubGeGkfRZzA1RKjV58kB3TIffEBpXuLHvWT7BBdlss88JT5m
	CZqrYskkO9sQPaL+ywQYNP0qJLeFdvBxYW/m/Sd9oXgnTChNsXJUEf3PtMxEYKJFrv3HOEuJsev
	w5vhWUDAHC+ER54D4+B/a2e9Lu68JHNybu7P4fAsrrMJ8Z4kHJ8gHTv0xF4Q=
X-Google-Smtp-Source: AGHT+IHLxXuOYYPNOTXfd70oIaGzDB0tfb7mCH8Eh9uoQMswgM/rxufC99K6Uo6S2OPHU1x4uYwnVaJOWWElpmssxJ/4eiW3KUSQ
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc8:b0:424:8c15:888a with SMTP id
 e9e14a558f8ab-430c532c218mr3825055ab.32.1760622151556; Thu, 16 Oct 2025
 06:42:31 -0700 (PDT)
Date: Thu, 16 Oct 2025 06:42:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f0f647.050a0220.91a22.040c.GAE@google.com>
Subject: [syzbot] [sctp?] WARNING: refcount bug in sctp_generate_timeout_event (2)
From: syzbot <syzbot+b86c971dee837a7f5993@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0db4941d9dae bpf: Use rcu_read_lock_dont_migrate in bpf_sk..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172af92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e0e0bf7e51565cd
dashboard link: https://syzkaller.appspot.com/bug?extid=b86c971dee837a7f5993
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/692372caac28/disk-0db4941d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5518b9303204/vmlinux-0db4941d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/606bc80ec5b8/bzImage-0db4941d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b86c971dee837a7f5993@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 7563 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 1 UID: 0 PID: 7563 Comm: syz.3.521 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Code: 00 00 e8 c9 fb 2f fd 5b 41 5e e9 11 dc ba 06 cc e8 bb fb 2f fd c6 05 87 a1 f8 0a 01 90 48 c7 c7 00 b2 bf 8b e8 f7 19 f3 fc 90 <0f> 0b 90 90 eb d7 e8 9b fb 2f fd c6 05 68 a1 f8 0a 01 90 48 c7 c7
RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
RAX: 7c4c1f86041de100 RBX: 0000000000000002 RCX: ffff88802da23c80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa244 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff888054308004 R15: ffff8880543083c0
FS:  00007f399e4b86c0(0000) GS:ffff888125e27000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f399e497d58 CR3: 0000000032fde000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 sctp_generate_timeout_event+0x1c8/0x360 net/sctp/sm_sideeffect.c:284
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x283/0x870 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:schedule_debug kernel/sched/core.c:5885 [inline]
RIP: 0010:__schedule+0x1b3/0x4cc0 kernel/sched/core.c:6806
Code: f6 48 8b 1b 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 24 ce dc f6 48 81 3b 9d 6e ac 57 <0f> 85 b7 18 00 00 45 85 ed 7f 54 49 8d 5e 18 48 89 d8 48 c1 e8 03
RSP: 0018:ffffc90005536be0 EFLAGS: 00000246
RAX: 1ffff92000aa6000 RBX: ffffc90005530000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8bc060c0 RDI: ffffffff8bc06080
RBP: ffffc90005536df0 R08: ffffffff8f9db437 R09: 1ffffffff1f3b686
R10: dffffc0000000000 R11: fffffbfff1f3b687 R12: ffff888125e27000
R13: 0000000000000001 R14: ffff88802da23c80 R15: 1ffff110170e7568
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7256
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:211
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 5b 1b f3 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90005536f78 EFLAGS: 00000206
RAX: 7c4c1f86041de100 RBX: 0000000000000000 RCX: 7c4c1f86041de100
RDX: 0000000000000000 RSI: ffffffff8d9cc7dc RDI: ffffffff8bc060e0
RBP: ffffffff8216d87d R08: 0000000000000000 R09: ffffffff8216d87d
R10: ffffc90005536c08 R11: fffff52000aa6d83 R12: 0000000000000000
R13: ffffffff8e255de0 R14: 0000000000000001 R15: 0000000000000246
 fs_reclaim_acquire+0x99/0x100 mm/page_alloc.c:4286
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4897 [inline]
 slab_alloc_node mm/slub.c:5221 [inline]
 kmem_cache_alloc_node_noprof+0x48/0x710 mm/slub.c:5297
 kmalloc_reserve+0xbd/0x290 net/core/skbuff.c:579
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 netlink_ack+0x146/0xa50 net/netlink/af_netlink.c:2489
 netlink_rcv_skb+0x28c/0x470 net/netlink/af_netlink.c:2558
 nfnetlink_rcv+0x282/0x2590 net/netfilter/nfnetlink.c:669
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f399d58eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f399e4b8038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f399d7e5fa0 RCX: 00007f399d58eec9
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 000000000000000c
RBP: 00007f399d611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f399d7e6038 R14: 00007f399d7e5fa0 R15: 00007fff5f9ffbb8
 </TASK>
----------------
Code disassembly (best guess):
   0:	f6 48 8b 1b          	testb  $0x1b,-0x75(%rax)
   4:	48 89 d8             	mov    %rbx,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  12:	fc ff df
  15:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  19:	74 08                	je     0x23
  1b:	48 89 df             	mov    %rbx,%rdi
  1e:	e8 24 ce dc f6       	call   0xf6dcce47
  23:	48 81 3b 9d 6e ac 57 	cmpq   $0x57ac6e9d,(%rbx)
* 2a:	0f 85 b7 18 00 00    	jne    0x18e7 <-- trapping instruction
  30:	45 85 ed             	test   %r13d,%r13d
  33:	7f 54                	jg     0x89
  35:	49 8d 5e 18          	lea    0x18(%r14),%rbx
  39:	48 89 d8             	mov    %rbx,%rax
  3c:	48 c1 e8 03          	shr    $0x3,%rax


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

