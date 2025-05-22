Return-Path: <linux-sctp+bounces-559-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8165AC0DAD
	for <lists+linux-sctp@lfdr.de>; Thu, 22 May 2025 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE4B1C0040B
	for <lists+linux-sctp@lfdr.de>; Thu, 22 May 2025 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90D28DB5F;
	Thu, 22 May 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4jM5Mco"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E928C2A4;
	Thu, 22 May 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922827; cv=none; b=rwqD8E4q0OCnUu+o+6bahQpk1xxPE+NvNde0iDBp3P4JyuRYqKvkw9fRuCWADpobgpvGeBx2khZhTzfwHupWQN+OxocakXMgTIiO1UzsNn+sC+r8IEDyeSIkPUm9I6aqdvtXTOQ5bG8IdOPfSVRnFhTAcrcu9ldrdHO+1kYbnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922827; c=relaxed/simple;
	bh=0P6S5mM76WtwYl5idB17bKNw74rBuLMDgD/qcH1/GVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia3FJqSEQyceWM47mOpApzYaTK21qK70PjJGRjmRUFd30yfnsKdMCR0XAlQT0tGlNz5+6lcDHgreyq51WkiAXz3Zl/dOKKlPB4u8AJykoGWXINyppgW0rChGksSok/fl+Yzf2kOhkT3PPvGzTvkJMIGv67UMUVVkEp0ytSYQQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4jM5Mco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E084C4CEE4;
	Thu, 22 May 2025 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747922827;
	bh=0P6S5mM76WtwYl5idB17bKNw74rBuLMDgD/qcH1/GVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t4jM5Mcoruwb0RQ3t4tiGede8lBriTubmyqoGwRhBMLKQPI4fc/yuyUK3uZu+8QYK
	 OF+Ny41dH/CjE7V80MrNfS7o11ufE9gjuhDD2sLkqmPrIlwtsRGd2vfReo+v8/bKuh
	 QFWywpSNXfLYtNRewJP1zyjkOwG+MA59zaUM1ifbAUBUvw31yw46fWBNb/61sLobcs
	 rvXejF2qKKn3bgBPlSPW/N1ox2rMOobDUWI2GY1k6/qgB1pPr/TqYJoJrUe9CeGXvA
	 W5H48e9N3/TtAAZFSOD9f/6iB2oF/sWXOLGgocVZYR92cQTmpCOPnNWkiqyRb+RZ5j
	 lgJAtiFHhb50A==
Date: Thu, 22 May 2025 07:07:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250522070705.19fa9ca6@kernel.org>
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 10:50:02 -0700 Eric Biggers wrote:
> Update networking code that computes the CRC32C of packets to just call
> crc32c() without unnecessary abstraction layers.  The result is faster
> and simpler code.
> 
> Patches 1-7 add skb_crc32c() and remove the overly-abstracted and
> inefficient __skb_checksum().
> 
> Patches 8-10 replace skb_copy_and_hash_datagram_iter() with
> skb_copy_and_crc32c_datagram_iter(), eliminating the unnecessary use of
> the crypto layer.  This unblocks the conversion of nvme-tcp to call
> crc32c() directly instead of using the crypto layer, which patch 9 does.
> 
> Please consider this series for net-next for 6.16.

Applied to net-next with Leon's ack he sent to v1.
Thanks!

