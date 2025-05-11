Return-Path: <linux-sctp+bounces-495-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D97AAB25DF
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6746C460820
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6417A2ED;
	Sun, 11 May 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJemVLpI"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E5155322;
	Sun, 11 May 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924093; cv=none; b=Dw3n3w+WB9rM+lYT8XKZxQJv+yVtoyHGCFdp3eHYMA+l49qGVSiscTJjvSB27AH4pJ3Bq047EirF32lC4fu+Nw0d5PT3crCjAvYujvBk9ryAbr87qatBaFmjURppqZvVnrZIeDs/72V6+eZ8nqEdaxXuig5G7kcQjLBz88dXzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924093; c=relaxed/simple;
	bh=IwN0x6l2VckNHXEEglHCnVHt/6hl+HXCt3jiyh026og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6XrF7vyZuHxtmigfKj2ItOditNYl4MUAlw8vEy3py+Bf3SxO7RQ2raO4Dk2H2nPYLM97/txMDPDICoUSyt24IibkZUH/PfVMohSLRpW6dZEONWZHxd9wUuWzMjes8W9Rs/s/OBk8Xf6Y++8QolBEc/k4UvXW9u7F0KlkJuoYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJemVLpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CADEC4CEE2;
	Sun, 11 May 2025 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924093;
	bh=IwN0x6l2VckNHXEEglHCnVHt/6hl+HXCt3jiyh026og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJemVLpI1SUn8x/itxDunpJJSTPHgSrvU7okEl2jVOzcEmKGHFuJEYaek3TfkG/37
	 7H5LtY6qDtcPgB/uPA94WF00BzSm3cPQkSIZAy76OQ5GwjdtwAd9vD9+QFAYMruF/E
	 6PjPCY/oTm2bcITyxO5cSMwJ+s7cVi1XdM9EU76ax+ODQ8j1XEClds82ensWXTDuXz
	 JsTPrFfin6XR5bt+LvJM5U2KYo5VBaAcNqRayfiOHqTmm0VzSpIxr/jI4nAPw0n3zo
	 oXkQVutteDPHb4aVsup7jD9XMotu4BmggbwVlH3qVsiLcrJmnhOD0beWJaWp5T2TXV
	 /ztmrEfidVbJg==
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
Subject: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of __skb_checksum()
Date: Sat, 10 May 2025 17:41:04 -0700
Message-ID: <20250511004110.145171-5-ebiggers@kernel.org>
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

Instead of calling __skb_checksum() with a skb_checksum_ops struct that
does CRC32C, just call the new function skb_crc32c().  This is faster
and simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/sw/siw/Kconfig |  1 +
 drivers/infiniband/sw/siw/siw.h   | 22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index ae4a953e2a03..186f182b80e7 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,10 +1,11 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND
 	depends on INFINIBAND_VIRT_DMA
 	select CRC32
+	select NET_CRC32C
 	help
 	This driver implements the iWARP RDMA transport over
 	the Linux TCP/IP network stack. It enables a system with a
 	standard Ethernet adapter to interoperate with a iWARP
 	adapter or with another system running the SIW driver.
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 385067e07faf..d9e5a2e4c471 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -691,33 +691,13 @@ static inline void siw_crc_oneshot(const void *data, size_t len, u8 out[4])
 	siw_crc_init(&crc);
 	siw_crc_update(&crc, data, len);
 	return siw_crc_final(&crc, out);
 }
 
-static inline __wsum siw_csum_update(const void *buff, int len, __wsum sum)
-{
-	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
-}
-
-static inline __wsum siw_csum_combine(__wsum csum, __wsum csum2, int offset,
-				      int len)
-{
-	return (__force __wsum)crc32c_combine((__force __u32)csum,
-					      (__force __u32)csum2, len);
-}
-
 static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
 {
-	const struct skb_checksum_ops siw_cs_ops = {
-		.update = siw_csum_update,
-		.combine = siw_csum_combine,
-	};
-	__wsum crc = (__force __wsum)srx->mpa_crc;
-
-	crc = __skb_checksum(srx->skb, srx->skb_offset, len, crc,
-			     &siw_cs_ops);
-	srx->mpa_crc = (__force u32)crc;
+	srx->mpa_crc = skb_crc32c(srx->skb, srx->skb_offset, len, srx->mpa_crc);
 }
 
 #define siw_dbg(ibdev, fmt, ...)                                               \
 	ibdev_dbg(ibdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
-- 
2.49.0


