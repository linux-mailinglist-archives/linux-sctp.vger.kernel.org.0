Return-Path: <linux-sctp+bounces-738-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A448C3D9B3
	for <lists+linux-sctp@lfdr.de>; Thu, 06 Nov 2025 23:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB84E496A
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Nov 2025 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2B29B229;
	Thu,  6 Nov 2025 22:30:31 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B06A33B
	for <linux-sctp@vger.kernel.org>; Thu,  6 Nov 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468231; cv=none; b=at1JFttWT8KK5R7JMZs7TrfB8PjF9tzKIu4yzcC1C8yUrJAERrgAOjNfeZq0/rotIstU2mGda16FWMS0/0JSyvB2bJMnZF44qwlDg1hOarVlfd4eU7WkWNEhAnjbHItuXQlQmyC8Q0vsYpqQoffMzqteS296ghVFXLkoJTK8ggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468231; c=relaxed/simple;
	bh=aoqPzFm7oDwFwoc7LASh6+cxqVFFNRpQUn4XqSIeZsw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=apxetZYrrJ/Y+O6yfRi2HYpCainG/FZ3ckt5T4cTFQckqoDbhfodpPseUXMfY61eU8SjKc+M9YS+vOOxq55Vtfplrn+fvTbym1uCoHPUM6qspSLfhajOPyzr9UBPLH31DtsHNVjx3z2e9qnPL+8XWQmftXRpFM81r+9ZCl/KqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-433154d39abso5208245ab.0
        for <linux-sctp@vger.kernel.org>; Thu, 06 Nov 2025 14:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762468229; x=1763073029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9i4whal81/zcSAHBrOH8La+Wz6AFlPsYwQERm7FWms=;
        b=i1psc9/G/YSmZefIccRMK02kCEZ7cilJs1sJPJvDqehzREsCbIFCVLROw9RztjT6t+
         keEtgGKd8Uk22DaRKQwid9HjhK8DhoBF9OTjld3HzQY3IuHC0kD7H48eNNeNXg5piCYi
         SW+DTo64eGJGSMEcd69rveC7MPfqpTyRkI5jXM9yCZFiz7kO2ZVk8RxAhE3Oo7j/RwP4
         yOWf7WS09p2emkqVFH2UxYf2WgJtdS2CPLeRUx9MAx8QWlYPB3ZN1LFFB3n2lwzX+HiQ
         APoK3aM2xGqz5aYoiwK4RuX2QLA/2SPpffArZEX0RWWVoq9JGBDLPHtY1NGDBv7teP4I
         LRSA==
X-Forwarded-Encrypted: i=1; AJvYcCVk8Eeh829MGFE+gD8tUJTW8bd4sAF556mi5OWT4GSyDJpcfcKQgxIFXuki5vbcJL1WkRghi8YZhDaK@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEnRAZebPrP3Fh1PKQ9OQZ8xt2Mz08W32EsdAytbxMPtjWCp/
	0EO35wJ0ikjXp6AdI/4skNMqzTCqeF9B/I4U2HNDSHW3st0LGgxY66TwGnGuDa057T/f2GbIden
	480TqIZmKp7mH60R5gWT56QhNf5L6gsrMmXVyKRLbIig3t4k4I3Yzit611yU=
X-Google-Smtp-Source: AGHT+IH5uw/iIj2y/V+P1SCd4V3iW16EXYXodigyiDNJPk+hbLfxZatAWtBsRRM4fNFj+ssVTx5tKZKEMYQ2Fz3AzQBLKa1C0Bj2
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:433:150:bacf with SMTP id
 e9e14a558f8ab-4335f5928c2mr16471755ab.26.1762468229031; Thu, 06 Nov 2025
 14:30:29 -0800 (PST)
Date: Thu, 06 Nov 2025 14:30:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d2185.a70a0220.22f260.000e.GAE@google.com>
Subject: [syzbot] [sctp?] BUG: corrupted list in sctp_destroy_sock
From: syzbot <syzbot+ba535cb417f106327741@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a2352ad82b5 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1110fe7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=810aeb811fb1cca1
dashboard link: https://syzkaller.appspot.com/bug?extid=ba535cb417f106327741
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ff9704580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11372bcd980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ba55bd42dcf/disk-1a2352ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/57da62b6c7d2/vmlinux-1a2352ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d8bb5da864a/bzImage-1a2352ad.xz

The issue was bisected to:

commit 16942cf4d3e31b6246b7d000dd823f7b0b38bf8c
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Thu Oct 23 23:16:54 2025 +0000

    sctp: Use sk_clone() in sctp_accept().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1634e32f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1534e32f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1134e32f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba535cb417f106327741@syzkaller.appspotmail.com
Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")

 slab net_namespace start ffff88803347c900 pointer offset 4344 size 9088
list_del corruption. prev->next should be ffff8880799e9148, but was ffff8880799e8808. (prev=ffff88803347d9f8)
------------[ cut here ]------------
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
RIP: 0033:0x7f3890b8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5dc3b8a8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000015724 RCX: 00007f3890b8efc9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000055dc3bb9f
R10: 0000001b2ec20000 R11: 0000000000000246 R12: 00007f3890de5fac
R13: 00007f3890de5fa0 R14: ffffffffffffffff R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
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

