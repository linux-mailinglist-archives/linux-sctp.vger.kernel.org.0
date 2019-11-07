Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34584F37AC
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2019 19:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKGSzK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 7 Nov 2019 13:55:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:32791 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKGSzK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 7 Nov 2019 13:55:10 -0500
Received: by mail-il1-f200.google.com with SMTP id z14so3630310ill.0
        for <linux-sctp@vger.kernel.org>; Thu, 07 Nov 2019 10:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ebPwios/a/BkGm6Az/riO5vBmQU4SCQIjm285Fi84Ok=;
        b=ssXLnEWy6rfFVraBQUftL98AqWKQxL5TPUVBZE6x9itXcGwc7bu03BHog+wU4TzbMe
         fn51tispxzuU904CbFqrEB5w5IhIo7JRTif54NWzbLKDgWrKWmDYlJn5gbGZyW9XU8P4
         iVTMt8B1P/QlLnMWGhJ3Fqm/5lh5KBsoEeRUOWd4yqeNb0jyTZB15nPNqUqa2ana6Ilw
         JYf+h9wVscU9WICo0zL3eH29gLx3jVxN+YLiXBeoxs+qulscxmndw0tc/+ItiVnQku2e
         F2mz0RijcmE96k9oVxmMZp6hzdEBKN7az0XApDjpVOWYgqStRq6YCFilt8RrIQjoxFIP
         4vWQ==
X-Gm-Message-State: APjAAAWYYQF8Ipz3RtBVifsjYp9HILoAlGDMhsSimRp1OZOo1H4xGd7w
        muG9sCIO/cYEIFMt2CG7p1X/t9NRX6iH5sNO4BKtAaeYScON
X-Google-Smtp-Source: APXvYqzBDOsS8mZ6Itklvqdj/v5vZqjYnnpcPTCDdNcQNyvmaEezCkV7wemNSVu35PiJ/FVLAvrE/7UlYClNkml7HmY5onoPiX9g
MIME-Version: 1.0
X-Received: by 2002:a92:3ad4:: with SMTP id i81mr6080862ilf.18.1573152909497;
 Thu, 07 Nov 2019 10:55:09 -0800 (PST)
Date:   Thu, 07 Nov 2019 10:55:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005927bf0596c634a2@google.com>
Subject: KCSAN: data-race in sctp_assoc_migrate / sctp_hash_obj
From:   syzbot <syzbot+e3b35fe7918ff0ee474e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, elver@google.com,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1046796ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=e3b35fe7918ff0ee474e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e3b35fe7918ff0ee474e@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in sctp_assoc_migrate / sctp_hash_obj

write to 0xffff8880b67c0020 of 8 bytes by task 18908 on cpu 1:
  sctp_assoc_migrate+0x1a6/0x290 net/sctp/associola.c:1091
  sctp_sock_migrate+0x8aa/0x9b0 net/sctp/socket.c:9465
  sctp_accept+0x3c8/0x470 net/sctp/socket.c:4916
  inet_accept+0x7f/0x360 net/ipv4/af_inet.c:734
  __sys_accept4+0x224/0x430 net/socket.c:1754
  __do_sys_accept net/socket.c:1795 [inline]
  __se_sys_accept net/socket.c:1792 [inline]
  __x64_sys_accept+0x4e/0x60 net/socket.c:1792
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8880b67c0020 of 8 bytes by task 12003 on cpu 0:
  sctp_hash_obj+0x4f/0x2d0 net/sctp/input.c:894
  rht_key_get_hash include/linux/rhashtable.h:133 [inline]
  rht_key_hashfn include/linux/rhashtable.h:159 [inline]
  rht_head_hashfn include/linux/rhashtable.h:174 [inline]
  head_hashfn lib/rhashtable.c:41 [inline]
  rhashtable_rehash_one lib/rhashtable.c:245 [inline]
  rhashtable_rehash_chain lib/rhashtable.c:276 [inline]
  rhashtable_rehash_table lib/rhashtable.c:316 [inline]
  rht_deferred_worker+0x468/0xab0 lib/rhashtable.c:420
  process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
  worker_thread+0xa0/0x800 kernel/workqueue.c:2415
  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 12003 Comm: kworker/0:6 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events rht_deferred_worker
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
