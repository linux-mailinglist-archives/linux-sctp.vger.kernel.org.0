Return-Path: <linux-sctp+bounces-276-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9219B5159
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519601C219B4
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A01DB372;
	Tue, 29 Oct 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAlwwcIO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C1194A64;
	Tue, 29 Oct 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224389; cv=none; b=GMmgcK/GWIJZ6yjx/QjNKZofd5IyHBPs+SMEe9caqON0j1R5L2ggWw9xbAgkRHsfgC2CzQln8nuNZCERsBT0Ys7JJyvHUh8qTUfCD4sWzjFIdz5w+wUlat2XvmzgZZhonMv2wOfYhi2HBOsNHmNxo9mhMV614nV088w//+dLj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224389; c=relaxed/simple;
	bh=lMs076dB9m6Rrf0Oz5b2e6MGUaNRcSM5mDh7+qXng8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdTta9nQWAGr0CefVNZgmVflDirw36iIvVlpDkxdUeCsLS4O+7P4gMX/bNkNqiYI1V0+eAVCy+pWaR+8+MFpFdPrEPrw9pMGblm/gLThB+5MkuYr8ckJoJT3ssVVtpbzLuft0C+eENv3bDqtqGgdbTNJH3vw9M6oIiX70+THpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAlwwcIO; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a4e5e57679so15124005ab.0;
        Tue, 29 Oct 2024 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730224386; x=1730829186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M+5zJncJw2cJDUFF1hsOqjSFbKQ8MJXAgAE2JhHUqk=;
        b=XAlwwcIOpu1Y5LSZB4z/OynnMPSZ+FyZ2UvEB+ExyWCkSDY8J8NUacTVqQF7wCzsLU
         uNH8EjLKzoWxxGEyWdiIJEQLVU+VJS3JmzKvOtb1EgB9IWSxFrCXuXf3fxmBZYIxd/FD
         qqblvRug5gGXPldVpqVmLpDv2/vQD+vHCFabSbJ7zTEAqRRMOcRJ63xsi47l/ngccUB4
         rdGr/CV8u20uspBBzFdCERdh1vsrWSKKxz4I6sOVQYslIhKDr0V+hyyKW1wNQqhRQW/E
         ABos3iEKFBwxroa8zRWWGrXLlYH5hxLpkQeUnRgiKtgeqWQU5tRvF1E9aJl2vFXDElGn
         LPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224386; x=1730829186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0M+5zJncJw2cJDUFF1hsOqjSFbKQ8MJXAgAE2JhHUqk=;
        b=NJ2D3m5/xXsxTrR8rWR21IzGoseZvT9XXEoDAU5f4sMxneX/MM7GfnBMBfRx4++JvZ
         lThweyxcm7QGadTsmyHMZCCoRgaHVLPyT3KoY7a4d/x4B0b6hjXvIOvV/v36gMSAs2wx
         trFBXYRYmsOI/4zVhbHqsP1eg/nkJbJYGRAXdjJ9BQTdJYrMDOQYMb8YpiZm6dpAvaCB
         qfIxj+jm2eNVVVKjva4b6sqn+GEyS/P5QLgZUa1mI/5adtYF4gbHhjT9o/0yizTvP3Sj
         ukiWgBtk+sa8sVXhnzK9R6DsZy65uzV46CrEso23jPIpG3MtP6JBrZHdyGTfM6zHcLoQ
         JE0A==
X-Forwarded-Encrypted: i=1; AJvYcCUItyURL7fwRZ3Owyysj7qlDWjGlXZaHa3Y6Luh2z+3uS53bLWs07Ahjzb/IraHyw7vpTK3qqpY@vger.kernel.org, AJvYcCVEOYR0a1PFdnuE8ONoSBI4w+UY++890bcfmkgx3cR6OZth8MRqFIsPjmrXH5FyRmPnXZsHoWbp4TrJ0g==@vger.kernel.org, AJvYcCWKwPmp202ypU9L/MF8gLBUUBUtWwQoeFraB7eUr5uAef8QBQEuHy9K60DLj0NZIaWQRXFXnBis/PzvyIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqJUpgqd2AWBgwqDanN+XFTcdTWXQbzSVvJuCM3c13LgymBj6
	vZvJPO0JWOmVojhhJdSt1qwvxv0us3cOKcH+9SibXB7io1i2EciBcAwZ39/Ks9/thyG87GGmnHx
	Dz3xzvUjuxAdhmkBATSwBdzIRTgQ=
