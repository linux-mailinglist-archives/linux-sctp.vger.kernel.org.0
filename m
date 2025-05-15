Return-Path: <linux-sctp+bounces-514-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D85AB8E88
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 20:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6711BC645D
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CCA25A646;
	Thu, 15 May 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgTeyS0n"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAA1F4C96;
	Thu, 15 May 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332544; cv=none; b=PTqkWbFZhDw0Vlg5AAhdOt27LtB9REmk28sA3JaKKeELXolmWLjumct29JbZAq0YvVOvzxr04JYiB0ez1J7MlT+BIaFzDtG/tVqth7YfwqpXvOvOhJ8WYeLe0yKVqbTIRFfdFPcP/HSADirnv/ejw0qSYtZdJck4AvZFNNfetyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332544; c=relaxed/simple;
	bh=EMbkV613PdDRHIH0TklJGK8IdRcNls/AaRkWvfzUGpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLphbU13iFSvd2LMNBIDKl7G7gl3F1ws1qm3ymYOm8TO7zTgNKMWICYfkC+PsvjQWjUvGpkNRG5lkWiL084KhMfmrAI4RtWj+BcpJ0Pv7uKJD7dHigq8GVHRHEcFc66dcgUwVIwlfaGCTerbK1TOWXR+9TUB1XehLDmc0T2ubS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgTeyS0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBDBC4CEE7;
	Thu, 15 May 2025 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332543;
	bh=EMbkV613PdDRHIH0TklJGK8IdRcNls/AaRkWvfzUGpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgTeyS0nRo/8GGQox7waepWvBt89X11Tjc4IIkuPLN0GqeY5JaU0dP3ym2OYbstyL
	 hPFl1HqPwySKYVlNGI38eFb3BPYb3C2/AcLkuR50wXRdHE08PjpxH9cqqp+Mas8EYK
	 myf9BJtwv/4ZVcfwyLFJvrIrIAML+DPXg8il6uwFuWTw6hOY1VNhSmZOBCVAOktZe5
	 jIGzEPHRseWZPp8ondAPHuPX3YYAZUytRpBBj/4SyF2rV8x/Ga8V0gNi+mZuNkdA/z
	 rU46XFYpoJRDo7+XpyKuN9P7N0Qyw6cTd0saAbr5xlcFyL2S1yity0q4TbtzPQ+f7d
	 z44zZxxq4c07w==
Date: Thu, 15 May 2025 11:09:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 08/10] net: add
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250515180901.GA1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-9-ebiggers@kernel.org>
 <20250513144154.49f8faaa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513144154.49f8faaa@kernel.org>

On Tue, May 13, 2025 at 02:41:54PM -0700, Jakub Kicinski wrote:
> On Sat, 10 May 2025 17:41:08 -0700 Eric Biggers wrote:
> > +/**
> > + *	skb_copy_and_crc32c_datagram_iter - Copy datagram to an iovec iterator
> > + *		and update a CRC32C value.
> > + *	@skb: buffer to copy
> > + *	@offset: offset in the buffer to start copying from
> > + *	@to: iovec iterator to copy to
> > + *	@len: amount of data to copy from buffer to iovec
> > + *	@crcp: pointer to CRC32C value to update
> > + */
> 
> When you repost please toss a Return: statement here.
> kernel-doc -Wall is complaining

I'll plan to fold in the following:

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 3599eda959917..fa87abb666324 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -538,10 +538,12 @@ static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
  *	@skb: buffer to copy
  *	@offset: offset in the buffer to start copying from
  *	@to: iovec iterator to copy to
  *	@len: amount of data to copy from buffer to iovec
  *	@crcp: pointer to CRC32C value to update
+ *
+ *	Return: 0 on success, -EFAULT if there was a fault during copy.
  */
 int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 				      struct iov_iter *to, int len, u32 *crcp)
 {
 	return __skb_datagram_iter(skb, offset, to, len, true,

