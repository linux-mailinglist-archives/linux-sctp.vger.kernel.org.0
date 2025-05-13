Return-Path: <linux-sctp+bounces-509-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953FAB5E83
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 23:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BC34663F6
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E7202984;
	Tue, 13 May 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYfUUcKS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D03596B;
	Tue, 13 May 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172516; cv=none; b=s4/vw/7onso99TrFx99YM6FQb/Ex6Is58Cx48wd/wfm+mS3XlvqwCT4VA5laF6enti+/ozWmpLDdMCxDuI12FrmqJVu88ShHmxJMIeILJiPBcSC/1X7S/SEqdicFTFYaAsjMUs9zqKWwNNadk3uMJ1KZwKU+WG0V0sFv27Uetrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172516; c=relaxed/simple;
	bh=8PWt1duAkSY7eSn4u0WA9MHoPcUK8ogpDcpia6Mf+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhqTcD+i3e6oGNxLG3YaQ7gnDRtSlk1a3aScZjWtahM9zt1mvorxLWtnIbJIPphhTv8r0xyh6jVxnoYJTEUrvrmqSSsfmM+20KarPVnOS4twMBVSaO7REqxyCCJZK6H3NlpXMY0JO9WzyZw9Ue1xtsq/LswM6oOLA+XORWwbGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYfUUcKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABD4C4CEE4;
	Tue, 13 May 2025 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747172515;
	bh=8PWt1duAkSY7eSn4u0WA9MHoPcUK8ogpDcpia6Mf+yA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QYfUUcKS7ZRph5ZQSlsbksWFlsHZrbYQU91a1GdrsTJKsGnBwGd9bEjQ0JzxQGZBG
	 zRPMX5cd389R1pA+9RiAx7VsRVe0R8Vj3zm35epQASw2usv2xC1DU9h6bVGKN6Z/VR
	 PKdJ+E/bWYHTXpICV/pSE38natav9ZT3UPQaMO/HrBw/2kG831go1wIrheYPldhChd
	 QHcoDk3XFl3hFlrXxSniyVxZZVBqqlFLTsfzKkuC712ILn6HYEImlsRVr9oSRprxOF
	 rj7P/j44FWiRYyEq3MN5wnMEc+YMSKktXHFR/Wqhti6xnyIYmHFahyz036ZTbXVHg7
	 kCAXqNsJ6U2Kg==
Date: Tue, 13 May 2025 14:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 08/10] net: add
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250513144154.49f8faaa@kernel.org>
In-Reply-To: <20250511004110.145171-9-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
	<20250511004110.145171-9-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 17:41:08 -0700 Eric Biggers wrote:
> +/**
> + *	skb_copy_and_crc32c_datagram_iter - Copy datagram to an iovec iterator
> + *		and update a CRC32C value.
> + *	@skb: buffer to copy
> + *	@offset: offset in the buffer to start copying from
> + *	@to: iovec iterator to copy to
> + *	@len: amount of data to copy from buffer to iovec
> + *	@crcp: pointer to CRC32C value to update
> + */

When you repost please toss a Return: statement here.
kernel-doc -Wall is complaining

> +int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
> +				      struct iov_iter *to, int len, u32 *crcp)

