Return-Path: <linux-sctp+bounces-498-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7690AB25E9
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E118911F2
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8471A238B;
	Sun, 11 May 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ+G6GKy"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D319E97C;
	Sun, 11 May 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924097; cv=none; b=L40DIQaoszsNHsDdBn9yQ2t/VXq8VR/Cldst0dlVgol0IiiyeV6TJqx4KVozE9WLFLvtn0yH5bWGCufAV6I03n6O9Ny4Zzr3EuG0Bk+1nAxMQQtUUhx9j8nZutOACfd40Fqyu2Reum95Ouqti9INgQYm4sQP5blyZpXxdI57cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924097; c=relaxed/simple;
	bh=lrrEmehbwxWEKGD3wwCwtRu2pJjck1nWjCeLNo9TZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYOxqduEkSj18pEJQmAgi5GH+V69CW2vABEDPPeHUoaebEv4/8bZAcLDUZV9kE+0CahZzNkwdXwPGHxn8xFPaF64yqbZWY/kXhl8kbmLHsR4XfTq+guTT2KRYbwUpvHr7WmuIjMx8SFphdRfT76ZnZc1fDSDrf+KLahUmeyhZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ+G6GKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD6C4CEE2;
	Sun, 11 May 2025 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924096;
	bh=lrrEmehbwxWEKGD3wwCwtRu2pJjck1nWjCeLNo9TZWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZ+G6GKyaMO9jwCJkNQPgPKy07uW683dXPqFPHLVjvns+beQP1B0lSyu4y/UlOKcN
	 WNCifKV9Fi4CLPKSzJRkKGLS37q1CTr/mM43gJ3d9OPluIDjdjEJzwZ8VkXlZko3lP
	 HUMQlrCAs1PFxceMg5nNJ0lV15q6d7+B7dl28oao79TYJOp3BtI1BFesBcTtSiz0EO
	 Dj5sGtUbGJmnZdskWImOYgulYYil/93TlT7okbsQ6nNg+414oguMpdfzsweIyep4E6
	 PAUauigCUbb9KjtfcfhvdVlEWXBmzmmnFtu6/RMSV8LOgHxRn2G9RYhRLltKhn++wt
	 XximtRg5csL+g==
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
Subject: [PATCH net-next 07/10] lib/crc32: remove unused support for CRC32C combination
Date: Sat, 10 May 2025 17:41:07 -0700
Message-ID: <20250511004110.145171-8-ebiggers@kernel.org>
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

crc32c_combine() and crc32c_shift() are no longer used (except by the
KUnit test that tests them), and their current implementation is very
slow.  Remove them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/crc32.h | 23 -----------------------
 lib/crc32.c           |  6 ------
 lib/tests/crc_kunit.c |  6 ------
 3 files changed, 35 deletions(-)

diff --git a/include/linux/crc32.h b/include/linux/crc32.h
index 69c2e8bb3782..7f7d0be8a0ac 100644
--- a/include/linux/crc32.h
+++ b/include/linux/crc32.h
@@ -74,33 +74,10 @@ u32 crc32_le_shift(u32 crc, size_t len);
 static inline u32 crc32_le_combine(u32 crc1, u32 crc2, size_t len2)
 {
 	return crc32_le_shift(crc1, len2) ^ crc2;
 }
 
-u32 crc32c_shift(u32 crc, size_t len);
-
-/**
- * crc32c_combine - Combine two crc32c check values into one. For two sequences
- *		    of bytes, seq1 and seq2 with lengths len1 and len2, crc32c()
- *		    check values were calculated for each, crc1 and crc2.
- *
- * @crc1: crc32c of the first block
- * @crc2: crc32c of the second block
- * @len2: length of the second block
- *
- * Return: The crc32c() check value of seq1 and seq2 concatenated, requiring
- *	   only crc1, crc2, and len2. Note: If seq_full denotes the concatenated
- *	   memory area of seq1 with seq2, and crc_full the crc32c() value of
- *	   seq_full, then crc_full == crc32c_combine(crc1, crc2, len2) when
- *	   crc_full was seeded with the same initializer as crc1, and crc2 seed
- *	   was 0. See also crc_combine_test().
- */
-static inline u32 crc32c_combine(u32 crc1, u32 crc2, size_t len2)
-{
-	return crc32c_shift(crc1, len2) ^ crc2;
-}
-
 #define crc32(seed, data, length)  crc32_le(seed, (unsigned char const *)(data), length)
 
 /*
  * Helpers for hash table generation of ethernet nics:
  *
diff --git a/lib/crc32.c b/lib/crc32.c
index fddd424ff224..ade48bbb0083 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -117,16 +117,10 @@ u32 crc32_le_shift(u32 crc, size_t len)
 {
 	return crc32_generic_shift(crc, len, CRC32_POLY_LE);
 }
 EXPORT_SYMBOL(crc32_le_shift);
 
-u32 crc32c_shift(u32 crc, size_t len)
-{
-	return crc32_generic_shift(crc, len, CRC32C_POLY_LE);
-}
-EXPORT_SYMBOL(crc32c_shift);
-
 u32 crc32_be_base(u32 crc, const u8 *p, size_t len)
 {
 	while (len--)
 		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
 	return crc;
diff --git a/lib/tests/crc_kunit.c b/lib/tests/crc_kunit.c
index 585c48b65cef..064c2d581557 100644
--- a/lib/tests/crc_kunit.c
+++ b/lib/tests/crc_kunit.c
@@ -389,21 +389,15 @@ static void crc32_be_benchmark(struct kunit *test)
 static u64 crc32c_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc32c(crc, p, len);
 }
 
-static u64 crc32c_combine_wrapper(u64 crc1, u64 crc2, size_t len2)
-{
-	return crc32c_combine(crc1, crc2, len2);
-}
-
 static const struct crc_variant crc_variant_crc32c = {
 	.bits = 32,
 	.le = true,
 	.poly = 0x82f63b78,
 	.func = crc32c_wrapper,
-	.combine_func = crc32c_combine_wrapper,
 };
 
 static void crc32c_test(struct kunit *test)
 {
 	crc_test(test, &crc_variant_crc32c);
-- 
2.49.0


