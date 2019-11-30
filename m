Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29F010DE26
	for <lists+linux-sctp@lfdr.de>; Sat, 30 Nov 2019 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfK3PiK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 30 Nov 2019 10:38:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36161 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfK3PiK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 30 Nov 2019 10:38:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id v19so8687870qkv.3
        for <linux-sctp@vger.kernel.org>; Sat, 30 Nov 2019 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWJ16jxU4+iwSnWuytlpM5skSBZCFvJ07mOrWCdI8wc=;
        b=Z0do+C6MX4UQUlXCJKKERLJS6qUjfvq9gStNXTZVBtJmE44YwC6lBYp1wp7nj4VVAF
         h8Sr6i5gBvJ95H9Pier1R1Eqwkms5h8b40JjnLAJ2EJfmkch3gE/BfruftJym/5Ewqcv
         v/bo5Hn7+WBUwHQHqmGModZzg/lEQLFnv/AH8aY6vKjQdZNmfCv1leg0jH/n9uuyEcTy
         HQNGkvg+C1ZV1nEt0gMq7mc9J8VC4PQRWI57hoZsmf8e6Dvjy0Wzb0MBGqoexGuNL7io
         39yg03NEPzERgNel4dOZvjz7I6irnsrA8hmpElXkXWe4oNks/sQypLZPYIta1B5liIsF
         /hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWJ16jxU4+iwSnWuytlpM5skSBZCFvJ07mOrWCdI8wc=;
        b=ZRMczPtuksL07ic//8z2ILRryFZB7UvK03KUhXWwV3YpVLlkitdOaqGOHpCaRLnzom
         p2SWDQsyhBrqcO+qzCbPJbS7297cLwN2hcwJ0K2E9grKlgvpX8JLDaYTRgF/L12zRSMO
         LShr89HphErF/vgggL0wOWE7WqGd55L3+xDa8scqTPLGt6urI5ca3QDZNUymQ9bhltD8
         bZ4wLGdbl3RGweUrblc/HYdwstw7VLoLaGgwBPYaNpglA5Vw5YejebNAHPsa++fk74Aw
         91Ad8LAkEWGoR93wdB3MoQkms55bvdy9ta9C2DxRImPuJXp6dtn1RcSnkcVLio1lMH/a
         CKvg==
X-Gm-Message-State: APjAAAVr3VSEPvatWpANawgS9REGg7WcCvbq8DmSlFxIdZbQ4IIR0yBC
        7F7aI8Rx/X8xlzh7QauiCusxFEP4SRSO5Z3K6BGUZg9BZrU=
X-Google-Smtp-Source: APXvYqyEw2xrZSw3JJwFJXLe27gK/0Ir6IeNXiYibz7PYq6PHaf/95WNzEkN7e7PnCW0Db8qMicOZezd1ddMCtfYpBY=
X-Received: by 2002:a37:bdc3:: with SMTP id n186mr6568797qkf.407.1575128287383;
 Sat, 30 Nov 2019 07:38:07 -0800 (PST)
MIME-Version: 1.0
References: <001a114372a6074e6505642b7f72@google.com> <000000000000039751059891760e@google.com>
In-Reply-To: <000000000000039751059891760e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 30 Nov 2019 16:37:56 +0100
Message-ID: <CACT4Y+Yrg8JxWABi4CJgBG7GpBSCmT0DHr_eZhQA-ikLH-X5Yw@mail.gmail.com>
Subject: Re: kernel BUG at net/core/skbuff.c:LINE! (3)
To:     syzbot <syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>, mvohra@vmware.com,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        William Tu <u9012063@gmail.com>,
        Vladislav Yasevich <vyasevich@gmail.com>,
        websitedesignservices4u@gmail.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Nov 30, 2019 at 3:50 PM syzbot
<syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 84e54fe0a5eaed696dee4019c396f8396f5a908b
> Author: William Tu <u9012063@gmail.com>
> Date:   Tue Aug 22 16:40:28 2017 +0000
>
>      gre: introduce native tunnel support for ERSPAN
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158a2f86e00000
> start commit:   f9f1e414 Merge tag 'for-linus-4.16-rc1-tag' of git://git.k..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=178a2f86e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=138a2f86e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=34a80ee1ac29767b
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2bf2652983d23734c5c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147bfebd800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d8d543800000
>
> Reported-by: syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Humm... the repro contains syz_emit_ethernet, wonder if it's
remote-triggerable...
