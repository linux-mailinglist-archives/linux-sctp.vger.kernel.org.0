Return-Path: <linux-sctp+bounces-537-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDAABC601
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7880A1727D7
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B4289E0B;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqDgCFHe"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8A289826;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677119; cv=none; b=fR1LQ3uGBiY1fJmMVBqywbVk2UssKEbYug0UpCSIj9eDmdyQCdaU/VyMNkqHzaAfcUNCFX5d9fe2aAy7xdje6rYY3k69fmyeJyyQr64Sy/LqeSkdK5ZplMl+1jtpuGBuMYPxY0DrpZOTjRQs73t4r+W7FLVHM1//vFSnqcqWz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677119; c=relaxed/simple;
	bh=9W6A/eAI/6T9jjyybm1nmFEiGSJ8YHRariNqFak7k5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFvJPgSq9m0BejEEATnnhvU9L1u/uR3UdXrRW7DZNbcn3fSQ2Td/S4ROO3918z9CiolD7gz6cQeSYOgSNzW6SFRmdHRodleWDnYl7+b7Xd1v9kGM/dDmJVwofsmqeMBE/OLUIMNHMDo9UVMjNOLwy20/rttGLkNneTSbUVn31Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqDgCFHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12ECC4CEEB;
	Mon, 19 May 2025 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677118;
	bh=9W6A/eAI/6T9jjyybm1nmFEiGSJ8YHRariNqFak7k5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqDgCFHe8B1mn5iXFFjbvnu0VTeibtAMAGGfbkUHmpP7Q7Z1c3PP00hxMn5pp4WSg
	 3IMqnhfcPeQsfYb/NqBJgwYBrnNc9lz3LSFHVUzQvQ1lHjgqJC9X/ByN9wYtC4sjnx
	 SCuMMmkVH36210UXmI7/b9ZmiudEil9YC9ev0e+Rb7ZuZkNkd1F1YGYVROgxSnrlNw
	 3/sO4HKDQtLo28wVhHc4quW//i/ZhOToGftyUMmtdZ+KnaX310Qv5Lrw9C2mUimJbj
	 h89YDlxguBIjMBjbWRQmFNXj8nqd9cFWKCna2NSieZe1VW9b1ZiAAa8i3+1qQmQZsk
	 lPivyl4aEPijQ==
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
Subject: [PATCH v2 06/10] net: fold __skb_checksum() into skb_checksum()
Date: Mon, 19 May 2025 10:50:08 -0700
Message-ID: <20250519175012.36581-7-ebiggers@kernel.org>
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

Now that the only remaining caller of __skb_checksum() is
skb_checksum(), fold __skb_checksum() into skb_checksum().  This makes
struct skb_checksum_ops unnecessary, so remove that too and simply do
the "regular" net checksum.  It also makes the wrapper functions
csum_partial_ext() and csum_block_add_ext() unnecessary, so remove those
too and just use the underlying functions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  9 -------
 include/net/checksum.h | 12 ---------
 net/core/skbuff.c      | 59 +++++-------------------------------------
 3 files changed, 7 insertions(+), 73 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7ccc6356acaca..018c072305133 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4190,19 +4190,10 @@ static inline int memcpy_from_msg(void *data, struct msghdr *msg, int len)
 static inline int memcpy_to_msg(struct msghdr *msg, void *data, int len)
 {
 	return copy_to_iter(data, len, &msg->msg_iter) == len ? 0 : -EFAULT;
 }
 
-struct skb_checksum_ops {
-	__wsum (*update)(const void *mem, int len, __wsum wsum);
-	__wsum (*combine)(__wsum csum, __wsum csum2, int offset, int len);
-};
-
-extern const struct skb_checksum_ops *crc32c_csum_stub __read_mostly;
-
-__wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
-		      __wsum csum, const struct skb_checksum_ops *ops);
 __wsum skb_checksum(const struct sk_buff *skb, int offset, int len,
 		    __wsum csum);
 u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc);
 
 static inline void * __must_check
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 243f972267b8d..e57986b173f8e 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -96,16 +96,10 @@ static __always_inline __wsum
 csum_block_add(__wsum csum, __wsum csum2, int offset)
 {
 	return csum_add(csum, csum_shift(csum2, offset));
 }
 
-static __always_inline __wsum
-csum_block_add_ext(__wsum csum, __wsum csum2, int offset, int len)
-{
-	return csum_block_add(csum, csum2, offset);
-}
-
 static __always_inline __wsum
 csum_block_sub(__wsum csum, __wsum csum2, int offset)
 {
 	return csum_block_add(csum, ~csum2, offset);
 }
@@ -113,16 +107,10 @@ csum_block_sub(__wsum csum, __wsum csum2, int offset)
 static __always_inline __wsum csum_unfold(__sum16 n)
 {
 	return (__force __wsum)n;
 }
 
