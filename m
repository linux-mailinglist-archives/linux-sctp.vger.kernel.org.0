Return-Path: <linux-sctp+bounces-503-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2BAB29E2
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 19:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1131B18965BF
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE0B25D21E;
	Sun, 11 May 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDqFBeUW"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217A22D7A3;
	Sun, 11 May 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984578; cv=none; b=NBDm2JpWSdCkeV88HCU29LeHPYDVxX+PQ9M++VjG0A+mfm8Pzt7yUhK9C0il0Q4j6tici7lyTRdHQNW8JWmY0bxN/aLJkVQ04zELXFseKheuS4cyGdA+0UgDmEP44k3uX/C/NO/ATVO2v3zovDqJMgqWvCPT6/O2kVyukXDt/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984578; c=relaxed/simple;
	bh=SHyF1n7YIV4Y//zRB8/o+8Lh6KmT8QksNXJUTSUBUJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmIe3VV5Gw+FghmJrg+7aysSvufz2Rx1DPItEaBKQAbCPDGIsqFkZJb/XK8/aQ8Y9SDX46IdUFut9RSq1iWifY53yVxII9kvYBCGCQOigMBCgsulScGIusFeNWRN/Pj67ClaFvOwecXqQXRwuXaSdByD6Y2Wdp1TZI+l0Tm4Jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDqFBeUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10463C4CEE4;
	Sun, 11 May 2025 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746984577;
	bh=SHyF1n7YIV4Y//zRB8/o+8Lh6KmT8QksNXJUTSUBUJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDqFBeUWVUol4xajWSZX318VjdXJwcBgz2cwlSIQ/r9Pa41P1AIz4o2sbbiAl22sr
	 YV6tYmXgYLYhsfU3+7GP+PJmKWFiNNR3Y5YLbkmpump0bXledonvjDd4rT7OVdz/do
	 9wnuG7zuM99pjwq21LYQmW3SCnSUEghD5qz8maz6HOI8tAvCTOu3x3IVinfH7NvBSj
	 /unTwWrFqi0nLDsogIrToB75vENmdp15g85aXRSpOPGmlZI4ir9TiqQRQzAud+Tkbq
	 wTQvqfhwX/ALPF1sW5xzC6pIHP2cZ0Ji7DxM3Pt383BpTFhNGs8A0K986MqGVwvdRy
	 C53Ky+39prniA==
Date: Sun, 11 May 2025 10:29:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250511172929.GA1239@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>

On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > Update networking code that computes the CRC32C of packets to just call
> > crc32c() without unnecessary abstraction layers.  The result is faster
> > and simpler code.
> 
> Hi Eric
> 
> Do you have some benchmarks for these changes?
> 
> 	Andrew

Do you want benchmarks that show that removing the indirect calls makes things
faster?  I think that should be fairly self-evident by now after dealing with
retpoline for years, but I can provide more details if you need them.

Removing the inefficient use of crc32c_combine() makes a massive difference on
fragmented sk_buffs, since crc32c_combine() is so slow (much slower than the CRC
calculation itself).  However, reverting the workaround commit 4c2f24549644
("sctp: linearize early if it's not GSO") is beyond the scope of this patchset,
so for now the sctp stack doesn't actually call skb_crc32c() on fragmented
sk_buffs.  I can provide microbenchmarks of skb_crc32c() on a fragmented sk_buff
directly though, if you don't think it's clear already.

Of course, please also keep in mind the -118 line diffstat.  Even if it wasn't
faster we should just do it this way anyway.

- Eric