X-Google-Smtp-Source: AGHT+IEGf/G0Ntyslg+t/s+p/we/+l+3tHTvQRCfbZyT/j0KTRayQqhKr3nGyYuyxVFPxvlejddMSabIZVWW9BWZaQA=
X-Received: by 2002:a05:6e02:1609:b0:3a4:e62b:4dfd with SMTP id
 e9e14a558f8ab-3a5e2458517mr5621355ab.7.1730224385824; Tue, 29 Oct 2024
 10:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000044832c06209859bd@google.com> <672024e1.050a0220.11b624.04b7.GAE@google.com>
In-Reply-To: <672024e1.050a0220.11b624.04b7.GAE@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 29 Oct 2024 13:52:54 -0400
Message-ID: <CADvbK_fgw2YeaQdJs-69kOnrcQ4JoZHYgDxDSGzmfa-sehZBRA@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_sf_ootb
To: syzbot <syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:57=E2=80=AFPM syzbot
<syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    819837584309 Linux 6.12-rc5
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1211e94058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d4311df74eee=
96f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df0cbb34d39392f2=
746ca
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11eb3230580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11f36ca798000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/dfa054090a8f/dis=
k-81983758.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/54edfdbd151e/vmlinu=
x-81983758.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d63a317b80f9/b=
zImage-81983758.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com
>
> syz-executor341 uses obsolete (PF_INET,SOCK_PACKET)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefun=
s.c:3712
>  sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
>  sctp_do_sm+0x181/0x93d0 net/sctp/sm_sideeffect.c:1166
>  sctp_endpoint_bh_rcv+0xc38/0xf90 net/sctp/endpointola.c:407
>  sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
>  sctp_rcv+0x3831/0x3b20 net/sctp/input.c:243
>  sctp4_rcv+0x42/0x50 net/sctp/protocol.c:1159
>  ip_protocol_deliver_rcu+0xb51/0x13d0 net/ipv4/ip_input.c:205
>  ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
>  dst_input include/net/dst.h:460 [inline]
>  ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:449
>  NF_HOOK include/linux/netfilter.h:314 [inline]
>  ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:569
>  __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
>  __netif_receive_skb+0x319/0xa00 net/core/dev.c:5779
>  netif_receive_skb_internal net/core/dev.c:5865 [inline]
>  netif_receive_skb+0x58/0x660 net/core/dev.c:5924
>  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1550
>  tun_get_user+0x5783/0x6c60 drivers/net/tun.c:2007
>  tun_chr_write_iter+0x3ac/0x5d0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0xb2b/0x1540 fs/read_write.c:683
>  ksys_write+0x24f/0x4c0 fs/read_write.c:736
>  __do_sys_write fs/read_write.c:748 [inline]
>  __se_sys_write fs/read_write.c:745 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:745
>  x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4091 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
>  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
>  alloc_skb include/linux/skbuff.h:1322 [inline]
>  alloc_skb_with_frags+0xc8/0xd00 net/core/skbuff.c:6612
>  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2883
>  tun_alloc_skb drivers/net/tun.c:1526 [inline]
>  tun_get_user+0x20f4/0x6c60 drivers/net/tun.c:1851
>  tun_chr_write_iter+0x3ac/0x5d0 drivers/net/tun.c:2053
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0xb2b/0x1540 fs/read_write.c:683
>  ksys_write+0x24f/0x4c0 fs/read_write.c:736
>  __do_sys_write fs/read_write.c:748 [inline]
>  __se_sys_write fs/read_write.c:745 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:745
>  x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 UID: 0 PID: 5818 Comm: syz-executor341 Not tainted 6.12.0-rc5-syzk=
aller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
Sorry for forgetting the proposed fix. Here is the one I just posted.

https://lore.kernel.org/netdev/a29ebb6d8b9f8affd0f9abb296faafafe10c17d8.173=
0223981.git.lucien.xin@gmail.com/T/#u

