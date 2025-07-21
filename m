Return-Path: <linux-sctp+bounces-585-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1488EB0CAD2
	for <lists+linux-sctp@lfdr.de>; Mon, 21 Jul 2025 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12B53A505F
	for <lists+linux-sctp@lfdr.de>; Mon, 21 Jul 2025 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851DC225A3D;
	Mon, 21 Jul 2025 19:06:41 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544C1E520D
	for <linux-sctp@vger.kernel.org>; Mon, 21 Jul 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124801; cv=none; b=nyjoyvS4sCVDGLA3Ny/JdkJ/2jhw2beKS5SLgP1ggincPXKeWXm5k1G68MX7RoJNC0lyOPopKmviLwygRV4JSsXC/KktliUELSwqSFSgNubW5DibRgPlBeo2+UTyB0WJkbEpdqEJOWBKti/oL7QEdz9MoAiSHX5M2zO5rbiQrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124801; c=relaxed/simple;
	bh=W7kBEV7c89kcPfds65jFKTlDtmUYepP1h4+CWTAKRE4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UNP4BAwjn3ed/CSVgq3yusZH1MQzh146OgGwwAwz6XWgYC9eKhMrGDbJvmAGQzPCCK5WLBk3OPbQG0D72vdssTWQvAtAtclpOBeF87BvhvqXYO0XNFnOjMe4+EYQpcqc438H9fw2KfiX9moY2q8griaDmpKMW9MwDLEbBvxpzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso87579775ab.2
        for <linux-sctp@vger.kernel.org>; Mon, 21 Jul 2025 12:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753124799; x=1753729599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPx8+JEokfjkofjfDOhJT6DZZEclvZcdGwiXhl1pZQ0=;
        b=oqhnegL/ZtKEg/zR7aE8x4OoiOsCr1uPq+HO7TNqorqLhFFQCBU4JOaSWj42vXWDNr
         lKizn3v6ob0KB75rvOsT0hCQ0swQ0T90y8anI4T6rrQIn9shMzx+wnJ7G9b20/C8YlPy
         db9nYKK0qTjivKWAY4HVuTbpw4pyN6dr5XGXN8iHuxaEq8uY+WCgmLSTRLSCl/BcYwjO
         e/9B+jP63iriN1kyWDn0sMHE4cXhoWFoBONXJVplQfDhDEDxvy60723oKO7YkoUjC+CT
         8nqdzuY1isIoGi20toqRmJdaGBBeZEqUWtdOorXha+DaVawq35G5oTW8Yvy/+o4A4uzL
         DgaA==
X-Forwarded-Encrypted: i=1; AJvYcCWvTb/DxYZU2/958XZfnj5sS8GkNiTKXWW/AVVAwelgM4csPZssH5sdi+tQuwK/Cqt5KTteFhiWY4qZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0752UF3tkWE/26uP49Fv3Fd3Sgo2vwLNfWb3IbhsAtMeQem5a
	nfNYNk0oQKDjWXKZMzD2k+m1XbeVehUjwMi2y3tBcUYZ84TSy1BxuFdgtOMCfmkTLx4pLCXAJIF
	J8cwgx+Dovf/vne4/6mJzmJ2ADAJBBuGDMrrC3NiiYyNY9Hfp4lmy32CMK5c=
X-Google-Smtp-Source: AGHT+IEiJ4Fb1oZt6NyM4ShD2ZHm//REnRAWU9mZsKxmaqSSpQalWUvKQcTzKUknPnwrrxPUW7zZQiP3MTl3aLKu89nLHMeHbH/X
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2587:b0:3e2:9f78:3783 with SMTP id
 e9e14a558f8ab-3e29f783956mr138838035ab.21.1753124798817; Mon, 21 Jul 2025
 12:06:38 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:06:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e8fbe.a70a0220.1224c.001d.GAE@google.com>
Subject: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
From: syzbot <syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6832a9317eee Merge tag 'net-6.16-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137d9d8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=693e2f5eea496864
dashboard link: https://syzkaller.appspot.com/bug?extid=2e455dd90ca648e48cea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a84ef6250f7/disk-6832a931.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/454efb0534f6/vmlinux-6832a931.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a5841eb7e63/bzImage-6832a931.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
shift exponent 237 is too large for 32-bit type 'unsigned int'
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc6-syzkaller-00121-g6832a9317eee #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:233 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
 sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:509
 sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
 sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
 sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
 sctp_do_sm+0x36df/0x5c80 net/sctp/sm_sideeffect.c:1175
 sctp_assoc_bh_rcv+0x392/0x6f0 net/sctp/associola.c:1034
 sctp_inq_push+0x1db/0x270 net/sctp/inqueue.c:88
 sctp_rcv+0x14d8/0x3c60 net/sctp/input.c:243
 ip_protocol_deliver_rcu+0x447/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:317 [inline]
 NF_HOOK include/linux/netfilter.h:311 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:469 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:448 [inline]
 NF_HOOK include/linux/netfilter.h:317 [inline]
 NF_HOOK include/linux/netfilter.h:311 [inline]
 ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:568
 __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:5977
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6090
 process_backlog+0x442/0x15e0 net/core/dev.c:6442
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:7414
 napi_poll net/core/dev.c:7478 [inline]
 net_rx_action+0xa9f/0xfe0 net/core/dev.c:7605
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 0b 6f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 77 25 00 fb f4 <e9> 8c fb 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e207e08 EFLAGS: 000002c6
RAX: 0000000000448811 RBX: 0000000000000000 RCX: ffffffff8b849c69
RDX: 0000000000000000 RSI: ffffffff8de2d10c RDI: ffffffff8c157960
RBP: fffffbfff1c52ef0 R08: 0000000000000001 R09: ffffed1017086645
R10: ffff8880b843322b R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff8e297780 R14: ffffffff90a9a650 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:749
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x391/0x510 kernel/sched/idle.c:325
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
 rest_init+0x16b/0x2b0 init/main.c:745
 start_kernel+0x3ee/0x4d0 init/main.c:1102
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:307
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:288
 common_startup_64+0x13e/0x148
 </TASK>
---[ end trace ]---
----------------
Code disassembly (best guess):
   0:	0b 6f 02             	or     0x2(%rdi),%ebp
   3:	c3                   	ret
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
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d d3 77 25 00 	verw   0x2577d3(%rip)        # 0x2577fb
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	e9 8c fb 02 00       	jmp    0x2fbbb <-- trapping instruction
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

