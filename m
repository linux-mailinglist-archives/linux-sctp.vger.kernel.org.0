Return-Path: <linux-sctp+bounces-564-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEBAC5EDE
	for <lists+linux-sctp@lfdr.de>; Wed, 28 May 2025 03:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8047AACC1
	for <lists+linux-sctp@lfdr.de>; Wed, 28 May 2025 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915A1BBBE5;
	Wed, 28 May 2025 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1MoSAw5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CC1B0F1E;
	Wed, 28 May 2025 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748396395; cv=none; b=GvyaNPEzR+rcX46FAyeoollPmXFS33R2207nBNGEWM4EUYZBI2i+mpT+bdHa/0XegqTFerrdHyJbFMOSUE8HDDqSkAZograXw2AWc6WIq3Q1WXU3JO/R2iYZDYDqRqCK3kJxKjrw1jU5tLQno1cL9xGOgqsVHejJMcjRDKa540Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748396395; c=relaxed/simple;
	bh=flw3Isy+ywHt9GsOR8idcRLbhPy4esufuq17o10W1Fk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dji+BdBIyW9wj7BRo+63+EhKdeYoALkCMFtryxON3Zt2sQd2V8Ak7MnWY3Qkps7G19n145KwwSuj2O0lXZ8nvPiK/V6d+VyzrHi2fc6NXbRow6QaFtSpt1v3RvHT3fSxSVOa7zB4R9901HqIlr9qM4j2F18AZC/MmATN+XxESsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1MoSAw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192EAC4CEE9;
	Wed, 28 May 2025 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748396395;
	bh=flw3Isy+ywHt9GsOR8idcRLbhPy4esufuq17o10W1Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1MoSAw5pAfkK9zgZSyZMYmQvH4yFsrczJ0S54dIxDydcQHgPd2u2Tl5r/U3YQZG7
	 +2kyXAOsBpUrm3E/4/aQni1U6BOn9WA3V70UzSItIT0KyZLEVwVPIYz+ZDQGSNXjDl
	 uM39wG8GVgvMpcuBgHG6E5FHuP80Vk40YCU8a7WWN803rhlbhcX5pbLZzm6NVZZF9R
	 yK2LPHZlF13k+BpvNfh6DroOBYkzLff8QhQ+aDNh690RkKDfLqITZkI2N1si47gc4q
	 a3BQ/6zN5yk9Qn38kraXX2xHV7kekyod/1KNTCaM2xpvu79I9aLofq0Ckuu8KMc2KM
	 XDnCW7ghAk8CQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710E03822D1A;
	Wed, 28 May 2025 01:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: mark sctp_do_peeloff static
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839642899.1854922.15647234054812276998.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:40:28 +0000
References: <20250526054745.2329201-1-hch@lst.de>
In-Reply-To: <20250526054745.2329201-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 May 2025 07:47:45 +0200 you wrote:
> sctp_do_peeloff is only used inside of net/sctp/socket.c,
> so mark it static.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/net/sctp/sctp.h | 2 --
>  net/sctp/socket.c       | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - sctp: mark sctp_do_peeloff static
    https://git.kernel.org/netdev/net-next/c/33f1b3677a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



