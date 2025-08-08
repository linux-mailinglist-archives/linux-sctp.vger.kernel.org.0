Return-Path: <linux-sctp+bounces-597-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8E2B1EF5A
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Aug 2025 22:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF872391E
	for <lists+linux-sctp@lfdr.de>; Fri,  8 Aug 2025 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1895222568;
	Fri,  8 Aug 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REgt2gii"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDC1F2BBB;
	Fri,  8 Aug 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684396; cv=none; b=T9HzAp2WUaqLe+aih+Bd7LDtvxtVakrG4rbotq6CDJEYXay4cSFrSPsZcxE9+yOZGJc3X+fQipVWZyw1b995sECwjU6Lk3cV+8TH6fabxj5kseOKoiLsHX5GafCjBNmuOg6/wpj07rMcxeySi3Ms1ViQqG0iae9rkm+kPRnvvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684396; c=relaxed/simple;
	bh=/3QRMC2vD0qDAwbINPgYcIR1G66c5eVra2axNLfOSls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FOvngcM9uCHh96Ej4khj5k5Rfg020xYg3SdIVUj8F2y9AvylHo7LarCh9nUnghS98gQEhLotj38175oOKxfVAjm83kuRINUtVVX2gmq/V54GVwof+tPNLzk7LaG6Gq+h7WabiAvD8teiv+1uWnpoaUfPQWk9URqLxqiHnrBFpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REgt2gii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E34C4CEED;
	Fri,  8 Aug 2025 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754684396;
	bh=/3QRMC2vD0qDAwbINPgYcIR1G66c5eVra2axNLfOSls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=REgt2giicXwp8zuPqp9iotG2WIT0mbu19Jdl2rNKrd2agDjYvNMb6t4huUnpqiuRM
	 aU5RTzxHJC09KKlUiwoCYDJJdnY96xRM4EqGksNftJuk6DqllKUE4ptvfGVHYqj6tw
	 H3AZfGZEp3tW8dhw9kpgg0RO9EGrnImJHLFip83jFEUW8bsoWwzVGRjhlGKrvONBIY
	 R4flG5ELzLTcaSSAgnaI2l46M40JprSAS9V4WX/jpl3s76aFORp/5bK4DqmLGMvM9G
	 BADtZKdJkHQ1akE0EfiVVuYeDblfxOi7DHrLAZgALPVniHmHzOCtkiJhtRa12VrWzG
	 McUIREqlo4Nzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE003383BF5A;
	Fri,  8 Aug 2025 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: linearize cloned gso packets in sctp_rcv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468440950.254982.15282866112466128113.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:20:09 +0000
References: 
 <dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com>
In-Reply-To: 
 <dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, n.zhandarovich@fintech.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Aug 2025 15:40:11 -0400 you wrote:
> A cloned head skb still shares these frag skbs in fraglist with the
> original head skb. It's not safe to access these frag skbs.
> 
> syzbot reported two use-of-uninitialized-memory bugs caused by this:
> 
>   BUG: KMSAN: uninit-value in sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
>    sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
>    sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:998
>    sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
>    sctp_backlog_rcv+0x397/0xdb0 net/sctp/input.c:331
>    sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
>    __release_sock+0x1da/0x330 net/core/sock.c:3106
>    release_sock+0x6b/0x250 net/core/sock.c:3660
>    sctp_wait_for_connect+0x487/0x820 net/sctp/socket.c:9360
>    sctp_sendmsg_to_asoc+0x1ec1/0x1f00 net/sctp/socket.c:1885
>    sctp_sendmsg+0x32b9/0x4a80 net/sctp/socket.c:2031
>    inet_sendmsg+0x25a/0x280 net/ipv4/af_inet.c:851
>    sock_sendmsg_nosec net/socket.c:718 [inline]
> 
> [...]

Here is the summary with links:
  - [net] sctp: linearize cloned gso packets in sctp_rcv
    https://git.kernel.org/netdev/net/c/fd60d8a08619

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



