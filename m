Return-Path: <linux-sctp+bounces-492-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4916AB25D7
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9833B3672
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A92CCC9;
	Sun, 11 May 2025 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0y1n+I7"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4507320311;
	Sun, 11 May 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924090; cv=none; b=VkqsbpRSWUpEVPCxrjlvi02wUjyq28eqPcoUl9VJ5oACaOaFl6GxZ8voZN1l0FJpntn0rFkKUu1eLZC1TmiTEkCI6SbGomSfaq2TzmPPpx4IF+5WE7/0iG5hLWA95sbykmln6twcVBOZ/xOASe3vUPnXUCZxGCLmRAuZsQRMqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924090; c=relaxed/simple;
	bh=y+V5sqoQHeK8LApRzwTSNGThMks43WhP9Yn3FOEf8Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b231eocWF+fW1hVvAEodyPi6jT3JOx1gMpnCStHQ6dq5gx3uuEUpmKbUP9PnNdEC9AlJM6Zk9/Bpy6bcDQtC/gN+i+0FmxixCuvw1yhha2pI5It7Jz1NXVs+zZqcEpxeKQq4vlHsiyGxzSI2uNuf+NoTC1Wg8kJp8LjqcoVxQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0y1n+I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A479BC4CEE7;
	Sun, 11 May 2025 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924089;
	bh=y+V5sqoQHeK8LApRzwTSNGThMks43WhP9Yn3FOEf8Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0y1n+I7LS4gxWUEW9UGJENJf8q05kPt14AA+vOjXvPSld21FBsxDTrngmhW6ds9N
	 tNT/l2LtTU/Xb2/E1IMyJa1O1Ik3Tq22x9etKzp4elyOyULegjzrqxh8LqsSveZmoE
	 5aJWy990axz8FFX4bpgK333gBTiL63N4H+JBq2aP9gLpKve61soSVwMvbQBHeHilEe
	 E06Q51UbJiuMdrNEc2Ccg2Y5ES8nPgRT2hg7KiZViZ1OS4qbHLPIDxNR0xzOz9qssQ
	 x4w8YtgvS0wTrAiRvj8S5qUevItSur4VK5ulS/MjwAi195cZHdwXXxlyElSlFI6JOQ
	 IOI1ZpNS9qCaw==
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
Subject: [PATCH net-next 01/10] net: introduce CONFIG_NET_CRC32C
Date: Sat, 10 May 2025 17:41:01 -0700
Message-ID: <20250511004110.145171-2-ebiggers@kernel.org>
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

Add a hidden kconfig symbol NET_CRC32C that will group together the
functions that calculate CRC32C checksums of packets, so that these
don't have to be built into NET-enabled kernels that don't need them.

Make skb_crc32c_csum_help() (which is called only when IP_SCTP is
enabled) conditional on this symbol, and make IP_SCTP select it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/Kconfig      | 4 ++++
 net/core/dev.c   | 2 ++
 net/sctp/Kconfig | 1 +
 3 files changed, 7 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 202cc595e5e6..5b71a52987d3 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -73,10 +73,14 @@ config NET_DEVMEM
 	depends on PAGE_POOL
 
 config NET_SHAPER
 	bool
 
+config NET_CRC32C
+	bool
+	select CRC32
+
 menu "Networking options"
 
 source "net/packet/Kconfig"
 source "net/unix/Kconfig"
 source "net/tls/Kconfig"
diff --git a/net/core/dev.c b/net/core/dev.c
index c9013632296f..51606b2d17bb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3592,10 +3592,11 @@ int skb_checksum_help(struct sk_buff *skb)
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_checksum_help);
 
+#ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
 	__le32 crc32c_csum;
 	int ret = 0, offset, start;
 
@@ -3631,10 +3632,11 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 	skb_reset_csum_not_inet(skb);
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_crc32c_csum_help);
+#endif /* CONFIG_NET_CRC32C */
 
 __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 {
 	__be16 type = skb->protocol;
 
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index d18a72df3654..3669ba351856 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -9,10 +9,11 @@ menuconfig IP_SCTP
 	depends on IPV6 || IPV6=n
 	select CRC32
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
+	select NET_CRC32C
 	select NET_UDP_TUNNEL
 	help
 	  Stream Control Transmission Protocol
 
 	  From RFC 2960 <http://www.ietf.org/rfc/rfc2960.txt>.

base-commit: 0b28182c73a3d013bcabbb890dc1070a8388f55a
-- 
2.49.0


