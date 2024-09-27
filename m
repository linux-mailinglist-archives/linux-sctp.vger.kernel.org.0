Return-Path: <linux-sctp+bounces-260-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A11419888B1
	for <lists+linux-sctp@lfdr.de>; Fri, 27 Sep 2024 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993EB1C20EEB
	for <lists+linux-sctp@lfdr.de>; Fri, 27 Sep 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0C16D9AE;
	Fri, 27 Sep 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjNAgSor"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60913CA81;
	Fri, 27 Sep 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453065; cv=none; b=kdcVkaT5dEoCksH+1Y2VyqzNTnU1EvzzkRai8JNBJkEWXLdvR4HTNXI9kgU6smDbxaiijWrGLOnyMgczCpTAPiZ7H7PxSRMCyUMw4Teh3GEhmqA35bIT8QMXiyGSKqySMlhkrT1GYDbdQXBIuf+Z8nAU4GViueCao4SZcnF89i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453065; c=relaxed/simple;
	bh=Gu4nG96kzcucKdcN6xH7Hfcnj7tf2Rp8UdR4tx9Ffjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+a8CcLT+82NuA3RYrCewTV7DomSKURl4tGDZ4HunDNKMcnbS1semQGgzvfQoo4SkSMeBYyUq7YwK9Gb++cQjGK1AiPVcS3zDqut2eQ2CLnKvRs7TTYqmR3m/nfH5H/hrUKD6Y14hs6gcANsl7p3Gpy233+4xhhjKTYIMTjFu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjNAgSor; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0c8b81b4eso9637605ab.0;
        Fri, 27 Sep 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727453062; x=1728057862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg2l6UGtum/7AudqJcwWoets59MOCUr9IF+C08Kwo9w=;
        b=YjNAgSorLirhDGirMiJHB9lAfYB5tbsUGLIshviD7O5VydiWMf8iUyCcleMncdjLGd
         qTcSNj7wlJF23AA1a18lo8ppLiuZA7xaRJtN+0GR4gXygu12z4989aMUXyItwz9brz6D
         dlSCqhDUpSRlhPKYAJD5ag/OhaqqXf+shPWcU/zHPop8XBCtzqOVm+QAyOxjRQ9wkdFd
         IGA4X8j0WIgzm1kV8pdkFXJClbllVXixAt6fWChdjZrXXUr8f9exQCcBq66y77VS1lyL
         WJ2HQvv+Z8G//Pi1iOHnfoYFNRzol2x4NFCalXmZpMyV9I/HljAtS9dWWtMfE/Q5ur5t
         CLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453062; x=1728057862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg2l6UGtum/7AudqJcwWoets59MOCUr9IF+C08Kwo9w=;
        b=q0KosktuwFr+7iO7m4R1Jlezpg1ROBliseXw7MMXQLtqoAk/Iq1Qpgz95za4mx7TCv
         fZ2ZaxoBo0ukgHm20qZGEV7iHobqiGpj5TfeATG05i+GpaH0DklsrKifNTPkGRT2fw1y
         uOItwj3Mh7nOUe8BgE6ItP0XtYFIfavR1+fIT2wEncd1GuuZBX43aPArwS2LnzjVj5g1
         6EiS2jJEfJjTWP5GdUI3imxlqQYxXZzQgVtS7S2R3XFuE3gnS1Hf1gQ2Sx4NB2SFzuXj
         OKgxKI9UK/4ui+RoJ6wO5TcYS+eRRU+wCQnWTVXRuniaueoCmqgt57IoTjdqxmZuxN3F
         On7A==
X-Forwarded-Encrypted: i=1; AJvYcCVioPiV97HJp8KuYTPs2OzRgrIfuydp/mjHFkB2xtLP7FC0mS5DDAvO8rNMjTT1jQ+kqpa7eYd9SZ56iw==@vger.kernel.org, AJvYcCW3MbGhkdzUY/w1cA+P6MA4R7h+NXcCzNIiEx8xnzl3kgure0AwmDQsWz4p3f3XR9OJD0jYJYo4@vger.kernel.org, AJvYcCX+Hjj00+Pf99MpIBHHyE5rr4bp5OHnbGKw3cv0qWRJV6JUOGzeij1h5Y+0eBjZaxLIk4rI6B4x3MhJMdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0UPRmllXbwXgQ16LYEnEPtLXdrmr+0Lw3xZ2r2SBO38NlSC0
	6FC9lTiP64xV5VCXJE4WRfWh32kW7OCk/rbfoQYIq37ji0f9Yg9T+gdWSV8bD/bdkHybNFnM4+9
	laBgxFZMHd+iOeR+3j/3QYQ6GSwI=
X-Google-Smtp-Source: AGHT+IEbjcly4ZSXbWX9GWV9zM/1K7tqjTq3D0Rfh9Q96eNhxC2541Z+C3b8vuL1ICAaIRXgAsZeFsyI1BonMXhXHvc=
X-Received: by 2002:a05:6e02:152a:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a3451bc28cmr39565755ab.21.1727453062222; Fri, 27 Sep 2024
 09:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f6c84c.050a0220.38ace9.0027.GAE@google.com>
