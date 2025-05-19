Return-Path: <linux-sctp+bounces-541-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFEEABC60D
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70E21B64E49
	for <lists+linux-sctp@lfdr.de>; Mon, 19 May 2025 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6328A73E;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldxK9dw+"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAB28A715;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677120; cv=none; b=VRqzSNTa6K6na7L8fY0qjAue1QBllY6BQoZVNb1D2QrSSQ+tyJW0xvB04kscRT4tMmDdBQL+T/3tqE3Z3kJFA1kiycZdqhS6t4VDs7eYQ4CDTAKt9ZTkhDUBGrtpBO89cJW2Or7simUPGM4ew31ZbKH7jWxHXfw8uXuGTv4ED80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677120; c=relaxed/simple;
	bh=wJP8T2TD425wEzkz5/xhkjJMoKHuDj15HpiXYQizJiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXu03Akij/NjCjPUqvDCg/8owjvh3fsThTPUNFrce2BmAHXcG+QPxkXCOSGf8Mw0OBqMgekGbUm/gaq19SN6h4mB2MjdAIipWbXCc5mJPSNJSIrGKprFCcYpUbjc45lofuFT6aexpQWSZifiSbb6Hhg1Cc0PDLN6ag3MnSW2tgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldxK9dw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6F8C4CEE4;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677120;
	bh=wJP8T2TD425wEzkz5/xhkjJMoKHuDj15HpiXYQizJiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldxK9dw+qB9yi477JSw2w62fHlbk+gbZMw5KHZGuCRbcKH7ZHuarO18o7Z5CQVX+i
	 DXnnJIPe2FutEnBkG3o08O3jtiue2nXCme3gL048jTSo9xCg9h56VJ9NUXOX5Cngv/
	 tJn83pA2xTK0JXBFODyuldig4BYNp17Z4H6eJpMWPOlebzI1XPotGsZaRLmmBhShyr
	 1ke5xpA0iwQLzDw2Pzy9O1S/5zgQr1b8jmT9XHNHh5hiuW+MOfKrvpq7WbEbWBbvMq
	 TKAdtL+F04l2NfH6gTq+IOVruGhxu2a49bWNBeIgeJXYhjP2sIe5O4jpLIcZ7HZ5sx
	 tNTESKaHzeIEQ==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/10] nvme-tcp: use crc32c() and skb_copy_and_crc32c_datagram_iter()
Date: Mon, 19 May 2025 10:50:11 -0700
Message-ID: <20250519175012.36581-10-ebiggers@kernel.org>
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

Now that the crc32c() library function directly takes advantage of
architecture-specific optimizations and there also now exists a function
skb_copy_and_crc32c_datagram_iter(), it is unnecessary to go through the
crypto_ahash API.  Just use those functions.  This is much simpler, and
it also improves performance due to eliminating the crypto API overhead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/nvme/host/Kconfig |   4 +-
 drivers/nvme/host/tcp.c   | 124 ++++++++++++--------------------------
 2 files changed, 42 insertions(+), 86 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 4d64b6935bb91..7dca58f0a237b 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -82,13 +82,13 @@ config NVME_FC
 
 config NVME_TCP
 	tristate "NVM Express over Fabrics TCP host driver"
 	depends on INET
 	depends on BLOCK
+	select CRC32
+	select NET_CRC32C
 	select NVME_FABRICS
-	select CRYPTO
-	select CRYPTO_CRC32C
 	help
 	  This provides support for the NVMe over Fabrics protocol using
 	  the TCP transport.  This allows you to use remote block devices
 	  exported using the NVMe protocol set.
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index aba365f97cf6b..8ae6cc2280caa 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -6,19 +6,19 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/blk-mq.h>
-#include <crypto/hash.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -166,12 +166,12 @@ struct nvme_tcp_queue {
 	bool			rd_enabled;
 
 	bool			hdr_digest;
 	bool			data_digest;
 	bool			tls_enabled;
-	struct ahash_request	*rcv_hash;
-	struct ahash_request	*snd_hash;
+	u32			rcv_crc;
+	u32			snd_crc;
 	__le32			exp_ddgst;
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
 	int                     tls_err;
 	struct page_frag_cache	pf_cache;
@@ -454,36 +454,42 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 
 	list_del(&req->entry);
 	return req;
 }
 
