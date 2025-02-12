Return-Path: <linux-sctp+bounces-335-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AD8A32D3E
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Feb 2025 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DBC18842DC
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Feb 2025 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA720F079;
	Wed, 12 Feb 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxgkwYpv"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD84205AD9;
	Wed, 12 Feb 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380821; cv=none; b=Gx2itELuZxTxN+PJ2fnOBncLaHNd3+e8NuYqLyBUzkmXYb2jy29JDnco6F4TqsLqsmWJKCmtYNryXtelzH6M7Oz33N/dneYfuZNcQb3Wb4e8JZnot1HnMGQoOOspbhBabDN+oMTKf01wMM4uJVrSSCgbMsqZW/w3m9UKIi2TT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380821; c=relaxed/simple;
	bh=SF1KA2R8r1IfRxRoZeUU6wUugItnHDrzLvwBIixnO0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyQbcAKlApIBtMNKBzK8rZjIf0IyNciRnLu6lFS5LyFov0SIITTA+jSnroWXTtYZKbfw603kvNUHyIm8FbjlFXi5ysI1w+di7h5SLoCBoWowDpZ0chXkxMrxVKtZ4OVDPRtNsOB5dSdVsB2cw7dOoJH3yPn4Pyxbq72UWTODqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxgkwYpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF2BC4CEDF;
	Wed, 12 Feb 2025 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739380820;
	bh=SF1KA2R8r1IfRxRoZeUU6wUugItnHDrzLvwBIixnO0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxgkwYpvfjxsF1n1c5Xo6DXZ8WYkF+GYzmXDFG2Sl2FBonRCmMhhqnxMsjz8eEYCS
	 KzI87flW7xx76cs9jHU3uIdiLFmM6HOvsZV9xcZZZqvRfUsnFQD4YU5ITTQV3IISNi
	 54yno8cmomhhdFx0wD9Ht1BINM+8eucgxqo4O6YoWhDUq3ItTFQA7cm8aGT26eff+W
	 4ZZ1/aJgcJZ4ZM5ujHEILccG4u6aNOg9rMt9zbTn97QbBoeWnMn6HABk6ZzX+ZcOt6
	 Repo2YAVwnCYLEzPZxckMGiJP1S7FLZwJ7g5bBfQdQC835DrY57GYm/MrlNSOzFBXA
	 ikoWlv4I3dqDQ==
Date: Wed, 12 Feb 2025 17:20:16 +0000
From: Simon Horman <horms@kernel.org>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
	thorsten.blum@linux.dev, lucien.xin@gmail.com
Subject: Re: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev
 entry
Message-ID: <20250212172016.GF1615191@kernel.org>
References: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>

On Mon, Feb 10, 2025 at 10:24:55AM -0300, Marcelo Ricardo Leitner wrote:
> All SCTP patches are picked up by netdev maintainers. Two headers were
> missing to be listed there.
> 
> Reported-by: Thorsten Blum <thorsten.blum@linux.dev>
> Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


