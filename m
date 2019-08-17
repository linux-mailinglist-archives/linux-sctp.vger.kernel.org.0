Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE64911A2
	for <lists+linux-sctp@lfdr.de>; Sat, 17 Aug 2019 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfHQP2B (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 17 Aug 2019 11:28:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34904 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfHQP2B (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 17 Aug 2019 11:28:01 -0400
Received: by mail-io1-f70.google.com with SMTP id p2so6737938iod.2
        for <linux-sctp@vger.kernel.org>; Sat, 17 Aug 2019 08:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qXE76hfKHYN2qVI6DJHVNV4EHRnZduBHUK4jM6XkuBk=;
        b=TLQp/Ccldtg9rs/qHI8HFseSWKTmxjul3uTPovXORf1g3XmTPU+DeN/S+X+hH8GDiy
         QRq0tB/t51+I2O9zg0+mteuxOsgyAd3OQTf0HWAKcZs94GENOkY67tHzdONdENHZuNqs
         PN8fRaMMTaz3HO+a5CpoZ97I2HGDKVVkfjvI7M1+3DMPT7LzNIDEXJg7q/8iwhpvj+EU
         tZY5+gGvxE7AqT5LFl/RVb83JP7XrHqd3qd65TUNdmYBn1an5nB4tQnQH5tQhi90PO1N
         URgqtjkVE7z31zbLBsfdL1DrM/vZbLKzcZFGSImwS8UPw1SL5t/hmOZUAB9FO7U8KAGk
         7qEQ==
X-Gm-Message-State: APjAAAW2sWb6KBUeAmh2W+8EGI862woQ1QQasF0M+UlBFStjlvw1zw14
        ooS1dDQYaFmlo/Lh4B5A24Pz7BOgv8/Gdqh8+Xme4hw7AWSH
X-Google-Smtp-Source: APXvYqy32T19mCY7ScSzCH1AG2iuA/7tu57F30CzrxJU8e3Sn3tTW2DL/KSoBpfG8OZDLLKbeWQvoE0KFNbqI5MpLRsdLPIx4Cxm
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2193:: with SMTP id b19mr11372341iob.113.1566055680310;
 Sat, 17 Aug 2019 08:28:00 -0700 (PDT)
Date:   Sat, 17 Aug 2019 08:28:00 -0700
In-Reply-To: <0000000000008182a50590404a02@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000860647059051c0b8@google.com>
Subject: Re: kernel BUG at include/linux/skbuff.h:LINE! (2)
From:   syzbot <syzbot+eb349eeee854e389c36d@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        edumazet@google.com, f.fainelli@gmail.com, idosch@mellanox.com,
        kimbrownkd@gmail.com, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vyasevich@gmail.com, wanghai26@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

syzbot has bisected this bug to:

commit bc389fd101e57b36aacfaec2df8fe479eabb44ea
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Jul 2 21:12:30 2019 +0000

     Merge branch 'macsec-fix-some-bugs-in-the-receive-path'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125c5c4c600000
start commit:   459c5fb4 Merge branch 'mscc-PTP-support'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=115c5c4c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=165c5c4c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4cf1ffb87d590d7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb349eeee854e389c36d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111849e2600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1442c25a600000

Reported-by: syzbot+eb349eeee854e389c36d@syzkaller.appspotmail.com
Fixes: bc389fd101e5 ("Merge  
branch 'macsec-fix-some-bugs-in-the-receive-path'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
