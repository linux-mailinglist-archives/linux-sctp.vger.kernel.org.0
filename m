Return-Path: <linux-sctp+bounces-575-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A547AD6DAF
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Jun 2025 12:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1152E3A880D
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Jun 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE902231825;
	Thu, 12 Jun 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KTOKy+47"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546C22423F
	for <linux-sctp@vger.kernel.org>; Thu, 12 Jun 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724105; cv=none; b=Oks04qgGMJCDdyZEFaarr3M3selbEfCTquKO/0zRd/9emQjqEWoLG5f5u/KT4BvOJ3zCjqhhY4g0DO846uJor9g2dEI1sBIAdgXs1gs782ax/p2hlD13i49CFhEUkejNzLKtbKfEzTfL/3kAbNh31ePMk1YuQ13ZP++pMskkVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724105; c=relaxed/simple;
	bh=xWIqj6aprpDfjLRAvATge4t82VpM1CEeDxd5L0CT2ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIxOYqG2IBmkZ7ttAUm1xMtAzUtghcbcMRK2Zyey22LsqfBwp27dAOoHTQVNQsjyd4unhSy1Pu9hz2nORKi5Kz3xYDBaT04u5p4ldpoQ1KalbDBA1YZRLpbDLsOLyALQn75IzIeZLT+IRI/5YCiQzH2v/IC4c0TJnuqMxGfC/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KTOKy+47; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5533a86a134so655492e87.3
        for <linux-sctp@vger.kernel.org>; Thu, 12 Jun 2025 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724102; x=1750328902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdrRzDXFOwHG448jvig1wt2IVm7ZK5vVmOxfUEc3Mfw=;
        b=KTOKy+47M9f0qDWFBsMxDcBw8cQ/Q0PKsXAkNy7pjz13cFmUSzfw2boKbWSociwLbh
         yrWKxhE0YErfKnMUxoSk4orFw3kJw8Q2Gq8oiM8+Gj2fn7IMHyIN8yp+tHLsX2p3hUYU
         49b0tW9uz5r6WJ0HD1o6cO9RL2Y3sUYTXuyl7cWqMD922h2JDwbsmtpOEbn2+AePV8uJ
         MvIKn/QaR6hUtI/SPslpf4soeVQlXtJWfnLidxNlRGd7emQYPnKFKXGlNfJvLYqjw8JT
         UcJFp8vdx3o4TnLEEJ/TUMBwmnDdpfxMaODzx9OlB8kN6hYSwSStktTOu9WwAAL8EKn8
         TSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724102; x=1750328902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdrRzDXFOwHG448jvig1wt2IVm7ZK5vVmOxfUEc3Mfw=;
        b=ZiP3O6aEkFFl/2kUqFK8f9AHuh71RcJq1IMj8gX4C7/LQzqO7t63rcbJarhKzMsRSR
         70pIcnXZCPhBWPihkk7ZP28kiguoIQGXnRJrN5DvGNBFdg9HsGJaNAqssQ66Gk8RPEzt
         v9XnL3PCxtpD2yi4KKtDZ6mGS4rdN6/TGkfDEBB9c5QZpoh2WTDYOzmRhMRvx5wXZAYS
         bIQO2qEfo3bvl2wOJedqagRnKdRF1JyS27b7LPPBcS09lk0J6WVelR9PG5Mt3uXYi2qM
         rJZiqhhX6JkygmApttdBZhs6dEv2tI1Txnf2VbkQs7EnR4bURU49utjKT0eXe/scIqXJ
         nC/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGC6n0zAsNpqrUYzjImnNy15MZA+yebhfVeI7dzuC6wjCZZKzUpRzjya4Nvv56S2ZKwIM/twQF1Qmi@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQIqRh6N4FBB8RbFIYPCZKRTG4DXwSxb6jaQTFmbtXabzHqxJ
	+f0Y7kCMYxYS2GPIpsHyhUKdvDK+7CepZX5WNzKp7l1jbfppEAzOyVlp11mXwsLwn4Q=
