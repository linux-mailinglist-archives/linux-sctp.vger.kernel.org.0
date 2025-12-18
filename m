Return-Path: <linux-sctp+bounces-767-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87938CCA07B
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Dec 2025 03:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6769B3019BEC
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Dec 2025 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4142242D97;
	Thu, 18 Dec 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A8ftmX1G"
X-Original-To: linux-sctp@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AE257435
	for <linux-sctp@vger.kernel.org>; Thu, 18 Dec 2025 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023251; cv=none; b=fFLZVe/D2HnJ/0yVeZwtp+wXfREauumXVokcFNkH4/kGkCYqP+WKKPT7IQr4Z4Jy3lF/LzK6efMNrWuPhUdJhOjfsUHPcfaY3SvlbTDu+JwsUHVUkmZbhRE4qw45G/nzELM2ZLuDVmV6J5n5WSuZaPBiBjARuSXT3JfIE596cPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023251; c=relaxed/simple;
	bh=RicVOzM7KztaT/uT7bySPGfQiBLKu5vHw8o+W+Q1+0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X0L2TWIYA9sKSnjf7un7DrwyQ9spdnHkRx37CGOFmeiRaijbcJf0S/q7fcTyVuWV2UmnD798BeiMx8OOPK8mXap2BdNejfPHBQ0z6TFwO5HfR/7+qzm6DdfhVNsyNV9+Vjm4M9j4jdm2ViL6mrVa0tlYGd0rKWiG5Ux0jmFFsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A8ftmX1G; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I/lP5uAvsevNy2ep+AQAmztGBNeJuudxIZzINSND/LY=;
	b=A8ftmX1G9k2m07i1xuTJKhSCavKDg1Il0AJbwHQ6G2RaCMcsnCLGpGtzXDShGve1IiNzD8Tte
	T03H4LDdKtYfyVbpOhFqS+OnTMh1A6KCGlrnqc5Cbg1jrOM1AtLomBsFddJ5yGDMig9YU1yVb19
	K/j0rrm3RneeiZvoWAqCVk8=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dWv2v3QD9znTV6
	for <linux-sctp@vger.kernel.org>; Thu, 18 Dec 2025 09:58:31 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 80FC114013B
	for <linux-sctp@vger.kernel.org>; Thu, 18 Dec 2025 10:00:44 +0800 (CST)
Received: from [10.136.112.207] (10.136.112.207) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 10:00:43 +0800
Message-ID: <95232a2f-f8f8-3cba-ebf3-cefffac87323@huawei.com>
Date: Thu, 18 Dec 2025 10:00:43 +0800
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
To: Xin Long <lucien.xin@gmail.com>
CC: <marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
References: <f5a9e456-415c-0a7c-8e73-ba3c297447f0@huawei.com>
 <CADvbK_d082m8hWfbK5-khpAtGtRsC_6yO4dBvdM0q71xo=umdw@mail.gmail.com>
From: Chen Zhen <chenzhen126@huawei.com>
In-Reply-To: <CADvbK_d082m8hWfbK5-khpAtGtRsC_6yO4dBvdM0q71xo=umdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500008.china.huawei.com (7.202.194.93)



