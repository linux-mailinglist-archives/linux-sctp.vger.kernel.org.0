Return-Path: <linux-sctp+bounces-769-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C877D0C67C
	for <lists+linux-sctp@lfdr.de>; Fri, 09 Jan 2026 23:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF58830090C5
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Jan 2026 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738983009D4;
	Fri,  9 Jan 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl/PSo03"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9134402B
	for <linux-sctp@vger.kernel.org>; Fri,  9 Jan 2026 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767996151; cv=none; b=qbXt4v3EwtGFmlaEBGePQqNHD1BxgBZpmBgD5j6fy7DpfJchTTRM+EwemEozVNgsRLmVor5Urf4Me6t+AQSwu+I0QIpFADURCRjwvVH/h1zrDBLregXMMofus0ymDgtUzRQh6dV62fk0Xi/OWrFZ5LASdIKziP+Kkq0Y6U3TBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767996151; c=relaxed/simple;
	bh=hR7bFQ80u7j/da7yrq3uCLTzJHwyiDzRSFrhv65eQ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fy1LScOfV9s/+tr8jFg9/mCeSEbpIPAk889YhTikDWrRaY/I+2Itka+0DMl43AFxvi02RuW0TwP+XvWx9s0zoRLkjRgJlfmFybQbeZLo1S5FQwB38BRuaZNjq05mdYznSVptdTGd0G207Y9uTMILLeeDXBhbKhkJG9VrnfosctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl/PSo03; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c3259da34so2972956a91.2
        for <linux-sctp@vger.kernel.org>; Fri, 09 Jan 2026 14:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767996136; x=1768600936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7r7wasTeqR65W2FOrxQS2dVTUOca2QVhUU7T/+3mME=;
        b=nl/PSo034OhGs9ziYXK5C3gq0g44DIUycwts/SpMpOr5Kev/nQxuOoa5aWVXFdt68+
         hq8oGrNS1suFf7sjaa5IMU0wrHR3OM00D7GUcvMiN6A7P8yqM/bcdkCkRl2ij2Vh3n23
         yt2soanNPGQEhs4yf/XTtJWac1asuneVQKqRkJDsDn0X+d59ueyJWoKK5mdYsOUn9MHh
         aQvZBn0bJmE/JRRlA+S4KR0bp7voi1lv4SgEVueyK6pKvVXR8D6c8B9QLkbmFFzeIKUO
         UpchQkYdbOCEmy6psn7NusppMpbmgKgcGfxqnOs4zmksRxSZTMlgU7sV+IctvrjuAsoR
         RqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767996136; x=1768600936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7r7wasTeqR65W2FOrxQS2dVTUOca2QVhUU7T/+3mME=;
        b=qe5OH/7dhENHV21lmqnRDLeTGSMaUu9aFMyEnxrIayKyYmLLEcY9WhawXjUN2sVSM9
         cUmKsEeyTRN7stKCC55DYt0RowEK+39IyVet5yRwbW7gLaS1mjYctQtf+dDx5oSIlS8w
         CJIrPg+3Dk51ZjNw2zs1+CI8oD++XMi5Dwf4jipvoWKjf3GAWyH15vCuJrzF5VdGCzwf
         n9yOaR3M3kHnJdjQ7LgyfxwQ0i5gviC9Myy06aplwMY6heViTAbiIzjOY/tO+kmIGW0n
         xvOEaellMMKDtXFCs3ME8t7/P1ZW+rlANhc6dwNvGqiEUaKNEcPILlSTuziz65JxfhBf
         WzYg==
X-Forwarded-Encrypted: i=1; AJvYcCW9NXdet2YltGN99lBy9G6NGwXYSJI9JPkh9McXtdYlHkzSQ4gGQFhWI1lGiXUzP7+h7G/FDe4gZjfF@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuMYvctyzPfd+Sc7tWvuk7QrZREGpY/XB7MoL8LqLqvJ2WD1n
	L5EyHDsmabZaWroIlPpx+TN8eqkJfQIp7u29eckp7mPNdkj9SXM0YKyoAlrnXTcWhZ4RqsbYgp0
	sJHoLUKxGqdgjuJK9j/Cq6xSv2iND9F4=
