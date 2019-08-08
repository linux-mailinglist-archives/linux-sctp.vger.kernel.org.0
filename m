Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB4864E4
	for <lists+linux-sctp@lfdr.de>; Thu,  8 Aug 2019 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfHHO6J (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 8 Aug 2019 10:58:09 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:45964 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHO6G (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 8 Aug 2019 10:58:06 -0400
Received: by mail-ot1-f72.google.com with SMTP id b25so62149407otp.12
        for <linux-sctp@vger.kernel.org>; Thu, 08 Aug 2019 07:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hzPCZwefKJfQcvn5B7LPmicli4s8uiqMv/SP2gxfHXg=;
        b=D+n+XUHz5Qu2j69rWQElYo0kCMOm209BL/yCWRYuJtLGTwpcv9ljujrvXicwQ2WTyk
         kPgluSIRzOXtBa2+K1wf3s/fAHmSl4NBx+iZdDaqrr00aV2cZVe+Af3cZmf7B0DGbYFN
         oMVYebbuSynR5mySm+CfEyhhPyzKS65aqUxObddysBDjUvZ2vXqv4fS6mT2RnmRb6OYq
         x2B+aH1Nac9gCJlgLeEPoEAQTP35r38F4Z24WJZF0ZcrsJ+nvwcQ41u5XEKFcTklHmVy
         IUprboWxZMllPKW66bspiO0Y+YR19Xc9H4ys7qcrW74aBbaQ8j3fiugdO+80KYVp8qNk
         0p0A==
X-Gm-Message-State: APjAAAWLoOHCmYDsLBt9DLQOrF3vxcP8o1UjKVIGWNjLox8Nr5u761Pl
        uZUU6CQANx7uGF9IO3iFtcQp5JVoIVEfmLLk+POxf1d3ENOx
X-Google-Smtp-Source: APXvYqwDuB4Usf52KhYW2cUba6zYP1GiRCFwKZz8FS9QcEa26TO21VotgwzpkHA8HVAZ0/wMGyjDY/77LlbDwzXW1RAx7kGPnZ53
MIME-Version: 1.0
X-Received: by 2002:a02:b791:: with SMTP id f17mr5130499jam.51.1565276285514;
 Thu, 08 Aug 2019 07:58:05 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:58:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f93dd2058f9c4873@google.com>
Subject: memory leak in sctp_get_port_local (2)
From:   syzbot <syzbot+2d7ecdf99f15689032b3@syzkaller.appspotmail.com>
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

HEAD commit:    0eb0ce0a Merge tag 'spi-fix-v5.3-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1234588c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39113f5c48aea971
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7ecdf99f15689032b3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e1906600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140ab906600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2d7ecdf99f15689032b3@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810fa4b380 (size 64):
   comm "syz-executor900", pid 7117, jiffies 4294946947 (age 16.560s)
   hex dump (first 32 bytes):
     20 4e 00 00 89 e7 4c 8d 00 00 00 00 00 00 00 00   N....L.........
     58 40 dd 16 82 88 ff ff 00 00 00 00 00 00 00 00  X@..............
   backtrace:
     [<00000000f1461735>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000f1461735>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000f1461735>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000f1461735>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000ff3ccf22>] sctp_bucket_create net/sctp/socket.c:8374 [inline]
     [<00000000ff3ccf22>] sctp_get_port_local+0x189/0x5b0  
net/sctp/socket.c:8121
     [<00000000eed41612>] sctp_do_bind+0xcc/0x1e0 net/sctp/socket.c:402
     [<000000002bf65239>] sctp_bind+0x44/0x70 net/sctp/socket.c:302
     [<00000000b1aaaf57>] inet_bind+0x40/0xc0 net/ipv4/af_inet.c:441
     [<00000000db36b917>] __sys_bind+0x11c/0x140 net/socket.c:1647
     [<00000000679cfe3c>] __do_sys_bind net/socket.c:1658 [inline]
     [<00000000679cfe3c>] __se_sys_bind net/socket.c:1656 [inline]
     [<00000000679cfe3c>] __x64_sys_bind+0x1e/0x30 net/socket.c:1656
     [<000000002aac3ac2>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<000000000c38e074>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fa4b380 (size 64):
   comm "syz-executor900", pid 7117, jiffies 4294946947 (age 19.260s)
   hex dump (first 32 bytes):
     20 4e 00 00 89 e7 4c 8d 00 00 00 00 00 00 00 00   N....L.........
     58 40 dd 16 82 88 ff ff 00 00 00 00 00 00 00 00  X@..............
   backtrace:
     [<00000000f1461735>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000f1461735>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000f1461735>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000f1461735>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000ff3ccf22>] sctp_bucket_create net/sctp/socket.c:8374 [inline]
     [<00000000ff3ccf22>] sctp_get_port_local+0x189/0x5b0  
net/sctp/socket.c:8121
     [<00000000eed41612>] sctp_do_bind+0xcc/0x1e0 net/sctp/socket.c:402
     [<000000002bf65239>] sctp_bind+0x44/0x70 net/sctp/socket.c:302
     [<00000000b1aaaf57>] inet_bind+0x40/0xc0 net/ipv4/af_inet.c:441
     [<00000000db36b917>] __sys_bind+0x11c/0x140 net/socket.c:1647
     [<00000000679cfe3c>] __do_sys_bind net/socket.c:1658 [inline]
     [<00000000679cfe3c>] __se_sys_bind net/socket.c:1656 [inline]
     [<00000000679cfe3c>] __x64_sys_bind+0x1e/0x30 net/socket.c:1656
     [<000000002aac3ac2>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<000000000c38e074>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fa4b380 (size 64):
   comm "syz-executor900", pid 7117, jiffies 4294946947 (age 21.990s)
   hex dump (first 32 bytes):
     20 4e 00 00 89 e7 4c 8d 00 00 00 00 00 00 00 00   N....L.........
     58 40 dd 16 82 88 ff ff 00 00 00 00 00 00 00 00  X@..............
   backtrace:
     [<00000000f1461735>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000f1461735>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000f1461735>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000f1461735>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000ff3ccf22>] sctp_bucket_create net/sctp/socket.c:8374 [inline]
     [<00000000ff3ccf22>] sctp_get_port_local+0x189/0x5b0  
net/sctp/socket.c:8121
     [<00000000eed41612>] sctp_do_bind+0xcc/0x1e0 net/sctp/socket.c:402
     [<000000002bf65239>] sctp_bind+0x44/0x70 net/sctp/socket.c:302
     [<00000000b1aaaf57>] inet_bind+0x40/0xc0 net/ipv4/af_inet.c:441
     [<00000000db36b917>] __sys_bind+0x11c/0x140 net/socket.c:1647
     [<00000000679cfe3c>] __do_sys_bind net/socket.c:1658 [inline]
     [<00000000679cfe3c>] __se_sys_bind net/socket.c:1656 [inline]
     [<00000000679cfe3c>] __x64_sys_bind+0x1e/0x30 net/socket.c:1656
     [<000000002aac3ac2>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<000000000c38e074>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810fa4b380 (size 64):
   comm "syz-executor900", pid 7117, jiffies 4294946947 (age 22.940s)
   hex dump (first 32 bytes):
     20 4e 00 00 89 e7 4c 8d 00 00 00 00 00 00 00 00   N....L.........
     58 40 dd 16 82 88 ff ff 00 00 00 00 00 00 00 00  X@..............
   backtrace:
     [<00000000f1461735>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000f1461735>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000f1461735>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000f1461735>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000ff3ccf22>] sctp_bucket_create net/sctp/socket.c:8374 [inline]
     [<00000000ff3ccf22>] sctp_get_port_local+0x189/0x5b0  
net/sctp/socket.c:8121
     [<00000000eed41612>] sctp_do_bind+0xcc/0x1e0 net/sctp/socket.c:402
     [<000000002bf65239>] sctp_bind+0x44/0x70 net/sctp/socket.c:302
     [<00000000b1aaaf57>] inet_bind+0x40/0xc0 net/ipv4/af_inet.c:441
     [<00000000db36b917>] __sys_bind+0x11c/0x140 net/socket.c:1647
     [<00000000679cfe3c>] __do_sys_bind net/socket.c:1658 [inline]
     [<00000000679cfe3c>] __se_sys_bind net/socket.c:1656 [inline]
     [<00000000679cfe3c>] __x64_sys_bind+0x1e/0x30 net/socket.c:1656
     [<000000002aac3ac2>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<000000000c38e074>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program
executing program
executing program


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
