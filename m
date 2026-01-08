Return-Path: <linux-sctp+bounces-768-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32BED01ADA
	for <lists+linux-sctp@lfdr.de>; Thu, 08 Jan 2026 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5564935B3BF2
	for <lists+linux-sctp@lfdr.de>; Thu,  8 Jan 2026 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4D3ACEF3;
	Thu,  8 Jan 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FKk4BvSM";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FKk4BvSM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACB37E2E1
	for <linux-sctp@vger.kernel.org>; Thu,  8 Jan 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860462; cv=none; b=SZZCa0MBxxyLwNgN2mFmEcRqN0XOae7XWNrUrNqAltSKIF4kGcJxqd0wikE6lY9Mi11zqEMPSU3gax0V8u0+7QVDlG/bSmZs7IOFeCfvbKSZlQETzFGH1uB3OWEvLdnxfPseK8+EkV1dMwZAQcX+Vf1523U+hbDvYitVnHD528Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860462; c=relaxed/simple;
	bh=02dqjQKZvjxZ0NcML9lQomn8tAQZsBQZa1Z6U4RE3nk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YUGVJlb3jm1zOyEnMGsOrQJWeu/gqi9FxpQBP7wJT1ZdvwrUtwo3jJcFxWfM0Au1t4JVk3v95eQhbO1RyN84JdmujzQvY7DgvlDt3KdoE+B3MFSfjNbb2y9RkJvAfTtjpIOobBFQSTFIZftjoaVLTdGrZyQ/EyjsEFgLDhjGes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FKk4BvSM; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FKk4BvSM; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BufBs50fPagDrpwp1A2FqulTL98ifBXs7X8OVdA0Bvc=;
	b=FKk4BvSMTIA9KZEKXxLZcCPqxfIz6uUyNYBkAEuQYWXHzDHutawBqspc1AGrpl8qQzB1XVtan
	+og2A9xT6FahJ+M7MfDGSr4KFaoCiv5Q40eE8dd5P6Z5MilIw2GQjsRcdVer5OsrSnU/u2zO/H2
	coekgUWAp7PP083FJ2TlcUE=
Received: from canpmsgout07.his.huawei.com (unknown [172.19.92.160])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dmyW52VHWz1BG93
	for <linux-sctp@vger.kernel.org>; Thu,  8 Jan 2026 16:19:45 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BufBs50fPagDrpwp1A2FqulTL98ifBXs7X8OVdA0Bvc=;
	b=FKk4BvSMTIA9KZEKXxLZcCPqxfIz6uUyNYBkAEuQYWXHzDHutawBqspc1AGrpl8qQzB1XVtan
	+og2A9xT6FahJ+M7MfDGSr4KFaoCiv5Q40eE8dd5P6Z5MilIw2GQjsRcdVer5OsrSnU/u2zO/H2
	coekgUWAp7PP083FJ2TlcUE=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dmySJ5MzRzLlYG
	for <linux-sctp@vger.kernel.org>; Thu,  8 Jan 2026 16:17:20 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1262A40562
	for <linux-sctp@vger.kernel.org>; Thu,  8 Jan 2026 16:20:36 +0800 (CST)
Received: from [10.136.112.207] (10.136.112.207) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 16:20:35 +0800
Message-ID: <58c77f72-7d26-f325-23ec-6d6f85b7c7b8@huawei.com>
Date: Thu, 8 Jan 2026 16:20:35 +0800
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [BUG] null-ptr-deref bug in sctp_packet_bundle_auth
Content-Language: en-US
From: Chen Zhen <chenzhen126@huawei.com>
To: Xin Long <lucien.xin@gmail.com>
CC: <marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
References: <f5a9e456-415c-0a7c-8e73-ba3c297447f0@huawei.com>
 <CADvbK_d082m8hWfbK5-khpAtGtRsC_6yO4dBvdM0q71xo=umdw@mail.gmail.com>
 <95232a2f-f8f8-3cba-ebf3-cefffac87323@huawei.com>
In-Reply-To: <95232a2f-f8f8-3cba-ebf3-cefffac87323@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500008.china.huawei.com (7.202.194.93)