On 25/12/18 0:53, Xin Long wrote:
> On Wed, Dec 17, 2025 at 8:13 AM Chen Zhen <chenzhen126@huawei.com> wrote:
>>
>> Hi all,
>>
>> We tested with syzkaller on linux-6.6 and it reported a null-ptr-deref bug:
>>
>> ==================================================================
>> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
>> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>> CPU: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G W 6.6.0 #2
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
>> RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
>> Code: 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 93 05 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 7b 40 49 8d 7f 1c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 57
>> RSP: 0018:ffffc9000010efe8 EFLAGS: 00010207
>> RAX: dffffc0000000000 RBX: ffff88810c746000 RCX: ffffffff8d758fca
>> RDX: 0000000000000003 RSI: ffff888100d1cd40 RDI: 000000000000001c
>> RBP: ffff88811dea8b78 R08: 0000000000000000 R09: fffffbfff27f8b7d
>> R10: fffffbfff27f8b7c R11: ffffffff93fc5be7 R12: ffff88804247c000
>> R13: ffff88811dea8bb8 R14: ffff88810c746040 R15: 0000000000000000
>> FS: 0000000000000000(0000) GS:ffff88816e600000(0000) knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000021000000 CR3: 000000011dfb4002 CR4: 0000000000170ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
>> Call Trace:
>>
>> sctp_packet_transmit_chunk+0x31/0x250 net/sctp/output.c:189
>> sctp_outq_flush_data+0xa29/0x26d0 net/sctp/outqueue.c:1111
>> sctp_outq_flush+0xc80/0x1240 net/sctp/outqueue.c:1217
>> sctp_cmd_interpreter.isra.0+0x19a5/0x62c0 net/sctp/sm_sideeffect.c:1787
>> sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
>> sctp_do_sm+0x1a3/0x670 net/sctp/sm_sideeffect.c:1169
>> sctp_assoc_bh_rcv+0x33e/0x640 net/sctp/associola.c:1052
>> sctp_inq_push+0x1dd/0x280 net/sctp/inqueue.c:88
>> sctp_rcv+0x11ae/0x3100 net/sctp/input.c:243
>> sctp6_rcv+0x3d/0x60 net/sctp/ipv6.c:1127
>> ip6_protocol_deliver_rcu+0x12c1/0x1e40 net/ipv6/ip6_input.c:438
>> ip6_input_finish+0xc8/0x260 net/ipv6/ip6_input.c:483
>> NF_HOOK include/linux/netfilter.h:308 [inline]
>> ip6_input+0xd1/0x430 net/ipv6/ip6_input.c:492
>> dst_input include/net/dst.h:487 [inline]
>> ip6_rcv_finish+0x1b9/0x5c0 net/ipv6/ip6_input.c:79
>> NF_HOOK include/linux/netfilter.h:308 [inline]
>> ipv6_rcv+0xf8/0x440 net/ipv6/ip6_input.c:310
>> __netif_receive_skb_one_core+0x133/0x1f0 net/core/dev.c:5603
>> __netif_receive_skb+0x24/0x1c0 net/core/dev.c:5717
>> process_backlog+0x21d/0x7e0 net/core/dev.c:6045
>> __napi_poll+0xc2/0x690 net/core/dev.c:6607
>> napi_poll net/core/dev.c:6674 [inline]
>> net_rx_action+0x87d/0xce0 net/core/dev.c:6810
>> handle_softirqs+0x1b4/0x700 kernel/softirq.c:578
>> run_ksoftirqd kernel/softirq.c:997 [inline]
>> run_ksoftirqd+0x2f/0x60 kernel/softirq.c:989
>> smpboot_thread_fn+0x3b9/0x860 kernel/smpboot.c:164
>> kthread+0x324/0x420 kernel/kthread.c:388
>> ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:152
>> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293
>>
>> Modules linked in:
>> kernel fault(0x1) notification starting on CPU 0
>> kernel fault(0x1) notification finished on CPU 0
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
>> RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
>> Code: 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 93 05 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 7b 40 49 8d 7f 1c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 57
>> RSP: 0018:ffffc9000010efe8 EFLAGS: 00010207
>> RAX: dffffc0000000000 RBX: ffff88810c746000 RCX: ffffffff8d758fca
>> RDX: 0000000000000003 RSI: ffff888100d1cd40 RDI: 000000000000001c
>> RBP: ffff88811dea8b78 R08: 0000000000000000 R09: fffffbfff27f8b7d
>> R10: fffffbfff27f8b7c R11: ffffffff93fc5be7 R12: ffff88804247c000
>> R13: ffff88811dea8bb8 R14: ffff88810c746040 R15: 0000000000000000
>> FS: 0000000000000000(0000) GS:ffff88816e600000(0000) knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000021000000 CR3: 000000011dfb4002 CR4: 0000000000170ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
>> Code disassembly (best guess):
>> 0: 4c 89 f2 mov %r14,%rdx
>> 3: 48 c1 ea 03 shr $0x3,%rdx
>> 7: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
>> b: 0f 85 93 05 00 00 jne 0x5a4
>> 11: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
>> 18: fc ff df
>> 1b: 4c 8b 7b 40 mov 0x40(%rbx),%r15
>> 1f: 49 8d 7f 1c lea 0x1c(%r15),%rdi
>> 23: 48 89 fa mov %rdi,%rdx
>> 26: 48 c1 ea 03 shr $0x3,%rdx
>>
>> 2a: 0f b6 14 02 movzbl (%rdx,%rax,1),%edx <-- trapping instruction
>> 2e: 48 89 f8 mov %rdi,%rax
>> 31: 83 e0 07 and $0x7,%eax
>> 34: 83 c0 01 add $0x1,%eax
>> 37: 38 d0 cmp %dl,%al
>> 39: 7c 08 jl 0x43
>> 3b: 84 d2 test %dl,%dl
>> 3d: 0f .byte 0xf
>> 3e: 85 .byte 0x85
>> 3f: 57 push %rdi
>> ==================================================================
>>
>> The direct cause is that chunk->shkey is NULL in sctp_packet_bundle_auth().
>>
>>         if (!chunk->auth)
>>                 return retval;
>>
>>         auth = sctp_make_auth(asoc, chunk->shkey->key_id);    <=== BUG
>>         if (!auth)
>>                 return retval;
>>
>> It is simple to fix it by adding a null-ptr check before sctp_make_auth() but maybe
>> there are better solutions?
>>
> We need to check how this was triggered? Do you have a reproducer for this?
> 
> Thanks.
> .
==================
Syzkaller reproducer:

