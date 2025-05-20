Return-Path: <linux-sctp+bounces-546-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA9BABDEA6
	for <lists+linux-sctp@lfdr.de>; Tue, 20 May 2025 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B85F1BA64EC
	for <lists+linux-sctp@lfdr.de>; Tue, 20 May 2025 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB025A2D7;
	Tue, 20 May 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIkvmAtt"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026B25229C;
	Tue, 20 May 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754311; cv=none; b=Vbt9yVQYIg/trOmt9P36y+W3mLnAJqin1NDSnogCxd2AgIgqXNmbHenrSydaboVPpbOcA2sW4WWEyGfwIPTLCtf0B03nUwbJn9l2Vi8cSxe1mO0Uz2SAxwPTNlxUmeS1Jop9NwwRp4ac38ppjla6q6kybI5hVdf9yl2k+tMaLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754311; c=relaxed/simple;
	bh=gOcAH/YL5VciW2jCfOJM+RDZl3zKyoeTRxoKCucXQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNmkEERJHOsT0jVLXqV6syU2YG7UI19X5CVFnJpIomX9/PuNl8AGpn81o0b/x9XxDuHwzaZfjouNbhPcDIZfY4hYjDvOZR2YtQyvKLI0lpgpfAyi3QBJ2g1ZAUVKrLXIyKhc9MCWaW8eI7exBoGHgHKrFnbEdeuuI2ZXS26nCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIkvmAtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A749C4CEEA;
	Tue, 20 May 2025 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747754310;
	bh=gOcAH/YL5VciW2jCfOJM+RDZl3zKyoeTRxoKCucXQKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIkvmAtt5TOeMvCDGBbPJgB4JjBBPqqSvNUUZs5g4513rRX5RxJkhlFPLNQkiiSyC
	 kEEBnlMGbFy/UU2efYx4TS3uT1GkmLUB264f5DqVEAa1qu5AO0ZRlBcHoeOMvtBA6A
	 dlCY/nTm3or20KEx0j9YfHik5x+PVGGk4VLjiEfUS3XV41Kx+8Mm28DQSJyEUF+vYJ
	 OZB17ZWCrXlQ1JSY2UVx+PS5QsvjVLI4un1blQBMuTIzblz8vEuUEAWl+bbvgzxDeR
	 +cE1X4cBIWWYk68/zYN0cY9FKSUESNiQcbeSYO/YpWyDDzCytghiSikW029Z+g86CS
	 Ha7+ngUMOWpVw==
Date: Tue, 20 May 2025 08:18:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20250520151817.GA1249@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20250520131841.GH7435@unreal>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520131841.GH7435@unreal>

On Tue, May 20, 2025 at 04:18:41PM +0300, Leon Romanovsky wrote:
> On Mon, May 19, 2025 at 09:04:04AM +0000, Bernard Metzler wrote:
> > 
> 
> <...>
> 
> > > 
> > 
> > Thanks Eric!
> > Works fine. Correct checksum tested against siw and cxgb4 peers.
> > 
> > Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> 
> This patch should go through RDMA repository, Please resend it.
> 
> Thanks

It depends on patches 1-2, and patches 6-7 depend on this one.  So your proposal
would require that we drag this out over 3 cycles (patches 1-3,5,8-10 in net in
6.16, patch 4 in RDMA in 6.17, patches 6-7 in net in 6.18).  Can we please just
take the whole series through net in 6.16?  There aren't any conflicts.

- Eric

