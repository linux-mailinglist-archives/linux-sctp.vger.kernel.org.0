Return-Path: <linux-sctp+bounces-519-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4FBAB9097
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 22:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003111BC212D
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 20:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A21F27A461;
	Thu, 15 May 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVlfuHKg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4E282F1;
	Thu, 15 May 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339970; cv=none; b=UUcVm54BwOGn4+jLULYBQ3jkG16Af3i9ZiXYR76cn0nGQeMz2U/l9/l8bAt4qlGAvcOciaDOucZV+IDKjfyJKKuEjtxtoLg1p6hy3+XXod6WyJ/QAHQ12LXXjWOCBw1Bhc1oBeSqG5VJPVMTRHwU5QjDvTxogXPITLfwmSEtQKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339970; c=relaxed/simple;
	bh=fGPTYiA6cdbBydyA22vKFEs2piBzXgBhEu5Frcpbros=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2YeV/wb4rph7TsBhYB6OWNNk96llTJ47I7OmW2U9fH/Fv/FAYec3vb3RQ0Vb7b35yZ4ej9vuBMVM++KDriJT9tuOMswlM01nn8vuad9g7bo3Z4HFiXd99j2GD4R/9n2gkXNb9s2xx764FingfcHkmnaqLBhNBAqbRWKk36rdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVlfuHKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22F1C4CEE7;
	Thu, 15 May 2025 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747339969;
	bh=fGPTYiA6cdbBydyA22vKFEs2piBzXgBhEu5Frcpbros=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVlfuHKgjAfU5NWY8AgjXLeWjafxAwEFhJBl5HWk1jgr7/FqCdrcDoxZ5UpRTrIVx
	 tFOeGFiM0DfmxTyQbGMKHB/5Lg0mpryUEwoTQMVe/dx5w0m/bkNV94/HxC1RRzHNg7
	 OabmtMEN2j/tIV+ugY/gBAe6F+9Qmb+YpJ3vKYOug9Eu3adVO43emVVAXRhQ0dQD2c
	 sRSLixA8n+IvpBFntjGRERkUn3e7eg2k1JbSRCF7kugaoCcadw8vdLRG1M1vZyLVAi
	 lhsvKhbttP/uvfXmt3MUTcSklnUou90moJEaYY4jKLScbZsQRNagW3+Q4XfM9mfZL0
	 RCIw2ZZXatXbA==
Date: Thu, 15 May 2025 13:12:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: netdev@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
Message-ID: <20250515201247.GM1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69341806-3ffd-41f0-95d6-6c8b750a6b45@acm.org>

On Thu, May 15, 2025 at 01:02:20PM -0700, Bart Van Assche wrote:
> On 5/10/25 5:41 PM, Eric Biggers wrote:
> > Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> > does CRC32C, just call the new function skb_crc32c().  This is faster
> > and simpler.
> Bernard, since you are the owner and author of the siw driver, please help
> with reviewing this patch.
> 
> Eric, do you already have a test case for the siw driver? If not,
> multiple tests in the blktests framework use this driver intensively,
> including the SRP tests that I wrote myself. See also
> https://github.com/osandov/blktests.

No.  I'll try that out when I have a chance.

If the developers/maintainers of the driver could help test it, that would be a
lot easier though.  I've been cleaning up the CRC calls across the whole kernel,
and it gets time-consuming when individual subsystems insist on me running their
custom test suite(s) and providing subsystem-specific benchmarks.

- Eric

