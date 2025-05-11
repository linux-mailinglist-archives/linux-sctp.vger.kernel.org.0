Return-Path: <linux-sctp+bounces-501-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68DEAB25F8
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 02:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AD416ADDC
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 00:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955DD1DB154;
	Sun, 11 May 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZOX/xwM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641521D5CEA;
	Sun, 11 May 2025 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924100; cv=none; b=r/6bnBbgkWuaxqmaoQoQEXLJM/FU1DjZMp4VQWyRVbB9+plvKIlUbXZdpnCOdUJxMQdWDlqNr1nOQZc3k2qc58lulGyCwdgBg6r1Vb5Y6GywTuysjKLQvtj0fshzqLILlZfYACotvjYAwnjqx1XKbi/y9h85m919gtUtCcqDVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924100; c=relaxed/simple;
	bh=1M/Uxj/GlzhwSrBWvWBpAp/iDXzpGWDqYvfOyMyRoL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIwBYzN1AFi5rP+szGhrwM50ZLt2qU/Icspw8rgQFxkCcHeVIsJzrQt0zT1FhN0b2B4IiKLYHsc386UGvrkPdfNmfkBQAOo2ahP1wOth7LbfK4QYFK0YiACVk9m/gQnT69O2BU3IqM9AHwZnuht0sGmcnC2kcNQd0u+hQfAAtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZOX/xwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631B4C4CEEE;
	Sun, 11 May 2025 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924100;
	bh=1M/Uxj/GlzhwSrBWvWBpAp/iDXzpGWDqYvfOyMyRoL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZOX/xwMxCnXrfMk9nmIM7VO+YI5DMYHUfROWZ/IvYpTGiJ3pS0j87VESZ6xW8kOs
	 A5uDYUAkFqYXzdpzyeng1AI6bchZZ6NmZKvS5t+WQWxNXX9a2yGCpeNKC8dB71eEyX
	 GpBvoEOACOz2AHtm9Y+hBGYNuikSYitAsXa0DpuuiD7xNb3RoKA2jsehoXky/JTvYR
	 9ptSMpk7mJu4rh3cg/h/r5l042QmusHMbSP5ulzjQMAZBc+UgSwtrcAPi714mInHtX
	 pi7Sqjxuu46+6wuIByHBS6WbVlsJnhDjcQ9CjSpFgfjY3DB5BlAaLJ3tFUyehKvot8
	 258DbM8dcgFoA==
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
Subject: [PATCH net-next 10/10] net: remove skb_copy_and_hash_datagram_iter()
Date: Sat, 10 May 2025 17:41:10 -0700
Message-ID: <20250511004110.145171-11-ebiggers@kernel.org>
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

Now that skb_copy_and_hash_datagram_iter() is no longer used, remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  4 ----
 net/core/datagram.c    | 37 -------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0027f2977c02..98cecd3a2fb8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -272,11 +272,10 @@
 /* return minimum truesize of one skb containing X bytes of data */
 #define SKB_TRUESIZE(X) ((X) +						\
 			 SKB_DATA_ALIGN(sizeof(struct sk_buff)) +	\
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
-struct ahash_request;
 struct net_device;
 struct scatterlist;
 struct pipe_inode_info;
 struct iov_iter;
 struct napi_struct;
@@ -4123,13 +4122,10 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 {
 	return skb_copy_datagram_iter(from, offset, &msg->msg_iter, size);
 }
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
-int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
-			   struct iov_iter *to, int len,
-			   struct ahash_request *hash);
 int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 				      struct iov_iter *to, int len, u32 *crcp);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 47a6eef83162..b83731f11fad 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -60,11 +60,10 @@
 #include <net/checksum.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
-#include <crypto/hash.h>
 
 /*
  *	Is a socket 'connection oriented' ?
  */
 static inline int connection_based(struct sock *sk)
@@ -480,46 +479,10 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 		goto fault;
 
 	return 0;
 }
 
-static size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
-				    struct iov_iter *i)
-{
-#ifdef CONFIG_CRYPTO_HASH
-	struct ahash_request *hash = hashp;
-	struct scatterlist sg;
-	size_t copied;
-
-	copied = copy_to_iter(addr, bytes, i);
-	sg_init_one(&sg, addr, copied);
-	ahash_request_set_crypt(hash, &sg, NULL, copied);
-	crypto_ahash_update(hash);
-	return copied;
-#else
-	return 0;
-#endif
-}
-
-/**
- *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
- *          and update a hash.
- *	@skb: buffer to copy
- *	@offset: offset in the buffer to start copying from
- *	@to: iovec iterator to copy to
- *	@len: amount of data to copy from buffer to iovec
- *      @hash: hash request to update
- */
-int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
-			   struct iov_iter *to, int len,
-			   struct ahash_request *hash)
-{
-	return __skb_datagram_iter(skb, offset, to, len, true,
-			hash_and_copy_to_iter, hash);
-}
-EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
-
 #ifdef CONFIG_NET_CRC32C
 static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
 				      void *_crcp, struct iov_iter *i)
 {
 	u32 *crcp = _crcp;
-- 
2.49.0


