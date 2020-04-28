Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3911BBEDC
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Apr 2020 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgD1NSP (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 28 Apr 2020 09:18:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33602 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgD1NSO (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 28 Apr 2020 09:18:14 -0400
Received: by mail-il1-f197.google.com with SMTP id l18so23024719ilg.0
        for <linux-sctp@vger.kernel.org>; Tue, 28 Apr 2020 06:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cO1dmFjxj7pHgf6wRSI/Jxa/CJInWZCNMVN5MW1ZKzY=;
        b=qJ85GO8qFkUWbLbgmp0ovO+FEtFMOlIHdYW4kdn2leKU+9N4dPtrxFelNSThBEEJh9
         IEJatCR4s7KLwc1luQ8zRi6BFwAGzZht7JcLjNbb8ggmRc2f8Yi2DliftSp6mIF31NZ5
         j+4RHUQX9fWqaE0iYbnNJnBzhxtbpYoY6AeXoUx5KCvfSzbccDM6VKoJ9D2twQoS4vIi
         r+IGKEdB9NdrlLM/Cio9HYsupFSYc8mXGxvKnL3djrpDEUC/T0SxKOz4l0PmFDWqYBsJ
         6OXalemf3mgjsWR/uGjEv0cVTMvGhbIl1tPhB0EbSWfFN/3xE5Xb8rlsWqWy41cb+V7l
         +Qtw==
X-Gm-Message-State: AGi0PubOe/R32ujh6LCysctc1T+4YbVBjYt6cp5tDvTIoEBpSjBffUDH
        6uxHfKu3GVUHalGjCEABcJiuLYoDmX8uST33tTlN5GmFotP1
X-Google-Smtp-Source: APiQypJBIh6sWAk2VEH67hkKX92uJASxIyEFLfJT+ARXHfA+2StVE5xLgV2uAHqaoDV1NZZBwy9nTgFUgWjVtq3tx3om0yfkOcEJ
MIME-Version: 1.0
X-Received: by 2002:a02:8247:: with SMTP id q7mr3992896jag.68.1588079893206;
 Tue, 28 Apr 2020 06:18:13 -0700 (PDT)
Date:   Tue, 28 Apr 2020 06:18:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8dc1d05a459a988@google.com>
Subject: KMSAN: uninit-value in sctp_rcv
From:   syzbot <syzbot+95632cde252ddaed5a8e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bfa90a4a kmsan: remove __GFP_NO_KMSAN_SHADOW
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11d13ca7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5915107b3106aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=95632cde252ddaed5a8e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13076490100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12996d80100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+95632cde252ddaed5a8e@syzkaller.appspotmail.com

batman_adv: batadv0: Interface activated: batadv_slave_1
=====================================================
BUG: KMSAN: uninit-value in __sctp_rcv_walk_lookup net/sctp/input.c:1208 [inline]
BUG: KMSAN: uninit-value in __sctp_rcv_lookup_harder net/sctp/input.c:1287 [inline]
BUG: KMSAN: uninit-value in __sctp_rcv_lookup net/sctp/input.c:1307 [inline]
BUG: KMSAN: uninit-value in sctp_rcv+0x2b2d/0x5410 net/sctp/input.c:159
CPU: 0 PID: 8827 Comm: syz-executor885 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 __sctp_rcv_walk_lookup net/sctp/input.c:1208 [inline]
 __sctp_rcv_lookup_harder net/sctp/input.c:1287 [inline]
 __sctp_rcv_lookup net/sctp/input.c:1307 [inline]
 sctp_rcv+0x2b2d/0x5410 net/sctp/input.c:159
 ip_protocol_deliver_rcu+0x700/0xbc0 net/ipv4/ip_input.c:204
 ip_local_deliver_finish net/ipv4/ip_input.c:231 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ip_local_deliver+0x62a/0x7c0 net/ipv4/ip_input.c:252
 dst_input include/net/dst.h:442 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:428 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ip_rcv+0x6cf/0x750 net/ipv4/ip_input.c:538
 __netif_receive_skb_one_core net/core/dev.c:5187 [inline]
 __netif_receive_skb net/core/dev.c:5301 [inline]
 netif_receive_skb_internal net/core/dev.c:5391 [inline]
 netif_receive_skb+0xbb5/0xf20 net/core/dev.c:5450
 tun_rx_batched include/linux/skbuff.h:4351 [inline]
 tun_get_user+0x6aef/0x6f60 drivers/net/tun.c:1997
 tun_chr_write_iter+0x1f2/0x360 drivers/net/tun.c:2026
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:496
 vfs_write+0x44a/0x8f0 fs/read_write.c:558
 ksys_write+0x267/0x450 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:620
 __x64_sys_write+0x4a/0x70 fs/read_write.c:620
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443679
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffee474918 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000003172 RCX: 0000000000443679
RDX: 000000000000fdef RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007fffee474940 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000aa14 R11: 0000000000000246 R12: 656c6c616b7a7973
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2801 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4420
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1081 [inline]
 alloc_skb_with_frags+0x18c/0xa70 net/core/skbuff.c:5764
 sock_alloc_send_pskb+0xada/0xc60 net/core/sock.c:2245
 tun_alloc_skb drivers/net/tun.c:1529 [inline]
 tun_get_user+0x10ae/0x6f60 drivers/net/tun.c:1843
 tun_chr_write_iter+0x1f2/0x360 drivers/net/tun.c:2026
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:496
 vfs_write+0x44a/0x8f0 fs/read_write.c:558
 ksys_write+0x267/0x450 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:620
 __x64_sys_write+0x4a/0x70 fs/read_write.c:620
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
