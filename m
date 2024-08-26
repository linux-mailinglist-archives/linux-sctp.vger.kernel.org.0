Return-Path: <linux-sctp+bounces-219-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A295F615
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 18:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0C282876
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94C719342E;
	Mon, 26 Aug 2024 16:09:27 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1A4C96
	for <linux-sctp@vger.kernel.org>; Mon, 26 Aug 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688567; cv=none; b=dc3zR8SKyOiUd9RRYi7VdlnuUUuDB/N1I1+G0y5w2vt/nX6pp4QKJH1gjqgWizCEuNStoVqI8755fQI4NJjNrFkul/w7knJzQKntzEXadfg/Wqjq61zrhFd07YoFkDzKavI2AD6GbFy+qeHisaYTtjCp2H0Pk5ksSLNiNrKtC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688567; c=relaxed/simple;
	bh=xRFXY7a1NS7rsT5IPKt+2U4xXWn38dio2H9Pw0Geql8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YIyegkPWwXcW8Aq7p5PAN4AuBiwUfBPYYqJazYUYsMFMIiCVqaZMym3cmZ+cHK6mPT0cjb+bPsfA3q+wGVzL22sMqjlZiy94IOvISN+PJV/4o8+mS5T6iTbP4bfy5ytXAkccliW3ZHbrw+c0H5HWvcOUkZhFfAQ4mCfYmxjqV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d27488930so46085755ab.3
        for <linux-sctp@vger.kernel.org>; Mon, 26 Aug 2024 09:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724688565; x=1725293365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0mc0zFjo46BT2fOdbAUWNVmQV1JwvohMKwJbBgfLZI=;
        b=CsdbFcFSvrRv3DNhXNKD7ahWBbiQ5CZsAGvBwymKLqKDpHhpEe7uok64hOa/mo8BFG
         eZC1jfAHPji1zh6t8n6XB7Tb/uIGTnri6P2cDnpDGndOukbpvFaeO88T3NKoa5miLgvk
         eSTA5s1Ph1uoRPi1l6CvPacdbdXajbwPXo9+dkY0GwcPziXU9ujPmovt1eGoFMnZXIH0
         X96XAPOzXK1DqEuHDZ6HGvXnOacwKmam+V8H7d4DHhH7jWqq7yl5dV6X8D3klxryOrtH
         AZLGK3LJa3PDXTXyifhASCa0ndGvFa6yfNm4sjG+Y/DiHrxXR+a54D0uoH8Y1LeudJsj
         6kbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSK0zu0ShIKIX+uYJtg+qZmWhFfTZ6Rw2Lwrewfr5g9LAByCUVYm76O9p2oQMj4u5Xoi8GS0J9kfdg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ttJPE8gL7TppRAdfLfbI/DrudvRFm95OEJkAjG7hPXItkn2O
	fVeYiNH+cLbfYHoqdTiB1vgMZ3hJ6DltNEVgb5oRGm2W0r31gwD0dXEGjsEwAp8/eOYe6Hl/1yg
	/NPO3F93eLfJV6kvimeo8dGwJ+eplx66JbR0E9NUrRuEIKufSc91znfo=
X-Google-Smtp-Source: AGHT+IGoUMvqtqNrZf06zsHOHnmrGyNj+DWyQGAwEMMxlJdkSBcPdRRHX4Wfi6NwwZXbVgIrQadcm5S3xyQWNL6vU9Cw6EenfmJ8
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c4:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39e63acc9b5mr120435ab.0.1724688565033; Mon, 26 Aug 2024
 09:09:25 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044832c06209859bd@google.com>
Subject: [syzbot] [sctp?] KMSAN: uninit-value in sctp_sf_ootb
From: syzbot <syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e9b7f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62f882de896675a6
dashboard link: https://syzkaller.appspot.com/bug?extid=f0cbb34d39392f2746ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/17f6ee87834d/disk-d2bafcf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7783769858d1/vmlinux-d2bafcf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45248109d188/bzImage-d2bafcf2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3702
 sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3702
 sctp_do_sm+0x181/0x93d0 net/sctp/sm_sideeffect.c:1166
 sctp_endpoint_bh_rcv+0xc38/0xf90 net/sctp/endpointola.c:407
 sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
 sctp_rcv+0x3831/0x3b20 net/sctp/input.c:243
 sctp4_rcv+0x42/0x50 net/sctp/protocol.c:1158
 ip_protocol_deliver_rcu+0xb51/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5775
 netif_receive_skb_internal net/core/dev.c:5861 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5921
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5677/0x6b50 drivers/net/tun.c:2006
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
 pskb_expand_head+0x222/0x19c0 net/core/skbuff.c:2259
 __skb_cow include/linux/skbuff.h:3646 [inline]
 skb_cow include/linux/skbuff.h:3665 [inline]
 ip_rcv_options net/ipv4/ip_input.c:272 [inline]
 ip_rcv_finish_core+0xf3d/0x1fe0 net/ipv4/ip_input.c:387
 ip_rcv_finish+0x2cc/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5775
 netif_receive_skb_internal net/core/dev.c:5861 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5921
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5677/0x6b50 drivers/net/tun.c:2006
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb2f/0x1550 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 13990 Comm: syz.3.1326 Not tainted 6.11.0-rc4-syzkaller-00255-gd2bafcf224f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

