Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B540A78BF09
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Aug 2023 09:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjH2HPa (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 29 Aug 2023 03:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjH2HPM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 29 Aug 2023 03:15:12 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 00:15:01 PDT
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B7CD6
        for <linux-sctp@vger.kernel.org>; Tue, 29 Aug 2023 00:15:01 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 29 Aug
 2023 10:13:53 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Aug
 2023 10:13:53 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-sctp@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com>
Subject: [PATCH net] sctp: fix uninit-value in sctp_inq_pop()
Date:   Tue, 29 Aug 2023 00:13:34 -0700
Message-ID: <20230829071334.58083-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Syzbot identified a case [1] of uninitialized memory usage in
sctp_inq_pop(), specifically in 'ch->length'.

Fix the issue by ensuring that 'ch->length' reflects the size of
'sctp_chunkhdr *ch' before accessing it.

[1]
BUG: KMSAN: uninit-value in sctp_inq_pop+0x1597/0x1910 net/sctp/inqueue.c:205
 sctp_inq_pop+0x1597/0x1910 net/sctp/inqueue.c:205
 sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:997
 sctp_inq_push+0x23e/0x2b0 net/sctp/inqueue.c:80
 sctp_backlog_rcv+0x394/0xd80 net/sctp/input.c:331
 sk_backlog_rcv include/net/sock.h:1115 [inline]
 __release_sock+0x207/0x570 net/core/sock.c:2911
 release_sock+0x6b/0x1e0 net/core/sock.c:3478
 sctp_wait_for_connect+0x486/0x810 net/sctp/socket.c:9325
 sctp_sendmsg_to_asoc+0x1ea7/0x1ee0 net/sctp/socket.c:1884
 ...

Uninit was stored to memory at:
 sctp_inq_pop+0x151a/0x1910 net/sctp/inqueue.c:201
 sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:997
 sctp_inq_push+0x23e/0x2b0 net/sctp/inqueue.c:80
 sctp_backlog_rcv+0x394/0xd80 net/sctp/input.c:331
 sk_backlog_rcv include/net/sock.h:1115 [inline]
 __release_sock+0x207/0x570 net/core/sock.c:2911
 release_sock+0x6b/0x1e0 net/core/sock.c:3478
 sctp_wait_for_connect+0x486/0x810 net/sctp/socket.c:9325
 sctp_sendmsg_to_asoc+0x1ea7/0x1ee0 net/sctp/socket.c:1884
 ...

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node_track_caller+0x118/0x3c0 mm/slab_common.c:986
 kmalloc_reserve+0x248/0x470 net/core/skbuff.c:585
 __alloc_skb+0x318/0x740 net/core/skbuff.c:654
 alloc_skb include/linux/skbuff.h:1288 [inline]
 sctp_packet_pack net/sctp/output.c:472 [inline]
 sctp_packet_transmit+0x1729/0x4150 net/sctp/output.c:621
 sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
 ...

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=70a42f45e76bede082be
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 net/sctp/inqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7182c5a450fb..98ce9524c87c 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -197,6 +197,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 		}
 	}
 
+	ch->length = htons(sizeof(*ch));
 	chunk->chunk_hdr = ch;
 	chunk->chunk_end = ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
 	skb_pull(chunk->skb, sizeof(*ch));
-- 
2.25.1

