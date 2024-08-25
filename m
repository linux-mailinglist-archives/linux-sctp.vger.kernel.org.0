Return-Path: <linux-sctp+bounces-213-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B91C95E0BE
	for <lists+linux-sctp@lfdr.de>; Sun, 25 Aug 2024 04:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA9A1C20A54
	for <lists+linux-sctp@lfdr.de>; Sun, 25 Aug 2024 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583888F77;
	Sun, 25 Aug 2024 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="DLtHrhGO";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="urXw0AhU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C88C07
	for <linux-sctp@vger.kernel.org>; Sun, 25 Aug 2024 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724553826; cv=none; b=uTJn/0jzGzOfmRpFa8RHC3OB5icE7y/plcMgP7Hg+hzWHsSsGLPSkNhY+oXNW8UOwPMsLvha8KF7pOaxeZeWE71pE7cDGTZxY4mmBx2iry/YDMrRu8JTjNNtSvYU4/aN6VLFPa+TTIrNga4V8U8PPe2mA8ZUq37EfCQOUV0ueDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724553826; c=relaxed/simple;
	bh=xYwht60nwukBIB8VvdyNWQ1W6v8FzgDLlaemLk8iqvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PjfpP0KRAVmuSOeVtREGmuUFl8EiD5ZIL6MgNwffrRPwiB6HzgpqrPzAn9G8HBowiZMnNtmtW2e3x+CEe9o5aCglLSCRwFWvEcQ2Bxm3snherKr63Q0YJD953LBMpBzldv+nPSobCQqsxETku5ABU/tGMdyP3S0j3zvoYqd0kWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=DLtHrhGO; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=urXw0AhU; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724553824; x=1756089824;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=xYwht60nwukBIB8VvdyNWQ1W6v8FzgDLlaemLk8iqvs=;
  b=DLtHrhGOCOSKsZzr5yzCTnPbGDG5JWP09TM6AjBAxMmcAPEMWTj3G74J
   qgAbeKLh5yki8XLnxocePD5aaulwg3OqFxiMx3KPIQ/Deyn/+qiiTR6mz
   fAez2cQRRIIFQAKiScSIto48HrmR5aBZnCuTAR+3JzmPHO3Gd/3GDbnuT
   ZsBUTWCf/3E9R9eqgOv/Bjmim8CYU+S50H/smcDbZv4CxTcsjIhKVCaIA
   rMCVGWkO5VizqkgRlMpPbaPhRQbx1ejNowCiulFJQVCekeZMpnG+vkk7z
   SzkQwQINMIfI17113gZzPM1wrsxVhIpHCC2ei+5bNkuFGyhNzG69US6Yz
   A==;
X-CSE-ConnectionGUID: THuEF+DETey15HkxwBY3WA==
X-CSE-MsgGUID: M7RsrnaaQbueP8SgxWUsiA==
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 19:43:43 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d293e492aso37074495ab.1
        for <linux-sctp@vger.kernel.org>; Sat, 24 Aug 2024 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724553822; x=1725158622; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4MNH+fMGdP9JHLT+281L3G2ZahxWv0gRwwGG3Pw9Mrw=;
        b=urXw0AhUEaSFCqW1NBeuVHtsyQkk111oNXqnAJgSF4uLSvz036Z4wLvkyMtq+MCbts
         G49V3/MYYUmGGDniPqlpB/QjSwm+jIK8w6UlhDAXX1a1BQcR0N7yDIzIlZW7kjNAOT9n
         DnKe1cCwCTSSvtKMaga4/YoqtFYhhwhkme+/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724553822; x=1725158622;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MNH+fMGdP9JHLT+281L3G2ZahxWv0gRwwGG3Pw9Mrw=;
        b=mwdiNkwOhlVIR8a3PaAL7Z6C02Be7PqMv8Uk+3IrXD7etdaLFwhCc4DOXTGvo20IpI
         nPqxDdx3StZ5vA+ypWeTJFnR4K6UTLVF9VmiNe9LAmAfqVNjCGhcNCJIRSbn8a0KnHze
         EtzLYg5t8mRZ9ekUBiKfMmuFaJDi/0AekfJg1oJm4ZJ6834yBREZgFl0OFjljeoWZf4n
         Aj+kRdamKDGoOqx/hqoDpwBzcRh/8YThYMdfNTLBzkJ99jJ2p7uBHW2UGG52Ql5JI75N
         /FarJgc+suXfX4xZPxRYuV1LJq7ihzQ0iuMNTTtcpX+pXjdLR8tROEAo9DLJ4FzzP8fg
         IBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUmT7c+x+6RUi7b98GQl2dYuY2mLFZWGFJCIB4RY3YUeqv4RcN1mfNXHT+dDQSrGXI7AuYwWsd3KnLw@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrJvgxxSzvrewOI/oEKYUyfDxsWYkU5tFvzMB3/GS9OpIBnRy
	BfT8BlIKXuSiD1pan0MYaDMHiHEPOTEkSQnna4m21n55t9Dv6yTv0bT1JbtIEZBhk8zUH5mPXXT
	wA8FaEht8p3m8V9Eai1zN5lfbZeoYGjVnUeE8QX8ix2L8ZnElUv2crs19r3NTkQpxKfShRBTgIm
	LtXOQvPqq6dsatJvHoDeBjMb8oz45ZO7fsysU=
