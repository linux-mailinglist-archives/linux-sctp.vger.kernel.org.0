Return-Path: <linux-sctp+bounces-526-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39FBABAB71
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95F3189F399
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9520E332;
	Sat, 17 May 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyF5WWZ6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA120E000;
	Sat, 17 May 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747503006; cv=none; b=bIyFNanxAzKO/bikGKR2WpUgdbJrEc2h4+CFMpSccsej6G/deqfFbFjfQS45V9cDbQCFGg4TaUUw5JD3rEr4G+LLINpgPU2Iq3Jak81p5L4oJGzAa2qMVafeJhk3ug0qgCz3D8HW3BCxVzo8W9Kk6NZs4Z6yIiUtW0Ggb4eXN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747503006; c=relaxed/simple;
	bh=f81/M7NtWX54f5IpNC9UWQq+EKFTy1NMk2/6m6eqiIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j74VERYonoIEyTbsko+PKsyWHYCsaMtFXTiG+MXoymhzQkqQ4o7C7PMeV6bTDNmPzfseQ4NqUNgEMGMVyEl7EKmTN2PYxppMaVeI3bgUwI5kB9jhEZjHUNScHzBJ8WLo9xj1/SkzwmsUDCj/USfqH+Lv/Th/oC68Cj5qydKwthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyF5WWZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9E2C4CEE3;
	Sat, 17 May 2025 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747503005;
	bh=f81/M7NtWX54f5IpNC9UWQq+EKFTy1NMk2/6m6eqiIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyF5WWZ6HYP3IKMJshPYdOKe7d3oVgEL/l2dTMOrp8n9njs5m4RNI16oQ3PYwDfRv
	 dyEYn5wUnXDzts2G/ROnpJr4I0pUs4rEd20j4Ka3rr2aYDz2WitXJph5Om29lHRnoO
	 CQFIn1KHGD2k5TaLaW4KNucyNR9sjLcsI99PTXYFQAyMpwH9qeJt7HFDuhTR6F9PkQ
	 hFZ7CdfTlO//IYAkI25qnKsFZqy51KWpAmx+3Psexow7i28x+DHjLkibzhqTh2QlPL
	 YvnYyQV2871Jj+lOyjcxnrURlVDMiOHZ3pUSCCn/jc8kkMFSXEtMLRAS5PF62yFZc9
	 TP0FSYBweK/MA==
Date: Sat, 17 May 2025 10:29:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <20250517172954.GA1239@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>

On Sat, May 17, 2025 at 12:58:35PM +0300, Sagi Grimberg wrote:
> >   #include "nvme.h"
> >   #include "fabrics.h"
> > @@ -166,12 +166,12 @@ struct nvme_tcp_queue {
> >   	bool			rd_enabled;
> >   	bool			hdr_digest;
> >   	bool			data_digest;
> >   	bool			tls_enabled;
> > -	struct ahash_request	*rcv_hash;
> > -	struct ahash_request	*snd_hash;
> > +	u32			rcv_crc;
> > +	u32			snd_crc;
> >   	__le32			exp_ddgst;
> >   	__le32			recv_ddgst;
> 
> Let's call it rcv_dgst (recv digest) and snd_dgst (send digest).
> Other than that, looks good to me.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

rcv_dgst would be awfully close to recv_ddgst which holds the on-wire digest
that is received.  I think I slightly prefer *_crc, since that helps
differentiate the in-progress values from the finalized values.

- Eric

