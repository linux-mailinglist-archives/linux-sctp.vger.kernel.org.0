Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA818598A
	for <lists+linux-sctp@lfdr.de>; Sun, 15 Mar 2020 04:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCODDD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 14 Mar 2020 23:03:03 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200]:33837 "EHLO
        mail-pg1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgCODDC (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 14 Mar 2020 23:03:02 -0400
Received: by mail-pg1-f200.google.com with SMTP id 12so9285258pgv.1
        for <linux-sctp@vger.kernel.org>; Sat, 14 Mar 2020 20:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/CZuM0+mbO6NyqR+mLDX0oKlbyLZj3NtZHFhJDcGVng=;
        b=KQc8V3BIIYIhCaj6acvAaFznw9j2dKnfMeRhDUcTSeiQjoq7NpNW0FEhLe/aGu7ogh
         2tEShGrjl4x8T3C3RbUe7ee1oClh/1lfBfUBKyquI5EUYMFmOmUN0vElNVYjPYw21umD
         oXtYBQjUuXmRBGvqk/vF/u1FGUA26QyYltuismy9X1cxjV1+OW8TAUZroJzfPRd3LO+6
         JirCKuHqnGmxPc0CvhgT8wIVDVm2snmucUHxT6wd1l85Tq7HufKbAldsS3W4LdBUuIjl
         GH2ocFMWC464fuJEJ4rrZ0o/DZGGHnz6ipwUkHS3UAwrSXuFOZN+pW96SwILrrSt3AmL
         wHmQ==
X-Gm-Message-State: ANhLgQ3i2Ee7X/5oIRZ4cXY7nOd6t0fuG3VgS/BHprHiSBLTvfBYOasr
        5tKRMLD7Z8/ShhulRnZt/f6PfbN81pJvcMvqmcPEpvpd5qti
X-Google-Smtp-Source: ADFU+vsd7B6zM7k661+N9RLASlT7wDY115i+NOnn4ChlOdfINGGNLgluD9/L+k0eJ+9HakWUkF332HYt3wzwxnDAhQKyCHW7keRq
MIME-Version: 1.0
X-Received: by 2002:a92:79cf:: with SMTP id u198mr2189717ilc.23.1584158642104;
 Fri, 13 Mar 2020 21:04:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:04:02 -0700
In-Reply-To: <CADG63jCSHu7dQ118GEuhXBi0H4CW3cBqB5F2qKiyeVzNb0U+wg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021721505a0c8ad76@google.com>
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

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo https://github.com/hqj/hqjagain_test.git/scup_wfree: failed to run ["git" "fetch" "https://github.com/hqj/hqjagain_test.git" "scup_wfree"]: exit status 128
fatal: couldn't find remote ref scup_wfree



Tested on:

commit:         [unknown 
git tree:       https://github.com/hqj/hqjagain_test.git scup_wfree
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

