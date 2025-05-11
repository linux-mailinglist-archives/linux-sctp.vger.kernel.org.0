Return-Path: <linux-sctp+bounces-502-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0868AB298C
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6063B3A33
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039C16F288;
	Sun, 11 May 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jUFhMOOp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2932C85;
	Sun, 11 May 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981030; cv=none; b=A3HXJTzkMKYj79caVzUJgNo2vPNExpQ6gCVvOXtp7u91kjldA8f2WMXLSDhRS4rbE1a1KYSLK3lUXueRbx4tv83Wn6adaiEIFdx7DoeYL2im+OtvxLOyLj6GwoNlm1/X4f07+AJqUykh6GhdnlklgU6xLWcErWX10I2I/EPG3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981030; c=relaxed/simple;
	bh=WBEGWRJtI80dhL8T60m5m5/cbJdkTfXRjiw7WH2TVXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYtrovNKKvGKrm9wHFihcn9sR1w7tGMRssRP0VpbRihz8gvbcGBaO7oaMi7M1eNu1LXmUkxwBrM+O2DzVHXZRji+QQuWDkQe2X04FucDRExcMfk/6eISt0D+WfU2iZ3MbD1zTiJUJqo6QFBOC6/vrXAxQrRSdOvF8USS8oytDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jUFhMOOp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j05ufgCRTBywcfpa2gjsTlesPknyJhWtmE7m1Zcza5k=; b=jUFhMOOpXtt4/9SFb4okUCh1DI
	Z70wp1ljdZM3lK26U+VSa+gVeAfy9DN6IF7iNsK9Nlqrbl2fAOZEO85v6DXslIPQN0udj+AkT6eiv
	CWDhFneAVMLgpmaYSxaxXDQoyW/E9Bz2Iygeuf4BzPyAbM5LeOmYCGbeHJSi16BsrKVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9ZJ-00CGFF-El; Sun, 11 May 2025 18:30:25 +0200
Date: Sun, 11 May 2025 18:30:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
References: <20250511004110.145171-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>

On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> Update networking code that computes the CRC32C of packets to just call
> crc32c() without unnecessary abstraction layers.  The result is faster
> and simpler code.

Hi Eric

Do you have some benchmarks for these changes?

	Andrew

