Return-Path: <linux-sctp+bounces-761-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C7CA5A70
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Dec 2025 23:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EADEE30AE08F
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Dec 2025 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214462C11FE;
	Thu,  4 Dec 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FquaNi+T"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A111EFFB4
	for <linux-sctp@vger.kernel.org>; Thu,  4 Dec 2025 22:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764888821; cv=none; b=XwLazvHoibtq3RiQObeGdpy8FksRErLm/fEh+wF0IZ42969LZ9AtmgqodPtwJ3R5qwvxMHCLm04qy0yWVXs9IhTJa1mE7YMGr0KjH7irfYyz9A06ZFkgqhfwgEBSRdw+G5Wzx/Tr9DZzaCQYj0V6h4MF6MBBiT1B+dtBcq7TEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764888821; c=relaxed/simple;
	bh=ov/f8b8oypFf0TX9IG1Hds3sjboOgsbSiIZLkTlT/ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYWPjsMZOGEdSvsw2ZHzgeLaMj5Cvf6p7Ad4axXixLMTn5QtuH7fnfBKTm3sO1IudYzeRUJ1t9vcTTz/D5yhKXCVW1U94A8pADSpP2e/m1boBad0mGB3UlBbiBZWP888HXbhh434vEBsdYmJAZIf7mPgFRHcKNnbHKWBDoO+Er0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FquaNi+T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1502191b3a.1
        for <linux-sctp@vger.kernel.org>; Thu, 04 Dec 2025 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764888820; x=1765493620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAAnq58Gza2HWLmbJ/nZdDyBYDgBI3oQQQBansr3zS0=;
        b=FquaNi+TOX/xyt57HPu4Ifcg/jjI/RCHygU4t/kE1T2Ijcta6Qer/cN/ghnQGPAnt/
         hp7oPZEtcS6iUMs6XQZFuGMuAwsirFN8YZ1/0nVoiBrKh5UfLY0m6SmH0wChHO9Ot/aG
         ROZ4MkEXoyA63t/pmZWo+HYrgxQ9FRBCJQFL4nrdgESxHdyAyvJBmroc9dNWcf2BqnU+
         II0CSgWUEUlNB9qzpjo28BdSMJgvb0mrns8Yh8c9huDw0eW4dlXtv6giTZd3tQLoTCZV
         AftqdVWEQU7OyiHYjo8GkkQ0p30+aJPzZqqfw/v0dfW3cD8fr4Nj2Ch+qKQu5qhBh3gt
         D3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764888820; x=1765493620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cAAnq58Gza2HWLmbJ/nZdDyBYDgBI3oQQQBansr3zS0=;
        b=eUkyOFa7OCpUo7ZMko/KY/ozvTgFmubqyI8mvo+GzuwjonLn6sfqhMXGYdxnJzuwiD
         OaO0HGC3qeBEhgZVmh+LcdMiwYZ0gdkI7DzeevepuXjdAHak33EDVHUY4ahaTgxpsADi
         9dd9ILroJ29j4E3jSHbvgcpt6yhucGr/jJ/+nxzZN/g4VfVDF0IXbXQJe+oUO6pytRlJ
         bac5fG8nPlzw9uTKgJPTmgEeshFXenFJMtELENDoFv6B82ICjBeA43tu92ymvrvJSCp7
         LVAbUX2KvJeDrYvjNRu70UWshAqj1z+RIKelpB4ZKGZFWog9S9GiE9EYk5E/PWgw6BG9
         96/w==
X-Forwarded-Encrypted: i=1; AJvYcCW4853eVUNKtj7Tavnj9jvd+pP6KGIWeuui/tXuQA+pKYPWL5YRKCvV543zgjX/p+3cn9eitVZprehw@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvGSYuSqJDYYc+GB/uWW9qE7/qtjPYUtA4VYRgVY6DuuBIsg2
	gsozJKMFx7Nd49+U5/tkogneKkLZBhItRZAu97vx1nyxlLbecDAxe9NAlKJG+euGAK958Z/6EKH
	TWqZvuOW8XNwKY4qinIBIcNqa4Whqlq0=
