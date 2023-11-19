Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8E7F0436
	for <lists+linux-sctp@lfdr.de>; Sun, 19 Nov 2023 04:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSDaQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 18 Nov 2023 22:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSDaP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 18 Nov 2023 22:30:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081CD194;
        Sat, 18 Nov 2023 19:30:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2FBC433C8;
        Sun, 19 Nov 2023 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700364611;
        bh=cF0DfcV5jamol5ijl6UjVG5UKkxViwvd/MyyuGVd+BA=;
        h=From:To:Cc:Subject:Date:From;
        b=hBdsCaJGdZ2wVZzBQvYwx5V2OQ7oa1M6OoRgE+VCZa8PfHDjXti9f1yOfblQk/KTg
         +dd0jNGo67QWr12l2Cq/M+PM1jQnRtaw4rvcncHpW4tBNsXok+ZpXXGgqpM8ims2Qs
         fEqrRIfMTusjsz3AIa8q/dPzRlG39Hmjx786uNOSNo8Yk6mhDqxjbovL/mYOnNWHhx
         5LxQyp4jHWNk0xJuEMNIBChxBJQ2MCGzLoMHaQZKEZd4bfWExXuiYoD3l6C3QYBsbq
         oeBgzCVmCciQRtownB0jtrgft1lcJ1Zg0QXOjXdGUDrIVNHB4ECYLWOViNUGzu+Ywv
         Kx5CeLAXoPFAw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org,
        matttbe@kernel.org, martineau@kernel.org,
        marcelo.leitner@gmail.com, lucien.xin@gmail.com,
        kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, jmaloy@redhat.com, ying.xue@windriver.com,
        sgarzare@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, kuniyu@amazon.com,
        mptcp@lists.linux.dev, linux-sctp@vger.kernel.org,
        linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: [PATCH net] net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
Date:   Sat, 18 Nov 2023 19:30:06 -0800
Message-ID: <20231119033006.442271-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to all the sock diag modules in one fell swoop.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
CC: matttbe@kernel.org
CC: martineau@kernel.org
CC: marcelo.leitner@gmail.com
CC: lucien.xin@gmail.com
CC: kgraul@linux.ibm.com
CC: wenjia@linux.ibm.com
CC: jaka@linux.ibm.com
CC: alibuda@linux.alibaba.com
CC: tonylu@linux.alibaba.com
CC: guwen@linux.alibaba.com
CC: jmaloy@redhat.com
CC: ying.xue@windriver.com
CC: sgarzare@redhat.com
CC: bjorn@kernel.org
CC: magnus.karlsson@intel.com
CC: maciej.fijalkowski@intel.com
CC: kuniyu@amazon.com
CC: mptcp@lists.linux.dev
CC: linux-sctp@vger.kernel.org
CC: linux-s390@vger.kernel.org
CC: tipc-discussion@lists.sourceforge.net
CC: virtualization@lists.linux.dev
CC: bpf@vger.kernel.org
---
 net/ipv4/inet_diag.c   | 1 +
 net/ipv4/raw_diag.c    | 1 +
 net/ipv4/tcp_diag.c    | 1 +
 net/ipv4/udp_diag.c    | 1 +
 net/mptcp/mptcp_diag.c | 1 +
 net/packet/diag.c      | 1 +
 net/sctp/diag.c        | 1 +
 net/smc/smc_diag.c     | 1 +
 net/tipc/diag.c        | 1 +
 net/unix/diag.c        | 1 +
 net/vmw_vsock/diag.c   | 1 +
 net/xdp/xsk_diag.c     | 1 +
 12 files changed, 12 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index f01aee832aab..7d0e7aaa71e0 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1481,5 +1481,6 @@ static void __exit inet_diag_exit(void)
 module_init(inet_diag_init);
 module_exit(inet_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("INET/INET6: socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2 /* AF_INET */);
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 10 /* AF_INET6 */);
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index 63a40e4b678f..fe2140c8375c 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -257,5 +257,6 @@ static void __exit raw_diag_exit(void)
 module_init(raw_diag_init);
 module_exit(raw_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RAW socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-255 /* AF_INET - IPPROTO_RAW */);
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 10-255 /* AF_INET6 - IPPROTO_RAW */);
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 01b50fa79189..4cbe4b44425a 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -247,4 +247,5 @@ static void __exit tcp_diag_exit(void)
 module_init(tcp_diag_init);
 module_exit(tcp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TCP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-6 /* AF_INET - IPPROTO_TCP */);
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index de3f2d31f510..dc41a22ee80e 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -296,5 +296,6 @@ static void __exit udp_diag_exit(void)
 module_init(udp_diag_init);
 module_exit(udp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UDP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-17 /* AF_INET - IPPROTO_UDP */);
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-136 /* AF_INET - IPPROTO_UDPLITE */);
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 8df1bdb647e2..5409c2ea3f57 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -245,4 +245,5 @@ static void __exit mptcp_diag_exit(void)
 module_init(mptcp_diag_init);
 module_exit(mptcp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-262 /* AF_INET - IPPROTO_MPTCP */);
diff --git a/net/packet/diag.c b/net/packet/diag.c
index f6b200cb3c06..9a7980e3309d 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -262,4 +262,5 @@ static void __exit packet_diag_exit(void)
 module_init(packet_diag_init);
 module_exit(packet_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PACKET socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 17 /* AF_PACKET */);
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index c3d6b92dd386..eb05131ff1dd 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -527,4 +527,5 @@ static void __exit sctp_diag_exit(void)
 module_init(sctp_diag_init);
 module_exit(sctp_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SCTP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-132);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 7ff2152971a5..a584613aca12 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -268,5 +268,6 @@ static void __exit smc_diag_exit(void)
 module_init(smc_diag_init);
 module_exit(smc_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SMC socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 43 /* AF_SMC */);
 MODULE_ALIAS_GENL_FAMILY(SMCR_GENL_FAMILY_NAME);
diff --git a/net/tipc/diag.c b/net/tipc/diag.c
index 73137f4aeb68..18733451c9e0 100644
--- a/net/tipc/diag.c
+++ b/net/tipc/diag.c
@@ -113,4 +113,5 @@ module_init(tipc_diag_init);
 module_exit(tipc_diag_exit);
 
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("TIPC socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, AF_TIPC);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 616b55c5b890..bec09a3a1d44 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -339,4 +339,5 @@ static void __exit unix_diag_exit(void)
 module_init(unix_diag_init);
 module_exit(unix_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UNIX socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 1 /* AF_LOCAL */);
diff --git a/net/vmw_vsock/diag.c b/net/vmw_vsock/diag.c
index a2823b1c5e28..2e29994f92ff 100644
--- a/net/vmw_vsock/diag.c
+++ b/net/vmw_vsock/diag.c
@@ -174,5 +174,6 @@ static void __exit vsock_diag_exit(void)
 module_init(vsock_diag_init);
 module_exit(vsock_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VMware Virtual Sockets monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG,
 			       40 /* AF_VSOCK */);
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 22b36c8143cf..9f8955367275 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -211,4 +211,5 @@ static void __exit xsk_diag_exit(void)
 module_init(xsk_diag_init);
 module_exit(xsk_diag_exit);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("XDP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, AF_XDP);
-- 
2.42.0

