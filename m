Return-Path: <linux-sctp+bounces-192-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50094607A
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Aug 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D43286A28
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Aug 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765C175D56;
	Fri,  2 Aug 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIKxU8MX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758FC1537CA;
	Fri,  2 Aug 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612319; cv=none; b=TFi6NcW4CXrT7Qx1gUqQjY6KO8TrmnQEvcSC1Tqzvz7tejlu7uqgUAFOCpqN+P16/H5fML3Z5Uy0DScFvtY+nP/6DOd1byx9ZIVLRD1kqy1OlxGeQ+0h32fwxEpEqktU7FOpaEbc4+rZ+Cuqfa6zCe73qIdusOIUjCRfTaBe+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612319; c=relaxed/simple;
	bh=wY1KLAC2fh+ZcwsgVVv5v/qHWEK1TKOSeKoW450qjHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdL2fGPug4q06+GEFHqSJQsq5qqFwmez7NDfa/c9bnlmjoIREVkXtpb2rb4yIKEnaEacSlPvGgtdxiQMpO4tGcBPpCymMD4Cbv2qfRH87geBRJ661ZVW3mgy8NcfmpzMepn46yFzPzzlPQ2g0Tbae8+CfyK7FIGJ3Vp/iyu2d+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIKxU8MX; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39728bbf949so38460555ab.3;
        Fri, 02 Aug 2024 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722612316; x=1723217116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTcGq2BgWzPkbjAKTT+PEccBFOTJFGD2LfzafDItPQ4=;
        b=HIKxU8MXtq4qwgwNxOEQan8XPcHFnrCTFFbvjGyDaALRMEb9a3d7ZHlZkT6qm888l5
         bifTB53D/MiVHkLznZWSE+bKwX8eThuj0p3mkeW2aZ10lv4q94AIiUlxkpJVT8CY/eQy
         KJm+pZBrj4aLnoqGW0SuqNvw8gGfW07O3NXGjUW/cRH81b92DKxF/EXDGxwE+OyDUsHW
         QH6K8tQLX+wXd/cxCLmwjdoz4tkDx45Af5FWhwwj3z+smpWkLkbhMRwDKcNbwEb9g+Yu
         oNxxFh+ivylwLfO12gZjUOLs8XzDBlprqZFVKnLjXdOF6Rr5oM50eyqeoyItdNrNC0jk
         1KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722612316; x=1723217116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTcGq2BgWzPkbjAKTT+PEccBFOTJFGD2LfzafDItPQ4=;
        b=HsxL2+54eVSZunrW3M/r9yPlDh5hAYXhjwRBPXbN2zLWSxn2rDr1J/SOBbN9jzpmkA
         bg7GcPw69RZ1dKi1OCxIGLZK+UrV0vZRUqeRi54+e3Oxdzw6LChoxxIPOONVoDuP940J
         wkPp3WxjDN82rTITQOUZUDeurUv0nr9oXZjD9Nfpdlbi5qrqPdMM6QSIupOdvsEQYCmn
         vgf6VCTb8vwWwMdEXwTm9nnPPe/SAbNDVcWRd/fwQKFMG+hDl4SA+tB6t9PknqGB3GXn
         5jUvuJiCwUav+/bWITkPdSdD4G1wdPnX9Q5kkHHJaPPletu+3jMqSfeBOEJ7ES/vSm17
         +1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV/j9esrmZ+5Oz3FI/6tjFA8/06yDPtZRQGPNDGSFR2kgFueroreOwN4757xq9lIdZLMg6NyNCeFigQk+CnOWWCxt1FN+sXgfRwkiu0ZJVMXRXqFOeGH74RzlEuMyHTc7QTMg==
X-Gm-Message-State: AOJu0Yz77mrtTtlJPWc/705/EJA7CMiM/dVY4MnYZLY8J3hSawD7dFC/
	fSRDJ1p6y2IanQwgahhjnwrlwTPCOZTn5XEt+2r04646NSc/46eRNdib4NBuuzn5vvalsHnzJA5
	2+b1UGQBBfCvYUs6dw4S1bSRy028=
X-Google-Smtp-Source: AGHT+IETmWNghiQ70ufBYJVYvG8OIsLLrrpogf/1Zu7V8jrglBxZerBH2o2psnLIAekCrEtL7Ck+/J6xvro1J4XI4A4=
X-Received: by 2002:a92:d3c2:0:b0:398:17c8:6bd9 with SMTP id
 e9e14a558f8ab-39b1fb9253dmr44697015ab.8.1722612316413; Fri, 02 Aug 2024
 08:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731234624.94055-1-kuniyu@amazon.com>
