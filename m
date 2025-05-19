Return-Path: <linux-sctp+bounces-532-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F27ABC5EE
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CF11622C6
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8C4288C35;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlY9EiFo"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E1288C0A;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677117; cv=none; b=NHXzz3kqQDPb+If0oCVxRv07Ao75H+ngwgGABVYeAXKRGUGQkTmZykfaVFm58KFi9ElUTt1MbAro8ehNAfaWy3HeyRrVK5NanfZN7miltQHDfTJcaVYGT5Qf4hzFoOn6sBSA/NGK0qvBawyIyB+2nMO8Pr5lHu7XRkgcvA0kd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677117; c=relaxed/simple;
	bh=X8dbjSHr2U6lQaQcWmgJZbE8GedZCYfvJMCrGbZTikY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t71t3KSC57XHPFYnLkavQlpgy3VejZk+9Vg5pUXWTtRbWDL+HYItdskhfNEC+AoBvIIu43LvMNfB8aQuXUBkLFUqiImp/gKHX5O84uKZtG9XfUG4HdpvTBJ3pq3xs5gLAGQhwNrhanszxv1d5Il0s7c5auZEkOS+XpXCOHpA8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlY9EiFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91366C4CEF1;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677116;
	bh=X8dbjSHr2U6lQaQcWmgJZbE8GedZCYfvJMCrGbZTikY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlY9EiFojWR3LwToOtmFKpKqswni2sODtLWJbQOJSCZyOK3D+ckVrbbhOgVWs2kBC
	 jVpl3rCL7kbqWbN28BQ2XXqsRU7IqUu4cAsoE2sOZfX5RL6xi/vudcPhnJa6MNKo9r
	 U1VvGoA6aSxgLm5UbwrFmZBSjHsroSYw01xEjP76EVYxZIRBLF6BzDT1HzmskXtGUq
	 GMCVwoYXrWKjOFGvTjVQUKtIVaAwLDLeM98s1sd7Cm+3lrVAajh7hQSnZo2SWEcyQa
	 igBEz3Dvjktpl3HwTfoRnmTv+fZ/uDuSFGVIzEkK3+KNNL2F6DrrKLX5qCsxBL9YDU
	 Xk/2zo2X+V+vw==
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
Subject: [PATCH v2 01/10] net: introduce CONFIG_NET_CRC32C
Date: Mon, 19 May 2025 10:50:03 -0700
Message-ID: <20250519175012.36581-2-ebiggers@kernel.org>
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
index 202cc595e5e6f..5b71a52987d33 100644
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
index fccf2167b2352..d93bee5eb5d8c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3594,10 +3594,11 @@ int skb_checksum_help(struct sk_buff *skb)
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_checksum_help);
 
+#ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
 	__le32 crc32c_csum;
 	int ret = 0, offset, start;
 
@@ -3633,10 +3634,11 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
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
index d18a72df3654e..3669ba3518563 100644
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

base-commit: a8ae8a0e848e3506c95e45e7cb6e640502495f1a
-- 
2.49.0


