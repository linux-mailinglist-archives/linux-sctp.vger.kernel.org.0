Return-Path: <linux-sctp+bounces-255-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF57C96F9C4
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 19:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC811F2454B
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE441D4618;
	Fri,  6 Sep 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFog4E+D"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C11CFEC9;
	Fri,  6 Sep 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642809; cv=none; b=SMl6CXUH8QB/F0dAMA8U9BSpqhoJi5YDkz1jOtHuyI9zknLglRPznU9UPKErOn7CNbKJx0kgZ8mGH5ge7Iji4qmDx69zgX1z3tvhbeJFDppgEynwxhrPjlpu3DPEh10DpOSZNDE6lUu+AALkb/a6IfEy7xMXPB348+t7vmO6z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642809; c=relaxed/simple;
	bh=za9hRWAJFue3qA2/8qfDjGdwgXq/W1BfL0Az38VY1kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6+eUSVwAsi9gmEkY8Dk/8OcqAeaQNlVaSeDtwEi943CrWTZt8hIzrYj2m+NtmoStOvXVUzkSztDBqeN/mM/+zOjdzEQpQzJGMra2Mk8IK0rOJmaGwHcfFRSK2nGqyNfeB8MfNLrYndPySaXsQXGDJJ4DHFGE5hbvJpBKW0/jl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFog4E+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3692C4CEC4;
	Fri,  6 Sep 2024 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725642808;
	bh=za9hRWAJFue3qA2/8qfDjGdwgXq/W1BfL0Az38VY1kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFog4E+Ddyk1X/+lDS2YOD8HoYsrbiaXVWJMHDKK76Fj4BaEP3kzl/ig0ojYByIER
	 NcQPadazN3d/t+eluRpnLIuWo/yHIXahwADGaZMRskL8z+GZKWDrGOmIfFr7+iv0EK
	 rUaNZeOIXK5PT3mo25G0fNtbFmDY1v8bceg+7lz6S3bstEAyN9EYQ7NYsi920Bv0nn
	 do67l2juJ/MulHR7CU9F9SvFAWj9kBc7csqzjWok+b8fsPIGrIk/iRguGUXpX6j8Jt
	 4RkRTBPpCQsUzCjMcoBo5c/D+7B9ZffYeuI542pWftpxrmNHkI0CgUuB9sNkULkBWt
	 bve0Tf9j1juNw==
Message-ID: <a82d846d-ec87-4cb4-ab5f-86fee52e3124@kernel.org>
Date: Fri, 6 Sep 2024 11:13:27 -0600
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 4 (last)
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, gnault@redhat.com, razor@blackwall.org,
 pablo@netfilter.org, kadlec@netfilter.org, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
References: <20240905165140.3105140-1-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240905165140.3105140-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 10:51 AM, Ido Schimmel wrote:
> tl;dr - This patchset finishes to unmask the upper DSCP bits in the IPv4
> flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
> functional changes are expected.
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> It is currently impossible for user space to configure FIB rules that
> match on the DSCP value as the upper DSCP bits are either masked in the
> various call sites that initialize the IPv4 flow key or along the path
> to the FIB core.
> 
> In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
> need to make sure the entire DSCP value is present in the IPv4 flow key.
> This patchset finishes to unmask the upper DSCP bits by adjusting all
> the callers of ip_route_output_key() to properly initialize the full
> DSCP value in the IPv4 flow key.
> 
> No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
> Centralize TOS matching") moved the masking of the upper DSCP bits to
> the core where 'flowi4_tos' is matched against the TOS selector.
> 
> Ido Schimmel (12):
>   netfilter: br_netfilter: Unmask upper DSCP bits in
>     br_nf_pre_routing_finish()
>   ipv4: ip_gre: Unmask upper DSCP bits in ipgre_open()
>   bpf: lwtunnel: Unmask upper DSCP bits in bpf_lwt_xmit_reroute()
>   ipv4: icmp: Unmask upper DSCP bits in icmp_reply()
>   ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
>   ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
>   ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()
>   ipv4: netfilter: Unmask upper DSCP bits in ip_route_me_harder()
>   netfilter: nft_flow_offload: Unmask upper DSCP bits in
>     nft_flow_route()
>   netfilter: nf_dup4: Unmask upper DSCP bits in nf_dup_ipv4_route()
>   ipv4: udp_tunnel: Unmask upper DSCP bits in udp_tunnel_dst_lookup()
>   sctp: Unmask upper DSCP bits in sctp_v4_get_dst()
> 
>  net/bridge/br_netfilter_hooks.c  |  3 ++-
>  net/core/lwt_bpf.c               |  3 ++-
>  net/ipv4/icmp.c                  |  2 +-
>  net/ipv4/ip_gre.c                |  3 ++-
>  net/ipv4/ip_tunnel.c             | 11 ++++++-----
>  net/ipv4/netfilter.c             |  3 ++-
>  net/ipv4/netfilter/nf_dup_ipv4.c |  3 ++-
>  net/ipv4/udp_tunnel_core.c       |  3 ++-
>  net/netfilter/nft_flow_offload.c |  3 ++-
>  net/sctp/protocol.c              |  3 ++-
>  10 files changed, 23 insertions(+), 14 deletions(-)
> 

For the set:
Reviewed-by: David Ahern <dsahern@kernel.org>



