Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F709339CA
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Jun 2019 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFCUds (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 3 Jun 2019 16:33:48 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:38641 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfFCUds (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 3 Jun 2019 16:33:48 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:405a::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hXteG-00045g-QZ; Mon, 03 Jun 2019 16:33:44 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     linux-sctp@vger.kernel.org
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        syzbot+f7e9153b037eac9b1df8@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH V2] Fix memory leak in sctp_process_init
Date:   Mon,  3 Jun 2019 16:32:59 -0400
Message-Id: <20190603203259.21508-1-nhorman@tuxdriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <00000000000097abb90589e804fd@google.com>
References: <00000000000097abb90589e804fd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

syzbot found the following leak in sctp_process_init
BUG: memory leak
unreferenced object 0xffff88810ef68400 (size 1024):
  comm "syz-executor273", pid 7046, jiffies 4294945598 (age 28.770s)
  hex dump (first 32 bytes):
    1d de 28 8d de 0b 1b e3 b5 c2 f9 68 fd 1a 97 25  ..(........h...%
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000a02cebbd>] kmemleak_alloc_recursive include/linux/kmemleak.h:55
[inline]
    [<00000000a02cebbd>] slab_post_alloc_hook mm/slab.h:439 [inline]
    [<00000000a02cebbd>] slab_alloc mm/slab.c:3326 [inline]
    [<00000000a02cebbd>] __do_kmalloc mm/slab.c:3658 [inline]
    [<00000000a02cebbd>] __kmalloc_track_caller+0x15d/0x2c0 mm/slab.c:3675
    [<000000009e6245e6>] kmemdup+0x27/0x60 mm/util.c:119
    [<00000000dfdc5d2d>] kmemdup include/linux/string.h:432 [inline]
    [<00000000dfdc5d2d>] sctp_process_init+0xa7e/0xc20
net/sctp/sm_make_chunk.c:2437
    [<00000000b58b62f8>] sctp_cmd_process_init net/sctp/sm_sideeffect.c:682
[inline]
    [<00000000b58b62f8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1384
[inline]
    [<00000000b58b62f8>] sctp_side_effects net/sctp/sm_sideeffect.c:1194
[inline]
    [<00000000b58b62f8>] sctp_do_sm+0xbdc/0x1d60 net/sctp/sm_sideeffect.c:1165
    [<0000000044e11f96>] sctp_assoc_bh_rcv+0x13c/0x200
net/sctp/associola.c:1074
    [<00000000ec43804d>] sctp_inq_push+0x7f/0xb0 net/sctp/inqueue.c:95
    [<00000000726aa954>] sctp_backlog_rcv+0x5e/0x2a0 net/sctp/input.c:354
    [<00000000d9e249a8>] sk_backlog_rcv include/net/sock.h:950 [inline]
    [<00000000d9e249a8>] __release_sock+0xab/0x110 net/core/sock.c:2418
    [<00000000acae44fa>] release_sock+0x37/0xd0 net/core/sock.c:2934
    [<00000000963cc9ae>] sctp_sendmsg+0x2c0/0x990 net/sctp/socket.c:2122
    [<00000000a7fc7565>] inet_sendmsg+0x64/0x120 net/ipv4/af_inet.c:802
    [<00000000b732cbd3>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000b732cbd3>] sock_sendmsg+0x54/0x70 net/socket.c:671
    [<00000000274c57ab>] ___sys_sendmsg+0x393/0x3c0 net/socket.c:2292
    [<000000008252aedb>] __sys_sendmsg+0x80/0xf0 net/socket.c:2330
    [<00000000f7bf23d1>] __do_sys_sendmsg net/socket.c:2339 [inline]
    [<00000000f7bf23d1>] __se_sys_sendmsg net/socket.c:2337 [inline]
    [<00000000f7bf23d1>] __x64_sys_sendmsg+0x23/0x30 net/socket.c:2337
    [<00000000a8b4131f>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:3

The problem was that the peer.cookie value points to an skb allocated
area on the first pass through this function, at which point it is
overwritten with a heap allocated value, but in certain cases, where a
COOKIE_ECHO chunk is included in the packet, a second pass through
sctp_process_init is made, where the cookie value is re-allocated,
leaking the first allocation.

Fix is to always allocate the cookie value, and free it when we are done
using it.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Reported-by: syzbot+f7e9153b037eac9b1df8@syzkaller.appspotmail.com
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org

---
Change notes

V1->V2:
  * Removed an accidental double free I let slip in in
sctp_association_free
  * Removed now unused cookie variable
---
 net/sctp/sm_make_chunk.c | 13 +++----------
 net/sctp/sm_sideeffect.c |  5 +++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 72e74503f9fc..8e12e19fe42d 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2327,7 +2327,6 @@ int sctp_process_init(struct sctp_association *asoc, struct sctp_chunk *chunk,
 	union sctp_addr addr;
 	struct sctp_af *af;
 	int src_match = 0;
-	char *cookie;
 
 	/* We must include the address that the INIT packet came from.
 	 * This is the only address that matters for an INIT packet.
@@ -2431,14 +2430,6 @@ int sctp_process_init(struct sctp_association *asoc, struct sctp_chunk *chunk,
 	/* Peer Rwnd   : Current calculated value of the peer's rwnd.  */
 	asoc->peer.rwnd = asoc->peer.i.a_rwnd;
 
-	/* Copy cookie in case we need to resend COOKIE-ECHO. */
-	cookie = asoc->peer.cookie;
-	if (cookie) {
-		asoc->peer.cookie = kmemdup(cookie, asoc->peer.cookie_len, gfp);
-		if (!asoc->peer.cookie)
-			goto clean_up;
-	}
-
 	/* RFC 2960 7.2.1 The initial value of ssthresh MAY be arbitrarily
 	 * high (for example, implementations MAY use the size of the receiver
 	 * advertised window).
@@ -2607,7 +2598,9 @@ static int sctp_process_param(struct sctp_association *asoc,
 	case SCTP_PARAM_STATE_COOKIE:
 		asoc->peer.cookie_len =
 			ntohs(param.p->length) - sizeof(struct sctp_paramhdr);
-		asoc->peer.cookie = param.cookie->body;
+		asoc->peer.cookie = kmemdup(param.cookie->body, asoc->peer.cookie_len, gfp);
+		if (!asoc->peer.cookie)
+			retval = 0;
 		break;
 
 	case SCTP_PARAM_HEARTBEAT_INFO:
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 4aa03588f87b..27ddf2d8f001 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -898,6 +898,11 @@ static void sctp_cmd_new_state(struct sctp_cmd_seq *cmds,
 						asoc->rto_initial;
 	}
 
+	if (sctp_state(asoc, ESTABLISHED)) {
+		kfree(asoc->peer.cookie);
+		asoc->peer.cookie = NULL;
+	}
+
 	if (sctp_state(asoc, ESTABLISHED) ||
 	    sctp_state(asoc, CLOSED) ||
 	    sctp_state(asoc, SHUTDOWN_RECEIVED)) {
-- 
2.20.1

