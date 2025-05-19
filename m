Return-Path: <linux-sctp+bounces-534-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FAABC5F5
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CF116FCD5
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFE289341;
	Mon, 19 May 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+NY6IHX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE55288CA9;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677118; cv=none; b=jmP/ptO+0Te+J8pyaJYsTQvVKKZ1bcYpyoEQXpGmdZzktmckoDbl0J/Y7npo4hxPnfGKzBf3caR9jHnwre+QxJkdV9MueOGCTCVJ4mBy+btUOgugze16kzeeCg+cs5hQb/OhgRjS1bPeGbxza5jBB48qKmWAaK8fbgfPM1e6Q9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677118; c=relaxed/simple;
	bh=CZeHbIh3l9QIcf9yTA+bjElzQVy8LoKCuirQSGJR4qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pep5Fn5zWh70qY71d8nmRkLaIHOQgJOlQKX97JuZnkYOsdfVFIdx9WNesqdfjU2aLdvLA3WpFb0+z/vxK7V6YIJ6l19e/YFi09FoDsd6KPNmRojCk8S/ztrMtMdlF9eS2oQ5umixYAb+lqVf65dQv/Fmh5DAsaQdY2WEdNR3jG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+NY6IHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DBFC4CEED;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677117;
	bh=CZeHbIh3l9QIcf9yTA+bjElzQVy8LoKCuirQSGJR4qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+NY6IHX2iV5SsY3RZYOow0Nztm2bCj7yjW+42uNiNSFXbjFwzEOzIa1yHobNoIhb
	 Jv+foKP87FEXKxWolLkrodJKpVSjv4B9H6I+GRogdRK2Z4nuyzhOckT+8nJ5ZDO6u6
	 bgTAfn5MWjHJOkFPnE22alDEqU8YZ7gFez4x/tPKtOifW0lsdtxFP/1nwDGl75C34T
	 DU6mk33vfWRZVLao7AKYFosr0dpXFaWcwaOcY/RaNbU9mKu+Wae54MLODBQcPKkMR9
	 oX6rrbKA+6GmCjpGtO2UdFB+En5qzUkjpnNSabxBiQDMB3ByfHC5K7WlUMoOQKfHsJ
	 uP2ZUx4JCFUoA==
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
Subject: [PATCH v2 03/10] net: use skb_crc32c() in skb_crc32c_csum_help()
Date: Mon, 19 May 2025 10:50:05 -0700
Message-ID: <20250519175012.36581-4-ebiggers@kernel.org>
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

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/core/dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d93bee5eb5d8c..430b3d3240d8f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3597,11 +3597,11 @@ int skb_checksum_help(struct sk_buff *skb)
 EXPORT_SYMBOL(skb_checksum_help);
 
 #ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
-	__le32 crc32c_csum;
+	u32 crc;
 	int ret = 0, offset, start;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		goto out;
 
@@ -3625,14 +3625,12 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 
 	ret = skb_ensure_writable(skb, offset + sizeof(__le32));
 	if (ret)
 		goto out;
 
-	crc32c_csum = cpu_to_le32(~__skb_checksum(skb, start,
-						  skb->len - start, ~(__u32)0,
-						  crc32c_csum_stub));
-	*(__le32 *)(skb->data + offset) = crc32c_csum;
+	crc = ~skb_crc32c(skb, start, skb->len - start, ~0);
+	*(__le32 *)(skb->data + offset) = cpu_to_le32(crc);
 	skb_reset_csum_not_inet(skb);
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_crc32c_csum_help);
-- 
2.49.0


