Return-Path: <linux-sctp+bounces-737-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64403C3A765
	for <lists+linux-sctp@lfdr.de>; Thu, 06 Nov 2025 12:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C343D1895B7C
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Nov 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DBD30C639;
	Thu,  6 Nov 2025 11:08:33 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC22E7F02
	for <linux-sctp@vger.kernel.org>; Thu,  6 Nov 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427313; cv=none; b=gwitdUAy9ebIMayZo6RKLkJDWhEFUQalcOzvGLxNeYcEl8a4BGLD5QE9NZaisbFu0KzQoovQV+m3tSwxJnFWASe99LVN/rWhNvOI0ipnYQJ27l67nJh6kibtIWplwgm09WCm9gtye2ZZcB6hnf9T/IDa2L5rosWnm6JxNGFMVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427313; c=relaxed/simple;
	bh=1/8gfgj/VfoBPSX6YkhXgToj4pYCH2gIKZl+fzyz2Yo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SPcAu9E1iVK6bzli2oPUvRnzGh98kNuDvLMHOQrsUcDe5RvWeg3VoVgyag8ZIfDieLnw4Ag9V/YW33RwbuuNPPuLJbCPmg7Ns4FMuJySU6lc+qTRMXmwFBXR7XeiEn1tIhZ4Z4aLdNyHlUeDHWYtX4/2cS3LEjrsrTbQBzDvET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43331987addso5936015ab.2
        for <linux-sctp@vger.kernel.org>; Thu, 06 Nov 2025 03:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427310; x=1763032110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xt9I9ECQYklwP1K0IfUhucTf4beK1df9htAhtxikHzc=;
        b=kIvAxRolqZGacJqvCIqKBsqtzAoCtL2BPZjqGUDDyNHUq+jh82z0c9vVwV4g7VGrwo
         jwoHhKz3Z0AlXbKFARHjQjrZahRlMjTiTmgnpLJrnatzxZS5l+JPvtIoF2IBAleyK4WW
         GUpJJL9VUCtnC7kewjQ7Uvery25U07A+6UpLXZHRmWjimMn6/5VtREkCLTfF+xkOsbjN
         hVXfed5fk928cNpeEGMSTAxZsiTpQA2P1bgDApKeCfXTPuekHePgb1D7vPkQAx6zbw/P
         3ZLEuN8lKIEbpeLBRmq5L9TTayp20rsMi2bADlCHO056tdKixuLxqrmRofCGwSdavZn7
         RMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWmu1PypbiwRc2a1vVTl1qEnUTNZzPEG2test7IrRCu2HeZ0+Sa+1ihP6hl2vi7/dlmteF1tFWkqfvH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc28EZawaahJyug68O82KrLvKG7t9V2A/m5djBUlZiRMh0NZvE
	D864tfX1mHWL3XbEo/jN9tzqAPsDT76JntKzBAXjQgokvZyajS+7OrjiaJDcDj91BZGNkBxYdpR
	AaHzFTHJZmwriZrthgQ0NGMDvgSX7m2VT3vybDToUCddaqHG0pX4pkZUedVM=
X-Google-Smtp-Source: AGHT+IF0sgKhdjOK3t2OgeZSgNWC4Te4epR7iggYWJe3cHd31IWq6GRJfNeHXBa9mJTtHXtXf4B/qofx02wjuRfEWCs+GDBx61eM
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4815:b0:433:5c92:4de6 with SMTP id
 e9e14a558f8ab-4335c924f25mr2230005ab.19.1762427310364; Thu, 06 Nov 2025
 03:08:30 -0800 (PST)
Date: Thu, 06 Nov 2025 03:08:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c81ae.050a0220.3d0d33.014e.GAE@google.com>
Subject: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
 (2)
From: syzbot <syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c9cfc122f037 Merge tag 'for-6.18-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d72114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c46c8b2b7f6e076e99
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1699c8b52f1/disk-c9cfc122.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1af4e539151/vmlinux-c9cfc122.xz
kernel image: https://storage.googleapis.com/syzbot-assets/771c6be9d72b/bzImage-c9cfc122.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
shift exponent 64 is too large for 32-bit type 'unsigned int'
CPU: 0 UID: 0 PID: 16704 Comm: syz.2.2320 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
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
 sctp_backlog_rcv+0x169/0x590 net/sctp/input.c:331
 sk_backlog_rcv include/net/sock.h:1158 [inline]
 __release_sock+0x3a9/0x450 net/core/sock.c:3180
 release_sock+0x5a/0x220 net/core/sock.c:3735
 sctp_sendmsg+0xeb9/0x1e00 net/sctp/socket.c:2036
 inet_sendmsg+0x11c/0x140 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 sock_write_iter+0x509/0x610 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e92f8f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e93e34038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3e931e6090 RCX: 00007f3e92f8f6c9
RDX: 000000000000fdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f3e93011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3e931e6128 R14: 00007f3e931e6090 R15: 00007ffc44d78078
 </TASK>
---[ end trace ]---


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

