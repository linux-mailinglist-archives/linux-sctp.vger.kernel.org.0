Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF452316
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Jun 2019 07:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfFYFtd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 25 Jun 2019 01:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbfFYFtd (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 25 Jun 2019 01:49:33 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904E520659;
        Tue, 25 Jun 2019 05:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561441771;
        bh=PxtQYvbthqhzGqE1gay6DbxHrrrWN2rLXfBSt/vGYcQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OqClgybL+3RxeFXuctICEMksXVIvqrSSOBNyUtnPDFgwmMqzRsWdl/Ka71SFGImyJ
         ycxTgI9LZqilh0iZIHZCRzg5nTtn/pvh+gQ8SiaBe17NEoI77nd7gLXdEpmHL/WKNh
         njY0yexdO03lDx0gj+qq9idX+7Cj2tGkgz9vwLVI=
Date:   Mon, 24 Jun 2019 22:49:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Reminder: 14 open syzbot bugs in "net/sctp" subsystem
Message-ID: <20190625054930.GC17703@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

[This email was generated by a script.  Let me know if you have any suggestions
to make it better.]

Of the currently open syzbot reports against the upstream kernel, I've manually
marked 14 of them as possibly being bugs in the "net/sctp" subsystem.  I've
listed these reports below, sorted by an algorithm that tries to list first the
reports most likely to be still valid, important, and actionable.

Of these 14 bugs, 4 were seen in mainline in the last week.

Of these 14 bugs, 2 were bisected to commits from the following person:

	Xin Long <lucien.xin@gmail.com>

If you believe a bug is no longer valid, please close the syzbot report by
sending a '#syz fix', '#syz dup', or '#syz invalid' command in reply to the
original thread, as explained at https://goo.gl/tpsmEJ#status

If you believe I misattributed a bug to the "net/sctp" subsystem, please let me
know, and if possible forward the report to the correct people or mailing list.

Here are the bugs:

--------------------------------------------------------------------------------
Title:              general protection fault in sctp_sched_prio_sched
Last occurred:      9 days ago
Reported:           9 days ago
Branches:           net
Dashboard link:     https://syzkaller.appspot.com/bug?id=c9eebb3d2277a526840c1049ae16762b9b11e50e
Original thread:    https://lkml.kernel.org/lkml/00000000000017a264058b653a58@google.com/T/#u

This bug has a C reproducer.

This bug was bisected to:

	commit 4ff40b86262b73553ee47cc3784ce8ba0f220bd8
	Author: Xin Long <lucien.xin@gmail.com>
	Date:   Mon Jan 21 18:42:09 2019 +0000

	  sctp: set chunk transport correctly when it's a new asoc

The original thread for this bug has received 4 replies; the last was 6 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+c1a380d42b190ad1e559@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 6 days ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lkml.kernel.org/r/00000000000017a264058b653a58@google.com

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Read in __lock_sock
Last occurred:      9 days ago
Reported:           219 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=27934d200d11e2fbae5c715bfefad252f41785fb
Original thread:    https://lkml.kernel.org/lkml/000000000000b98a67057ad7158a@google.com/T/#u

This bug has a syzkaller reproducer only.

This bug was bisected to:

	commit 8f840e47f190cbe61a96945c13e9551048d42cef
	Author: Xin Long <lucien.xin@gmail.com>
	Date:   Thu Apr 14 07:35:33 2016 +0000

	  sctp: add the sctp_diag.c file

The original thread for this bug received 6 replies; the last was 200 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+9276d76e83e3bcde6c99@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000b98a67057ad7158a@google.com

--------------------------------------------------------------------------------
Title:              memory leak in sctp_stream_init_ext
Last occurred:      0 days ago
Reported:           24 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=bbfa653205516be2a33b51c381ef827c534ba596
Original thread:    https://lkml.kernel.org/lkml/000000000000f122ab058a303d94@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug has received 2 replies; the last was 20 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+7f3b6b106be8dcdcdeec@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000f122ab058a303d94@google.com

--------------------------------------------------------------------------------
Title:              memory leak in sctp_get_port_local
Last occurred:      3 days ago
Reported:           27 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=ff1010c7eb802434fa13f8a03fdf6752d043c77c
Original thread:    https://lkml.kernel.org/lkml/00000000000069c3140589f6d3b7@google.com/T/#u

This bug has a C reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+079bf326b38072f849d9@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/00000000000069c3140589f6d3b7@google.com

--------------------------------------------------------------------------------
Title:              memory leak in sctp_v4_create_accept_sk
Last occurred:      2 days ago
Reported:           0 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=6707a16a015da72a5d22a843e2ce411fd207b55f
Original thread:    https://lkml.kernel.org/lkml/00000000000064c849058c0cbdc9@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug has received 1 reply, 9 hours ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+afabda3890cc2f765041@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 9 hours ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lkml.kernel.org/r/00000000000064c849058c0cbdc9@google.com

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Read in ip6_hold_safe (3)
Last occurred:      1 day ago
Reported:           48 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=b30a8ecdfbefe331ff4d3a0a601ae28d91a430e3
Original thread:    https://lkml.kernel.org/lkml/000000000000eba333058848fcc1@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+1de7f57dd018a516ae89@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000eba333058848fcc1@google.com

--------------------------------------------------------------------------------
Title:              memory leak in sctp_send_reset_streams
Last occurred:      24 days ago
Reported:           24 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=ecedaad28cb6bb86a08d6dcabd93ef76f875bfaf
Original thread:    https://lkml.kernel.org/lkml/000000000000f7a443058a358cb4@google.com/T/#u

This bug has a C reproducer.

The original thread for this bug has received 2 replies; the last was 23 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+6ad9c3bd0a218a2ab41d@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000f7a443058a358cb4@google.com

--------------------------------------------------------------------------------
Title:              memory leak in sctp_v6_create_accept_sk
Last occurred:      22 days ago
Reported:           22 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=6dbf93a38d9b3ad51c95a4b5f4dfe8f0cf03a74b
Original thread:    https://lkml.kernel.org/lkml/0000000000004c134d058a5d0096@google.com/T/#u

This bug has a C reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+276ca1c77a19977c0130@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000004c134d058a5d0096@google.com

--------------------------------------------------------------------------------
Title:              KASAN: user-memory-access Read in ip6_hold_safe (3)
Last occurred:      4 days ago
Reported:           23 days ago
Branches:           bpf-next, linux-next, and net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=1707ac302b38aaceb5b3df470b198244fe0205d0
Original thread:    https://lkml.kernel.org/lkml/000000000000a7776f058a3ce9db@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 3 replies; the last was 18 hours
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+a5b6e01ec8116d046842@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread, which had activity only 18 hours ago.  For the git send-email command to
use, or tips on how to reply if the thread isn't in your mailbox, see the "Reply
instructions" at https://lkml.kernel.org/r/000000000000a7776f058a3ce9db@google.com

--------------------------------------------------------------------------------
Title:              BUG: unable to handle kernel paging request in sctp_v6_get_dst
Last occurred:      8 days ago
Reported:           176 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=b44ed5bb06a257ee2649272a08d7b68c184a7bfe
Original thread:    https://lkml.kernel.org/lkml/000000000000aa968f057e372583@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+ae70faffd84f05295f27@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000aa968f057e372583@google.com

--------------------------------------------------------------------------------
Title:              BUG: unable to handle kernel paging request in dst_release (2)
Last occurred:      12 days ago
Reported:           90 days ago
Branches:           net and net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=1457062b2884c65d9c089e0abee144e7a6de1006
Original thread:    https://lkml.kernel.org/lkml/0000000000008cc65f0584fba1c4@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+f7b46bf869b6ace2ea45@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000008cc65f0584fba1c4@google.com

--------------------------------------------------------------------------------
Title:              general protection fault in sctp_v6_get_dst (2)
Last occurred:      17 days ago
Reported:           97 days ago
Branches:           bpf-next, net, and net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=f30835c913a031ac302f0124763139ec0eb4b5d3
Original thread:    https://lkml.kernel.org/lkml/000000000000e8335605846f099f@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+5aab5972d41ebaa03f25@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000e8335605846f099f@google.com

--------------------------------------------------------------------------------
Title:              KASAN: slab-out-of-bounds Read in fib6_rule_action
Last occurred:      70 days ago
Reported:           62 days ago
Branches:           net
Dashboard link:     https://syzkaller.appspot.com/bug?id=9b73c38d6e1905753dad5374ca51271b6787a124
Original thread:    https://lkml.kernel.org/lkml/0000000000001645670587350783@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+3edc8b0bf48d614ae4ef@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000001645670587350783@google.com

--------------------------------------------------------------------------------
Title:              general protection fault in reuseport_add_sock
Last occurred:      129 days ago
Reported:           128 days ago
Branches:           net
Dashboard link:     https://syzkaller.appspot.com/bug?id=aae414b4366f2bb8cb759da428861e6e81942046
Original thread:    https://lkml.kernel.org/lkml/0000000000009e38f10581fd7499@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+675ee297acac988852c1@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000009e38f10581fd7499@google.com