X-Received: by 2002:a05:6e02:188a:b0:396:f026:b0ac with SMTP id e9e14a558f8ab-39e3c989ecfmr81369895ab.14.1724553822544;
        Sat, 24 Aug 2024 19:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr8z+YHMldSfKdzax7ksxhfCeggpAybAldZfkpvfBau9UN11Sq+ooUijQjlihTL6LPNcWCm6zdS6A/CIPsSIU=
X-Received: by 2002:a05:6e02:188a:b0:396:f026:b0ac with SMTP id
 e9e14a558f8ab-39e3c989ecfmr81369785ab.14.1724553822239; Sat, 24 Aug 2024
 19:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 19:43:30 -0700
Message-ID: <CANikGpfm_DbtXV9+omVrZhGiFA3iVEb=JeE1OQwvB3cXXDPoag@mail.gmail.com>
Subject: BUG: general protection fault in sctp_inet6addr_event
To: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `sctp_inet6addr_event`, a general protection fault error is
triggered when trying to execute `list_for_each_entry_safe(addr, temp,
&net->sctp.local_addr_list, list) { ...`
According to the report, it looks like the register $rax (propagated
from $r15) is unexpectedly set to null, causing an null-pointer
dereference issue.


Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 16764 Comm: kworker/u4:10 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:sctp_inet6addr_event+0x118/0x6e0
Code: 44 24 08 48 89 44 24 40 4c 89 e0 48 c1 e8 03 48 89 44 24 38 4c
89 64 24 28 4c 89 74 24 30 4c 89 f8 48 c1 e8 03 48 89 44 24 48 <42> 80
3c 28 00 74 08 4c 89 ff e8 89 25 b3 f7 49 8b 07 48 89 44 24
RSP: 0018:ffffc9000a037340 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888024170000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
RBP: ffff88802e8ed520 R08: ffffffff8a413727 R09: fffff52001406e58
R10: dffffc0000000000 R11: fffff52001406e58 R12: ffff88801856d000
R13: dffffc0000000000 R14: ffff88802cd22b88 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10a8812088 CR3: 0000000028e84000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notifier_call_chain kernel/notifier.c:93 [inline]
 atomic_notifier_call_chain+0x195/0x2d0 kernel/notifier.c:231
 addrconf_ifdown+0xedb/0x1b50 net/ipv6/addrconf.c:3980
 addrconf_notify+0x3c4/0x1000
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 dev_close_many+0x352/0x4e0 net/core/dev.c:1585
 dev_close+0x1bb/0x2c0 net/core/dev.c:1607
 cfg80211_shutdown_all_interfaces+0xbc/0x1d0 net/wireless/core.c:280
 ieee80211_remove_interfaces+0x111/0x690 net/mac80211/iface.c:2278
 ieee80211_unregister_hw+0x59/0x2d0 net/mac80211/main.c:1659
 mac80211_hwsim_del_radio+0x2ba/0x4b0
drivers/net/wireless/virtual/mac80211_hwsim.c:5576
 hwsim_exit_net+0x5bd/0x660 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sctp_inet6addr_event+0x118/0x6e0
Code: 44 24 08 48 89 44 24 40 4c 89 e0 48 c1 e8 03 48 89 44 24 38 4c
89 64 24 28 4c 89 74 24 30 4c 89 f8 48 c1 e8 03 48 89 44 24 48 <42> 80
3c 28 00 74 08 4c 89 ff e8 89 25 b3 f7 49 8b 07 48 89 44 24
RSP: 0018:ffffc9000a037340 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888024170000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
RBP: ffff88802e8ed520 R08: ffffffff8a413727 R09: fffff52001406e58
R10: dffffc0000000000 R11: fffff52001406e58 R12: ffff88801856d000
R13: dffffc0000000000 R14: ffff88802cd22b88 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10a8812088 CR3: 0000000028e84000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 44 24 08             rex.R and $0x8,%al
   3: 48 89 44 24 40       mov    %rax,0x40(%rsp)
   8: 4c 89 e0             mov    %r12,%rax
   b: 48 c1 e8 03           shr    $0x3,%rax
   f: 48 89 44 24 38       mov    %rax,0x38(%rsp)
  14: 4c 89 64 24 28       mov    %r12,0x28(%rsp)
  19: 4c 89 74 24 30       mov    %r14,0x30(%rsp)
  1e: 4c 89 f8             mov    %r15,%rax
  21: 48 c1 e8 03           shr    $0x3,%rax
  25: 48 89 44 24 48       mov    %rax,0x48(%rsp)
* 2a: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 ff             mov    %r15,%rdi
  34: e8 89 25 b3 f7       call   0xf7b325c2
  39: 49 8b 07             mov    (%r15),%rax
  3c: 48                   rex.W
  3d: 89                   .byte 0x89
  3e: 44                   rex.R
  3f: 24                   .byte 0x24