X-Gm-Gg: AY/fxX7vLgNznSR+z2DTOsInX1pCP3N5gArkVIx0wPOvuVG92YF/q9HJU81sGTfJsPB
	/ihy2FnkNjnVBVJnJN4p1f1CKP55itrG2xSdHpzrd+33N4Je/V9pT/yo5GOE6xRL5y2xIdAa1H7
	MY4SBAE2uZ8Nnin4Q0bR7FqjJoV/ZHvGutR3szbOr4fS6ldoaYM4frLktUNpf5JtInQ00XLjKAe
	APdJLzdbbGI4OjX1J2POSY4dDD9IJCh5y/LhrIaV9ocMT/Anpr7SVBh5PEXtFxedz5108Cl1A==
X-Google-Smtp-Source: AGHT+IG7zPQLQwrNqV3EBjjQVHF9AtP2VwQ8KFXKEWlN0XuVzsnDVIinChzFJssrCYPJoIgwVx0YzkG9cxWQofXbuf0=
X-Received: by 2002:a17:90a:d890:b0:32e:a10b:ce33 with SMTP id
 98e67ed59e1d1-34f68c9138emr10338354a91.21.1767996136079; Fri, 09 Jan 2026
 14:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5a9e456-415c-0a7c-8e73-ba3c297447f0@huawei.com>
 <CADvbK_d082m8hWfbK5-khpAtGtRsC_6yO4dBvdM0q71xo=umdw@mail.gmail.com>
 <95232a2f-f8f8-3cba-ebf3-cefffac87323@huawei.com> <58c77f72-7d26-f325-23ec-6d6f85b7c7b8@huawei.com>
In-Reply-To: <58c77f72-7d26-f325-23ec-6d6f85b7c7b8@huawei.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 9 Jan 2026 17:02:03 -0500
X-Gm-Features: AZwV_QgWytpSiNzLsFOi5UvJsbX6IcEhuJ7OFXTEJ1RHN_8yfoD09U77q7szirM
Message-ID: <CADvbK_dvRiP05x-+rfvz0vbRO5a4iVmEFKmSsKiQnLEmKENNxw@mail.gmail.com>
Subject: Re: [BUG] null-ptr-deref bug in sctp_packet_bundle_auth
To: Chen Zhen <chenzhen126@huawei.com>
Cc: marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org, 
	huyizhen2@huawei.com, gaoxingwang1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:20=E2=80=AFAM Chen Zhen <chenzhen126@huawei.com> w=
