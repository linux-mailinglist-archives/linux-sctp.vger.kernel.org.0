Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDD10AA7E
	for <lists+linux-sctp@lfdr.de>; Wed, 27 Nov 2019 07:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfK0GBl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 27 Nov 2019 01:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfK0GBl (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 27 Nov 2019 01:01:41 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DBC420684;
        Wed, 27 Nov 2019 06:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574834500;
        bh=GQL5eQ9+Hch/EyfVAAlb+xEVvTg2dFj3z5JsdSMOvKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WZQuLHwmW4xbPCvZr9Se+28+z1W9wrk/8k9TyYUosKAXkGUOjykJjO0PwosE4+Ryx
         xyUuDR3lmWGgFgXrLUZXVB2hXQbSFYRO7+PQDgNmPOu7YRbGkkJwaHWMEovl9xksRx
         MM+/SgD9LsHcCD+SgtTCg2g/9v9mPXktc2k/UUOA=
Date:   Tue, 26 Nov 2019 22:01:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Cc:     syzbot <syzbot+6dcbfea81cd3d4dd0b02@syzkaller.appspotmail.com>,
        davem@davemloft.net, glider@google.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in __crc32c_le_base
Message-ID: <20191127060138.GB227319@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000004b2df0598075fc8@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Looks like a bug in net/sctp/ where it's passing uninitialized memory into the
crc32c() function.  SCTP maintainers, can you please take a look?

Also, this might be a duplicate of "KMSAN: uninit-value in __skb_checksum_complete (4)"
(https://lore.kernel.org/lkml/0000000000000924780598075f4b@google.com/T/#u).

On Sat, Nov 23, 2019 at 10:05:09AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    3db92f3b kmsan: process DMA pages separately in kmsan_hand..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=17bad222e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e324dfe9c7b0360
> dashboard link: https://syzkaller.appspot.com/bug?extid=6dcbfea81cd3d4dd0b02
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128145cee00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6dcbfea81cd3d4dd0b02@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:112 [inline]
> BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
> BUG: KMSAN: uninit-value in __crc32c_le_base+0x4fa/0xd30 lib/crc32.c:202
> CPU: 1 PID: 12411 Comm: syz-executor.1 Not tainted 5.4.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>  kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
>  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
>  crc32_body lib/crc32.c:112 [inline]
>  crc32_le_generic lib/crc32.c:179 [inline]
>  __crc32c_le_base+0x4fa/0xd30 lib/crc32.c:202
>  chksum_update+0xb2/0x110 crypto/crc32c_generic.c:90
>  crypto_shash_update+0x4c5/0x530 crypto/shash.c:107
>  crc32c+0x150/0x220 lib/libcrc32c.c:47
>  sctp_csum_update+0x89/0xa0 include/net/sctp/checksum.h:36
>  __skb_checksum+0x1297/0x12a0 net/core/skbuff.c:2640
>  sctp_compute_cksum include/net/sctp/checksum.h:59 [inline]
>  sctp_packet_pack net/sctp/output.c:528 [inline]
>  sctp_packet_transmit+0x40fb/0x4250 net/sctp/output.c:597
>  sctp_outq_flush_transports net/sctp/outqueue.c:1146 [inline]
>  sctp_outq_flush+0x1823/0x5d80 net/sctp/outqueue.c:1194
>  sctp_outq_uncork+0xd0/0xf0 net/sctp/outqueue.c:757
>  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1781 [inline]
>  sctp_side_effects net/sctp/sm_sideeffect.c:1184 [inline]
>  sctp_do_sm+0x8fe1/0x9720 net/sctp/sm_sideeffect.c:1155
>  sctp_primitive_REQUESTHEARTBEAT+0x175/0x1a0 net/sctp/primitive.c:185
>  sctp_apply_peer_addr_params+0x212/0x1d40 net/sctp/socket.c:2433
>  sctp_setsockopt_peer_addr_params net/sctp/socket.c:2686 [inline]
>  sctp_setsockopt+0x189bb/0x19090 net/sctp/socket.c:4672
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3151
>  __sys_setsockopt+0x7c3/0xa30 net/socket.c:2084
>  __do_sys_setsockopt net/socket.c:2100 [inline]
>  __se_sys_setsockopt+0xdd/0x100 net/socket.c:2097
>  __x64_sys_setsockopt+0x62/0x80 net/socket.c:2097
>  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> RIP: 0033:0x45a639
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f2a8cb65c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045a639
> RDX: 0000000000000009 RSI: 0000000000000084 RDI: 0000000000000004
> RBP: 000000000075bfc8 R08: 0000000000000098 R09: 0000000000000000
> R10: 0000000020000440 R11: 0000000000000246 R12: 00007f2a8cb666d4
> R13: 00000000004d1a88 R14: 00000000004e08f0 R15: 00000000ffffffff
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
>  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
>  kmsan_memcpy_memmove_metadata+0x25c/0x2e0 mm/kmsan/kmsan.c:254
>  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:274
>  __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:129
>  skb_put_data include/linux/skbuff.h:2217 [inline]
>  sctp_packet_pack net/sctp/output.c:470 [inline]
>  sctp_packet_transmit+0x1d9e/0x4250 net/sctp/output.c:597
>  sctp_outq_flush_transports net/sctp/outqueue.c:1146 [inline]
>  sctp_outq_flush+0x1823/0x5d80 net/sctp/outqueue.c:1194
>  sctp_outq_uncork+0xd0/0xf0 net/sctp/outqueue.c:757
>  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1781 [inline]
>  sctp_side_effects net/sctp/sm_sideeffect.c:1184 [inline]
>  sctp_do_sm+0x8fe1/0x9720 net/sctp/sm_sideeffect.c:1155
>  sctp_primitive_REQUESTHEARTBEAT+0x175/0x1a0 net/sctp/primitive.c:185
>  sctp_apply_peer_addr_params+0x212/0x1d40 net/sctp/socket.c:2433
>  sctp_setsockopt_peer_addr_params net/sctp/socket.c:2686 [inline]
>  sctp_setsockopt+0x189bb/0x19090 net/sctp/socket.c:4672
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3151
>  __sys_setsockopt+0x7c3/0xa30 net/socket.c:2084
>  __do_sys_setsockopt net/socket.c:2100 [inline]
>  __se_sys_setsockopt+0xdd/0x100 net/socket.c:2097
>  __x64_sys_setsockopt+0x62/0x80 net/socket.c:2097
>  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
>  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
>  kmsan_memcpy_memmove_metadata+0x25c/0x2e0 mm/kmsan/kmsan.c:254
>  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:274
>  __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:129
>  skb_put_data include/linux/skbuff.h:2217 [inline]
>  sctp_addto_chunk net/sctp/sm_make_chunk.c:1494 [inline]
>  sctp_make_heartbeat+0x612/0x9e0 net/sctp/sm_make_chunk.c:1164
>  sctp_sf_heartbeat net/sctp/sm_statefuns.c:990 [inline]
>  sctp_sf_do_prm_requestheartbeat+0x8f/0x4b0 net/sctp/sm_statefuns.c:5329
>  sctp_do_sm+0x2b2/0x9720 net/sctp/sm_sideeffect.c:1152
>  sctp_primitive_REQUESTHEARTBEAT+0x175/0x1a0 net/sctp/primitive.c:185
>  sctp_apply_peer_addr_params+0x212/0x1d40 net/sctp/socket.c:2433
>  sctp_setsockopt_peer_addr_params net/sctp/socket.c:2686 [inline]
>  sctp_setsockopt+0x189bb/0x19090 net/sctp/socket.c:4672
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3151
>  __sys_setsockopt+0x7c3/0xa30 net/socket.c:2084
>  __do_sys_setsockopt net/socket.c:2100 [inline]
>  __se_sys_setsockopt+0xdd/0x100 net/socket.c:2097
>  __x64_sys_setsockopt+0x62/0x80 net/socket.c:2097
>  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
>  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
>  kmsan_memcpy_memmove_metadata+0x25c/0x2e0 mm/kmsan/kmsan.c:254
>  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:274
>  __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:129
>  sctp_make_heartbeat+0x3e9/0x9e0 net/sctp/sm_make_chunk.c:1156
>  sctp_sf_heartbeat net/sctp/sm_statefuns.c:990 [inline]
>  sctp_sf_do_prm_requestheartbeat+0x8f/0x4b0 net/sctp/sm_statefuns.c:5329
>  sctp_do_sm+0x2b2/0x9720 net/sctp/sm_sideeffect.c:1152
>  sctp_primitive_REQUESTHEARTBEAT+0x175/0x1a0 net/sctp/primitive.c:185
>  sctp_apply_peer_addr_params+0x212/0x1d40 net/sctp/socket.c:2433
>  sctp_setsockopt_peer_addr_params net/sctp/socket.c:2686 [inline]
>  sctp_setsockopt+0x189bb/0x19090 net/sctp/socket.c:4672
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3151
>  __sys_setsockopt+0x7c3/0xa30 net/socket.c:2084
>  __do_sys_setsockopt net/socket.c:2100 [inline]
>  __se_sys_setsockopt+0xdd/0x100 net/socket.c:2097
>  __x64_sys_setsockopt+0x62/0x80 net/socket.c:2097
>  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
>  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
>  kmsan_memcpy_memmove_metadata+0x25c/0x2e0 mm/kmsan/kmsan.c:254
>  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:274
>  __msan_memcpy+0x56/0x70 mm/kmsan/kmsan_instr.c:129
>  sctp_transport_init net/sctp/transport.c:47 [inline]
>  sctp_transport_new+0x248/0xa00 net/sctp/transport.c:100
>  sctp_assoc_add_peer+0x5ba/0x2030 net/sctp/associola.c:611
>  sctp_process_param net/sctp/sm_make_chunk.c:2524 [inline]
>  sctp_process_init+0x162b/0x3e30 net/sctp/sm_make_chunk.c:2345
>  sctp_cmd_process_init net/sctp/sm_sideeffect.c:667 [inline]
>  sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1374 [inline]
>  sctp_side_effects net/sctp/sm_sideeffect.c:1184 [inline]
>  sctp_do_sm+0x1b8b/0x9720 net/sctp/sm_sideeffect.c:1155
>  sctp_assoc_bh_rcv+0x65a/0xd80 net/sctp/associola.c:1048
>  sctp_inq_push+0x300/0x420 net/sctp/inqueue.c:80
>  sctp_backlog_rcv+0x2d7/0x11a0 net/sctp/input.c:344
>  sk_backlog_rcv include/net/sock.h:950 [inline]
>  __release_sock+0x448/0x640 net/core/sock.c:2439
>  release_sock+0x99/0x2a0 net/core/sock.c:2955
>  sctp_wait_for_connect+0x3d7/0x840 net/sctp/socket.c:9167
>  __sctp_connect+0x1e9d/0x1f20 net/sctp/socket.c:1226
>  __sctp_setsockopt_connectx net/sctp/socket.c:1322 [inline]
>  sctp_setsockopt_connectx_old net/sctp/socket.c:1338 [inline]
>  sctp_setsockopt+0x960d/0x19090 net/sctp/socket.c:4647
>  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3151
>  __sys_setsockopt+0x7c3/0xa30 net/socket.c:2084
>  __do_sys_setsockopt net/socket.c:2100 [inline]
>  __se_sys_setsockopt+0xdd/0x100 net/socket.c:2097
>  __x64_sys_setsockopt+0x62/0x80 net/socket.c:2097
>  do_syscall_64+0xb6/0x160 arch/x86/entry/common.c:291
>  entry_SYSCALL_64_after_hwframe+0x63/0xe7
> 
> Local variable description: ----addr.i@sctp_process_init
> Variable was created at:
>  sctp_process_param net/sctp/sm_make_chunk.c:2495 [inline]
>  sctp_process_init+0x603/0x3e30 net/sctp/sm_make_chunk.c:2345
>  sctp_process_param net/sctp/sm_make_chunk.c:2495 [inline]
>  sctp_process_init+0x603/0x3e30 net/sctp/sm_make_chunk.c:2345
> =====================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000004b2df0598075fc8%40google.com.
