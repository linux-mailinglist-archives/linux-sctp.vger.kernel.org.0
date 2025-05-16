Return-Path: <linux-sctp+bounces-520-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7BDAB9548
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 06:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BC6500EEF
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 04:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C7217651;
	Fri, 16 May 2025 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vWZAhmYD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D370635;
	Fri, 16 May 2025 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370169; cv=none; b=oDDXq1Py3QBL+39gSqjqzeDdlxnZMUrbK2wmEVok4M8/vbtrejdB9nM5rov8whXNOyaY6HEsGCY7b8USB8rGiBG57PUVTfjy+B7bNqPadyRphlBfW0b92M2/JP/gjqdqUX+ihfyKfCVWgnmYiAudkqPBZBEbmn3tOUn9MNdPOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370169; c=relaxed/simple;
	bh=hv/SEzp5vdmYJGqPOg3MBRtQXnOQfCzT2cUlNcn6mBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8O/LmRUa00bHLS79NU+Kgj2BJd12LGMGYlvt/jlTQl2kfrtUCd2Sc9666qQMeqOKhoHyGyVV5fCgJBw8RuMTyAvVfcvO1uthRJZ+RlNydNmCcE6QwroGMI76b+6Ti5hyqeJnaqXAbAez7nNgO5YsTaCGZoVHekSw8NOzsuFEwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vWZAhmYD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D/sL8xKdHNXpp4F48ilzZqzQNOfczYgnjCBdaBL/BJs=; b=vWZAhmYDTGHkGNmstaLxpNJ3nn
	GGFyOUpiy9u4mMZvGiGfYPEnRS7CvHXF6Sf8U1C9CvwTqbtQqlVa+FlpwjUx6H/xX+20OGd8A5V5D
	rW1LzHEmzvo2asYburR5sqStp0ihXeyv+XVtn0PXgHT5g7sySC/nWhSR5xjNWh8yif6LG/N8JD/5n
	+8j+yEP42x9uyO19JCi2fNMkrdvi3GfxvBlQu4a7xiqqX/OK3O1MjrBbifAi/k1IP97LwtwFuB+0C
	tA8TLoitJ+6QoHybu2A09UklgJ0i2fqcaoYyCapR4BrVnxEF5PW8VasdJSNR4OljTtR5Rks5iIVLK
	Zlle1N7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFmng-00000002Sry-45J2;
	Fri, 16 May 2025 04:36:00 +0000
Date: Thu, 15 May 2025 21:36:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <aCbAsCkTPMNE6Ogb@infradead.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511004110.145171-10-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, May 10, 2025 at 05:41:09PM -0700, Eric Biggers wrote:
> +static inline void nvme_tcp_ddgst_init(u32 *crcp)
>  {
> +	*crcp = ~0;
>  }

This helper looks really odd.  It coud just return the value, or
we could just assign it there using a seed define, e.g. this is what
XFS does:

#define XFS_CRC_SEED    (~(uint32_t)0)

nd that might in fact be worth lifting to common code with a good
comment on why all-d is used as the typical crc32 seed.

> +static inline void nvme_tcp_ddgst_final(u32 *crcp, __le32 *ddgst)
>  {
> +	*ddgst = cpu_to_le32(~*crcp);
> +}

Just return the big endian version calculated here?

> +static inline void nvme_tcp_hdgst(void *pdu, size_t len)
> +{
> +	put_unaligned_le32(~crc32c(~0, pdu, len), pdu + len);
>  }

This could also use the seed define mentioned above.

>  	recv_digest = *(__le32 *)(pdu + hdr->hlen);
> -	nvme_tcp_hdgst(queue->rcv_hash, pdu, pdu_len);
> +	nvme_tcp_hdgst(pdu, pdu_len);
>  	exp_digest = *(__le32 *)(pdu + hdr->hlen);
>  	if (recv_digest != exp_digest) {

This code looks really weird, as it samples the on-the-wire digest
first and then overwrites it.  I'd expect to just check the on-the-wire
on against one calculated in a local variable.

Sagi, any idea what is going on here?

Otherwise this looks great.  It's always good to get rid of the
horrendous crypto API calls.

