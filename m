Return-Path: <linux-sctp+bounces-221-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E0595F6FF
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFF4B2099E
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C3E195390;
	Mon, 26 Aug 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUeYh1u6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A75194096;
	Mon, 26 Aug 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690709; cv=none; b=fG8uZOvkvY6og0piZzJk2GduNzlD2hph5+srRsoIKnCGztGUGVPruJE/+ue3kGcQafZi15Sz3ThAnWJZk5YBnQehImWNp2b3NGcg8mUnDKZzU9LZ6bsN3hSaGzbNotz2LStEo4D4DY+ZaOEZdwseVcli3z+pjeNvztcKtFZWKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690709; c=relaxed/simple;
	bh=QEZqa9+OcX1Yz1LbRQreJGZch1R6GBmVb8/hn3KGmDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5ROunzQrZFKQCInhxaoxXr/FZgNP+inJLyXIx8ad+eNf3Xbt7EUPwRlCgw1Kb7cJmY32yACRsdOzyfGVsefha33vbNOV5iGlgoHnIgHjSKL3phhO0ieKNq0NUvnhTgOTp3GNKkFwJCJZsaWI/eIzONPIYxqoYnxWe7UbPX51+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUeYh1u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411ABC52FD3;
	Mon, 26 Aug 2024 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724690709;
	bh=QEZqa9+OcX1Yz1LbRQreJGZch1R6GBmVb8/hn3KGmDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUeYh1u64SrjyKJPsqv4w7j8JRidBU9jOTsl/40dd1wNOv6pQm5m/8qwEeJtOyuhI
	 U8P73/uRiZv+yKFMR87mROZbweRpJr/A/HJxrmMcfex3kZji4uq/SD6K4PqF/f0n2g
	 Xp9blCCayiNGdwn5PlWg1BXwl0uC+JrrbmztbVKAr7s6JspayHEL91NR0OTSwn7IUW
	 j8TQ/r2CIa+OvwABIe12CGTWl+xaabJNJ6o9+nnVwswsb2g8ZEAs6NHChKFpkGYa0W
	 t7AQvSbmAye7sqsaY3ZnLB6doptWLJCGmPunKSNO4IVOAwY/IF3bfXZH50wUSf+5lQ
	 iq418pg3uoEIw==
Date: Mon, 26 Aug 2024 09:45:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexandra Winter <wintera@linux.ibm.com>, Thorsten
 Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, Jay
 Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, Subash
 Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, Sean Tranchetti
 <quic_stranche@quicinc.com>, Paul Moore <paul@paul-moore.com>, Krzysztof
 Kozlowski <krzk@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 Martin Schiller <ms@dev.tdt.de>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] net: Correct spelling in headers
Message-ID: <20240826094507.4b5798ef@kernel.org>
In-Reply-To: <20240822-net-spell-v1-12-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
	<20240822-net-spell-v1-12-3a98971ce2d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 13:57:33 +0100 Simon Horman wrote:
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 9707ab54fdd5..4748680e8c88 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -155,8 +155,8 @@ enum skb_drop_reason {
>  	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
>  	SKB_DROP_REASON_SOCKET_RCVBUFF,
>  	/**
> -	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limition, such as udp packet
> -	 * drop out of udp_memory_allocated.
> +	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limitation, such as
> +	 * udp packet drop out of udp_memory_allocated.
>  	 */
>  	SKB_DROP_REASON_PROTO_MEM,
>  	/**
> @@ -217,7 +217,7 @@ enum skb_drop_reason {
>  	 */
>  	SKB_DROP_REASON_TCP_ZEROWINDOW,
>  	/**
> -	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data reveived is already
> +	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data received is already
>  	 * received before (spurious retrans may happened), see
>  	 * LINUX_MIB_DELAYEDACKLOST
>  	 */

I'd have been tempted to improve the grammar of these while at it.
But I guess that'd make the patch more than a spelling fix.