-static inline void nvme_tcp_ddgst_final(struct ahash_request *hash,
-		__le32 *dgst)
+#define NVME_TCP_CRC_SEED (~0)
+
+static inline void nvme_tcp_ddgst_update(u32 *crcp,
+		struct page *page, size_t off, size_t len)
 {
-	ahash_request_set_crypt(hash, NULL, (u8 *)dgst, 0);
-	crypto_ahash_final(hash);
+	page += off / PAGE_SIZE;
+	off %= PAGE_SIZE;
+	while (len) {
+		const void *vaddr = kmap_local_page(page);
+		size_t n = min(len, (size_t)PAGE_SIZE - off);
+
+		*crcp = crc32c(*crcp, vaddr + off, n);
+		kunmap_local(vaddr);
+		page++;
+		off = 0;
+		len -= n;
+	}
 }
 
-static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
-		struct page *page, off_t off, size_t len)
+static inline __le32 nvme_tcp_ddgst_final(u32 crc)
 {
-	struct scatterlist sg;
-
-	sg_init_table(&sg, 1);
-	sg_set_page(&sg, page, len, off);
-	ahash_request_set_crypt(hash, &sg, NULL, len);
-	crypto_ahash_update(hash);
+	return cpu_to_le32(~crc);
 }
 
-static inline void nvme_tcp_hdgst(struct ahash_request *hash,
-		void *pdu, size_t len)
+static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
 {
-	struct scatterlist sg;
+	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
+}
 
-	sg_init_one(&sg, pdu, len);
-	ahash_request_set_crypt(hash, &sg, pdu + len, len);
-	crypto_ahash_digest(hash);
+static inline void nvme_tcp_set_hdgst(void *pdu, size_t len)
+{
+	*(__le32 *)(pdu + len) = nvme_tcp_hdgst(pdu, len);
 }
 
 static int nvme_tcp_verify_hdgst(struct nvme_tcp_queue *queue,
 		void *pdu, size_t pdu_len)
 {
@@ -497,12 +503,11 @@ static int nvme_tcp_verify_hdgst(struct nvme_tcp_queue *queue,
 			nvme_tcp_queue_id(queue));
 		return -EPROTO;
 	}
 
 	recv_digest = *(__le32 *)(pdu + hdr->hlen);
-	nvme_tcp_hdgst(queue->rcv_hash, pdu, pdu_len);
-	exp_digest = *(__le32 *)(pdu + hdr->hlen);
+	exp_digest = nvme_tcp_hdgst(pdu, pdu_len);
 	if (recv_digest != exp_digest) {
 		dev_err(queue->ctrl->ctrl.device,
 			"header digest error: recv %#x expected %#x\n",
 			le32_to_cpu(recv_digest), le32_to_cpu(exp_digest));
 		return -EIO;
@@ -524,11 +529,11 @@ static int nvme_tcp_check_ddgst(struct nvme_tcp_queue *queue, void *pdu)
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d: data digest flag is cleared\n",
 		nvme_tcp_queue_id(queue));
 		return -EPROTO;
 	}
