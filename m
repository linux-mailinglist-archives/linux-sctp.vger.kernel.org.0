Return-Path: <linux-sctp+bounces-220-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15795F67B
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402A91F25459
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFE1957FC;
	Mon, 26 Aug 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA/XpniJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093701957E2;
	Mon, 26 Aug 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689490; cv=none; b=HaxuOwrP+rBq5vb2WGPCyTGq3rpwDWswGmdU5bz13IiN7nId7mKt4n/6N49jPNn5IgNLIC1DLrKoG0FXspbgpw2drT56m1HF+AC71GV0mG0xSDTraXy1stVtLwMMnu0tLkj8cv6KB6CwojDc70d7AVuBgDQBcMA56kz/C4lDYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689490; c=relaxed/simple;
	bh=QT6Du/3VIcwYOfo4b6uM70akCGjVYihZamh0JczG1mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC6kYusBmYxb/IaQPSmby62jnS4lTQ75v5DM1yrG5T9RtrWMXJGZS5jrpEBk5E7msgqDUbl012C31fGxlpCRx9fPyV/nurH1btcuFQJl95mcuT2BQvBqAF8987d1M1N6PYY88cMJd9AQbxVqPLvUU88NiRpkRjJh2dNxSAXA37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA/XpniJ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d311d8091so19035625ab.3;
        Mon, 26 Aug 2024 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724689488; x=1725294288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG+uOPG9GlWGrQItB6Aw5fIBX1uYB1rriS7aFcacuVs=;
        b=LA/XpniJwBkEXM5VQGajfTL+68fUphXXGvphp1Qk7tKbrM9HZheyC+CTAPBAuahySk
         GJ9P82Jips5fgPJ8qm3rek+IGkscHb1orvEgaQYY6WyIZ/P5tF93vEPPr9hNq9orNyTE
         WsOe7sRDiPYAPX0qVht09RqmgAyLo0v2nAPVUCtx5rFessZkOECd2AlXpUp2aWxQ4Ta6
         UOO5d6ZlaAunrXz9UeW5rB0nhY8IrZCeE27+h93skCuaZQ5sLQ6vanObI7p8tqEJAlp3
         0NrMLw6EAcJSut9im6SIDBHZaG792UmYwzQ5aPSP3fQCR2hGs6eM6Oz6vTTkKi++FY7Q
         TOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724689488; x=1725294288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG+uOPG9GlWGrQItB6Aw5fIBX1uYB1rriS7aFcacuVs=;
        b=mvopcRmTsThjRoWKF03V8/f7gY/wRPZODuSRH9nNnz+TSVielIVvJzVF9SMj9MVuRS
         smMOT+P3VfwWghqikfenj9NAXrjrE8KCv39wpTMxU2Rpa4d49eGGrEiNoLiVtVclicde
         d0WVQ4i7PGgkTnG+0RQ8H51Lxo3e+iQDdCRBfVy6V3XANw/S33kPvpbkBqWsuiXyUpye
         MiBKGZEupy4f1+3xF6U/XXDJvDqsZcvA0AiOuCeE6hROYigMnVq3whFQ5OSiq0IWYqh0
         Spbxu4m+Qr4yuHS2+DdDbkTwuNowKrMLwp4phheHOvJwTAqKVE2vInygjPMv1Y12Pp7t
         kagw==
X-Forwarded-Encrypted: i=1; AJvYcCVCu4dOJ/6BR8lVReOtiE5xNi8qJYSf4eqQSzYFR7zIbF5c6nT0mSPHB+gVA7Ci/KbeRk2JmOkvXKCpcYA=@vger.kernel.org, AJvYcCVH8lmPCkrIt5ysOzxc5g1wAfZMi4LWEKUIe4+QAjJUn9ZF3NV8ynvY0qvsXRzk3iRHSxJpu1ng3HV+zg==@vger.kernel.org, AJvYcCXNH9/Hji/q02FxefcHDYVTh8Wo1eu/RCJboqgyJB3GjxRdhGlR6d4/zI8Ci5TQovf8mlZjVM64@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQtHlylwFJzNkiERzXuYR6FXdHJxcdfjn/sY5UxOyLdoKlQ++
	2kkQA7k+rBbD2ryDIAU4W59Z+J9l8Ymefj9RrSEKr8I/RJwso6ml092NXZp6k1zM//2vXAGLesi
	iGz3I4zmyTXO8GfHT9jnq9pOZopQ=
X-Google-Smtp-Source: AGHT+IFD/I1doeGA/s9YIxhImbIT5SG7qNJzbRRVL6Wz8AlHXbYWrDz1Q3Dc1pto2rgb623eIVc6e/0ycxACqCy2El8=
X-Received: by 2002:a05:6e02:1808:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-39e63e807c0mr2717785ab.12.1724689487928; Mon, 26 Aug 2024
 09:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000044832c06209859bd@google.com>
In-Reply-To: <00000000000044832c06209859bd@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 26 Aug 2024 12:24:35 -0400
Message-ID: <CADvbK_fopx-d-3N9B84C58D+Z_eSiAyeedMH+31SMJXqHNJzfg@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_sf_ootb
To: syzbot <syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:09=E2=80=AFPM syzbot
<syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git=
:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15e9b7f598000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D62f882de89667=
5a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df0cbb34d39392f2=
746ca
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/17f6ee87834d/dis=
k-d2bafcf2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7783769858d1/vmlinu=
x-d2bafcf2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/45248109d188/b=
zImage-d2bafcf2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+f0cbb34d39392f2746ca@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefun=
s.c:3702
it seems we need a similar fix in sctp_sf_ootb() as:

commit 50619dbf8db77e98d821d615af4f634d08e22698
Author: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date:   Mon Jun 28 16:13:42 2021 -0300

    sctp: add size validation when walking chunks


diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..71b9feaf36bc 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3741,7 +3741,7 @@ enum sctp_disposition sctp_sf_ootb(struct net *net,
                }

                ch =3D (struct sctp_chunkhdr *)ch_end;
-       } while (ch_end < skb_tail_pointer(skb));
+       } while (ch_end + sizeof(*ch) < skb_tail_pointer(skb));

        if (ootb_shut_ack)
                return sctp_sf_shut_8_4_5(net, ep, asoc, type, arg, command=
s);