X-Gm-Gg: ASbGncsa6mOQrdL5uq/+lh4DMH24FOF6bjJQsRJ8t/FMG5BtyM5XJfXsz+9Ml8ygZMM
	bjvXt5AuhiomNyOrHp/HIBCtWalZ0zmYW2F3Hk/0jydAVe3PYgNGkTI+2KKDGD6YX1A/dKs59+/
	xnQAF8ROWUjXLFCX2MTkUPVZjHIoUYl65NqwV3ddsp3UmPn7VyYFJc4T0ONebCW8LavRt0rwQ/k
	KswXtBOf+ST+thy70TPaD964bcWewq0hk6llW/89rEbEH9y2Ve2EYri/P3TwafYBbYSwYcmIj16
	j/BG7GlHTZgWhyt7ZyxNdDnn7BJ9cxbioJTGun07i/vqyhyFiRuPbBeNJkmayvVTzSFWqH8jaw2
	t/fi5PRpFx+V3nq2RMS/f9IusjAJFU7RJ6U7j1N3Yow==
X-Google-Smtp-Source: AGHT+IGMFEbW3kewoiFhwiIdhmG/b2bgCVSsV0qnpHHNcqp+03mzW/XSSQXifX6p6Cue4i8glJvBHQ==
X-Received: by 2002:a05:6512:4004:b0:54f:c6b0:4b67 with SMTP id 2adb3069b0e04-553a5453064mr1024275e87.4.1749724101957;
        Thu, 12 Jun 2025 03:28:21 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac13f0besm68262e87.84.2025.06.12.03.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:28:21 -0700 (PDT)
Message-ID: <def0704c-38ed-42ac-8287-503ebbb61115@blackwall.org>
Date: Thu, 12 Jun 2025 13:28:19 +0300
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/14] net: ipv4: Add a flags argument to
 iptunnel_xmit(), udp_tunnel_xmit_skb()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Pablo Neira Ayuso <pablo@netfilter.org>,
 osmocom-net-gprs@lists.osmocom.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Taehee Yoo <ap420073@gmail.com>, Antonio Quartulli <antonio@openvpn.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-sctp@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
 tipc-discussion@lists.sourceforge.net
References: <cover.1749499963.git.petrm@nvidia.com>
 <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> iptunnel_xmit() erases the contents of the SKB control block. In order to
> be able to set particular IPCB flags on the SKB, add a corresponding
> parameter, and propagate it to udp_tunnel_xmit_skb() as well.
> 
> In one of the following patches, VXLAN driver will use this facility to
> mark packets as subject to IP multicast routing.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Pablo Neira Ayuso <pablo@netfilter.org>
> CC: osmocom-net-gprs@lists.osmocom.org
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Taehee Yoo <ap420073@gmail.com>
> CC: Antonio Quartulli <antonio@openvpn.net>
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: wireguard@lists.zx2c4.com
> CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> CC: linux-sctp@vger.kernel.org
> CC: Jon Maloy <jmaloy@redhat.com>
> CC: tipc-discussion@lists.sourceforge.net
> 
>   drivers/net/amt.c              |  9 ++++++---
>   drivers/net/bareudp.c          |  4 ++--
>   drivers/net/geneve.c           |  4 ++--
>   drivers/net/gtp.c              | 10 ++++++----
>   drivers/net/ovpn/udp.c         |  2 +-
>   drivers/net/vxlan/vxlan_core.c |  2 +-
>   drivers/net/wireguard/socket.c |  2 +-
>   include/net/ip_tunnels.h       |  2 +-
>   include/net/udp_tunnel.h       |  2 +-
>   net/ipv4/ip_tunnel.c           |  4 ++--
>   net/ipv4/ip_tunnel_core.c      |  4 +++-
>   net/ipv4/udp_tunnel_core.c     |  5 +++--
>   net/ipv6/sit.c                 |  2 +-
>   net/sctp/protocol.c            |  3 ++-
>   net/tipc/udp_media.c           |  2 +-
>   15 files changed, 33 insertions(+), 24 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


