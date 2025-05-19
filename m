Return-Path: <linux-sctp+bounces-533-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA8ABC5F2
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F643B1D56
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4C288CAE;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETkvhMyz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1C288C8A;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677117; cv=none; b=Z2pMDMNX/DncoOI9XarX2+KiE+1B2vImjv1jJjlQ2No66b8sVYoYnUBg5PwpNkvcDqy4fSlNTq6A6Wu+MgQFX5E3CpAyX5U0DEq9p1zlGH8JOkyU8pal9HXBrIVY52f1qYBWkBNBKkIbHrUj+dWAQJ9aeTB6/wQhQknTL3gpsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677117; c=relaxed/simple;
	bh=HUzbwNVRvrtqASUz0MiDlh5yFYtIHGu8zQ8EoJJzhm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4+7KPHuoU3YNSrlqt17vjHvCnYu3UMRrOwT/515q8kMNJ1C1hwt17mZBC5TGNclQbxOgSfaERpOjiyx8Ib25fuxLC/I4WasKPkXjykCPD5achBi+s6IFpSRekiA96zrYviPNlwIsz0oiZa0HsKqB90wyG9n2cEqoCrdVRlKrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETkvhMyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004ADC4CEE4;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677117;
	bh=HUzbwNVRvrtqASUz0MiDlh5yFYtIHGu8zQ8EoJJzhm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETkvhMyzboMhacPdNyumj17YtYzcsaWXVZG9idr9C+sX7gyBNK74FR5xT2D5k8UJA
	 dc76liUjUB3qpNRyOzUzQozlSMqR2brpk8OP5yfRgyF9BVEln8Mj1CFjoCxaEjXoxw
	 tcHFu6VZFi/i9e3vJMc0mY5ugdTvkBLSu4y5MabuCF2Ec5ykXaZNz+d+PhGveAkf2P
	 /fDIfGf9HoVYBua+CouMubyvN1DPLzuEdEZfrH6x2C+Dei/IthncDLd0Ex2ewkDhLG
	 0oUWMvMhM1j/ICcVFRuVZFfHjCg9SuldGnLWbw65+OLnkiZSemBsyy3h8HdvNoSdb7
	 9b4LQcCl/arPA==
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
Subject: [PATCH v2 02/10] net: add skb_crc32c()
Date: Mon, 19 May 2025 10:50:04 -0700
Message-ID: <20250519175012.36581-3-ebiggers@kernel.org>
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

Add skb_crc32c(), which calculates the CRC32C of a sk_buff.  It will
replace __skb_checksum(), which unnecessarily supports arbitrary
checksums.  Compared to __skb_checksum(), skb_crc32c():

   - Uses the correct type for CRC32C values (u32, not __wsum).

   - Does not require the caller to provide a skb_checksum_ops struct.

   - Is faster because it does not use indirect calls and does not use
     the very slow crc32c_combine().

