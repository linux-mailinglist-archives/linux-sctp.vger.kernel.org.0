Return-Path: <linux-sctp+bounces-770-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D51D0CDB8
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Jan 2026 03:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 928853008C55
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Jan 2026 02:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FD19F40B;
	Sat, 10 Jan 2026 02:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WdntDRnw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F9946A
	for <linux-sctp@vger.kernel.org>; Sat, 10 Jan 2026 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768013482; cv=none; b=DMrQjiJAfsgMun8OavwzMyx6wYkGu12/Ng7ERAr/FlMVj+C3C9GxH5z6pU/GZftNQ0bQeOa4fM3iySZMDcu7661gauoa1jm4PpYYl9DEw22yd1RfNeTX+FIlStIxdks0PLCOe/pjr8F/8Fc/4dYjG8ZMbgh928r6hEPWTKCuNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768013482; c=relaxed/simple;
	bh=zbnRhtvWYeIc18nwrdwXW/Yp9U1HOOrQKBWAnzH763Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rE+THR4E6YGGx2+cSaW/Or0q0twV4rzaqwb0ZST9IbZ1GrNeskYvx77OJX538jQu9t4twzMcIHJZzitgMCpyNhYkHjVDHz0USYzuK5KCd65HOR9vuA0gAUMaqt5owDl/qY7kfcXk+eC0/FMgjQIhP4MmyM8SQVP9VKpcVQCiQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WdntDRnw; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yGE15mLX3y43BLDWhU4swfWek4kpX6Udps+P48qjOpk=;
	b=WdntDRnwvA8ezyRX3kMBeELLCCZwBfS8eaEPLUxQVKBeyrINSGw10dVoqw7udxfg6O6L3IxSW
	69hz0KfSietSdRQc+6S5AraxluF8cz0RjTrEH0+i0iQA1K6dkV7eZ/E1Yqc7XRTbs0mdRCOZnVe
	hOsLSsyS9ihrKWWYu6YEE5c=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dp33K5LSmz1prNN
	for <linux-sctp@vger.kernel.org>; Sat, 10 Jan 2026 10:47:57 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B533E404AD
	for <linux-sctp@vger.kernel.org>; Sat, 10 Jan 2026 10:51:16 +0800 (CST)
Received: from [10.136.112.207] (10.136.112.207) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 10 Jan 2026 10:51:16 +0800
Message-ID: <ed25debe-09ae-4d6d-d93a-715cd58e8bfc@huawei.com>
Date: Sat, 10 Jan 2026 10:51:15 +0800
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
 <95232a2f-f8f8-3cba-ebf3-cefffac87323@huawei.com>
 <58c77f72-7d26-f325-23ec-6d6f85b7c7b8@huawei.com>
 <CADvbK_dvRiP05x-+rfvz0vbRO5a4iVmEFKmSsKiQnLEmKENNxw@mail.gmail.com>
From: Chen Zhen <chenzhen126@huawei.com>
In-Reply-To: <CADvbK_dvRiP05x-+rfvz0vbRO5a4iVmEFKmSsKiQnLEmKENNxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500008.china.huawei.com (7.202.194.93)

