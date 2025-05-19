Return-Path: <linux-sctp+bounces-539-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE5ABC608
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1316F1CB
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5628A41C;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq+0yzHg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CF28A404;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677120; cv=none; b=Rs3ad0ZcM8g75UazYj8VAOdK88InXgVgK61s2O1Fw4MHZ8WVTFRm4HZMZ/iCWm/EO+vHQ4HlCgpvymJpfOdXb6qwHduMRPuDrsH3yeTxCJplTCgssymvEarA9Urn6LFdqmk2jP3tLu/sSFgIuuMtACU7vfGQTKSUkNtPvuqUqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677120; c=relaxed/simple;
	bh=kKAbK/ihktd10bayLsP//PWEOGB9vYQ3zKxqoKSXAE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZEww7fP0IA7vGdjOFJyxIPnBNh9yU7BY2+V0Fe6lgbnj67BbsT7wTFopiCrFh/YFsnuGtjzCwdAk47AxZsrdOGpkNXMdgo4fOaBR7JxI5Om5OER0HjSTkVTmYtagRopXd/pICJMKY7LP50LpuRmjY0QADCdB3IEsN6L0wAyyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq+0yzHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D79C4CEF4;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677119;
	bh=kKAbK/ihktd10bayLsP//PWEOGB9vYQ3zKxqoKSXAE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oq+0yzHgg/BE5fx8mWtvGsUZsDNEl+TglApCHMhKrDLYo7bdS+pUHN2mZTrEmoPHR
	 IM5pPe9XgnOziiQyvPwuQmseGRtl4SiOwhx9anLsXUMc8AL78m1bT13Mmc0zn/wx5o
	 523Ppp6ZmG6Gr3yiwa3AARwmMKgGpu7K/ufv0sduClRfWk7uM4mP81MuC/e7DLyrg1
	 eTPJmldloKsrqZbFspNXjm32F9V3C72jFsShlXfO3eQ4X7CpJoxLVybdT1lP5hDhSE
	 yug0J+IvMku+I7yPD/9hd2gS6l0LEACk5LD0XXVtvVf9oWTOSAssUAfQTi7NQneTDb
	 kFTNIJa5EehDg==
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
Subject: [PATCH v2 08/10] net: add skb_copy_and_crc32c_datagram_iter()
Date: Mon, 19 May 2025 10:50:10 -0700
Message-ID: <20250519175012.36581-9-ebiggers@kernel.org>
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

Since skb_copy_and_hash_datagram_iter() is used only with CRC32C, the
crypto_ahash abstraction provides no value.  Add
skb_copy_and_crc32c_datagram_iter() which just calls crc32c() directly.

This is faster and simpler.  It also doesn't have the weird dependency
issue where skb_copy_and_hash_datagram_iter() depends on
CONFIG_CRYPTO_HASH=y without that being expressed explicitly in the
kconfig (presumably because it was too heavyweight for NET to select).
The new function is conditional on the hidden boolean symbol NET_CRC32C,
which selects CRC32.  So it gets compiled only when something that
actually needs CRC32C packet checksums is enabled, it has no implicit
dependency, and it doesn't depend on the heavyweight crypto layer.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/datagram.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 018c072305133..510adf63c2113 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4135,10 +4135,12 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
 int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct iov_iter *to, int len,
 			   struct ahash_request *hash);
+int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
+				      struct iov_iter *to, int len, u32 *crcp);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 9ef5442536f59..fa87abb666324 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -50,10 +50,11 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/iov_iter.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/crc32.h>
 
 #include <net/protocol.h>
 #include <linux/skbuff.h>
 
 #include <net/checksum.h>
@@ -517,10 +518,42 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 	return __skb_datagram_iter(skb, offset, to, len, true,
 			hash_and_copy_to_iter, hash);
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
 
+#ifdef CONFIG_NET_CRC32C
+static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
+				      void *_crcp, struct iov_iter *i)
+{
+	u32 *crcp = _crcp;
+	size_t copied;
+
+	copied = copy_to_iter(addr, bytes, i);
+	*crcp = crc32c(*crcp, addr, copied);
+	return copied;
+}
+
+/**
+ *	skb_copy_and_crc32c_datagram_iter - Copy datagram to an iovec iterator
+ *		and update a CRC32C value.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ *	@crcp: pointer to CRC32C value to update
+ *
+ *	Return: 0 on success, -EFAULT if there was a fault during copy.
+ */
+int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
+				      struct iov_iter *to, int len, u32 *crcp)
+{
+	return __skb_datagram_iter(skb, offset, to, len, true,
+				   crc32c_and_copy_to_iter, crcp);
+}
+EXPORT_SYMBOL(skb_copy_and_crc32c_datagram_iter);
+#endif /* CONFIG_NET_CRC32C */
+
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
 	return copy_to_iter(addr, bytes, i);
 }
-- 
2.49.0


