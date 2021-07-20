Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1416D3D03E9
	for <lists+linux-sctp@lfdr.de>; Tue, 20 Jul 2021 23:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGTUwd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 20 Jul 2021 16:52:33 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:34549 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhGTUwc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 20 Jul 2021 16:52:32 -0400
Received: by mail-il1-f200.google.com with SMTP id w2-20020a056e0213e2b029020f555eb3c6so349632ilj.1
        for <linux-sctp@vger.kernel.org>; Tue, 20 Jul 2021 14:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3twmQjVLKZYLJpKK4SKvwqowp6QBKj+Dr4lo3yFdzNA=;
        b=csUbRCavln+JJhg7OZa2ciSugA4fXHUa1RtaC+JzkhDMNdCj8GyxxFdIPJYgUYTTfw
         tmNNSTHAGwyUyA7fAIVPupGXHYPwqSREgvt2VIMaUskxTjYBnuBBQ1S9Cqzg2tuQmfpN
         J1a/2e32HdNDyp/6p/9MtvWAPUxzS5MAcKjkIOhhZPmUIVWDu3EZGNNwR9+OZl6SQeNJ
         ePruXksWzJtwg8II3TizgHlap712/0Uz2i3ihkZQmFZgJdEU4zUaKjDz40xNuhP63x+p
         DHiNFO/Ubgc6Ek63YjCatCquKGABmxXF3TX0E/IA3P3fqpbXlilIzFDOTO3jYrzr8+nD
         jI0w==
X-Gm-Message-State: AOAM5304OamfSotK5fuYi55opEBL+J+Thf73b1BYHnma+aV86+iY58JH
        pU5utTa+EMmyvDWpdYnFCf28qLpVUmoiHVklR0MIN20xVf78
X-Google-Smtp-Source: ABdhPJwTGv8EA0EAXmAbxt7FCbB05Tx4rEaJhZhVK23G4D38hwxDrO7tuJHibuW4OAJb7XFSwHPExGTlUY8xeNWFF45fpyVojlM+
MIME-Version: 1.0
X-Received: by 2002:a92:507:: with SMTP id q7mr17867804ile.81.1626816790235;
 Tue, 20 Jul 2021 14:33:10 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:33:10 -0700
In-Reply-To: <000000000000a0982305c6e5c9f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e58f5705c794cc1b@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in sctp_auth_shkey_hold
From:   syzbot <syzbot+b774577370208727d12b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hdanton@sina.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        lucien.xin@gmail.com, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

syzbot has bisected this issue to:

commit 56dd525abd56f7acd7b44a52935726e3ada4916c
Author: Xin Long <lucien.xin@gmail.com>
Date:   Mon Aug 19 14:02:49 2019 +0000

    sctp: add SCTP_AUTH_SUPPORTED sockopt

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162bdf22300000
start commit:   6f20c8adb181 net/tcp_fastopen: fix data races around tfo_a..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=152bdf22300000
console output: https://syzkaller.appspot.com/x/log.txt?x=112bdf22300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6da37c7627210105
dashboard link: https://syzkaller.appspot.com/bug?extid=b774577370208727d12b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d37b4a300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114bd0ea300000

Reported-by: syzbot+b774577370208727d12b@syzkaller.appspotmail.com
Fixes: 56dd525abd56 ("sctp: add SCTP_AUTH_SUPPORTED sockopt")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
