Return-Path: <linux-sctp+bounces-594-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE4B13202
	for <lists+linux-sctp@lfdr.de>; Sun, 27 Jul 2025 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2221671EE
	for <lists+linux-sctp@lfdr.de>; Sun, 27 Jul 2025 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7B242927;
	Sun, 27 Jul 2025 21:25:39 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299623C4FB
	for <linux-sctp@vger.kernel.org>; Sun, 27 Jul 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753651539; cv=none; b=tTt0gZ0kW6rKSAet27BsN6hStQMD648e0Kodp1sYx6DbuvsLHSi9ShUzZwz0TbDP/WozT9lupXG4f+LBzDFjlbPm9vvBAK7HJh3HwmPGJ6YikxckD42AEao42Ui+QsG7H3g1JuTJpMKVTKvpwayCmmr0fW/5aIvp1wUEXj7FUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753651539; c=relaxed/simple;
	bh=vCn40UUDOGw/cGn46/9TLk9ExbLqzknDAf9psSCEoro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=grhhjPr9V4xlV/zBqOr2G2cJVQs8nWTF2VwJpyf/GbdAiSNZqLbR37LDlbHmQToOLAjiy+lPcj9Ie4/tViKcwYwLXRp5QoPZeR0Ken56nMf9iuSbJCxbZkaCROQkMVnOfuRdkn5o+FRDk6X2GRRI+P+W7rktxogHkDBh8Uw7dkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87c056ae7c0so832186039f.2
        for <linux-sctp@vger.kernel.org>; Sun, 27 Jul 2025 14:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753651536; x=1754256336;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDz96/NZdwrM4WZ2hwJOdssYjQnPlecps7fWxJhLeoE=;
        b=V9K7ExgMvESLddX2DhPJZAODEF1LA/7ybEJ5POfkfGAqmbZXNnpnK5o0FcWLeehwwH
         Y53Q29rDVzzp+s3/GSCWT/3W/ffvt2zAAKbnUGdIB6DUypZlzoEC4S0tB3KGcyCPtK2I
         CNVroxFd6yNYnLDB/2q/jZf6yY8ODWu35ATinzDRkGAPqbg70neOaLqW6Vrk07movQvt
         Hgmc2NfkKeNWexfInjg7fzpxxPYx4CSHRLCkGW1VfU/owGYEF/QtXCbn+vDvCzQIMfDs
         tJo8cZKRyLLPYPl3UOEVt+n/zUzvlZ3pSWEbT42Aa0YXPfgfAh2pizXsE2mGqPfZld3C
         xWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzMjUx0ZO/It0Dd8vSGdcMIm3q52MpoewkmgYHUaSnqyVvBvPFLnor7BlCi6413rnILxs0w/qytbLa@vger.kernel.org
X-Gm-Message-State: AOJu0YycZDZYocda4bHfye6X9kuTSiX6CYUVnubKUTvKWHoKu/vGGNim
	c1QHFNwU9Ssstf95iEuGT84ukW8NoqNSalw/eyERfrzFUv0XE/2lcejGxm3p/MkT7DnILQwz3/T
	sT7cH4FGA3hGaQs/BNEkLrw8hZtc61EKBZ3sSqRTJifohMWXZai0FaBJTHEc=
X-Google-Smtp-Source: AGHT+IGV/vmcOJppMjmvKEjjQJU8CcsxIXujF1febzAXDp9rprnfabmGVT7kwNAJwOtVnimBVNYTCCYWMSzYzwLc01EiFXk2wQZz
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:341b:b0:87c:4496:329d with SMTP id
 ca18e2360f4ac-8800f104e04mr1771256539f.5.1753651536014; Sun, 27 Jul 2025
 14:25:36 -0700 (PDT)
Date: Sun, 27 Jul 2025 14:25:36 -0700
In-Reply-To: <67f0b437.050a0220.0a13.022c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68869950.a00a0220.b12ec.006c.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_assoc_bh_rcv
From: syzbot <syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ec2df4364666 Merge tag 'spi-fix-v6.16-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=126d74f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7753c32e11ff6a95
dashboard link: https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e838a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1084a782580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f86f1075111/disk-ec2df436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c90594c19d7f/vmlinux-ec2df436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8eac8db13156/bzImage-ec2df436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
 sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
 sctp_inq_push+0x2a3/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
 __release_sock+0x1d3/0x330 net/core/sock.c:3213
 release_sock+0x6b/0x270 net/core/sock.c:3767
 sctp_wait_for_connect+0x458/0x820 net/sctp/socket.c:9367
 sctp_sendmsg_to_asoc+0x223a/0x2260 net/sctp/socket.c:1886
 sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2032
 inet_sendmsg+0x269/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:727
 __sys_sendto+0x593/0x720 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2183
 x64_sys_call+0x3c0b/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x96d/0x12f0 mm/slub.c:4347
 kmalloc_reserve+0x22f/0x4b0 net/core/skbuff.c:601
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 sctp_packet_pack net/sctp/output.c:472 [inline]
 sctp_packet_transmit+0x18a1/0x46d0 net/sctp/output.c:621
 sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
 sctp_outq_flush+0x1c7d/0x67c0 net/sctp/outqueue.c:1221
 sctp_outq_uncork+0x9e/0xc0 net/sctp/outqueue.c:764
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
 sctp_do_sm+0x8c8e/0x9720 net/sctp/sm_sideeffect.c:1175
 sctp_assoc_bh_rcv+0x88b/0xbc0 net/sctp/associola.c:1034
 sctp_inq_push+0x2a3/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
 __release_sock+0x1d3/0x330 net/core/sock.c:3213
 release_sock+0x6b/0x270 net/core/sock.c:3767
 sctp_wait_for_connect+0x458/0x820 net/sctp/socket.c:9367
 sctp_sendmsg_to_asoc+0x223a/0x2260 net/sctp/socket.c:1886
 sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2032
 inet_sendmsg+0x269/0x2a0 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:727
 __sys_sendto+0x593/0x720 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0x130/0x200 net/socket.c:2183
 x64_sys_call+0x3c0b/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 5812 Comm: syz-executor343 Not tainted 6.16.0-rc7-syzkaller-00140-gec2df4364666 #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

