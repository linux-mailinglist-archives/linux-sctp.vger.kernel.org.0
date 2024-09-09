Return-Path: <linux-sctp+bounces-256-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B7971AB6
	for <lists+linux-sctp@lfdr.de>; Mon,  9 Sep 2024 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F8282264
	for <lists+linux-sctp@lfdr.de>; Mon,  9 Sep 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52051B86E6;
	Mon,  9 Sep 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrWusSRL"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA47176259;
	Mon,  9 Sep 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888029; cv=none; b=XczQH3DjZli4NxClwAP8uD83t7EQi7wlyxZ49i0iMXytKB833CwBp+Xz36WyZrGTvo6I+s2IhNp+NTRb0pAjSt2cu9Ex86gbBJvd9ATbyYPei7K4ba3vR5pFTaQOFzVVpQQfe9W9aaHfmjpzXlYK//joqAqsyaa4vyo9J3SQuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888029; c=relaxed/simple;
	bh=yNPCM00JF29Zlm/VXMGvWB+B7uLbHwPXGgxQaLUWfxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mdIyZr7tHJTZDtjQGZlyrtbWHRCALxk9MVuRA+MnNQhIVln/gUHmAu2QLUsHYoy3lqO4K28OlQEgiayaSldUvhENlZDBkYLz0Hv3bjApIDfEc2+4n3vWd0e4BxzN3pNxRcge0JnYjPVYch+1bFNQjc/yTiJ+t9Jwux+QfLkrDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrWusSRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D65C4CEC5;
	Mon,  9 Sep 2024 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725888029;
	bh=yNPCM00JF29Zlm/VXMGvWB+B7uLbHwPXGgxQaLUWfxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WrWusSRL41NxWgD/QPKhzXVU/rHrm6uulLcE+/kkalNDNIyCl+1HWVwhfwBsiSqQ1
	 XV+E9AmuiXOlkD5JzeqoB4gf2rrvE8GEV3q2QkMd6jbIXTJoCGoiYxFnTvIgqHCapd
	 OSbN6umV8Sb+z5khibqtBGqpyxbZ0qMQMnCV7LUcgrUuN3mGlBKt4QH11U+AmbG4Ej
	 c4ienwQQlzkm/L4rvi3UbVgC1f52QOjc7YKyp3y8HV7F4HNhH32NqFw/1X1bNSFtUj
	 BbtItzNAGqH8Kf9CLu7M7XASi40JTdS2wQyy+phRmWMR06JBfwDa5d+RldTZzO+qwS
	 T5+vW9CRa76IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E693806654;
	Mon,  9 Sep 2024 13:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 4 (last)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172588803001.3758847.17988621944991615601.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 13:20:30 +0000
References: <20240905165140.3105140-1-idosch@nvidia.com>
In-Reply-To: <20240905165140.3105140-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 gnault@redhat.com, razor@blackwall.org, pablo@netfilter.org,
 kadlec@netfilter.org, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-sctp@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 5 Sep 2024 19:51:28 +0300 you wrote:
> tl;dr - This patchset finishes to unmask the upper DSCP bits in the IPv4
> flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
> functional changes are expected.
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] netfilter: br_netfilter: Unmask upper DSCP bits in br_nf_pre_routing_finish()
    https://git.kernel.org/netdev/net-next/c/1f23a1909d7f
  - [net-next,02/12] ipv4: ip_gre: Unmask upper DSCP bits in ipgre_open()
    https://git.kernel.org/netdev/net-next/c/25376a890119
  - [net-next,03/12] bpf: lwtunnel: Unmask upper DSCP bits in bpf_lwt_xmit_reroute()
    https://git.kernel.org/netdev/net-next/c/b3899830aa47
  - [net-next,04/12] ipv4: icmp: Unmask upper DSCP bits in icmp_reply()
    https://git.kernel.org/netdev/net-next/c/848789d552bb
  - [net-next,05/12] ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
    https://git.kernel.org/netdev/net-next/c/e7191e517a03
  - [net-next,06/12] ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
    https://git.kernel.org/netdev/net-next/c/c34cfe72bb26
  - [net-next,07/12] ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()
    https://git.kernel.org/netdev/net-next/c/c2b639f9f3b7
  - [net-next,08/12] ipv4: netfilter: Unmask upper DSCP bits in ip_route_me_harder()
    https://git.kernel.org/netdev/net-next/c/4f0880766a97
  - [net-next,09/12] netfilter: nft_flow_offload: Unmask upper DSCP bits in nft_flow_route()
    https://git.kernel.org/netdev/net-next/c/b7172768abfd
  - [net-next,10/12] netfilter: nf_dup4: Unmask upper DSCP bits in nf_dup_ipv4_route()
    https://git.kernel.org/netdev/net-next/c/345663e6a727
  - [net-next,11/12] ipv4: udp_tunnel: Unmask upper DSCP bits in udp_tunnel_dst_lookup()
    https://git.kernel.org/netdev/net-next/c/2c60fc9ca216
  - [net-next,12/12] sctp: Unmask upper DSCP bits in sctp_v4_get_dst()
    https://git.kernel.org/netdev/net-next/c/8b6d13cc8b38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



