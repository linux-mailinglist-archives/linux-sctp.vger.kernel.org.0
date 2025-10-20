Return-Path: <linux-sctp+bounces-640-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEBBF3AC9
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Oct 2025 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53A53B069A
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Oct 2025 21:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC6332EBC;
	Mon, 20 Oct 2025 21:09:28 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CE230BCC
	for <linux-sctp@vger.kernel.org>; Mon, 20 Oct 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994568; cv=none; b=j69/N3Tn+jFHZKexeQU3idFdGePqjnokZC6ex1HYgoQssGulzQs2as8NOpVpRioRux6OIrtCKMQzZraXFc7BVCsdmTCyzUsbTPsEk3ejSvn5OwUboKWUMkM0DY3i7B60gmdHWCkl53RpFDXUTPV1AfDH+VnfrUhBejmVzqZxYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994568; c=relaxed/simple;
	bh=bReRybpNL/hzm5Z1ABBJMKdETWBrbE1IJm3RQyP8kf8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PfYMep2MAbk8swKKOcgtPwi3//ZrHL6rizHqAaExtCu71rIa813bZMju+wPbG8TaHTMy2nisepO7E6o7clvMx8mGDDhQbKWnLsox6+J/YlsFczR7X07+V9zGrWbvtlQ7EIm4/58a9WiL1LmEnkC6umpBW99zrtDsZCeBxWlRLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93e4da7a183so453154039f.1
        for <linux-sctp@vger.kernel.org>; Mon, 20 Oct 2025 14:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994565; x=1761599365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+V+MdXb/YmgAev9Sw7gcszmGhR3iqiEIadv8VJjYG7I=;
        b=eR+b7vxHS9sSiscrnZwGZNZxxbVoSHriUg8i1bm4i5sD3v4G9Wpm9MZ8ZR1J/gmMmZ
         x27r81j/OPtlHtYd2Du6lAV2Kderskxdp9vwi/rr2R1KbVyMyLxDlFR7r6/Z7Yw3Xmqn
         raXT0mLGGqJ222p1JMvImLfjjULkMRtm/+7pKJOqx6Rbe175XpeVCzZPNxaltH+qCpSa
         xJWygHq4nv3aT4nyuMyz/lZL1nGO+oJDaD7wXRi7n69aKCu52NjFkPr4xGlfKIeAmLp6
         y1GzhVCHQUcV8/lrCWAQEmhq4fRfFtvJ6+PgR27V2fXCeavvwAy310qi1U3GhTfJVWhW
         g4oA==
X-Forwarded-Encrypted: i=1; AJvYcCUoVrsNoqscHR5zvfo2r7EOTnVaRrluMurPi2QjWUZvvCiDSZWozNy4JO25xbc3gGGu7gC8xA1Tbu2V@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXQpS4uTzQA1bFztCGo0fNT7nbqv0tgSAsGX8T0e4JA6CLU+2
	eW/XNYg9XfYs/SypAd9nZixUCt8noR4lPO8yHI9CRR8+jFlvVSmlbxpdBZ1IxQK6H5+hmDEN09i
	piFbqihu3/LHbH9zTfx27exJTEpH7w7NmHs9hOYaviDeWOiAKWENPxNhZRxo=
X-Google-Smtp-Source: AGHT+IGiQbQSbJGoWUDS16sfg8Ogdo7rD7/vboTuECjLxjeioWAaGSzyvoClxUnJdmKvOwDhuoGUM6gfVTPdjeAHN7HFvuBTstFL
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6015:b0:93f:c5a3:2ad7 with SMTP id
 ca18e2360f4ac-93fc5a32d96mr1294638839f.6.1760994565634; Mon, 20 Oct 2025
 14:09:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f6a505.050a0220.91a22.0454.GAE@google.com>
Subject: [syzbot] [sctp?] KMSAN: uninit-value in sctp_sf_eat_data_6_2
From: syzbot <syzbot+aa85f41343d9a3174009@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114b752f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=aa85f41343d9a3174009
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15449734580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57a87b0986c0/disk-d9043c79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/019c87e1df0a/vmlinux-d9043c79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54f8a8b0734b/bzImage-d9043c79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa85f41343d9a3174009@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sctp_sf_eat_data_6_2+0x5fb/0xf10 net/sctp/sm_statefuns.c:3210
 sctp_sf_eat_data_6_2+0x5fb/0xf10 net/sctp/sm_statefuns.c:3210
 sctp_do_sm+0x196/0x9720 net/sctp/sm_sideeffect.c:1172
 sctp_assoc_bh_rcv+0x88b/0xbc0 net/sctp/associola.c:1034
 sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
 __release_sock+0x1ef/0x380 net/core/sock.c:3180
 release_sock+0x6b/0x270 net/core/sock.c:3735
 sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4969 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5324
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 sctp_packet_transmit+0x44b/0x46d0 net/sctp/output.c:598
 sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
 sctp_outq_flush+0x1c7d/0x67c0 net/sctp/outqueue.c:1221
 sctp_outq_uncork+0x9e/0xc0 net/sctp/outqueue.c:764
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
 sctp_do_sm+0x8c8e/0x9720 net/sctp/sm_sideeffect.c:1175
 sctp_primitive_SEND+0xd7/0x110 net/sctp/primitive.c:163
 sctp_sendmsg_to_asoc+0x1db8/0x2250 net/sctp/socket.c:1873
 sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2031
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6190 Comm: syz.1.23 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


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

