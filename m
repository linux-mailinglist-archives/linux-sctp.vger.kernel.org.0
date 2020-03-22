Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E486118E751
	for <lists+linux-sctp@lfdr.de>; Sun, 22 Mar 2020 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgCVHSF (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 22 Mar 2020 03:18:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52714 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVHSF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 22 Mar 2020 03:18:05 -0400
Received: by mail-io1-f70.google.com with SMTP id e21so8610324ios.19
        for <linux-sctp@vger.kernel.org>; Sun, 22 Mar 2020 00:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8H+ZxvVVLEf1sn4M+jADRlnacqoZ3lSMMd7kp5U9RKI=;
        b=SSUcaYKXS7nU4z7eQemd+L6tjQAQIWzJ1jI6KihOa6dg/oV/dB8o4LP1mwVlu8tebB
         5PVl4tYV9xEwHHho5MwSW16OQ/Z7/ParaXkJKgiAP9mq6GaS4k6lxd7oE+vV4HGUp0uZ
         47cBIbTFTdDYRe10s7sHIWtTy55MhaUxzboLh+cJkZQf7mNZVrK8wRm1VKCocYtUYx3y
         Wppqt88n/gGgjOtzUj/varv6UOdaeSPRNJ3GF4fbZANSGL/yiqX6DK6502nNKU48hUUB
         2A0rKnM6HCydkBzH5mEHQL9Gq9U4DcSP82TR4tvOoxOEj7r7fO2kUyYlQi8nJ1yfoYMH
         RZRA==
X-Gm-Message-State: ANhLgQ20V6wi6TqwJfallkiHVfpMXb9lFeGB9bkea8qrW/kzw3FxPVDk
        0szfG5hWoE6PvcIwFEOVczCKyXWXNYL3LxsPFMDV+YXN2uej
X-Google-Smtp-Source: ADFU+vvIFTtvKwJU396waC62o4+9tlw5aZYfAr7eL4DgL4YwSOJjDROpLIdkgAFOw9HEhlZhSWC/8N4NpyRvDPpo0+fwEiVh790Z
MIME-Version: 1.0
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr14333976ill.68.1584861484221;
 Sun, 22 Mar 2020 00:18:04 -0700 (PDT)
Date:   Sun, 22 Mar 2020 00:18:04 -0700
In-Reply-To: <CADG63jCpZWBjtJH_rjzBjTyTfYV0z9SHf1CzT9ic0-VY5C4AiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c909b405a16c5105@google.com>
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

commit:         573a2520 datamsg_list
git tree:       https://github.com/hqj/hqjagain_test.git datamsg_list
kernel config:  https://syzkaller.appspot.com/x/.config?x=6dfa02302d6db985
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Note: testing is done by a robot and is best-effort only.