rote:
>
> On 25/12/18 10:00, Chen Zhen wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Syzkaller reproducer:
> >
> > {Threaded:false Repeat:true RepeatTimes:0 Procs:10 Slowdown:1 Sandbox:n=
one SandboxArg:0 Leak:false NetInjection:true NetDevices:true NetReset:true=
 Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:false Ni=
cVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:=
true Swap:true UseTmpDir:true HandleSegv:true Repro:false Trace:false Legac=
yOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
> > perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > sendmsg$nl_route_sched(0xffffffffffffffff, 0x0, 0x0)
> > r0 =3D perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff=
, 0x0)
> > r1 =3D socket$key(0xf, 0x3, 0x2)
> > sendmsg$key(r1, 0x0, 0x0)
> > fchown(r0, 0x0, 0xee01)
> > sendmsg$key(r1, 0x0, 0x0)
> > read$FUSE(0xffffffffffffffff, 0x0, 0x0)
> > prlimit64(0x0, 0xe, 0x0, 0x0)
> > sched_setscheduler(0x0, 0x2, 0x0)
> > sched_setscheduler(0x0, 0x2, 0x0)
> > ioctl$FS_IOC_SETFLAGS(0xffffffffffffffff, 0x40086602, 0x0)
> > sendmmsg$unix(0xffffffffffffffff, 0x0, 0x0, 0x0)
> > openat$null(0xffffffffffffff9c, 0x0, 0x600000, 0x0)
> > getpgid(0x0)
> > socket$nl_xfrm(0x10, 0x3, 0x6)
> > perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > perf_event_open(&(0x7f0000000200)=3D{0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp=
=3D{0x0}}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > write$eventfd(0xffffffffffffffff, 0x0, 0x0)
> > perf_event_open(0x0, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x3)
> > perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > socket$vsock_dgram(0x28, 0x2, 0x0)
> > clock_adjtime(0x0, 0x0)
> > perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > perf_event_open(&(0x7f0000000200)=3D{0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x50d, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_=
bp=3D{0x0}}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> > r2 =3D socket$inet6_sctp(0xa, 0x1, 0x84)
> > setsockopt(r2, 0x84, 0x81, &(0x7f00000002c0)=3D"1a00000019000000", 0x8)
> > setsockopt$inet_sctp_SCTP_SOCKOPT_BINDX_ADD(r2, 0x84, 0x64, &(0x7f00000=
00380)=3D[@in6=3D{0xa, 0x4e23, 0x0, @loopback}], 0x1c)
> > setsockopt$inet_sctp6_SCTP_AUTH_CHUNK(r2, 0x84, 0x15, &(0x7f00000001c0)=
, 0x1)
> > r3 =3D syz_open_procfs$procfs_self_proc_file(0xffffffffffffffff, &(0x7f=
0000000180)=3D'fail-nth\x00')
> > write$cgroup_int(r3, &(0x7f0000000200)=3D0x48, 0x12)
> > perf_event_open(&(0x7f0000000480)=3D{0x0, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_co=
nfig_ext}, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0)
> > r4 =3D openat$euleros_proc_task_file(0xffffffffffffff9c, &(0x7f00000004=
40)=3D'/proc/self/patch_state\x00', 0x20000, 0x0)
> > perf_event_open(0x0, 0x0, 0x6, r4, 0x2)
> > setsockopt$inet_sctp6_SCTP_ASSOCINFO(r3, 0x84, 0x1, &(0x7f0000000040)=
=3D{0x0, 0xd6, 0x2, 0x2d820323, 0x7, 0x1}, 0x14)
> > sendto$inet6(r2, &(0x7f0000000000)=3D' ', 0x1, 0x0, &(0x7f0000000080)=
=3D{0xa, 0x4e23, 0x0, @loopback}, 0x1c)
> > sendto$inet6(r2, &(0x7f0000000000)=3D' ', 0x1, 0x0, &(0x7f0000000080)=
=3D{0xa, 0x4e23, 0x0, @loopback}, 0x1c)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > It seems to be rare case because I cannot trigger this bug again with 2=
4h+ of reproducing.
> >
> > Thanks.
> After 10+ days of reproducing the bug finally re-occur...
> I investigated the vmcore dmesg and found this fault-injection backtrace =
just
> before the bug happened:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> FAULT_INJECTION: forcing a failure.
>     name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 2898 Comm: syz-executor.8 Kdump: loaded Tainted: G        W  =
        6.6.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xbd/0xe0
>  should_fail_ex+0x4b0/0x5b0
>  should_failslab+0xc3/0x120
>  __kmem_cache_alloc_node+0x67/0x5f0
>  __kmalloc+0x4e/0x150
>  sctp_auth_create_key+0x3d/0xe0
>  sctp_auth_make_key_vector+0x103/0x1e0
>  sctp_auth_asoc_create_secret+0xc6/0x340
>  sctp_auth_asoc_init_active_key.part.0+0x160/0x4b0
>  sctp_auth_asoc_init_active_key+0x67/0x90
>  sctp_cmd_interpreter.isra.0+0x2ccc/0x62c0
>  sctp_do_sm+0x1a3/0x670
>  sctp_assoc_bh_rcv+0x33e/0x640
>  sctp_inq_push+0x1dd/0x280
>  sctp_backlog_rcv+0x19e/0x11c0
>  __release_sock+0x29c/0x310
>  release_sock+0x59/0x1b0
>  sctp_wait_for_connect+0x35f/0x5d0
>  sctp_sendmsg_to_asoc+0x1865/0x1c90
>  sctp_sendmsg+0xc98/0x1e40
>  inet_sendmsg+0x122/0x150
>  __sock_sendmsg+0x1c6/0x2a0
>  __sys_sendto+0x203/0x2e0
>  __x64_sys_sendto+0xe2/0x1c0
>  do_syscall_64+0x6c/0x120
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> RIP: 0033:0x7f70f2493bdd
> Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f70f1ffebf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f70f25dbf80 RCX: 00007f70f2493bdd
> RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000005
> RBP: 00007f70f24f1499 R08: 0000000020000080 R09: 000000000000001c
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fffe62d14df R14: 00007fffe62d1680 R15: 00007f70f1ffed80
>  </TASK>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> And indeed the asoc->shkey=E3=80=81asoc->asoc_shared_key=E3=80=81chunk->a=
uth_chunk=E3=80=81chunk->shkey
> are all NULL in the vmcore memory.
> Is there any possible that the slab force failure caused the asoc->shkey =
NULL
> then chunk->shkey NULL after sctp_datamsg_from_user() but chunk->auth is =
true
> so resulted in null-ptr-deref?
>
Hi Chen, Thanks for reproducing it.

Yes, I think I can make sense of this now.

The slab force failure happens while processing INIT_ACK along the
following path:

sctp_do_sm()
 -> sctp_sf_do_5_1C_ack()
   -> sctp_cmd_interpreter(SCTP_CMD_ASSOC_SHKEY)
      -> sctp_auth_asoc_init_active_key()  <-- FAILED

In sctp_sf_do_5_1C_ack(), the SCTP_CMD_ASSOC_SHKEY command (which
calls sctp_auth_asoc_init_active_key) is currently added after:

- SCTP_CMD_TIMER_START (starting the T1_COOKIE timer), and
- SCTP_CMD_NEW_STATE (transition to COOKIE_ECHOED).

If SCTP_CMD_ASSOC_SHKEY fails, asoc->shkey remains NULL. However,
asoc->peer.auth_capable and asoc->peer.peer_chunks have already been
set earlier by SCTP_CMD_PEER_INIT (via sctp_cmd_process_init). As a
result, a DATA chunk with auth =3D 1 and shkey =3D NULL can still be
queued for transmission.

At that point, the association has already entered the COOKIE_ECHOED
state, and the T1_COOKIE timer may generate a COOKIE_ECHO chunk. Then,
sctp_outq_flush_data() allows the DATA chunk to send in COOKIE_ECHOED
state when a COOKIE_ECHO chunk exists, which leads to the observed
issue.

My thought is to move the SCTP_CMD_ASSOC_SHKEY command before
SCTP_CMD_TIMER_START (T1_COOKIE), even before SCTP_CMD_TIMER_STOP
(T1_INIT). This way, if shared key generation fails, the DATA chunk
in the outqueue won=E2=80=99t be allowed to send, and the T1_INIT timer can
also retransmit INIT. The client can then receive/process INIT_ACK
again and retry SCTP_CMD_ASSOC_SHKEY in sctp_sf_do_5_1C_ack().

Something like:

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 3755ba079d07..7b823d759141 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -603,6 +603,11 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *=
net,
        sctp_add_cmd_sf(commands, SCTP_CMD_PEER_INIT,
                        SCTP_PEER_INIT(initchunk));

+       /* SCTP-AUTH: generate the association shared keys so that
+        * we can potentially sign the COOKIE-ECHO.
+        */
+       sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
+
        /* Reset init error count upon receipt of INIT-ACK.  */
        sctp_add_cmd_sf(commands, SCTP_CMD_INIT_COUNTER_RESET, SCTP_NULL())=
;

@@ -617,11 +622,6 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *=
net,
        sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
                        SCTP_STATE(SCTP_STATE_COOKIE_ECHOED));

-       /* SCTP-AUTH: generate the association shared keys so that
-        * we can potentially sign the COOKIE-ECHO.
-        */
-       sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
-
        /* 5.1 C) "A" shall then send the State Cookie received in the
         * INIT ACK chunk in a COOKIE ECHO chunk, ...
         */

Could you give this a try?

Thanks.

