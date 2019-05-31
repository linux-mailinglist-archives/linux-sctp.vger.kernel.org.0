Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3931680
	for <lists+linux-sctp@lfdr.de>; Fri, 31 May 2019 23:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfEaVSH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 31 May 2019 17:18:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38461 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfEaVSH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 31 May 2019 17:18:07 -0400
Received: by mail-io1-f69.google.com with SMTP id w3so8682107iot.5
        for <linux-sctp@vger.kernel.org>; Fri, 31 May 2019 14:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9vJ5p7g65WszXpcgdHNrhcEVIXylvGJSGHu7KxUMRl0=;
        b=lf9XqtfB+7frFuwmf3aYdwEczjpzqrT8DvjFmNKsns23v4YF26j34KOvQuphna2XGL
         8oQOmOesZXHHEqJ4Lt2lOt99CaY8YF08D0Dx/wypqPEsg+0CxilGTQkRRnkfFkoZPsmb
         xxHMXgwTHwVTgGM8UsES9sWA6gT1HnRF7dlHHcpfC7PjkAdigRQcx71Zvk1twGjmmWyA
         WgMrSNTpiPhWWBpuYZp46vzLRwcfaCQGvf/iqnzZ3+qrtpvdnxwFldm8qs9s+a0i/T8e
         yS+VfVxPYb8iH3wpNDhGj1xx6zSxZhbbo7nFeOB13pfw57jW3vqar4fiBfk8QYLDjSHh
         ZYRw==
X-Gm-Message-State: APjAAAVvcm3DNtThR+1VGJHN8T1pAogcYEtyjFkuW0lFzmVlvmlfjW+I
        DEybV3obbHFn3fwEKdLJWcgmKaGfso/55wTbbqxrBSK4l8rw
X-Google-Smtp-Source: APXvYqyQthWYZkYEzHAw27Fklkf9ijpz/D7EU/qN25ZeTvfoP8xszP9EdDcihQRxiZOU0u7xwOU77U09S102kJHodTHCUDVE0ATP
MIME-Version: 1.0
X-Received: by 2002:a05:660c:6c1:: with SMTP id z1mr9492253itk.126.1559337486489;
 Fri, 31 May 2019 14:18:06 -0700 (PDT)
Date:   Fri, 31 May 2019 14:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7a443058a358cb4@google.com>
Subject: memory leak in sctp_send_reset_streams
From:   syzbot <syzbot+6ad9c3bd0a218a2ab41d@syzkaller.appspotmail.com>
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

HEAD commit:    036e3431 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153cff12a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f0f63a62bb5b13c
dashboard link: https://syzkaller.appspot.com/bug?extid=6ad9c3bd0a218a2ab41d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12561c86a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b76fd8a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6ad9c3bd0a218a2ab41d@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888123894820 (size 32):
   comm "syz-executor045", pid 7267, jiffies 4294943559 (age 13.660s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000c7e71c69>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c7e71c69>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c7e71c69>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000c7e71c69>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000c7e71c69>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<000000003250ed8e>] kmalloc_array include/linux/slab.h:670 [inline]
     [<000000003250ed8e>] kcalloc include/linux/slab.h:681 [inline]
     [<000000003250ed8e>] sctp_send_reset_streams+0x1ab/0x5a0  
net/sctp/stream.c:302
     [<00000000cd899c6e>] sctp_setsockopt_reset_streams  
net/sctp/socket.c:4314 [inline]
     [<00000000cd899c6e>] sctp_setsockopt net/sctp/socket.c:4765 [inline]
     [<00000000cd899c6e>] sctp_setsockopt+0xc23/0x2bf0 net/sctp/socket.c:4608
     [<00000000ff3a21a2>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3130
     [<000000009eb87ae7>] __sys_setsockopt+0x98/0x120 net/socket.c:2078
     [<00000000e0ede6ca>] __do_sys_setsockopt net/socket.c:2089 [inline]
     [<00000000e0ede6ca>] __se_sys_setsockopt net/socket.c:2086 [inline]
     [<00000000e0ede6ca>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2086
     [<00000000c61155f5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000e540958c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123894980 (size 32):
   comm "syz-executor045", pid 7268, jiffies 4294944145 (age 7.800s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000c7e71c69>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000c7e71c69>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000c7e71c69>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000c7e71c69>] __do_kmalloc mm/slab.c:3658 [inline]
     [<00000000c7e71c69>] __kmalloc+0x161/0x2c0 mm/slab.c:3669
     [<000000003250ed8e>] kmalloc_array include/linux/slab.h:670 [inline]
     [<000000003250ed8e>] kcalloc include/linux/slab.h:681 [inline]
     [<000000003250ed8e>] sctp_send_reset_streams+0x1ab/0x5a0  
net/sctp/stream.c:302
     [<00000000cd899c6e>] sctp_setsockopt_reset_streams  
net/sctp/socket.c:4314 [inline]
     [<00000000cd899c6e>] sctp_setsockopt net/sctp/socket.c:4765 [inline]
     [<00000000cd899c6e>] sctp_setsockopt+0xc23/0x2bf0 net/sctp/socket.c:4608
     [<00000000ff3a21a2>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3130
     [<000000009eb87ae7>] __sys_setsockopt+0x98/0x120 net/socket.c:2078
     [<00000000e0ede6ca>] __do_sys_setsockopt net/socket.c:2089 [inline]
     [<00000000e0ede6ca>] __se_sys_setsockopt net/socket.c:2086 [inline]
     [<00000000e0ede6ca>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2086
     [<00000000c61155f5>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<00000000e540958c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
