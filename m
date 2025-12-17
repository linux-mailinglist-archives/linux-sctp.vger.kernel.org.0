Return-Path: <linux-sctp+bounces-766-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E5CC8F79
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Dec 2025 18:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F90F30422BB
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Dec 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937E1A9FAA;
	Wed, 17 Dec 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ1vhigx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F87249EB
	for <linux-sctp@vger.kernel.org>; Wed, 17 Dec 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990401; cv=none; b=dvTD5LdejevWJrfuegomlwR+k5F5c8RhWgVxGF38aw9K2jmP4uOfF7CDEMIRFaptPmiznV3qxBZNUxVDMaC1KZcT+r6e7r2/ZQMSmuXm68FmLbAyl6+dOt/saG5mV4H5NZHXqC7C94xq2401FAbTFmpCK+16IhGn0qelp9dayj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990401; c=relaxed/simple;
	bh=GJJVUvbBTP2WFINewh6OrHLCpmnU2XQ6SIMRtU8Ah78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRrXu4yoqv1mALuc5OqcXGhEezk4w/Wnv43saSzAQTiqPRD7ElcC7NXQ0sDSX2eLBVfFu/VBw0NiVJDPKAhc4TU9XuE0v6KbJTh4HvPqJuF8NkfunPztcI/17DFzEH6pH/vg87ShtpfzLxm0OwLjY7YemNqlZ84fuC/FkMCPuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJ1vhigx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0c20ee83dso46498935ad.2
        for <linux-sctp@vger.kernel.org>; Wed, 17 Dec 2025 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990399; x=1766595199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDU86WOiqzmZjp50PLvvN68gkYYW/SlXdb1kbLDJ8G0=;
        b=TJ1vhigx+FfbyykAuaPEVIgXUp9pDgfCOJvk7LVLBnkRiiiGON9wv9KC7QFmRKpFk6
         e/wj/OOaS+r63WgHaQItQqgIum1LzpethJYGY0DMq9AFRYdrkdL7GijpOeKdp2Cl+jVz
         E+EbImu6TegQNj53gUnjXIe3ctEn+JA5LSE+WpxhZFCGZrYerzp6P0DQtmPTLYMwP4j/
         J1kkuUops4fna+lnwlUMRhgNGs7X/X9ykFo7PLoJSBKFWM8gt+Xyz2AQ+pfRq8AcsJly
         FHLD7PcZ+uviz7+jk3JRv0ZFuN1jGzRZxtNFXSqMH699tS/Q3E9mARdFtW6VVSiwh8gJ
         OSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990399; x=1766595199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDU86WOiqzmZjp50PLvvN68gkYYW/SlXdb1kbLDJ8G0=;
        b=TbXDzaDXlUeNZdRxxh7+hG0OzMoMxaLiKL/u0ZojfAegeXgqqID43/u2MwfD1dzIYl
         n8EEHNhweBEQIT44YsDgH7D/p0zNZc2mU1A1CzzFKIx/J2CgJKQsSqm/WvF2fEpEKfjm
         l6FxPgeIt/K7jeu5i5mr09/+Adxy1xlk9W9Z7EHUG2F5x3rXdrcTI6oL6GhH+4hWPylT
         Uqq3b0WHr2UQZmfiHGXcfJ62XnRXHvC6TI6L6i+3ZpJmhE4fjBTK+n4SkoYcl/c1Xh3r
         iMRJvBxY9Fdv2d9P4DtImmzOXulRjjs5cOQVC+bo2ZtFNQauRQ/ztzWxVwUx/+jYs9ig
         Ra7g==
X-Forwarded-Encrypted: i=1; AJvYcCXBeZadAtdYcqJ/15PTbYvTAuMPbSlB+G6ggJL6eNNAtSksgIZ5ZaUwx3+Z3Ip/g8q5ckcNUQVNCq9n@vger.kernel.org
X-Gm-Message-State: AOJu0Yylj7CRCefVFN7JmUEcGWNBjSSxu9iBH1OvEy8n3MsxnbOZ5m4p
	M0pOdowVPugJzkAY+25gjO+IwXUJqc4zz3L+ONdVZeEjONrPhrxQXArjcn+vw6hA5QnnipVT3K7
	GAr6yvbhAUJGoSZGa/NyHHlkoVWVclPs=