On 25/12/18 10:00, Chen Zhen wrote:
> ==================
> Syzkaller reproducer:
> 
> {Threaded:false Repeat:true RepeatTimes:0 Procs:10 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:true Swap:true UseTmpDir:true HandleSegv:true Repro:false Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
> perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> sendmsg$nl_route_sched(0xffffffffffffffff, 0x0, 0x0)
> r0 = perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> r1 = socket$key(0xf, 0x3, 0x2)
> sendmsg$key(r1, 0x0, 0x0)
> fchown(r0, 0x0, 0xee01)
> sendmsg$key(r1, 0x0, 0x0)
> read$FUSE(0xffffffffffffffff, 0x0, 0x0)
> prlimit64(0x0, 0xe, 0x0, 0x0)
> sched_setscheduler(0x0, 0x2, 0x0)
> sched_setscheduler(0x0, 0x2, 0x0)
> ioctl$FS_IOC_SETFLAGS(0xffffffffffffffff, 0x40086602, 0x0)
> sendmmsg$unix(0xffffffffffffffff, 0x0, 0x0, 0x0)
> openat$null(0xffffffffffffff9c, 0x0, 0x600000, 0x0)
> getpgid(0x0)
> socket$nl_xfrm(0x10, 0x3, 0x6)
> perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> perf_event_open(&(0x7f0000000200)={0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={0x0}}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> write$eventfd(0xffffffffffffffff, 0x0, 0x0)
> perf_event_open(0x0, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x3)
> perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> socket$vsock_dgram(0x28, 0x2, 0x0)
> clock_adjtime(0x0, 0x0)
> perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> perf_event_open(&(0x7f0000000200)={0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x50d, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={0x0}}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
> r2 = socket$inet6_sctp(0xa, 0x1, 0x84)
> setsockopt(r2, 0x84, 0x81, &(0x7f00000002c0)="1a00000019000000", 0x8)
> setsockopt$inet_sctp_SCTP_SOCKOPT_BINDX_ADD(r2, 0x84, 0x64, &(0x7f0000000380)=[@in6={0xa, 0x4e23, 0x0, @loopback}], 0x1c)
> setsockopt$inet_sctp6_SCTP_AUTH_CHUNK(r2, 0x84, 0x15, &(0x7f00000001c0), 0x1)
> r3 = syz_open_procfs$procfs_self_proc_file(0xffffffffffffffff, &(0x7f0000000180)='fail-nth\x00')
> write$cgroup_int(r3, &(0x7f0000000200)=0x48, 0x12)
> perf_event_open(&(0x7f0000000480)={0x0, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0)
> r4 = openat$euleros_proc_task_file(0xffffffffffffff9c, &(0x7f0000000440)='/proc/self/patch_state\x00', 0x20000, 0x0)
> perf_event_open(0x0, 0x0, 0x6, r4, 0x2)
> setsockopt$inet_sctp6_SCTP_ASSOCINFO(r3, 0x84, 0x1, &(0x7f0000000040)={0x0, 0xd6, 0x2, 0x2d820323, 0x7, 0x1}, 0x14)
> sendto$inet6(r2, &(0x7f0000000000)=' ', 0x1, 0x0, &(0x7f0000000080)={0xa, 0x4e23, 0x0, @loopback}, 0x1c)
> sendto$inet6(r2, &(0x7f0000000000)=' ', 0x1, 0x0, &(0x7f0000000080)={0xa, 0x4e23, 0x0, @loopback}, 0x1c)
> ==================
> 
> It seems to be rare case because I cannot trigger this bug again with 24h+ of reproducing. 
> 
> Thanks.
After 10+ days of reproducing the bug finally re-occur...
I investigated the vmcore dmesg and found this fault-injection backtrace just
before the bug happened:
======================
FAULT_INJECTION: forcing a failure.
    name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 2898 Comm: syz-executor.8 Kdump: loaded Tainted: G        W          6.6.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xbd/0xe0
 should_fail_ex+0x4b0/0x5b0
 should_failslab+0xc3/0x120
 __kmem_cache_alloc_node+0x67/0x5f0
 __kmalloc+0x4e/0x150
 sctp_auth_create_key+0x3d/0xe0
 sctp_auth_make_key_vector+0x103/0x1e0
 sctp_auth_asoc_create_secret+0xc6/0x340
 sctp_auth_asoc_init_active_key.part.0+0x160/0x4b0
 sctp_auth_asoc_init_active_key+0x67/0x90
 sctp_cmd_interpreter.isra.0+0x2ccc/0x62c0
 sctp_do_sm+0x1a3/0x670
 sctp_assoc_bh_rcv+0x33e/0x640
 sctp_inq_push+0x1dd/0x280
 sctp_backlog_rcv+0x19e/0x11c0
 __release_sock+0x29c/0x310
 release_sock+0x59/0x1b0
 sctp_wait_for_connect+0x35f/0x5d0
 sctp_sendmsg_to_asoc+0x1865/0x1c90
 sctp_sendmsg+0xc98/0x1e40
 inet_sendmsg+0x122/0x150
 __sock_sendmsg+0x1c6/0x2a0
 __sys_sendto+0x203/0x2e0
 __x64_sys_sendto+0xe2/0x1c0
 do_syscall_64+0x6c/0x120
 entry_SYSCALL_64_after_hwframe+0x78/0xe2
RIP: 0033:0x7f70f2493bdd
Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f70f1ffebf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f70f25dbf80 RCX: 00007f70f2493bdd
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007f70f24f1499 R08: 0000000020000080 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffe62d14df R14: 00007fffe62d1680 R15: 00007f70f1ffed80
 </TASK>
======================
And indeed the asoc->shkey、asoc->asoc_shared_key、chunk->auth_chunk、chunk->shkey
are all NULL in the vmcore memory.
Is there any possible that the slab force failure caused the asoc->shkey NULL
then chunk->shkey NULL after sctp_datamsg_from_user() but chunk->auth is true
so resulted in null-ptr-deref?

Any suggestions or ideas would be greatly appreciated!

Best regards,
Chen Zhen

 

