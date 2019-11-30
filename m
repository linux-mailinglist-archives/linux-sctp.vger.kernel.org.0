Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE010DDE1
	for <lists+linux-sctp@lfdr.de>; Sat, 30 Nov 2019 15:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfK3OuC (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 30 Nov 2019 09:50:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36683 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfK3OuB (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 30 Nov 2019 09:50:01 -0500
Received: by mail-io1-f69.google.com with SMTP id 202so10037444iou.3
        for <linux-sctp@vger.kernel.org>; Sat, 30 Nov 2019 06:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jII87kLhfoGRXBIl4TNhBeD/bYyBWSNWa+TtrCAMKnM=;
        b=O/H+4uZO1+U5N8ENAzHQCkg1DzrFarBjkcZaVB6gZuoLV5GX1NItpmTsK+vgq/HCEn
         mam+FZuBfM+UNRHV0H+ehWkJlDotnGF3EIX0Vz5I3GV07/k1hVdLinh0+3vFHPuKcDQ4
         v0r5YjuVQCPgU11y4qCW6EFsgtDvgbEePDBMCdeGVguEUufvVWcNyjeh30yCz/bvTnE/
         7Hytq/UJxdSHvgA1MNdPT8d4/ans9kGCFjrAuX3jWOaasjYWzu+G1bIEAgwjmXYkJOv2
         YceYbK3mxe8CylvwULjjrNZg1Y6g1jsS5OCNv/HrwfOiCyfR5bMrIAGRgQQdrTPlme1b
         Pkww==
X-Gm-Message-State: APjAAAWXMNBY4IbxfowRK/+dj8uq0RQ78yteFXWzS0T7DBdYqTvKo5r4
        3VLyElxDc3N0fnZEt7F31z0DE59/r6djKxF7BlHM87jmOQeD
X-Google-Smtp-Source: APXvYqzUupElDR1SDA77br+UIp2Mr5RrWPkK2noS9cYjk6kGU0lH4u9b3aZAbIjVILLbVLabmwApKQam8lGumAvU4U75q4v173bg
MIME-Version: 1.0
X-Received: by 2002:a92:5bdd:: with SMTP id c90mr2923790ilg.78.1575125401177;
 Sat, 30 Nov 2019 06:50:01 -0800 (PST)
Date:   Sat, 30 Nov 2019 06:50:01 -0800
In-Reply-To: <001a114372a6074e6505642b7f72@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000039751059891760e@google.com>
Subject: Re: kernel BUG at net/core/skbuff.c:LINE! (3)
From:   syzbot <syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        lucien.xin@gmail.com, mvohra@vmware.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        u9012063@gmail.com, vyasevich@gmail.com,
        websitedesignservices4u@gmail.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

syzbot has bisected this bug to:

commit 84e54fe0a5eaed696dee4019c396f8396f5a908b
Author: William Tu <u9012063@gmail.com>
Date:   Tue Aug 22 16:40:28 2017 +0000

     gre: introduce native tunnel support for ERSPAN

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158a2f86e00000
start commit:   f9f1e414 Merge tag 'for-linus-4.16-rc1-tag' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=178a2f86e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=138a2f86e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34a80ee1ac29767b
dashboard link: https://syzkaller.appspot.com/bug?extid=b2bf2652983d23734c5c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147bfebd800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d8d543800000

Reported-by: syzbot+b2bf2652983d23734c5c@syzkaller.appspotmail.com
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
