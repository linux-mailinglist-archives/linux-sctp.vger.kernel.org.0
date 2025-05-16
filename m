Return-Path: <linux-sctp+bounces-522-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4876AB95C7
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 08:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF54A7A8E
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EAD221283;
	Fri, 16 May 2025 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yt+5jJa6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA9182;
	Fri, 16 May 2025 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375619; cv=none; b=pyTwaLQY5WChmMFW9L1IwYzyenEpVIjHsQNZ3eBfFnrwvr2PBOYXY7k0z+DUBj343028H0xJdj0mDyEaF9mpfYPa3xQ+kApOcoKLF6iz4Q4V08qWOAz5i6tzGeERyOcnmFbQYU8xZfFumNbacXML56XwOYk4AAAxDeirZNz+prU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375619; c=relaxed/simple;
	bh=bphX/GG0yt3pLwRkZmQgU8fQ3GT9eblq3Ugq5jkFSHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHC+RpkCHH4fp6gfDEUPxEW/s3aHht1VwyxmPjomP8fkxhX6URYL2lslwLI4Kyz9W7si6gNaaLgJNllrEpZMyJ4ptsFKNYIHvsDgjSr+AeAYQs6zKNk7pjaWDEaaXd9XMEA3+Us9FQIbY0PmzmpJlPwd/RLeaKHEf0IQ0/WM3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yt+5jJa6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Nlt9/4135T4D0vircx++glsUBcW07iUUxenPSOo4Sw=; b=yt+5jJa61woMS4PHEVz5wv60CM
	xX4cABvvQxaO3OhveUsivvZY5K0J3oZLPBy6gZhjCtOxklctzBIW+3+1FTKzYYrdCUUlpizm4qUhu
	cDa4SQp1+A5k/w6WvVqoUgktgWyXGgdv9Yq7X99chK7gFpQ6270y2TvGUm0Agysc7Wky38j/q5/Xf
	pCNsFgOXFp6FfJ/g54J3+26fTXaiGlvwXhOh2DSZFNK/8jPwFFuUGR6PJyE1/VYcScSTo2KtSwFYi
	YgcdEBwfAdRI0npXhaUphSXjnR1vjLs37vfjLbktu/o5WrL1F2GUclW/S/CjSd2oAxI5XH4j8h1qm
	vRHG+7Qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFoDg-00000002YDl-3XSv;
	Fri, 16 May 2025 06:06:56 +0000
Date: Thu, 15 May 2025 23:06:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <aCbWAFNoBUjci7HG@infradead.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org>
 <20250516053100.GA10488@sol>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516053100.GA10488@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 15, 2025 at 10:31:00PM -0700, Eric Biggers wrote:
> +static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
> +{
> +	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
>  }

This drops the unaligned handling.  Now in the NVMe protocol it will
always be properly aligned, but my TCP-foo is not good enough to
remember if the networking code will also guarantee 32-bit alignment
for the start of the packet?

Otherwise this looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>

