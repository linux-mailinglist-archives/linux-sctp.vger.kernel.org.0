Return-Path: <linux-sctp+bounces-504-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9C0AB2B98
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30A73B5813
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F351258CFB;
	Sun, 11 May 2025 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MRsbE802"
X-Original-To: linux-sctp@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D743169;
	Sun, 11 May 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746998544; cv=none; b=oYqrqReffPzitxF4w/mVqUs9lTp43qXO3PfnKsotb4mZk4+pLluX+9sRtu9rAXFNE4yuXtz2CrqKRIHB+jaRHtvDmycA6pzzBw8aPzmkE3y4O2s4PydzNWs82C5RMFrLrIoLkmzd3tfAs207BF2nrC0I8uqUsKdH3yUjpoMxT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746998544; c=relaxed/simple;
	bh=mTem+6igHDgqrWUC8LXJOZmBzQNvwsDPdH4Z11cVT3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbQps5EfLRYzlb7gBKIUGzhE0iFl3ujHOxO7ks3LA4mT3whDdZ4ufBtUL6JiLxc5wPtSjJoXrWr0n7KgPhUgIMsv9QutysmsN2uuhY45nhmy3oQ+Uln9gw0Xj6fx96T3ejtoq9gJSqIF/z36ECp1EzWoYwuQ1uIY9UpgR+JhpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MRsbE802; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RrNyqzWsoxW7PT7XBcAVPoXOI9p5Db8vQWoqbzcV3Bs=; b=MRsbE802EdcrNIsmJ9rJJrB3Gb
	J27nqulZChtl/IUzRLo3poP1dnDuJTs8ZhlIKJ8x9qAZ+/ZyE5k8nQ1WpXhwwKP/1iofIltl6bscw
	riU7Q4/Z1OGJ6K8fvVqPh8lhdHDfv9QaEDscHK/OeYuVs2oAX3HAEx5fYslxxk2ah4D0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEE7l-00CHNm-T0; Sun, 11 May 2025 23:22:17 +0200
Date: Sun, 11 May 2025 23:22:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511172929.GA1239@sol>

On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:
> On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > > Update networking code that computes the CRC32C of packets to just call
> > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > and simpler code.
> > 
> > Hi Eric
> > 
> > Do you have some benchmarks for these changes?
> > 
> > 	Andrew
> 
> Do you want benchmarks that show that removing the indirect calls makes things
> faster?  I think that should be fairly self-evident by now after dealing with
> retpoline for years, but I can provide more details if you need them.

I was think more like iperf before/after? Show the CPU load has gone
down without the bandwidth also going down.

Eric Dumazet has a T-Shirt with a commit message on the back which
increased network performance by X%. At the moment, there is nothing
T-Shirt quotable here.

	Andrew