X-Gm-Gg: AY/fxX6bl4Us4VVO7fcmIKu7ctDj1EQ6zhCQhenYoSGm6/PR4yGi+3IEn17ltk8lFFv
	8cLdvE5XKc7OR+rjTUXORoSPJOBvwbWUMYONKUkTTFBlocNJ4yD1fhl8T+fFdknIMJPseBm1+Ay
	kB7avgCxzjjOtRh/kI94kdjX0lWp8IWAxTx9TxPgX4z0wQFQmXFRdX1ppp9T2AJseF0j9Iw6Dk6
	+dI7KbHGXK0GDfPT2Uz4SnrIu3a6FZx0R5zz75OUt4npnmf7cAk2E3JDoXk6uLsMLSbPmvn7w==
X-Google-Smtp-Source: AGHT+IHEIhVqS/k14BowC3gmu4SpK5DIA3uID1AT6F2b5DL0ZauhPKJlqVlxn+KCwLl558h3dlxF+gVpBL+q6YGosZ4=
X-Received: by 2002:a17:902:cec1:b0:2a0:c1fc:3de5 with SMTP id
 d9443c01a7336-2a0c1fc4006mr109566925ad.51.1765990399299; Wed, 17 Dec 2025
 08:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5a9e456-415c-0a7c-8e73-ba3c297447f0@huawei.com>
In-Reply-To: <f5a9e456-415c-0a7c-8e73-ba3c297447f0@huawei.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 17 Dec 2025 11:53:06 -0500
X-Gm-Features: AQt7F2rRWSIhyLeK6Yc0QrUbbUlgW00QR-OVtOljqrMG5VE1zuNGOwYj0YuZHdM
Message-ID: <CADvbK_d082m8hWfbK5-khpAtGtRsC_6yO4dBvdM0q71xo=umdw@mail.gmail.com>
Subject: Re: [BUG] null-ptr-deref bug in sctp_packet_bundle_auth
To: Chen Zhen <chenzhen126@huawei.com>
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	huyizhen2@huawei.com, gaoxingwang1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:13=E2=80=AFAM Chen Zhen <chenzhen126@huawei.com> =
wrote:
>
> Hi all,
>
> We tested with syzkaller on linux-6.6 and it reported a null-ptr-deref bu=
g:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> general protection fault, probably for non-canonical address 0xdffffc0000=
000003: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G W 6.6.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
> RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
> Code: 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 93 05 00 00 48 b8 00 00 00 0=
0 00 fc ff df 4c 8b 7b 40 49 8d 7f 1c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48=
 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 57
