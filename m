Return-Path: <linux-sctp+bounces-336-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4CA3367B
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 04:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1593A2537
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 03:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22E205502;
	Thu, 13 Feb 2025 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaAC0Ylw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C297158524;
	Thu, 13 Feb 2025 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419069; cv=none; b=ihGAKtA0XcjVdecKFMD2pJJgnXzUaI6X5gKmF4P6uBVK3QIyA+7RpEQXWgnFgJMdk0djD64UPTb8L2J729G/PXPfhzIF1TA/ZW/AAPWJtNcIPwSGS2GAA4oTUe6uNKKJMXhlAXtg91/VNTMC2RSBE1qI0IVbtqFTwjUXjjtV6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419069; c=relaxed/simple;
	bh=7iOzW3MxlmfTusA257TBzCfaZ6qKqNDstclBN4g2j28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hgm7yF2fTUQ84GpN/w4EhSCkpDnOBifLqnjPXCr9hatDZS0pr+QxlF95hKHMrVVPXh8oZa+ARd/ei77slMyO+zJ3e6+1nTXHyxv8Skbk8JSvQVKgym7KbqYmwZ4apY0BrVfey5x+DPmzk9E/dvlyXU/fLsMQY4HdD0XIvj+XJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaAC0Ylw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001FCC4CED1;
	Thu, 13 Feb 2025 03:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419069;
	bh=7iOzW3MxlmfTusA257TBzCfaZ6qKqNDstclBN4g2j28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eaAC0YlwES1E/erABTXfyy6tfG204Gj2v+xudwD6Ie1LySknURUfq1VmbHxcgM/Xz
	 YzwemkdI7GM5z7j5jxJYIFFtgWfe2EIpaKc6q0TuObtzHlEHdzjdtsAGpGVRfYr6un
	 3mQKbbzuHsQMUi0hYNuQF7AT94MXJ7V9sdMe/8aocznyZoaJw1rIf+BKV2FqUR963n
	 Uyd/1ztWMY2bnVroDVwA/txgIb8aAszmkN+VNmoT2SFjs+Nja4jVaOGmvaiQ1c+ndQ
	 JfBu4TvN97XXtgL5lT8iCIOJQmRILBH4GvQOLHdRMTgoXyc1OGxuO/0hf3HLdxPGzd
	 XwtYdQbAPAkCg==
Date: Wed, 12 Feb 2025 19:57:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] sctp: Remove commented out code
Message-ID: <20250212195747.198419a3@kernel.org>
In-Reply-To: <2c8985fa-4378-4aa2-a56d-c3ca04e8c74c@intel.com>
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
	<b85e552d-5525-4179-a9c4-6553b711d949@intel.com>
	<6F08E5F2-761F-4593-9FEB-173ECF18CC71@linux.dev>
	<2c8985fa-4378-4aa2-a56d-c3ca04e8c74c@intel.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 12:33:57 +0100 Mateusz Polchlopek wrote:
> >> I don't think we want to remove that piece of code, please refer
> >> to the discussion under the link:
> >>
> >> https://lore.kernel.org/netdev/cover.1681917361.git.lucien.xin@gmail.com/  
> > 
> > Hm, the commit message (dbda0fba7a14) says payload was deleted because
> > "the member is not even used anywhere," but it was just commented out.
> > In the cover letter it then explains that "deleted" actually means
> > "commented out."
> > 
> > However, I can't follow the reasoning in the cover letter either:
> > 
> > "Note that instead of completely deleting it, we just leave it as a
> > comment in the struct, signalling to the reader that we do expect
> > such variable parameters over there, as Marcelo suggested."
> > 
> > Where do I find Marcelo's suggestion and the "variable parameters over
> > there?"
> >   
> 
> That's good question, I can't find the Marcelo suggestion that author
> mention. It's hard to find without links to previous series or
> discussion :/
> 
> I guess it should be also commented by maintainers, I see that in the
> Xin's thread Kuba also commented change with commenting out instead
> of removing code. Let's wait

In the linked thread the point was to document what struct will be next
in memory. Here we'd be leaving an array of u8s which isn't very
informative. I see there's precedent in this file, but I vote we just
delete the line.
-- 
pw-bot: cr