-static __always_inline
-__wsum csum_partial_ext(const void *buff, int len, __wsum sum)
-{
-	return csum_partial(buff, len, sum);
-}
-
 #define CSUM_MANGLED_0 ((__force __sum16)0xffff)
 
 static __always_inline void csum_replace_by_diff(__sum16 *sum, __wsum diff)
 {
 	*sum = csum_fold(csum_add(diff, ~csum_unfold(*sum)));
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 94b977db47f9d..85fc82f72d268 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3443,24 +3443,22 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(skb_store_bits);
 
 /* Checksum skb data. */
-__wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
-		      __wsum csum, const struct skb_checksum_ops *ops)
+__wsum skb_checksum(const struct sk_buff *skb, int offset, int len, __wsum csum)
 {
 	int start = skb_headlen(skb);
 	int i, copy = start - offset;
 	struct sk_buff *frag_iter;
 	int pos = 0;
 
 	/* Checksum header. */
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
-		csum = INDIRECT_CALL_1(ops->update, csum_partial_ext,
-				       skb->data + offset, copy, csum);
+		csum = csum_partial(skb->data + offset, copy, csum);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
 		pos	= copy;
 	}
@@ -3486,17 +3484,13 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 
 			skb_frag_foreach_page(frag,
 					      skb_frag_off(frag) + offset - start,
 					      copy, p, p_off, p_len, copied) {
 				vaddr = kmap_atomic(p);
-				csum2 = INDIRECT_CALL_1(ops->update,
-							csum_partial_ext,
-							vaddr + p_off, p_len, 0);
+				csum2 = csum_partial(vaddr + p_off, p_len, 0);
 				kunmap_atomic(vaddr);
-				csum = INDIRECT_CALL_1(ops->combine,
-						       csum_block_add_ext, csum,
-						       csum2, pos, p_len);
+				csum = csum_block_add(csum, csum2, pos);
 				pos += p_len;
 			}
 
 			if (!(len -= copy))
 				return csum;
@@ -3513,14 +3507,13 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		end = start + frag_iter->len;
 		if ((copy = end - offset) > 0) {
 			__wsum csum2;
 			if (copy > len)
 				copy = len;
-			csum2 = __skb_checksum(frag_iter, offset - start,
-					       copy, 0, ops);
-			csum = INDIRECT_CALL_1(ops->combine, csum_block_add_ext,
-					       csum, csum2, pos, copy);
+			csum2 = skb_checksum(frag_iter, offset - start, copy,
+					     0);
+			csum = csum_block_add(csum, csum2, pos);
 			if ((len -= copy) == 0)
 				return csum;
 			offset += copy;
 			pos    += copy;
 		}
@@ -3528,22 +3521,10 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 	}
 	BUG_ON(len);
 
 	return csum;
 }
-EXPORT_SYMBOL(__skb_checksum);
-
-__wsum skb_checksum(const struct sk_buff *skb, int offset,
-		    int len, __wsum csum)
-{
-	const struct skb_checksum_ops ops = {
-		.update  = csum_partial_ext,
-		.combine = csum_block_add_ext,
-	};
-
-	return __skb_checksum(skb, offset, len, csum, &ops);
-}
 EXPORT_SYMBOL(skb_checksum);
 
 /* Both of above in one bottle. */
 
 __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
@@ -3763,36 +3744,10 @@ __sum16 __skb_checksum_complete(struct sk_buff *skb)
 
 	return sum;
 }
 EXPORT_SYMBOL(__skb_checksum_complete);
 
-static __wsum warn_crc32c_csum_update(const void *buff, int len, __wsum sum)
-{
-	net_warn_ratelimited(
-		"%s: attempt to compute crc32c without libcrc32c.ko\n",
-		__func__);
-	return 0;
-}
-
-static __wsum warn_crc32c_csum_combine(__wsum csum, __wsum csum2,
-				       int offset, int len)
-{
-	net_warn_ratelimited(
-		"%s: attempt to compute crc32c without libcrc32c.ko\n",
-		__func__);
-	return 0;
-}
-
-static const struct skb_checksum_ops default_crc32c_ops = {
-	.update  = warn_crc32c_csum_update,
-	.combine = warn_crc32c_csum_combine,
-};
-
-const struct skb_checksum_ops *crc32c_csum_stub __read_mostly =
-	&default_crc32c_ops;
-EXPORT_SYMBOL(crc32c_csum_stub);
-
  /**
  *	skb_zerocopy_headlen - Calculate headroom needed for skb_zerocopy()
  *	@from: source buffer
  *
  *	Calculates the amount of linear headroom needed in the 'to' skb passed
-- 
2.49.0


