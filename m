Return-Path: <linux-sctp+bounces-497-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B002BAB25E6
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FB8460421
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9F8199FA2;
	Sun, 11 May 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ45jumq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD961922C4;
	Sun, 11 May 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924096; cv=none; b=L6uEZLsZzg/ftHvbWQ+iMJgf0P3QWRcEgpd4239xW20ZwklvomZbyIzan/m4zmH3uEdBBqxoeJWfCPs8HCizcIhboKk2oN+vQtv9zqyG46xqIR1XRbiN+O8Q7pep7Ea6fsmruXvNGPPJL3fLH6KV5E9Y3f1S+FfsUsY6f4qQzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924096; c=relaxed/simple;
	bh=/A9NtJJ0pcYSzi7Q5tbR5gfyPyk7AS4gT0Xn3zsrRXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2KgJ7S6Y7EcI3pkhQgadH3d804VslCoQZUiGnzLIuVJ5WEWLZBbdZuMn97cvZvotfQcVOpxdheGsBdf5NE+FoKlWdrVjFwBXCihufit8TeaYuCDDrDfd5GoYps101Up8WmRsD8BFf3QB49+5OjB5/84TIPceDIuiGY2VPKeLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ45jumq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9761C4CEEF;
	Sun, 11 May 2025 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924095;
	bh=/A9NtJJ0pcYSzi7Q5tbR5gfyPyk7AS4gT0Xn3zsrRXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQ45jumq+j1KKVo/UHlGTJd20e4DFKDf4HDb7zNpC1qGye2USU/ef8NjVPsV0T14A
	 M4jug2r/Yq+VOS1fGQCxzyXAYoyoevhEV9K80h9QVcttRSXM+iMcoZJkQbp9lQCszx
	 ITOq1tQ3BQYVL+VjDTaZbvKR9A2dg1fYJ5d3vWpy6ATm10LTVbR11DIvSHr7zk/FXp
	 +7hSbi+HClEtL8cFGC8eYxB7glmb8eNbM/ZqywcVrB8xrRphB55w2ygtQI4t75sOh3
	 GFOjOLIPmoXEpUY7A2BNrk9RdobQ6OX+wMc9mDAWhkfGgZVv65FSbPiSRRJoeuttck
	 6zPsnrLDxUwaw==
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
Subject: [PATCH net-next 06/10] net: fold __skb_checksum() into skb_checksum()
Date: Sat, 10 May 2025 17:41:06 -0700
Message-ID: <20250511004110.145171-7-ebiggers@kernel.org>
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
index 33b33bb18aa6..eac5c8dde4a5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4181,19 +4181,10 @@ static inline int memcpy_from_msg(void *data, struct msghdr *msg, int len)
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
index 243f972267b8..e57986b173f8 100644
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
index b9900cc16a24..bfa892ccc7f7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3438,24 +3438,22 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len)
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
@@ -3481,17 +3479,13 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 
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
@@ -3508,14 +3502,13 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
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
@@ -3523,22 +3516,10 @@ __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
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
@@ -3758,36 +3739,10 @@ __sum16 __skb_checksum_complete(struct sk_buff *skb)
 
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


