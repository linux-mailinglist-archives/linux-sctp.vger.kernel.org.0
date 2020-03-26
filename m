Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C61194A78
	for <lists+linux-sctp@lfdr.de>; Thu, 26 Mar 2020 22:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCZVZE (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 26 Mar 2020 17:25:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50103 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgCZVZE (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 26 Mar 2020 17:25:04 -0400
Received: by mail-io1-f71.google.com with SMTP id p14so6541102ios.16
        for <linux-sctp@vger.kernel.org>; Thu, 26 Mar 2020 14:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=R0UtT0wl+/DHJxOHjaoWbQcF3VR+MnxFmO8PugCJFXM=;
        b=P2LcYQT+rvIos8VNWE/IdM4E6XZQNW08isNFgn7BeA8dgA3y+pV0fYIPB9vPFvkLgI
         zrjR9Y2QSX+cMLCP0YG0jwM3uTk9TlHlHp+ng39vvCmtbz567zQFb90pj+ctsQhV7Pb7
         6lfS2d86n4liLRZFaAq/38t5houheqdT+KTGyzYyVCVktyzbGLrtZQyKbuHs6fvQ7Xok
         oxMTxulgvaJvQqgNJfl/KhE20+DjfQj3wHtdRIhGYxlE8gFW88HPhivT36CEh0gvmB9b
         Tk9PveacqYYnQXEKgeR72t9sOx8SgLNg1tOqDAdpXJNkoNM18jvPNa/cNMjd8BffTD9t
         70Nw==
X-Gm-Message-State: ANhLgQ2RX2V0b/ck1Q2Vv0nAkg6lKQPThCpz6aUxxRID2bjrA7CHNihg
        Dolp3kHzp+gEdseRYpvGG0vfQI3yM+6or8y2KKpYLrSo13he
X-Google-Smtp-Source: ADFU+vuq1ZdA15x+aWbKAF5XR3OUgPZocunA3rxU2f2eixsCPsTJVpYHE8hrML1m+H2C0/QHibYoQEO8qicie9S7k8eG7C6Y0h32
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a4:: with SMTP id z4mr9602598jap.141.1585257901712;
 Thu, 26 Mar 2020 14:25:01 -0700 (PDT)
Date:   Thu, 26 Mar 2020 14:25:01 -0700
In-Reply-To: <CADG63jDGY1dEQ9uS5Cd9q3DeEKWTff-4FC=UiEBpuh2caSLwOQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bedcf05a1c89e96@google.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
From:   syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
To:     anenbupt@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com

Tested on:

commit:         9420e8ad Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1670bfbbe00000

Note: testing is done by a robot and is best-effort only.