{Threaded:false Repeat:true RepeatTimes:0 Procs:10 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:true Swap:true UseTmpDir:true HandleSegv:true Repro:false Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
sendmsg$nl_route_sched(0xffffffffffffffff, 0x0, 0x0)
r0 = perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
r1 = socket$key(0xf, 0x3, 0x2)
sendmsg$key(r1, 0x0, 0x0)
fchown(r0, 0x0, 0xee01)
sendmsg$key(r1, 0x0, 0x0)
read$FUSE(0xffffffffffffffff, 0x0, 0x0)
prlimit64(0x0, 0xe, 0x0, 0x0)
sched_setscheduler(0x0, 0x2, 0x0)
sched_setscheduler(0x0, 0x2, 0x0)
ioctl$FS_IOC_SETFLAGS(0xffffffffffffffff, 0x40086602, 0x0)
sendmmsg$unix(0xffffffffffffffff, 0x0, 0x0, 0x0)
openat$null(0xffffffffffffff9c, 0x0, 0x600000, 0x0)
getpgid(0x0)
socket$nl_xfrm(0x10, 0x3, 0x6)
perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
perf_event_open(&(0x7f0000000200)={0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={0x0}}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
write$eventfd(0xffffffffffffffff, 0x0, 0x0)
perf_event_open(0x0, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x3)
perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
socket$vsock_dgram(0x28, 0x2, 0x0)
clock_adjtime(0x0, 0x0)
perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
perf_event_open(&(0x7f0000000200)={0x1, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x50d, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_bp={0x0}}, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
r2 = socket$inet6_sctp(0xa, 0x1, 0x84)
setsockopt(r2, 0x84, 0x81, &(0x7f00000002c0)="1a00000019000000", 0x8)
setsockopt$inet_sctp_SCTP_SOCKOPT_BINDX_ADD(r2, 0x84, 0x64, &(0x7f0000000380)=[@in6={0xa, 0x4e23, 0x0, @loopback}], 0x1c)
setsockopt$inet_sctp6_SCTP_AUTH_CHUNK(r2, 0x84, 0x15, &(0x7f00000001c0), 0x1)
r3 = syz_open_procfs$procfs_self_proc_file(0xffffffffffffffff, &(0x7f0000000180)='fail-nth\x00')
write$cgroup_int(r3, &(0x7f0000000200)=0x48, 0x12)
perf_event_open(&(0x7f0000000480)={0x0, 0x80, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0)
r4 = openat$euleros_proc_task_file(0xffffffffffffff9c, &(0x7f0000000440)='/proc/self/patch_state\x00', 0x20000, 0x0)
perf_event_open(0x0, 0x0, 0x6, r4, 0x2)
setsockopt$inet_sctp6_SCTP_ASSOCINFO(r3, 0x84, 0x1, &(0x7f0000000040)={0x0, 0xd6, 0x2, 0x2d820323, 0x7, 0x1}, 0x14)
sendto$inet6(r2, &(0x7f0000000000)=' ', 0x1, 0x0, &(0x7f0000000080)={0xa, 0x4e23, 0x0, @loopback}, 0x1c)
sendto$inet6(r2, &(0x7f0000000000)=' ', 0x1, 0x0, &(0x7f0000000080)={0xa, 0x4e23, 0x0, @loopback}, 0x1c)
==================

It seems to be rare case because I cannot trigger this bug again with 24h+ of reproducing. 

Thanks.

