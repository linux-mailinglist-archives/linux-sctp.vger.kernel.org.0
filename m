Return-Path: <linux-sctp+bounces-483-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CFA7DCED
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Apr 2025 13:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D791888579
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Apr 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1822F392;
	Mon,  7 Apr 2025 11:53:31 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C122D4C7
	for <linux-sctp@vger.kernel.org>; Mon,  7 Apr 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026811; cv=none; b=IbAfOb+KmY8VqS43dZQrv2fhN5bz6fAzp8/vpb6bfJCANXFZ8wAKSZqTyvywfNiIumig2mzs4XqFhC74/ylLRfoo/8QcPCD3IfAQaAewukN/JFz95h1W21A5RT0ap5wSWMOzpZcMIaoWcBJXRUwUiaqlpK1TBCw4ZaTggn4s18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026811; c=relaxed/simple;
	bh=NCCctF/X0MoUzCs4K/uT98GCQBx106uFZXE9qPzQapA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=addd5lJHUCEo0CF1/lXWYrX1DEHnUOismEolHsHdL/ZulkFKDRulNSZNJeuaoEaHSgqVMpu3VHRUXB+LcvBu24fxf2ofgjOD92H5EwIjHXUQ7epyokA/JKQG/aJ/P8IghnmKfhZxRr5WdR3FcNMeNPdtyLdq8h92F3hJ1Eu1lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d458e61faaso44062595ab.0
        for <linux-sctp@vger.kernel.org>; Mon, 07 Apr 2025 04:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744026808; x=1744631608;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SWVqjL//hcLnAkvxJwkPgBqne5zgY402Ha3DCDbu50=;
        b=Zy+nQ3cP0pszLYlZypVLzNt0J9kzjxJSpr2qeLMTwLztJc+Yc8aROeIs5D17Sp4Cpf
         tRgRnPd1ur9QnjcQwJv7IAcpwbBaE5TssggYHQv30HXro80gbAamklbQbZShCyR2+k0s
         K6y9CzD8ltzS812pNwEQxSNlryIGIYVca990A+sm7X76fIuIBlx15R5KgwyyilbIyzXy
         CbRTS8W0g+iPfTH6bebt9uvYRATo87V9vzJDLG+VSfg4i/cRhWkpqGg17xEueSEPbOLM
         ceeKtH8KhIaeIbfjBpH5Go7+fOjbCVaDA+lgQ0GCmmS9/F4Y5SWmjsH1Rw148m3bUX+A
         IQFA==
X-Forwarded-Encrypted: i=1; AJvYcCVFKsC6Ow2NgylKHzxVOFWamKKqi/Y4B8h5gLy9oYREsr+b4JQ9fHm6qzsKaEqgW7WT2Uvj1fITW5IE@vger.kernel.org
X-Gm-Message-State: AOJu0YzHa0WFDUb2/loFErclReuHMRwFWyEb940n+e6DIgk0KmwHEeSS
	rD40u53wYI/Sf5gUSog9sFMgaGaqNbdS8rrC+MA37KBYbHdYi4sn49g5vkvhhKSC6M5p0Kb5cr8
	/sHcLNxV56/RR/jM7sekDzb1+v9Fwhb6u5eG+H5Sbmnsic3rYOxE8BrI=
X-Google-Smtp-Source: AGHT+IH3clogijSCrNF7bvPd9TVvbxN5RUhNGMjweeIVh1CqIfB+DtByVQY4zAhKK1rMjOk4j6SFO2nhMLZnpRnwVpkSFzwHJ3q9
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:3d4:2acc:81fa with SMTP id
 e9e14a558f8ab-3d6e3f89b8fmr118877825ab.2.1744026808507; Mon, 07 Apr 2025
 04:53:28 -0700 (PDT)
