Return-Path: <linux-sctp+bounces-496-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E075AAB25E4
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726904608B8
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262571946BC;
	Sun, 11 May 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm/YLJLE"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89D179BF;
	Sun, 11 May 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924096; cv=none; b=sHsVPR76S+a+jQwVk91FRnYEX+OwjPJSUdNozNQwlRlChgFewS1gnFIRN6mcBfqHrj8PUYAUy2LWC375PNiHigl6iPE46H61IC0E4/iDQMcVZKh1Nm3pG7oF3JcA5zKJKkabbyTJZbeKFKTAti9v1xzNTn+uHXVJnEV/4O328UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924096; c=relaxed/simple;
	bh=rzxlJ+REpOzn2hxjAiUOHuapxr7sRcF5AgoLopDe6KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrfusT1qe0YH6f7u94HSbpaoQ3BG5hulC52Wdku+eaTEbN0FaXwkkMw4ZhyMjP3hd86T1JyBcJvsUf+l+Q9uM0Uao6Axv/Y86PpyuBll2ivvgbPZ2snAx1p7w9xRzCVRYCTpMcwpe+bQIjPkzzXN3W92znvZIeCpcZ4wNNmnT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm/YLJLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B472C4CEE7;
	Sun, 11 May 2025 00:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924094;
	bh=rzxlJ+REpOzn2hxjAiUOHuapxr7sRcF5AgoLopDe6KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rm/YLJLE66m5WNVbp4MovT3aGm3bwEndEL51q8a2/boVKXK6nYdKZg/vVQFQPKleJ
	 l/e30U3014fXykXrZAK8jxbJXcO/IFBp/aO5zaW34w01OvvqOE9nn9qtjsuhAkBoLr
	 KWFW+hv0HpWlJgsIdqR8vFsplS6Td3hKtaN3oaw7NWBsPLn7kEMc5vC1p7fS3WK9mA
	 eNKHlUbYel1pBeiUIJ+VwhaQy2a7E5/DpVmiKdbpBvdqp8Z6rMZqxc0yVOJXSfFXi+
	 Nec2eKKlsISTaovL4hCDhNNmMPKRpxIJ343FGc9JCrhCcHfF4wKShEW/P36xp/EL7g
	 R2t/fWbZO9oUA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH net-next 05/10] sctp: use skb_crc32c() instead of __skb_checksum()
Date: Sat, 10 May 2025 17:41:05 -0700
Message-ID: <20250511004110.145171-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Make sctp_compute_cksum() just use the new function skb_crc32c(),
instead of calling __skb_checksum() with a skb_checksum_ops struct that
does CRC32C.  This is faster and simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/net/sctp/checksum.h | 29 +++--------------------------
 net/netfilter/Kconfig       |  4 ++--
 net/netfilter/ipvs/Kconfig  |  2 +-
 net/openvswitch/Kconfig     |  2 +-
 net/sched/Kconfig           |  2 +-
 net/sctp/Kconfig            |  1 -
 net/sctp/offload.c          |  1 -
 7 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
index 291465c25810..654d37ec0402 100644
--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -13,51 +13,28 @@
  *
  * Written or modified by:
  *    Dinakaran Joseph
  *    Jon Grimm <jgrimm@us.ibm.com>
  *    Sridhar Samudrala <sri@us.ibm.com>
- *
- * Rewritten to use libcrc32c by:
  *    Vlad Yasevich <vladislav.yasevich@hp.com>
  */
 
 #ifndef __sctp_checksum_h__
 #define __sctp_checksum_h__
 
 #include <linux/types.h>
 #include <linux/sctp.h>
-#include <linux/crc32c.h>
-#include <linux/crc32.h>
-
-static inline __wsum sctp_csum_update(const void *buff, int len, __wsum sum)
-{
-	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
-}
-
-static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
-				       int offset, int len)
-{
-	return (__force __wsum)crc32c_combine((__force __u32)csum,
-					      (__force __u32)csum2, len);
-}
-
-static const struct skb_checksum_ops sctp_csum_ops = {
-	.update  = sctp_csum_update,
-	.combine = sctp_csum_combine,
-};
 
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
 	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
 	__le32 old = sh->checksum;
