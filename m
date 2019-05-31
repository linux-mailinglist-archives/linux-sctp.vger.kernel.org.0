Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0F310B5
	for <lists+linux-sctp@lfdr.de>; Fri, 31 May 2019 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEaO6O (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 31 May 2019 10:58:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45443 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfEaO6G (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 31 May 2019 10:58:06 -0400
Received: by mail-io1-f71.google.com with SMTP id b197so7717271iof.12
        for <linux-sctp@vger.kernel.org>; Fri, 31 May 2019 07:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VAWNQSWXRFPjqWqvcnCxEWc2vR3xbR4pd4DDjFUHobY=;
        b=arsKIhx+e6faMCn84OX5gRQ5u03Sy3X8WgWYzpH1YAVzFzPPJv9XNuGWpBf2TX/8C8
         BqUzXLXt0+UE0kSsDGDR7gVcduGHORqlVG1GKiCrMu/mFpk18iNjoyVrS6EJRd7lJ4X0
         pBFTSMCRtJsh0L2rojy73SdRUY7xel1Zh39WJKFT7dQAVToTbgv3nLLBOyI9XzaqWSA7
         dBFqhoOwze/PsHEnUV13qM2O62aAR48KDBYGdP81eL4N0IQzXqoPrGY9gGdXdk53LuZD
         IcJZZgjT2hn2ZHwB/DfAU9vOdgl703EaU9em6Mg+5OFsryNekry3ZJxfYGiKmZK+A2sy
         eu5A==
X-Gm-Message-State: APjAAAVECPqNwsCPIqnFS3yhDpweB3dbrq5bjSpOg9vWZIXOEcNrPVeK
        S8yazZpHUfU/JItmQ96+zQDbcEPMj+2tOOxN05FKeJyFqAAd
X-Google-Smtp-Source: APXvYqy2LGeUvc5Dv4FGMjjqAoqP0NyUOjJt4CyFzayeTo7kbBilfa4tIw/mJKkyGhkh2Se+kWhGagFiaeOjWEqSVURBSe8Ui2Fy
MIME-Version: 1.0
X-Received: by 2002:a05:660c:444:: with SMTP id d4mr7089633itl.158.1559314685827;
 Fri, 31 May 2019 07:58:05 -0700 (PDT)
Date:   Fri, 31 May 2019 07:58:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f122ab058a303d94@google.com>
Subject: memory leak in sctp_stream_init_ext
From:   syzbot <syzbot+7f3b6b106be8dcdcdeec@syzkaller.appspotmail.com>
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

HEAD commit:    bec7550c Merge tag 'docs-5.2-fixes2' of git://git.lwn.net/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152a0916a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64479170dcaf0e11
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3b6b106be8dcdcdeec
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1142cd4ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f81d72a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f3b6b106be8dcdcdeec@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881114f5d80 (size 96):
   comm "syz-executor934", pid 7160, jiffies 4294993058 (age 31.950s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000ce7a1326>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000ce7a1326>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ce7a1326>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ce7a1326>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007abb7ac9>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007abb7ac9>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007abb7ac9>] sctp_stream_init_ext+0x2b/0xa0  
net/sctp/stream.c:157
     [<0000000048ecb9c1>] sctp_sendmsg_to_asoc+0x946/0xa00  
net/sctp/socket.c:1882
     [<000000004483ca2b>] sctp_sendmsg+0x2a8/0x990 net/sctp/socket.c:2102
     [<0000000094bdc32e>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<0000000022d1c2a5>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<0000000022d1c2a5>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000006ab53119>] sock_write_iter+0xb6/0x130 net/socket.c:1000
     [<00000000973772ef>] call_write_iter include/linux/fs.h:1872 [inline]
     [<00000000973772ef>] new_sync_write+0x1ad/0x260 fs/read_write.c:483
     [<0000000033f2491b>] __vfs_write+0x87/0xa0 fs/read_write.c:496
     [<00000000372fbd56>] vfs_write fs/read_write.c:558 [inline]
     [<00000000372fbd56>] vfs_write+0xee/0x210 fs/read_write.c:542
     [<000000007ccb2ea5>] ksys_write+0x7c/0x130 fs/read_write.c:611
     [<000000001c29b8c7>] __do_sys_write fs/read_write.c:623 [inline]
     [<000000001c29b8c7>] __se_sys_write fs/read_write.c:620 [inline]
     [<000000001c29b8c7>] __x64_sys_write+0x1e/0x30 fs/read_write.c:620
     [<0000000014d9243b>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000059f6e9a8>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881114f5d80 (size 96):
   comm "syz-executor934", pid 7160, jiffies 4294993058 (age 33.160s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000ce7a1326>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000ce7a1326>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ce7a1326>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ce7a1326>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007abb7ac9>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007abb7ac9>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007abb7ac9>] sctp_stream_init_ext+0x2b/0xa0  
net/sctp/stream.c:157
     [<0000000048ecb9c1>] sctp_sendmsg_to_asoc+0x946/0xa00  
net/sctp/socket.c:1882
     [<000000004483ca2b>] sctp_sendmsg+0x2a8/0x990 net/sctp/socket.c:2102
     [<0000000094bdc32e>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
     [<0000000022d1c2a5>] sock_sendmsg_nosec net/socket.c:652 [inline]
     [<0000000022d1c2a5>] sock_sendmsg+0x54/0x70 net/socket.c:671
     [<000000006ab53119>] sock_write_iter+0xb6/0x130 net/socket.c:1000
     [<00000000973772ef>] call_write_iter include/linux/fs.h:1872 [inline]
     [<00000000973772ef>] new_sync_write+0x1ad/0x260 fs/read_write.c:483
     [<0000000033f2491b>] __vfs_write+0x87/0xa0 fs/read_write.c:496
     [<00000000372fbd56>] vfs_write fs/read_write.c:558 [inline]
     [<00000000372fbd56>] vfs_write+0xee/0x210 fs/read_write.c:542
     [<000000007ccb2ea5>] ksys_write+0x7c/0x130 fs/read_write.c:611
     [<000000001c29b8c7>] __do_sys_write fs/read_write.c:623 [inline]
     [<000000001c29b8c7>] __se_sys_write fs/read_write.c:620 [inline]
     [<000000001c29b8c7>] __x64_sys_write+0x1e/0x30 fs/read_write.c:620
     [<0000000014d9243b>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000059f6e9a8>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program
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
