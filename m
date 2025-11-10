Return-Path: <linux-sctp+bounces-740-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AACC47621
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Nov 2025 15:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3BC4E065D
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Nov 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE522652D;
	Mon, 10 Nov 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSW+G4jh"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37663054F0
	for <linux-sctp@vger.kernel.org>; Mon, 10 Nov 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786769; cv=none; b=gZHR5T394Do6+vk7wXG9wI1FaS91lhykJW1n0BbB8jZR2C0B9/g2MYMx2jCoxwukWsPsvR+9bdjHqADCfO+/BjMDx2qpUIvH5RMxXbqUxA6CU4eKMq51r06rEH2U37IH2IiQgzX5qm5P+Ze/KipiKGcwcgYfOznzyNK1vXFijpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786769; c=relaxed/simple;
	bh=f2SjiNQtWs8HwsVcS2w1H54pcIV94jqtG4/TNw7bLB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH1DBuyYQWOGovJDyBfKDW8qvIlJrXYZUff6bjobeyVhJPiMy11Wj40Hm/QZPIApSK0PVK9AxJhZhqI7Yl3CoRZfnkwQRYqm4YPzRXGYdYSaxaWzNpRYKuspmSFLl+DhUtxEUwaqK3oiAAGQQkY5+4tWF44iFaOB7W3+Iv7uzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSW+G4jh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437ca434f4so1763882a91.0
        for <linux-sctp@vger.kernel.org>; Mon, 10 Nov 2025 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786767; x=1763391567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2GRBVLY4h+3JguhQ5Ws+X9zeEGmUy2Iu5yhjxh/67g=;
        b=eSW+G4jhsX6eHNr+ia3NcpLF0rs334fYCFtYX0lXlRjHZ67Etaslqxk8tXPdTt8GeS
         DIvyU0LVv9U+ECEBIsEB6cCp4ScsoBnIzHbsmyy/VB2dmeHRs9i2IC1GnKymIK7d4Vsy
         deRf6MNBXBDFBX469qz58kc4hTx5Xw9FpbjrcMSxOSPAdnBg4kH5LsH/DPfsZqyO19dC
         +QvN2qst9eQgrlJcnU8lC8759b5pFW6nFBOQkQRZpWAxY0KOihRGNNrBH6rAZB305TO8
         gM7PG/FseJJV0+qhpsmzslNekhcU9O/57SM/WceXz81cBiosyAqi49a4SmApH9bMXfLR
         kXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786767; x=1763391567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2GRBVLY4h+3JguhQ5Ws+X9zeEGmUy2Iu5yhjxh/67g=;
        b=ci2ddn4txHlmtUpvxsvWI5x3X7RjenlgDxyc7AB+qSVjlRoKJbuncvxpAUhlz51WjW
         swo3z09s8m+djQIxFvli0oL85Qv6ekzGDdfEJUjcdlTDWKN351kSFOYRFArya2jWsL+F
         WA22iRJ5JEi61oD4TsspZPR/PfNofjpaP+16KCCV/PX+7mEKKtrZL1sgZ8iVBT6xl7gu
         VqH9qo3IL+dZ8jSU20wUO0+vEIaTnL+YExn53bu8mIOcAMd+q5Y3bYvahy/ssWapTM1/
         pRYTy/rlkCH+iHK/ALCSfWdfObcRQHNYFc11cvBU8cMix95q7lCv86NWkUwa5LX0Hehc
         uBOA==
X-Forwarded-Encrypted: i=1; AJvYcCWc6qjZjCe7MtOEwEljVZUlPReqJN/SflFAHa++V/pLb9atel5LATAd/lkjPm8/9yaDbmFMTum/17Y4@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbCz8/ktTuHoPEVtLmQX7VADXxekRXWtfzWWE3Lp1iglJFOJl
	4K5FVP9C8oBwhriOISNWAHk+YUbDWVAgmtp7kZ0WoRTe75ngSwcSMK44kmsjCW0+now9RbkXntQ
	At7lHbOXz/BHtdQ02sV659RvolcwKmko=
X-Gm-Gg: ASbGncsNKCTv4r/N7NNq6W/l1dtkK2bkZQyAoWj/Dvz4mz8N018I7EKZBjo8L8K0pYy
	cunUdsvpgS4QqANToQEaDDN53X/BUgXuh50iT91SVWEkdEKVHn6PvQsi92kdAeWZza6IVr1RzC+
	cffXE+I7ucQRo2vd4ZA9iAlhnVuH2FXZRKvwzmazutzhJCf8SibMjP8Hzcgmlkp6NJ+5jB7ePer
	J1MzFS1FaoQAdH5tFcWffQ3jBRDLkZyLoaonpGliwELBMcdM2iO2PzzstPmvZb9PVKUXzimo+LU
	CH9HC4pmxaZzNnlkgWqtE9GRKfzO