Date: Mon, 07 Apr 2025 04:53:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3bcb8.050a0220.34461.0102.GAE@google.com>
Subject: [syzbot] [sctp?] WARNING: refcount bug in sctp_generate_timeout_event
From: syzbot <syzbot+c7dd9f1bd1d2ad0e5637@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9bae8f4f2168 selftests/bpf: Make res_spin_lock test less v..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=14ed9fb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
dashboard link: https://syzkaller.appspot.com/bug?extid=c7dd9f1bd1d2ad0e5637
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20830627571a/disk-9bae8f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f2da93cab39/vmlinux-9bae8f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0719a55401d0/bzImage-9bae8f4f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7dd9f1bd1d2ad0e5637@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 6783 at lib/refcount.c:25 refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 0 UID: 0 PID: 6783 Comm: syz.2.263 Not tainted 6.14.0-syzkaller-g9bae8f4f2168 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:refcount_warn_saturate+0x13a/0x1d0 lib/refcount.c:25
Code: 00 6a a1 8c e8 07 88 7d fc 90 0f 0b 90 90 eb b9 e8 cb 67 be fc c6 05 3a e3 44 0b 01 90 48 c7 c7 60 6a a1 8c e8 e7 87 7d fc 90 <0f> 0b 90 90 eb 99 e8 ab 67 be fc c6 05 1b e3 44 0b 01 90 48 c7 c7
RSP: 0018:ffffc90000007b28 EFLAGS: 00010246
RAX: f4de809b98aa7600 RBX: ffff8880738bc004 RCX: ffff88802665da00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff81827a12 R09: fffffbfff1d7a978
R10: dffffc0000000000 R11: fffffbfff1d7a978 R12: dffffc0000000000
R13: 0000000000000002 R14: ffff88802a051440 R15: ffff8880738bc000
FS:  00007f7af0ba46c0(0000) GS:ffff888124f96000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000000c0 CR3: 000000007c37c000 CR4: 00000000003526f0
DR0: 0000200000000300 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 sctp_generate_timeout_event+0x1ca/0x360 net/sctp/sm_sideeffect.c:284
 call_timer_fn+0x189/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66e/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_check_zapped_pte+0x3a/0xb0 arch/x86/mm/pgtable.c:890
Code: 7c c6 53 00 48 83 c3 20 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 c9 ef bd 00 4c 8b 3b <48> bb 00 00 00 00 20 00 00 00 48 89 de 4c 21 fe 31 ff e8 1f cb 53
RSP: 0018:ffffc9000306f240 EFLAGS: 00000246
RAX: 1ffff110066e0804 RBX: ffff888033704020 RCX: dffffc0000000000
RDX: ffffc9000ccc4000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffffc9000306f610 R08: ffffffff8211d084 R09: 1ffffd4000394330
R10: dffffc0000000000 R11: fffff94000394331 R12: ffffea0001ca1980
R13: dffffc0000000000 R14: 8000000072866007 R15: 00000000180400fb
 zap_present_folio_ptes mm/memory.c:1518 [inline]
 zap_present_ptes mm/memory.c:1586 [inline]
 do_zap_pte_range mm/memory.c:1687 [inline]
 zap_pte_range mm/memory.c:1731 [inline]
 zap_pmd_range mm/memory.c:1823 [inline]
 zap_pud_range mm/memory.c:1852 [inline]
 zap_p4d_range mm/memory.c:1873 [inline]
 unmap_page_range+0x20d7/0x44d0 mm/memory.c:1894
 unmap_vmas+0x3ce/0x5f0 mm/memory.c:1984
 exit_mmap+0x2bc/0xde0 mm/mmap.c:1284
 __mmput+0x115/0x420 kernel/fork.c:1379
 copy_process+0x2891/0x3d10 kernel/fork.c:2693
 kernel_clone+0x242/0x930 kernel/fork.c:2844
 __do_sys_clone kernel/fork.c:2987 [inline]
 __se_sys_clone kernel/fork.c:2971 [inline]
 __x64_sys_clone+0x268/0x2e0 kernel/fork.c:2971
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7aefd8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7af0ba3fe8 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f7aeffa5fa0 RCX: 00007f7aefd8d169
RDX: 00002000000000c0 RSI: 0000000000000000 RDI: 0000000082001000
RBP: 00007f7aefe0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7aeffa5fa0 R15: 00007ffe033b7728
 </TASK>
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	48 83 c3 20          	add    $0x20,%rbx
   4:	48 89 d8             	mov    %rbx,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  12:	fc ff df
  15:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  19:	74 08                	je     0x23
  1b:	48 89 df             	mov    %rbx,%rdi
  1e:	e8 c9 ef bd 00       	call   0xbdefec
  23:	4c 8b 3b             	mov    (%rbx),%r15
* 26:	48 bb 00 00 00 00 20 	movabs $0x2000000000,%rbx <-- trapping instruction
  2d:	00 00 00
  30:	48 89 de             	mov    %rbx,%rsi
  33:	4c 21 fe             	and    %r15,%rsi
  36:	31 ff                	xor    %edi,%edi
  38:	e8                   	.byte 0xe8
  39:	1f                   	(bad)
  3a:	cb                   	lret
  3b:	53                   	push   %rbx


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

