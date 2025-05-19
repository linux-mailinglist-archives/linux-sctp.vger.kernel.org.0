Return-Path: <linux-sctp+bounces-540-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12873ABC630
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114987AA9E9
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F028A73B;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR2+iVWK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7628A719;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677120; cv=none; b=Gn3COtg7/ImEVRwqqEemI7jkV4tgk300/BF/TngsQqHT8zZCoFweVUTO5CS0ouLxXn92Lvu6NTPngHRf0ivbtqvporiF7NjzL5rXNGhocy+QQUMl6LOkvuJFkOWnWuGRG2zvcioAUxWs+wfkA7hvon+jtG0TRRrxvhRdtKNtg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677120; c=relaxed/simple;
	bh=mIsfiVI45v2VPTWBozlSjRtw4VqrI/GcVcTcOwb4ZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dev2BLGtVx1kP7FXZZDS+bsr18pP2pw5AukOizD9jk5qfoJoQIvUMbWmay25ANl9oyKKiWPpn5aqyzWFtZdRzZ3I0/JL4EwYHXqwMFPVuY9ZsN36cxWNBv5jAC+f7ahbmQ/1P4BIGgR5Qwxriz1E2JXHW0Fgdo1FRo0IWpaZOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR2+iVWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F53C4CEF1;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677120;
	bh=mIsfiVI45v2VPTWBozlSjRtw4VqrI/GcVcTcOwb4ZRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QR2+iVWKJqeHqPio6M358dZ6cQUWbOX/PBRAO2eoWIddik+He5js4DXnq6aqPbeYC
	 6x+To/VR2K2WcczMELmWTmH2uhqmvKf9Ge4oKVWuJrZhPiZgZ4xAl34/1FENmTSEIe
	 P5c8E3xZSsSx+Et92DossoX9+FwAlX7/23r2kUxcCQ9eiNGcjZH6nAgYvrI9UZxBmB
	 qKSfwx/i2h7c5g7THDj7SPzNsg2zNqCqQVmW9CB5Ay+YoFCZbrvUXZ021BFfmkpBSD
	 V+155XQBuNbNnmaTsxGZ08hIfgzf+MmGtyY1z1ND0UtLvq/iYbjAf8ccvf2cPmNuRw
	 3/bMDyqVcqqiw==
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
Subject: [PATCH v2 10/10] net: remove skb_copy_and_hash_datagram_iter()
Date: Mon, 19 May 2025 10:50:12 -0700
Message-ID: <20250519175012.36581-11-ebiggers@kernel.org>
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

Now that skb_copy_and_hash_datagram_iter() is no longer used, remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  4 ----
 net/core/datagram.c    | 37 -------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 510adf63c2113..5520524c93bff 100644
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
@@ -4132,13 +4131,10 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
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
index fa87abb666324..b352a10093041 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -60,11 +60,10 @@
 #include <net/checksum.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
-#include <crypto/hash.h>
 
 #include "devmem.h"
 
 /*
  *	Is a socket 'connection oriented' ?
@@ -482,46 +481,10 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
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