> RSP: 0018:ffffc9000010efe8 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff88810c746000 RCX: ffffffff8d758fca
> RDX: 0000000000000003 RSI: ffff888100d1cd40 RDI: 000000000000001c
> RBP: ffff88811dea8b78 R08: 0000000000000000 R09: fffffbfff27f8b7d
> R10: fffffbfff27f8b7c R11: ffffffff93fc5be7 R12: ffff88804247c000
> R13: ffff88811dea8bb8 R14: ffff88810c746040 R15: 0000000000000000
> FS: 0000000000000000(0000) GS:ffff88816e600000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000021000000 CR3: 000000011dfb4002 CR4: 0000000000170ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Call Trace:
>
> sctp_packet_transmit_chunk+0x31/0x250 net/sctp/output.c:189
> sctp_outq_flush_data+0xa29/0x26d0 net/sctp/outqueue.c:1111
> sctp_outq_flush+0xc80/0x1240 net/sctp/outqueue.c:1217
> sctp_cmd_interpreter.isra.0+0x19a5/0x62c0 net/sctp/sm_sideeffect.c:1787
> sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
> sctp_do_sm+0x1a3/0x670 net/sctp/sm_sideeffect.c:1169
> sctp_assoc_bh_rcv+0x33e/0x640 net/sctp/associola.c:1052
> sctp_inq_push+0x1dd/0x280 net/sctp/inqueue.c:88
> sctp_rcv+0x11ae/0x3100 net/sctp/input.c:243
> sctp6_rcv+0x3d/0x60 net/sctp/ipv6.c:1127
> ip6_protocol_deliver_rcu+0x12c1/0x1e40 net/ipv6/ip6_input.c:438
> ip6_input_finish+0xc8/0x260 net/ipv6/ip6_input.c:483
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ip6_input+0xd1/0x430 net/ipv6/ip6_input.c:492
> dst_input include/net/dst.h:487 [inline]
> ip6_rcv_finish+0x1b9/0x5c0 net/ipv6/ip6_input.c:79
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ipv6_rcv+0xf8/0x440 net/ipv6/ip6_input.c:310
> __netif_receive_skb_one_core+0x133/0x1f0 net/core/dev.c:5603
> __netif_receive_skb+0x24/0x1c0 net/core/dev.c:5717
> process_backlog+0x21d/0x7e0 net/core/dev.c:6045
> __napi_poll+0xc2/0x690 net/core/dev.c:6607
> napi_poll net/core/dev.c:6674 [inline]
> net_rx_action+0x87d/0xce0 net/core/dev.c:6810
> handle_softirqs+0x1b4/0x700 kernel/softirq.c:578
> run_ksoftirqd kernel/softirq.c:997 [inline]
> run_ksoftirqd+0x2f/0x60 kernel/softirq.c:989
> smpboot_thread_fn+0x3b9/0x860 kernel/smpboot.c:164
> kthread+0x324/0x420 kernel/kthread.c:388
> ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:152
> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293
>
> Modules linked in:
> kernel fault(0x1) notification starting on CPU 0
> kernel fault(0x1) notification finished on CPU 0
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
> RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
> Code: 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 93 05 00 00 48 b8 00 00 00 0=
0 00 fc ff df 4c 8b 7b 40 49 8d 7f 1c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48=
 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 57
> RSP: 0018:ffffc9000010efe8 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff88810c746000 RCX: ffffffff8d758fca
> RDX: 0000000000000003 RSI: ffff888100d1cd40 RDI: 000000000000001c
> RBP: ffff88811dea8b78 R08: 0000000000000000 R09: fffffbfff27f8b7d
> R10: fffffbfff27f8b7c R11: ffffffff93fc5be7 R12: ffff88804247c000
> R13: ffff88811dea8bb8 R14: ffff88810c746040 R15: 0000000000000000
> FS: 0000000000000000(0000) GS:ffff88816e600000(0000) knlGS:00000000000000=
00
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000021000000 CR3: 000000011dfb4002 CR4: 0000000000170ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> Code disassembly (best guess):
> 0: 4c 89 f2 mov %r14,%rdx
> 3: 48 c1 ea 03 shr $0x3,%rdx
> 7: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
> b: 0f 85 93 05 00 00 jne 0x5a4
> 11: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
> 18: fc ff df
> 1b: 4c 8b 7b 40 mov 0x40(%rbx),%r15
> 1f: 49 8d 7f 1c lea 0x1c(%r15),%rdi
> 23: 48 89 fa mov %rdi,%rdx
> 26: 48 c1 ea 03 shr $0x3,%rdx
>
> 2a: 0f b6 14 02 movzbl (%rdx,%rax,1),%edx <-- trapping instruction
> 2e: 48 89 f8 mov %rdi,%rax
> 31: 83 e0 07 and $0x7,%eax
> 34: 83 c0 01 add $0x1,%eax
> 37: 38 d0 cmp %dl,%al
> 39: 7c 08 jl 0x43
> 3b: 84 d2 test %dl,%dl
> 3d: 0f .byte 0xf
> 3e: 85 .byte 0x85
> 3f: 57 push %rdi
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The direct cause is that chunk->shkey is NULL in sctp_packet_bundle_auth(=
).
>
>         if (!chunk->auth)
>                 return retval;
>
>         auth =3D sctp_make_auth(asoc, chunk->shkey->key_id);    <=3D=3D=
=3D BUG
>         if (!auth)
>                 return retval;
>
> It is simple to fix it by adding a null-ptr check before sctp_make_auth()=
 but maybe
> there are better solutions?
>
We need to check how this was triggered? Do you have a reproducer for this?

Thanks.

