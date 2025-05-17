Return-Path: <linux-sctp+bounces-527-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB6ABABB3
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 19:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B709E2850
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF420296F;
	Sat, 17 May 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq0DH6KX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940C19CC27;
	Sat, 17 May 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747503963; cv=none; b=GTalQBJtMLFbpGsgwvQIQoaXt5N/fBdVh+5phRaPoLpx2C0pqxXSJVVq6Nl98rBgn4vgvsT26QS8Gg3wdqyCYM9afHxkgqmRnrh8hB1OoLQO4nqp/nhcRQqeZTKBFJUpOa7hcVM4fOpf5C3RKtWeXnd7USk9dFmJbOvltb/MndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747503963; c=relaxed/simple;
	bh=7/27gGuAO+opB7qDSlkxsDQOtI6hEvDd/hdxFCWHj3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhpxc8c+md28lCntMOsEkDEbPA733Qeo9VI0EIK7/UDSQuTMYuJmBZcjoEi9ZpZgPmY5/MaIC3gvIPQsEOn12wCTKnJlarhFcWzm04kZmZAsfWJj1ZaDCwI4mLlvFETmWOYfqp3nS73kOOmOJimQwzY6mGN37oempQEyCwXZn9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq0DH6KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3353EC4CEE3;
	Sat, 17 May 2025 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747503962;
	bh=7/27gGuAO+opB7qDSlkxsDQOtI6hEvDd/hdxFCWHj3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq0DH6KXX9NRv3ifq9zWCcgIkIisXar1upGP0dZfAOxX/1CK8mmpbD2+XzhZodLGS
	 zH0RTmSq+1NguowNMBpHoiW/bBAmwFsjyr68tRP1dce6DFxX9BtLRnmqfGvjWucQVR
	 wkgR8NIg14iSz1TXnwDFYN905bLZKa17jb+KfohwSVrJSo8QBnt/W6QIaPyyIHK9hR
	 +gt48u1e1zwrC/eUWS3QVuZ5LWX7oh0T78mvP+LHUGjP9E8W9ZpMQTEe4XIiJFAe8L
	 EnkRjS80iJUrcGt+uvBhqrb19Evv5yxMuLVTwWASELtQj+B+pKHmLTe6gbe7pH6oAs
	 CDexrVCAuG/KA==
Date: Sat, 17 May 2025 10:45:52 -0700
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
Message-ID: <20250517174552.GB1239@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org>
 <20250516053100.GA10488@sol>
 <aCbWAFNoBUjci7HG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCbWAFNoBUjci7HG@infradead.org>

On Thu, May 15, 2025 at 11:06:56PM -0700, Christoph Hellwig wrote:
> On Thu, May 15, 2025 at 10:31:00PM -0700, Eric Biggers wrote:
> > +static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
> > +{
> > +	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
> >  }
> 
> This drops the unaligned handling.  Now in the NVMe protocol it will
> always be properly aligned, but my TCP-foo is not good enough to
> remember if the networking code will also guarantee 32-bit alignment
> for the start of the packet?
> 
> Otherwise this looks great:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

The nvme-tcp driver already assumes that the header is at least 4-byte aligned,
considering that it accesses hdr->plen and the struct doesn't use __packed:

    struct nvme_tcp_hdr {
            __u8	type;
            __u8	flags;
            __u8	hlen;
            __u8	pdo;
            __le32	plen;
    };

On the send size, the header size is always sizeof(struct nvme_tcp_cmd_pdu) or
sizeof(struct nvme_tcp_data_pdu) which are multiples of 4.  On the receive side,
nvme-tcp validates hdr->hlen == sizeof(struct nvme_tcp_rsp_pdu) and then does:

    recv_digest = *(__le32 *)(pdu + hdr->hlen);

So, using put_unaligned_le32() is unnecessary.  I just had it there in v1
because I had directly translated crypto_ahash_digest(), which does ultimately
do a put_unaligned_le32() once you unravel all the API layers.

- Eric