On 26/1/10 6:02, Xin Long wrote:
> On Thu, Jan 8, 2026 at 3:20 AM Chen Zhen <chenzhen126@huawei.com> wrote:
>> After 10+ days of reproducing the bug finally re-occur...
>> I investigated the vmcore dmesg and found this fault-injection backtrace just
>> before the bug happened:
>> ======================
>> FAULT_INJECTION: forcing a failure.
>>     name failslab, interval 1, probability 0, space 0, times 0
>> CPU: 0 PID: 2898 Comm: syz-executor.8 Kdump: loaded Tainted: G        W          6.6.0 #2
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0xbd/0xe0
>>  should_fail_ex+0x4b0/0x5b0
>>  should_failslab+0xc3/0x120
>>  __kmem_cache_alloc_node+0x67/0x5f0
>>  __kmalloc+0x4e/0x150
>>  sctp_auth_create_key+0x3d/0xe0
>>  sctp_auth_make_key_vector+0x103/0x1e0
>>  sctp_auth_asoc_create_secret+0xc6/0x340
>>  sctp_auth_asoc_init_active_key.part.0+0x160/0x4b0
>>  sctp_auth_asoc_init_active_key+0x67/0x90
>>  sctp_cmd_interpreter.isra.0+0x2ccc/0x62c0
>>  sctp_do_sm+0x1a3/0x670
>>  sctp_assoc_bh_rcv+0x33e/0x640
>>  sctp_inq_push+0x1dd/0x280
>>  sctp_backlog_rcv+0x19e/0x11c0
>>  __release_sock+0x29c/0x310
>>  release_sock+0x59/0x1b0
>>  sctp_wait_for_connect+0x35f/0x5d0
>>  sctp_sendmsg_to_asoc+0x1865/0x1c90
>>  sctp_sendmsg+0xc98/0x1e40
>>  inet_sendmsg+0x122/0x150
>>  __sock_sendmsg+0x1c6/0x2a0
>>  __sys_sendto+0x203/0x2e0
>>  __x64_sys_sendto+0xe2/0x1c0
>>  do_syscall_64+0x6c/0x120
>>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
>> RIP: 0033:0x7f70f2493bdd
>> Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f70f1ffebf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
>> RAX: ffffffffffffffda RBX: 00007f70f25dbf80 RCX: 00007f70f2493bdd
>> RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000005
>> RBP: 00007f70f24f1499 R08: 0000000020000080 R09: 000000000000001c
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007fffe62d14df R14: 00007fffe62d1680 R15: 00007f70f1ffed80
>>  </TASK>
>> ======================
>> And indeed the asoc->shkey、asoc->asoc_shared_key、chunk->auth_chunk、chunk->shkey
>> are all NULL in the vmcore memory.
>> Is there any possible that the slab force failure caused the asoc->shkey NULL
>> then chunk->shkey NULL after sctp_datamsg_from_user() but chunk->auth is true
>> so resulted in null-ptr-deref?
>>
> Hi Chen, Thanks for reproducing it.
> 
> Yes, I think I can make sense of this now.
> 
> The slab force failure happens while processing INIT_ACK along the
> following path:
> 
> sctp_do_sm()
>  -> sctp_sf_do_5_1C_ack()
>    -> sctp_cmd_interpreter(SCTP_CMD_ASSOC_SHKEY)
>       -> sctp_auth_asoc_init_active_key()  <-- FAILED
> 
> In sctp_sf_do_5_1C_ack(), the SCTP_CMD_ASSOC_SHKEY command (which
> calls sctp_auth_asoc_init_active_key) is currently added after:
> 
> - SCTP_CMD_TIMER_START (starting the T1_COOKIE timer), and
> - SCTP_CMD_NEW_STATE (transition to COOKIE_ECHOED).
> 
> If SCTP_CMD_ASSOC_SHKEY fails, asoc->shkey remains NULL. However,
> asoc->peer.auth_capable and asoc->peer.peer_chunks have already been
> set earlier by SCTP_CMD_PEER_INIT (via sctp_cmd_process_init). As a
> result, a DATA chunk with auth = 1 and shkey = NULL can still be
> queued for transmission.
> 
> At that point, the association has already entered the COOKIE_ECHOED
> state, and the T1_COOKIE timer may generate a COOKIE_ECHO chunk. Then,
> sctp_outq_flush_data() allows the DATA chunk to send in COOKIE_ECHOED
> state when a COOKIE_ECHO chunk exists, which leads to the observed
> issue.
> 
> My thought is to move the SCTP_CMD_ASSOC_SHKEY command before
> SCTP_CMD_TIMER_START (T1_COOKIE), even before SCTP_CMD_TIMER_STOP
> (T1_INIT). This way, if shared key generation fails, the DATA chunk
> in the outqueue won’t be allowed to send, and the T1_INIT timer can
> also retransmit INIT. The client can then receive/process INIT_ACK
> again and retry SCTP_CMD_ASSOC_SHKEY in sctp_sf_do_5_1C_ack().
> 
> Something like:
> 
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 3755ba079d07..7b823d759141 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -603,6 +603,11 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
>         sctp_add_cmd_sf(commands, SCTP_CMD_PEER_INIT,
>                         SCTP_PEER_INIT(initchunk));
> 
> +       /* SCTP-AUTH: generate the association shared keys so that
> +        * we can potentially sign the COOKIE-ECHO.
> +        */
> +       sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
> +
>         /* Reset init error count upon receipt of INIT-ACK.  */
>         sctp_add_cmd_sf(commands, SCTP_CMD_INIT_COUNTER_RESET, SCTP_NULL());
> 
> @@ -617,11 +622,6 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
>         sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
>                         SCTP_STATE(SCTP_STATE_COOKIE_ECHOED));
> 
> -       /* SCTP-AUTH: generate the association shared keys so that
> -        * we can potentially sign the COOKIE-ECHO.
> -        */
> -       sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
> -
>         /* 5.1 C) "A" shall then send the State Cookie received in the
>          * INIT ACK chunk in a COOKIE ECHO chunk, ...
>          */
> 
> Could you give this a try?
> 
> Thanks.
> .
Yes, I will try with this patch ASAP.
Thanks for your reply!

Best Regards,
Chen Zhen

