Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195D32BC86
	for <lists+linux-sctp@lfdr.de>; Tue, 28 May 2019 02:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfE1AsH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 27 May 2019 20:48:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:55806 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfE1AsH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 27 May 2019 20:48:07 -0400
Received: by mail-io1-f71.google.com with SMTP id s16so14700589ioe.22
        for <linux-sctp@vger.kernel.org>; Mon, 27 May 2019 17:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xml11WvwFdV80pdeUjkzRE4uuCvHaxcj9X4mv2XPj2M=;
        b=aIf/bCzS/wwbI8un8uDd0pzHxx2r+anLShPIMlFEXGP33xPN9Kxk5WJK8igEupUxQP
         GIPwiydG/bVB4oXC0kLhOdgv2JSgZf6RFP2rajrFwLe3AxhyatLqfXwMbnkPkZVYtXt3
         H4q4OIjLzUzFlof7demMVnTJ1TzV/8uO5HBav5cnRMPPOBhCuIKeImPjrpajtFP18Ahd
         qSQvkItUncd7akxac5ZK1OhPokB9F6AcSKwNtst0oVoK39ZV2NAaKJkHYY3WfS23HiNs
         rt5dj5ieEvG5wTDRYxzyqg0S90bAbQrlTuMezm65GFqfWk/mCzNpAie0L3fx53ZPWGa/
         0qhQ==
X-Gm-Message-State: APjAAAVtEZxmyQIl/6f+5ffEq/c2fDYdCbuu8wXHu5vfUsG9zW1bQBqf
        SpKzr+0jo5JKa7o9MM0Fv5K4Agu85ApwCLRdW/koI0bA2VYF
X-Google-Smtp-Source: APXvYqwzgrJoawmh/pkdI9g2/2cXXUBrXGI/R88w7CqqYUEM1U3tKKLlEBhMtDBlzvUEfHB5iUsPmfRrSbu1tFSQ34NoXZCeL4Kz
MIME-Version: 1.0
X-Received: by 2002:a6b:e412:: with SMTP id u18mr2625846iog.132.1559004486017;
 Mon, 27 May 2019 17:48:06 -0700 (PDT)
Date:   Mon, 27 May 2019 17:48:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097abb90589e804fd@google.com>
Subject: memory leak in sctp_process_init
From:   syzbot <syzbot+f7e9153b037eac9b1df8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9c7db500 Merge tag 'selinux-pr-20190521' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10388530a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61dd9e15a761691d
dashboard link: https://syzkaller.appspot.com/bug?extid=f7e9153b037eac9b1df8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e32f8ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177fa530a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f7e9153b037eac9b1df8@syzkaller.appspotmail.com

  0 to HW filter on device batadv0
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 28.770s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 28.840s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 28.910s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 28.980s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 29.050s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 29.120s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 29.190s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301

BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
   comm "syz-executor273", pid 7046, jiffies 4294945598 (age 29.260s)
   hex dump (first 32 bytes):
     1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000a02cebbd>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
     [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
     [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
     [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20  
net/sctp/sm_make_chunk.c:2437
     [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682  
[inline]
     [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384  
[inline]
     [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194  
[inline]
     [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60  
net/sctp/sm_sideeffect.c:1165
     [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200  
net/sctp/associola.c:1074
     [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
     [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
     [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
     [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
     [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
     [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
     [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
     [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
     [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
     [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
     [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
     [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
