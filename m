Return-Path: <linux-sctp+bounces-535-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02945ABC5FB
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D92173C1B
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC293289817;
	Mon, 19 May 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpqOLcbd"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11C28937F;
	Mon, 19 May 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677118; cv=none; b=AlRVVx8epQ6Nkz/SG0mIfyVSKNqlcWZAygAdvX0SvS74DK42it9mTHCv5msKZtnBpsBWN5PgMi/iiCU4EfzH+04j/tz7+C5f5BeBKEl4FEDarcBozWObZ3kEwEDoTq4g84TGtA2ZxieC8V1yY8noDbYF2GsSPrDJ2T7C7IQhyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677118; c=relaxed/simple;
	bh=qXgV9satb45eNRR3L104eZrX/IdR9NTQp49GiqE+3gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA8BA3bCgbo/17a5+XGDobNMfDwbdl/DXYQJ0gsO7iQ48gLvEVMl6eAjU67U+gsA5P+ZtlsoRCu9py55ZGsAQU4L0DOM/5iuECOvmYhtDDc242tNsRTNkWH2KMA2BogGIEl69zI7BX2qYBtIsNWwEhUj32A3/jTajGO1ZzFUIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpqOLcbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C762EC4CEF4;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677118;
	bh=qXgV9satb45eNRR3L104eZrX/IdR9NTQp49GiqE+3gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpqOLcbddjxKZISEVtDFk+/IF3H693CmEJVHkGUHSaHVKbdhuQx70BGwFU7IJhx6B
	 W9wBUwc+orbMN2pXbfpEvvH1D9aMRr+yqdI1KR9/l3/Niak2jcHpiC4sIZpASg0tre
	 +jl753yjFJx4dVmw+VsnvnsiE2lSDoeFw3P5kSSRIgzBPOSQMSZ6u6Ulh/b8xCDVwJ
	 K8zXhQlSxcM+ycmCftLdAnVhnhQGJzjQY+90r6Iz1oIJqYBhb8SffJGFKCwGY2Bq3h
	 NBUKYcVpi4rS2s2i+jW/wj5iz878bGlGCNufREw1AFZb7ALnlGC5fjgFOjvb526ZeC
	 RsZdP9qnwDJBw==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 04/10] RDMA/siw: use skb_crc32c() instead of __skb_checksum()
Date: Mon, 19 May 2025 10:50:06 -0700
Message-ID: <20250519175012.36581-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
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

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/sw/siw/Kconfig |  1 +
 drivers/infiniband/sw/siw/siw.h   | 22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index ae4a953e2a039..186f182b80e79 100644
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
index 385067e07faf1..d9e5a2e4c471a 100644
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


