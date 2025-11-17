Return-Path: <linux-sctp+bounces-745-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D506C62CB9
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Nov 2025 08:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D24C434BC70
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Nov 2025 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096331A567;
	Mon, 17 Nov 2025 07:50:30 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB82F6184
	for <linux-sctp@vger.kernel.org>; Mon, 17 Nov 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365830; cv=none; b=NvP1lq+vDC288nWdKELUBC0RcNXAStLZZHCumtIIIhteguMRSqPqjdHYRdfTw55eDoT+6ro7eFnZRnEx0bNvFzD6LhQz3z7n3Uy4C9VLcI2dccnDObBRCxtuleA8GNevO7MnUVoiAn1ZhPkG59Jm18eYZ/HHhP2y548atSX2gNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365830; c=relaxed/simple;
	bh=exFxZ3Dp9XithKleRlTYAXSbYBc8o1depYcp8ANM0SM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GwjVByZQ1v1b2X1HZZxG4xvdDTTFg05HwNLgsjqkBeHePz5gJAk/Ax1zg6rhkkT2+2Mw3ZJRvKjIgiNZCuIjloQ++8Kumo5G4dKtUl8l18YasOMnqcwjA7I5BgvNdr0X1CrD+cN28gGe9kkHxZuCLmGIkgDPtBCSkGje/PTtf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso960317739f.0
        for <linux-sctp@vger.kernel.org>; Sun, 16 Nov 2025 23:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365828; x=1763970628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SR48UPog8jJajspAE3Vve4DfAYEMOezKWsvRTEEqnyI=;
        b=nUBy1m501BrBKBK+s90w8i6TTSwCe6PzIFGc+hIY9ZUcF2ocw64ARUF8skXPiVC24j
         q/jjfOQop+IiLedgeDrdPdDymd4NxaFO+Y5Xzwk8fPK+JiWAj4DOFgLKhRQlpXid+vz1
         8QNNdgncp9qKd3rV+b+fozB4oGWjWyjn90Uch1ieadkrsQl04cPXPpC9vlYg2EbWNWho
         7SY5KWmONuHb+/mN96CHgBYx3uMwRppuSUZjVdKhHdqsY3jM7Gr8n8yBGY8kgMd7ewtH
         /eNXAcrLUnUpPF0Hdj65vCZttUTXS172qjL7pxOnX/a1GZXBSWzjbX7AULx8w11AWge0
         IHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlnsJdf0mnvuQHG9pql37OBApTIUgxbeqevcyAMpViHOM+WJEjrGyY7L9IV918dbVwoG5mxP14mtQi@vger.kernel.org
X-Gm-Message-State: AOJu0YwUD+Snz1UgEOeKa4RBfc4chXXtieKIox+hRQKKfgwfiD3TzErY
	nbDX4J6Ruo7WC5+0ZAskxYsX3mbcfhcKTGdMHwmSKBsrHuOwjksr6afRFng7XPWknUd3W5NTYjB
	jPk8DI7uA/0VRGohYPUjDhOTpON8Rq+/uBHZly7UXb4/oNPvpnndc6l/dL9I=
X-Google-Smtp-Source: AGHT+IGrxDGbCrzyXwSMXCo3r/6yUwB/4Wqa/qnuv7gyhBqhtBsxhDT3Tlb1v2YfKkjoZFzpt7c4eF7yI+GaJq7VZS7SLfQ0buyO
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dd2:b0:434:96ea:ff6e with SMTP id
 e9e14a558f8ab-43496eb01cbmr74910925ab.39.1763365828007; Sun, 16 Nov 2025
 23:50:28 -0800 (PST)
Date: Sun, 16 Nov 2025 23:50:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ad3c3.a70a0220.f6df1.0005.GAE@google.com>
Subject: [syzbot] [sctp?] WARNING: refcount bug in sctp_transport_put (5)
From: syzbot <syzbot+e94b93511bda261f4c43@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccec5944606 Merge tag 'erofs-for-6.18-rc6-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179c497c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=e94b93511bda261f4c43
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2ccec594.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a29a7f4d52f4/vmlinux-2ccec594.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1557802e0ae5/bzImage-2ccec594.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e94b93511bda261f4c43@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 88 82 1a fd 84 db 0f 85 66 ff ff ff e8 9b 87 1a fd c6 05 82 fe c8 0b 01 90 48 c7 c7 80 c3 ef 8b e8 b7 09 d9 fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 78 87 1a fd 0f b6 1d 5d fe c8 0b 31
RSP: 0018:ffffc90000007c30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817adc48
RDX: ffffffff8e097a00 RSI: ffffffff817adc55 RDI: 0000000000000001
RBP: ffff88806af5f820 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88806af5f820
R13: 0000000000000101 R14: ffffffff8a96c630 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88809780d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000003010cffc CR3: 000000005fddc000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 sctp_transport_put+0x12a/0x170 net/sctp/transport.c:476
 call_timer_fn+0x19a/0x620 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers+0x6ef/0x960 kernel/time/timer.c:2372
 __run_timer_base kernel/time/timer.c:2384 [inline]
 __run_timer_base kernel/time/timer.c:2376 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2393
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2403
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 97 6f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 83 b3 2c 00 fb f4 <e9> 3c 0a 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e007df8 EFLAGS: 00000286
RAX: 0000000000c7ee29 RBX: 0000000000000000 RCX: ffffffff8b5d72a9
RDX: 0000000000000000 RSI: ffffffff8da28539 RDI: ffffffff8bf075c0
RBP: fffffbfff1c12f40 R08: 0000000000000001 R09: ffffed1005646655
R10: ffff88802b2332ab R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff8e097a00 R14: ffffffff908244d0 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x38d/0x500 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 rest_init+0x16b/0x2b0 init/main.c:757
 start_kernel+0x3f6/0x4e0 init/main.c:1111
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
 </TASK>
----------------
Code disassembly (best guess):
   0:	97                   	xchg   %eax,%edi
   1:	6f                   	outsl  %ds:(%rsi),(%dx)
   2:	02 c3                	add    %bl,%al
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	0f 1f 00             	nopl   (%rax)
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d 83 b3 2c 00 	verw   0x2cb383(%rip)        # 0x2cb3ab
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	e9 3c 0a 03 00       	jmp    0x30a6b <-- trapping instruction
  2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  36:	00 00 00
  39:	66 90                	xchg   %ax,%ax
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