In-Reply-To: <20240731234624.94055-1-kuniyu@amazon.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 2 Aug 2024 11:25:05 -0400
Message-ID: <CADvbK_eRc7pgp_E95hjWK4wBSnY7RAtmqi3wPk+0+7f1O06p5w@mail.gmail.com>
Subject: Re: [PATCH v2 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzbot reported a null-ptr-deref while accessing sk2->sk_reuseport_cb in
> reuseport_add_sock(). [0]
>
> The repro first creates a listener with SO_REUSEPORT.  Then, it creates
> another listener on the same port and concurrently closes the first
> listener.
>
> The second listen() calls reuseport_add_sock() with the first listener as
> sk2, where sk2->sk_reuseport_cb is not expected to be cleared concurrentl=
y,
> but the close() does clear it by reuseport_detach_sock().
>
> The problem is SCTP does not properly synchronise reuseport_alloc(),
> reuseport_add_sock(), and reuseport_detach_sock().
>
> The caller of reuseport_alloc() and reuseport_{add,detach}_sock() must
> provide synchronisation for sockets that are classified into the same
> reuseport group.
>
> Otherwise, such sockets form multiple identical reuseport groups, and
> all groups except one would be silently dead.
>
>   1. Two sockets call listen() concurrently
>   2. No socket in the same group found in sctp_ep_hashtable[]
>   3. Two sockets call reuseport_alloc() and form two reuseport groups
>   4. Only one group hit first in __sctp_rcv_lookup_endpoint() receives
>       incoming packets
>
> Also, the reported null-ptr-deref could occur.
>
> TCP/UDP guarantees that would not happen by holding the hash bucket lock.
>
> Let's apply the locking strategy to __sctp_hash_endpoint() and
> __sctp_unhash_endpoint().
>
> [0]:
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 UID: 0 PID: 10230 Comm: syz-executor119 Not tainted 6.10.0-syzkall=
er-12585-g301927d2d2eb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/27/2024
> RIP: 0010:reuseport_add_sock+0x27e/0x5e0 net/core/sock_reuseport.c:350
> Code: 00 0f b7 5d 00 bf 01 00 00 00 89 de e8 1b a4 ff f7 83 fb 01 0f 85 a=
3 01 00 00 e8 6d a0 ff f7 49 8d 7e 12 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28=
 84 c0 0f 85 4b 02 00 00 41 0f b7 5e 12 49 8d 7e 14
> RSP: 0018:ffffc9000b947c98 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: ffff8880252ddf98 RCX: ffff888079478000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000012
> RBP: 0000000000000001 R08: ffffffff8993e18d R09: 1ffffffff1fef385
> R10: dffffc0000000000 R11: fffffbfff1fef386 R12: ffff8880252ddac0
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f24e45b96c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcced5f7b8 CR3: 00000000241be000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __sctp_hash_endpoint net/sctp/input.c:762 [inline]
>  sctp_hash_endpoint+0x52a/0x600 net/sctp/input.c:790
>  sctp_listen_start net/sctp/socket.c:8570 [inline]
>  sctp_inet_listen+0x767/0xa20 net/sctp/socket.c:8625
>  __sys_listen_socket net/socket.c:1883 [inline]
>  __sys_listen+0x1b7/0x230 net/socket.c:1894
>  __do_sys_listen net/socket.c:1902 [inline]
>  __se_sys_listen net/socket.c:1900 [inline]
>  __x64_sys_listen+0x5a/0x70 net/socket.c:1900
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f24e46039b9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f24e45b9228 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
> RAX: ffffffffffffffda RBX: 00007f24e468e428 RCX: 00007f24e46039b9
> RDX: 00007f24e46039b9 RSI: 0000000000000003 RDI: 0000000000000004
> RBP: 00007f24e468e420 R08: 00007f24e45b96c0 R09: 00007f24e45b96c0
> R10: 00007f24e45b96c0 R11: 0000000000000246 R12: 00007f24e468e42c
> R13: 00007f24e465a5dc R14: 0020000000000001 R15: 00007ffcced5f7d8
>  </TASK>
> Modules linked in:
>
> Fixes: 6ba845740267 ("sctp: process sk_reuseport in sctp_get_port_local")
> Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De6979a5d2f10ecb700e4
> Tested-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