-	crypto_ahash_init(queue->rcv_hash);
+	queue->rcv_crc = NVME_TCP_CRC_SEED;
 
 	return 0;
 }
 
 static void nvme_tcp_exit_request(struct blk_mq_tag_set *set,
@@ -924,12 +929,12 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		/* we can read only from what is left in this bio */
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
 		if (queue->data_digest)
-			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
-				&req->iter, recv_len, queue->rcv_hash);
+			ret = skb_copy_and_crc32c_datagram_iter(skb, *offset,
+				&req->iter, recv_len, &queue->rcv_crc);
 		else
 			ret = skb_copy_datagram_iter(skb, *offset,
 					&req->iter, recv_len);
 		if (ret) {
 			dev_err(queue->ctrl->ctrl.device,
@@ -943,11 +948,11 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		queue->data_remaining -= recv_len;
 	}
 
 	if (!queue->data_remaining) {
 		if (queue->data_digest) {
-			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
+			queue->exp_ddgst = nvme_tcp_ddgst_final(queue->rcv_crc);
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 				nvme_tcp_end_request(rq,
 						le16_to_cpu(req->status));
@@ -1145,11 +1150,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		ret = sock_sendmsg(queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
 
 		if (queue->data_digest)
-			nvme_tcp_ddgst_update(queue->snd_hash, page,
+			nvme_tcp_ddgst_update(&queue->snd_crc, page,
 					offset, ret);
 
 		/*
 		 * update the request iterator except for the last payload send
 		 * in the request where we don't want to modify it as we may
@@ -1159,12 +1164,12 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 			nvme_tcp_advance_req(req, ret);
 
 		/* fully successful last send in current PDU */
 		if (last && ret == len) {
 			if (queue->data_digest) {
-				nvme_tcp_ddgst_final(queue->snd_hash,
-					&req->ddgst);
+				req->ddgst =
+					nvme_tcp_ddgst_final(queue->snd_crc);
 				req->state = NVME_TCP_SEND_DDGST;
 				req->offset = 0;
 			} else {
 				if (h2cdata_left)
 					nvme_tcp_setup_h2c_data_pdu(req);
@@ -1192,11 +1197,11 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 		msg.msg_flags |= MSG_MORE;
 	else
 		msg.msg_flags |= MSG_EOR;
 
 	if (queue->hdr_digest && !req->offset)
-		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		nvme_tcp_set_hdgst(pdu, sizeof(*pdu));
 
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
@@ -1205,11 +1210,11 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	len -= ret;
 	if (!len) {
 		if (inline_data) {
 			req->state = NVME_TCP_SEND_DATA;
 			if (queue->data_digest)
-				crypto_ahash_init(queue->snd_hash);
+				queue->snd_crc = NVME_TCP_CRC_SEED;
 		} else {
 			nvme_tcp_done_send_req(queue);
 		}
 		return 1;
 	}
@@ -1227,11 +1232,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
 
 	if (queue->hdr_digest && !req->offset)
-		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		nvme_tcp_set_hdgst(pdu, sizeof(*pdu));
 
 	if (!req->h2cdata_left)
 		msg.msg_flags |= MSG_SPLICE_PAGES;
 
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
@@ -1242,11 +1247,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 
 	len -= ret;
 	if (!len) {
 		req->state = NVME_TCP_SEND_DATA;
 		if (queue->data_digest)
-			crypto_ahash_init(queue->snd_hash);
+			queue->snd_crc = NVME_TCP_CRC_SEED;
 		return 1;
 	}
 	req->offset += ret;
 
 	return -EAGAIN;
@@ -1382,45 +1387,10 @@ static void nvme_tcp_io_work(struct work_struct *w)
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
-static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)
-{
-	struct crypto_ahash *tfm = crypto_ahash_reqtfm(queue->rcv_hash);
-
-	ahash_request_free(queue->rcv_hash);
-	ahash_request_free(queue->snd_hash);
-	crypto_free_ahash(tfm);
-}
-
-static int nvme_tcp_alloc_crypto(struct nvme_tcp_queue *queue)
-{
-	struct crypto_ahash *tfm;
-
-	tfm = crypto_alloc_ahash("crc32c", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	queue->snd_hash = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!queue->snd_hash)
-		goto free_tfm;
-	ahash_request_set_callback(queue->snd_hash, 0, NULL, NULL);
-
-	queue->rcv_hash = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!queue->rcv_hash)
-		goto free_snd_hash;
-	ahash_request_set_callback(queue->rcv_hash, 0, NULL, NULL);
-
-	return 0;
-free_snd_hash:
-	ahash_request_free(queue->snd_hash);
-free_tfm:
-	crypto_free_ahash(tfm);
-	return -ENOMEM;
-}
-
 static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
 {
 	struct nvme_tcp_request *async = &ctrl->async_req;
 
 	page_frag_free(async->pdu);
@@ -1449,13 +1419,10 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	unsigned int noreclaim_flag;
 
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
-	if (queue->hdr_digest || queue->data_digest)
-		nvme_tcp_free_crypto(queue);
-
 	page_frag_cache_drain(&queue->pf_cache);
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	/* ->sock will be released by fput() */
 	fput(queue->sock->file);
@@ -1865,25 +1832,17 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		}
 	}
 
 	queue->hdr_digest = nctrl->opts->hdr_digest;
 	queue->data_digest = nctrl->opts->data_digest;
-	if (queue->hdr_digest || queue->data_digest) {
-		ret = nvme_tcp_alloc_crypto(queue);
-		if (ret) {
-			dev_err(nctrl->device,
-				"failed to allocate queue %d crypto\n", qid);
-			goto err_sock;
-		}
-	}
 
 	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
 			nvme_tcp_hdgst_len(queue);
 	queue->pdu = kmalloc(rcv_pdu_size, GFP_KERNEL);
 	if (!queue->pdu) {
 		ret = -ENOMEM;
-		goto err_crypto;
+		goto err_sock;
 	}
 
 	dev_dbg(nctrl->device, "connecting queue %d\n",
 			nvme_tcp_queue_id(queue));
 
@@ -1912,13 +1871,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 err_init_connect:
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 err_rcv_pdu:
 	kfree(queue->pdu);
-err_crypto:
-	if (queue->hdr_digest || queue->data_digest)
-		nvme_tcp_free_crypto(queue);
 err_sock:
 	/* ->sock will be released by fput() */
 	fput(queue->sock->file);
 	queue->sock = NULL;
 err_destroy_mutex:
-- 
2.49.0


