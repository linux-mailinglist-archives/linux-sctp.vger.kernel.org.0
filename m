Return-Path: <linux-sctp+bounces-578-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63722AD9326
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Jun 2025 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0E91897609
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Jun 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A211FCCEB;
	Fri, 13 Jun 2025 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQHeqPmL"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FF15A87C;
	Fri, 13 Jun 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833340; cv=none; b=OKH2FfyEcEy/T3FblYz4QoixJPD1ZFq7pghzx+zLZ/xJjqQfV5rzbbnQLe9aR4YeE1AAbGarvOsrBmzfUUSHBgDrdzGnVzYpMzSxejHHTK0ynPsLY+pIHyPiahzdrq7OWnmwINip7jcDsnWKwQKDdbpCAFsexu4JkUBecrgX42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833340; c=relaxed/simple;
	bh=9qE4Kk3orcnozxb2Pvy7xMPE0E6IASPUn9yb17+Z9nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQ4AHPCZcjA/wZqhbi+l88zJxW90ApzF/Ep5IuFGpDQtse9u4FCKCfyHPT3/ZrqvVhr/MfQ7my5cHKNT2agYf5XiNNii4ZdnVFQ0VeTgzbJDDCW7ywQugJacuGbO/FQiT6ddu0I/U2FzNuXRL9royMQCHWRpwHWwsMfeHTz8RVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQHeqPmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17550C4CEE3;
	Fri, 13 Jun 2025 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749833339;
	bh=9qE4Kk3orcnozxb2Pvy7xMPE0E6IASPUn9yb17+Z9nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lQHeqPmL2hTxWlqwT4eWnqQcuKXz+AR0+zVBfe8DXk8c00+4jSSVjQzIIwS9kjYlI
	 JKraQuA7ftKBR5I+YmToYLO01DxFv9JZmns7SX/5HRebOkuJfvltKaeuV3Dj6x3ukp
	 y1cGjPpeBO9OtzOqcZkMuZhlmrRDcRvQN18Vtj3CtR0TAKiD1O9fsqX6ri0i6fzasW
	 JZ+y7u0H3lT+O7t5LnZlyeJheC6nfLnLn9Zra7SCmFNe5KQwayaDiNh0vMdDmbfdKe
	 4JwVkE23AGm+toTtjamskt9qZbWsqjwwwUdExchuinb8olFWy1A6cIwBpkBgMM1W/6
	 2kDPMbRGrVPwg==
Date: Fri, 13 Jun 2025 09:48:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>, Antonio Quartulli
 <antonio@openvpn.net>, Pablo Neira Ayuso <pablo@netfilter.org>,
 <osmocom-net-gprs@lists.osmocom.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Taehee Yoo <ap420073@gmail.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 <wireguard@lists.zx2c4.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, <linux-sctp@vger.kernel.org>, Jon Maloy
 <jmaloy@redhat.com>, <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH net-next v2 01/14] net: ipv4: Add a flags argument to
 iptunnel_xmit(), udp_tunnel_xmit_skb()
Message-ID: <20250613094858.5dfa435e@kernel.org>
In-Reply-To: <93258d0156bab6c2d8c7c6e1a43d23e13e9830ec.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
	<93258d0156bab6c2d8c7c6e1a43d23e13e9830ec.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 22:10:35 +0200 Petr Machata wrote:
>  void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
>  			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
>  			 __be16 df, __be16 src_port, __be16 dst_port,
> -			 bool xnet, bool nocheck)
> +			 bool xnet, bool nocheck, u16 ipcb_flags)

This is a lot of arguments for a function.
I don't have a great suggestion off the top of my head, but maybe
think more about it?

