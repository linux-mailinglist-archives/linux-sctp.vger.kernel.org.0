Return-Path: <linux-sctp+bounces-558-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4DABF1C7
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4DD8C22E0
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D625F795;
	Wed, 21 May 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+hXcp8p"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AE14386D;
	Wed, 21 May 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823912; cv=none; b=WfNNP+4NES4XJKw+c7vGKKoWpheiCZksVinK9uXvWXyHSneP4KojjAh2U9u4w9KSVLghNptTSSLua3W06gI1T9v6CJwYVMTaMnK+n36GEWx9UIbSGdtn+E0YzM8lze2d/xhOZ4yRaEErYsqta+bZEjXuhjjezi2jBmufqT3SOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823912; c=relaxed/simple;
	bh=aP22tRhItrix52YIZPiTVvPDKBs7jZe4Es3e+EjKrVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8Kbia+XNkEsdFycBxVkAtqQGNGuC6bLslz9qxtKWWm2IwhTLG/2k0oY7Y6nrGtwQy2mURgJ88N2JWuKA0NlBt9chttZtUP5Xo1JCQT5b3hFsq9TmxgIYlLBc3h3UjX5lO/HVrqXZCfHqmpWU2ULZGaaFGz3wmmr+CGhLBWoqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+hXcp8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD53C4CEE4;
	Wed, 21 May 2025 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747823912;
	bh=aP22tRhItrix52YIZPiTVvPDKBs7jZe4Es3e+EjKrVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+hXcp8pAKKzCs00FWgYrnC8O7yQAa8uVeh8w3VdkVwNpenLYkEnJri4VfxQGgUmX
	 tPbGB9gAE3C8CQrTF2evARCW2FebIqh0P+lgHT/0Fab1flj+/psCo42ZMn8YD0yz0l
	 wb0ZX64Io59BhUdN/RX3a3K1CRwCEgbG2oDjdQR2G5BeMFTQu9ikyRT231aTCKl3ZY
	 VxHFef/Sf2BpBItLSxucJR4RTvN1MfErTfsiY2WVFQpbmfYyQr+CasunfF++egf9ex
	 N/MC8zR+ATZXZPfbD5ynphUE6BnlsFTbwKudgIqlkY2+GhiMglr9mFXuP69RYKtfYp
	 RVDtb53gCEOzg==
Date: Wed, 21 May 2025 13:38:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
Message-ID: <20250521103827.GK7435@unreal>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20250520131841.GH7435@unreal>
 <20250520151817.GA1249@sol>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520151817.GA1249@sol>

On Tue, May 20, 2025 at 08:18:17AM -0700, Eric Biggers wrote:
> On Tue, May 20, 2025 at 04:18:41PM +0300, Leon Romanovsky wrote:
> > On Mon, May 19, 2025 at 09:04:04AM +0000, Bernard Metzler wrote:
> > > 
> > 
> > <...>
> > 
> > > > 
> > > 
> > > Thanks Eric!
> > > Works fine. Correct checksum tested against siw and cxgb4 peers.
> > > 
> > > Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> > 
> > This patch should go through RDMA repository, Please resend it.
> > 
> > Thanks
> 
> It depends on patches 1-2, and patches 6-7 depend on this one.  So your proposal
> would require that we drag this out over 3 cycles (patches 1-3,5,8-10 in net in
> 6.16, patch 4 in RDMA in 6.17, patches 6-7 in net in 6.18).  Can we please just
> take the whole series through net in 6.16?  There aren't any conflicts.

No problem, if it helps.

Acked-by: Leon Romanovsky <leon@kernel.org>