X-Gm-Gg: ASbGncsUD4k+9IKRMsay8hBm1BZBdShvn3pVIPsYtmd/uB12BuXDakQ215pcch2b+wU
	FmGpe51sJFvcn5bmCGxTh0qIdmHfflR+bxys5VD90bH9in1obNVSGCDFqIy5xnm91uAZAJOqHIQ
	mQJbMiuaBacL7iMQoia4Q4pKLMBQPJ3XNsUTsNPrBnHanlpmp8aQROVs4ZXWgb5wA8mZvfOiT9N
	dzdXYj0poeDLB2Z8C934GMPdcUlj4yLSDwuTGZJhY/mQTjKW/9fL5mpWMzJGAgpX/FQ1HI=
X-Google-Smtp-Source: AGHT+IH68USfKg6PdpKuZn5qcBnhiQkshiVglbFjOwHfNj5mkWNcRLzrnUcAyN0dhhkRTtQZbJEIxFAiH8r6hxDSz4s=
X-Received: by 2002:a05:6a21:6d95:b0:340:cc06:94ee with SMTP id
 adf61e73a8af0-363f5ec2c70mr8923809637.60.1764888819551; Thu, 04 Dec 2025
 14:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com> <692e11fe.a70a0220.d98e3.018e.GAE@google.com>
In-Reply-To: <692e11fe.a70a0220.d98e3.018e.GAE@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 4 Dec 2025 17:53:27 -0500
X-Gm-Features: AWmQ_bkxm6uv8D6Xxa9zdzZ3DbkIJY7wBMEBfT35SAYtgzVLqH3usiQOQ8lnV_E
Message-ID: <CADvbK_ewub4ZZK-tZg8GBQbDFHWhd9a48C+AFXZ93pMsssCrUg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
To: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, mjguzik@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:09=E2=80=AFPM syzbot
<syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 457528eb27c3a3053181939ca65998477cc39c49
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Sun Nov 23 16:33:47 2025 +0000
>
>     net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1136a51258=
0000
> start commit:   7d31f578f323 Add linux-next specific files for 20251128
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1336a51258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1536a51258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6336d8e94a7c5=
17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D984a5c208d87765=
b2ee7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16a2322c580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12a3c51258000=
0
>
> Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com
> Fixes: 457528eb27c3 ("net/sctp: convert sctp_getsockopt_peeloff_common() =
to FD_PREPARE()")
This commit seems to no longer exist.

But I triggered a similar call trace with FAULT_INJECTION on net-next.git:

 [] FAULT_INJECTION: forcing a failure.
 [] Call Trace:
 []  <TASK>
 []  dump_stack_lvl+0x180/0x1b0
 []  should_fail_ex+0x520/0x650
 []  should_failslab+0xc2/0x120
 []  kmem_cache_alloc_lru_noprof+0x7a/0x780
 []  d_alloc_pseudo+0x1d/0xc0
 []  alloc_file_pseudo+0xbe/0x220
 []  sock_alloc_file+0x53/0x220
 []  __sys_socket+0x1be/0x320
 [] VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR)
encountered for inode ffff888054f9a900
 [] ------------[ cut here ]------------
 [] kernel BUG at fs/inode.c:1971!
 [] Call Trace:
 []  <TASK>
 []  iput+0x35/0x40
 []  __sock_release+0x20b/0x270
 []  __sys_socket+0x276/0x320
 []  __x64_sys_socket+0x72/0xb0

which was caused by:

commit 245f0d1c622b0183ce4f44b3e39aeacf78fae594
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Nov 23 17:33:48 2025 +0100

    net/socket: convert sock_map_fd() to FD_ADD()

static int sock_map_fd(struct socket *sock, int flags)
{
        int fd;

        fd =3D FD_ADD(flags, sock_alloc_file(sock, flags, NULL));
        if (fd < 0)
                sock_release(sock);
        return fd;
}

The allocation failure in sock_alloc_file() will call sock_release(),
and it should not be called again in sock_map_fd().

It could be fixed by:

diff --git a/net/socket.c b/net/socket.c
index 809ef372727b..0c2b03cec83d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -503,12 +503,13 @@ EXPORT_SYMBOL(sock_alloc_file);

 static int sock_map_fd(struct socket *sock, int flags)
 {
-       int fd;
+       struct file *file;

-       fd =3D FD_ADD(flags, sock_alloc_file(sock, flags, NULL));
-       if (fd < 0)
-               sock_release(sock);
-       return fd;
+       file =3D sock_alloc_file(sock, flags, NULL);
+       if (IS_ERR(file))
+               return PTR_ERR(file);
+
+       return FD_ADD(flags, file);
 }

