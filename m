Return-Path: <linux-sctp+bounces-521-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426EDAB9588
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 07:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C90CF7B37BD
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 05:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E9E21C9FF;
	Fri, 16 May 2025 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxtis54f"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1481BE67;
	Fri, 16 May 2025 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747373468; cv=none; b=n4IPBk4/uhlYmShMpSOY0LOLGHBHqQQYwX2yPT7B17WQxhghHi6c22iBhgZcvJ+6P7sKpxLzGkD7tCN3+skSAg/lEq2Q2A7pZws7QCxiZrTlSMoXdm2DFzuc1bFgrg19jmkCFULZM81KZBQdw3kyLKxuYsQ2x3HZr6iUpFfnPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747373468; c=relaxed/simple;
	bh=l6lDp7QR8574vZaalIIFj1DhoZ8IXApodiTEJ76851E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbc5KHy7zOUU5wKunogIaaKIXAnjttsltZlpgUkfUTeXG3bFgUhxx2d6kFnGcUDeLVHioSu4/euaLZVzLm2JijMdqb5Xe0XIAggysU1YQW6MH8mPXr2QNSjiJYTuiLPmf/F4ricuMXUaLQKJXnJN0KRpl8c7fe4r7TNi5Ko6Sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxtis54f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D79C4CEE9;
	Fri, 16 May 2025 05:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747373468;
	bh=l6lDp7QR8574vZaalIIFj1DhoZ8IXApodiTEJ76851E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxtis54fx1xh8rLK5lqCUusTQNB2c52pOfkRAr12Z+9TZR/mw+kI5B4t9gX/tPzwu
	 DN9D0nOnMeml/9lEHqYA7MpnK6+ke6VU/BJAP2TXrvpGEI+DFIGwOrkGoP5xfcqQVm
	 MXqDcWW2hUIyjzomE6I0e7Mblq11k5eGb1zatHPCp1ExR47EFm586v4o40xqL52geh
	 otWBnmpxk+E6GPV26zvp4SuX7HeGLk7GyGBWHM8w+4WFcNW+J6xYdqiSaN1CUSAH7s
	 BwhheMW85ciLjE7Euk/815QKFuJVQISVDy+gO9ROoO6LAvpSsJ5uKXefNPsnsahgR1
	 XXVlgPYlKBuLw==
Date: Thu, 15 May 2025 22:31:00 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250516053100.GA10488@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCbAsCkTPMNE6Ogb@infradead.org>

On Thu, May 15, 2025 at 09:36:00PM -0700, Christoph Hellwig wrote:
> On Sat, May 10, 2025 at 05:41:09PM -0700, Eric Biggers wrote:
> > +static inline void nvme_tcp_ddgst_init(u32 *crcp)
> >  {
> > +	*crcp = ~0;
> >  }
> 
> This helper looks really odd.  It coud just return the value, or
> we could just assign it there using a seed define, e.g. this is what
> XFS does:
> 
> #define XFS_CRC_SEED    (~(uint32_t)0)
> 
> nd that might in fact be worth lifting to common code with a good
> comment on why all-d is used as the typical crc32 seed.

Yes, there is CRC8_INIT_VALUE for crc8 but nothing for crc32.  It might be worth
adding a CRC32_INIT_VALUE to <linux/crc32.h>.  Though typically there's an
inversion at the end too, which can't be abstracted out the same way...  And
many users initialize with 0 instead of ~0, even though ~0 is the "right" way.

