Return-Path: <linux-sctp+bounces-494-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3CAB25DE
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551FC188F81C
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5214A09C;
	Sun, 11 May 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa7T7Oxn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A01F92E;
	Sun, 11 May 2025 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924092; cv=none; b=PpaYoLnFsAYhHj7Cb1ONuL7y0h0gNNp/AY1OLBskSrjFF76GJlf3Q4sF0EnSFT67/PJN+aLurevXsSRF2K/CMjBydClX473rY7FKqdtOZN5ihU83Zs1AMzm4eWvQqZGYFwnUTA8fmOr9EZwjMW8AMfW6YMQ/+TjcbyArVrrqez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924092; c=relaxed/simple;
	bh=dQ3McGhqu8bezBUWJWiJB1iEsbKs9gFTYUnJ6baxEuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdfE6+iecNaj1Tuhgu+ErELaqHsFuP+f88UL3/wSQohnNiwEKMdyfrPlG9wSE/c57eQdI/h+U5AzQSv9qHIkaZLj+SQs0DmVadjTu9cKWIr5nJQV15fFe1bL+769tIgX7WrKLOVK31khGbWZueVezyDhrOaPm1e6v0goFyN1ZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa7T7Oxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3EDC4CEEF;
	Sun, 11 May 2025 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924092;
	bh=dQ3McGhqu8bezBUWJWiJB1iEsbKs9gFTYUnJ6baxEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa7T7OxnnKAOtnHbW67Yh3SN6VEFAghG5iuSecCjaRjWK2H5ZFnqd3ruXmX1WCyPj
	 lMGthlluCIWNDUYdw8q/r4ByWc+TU+nj/oVY0GvbUT8XmBr/Gh8OYwcGF1QzHPlXFI
	 RDaackghdGL9dFfrsqWe9NGfMk//qkLqMk1/UGCTqlIXPt7H3DpmtQqS/4uT2bZlr8
	 rR1BreDqMu+yp9bSA0rtgY/IDR9iPUBpoNV5AhN/RaYk9lk3ajZJWWQq0N3VIdBV17
	 YFQd37j3IMwjX3/cZkWZvCi4PNEJ5rwtSSo72l6hVio6ufFY3Rk+EXMMvad4l7chNY
	 964mQbVB+pA5Q==
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
Subject: [PATCH net-next 03/10] net: use skb_crc32c() in skb_crc32c_csum_help()
Date: Sat, 10 May 2025 17:41:03 -0700
Message-ID: <20250511004110.145171-4-ebiggers@kernel.org>
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
 net/core/dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 51606b2d17bb..1eda2501f07b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3595,11 +3595,11 @@ int skb_checksum_help(struct sk_buff *skb)
 EXPORT_SYMBOL(skb_checksum_help);
 
 #ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
-	__le32 crc32c_csum;
+	u32 crc;
 	int ret = 0, offset, start;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		goto out;
 
@@ -3623,14 +3623,12 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 
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