X-Google-Smtp-Source: AGHT+IE6a1Mx//0q0QLN4miRlwYbk6iW6MuNW9eGB2NxeyWnRPirHtNAnbv5df8zAvsr11aBq9dnKaxSxS4AE1kkffE=
X-Received: by 2002:a17:90b:4b0e:b0:339:a243:e96d with SMTP id
 98e67ed59e1d1-3436cd15b8bmr11337184a91.36.1762786767280; Mon, 10 Nov 2025
 06:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106223418.1455510-1-kuniyu@google.com>
In-Reply-To: <20251106223418.1455510-1-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Nov 2025 09:59:15 -0500
X-Gm-Features: AWmQ_bnmuTn-5FAnVKxiAjCcmWMDHhsnXxhybG3GWlGUGMg6g3CvG4VdjnEDR_4
Message-ID: <CADvbK_ceAqeASAGppA_sjiofaxzpM_VnJP4G5_BR02exs3tV8A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] sctp: Don't inherit do_auto_asconf in sctp_clone_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org, 
	syzbot+ba535cb417f106327741@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> syzbot reported list_del(&sp->auto_asconf_list) corruption
> in sctp_destroy_sock().
>
> The repro calls setsockopt(SCTP_AUTO_ASCONF, 1) to a SCTP
> listener, calls accept(), and close()s the child socket.
>
> setsockopt(SCTP_AUTO_ASCONF, 1) sets sp->do_auto_asconf
> to 1 and links sp->auto_asconf_list to a per-netns list.
>
> Both fields are placed after sp->pd_lobby in struct sctp_sock,
> and sctp_copy_descendant() did not copy the fields before the
> cited commit.
>
> Also, sctp_clone_sock() did not set them explicitly.
>
> In addition, sctp_auto_asconf_init() is called from
> sctp_sock_migrate(), but it initialises the fields only
> conditionally.
>
> The two fields relied on __GFP_ZERO added in sk_alloc(),
> but sk_clone() does not use it.
>
> Let's clear newsp->do_auto_asconf in sctp_clone_sock().
>
> [0]:
> list_del corruption. prev->next should be ffff8880799e9148, but was ffff8=
880799e8808. (prev=3Dffff88803347d9f8)
> kernel BUG at lib/list_debug.c:64!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6008 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:6=
2
> Code: e8 7b 26 71 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 7c ee 92 fd 49 8b 1=
7 48 c7 c7 80 0a bf 8b 48 89 de 4c 89 f9 e8 07 c6 94 fc 90 <0f> 0b 4c 89 f7=
 e8 4c 26 71 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 4d
> RSP: 0018:ffffc90003067ad8 EFLAGS: 00010246
> RAX: 000000000000006d RBX: ffff8880799e9148 RCX: b056988859ee6e00
> RDX: 0000000000000000 RSI: 0000000000000202 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffc90003067807 R09: 1ffff9200060cf00
> R10: dffffc0000000000 R11: fffff5200060cf01 R12: 1ffff1100668fb3f
> R13: dffffc0000000000 R14: ffff88803347d9f8 R15: ffff88803347d9f8
> FS:  00005555823e5500(0000) GS:ffff88812613e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000480 CR3: 00000000741ce000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __list_del_entry_valid include/linux/list.h:132 [inline]
>  __list_del_entry include/linux/list.h:223 [inline]
>  list_del include/linux/list.h:237 [inline]
>  sctp_destroy_sock+0xb4/0x370 net/sctp/socket.c:5163
>  sk_common_release+0x75/0x310 net/core/sock.c:3961
>  sctp_close+0x77e/0x900 net/sctp/socket.c:1550
>  inet_release+0x144/0x190 net/ipv4/af_inet.c:437
>  __sock_release net/socket.c:662 [inline]
>  sock_close+0xc3/0x240 net/socket.c:1455
>  __fput+0x44c/0xa70 fs/file_table.c:468
>  task_work_run+0x1d4/0x260 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
> Reported-by: syzbot+ba535cb417f106327741@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/690d2185.a70a0220.22f260.000e.GAE@=
google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/sctp/structs.h | 4 ----
>  net/sctp/socket.c          | 1 +
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
> index 5900196d65fd..affee44bd38e 100644
> --- a/include/net/sctp/structs.h
> +++ b/include/net/sctp/structs.h
> @@ -228,10 +228,6 @@ struct sctp_sock {
>
>         atomic_t pd_mode;
>
> -       /* Fields after this point will be skipped on copies, like on acc=
ept
> -        * and peeloff operations
> -        */
> -
>         /* Receive to here while partial delivery is in effect. */
>         struct sk_buff_head pd_lobby;
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 38d2932acebf..d808096f5ab1 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -4885,6 +4885,7 @@ static struct sock *sctp_clone_sock(struct sock *sk=
,
>         }
>  #endif
>
> +       newsp->do_auto_asconf =3D 0;
>         skb_queue_head_init(&newsp->pd_lobby);
>
>         newsp->ep =3D sctp_endpoint_new(newsk, GFP_KERNEL);
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

