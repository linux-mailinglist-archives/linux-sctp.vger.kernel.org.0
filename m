Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0925B18E66C
	for <lists+linux-sctp@lfdr.de>; Sun, 22 Mar 2020 05:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgCVEqO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 22 Mar 2020 00:46:14 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48308 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCVEqN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 22 Mar 2020 00:46:13 -0400
Received: by mail-il1-f199.google.com with SMTP id h26so1742942ilf.15
        for <linux-sctp@vger.kernel.org>; Sat, 21 Mar 2020 21:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GI4GkIJkW1bKRzFiBtT/34jbKoBVKx5WZcrXpE1yJ60=;
        b=RwR3GsEJH1TiqoGBxYjjypjiJLtwSyx8VqGOQzHsPnpDHKyUiDs6rACjXTg49alpTI
         r6hShLKsgxGTSIaDQ/PIf2k6GVd6JHsqaazm9s4fxnhcSgXbkrvNXYD6BcbnpnwQiqTT
         G7sx3iiJK13LPckdjXSq3cDiiHhZJjck+f27f6rFf/Rh/ezdMOzkgKNCSzaYW88LTPRU
         OS9LYVfPFECqGudAowHJpl11GJEYJFRkpeFM2JSQM8YMp2tsIV1yhLy4aQK9mNly2dtx
         DKyvUSn43/nVS2s92SvAWHRBDUp9+IZLF6CnsPY6j55lMIqVS/gJIopXKf8MppY5X/Kx
         UIaA==
X-Gm-Message-State: ANhLgQ03EKBeeGYQwW7Pbki9oV+tfWYTy1rmT39q8b0FUOEgcMo1U9Vg
        z6R+ebzuMpif9y0pRepn5h7O8ij2xg+57KaI149pyrL/KbZs
X-Google-Smtp-Source: ADFU+vsJt5RAxUckaqjG5zRClhUofRtFleFv8EV/BOf4ia/aNTZI5251vcnXqewrTdJPZ9LxYOHay+p6Ei7aFnsYFXYRUdY460/d
MIME-Version: 1.0
X-Received: by 2002:a92:9e99:: with SMTP id s25mr14982996ilk.306.1584851942582;
 Sat, 21 Mar 2020 21:39:02 -0700 (PDT)
Date:   Sat, 21 Mar 2020 21:39:02 -0700
In-Reply-To: <CADG63jB59ZXWSUFKieXKGGEbPT9=z5OPARBjGqMgfh+K-k4-yQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f2eea05a16a1979@google.com>
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

commit:         e76397e4 iterate datamsg list
git tree:       https://github.com/hqj/hqjagain_test.git sctp_for_each_tx_datachunk
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
