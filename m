Return-Path: <linux-sctp+bounces-37-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CE87C546
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Mar 2024 23:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4EB1F21A24
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Mar 2024 22:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3110A20;
	Thu, 14 Mar 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL1JK3Da"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CC749A;
	Thu, 14 Mar 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456172; cv=none; b=BCmr6dyG1secgbl9WBjICf5FOnwuyjx+/oapXz4Z1IryDrUVNMBaDA7wXFzYjM+SLB5cxhlcjyXi1w20WG4Et5JsPIuV1cfosyhV3ezwklVPn7ROUy2A4iGUZ9cW7mLxzEIYRP9o2t/rELbNCDHg5cT5O0Ev9ES6DF0+4MJknvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456172; c=relaxed/simple;
	bh=U45zB3+40tmVIhF5iKt03Xdrdh8+Z7vW7QN+7y5B3f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB5Wb3hQ98+4qPYjE5RspExN3TQo+lo5Is+cx7p+cGooHVZO1SUVPRJclUMvpm+X1fpOHBTQCDRC5w4XkCLg+mbxnVpfQm4tYYUDJeQulI7J6E7RyHg0BlbvzBY1zbCud9RYe4CrhQMuIoZVu4tk7EdhxY4kqiC4mW+VwUqhOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL1JK3Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7C9C433C7;
	Thu, 14 Mar 2024 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710456171;
	bh=U45zB3+40tmVIhF5iKt03Xdrdh8+Z7vW7QN+7y5B3f0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TL1JK3Dai/kz4OGSXOftYv022x+e7Q4s6+0rQaw50afW+buujjI7SqPnwHoAH/3aY
	 mHTeNCNm02z8wXyaMCJODN+iXSFMO5ZqOrHw6II6qseUS3PXj/GAIKs2k3exN0FaMG
	 lgbBhDkTmXnrCvS40pNbF3ZnvBEUlCKF1ne+k8VzuEVhYpEglNHD41xcRqtveNNHb0
	 5zJFI9JPRdFPROEN46yi+IL95kRvDd7R2MZNGlrZ0+JIHP972CJ8zYnOHQCaTLhiDZ
	 ouFccyuRjCmD0Wx7PCvr2x5nVuP6IV9lwMrD/Xt8W4JeMxTlXrcUrM0JHh/VAe2C68
	 3WGbOwnNpaulg==
Date: Thu, 14 Mar 2024 15:42:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Cc: <j.granados@samsung.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern
 <dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Remi
 Denis-Courmont <courmisch@gmail.com>, Allison Henderson
 <allison.henderson@oracle.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jon Maloy
 <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Martin Schiller
 <ms@dev.tdt.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman
 <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Joerg Reuter
 <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
 <keescook@chromium.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
 linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org
Subject: Re: [PATCH 0/4] sysctl: Remove sentinel elements from networking
Message-ID: <20240314154248.155d96a4@kernel.org>
In-Reply-To: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
References: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 20:20:40 +0100 Joel Granados via B4 Relay wrote:
> These commits remove the sentinel element (last empty element) from the
> sysctl arrays of all the files under the "net/" directory that register
> a sysctl array. The merging of the preparation patches [4] to mainline
> allows us to just remove sentinel elements without changing behavior.
> This is safe because the sysctl registration code (register_sysctl() and
> friends) use the array size in addition to checking for a sentinel [1].

Thanks, but please resend after the merge window, we don't apply
code to -next until -rc1 is cut.
-- 
pw-bot: defer