> > +static inline void nvme_tcp_ddgst_final(u32 *crcp, __le32 *ddgst)
> >  {
> > +	*ddgst = cpu_to_le32(~*crcp);
> > +}
> 
> Just return the big endian version calculated here?
> 
> > +static inline void nvme_tcp_hdgst(void *pdu, size_t len)
> > +{
> > +	put_unaligned_le32(~crc32c(~0, pdu, len), pdu + len);
> >  }
> 
> This could also use the seed define mentioned above.
> 
> >  	recv_digest = *(__le32 *)(pdu + hdr->hlen);
> > -	nvme_tcp_hdgst(queue->rcv_hash, pdu, pdu_len);
> > +	nvme_tcp_hdgst(pdu, pdu_len);
> >  	exp_digest = *(__le32 *)(pdu + hdr->hlen);
> >  	if (recv_digest != exp_digest) {
> 
> This code looks really weird, as it samples the on-the-wire digest
> first and then overwrites it.  I'd expect to just check the on-the-wire
> on against one calculated in a local variable.
> 
> Sagi, any idea what is going on here?

It was probably just written that way to reuse nvme_tcp_hdgst() which writes to
the hdgst field.

Anyway, I was trying to keep the translation to the new API as straightforward
as possible, but I'll take your suggestions.  The following is what I ended up
with, but I'll resend the series formally after giving a bit more time.

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
index aba365f97cf6b..0c139d844422b 100644
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
@@ -454,36 +454,37 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 
 	list_del(&req->entry);
 	return req;
 }
 
-static inline void nvme_tcp_ddgst_final(struct ahash_request *hash,
-		__le32 *dgst)
-{
-	ahash_request_set_crypt(hash, NULL, (u8 *)dgst, 0);
-	crypto_ahash_final(hash);
-}
+#define NVME_TCP_CRC_SEED (~0)
 
-static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
-		struct page *page, off_t off, size_t len)
+static inline void nvme_tcp_ddgst_update(u32 *crcp,
+		struct page *page, size_t off, size_t len)
 {
-	struct scatterlist sg;
+	page += off / PAGE_SIZE;
+	off %= PAGE_SIZE;
+	while (len) {
+		const void *vaddr = kmap_local_page(page);
+		size_t n = min(len, (size_t)PAGE_SIZE - off);
 
-	sg_init_table(&sg, 1);
-	sg_set_page(&sg, page, len, off);
-	ahash_request_set_crypt(hash, &sg, NULL, len);
-	crypto_ahash_update(hash);
+		*crcp = crc32c(*crcp, vaddr + off, n);
+		kunmap_local(vaddr);
+		page++;
+		off = 0;
+		len -= n;
+	}
 }
 
-static inline void nvme_tcp_hdgst(struct ahash_request *hash,
-		void *pdu, size_t len)
+static inline __le32 nvme_tcp_ddgst_final(u32 crc)
 {
-	struct scatterlist sg;
+	return cpu_to_le32(~crc);
+}
 
-	sg_init_one(&sg, pdu, len);
-	ahash_request_set_crypt(hash, &sg, pdu + len, len);
-	crypto_ahash_digest(hash);
+static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
+{
+	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
 }
 
 static int nvme_tcp_verify_hdgst(struct nvme_tcp_queue *queue,
 		void *pdu, size_t pdu_len)
 {
@@ -497,12 +498,11 @@ static int nvme_tcp_verify_hdgst(struct nvme_tcp_queue *queue,
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
@@ -524,11 +524,11 @@ static int nvme_tcp_check_ddgst(struct nvme_tcp_queue *queue, void *pdu)
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
@@ -924,12 +924,12 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
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
@@ -943,11 +943,11 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
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
@@ -1145,11 +1145,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
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
@@ -1159,12 +1159,12 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
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
@@ -1192,11 +1192,11 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 		msg.msg_flags |= MSG_MORE;
 	else
 		msg.msg_flags |= MSG_EOR;
 
 	if (queue->hdr_digest && !req->offset)
-		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		*(__le32 *)(pdu + 1) = nvme_tcp_hdgst(pdu, sizeof(*pdu));
 
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
@@ -1205,11 +1205,11 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
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
@@ -1227,11 +1227,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
 
 	if (queue->hdr_digest && !req->offset)
-		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
+		*(__le32 *)(pdu + 1) = nvme_tcp_hdgst(pdu, sizeof(*pdu));
 
 	if (!req->h2cdata_left)
 		msg.msg_flags |= MSG_SPLICE_PAGES;
 
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
@@ -1242,11 +1242,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 
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
@@ -1382,45 +1382,10 @@ static void nvme_tcp_io_work(struct work_struct *w)
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
@@ -1449,13 +1414,10 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1865,25 +1827,17 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
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
 
@@ -1912,13 +1866,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
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

