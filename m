Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F95D59A2
	for <lists+linux-sctp@lfdr.de>; Mon, 14 Oct 2019 04:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfJNCtK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 13 Oct 2019 22:49:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55129 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfJNCtJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 13 Oct 2019 22:49:09 -0400
Received: by mail-io1-f70.google.com with SMTP id w8so24535532iod.21
        for <linux-sctp@vger.kernel.org>; Sun, 13 Oct 2019 19:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=orZnEAKo+tvTYtc/DSR/g4JEUJ0d6WZt/CdaVbskBII=;
        b=kknOz4ymgP3plzR6FFOZ0HhVpEGIQImdi421vO2ali/69SVxemySsp0IIx6CcHynYe
         I9Y5NDArWu3tDG1yppnS2luWWchksNyRKVai2YEcfw7nka2/iplPc6cpabZEiBne0iJ+
         1SvTXWTGLnKBKM5KAupEj6a9ArvDW41FUhhTnl8lQFe7W3EbpOk+2Vn1lpb7xMxAsrsU
         xcHngn8DOdw1eLtK362XvIYQ+V/+ZILJZ+KFrGRAq2MeoWJAwdF2JPRqsUpYhWO+METs
         yUWPKgaaRkhX1tkUq9/Ke7FkaFSY9nxKdt7C9W+L/T7SvAXLefA10BUNdJ9WPgNcMLWM
         FLCg==
X-Gm-Message-State: APjAAAVrxOqfedpQwC6EyR0Ug0BWaBNeYxZFyYv18Zh608Twflda28Qo
        VkzoErYFNLpbG7UEIi1Tf9f1ksnH0q/JG/UPJ79Aj9J2CXyu
X-Google-Smtp-Source: APXvYqwZPGuDyKKCpUyBD8S1EcUkOX3TUJyZIYZB9gnjoSB1pFD2kuMzCDSUc61oBcSNWAmSOR/aAMkTyf6qEGOkNiz0nbFpYF2/
MIME-Version: 1.0
X-Received: by 2002:a02:e47:: with SMTP id 68mr23697749jae.126.1571021349030;
 Sun, 13 Oct 2019 19:49:09 -0700 (PDT)
Date:   Sun, 13 Oct 2019 19:49:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007193390594d5e959@google.com>
Subject: memory leak in sctp_get_port_local (3)
From:   syzbot <syzbot+d44f7bbebdea49dbc84a@syzkaller.appspotmail.com>
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

HEAD commit:    da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c87fc7600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e76c708f07645488
dashboard link: https://syzkaller.appspot.com/bug?extid=d44f7bbebdea49dbc84a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128d3f8b600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ead04b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d44f7bbebdea49dbc84a@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff888120b3d380 (size 64):
   comm "syz-executor517", pid 6949, jiffies 4294941316 (age 13.400s)
   hex dump (first 32 bytes):
     23 4e 00 00 00 00 00 00 00 00 00 00 00 00 00 00  #N..............
     88 16 ef 24 81 88 ff ff 00 00 00 00 00 00 00 00  ...$............
   backtrace:
     [<000000006e6207b2>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<000000006e6207b2>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<000000006e6207b2>] slab_alloc mm/slab.c:3319 [inline]
     [<000000006e6207b2>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000d0d058e2>] sctp_bucket_create net/sctp/socket.c:8523 [inline]
     [<00000000d0d058e2>] sctp_get_port_local+0x189/0x5a0  
net/sctp/socket.c:8270
     [<0000000082735c7f>] sctp_do_bind+0xcc/0x200 net/sctp/socket.c:402
     [<0000000080c8d55e>] sctp_bindx_add+0x4b/0xd0 net/sctp/socket.c:497
     [<00000000eb10f474>] sctp_setsockopt_bindx+0x156/0x1b0  
net/sctp/socket.c:1022
     [<000000004e959dd5>] sctp_setsockopt net/sctp/socket.c:4641 [inline]
     [<000000004e959dd5>] sctp_setsockopt+0xaea/0x2dc0 net/sctp/socket.c:4611
     [<000000000e9e767a>] sock_common_setsockopt+0x38/0x50  
net/core/sock.c:3147
     [<00000000a549638a>] __sys_setsockopt+0x10f/0x220 net/socket.c:2084
     [<000000003c15b96c>] __do_sys_setsockopt net/socket.c:2100 [inline]
     [<000000003c15b96c>] __se_sys_setsockopt net/socket.c:2097 [inline]
     [<000000003c15b96c>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2097
     [<00000000ee3ea8a3>] do_syscall_64+0x73/0x1f0  
arch/x86/entry/common.c:290
     [<000000006bf005e9>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
