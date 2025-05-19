Return-Path: <linux-sctp+bounces-538-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E0ABC607
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E101B602E4
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955E28A1C8;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0fI/+ym"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74110289E29;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677119; cv=none; b=D0ThWG52DktPbIR/wno7HwdPWcCk2+qf8YpqXgxA1wf5Zz4bWot3qHnMV6zpwnF8anMxpoe1kQaCzHyBHHwcsSZbX5A40jQPMK6reBHzY0bI9S41QxL4Y/gOODAXOhNkJfbk5fh5INizafCEjieONRX0THyTpliUE7fKJmNlMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677119; c=relaxed/simple;
	bh=Oo53xf+vPT0XtWshqsuhuWmUJl5Op5w9Tt26Wx4wMsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIZkj2tBbth8SWRAgZ/GEyvJZ8fbyxdD8a4y5ALeK9MffmQLlVuH83EKYLcGj9kUvZsEM3PyuatDmFXvTBUljzHnjR6GQl/1+rrt3lYDa9pXtQrCHxNAS/JGBYbfdEQOxaC1Rb7OIpcJ/OghCDPWy02RZNoHwyFnc8mTaT+1TWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0fI/+ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503EC4CEED;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677119;
	bh=Oo53xf+vPT0XtWshqsuhuWmUJl5Op5w9Tt26Wx4wMsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0fI/+ymiRyCNifQz3w6CL5IrooEnfvl2XmRIp3GzU7Uz8tECZaFU1C7/yjE2x3Rx
	 mASFqRafI7kBpTNDdValHZy34XNWOpD0q3sotIZDeRlQDTNXCCeV4eqW8z0W6q0z+F
	 SDZwVRBuBKNvMa+bbsxIGADFCF44JFhMEncbJGaHI0xKPFWTyKh1x89MqZNqMipAcp
	 Qpe3UCxUO1Y1C2PnUYb1CjDycIIx8k1f80NKyxJEfIcwyv/7qEZYJsR4DndwJVxDd7
	 bP+Kl7+W4R3CAIxaQB0LZpz7AMzodl6esgFeBDGYtcrhKTdggH3HQN2XJAHhyUJ9YA
	 yCj6Pu/KIIdYQ==
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
Subject: [PATCH v2 07/10] lib/crc32: remove unused support for CRC32C combination
Date: Mon, 19 May 2025 10:50:09 -0700
Message-ID: <20250519175012.36581-8-ebiggers@kernel.org>
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
index 69c2e8bb37829..7f7d0be8a0acc 100644
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
index fddd424ff2245..ade48bbb00834 100644
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
index 585c48b65cefd..064c2d5815579 100644
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


