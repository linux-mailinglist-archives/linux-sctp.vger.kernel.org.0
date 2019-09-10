Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093B8AE40F
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Sep 2019 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406468AbfIJG4X (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 10 Sep 2019 02:56:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727816AbfIJG4W (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 10 Sep 2019 02:56:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E360A5AC159EB3A6D7B8;
        Tue, 10 Sep 2019 14:56:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Sep 2019 14:56:10 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <vyasevich@gmail.com>, <nhorman@tuxdriver.com>,
        <marcelo.leitner@gmail.com>, <davem@davemloft.net>
CC:     <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH net 2/2] sctp: destroy bucket if failed to bind addr
Date:   Tue, 10 Sep 2019 15:13:43 +0800
Message-ID: <20190910071343.18808-3-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910071343.18808-1-maowenan@huawei.com>
References: <20190910071343.18808-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

There is one memory leak bug report:
BUG: memory leak
unreferenced object 0xffff8881dc4c5ec0 (size 40):
  comm "syz-executor.0", pid 5673, jiffies 4298198457 (age 27.578s)
  hex dump (first 32 bytes):
    02 00 00 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    f8 63 3d c1 81 88 ff ff 00 00 00 00 00 00 00 00  .c=.............
  backtrace:
    [<0000000072006339>] sctp_get_port_local+0x2a1/0xa00 [sctp]
    [<00000000c7b379ec>] sctp_do_bind+0x176/0x2c0 [sctp]
    [<000000005be274a2>] sctp_bind+0x5a/0x80 [sctp]
    [<00000000b66b4044>] inet6_bind+0x59/0xd0 [ipv6]
    [<00000000c68c7f42>] __sys_bind+0x120/0x1f0 net/socket.c:1647
    [<000000004513635b>] __do_sys_bind net/socket.c:1658 [inline]
    [<000000004513635b>] __se_sys_bind net/socket.c:1656 [inline]
    [<000000004513635b>] __x64_sys_bind+0x3e/0x50 net/socket.c:1656
    [<0000000061f2501e>] do_syscall_64+0x72/0x2e0 arch/x86/entry/common.c:296
    [<0000000003d1e05e>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is because in sctp_do_bind, if sctp_get_port_local is to
create hash bucket successfully, and sctp_add_bind_addr failed
to bind address, e.g return -ENOMEM, so memory leak found, it
needs to destroy allocated bucket.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/sctp/socket.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 766b68b55ebe..ab37fc1f7bb6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -412,11 +412,13 @@ static int sctp_do_bind(struct sock *sk, union sctp_addr *addr, int len)
 	ret = sctp_add_bind_addr(bp, addr, af->sockaddr_len,
 				 SCTP_ADDR_SRC, GFP_ATOMIC);
 
-	/* Copy back into socket for getsockname() use. */
-	if (!ret) {
-		inet_sk(sk)->inet_sport = htons(inet_sk(sk)->inet_num);
-		sp->pf->to_sk_saddr(addr, sk);
+	if (ret) {
+		sctp_put_port(sk);
+		return ret;
 	}
+	/* Copy back into socket for getsockname() use. */
+	inet_sk(sk)->inet_sport = htons(inet_sk(sk)->inet_num);
+	sp->pf->to_sk_saddr(addr, sk);
 
 	return ret;
 }
-- 
2.20.1

