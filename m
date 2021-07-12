Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC03C4349
	for <lists+linux-sctp@lfdr.de>; Mon, 12 Jul 2021 06:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGLEsG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 12 Jul 2021 00:48:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45585 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhGLEsF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 12 Jul 2021 00:48:05 -0400
Received: by mail-io1-f69.google.com with SMTP id e24-20020a5d8e180000b02904dd8a55bbd7so10933093iod.12
        for <linux-sctp@vger.kernel.org>; Sun, 11 Jul 2021 21:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dhsrr+rASginLez2RsCV5ojUkurrc4xIF+0RmQJkAxQ=;
        b=Vh9Wx5NceJXOPN8A9gK0PHNgj3tXaHY/rsiZ5IGE5CVyNGpKt4lObJyZ8YUJOeOgzF
         06CGFqktNVw4QH2oQF16bjlH8O7tou8DcDFumCsQMLKFqNUvXw1Rg0GTjW/p/MBz4cvb
         F3XfMrJm/lLcNOR0cpnK53PZFWLqWvBewQQjMjvAphDVASjkXamU/4D+WqJsVyNSOp2B
         EXQOpkYsAnMTu0DQVXs8uQ29AeFyxSVVPc0YedLk4LL4NQeFOIoPcFQZYTb3MtgtkNxl
         AJOkASSxbcALQOzRXyILgopXOSrPF9UJg2luZwEtDhLQJbM3FkwQ1GMHgyexAK2tenn8
         dhJA==
X-Gm-Message-State: AOAM531q5Xb9EpySTjm+HrvoxwRBMTL3LBIfQjXr0c8EyABUjqjQT9dR
        W5YfNfCOTqFMvWh03tXoqJ3j8KQ0n8dN7FR/oX86I09NGi2T
X-Google-Smtp-Source: ABdhPJyN9waIunR13JsG3I44opbLaf2o0/KDW+GJFCyOSBhqewa0j4Pb+iqTjO3IeoVkZzsC8aLzznA8W3G/L+rMvz+Im+CkZJ44
MIME-Version: 1.0
X-Received: by 2002:a6b:cf15:: with SMTP id o21mr38748471ioa.9.1626065116107;
 Sun, 11 Jul 2021 21:45:16 -0700 (PDT)
Date:   Sun, 11 Jul 2021 21:45:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0982305c6e5c9f5@google.com>
Subject: [syzbot] KASAN: use-after-free Write in sctp_auth_shkey_hold
From:   syzbot <syzbot+b774577370208727d12b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e437416 Merge branch 'dsa-mv88e6xxx-topaz-fixes'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14503bac300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4cb84363d46e9fc3
dashboard link: https://syzkaller.appspot.com/bug?extid=b774577370208727d12b

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b774577370208727d12b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:111 [inline]
BUG: KASAN: use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: use-after-free in sctp_auth_shkey_hold+0x22/0xa0 net/sctp/auth.c:112
Write of size 4 at addr ffff88802053ad58 by task syz-executor.1/31590

CPU: 0 PID: 31590 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:111 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sctp_auth_shkey_hold+0x22/0xa0 net/sctp/auth.c:112
 sctp_set_owner_w net/sctp/socket.c:131 [inline]
 sctp_sendmsg_to_asoc+0x152e/0x2180 net/sctp/socket.c:1865
 sctp_sendmsg+0x103b/0x1d30 net/sctp/socket.c:2027
 inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:821
 sock_sendmsg_nosec net/socket.c:702 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:722
 ____sys_sendmsg+0x331/0x810 net/socket.c:2385
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2439
 __sys_sendmmsg+0x195/0x470 net/socket.c:2525
 __do_sys_sendmmsg net/socket.c:2554 [inline]
 __se_sys_sendmmsg net/socket.c:2551 [inline]
 __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2551
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f679ad9b188 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000002 RSI: 0000000020002340 RDI: 0000000000000003
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc95431f0f R14: 00007f679ad9b300 R15: 0000000000022000

Allocated by task 31590:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 sctp_auth_shkey_create+0x85/0x1f0 net/sctp/auth.c:84
 sctp_auth_asoc_copy_shkeys+0x1e8/0x350 net/sctp/auth.c:363
 sctp_association_init net/sctp/associola.c:257 [inline]
 sctp_association_new+0x1829/0x2250 net/sctp/associola.c:298
 sctp_connect_new_asoc+0x1ac/0x770 net/sctp/socket.c:1088
 __sctp_connect+0x3d0/0xc30 net/sctp/socket.c:1194
 sctp_connect net/sctp/socket.c:4804 [inline]
 sctp_inet_connect+0x15e/0x200 net/sctp/socket.c:4819
 __sys_connect_file+0x155/0x1a0 net/socket.c:1872
 __sys_connect+0x161/0x190 net/socket.c:1889
 __do_sys_connect net/socket.c:1899 [inline]
 __se_sys_connect net/socket.c:1896 [inline]
 __x64_sys_connect+0x6f/0xb0 net/socket.c:1896
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 31590:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1639 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1664
 slab_free mm/slub.c:3224 [inline]
 kfree+0xeb/0x670 mm/slub.c:4268
 sctp_auth_shkey_destroy net/sctp/auth.c:101 [inline]
 sctp_auth_shkey_release+0x100/0x160 net/sctp/auth.c:107
 sctp_auth_set_key+0x508/0x6d0 net/sctp/auth.c:862
 sctp_setsockopt_auth_key net/sctp/socket.c:3643 [inline]
 sctp_setsockopt+0x4919/0xa5e0 net/sctp/socket.c:4682
 __sys_setsockopt+0x2db/0x610 net/socket.c:2152
 __do_sys_setsockopt net/socket.c:2163 [inline]
 __se_sys_setsockopt net/socket.c:2160 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2160
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88802053ad40
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 24 bytes inside of
 32-byte region [ffff88802053ad40, ffff88802053ad60)
The buggy address belongs to the page:
page:ffffea0000814e80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2053a
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010841500
raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4873, ts 20137001110, free_ts 20080007470
 prep_new_page mm/page_alloc.c:2445 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4178
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5386
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1702 [inline]
 allocate_slab+0x32b/0x4c0 mm/slub.c:1842
 new_slab mm/slub.c:1905 [inline]
 new_slab_objects mm/slub.c:2651 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2814
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2854
 slab_alloc_node mm/slub.c:2936 [inline]
 slab_alloc mm/slub.c:2978 [inline]
 __kmalloc+0x312/0x330 mm/slub.c:4106
 kmalloc include/linux/slab.h:596 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x28/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x186/0x620 security/tomoyo/realpath.c:288
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1332
 vfs_getattr fs/stat.c:139 [inline]
 vfs_statx+0x164/0x390 fs/stat.c:207
 vfs_fstatat fs/stat.c:225 [inline]
 vfs_lstat include/linux/fs.h:3384 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1355 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3341 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3420
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8e/0xa0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2970 [inline]
 slab_alloc mm/slub.c:2978 [inline]
 kmem_cache_alloc+0x29b/0x4a0 mm/slub.c:2983
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x8e/0xd0 fs/namei.c:209
 do_sys_openat2+0xf5/0x420 fs/open.c:1189
 do_sys_open fs/open.c:1211 [inline]
 __do_sys_open fs/open.c:1219 [inline]
 __se_sys_open fs/open.c:1215 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1215
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88802053ac00: 00 00 00 02 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88802053ac80: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88802053ad00: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                    ^
 ffff88802053ad80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88802053ae00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