According to commit 2817a336d4d5 ("net: skb_checksum: allow custom
update/combine for walking skb") which added __skb_checksum(), the
original motivation for the abstraction layer was to avoid code
duplication for CRC32C and other checksums in the future.  However:

   - No additional checksums showed up after CRC32C.  __skb_checksum()
     is only used with the "regular" net checksum and CRC32C.

   - Indirect calls are expensive.  Commit 2544af0344ba ("net: avoid
     indirect calls in L4 checksum calculation") worked around this
     using the INDIRECT_CALL_1 macro. But that only avoided the indirect
     call for the net checksum, and at the cost of an extra branch.

   - The checksums use different types (__wsum and u32), causing casts
     to be needed.

   - It made the checksums of fragments be combined (rather than
     chained) for both checksums, despite this being highly
     counterproductive for CRC32C due to how slow crc32c_combine() is.
     This can clearly be seen in commit 4c2f24549644 ("sctp: linearize
     early if it's not GSO") which tried to work around this performance
     bug.  With a dedicated function for each checksum, we can instead
     just use the proper strategy for each checksum.

As shown by the following tables, the new function skb_crc32c() is
faster than __skb_checksum(), with the improvement varying greatly from
5% to 2500% depending on the case.  The largest improvements come from
fragmented packets, mainly due to eliminating the inefficient
crc32c_combine().  But linear packets are improved too, especially
shorter ones, mainly due to eliminating indirect calls.  These
benchmarks were done on AMD Zen 5.  On that CPU, Linux uses IBRS instead
of retpoline; an even greater improvement might be seen with retpoline:

    Linear sk_buffs

        Length in bytes    __skb_checksum cycles    skb_crc32c cycles
        ===============    =====================    =================
                     64                       43                   18
                    256                       94                   77
                   1420                      204                  161
                  16384                     1735                 1642

    Nonlinear sk_buffs (even split between head and one fragment)

        Length in bytes    __skb_checksum cycles    skb_crc32c cycles
        ===============    =====================    =================
                     64                      579                   22
                    256                      829                   77
                   1420                     1506                  194
                  16384                     4365                 1682

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 73 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c7397b17bb08e..7ccc6356acaca 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4201,10 +4201,11 @@ extern const struct skb_checksum_ops *crc32c_csum_stub __read_mostly;
 
 __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		      __wsum csum, const struct skb_checksum_ops *ops);
 __wsum skb_checksum(const struct sk_buff *skb, int offset, int len,
 		    __wsum csum);
+u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc);
 
 static inline void * __must_check
 __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 		     const void *data, int hlen, void *buffer)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4159107f1666c..94b977db47f9d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -62,10 +62,11 @@
 #include <linux/bitfield.h>
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/crc32.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/checksum.h>
@@ -3631,10 +3632,82 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 	BUG_ON(len);
 	return csum;
 }
 EXPORT_SYMBOL(skb_copy_and_csum_bits);
 
+#ifdef CONFIG_NET_CRC32C
+u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
+{
+	int start = skb_headlen(skb);
+	int i, copy = start - offset;
+	struct sk_buff *frag_iter;
+
+	if (copy > 0) {
+		copy = min(copy, len);
+		crc = crc32c(crc, skb->data + offset, copy);
+		len -= copy;
+		if (len == 0)
+			return crc;
+		offset += copy;
+	}
+
+	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
+		return 0;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end;
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		WARN_ON(start > offset + len);
+
+		end = start + skb_frag_size(frag);
+		copy = end - offset;
+		if (copy > 0) {
+			u32 p_off, p_len, copied;
+			struct page *p;
+			u8 *vaddr;
+
+			copy = min(copy, len);
+			skb_frag_foreach_page(frag,
+					      skb_frag_off(frag) + offset - start,
+					      copy, p, p_off, p_len, copied) {
+				vaddr = kmap_atomic(p);
+				crc = crc32c(crc, vaddr + p_off, p_len);
+				kunmap_atomic(vaddr);
+			}
+			len -= copy;
+			if (len == 0)
+				return crc;
+			offset += copy;
+		}
+		start = end;
+	}
+
+	skb_walk_frags(skb, frag_iter) {
+		int end;
+
+		WARN_ON(start > offset + len);
+
+		end = start + frag_iter->len;
+		copy = end - offset;
+		if (copy > 0) {
+			copy = min(copy, len);
+			crc = skb_crc32c(frag_iter, offset - start, copy, crc);
+			len -= copy;
+			if (len == 0)
+				return crc;
+			offset += copy;
+		}
+		start = end;
+	}
+	BUG_ON(len);
+
+	return crc;
+}
+EXPORT_SYMBOL(skb_crc32c);
+#endif /* CONFIG_NET_CRC32C */
+
 __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
 {
 	__sum16 sum;
 
 	sum = csum_fold(skb_checksum(skb, 0, len, skb->csum));
-- 
2.49.0