In-Reply-To: <66f6c84c.050a0220.38ace9.0027.GAE@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 27 Sep 2024 12:04:10 -0400
Message-ID: <CADvbK_cwG6b_PGji2bBp4=tGSxHi-ZMxjXAmKdzT1sKXr0_Uwg@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] general protection fault in sctp_inet_listen
To: syzbot <syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 10:59=E2=80=AFAM syzbot
<syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    196145c606d0 Merge tag 'clk-fixes-for-linus' of git://git=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16f8549f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D61d235cb8d150=
01c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df4e0f821e3a3b7c=
ee51d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/629d679a6d66/dis=
k-196145c6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aec0dd4a04f3/vmlinu=
x-196145c6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/68e515733997/b=
zImage-196145c6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 10078 Comm: syz.4.940 Not tainted 6.11.0-rc7-syzkaller=
-00097-g196145c606d0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
In sctp_listen_start() invoked by sctp_inet_listen(), it should set the
socket state back to CLOSED if sctp_autobind() fails due to whatever
reason:

@@ -8557,8 +8557,10 @@ static int sctp_listen_start(struct sock *sk,
int backlog)
         */
        inet_sk_set_state(sk, SCTP_SS_LISTENING);
        if (!ep->base.bind_addr.port) {
-               if (sctp_autobind(sk))
+               if (sctp_autobind(sk)) {
+                       inet_sk_set_state(sk, SCTP_SS_CLOSED);
                        return -EAGAIN;
+               }

Otherwise, next time when calling sctp_inet_listen(), if sctp_sk(sk)->reuse
is already set via setsockopt(SCTP_REUSE_PORT), sctp_sk(sk)->bind_hash will
be dereferenced as the state is LISTENING, and causes crash as bind_hash is
NULL.

> Code: 8d 98 00 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 d=
f e8 6e 4e 05 f7 48 8b 1b 48 83 c3 02 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28=
 84 c0 0f 85 8e 01 00 00 c6 03 01 31 db e9 d6 f9 ff
> RSP: 0018:ffffc90002eafd20 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88802e973c00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90002eafe78 R08: ffffffff8af5839c R09: 1ffffffff283c920
> R10: dffffc0000000000 R11: fffffbfff283c921 R12: 1ffff1100fc7e242
> R13: dffffc0000000000 R14: ffff88807e3f1212 R15: 1ffff1100fc7e2ff
> FS:  0000000000000000(0000) GS:ffff8880b8900000(0063) knlGS:00000000f5735=
b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 00007fadae30cff8 CR3: 0000000050d9a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __sys_listen_socket net/socket.c:1883 [inline]
>  __sys_listen+0x1b7/0x230 net/socket.c:1894
>  __do_sys_listen net/socket.c:1902 [inline]
>  __se_sys_listen net/socket.c:1900 [inline]
>  __ia32_sys_listen+0x5a/0x70 net/socket.c:1900
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf7fd6579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90=
 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f573556c EFLAGS: 00000206 ORIG_RAX: 000000000000016b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
> Code: 8d 98 00 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 d=
f e8 6e 4e 05 f7 48 8b 1b 48 83 c3 02 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28=
 84 c0 0f 85 8e 01 00 00 c6 03 01 31 db e9 d6 f9 ff
> RSP: 0018:ffffc90002eafd20 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88802e973c00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90002eafe78 R08: ffffffff8af5839c R09: 1ffffffff283c920
> R10: dffffc0000000000 R11: fffffbfff283c921 R12: 1ffff1100fc7e242
> R13: dffffc0000000000 R14: ffff88807e3f1212 R15: 1ffff1100fc7e2ff
> FS:  0000000000000000(0000) GS:ffff8880b8900000(0063) knlGS:00000000f5735=
b40
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 000055f65cf85950 CR3: 0000000050d9a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   8d 98 00 06 00 00       lea    0x600(%rax),%ebx
>    6:   48 89 d8                mov    %rbx,%rax
>    9:   48 c1 e8 03             shr    $0x3,%rax
>    d:   42 80 3c 28 00          cmpb   $0x0,(%rax,%r13,1)
>   12:   74 08                   je     0x1c
>   14:   48 89 df                mov    %rbx,%rdi
>   17:   e8 6e 4e 05 f7          call   0xf7054e8a
>   1c:   48 8b 1b                mov    (%rbx),%rbx
>   1f:   48 83 c3 02             add    $0x2,%rbx
>   23:   48 89 d8                mov    %rbx,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 0f b6 04 28          movzbl (%rax,%r13,1),%eax <-- trapping in=
struction
>   2f:   84 c0                   test   %al,%al
>   31:   0f 85 8e 01 00 00       jne    0x1c5
>   37:   c6 03 01                movb   $0x1,(%rbx)
>   3a:   31 db                   xor    %ebx,%ebx
>   3c:   e9                      .byte 0xe9
>   3d:   d6                      (bad)
>   3e:   f9                      stc
>   3f:   ff                      .byte 0xff
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