-	__wsum new;
+	u32 new;
 
 	sh->checksum = 0;
-	new = ~__skb_checksum(skb, offset, skb->len - offset, ~(__wsum)0,
-			      &sctp_csum_ops);
+	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
 	sh->checksum = old;
-
-	return cpu_to_le32((__force __u32)new);
+	return cpu_to_le32(new);
 }
 
 #endif /* __sctp_checksum_h__ */
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 3b2183fc7e56..2560416218d0 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -210,11 +210,11 @@ config NF_CT_PROTO_GRE
 
 config NF_CT_PROTO_SCTP
 	bool 'SCTP protocol connection tracking support'
 	depends on NETFILTER_ADVANCED
 	default y
-	select CRC32
+	select NET_CRC32C
 	help
 	  With this option enabled, the layer 3 independent connection
 	  tracking code will be able to do state tracking on SCTP connections.
 
 	  If unsure, say Y.
@@ -473,11 +473,11 @@ config NETFILTER_SYNPROXY
 
 endif # NF_CONNTRACK
 
 config NF_TABLES
 	select NETFILTER_NETLINK
-	select CRC32
+	select NET_CRC32C
 	tristate "Netfilter nf_tables support"
 	help
 	  nftables is the new packet classification framework that intends to
 	  replace the existing {ip,ip6,arp,eb}_tables infrastructure. It
 	  provides a pseudo-state machine with an extensible instruction-set
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 8c5b1fe12d07..c203252e856d 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -103,11 +103,11 @@ config	IP_VS_PROTO_AH
 	  This option enables support for load balancing AH (Authentication
 	  Header) transport protocol. Say Y if unsure.
 
 config  IP_VS_PROTO_SCTP
 	bool "SCTP load balancing support"
-	select CRC32
+	select NET_CRC32C
 	help
 	  This option enables support for load balancing SCTP transport
 	  protocol. Say Y if unsure.
 
 comment "IPVS scheduler"
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 5481bd561eb4..e6aaee92dba4 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -9,12 +9,12 @@ config OPENVSWITCH
 	depends on !NF_CONNTRACK || \
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
 				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
 	depends on PSAMPLE || !PSAMPLE
-	select CRC32
 	select MPLS
+	select NET_CRC32C
 	select NET_MPLS_GSO
 	select DST_CACHE
 	select NET_NSH
 	select NF_CONNTRACK_OVS if NF_CONNTRACK
 	select NF_NAT_OVS if NF_NAT
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 9f0b3f943fca..ad914d2b2e22 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -794,11 +794,11 @@ config NET_ACT_SKBEDIT
 	  module will be called act_skbedit.
 
 config NET_ACT_CSUM
 	tristate "Checksum Updating"
 	depends on NET_CLS_ACT && INET
-	select CRC32
+	select NET_CRC32C
 	help
 	  Say Y here to update some common checksum after some direct
 	  packet alterations.
 
 	  To compile this code as a module, choose M here: the
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 3669ba351856..24d5a35ce894 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -5,11 +5,10 @@
 
 menuconfig IP_SCTP
 	tristate "The SCTP Protocol"
 	depends on INET
 	depends on IPV6 || IPV6=n
-	select CRC32
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select NET_CRC32C
 	select NET_UDP_TUNNEL
diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index 502095173d88..e6f863c031b4 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -109,11 +109,10 @@ int __init sctp_offload_init(void)
 
 	ret = inet6_add_offload(&sctp6_offload, IPPROTO_SCTP);
 	if (ret)
 		goto ipv4;
 
-	crc32c_csum_stub = &sctp_csum_ops;
 	return ret;
 
 ipv4:
 	inet_del_offload(&sctp_offload, IPPROTO_SCTP);
 out:
-- 
2.49.0


