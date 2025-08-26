Return-Path: <linux-sctp+bounces-622-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D65B36942
	for <lists+linux-sctp@lfdr.de>; Tue, 26 Aug 2025 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1215678C7
	for <lists+linux-sctp@lfdr.de>; Tue, 26 Aug 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEE3568FC;
	Tue, 26 Aug 2025 14:11:49 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E83568EE
	for <linux-sctp@vger.kernel.org>; Tue, 26 Aug 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217509; cv=none; b=X8EXbuU4+GeNmcIESVQX8LKV63TpHphKnl+rGlhswfmaDEyep1LwnadQW9iiQOz+E6yh7Fe/bNpadqFg7YvGJO3RKOFTg8Ee/9qGuXuMxpvlJznvE6priiP5K3TG/tWyOqVI78qcJDH0MCSmZstMwhaNrOFamAMYGl53U9q/LZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217509; c=relaxed/simple;
	bh=IP84VAMKe+7JTHAUzdsvcaNy4u+T33/yrU6dHhzYJ7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MJQXjgpt+m2+ytJH3BgXIlFDnSBIDn/afoJO0kR4dSuw8rFnDcPs+8bK5jW8OveURKBrFoJUEfKnBZOi5wgE8/iNCcnWgteD2PS8DuPuHQcG5FEyDUzgn1WtmTrchJNQpY4qzB2Speptd7/OQG+THhQguVuRp1yLNdOwcij3Zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886b489984cso1365815339f.0
        for <linux-sctp@vger.kernel.org>; Tue, 26 Aug 2025 07:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217506; x=1756822306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pj99mwpeuh+2ZIqK32jcmt2O8E4ycT5xDz+MznD3w5c=;
        b=aydia6nfNXSzn6cNpl5do4lxpK63GMTwzyeEIbDWhxbNcUks09uVNhNx942hPdv50T
         S4a4e0dJcrWlLxXb4AHKKfnWxcguaSEyzXjYtXkkRkGBIugEww9dGyDJ3Q2u+ZBfUF/9
         yZPPDcJPGTBDrTr3tOm+GIRU+nSz+gA7T5Y7LeyhC4VP/nGKQ1NvMhFIru8KQ/FpKhxe
         uDs3Al8spWwIFeZ+N+kwZ9PbucDJBGjP74y5DHHhjy1YMTixbSG8o4Ke9DJTwhits577
         bJFb54oVhUz4gLS6ZsFL16Ri+ruzwLibBBPJ4MhrIJQ83LszrLxP6wOJUO2VadiH/tgP
         0kaw==
X-Forwarded-Encrypted: i=1; AJvYcCVD8fdFE6MgWZij70qqiPHoZQa3qTeQ/Gyvm69a6MXdCApKEEexdALcBEaf87RK2kAFusR33GyZ7IYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oMYq780gF4hP9YQkGt6z5uA8vHd5gaZQa2W1tcZD6d28n5hy
	N/TmeCDaAmuKNDkCe8ATb9l4OrJHHgoG6cbHa0iGaoOVnVOEOhq+WDewLDMjl+7o6pia/xsUhyX
	HMTcNvdzK2uJqKiXrPGlUNCCkexALmluTYrNRsTaKbeeogJ/UX2darSOtp+4=
X-Google-Smtp-Source: AGHT+IFDGCMXRz7a4pX8apUV6UfYH//IeuRbVeU+ESSTX+Rav46Nqm4Ry1ybDr1OfMxJhH2AcDn1fhDL5IX0YIwfvK2EmElpyH/g
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e92:b0:3ef:8763:bf96 with SMTP id
 e9e14a558f8ab-3ef8763cd79mr4521405ab.7.1756217506060; Tue, 26 Aug 2025
 07:11:46 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:11:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68adc0a2.050a0220.37038e.00c4.GAE@google.com>
Subject: [syzbot] [sctp?] KMSAN: uninit-value in __sctp_v6_cmp_addr (2)
From: syzbot <syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69fd6b99b8f8 Merge tag 'perf_urgent_for_v6.17_rc3' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10adec42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ccfdce02093e91f
dashboard link: https://syzkaller.appspot.com/bug?extid=e69f06a0f30116c68056
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130d8462580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bfb862580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce22f4296138/disk-69fd6b99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36a2af954ef6/vmlinux-69fd6b99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/594a8181f23a/bzImage-69fd6b99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
 __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
 sctp_inet6_cmp_addr+0x4f2/0x510 net/sctp/ipv6.c:983
 sctp_bind_addr_conflict+0x22a/0x3b0 net/sctp/bind_addr.c:390
 sctp_get_port_local+0x21eb/0x2440 net/sctp/socket.c:8452
 sctp_get_port net/sctp/socket.c:8523 [inline]
 sctp_listen_start net/sctp/socket.c:8567 [inline]
 sctp_inet_listen+0x710/0xfd0 net/sctp/socket.c:8636
 __sys_listen_socket net/socket.c:1912 [inline]
 __sys_listen net/socket.c:1927 [inline]
 __do_sys_listen net/socket.c:1932 [inline]
 __se_sys_listen net/socket.c:1930 [inline]
 __x64_sys_listen+0x343/0x4c0 net/socket.c:1930
 x64_sys_call+0x271d/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:51
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable t.i created at:
 __do_sys_futex kernel/futex/syscalls.c:165 [inline]
 __se_sys_futex+0x4d/0x740 kernel/futex/syscalls.c:160
 __x64_sys_futex+0x114/0x1a0 kernel/futex/syscalls.c:160

CPU: 1 UID: 0 PID: 6089 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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

