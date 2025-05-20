Return-Path: <linux-sctp+bounces-545-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB5ABD92A
	for <lists+linux-sctp@lfdr.de>; Tue, 20 May 2025 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A1F17F85E
	for <lists+linux-sctp@lfdr.de>; Tue, 20 May 2025 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E62417DE;
	Tue, 20 May 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHZFwaCx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56B241696;
	Tue, 20 May 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747747126; cv=none; b=ZKJYw9lE0tV7aSAfA60XlzEUkxtM5AE8QdUjdfk7lKJUKxuzlQNAoYQm90bRlDvh5zOicy4RqmTLYHWOEULLd58dCC1ixMKm6wm9Fbe/IjuR72j/WWwLO7Ifk+miXMgkVIKxQF5JIUY4DsdWht6c8qC2SuSNwluPB3yyPCbD0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747747126; c=relaxed/simple;
	bh=3MlZ6pJ3PgzLg+lrX3zgXpF30gosCty23jYj1U6ABBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIZQ8Nj9mVXXXybOQL8VMy6nM3B8zPTdGblhcv3FlC3/nBM624GdNl/nHi4l1L0kzefAWAjsc0qjyyZOY19y7Y09HSdY5+Xy3MLXLJusNO7GMQK6+1+vKrD7nQpDUGAHxPCNBuSEPqtLy1Y7iEnaSrrLX45t+sb8nPzGUnhe/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHZFwaCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F6BC4CEE9;
	Tue, 20 May 2025 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747747125;
	bh=3MlZ6pJ3PgzLg+lrX3zgXpF30gosCty23jYj1U6ABBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHZFwaCxrPnFBX+bCrP5SkGGkSpo8BjIXmypxC9p1xgUqUVI4SItq8gDUSbD/AZfa
	 wtrfH0zta4wZBkhj62UOCiue0+e33QAgbRtBIGgqva+jRnocD2SZleuKv63XMgiKV9
	 j9lbRtSHDM9ULHKpQnU/yIFlVUYNTenfQHTGRKoZOVPEjis08m3aMIMLmjTA//YMju
	 V7fmp3019Gsydch6NSzmwWZMxrYP0phNVLd3cvY7QV7kOC/Sv1H8igKvkr/VTVd2qC
	 yCDPCvIO9eg96H353N5rnH7gGbQaXeC6V2eWT00dQ7okBDANBDYR69Z10sD9Hu4DT/
	 r+bZgLir/nF4w==
Date: Tue, 20 May 2025 16:18:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <20250520131841.GH7435@unreal>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>

On Mon, May 19, 2025 at 09:04:04AM +0000, Bernard Metzler wrote:
> 

<...>

> > 
> 
> Thanks Eric!
> Works fine. Correct checksum tested against siw and cxgb4 peers.
> 
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

This patch should go through RDMA repository, Please resend it.

Thanks

