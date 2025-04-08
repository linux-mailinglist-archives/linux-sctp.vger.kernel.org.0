Return-Path: <linux-sctp+bounces-485-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA54DA7FA22
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Apr 2025 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E654210A6
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Apr 2025 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57422267AF3;
	Tue,  8 Apr 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5A1IDII"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B060267AF2;
	Tue,  8 Apr 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105195; cv=none; b=llkIFgHLgxVXoiXmb5ZER3oYPi6WNKhxmfQrMULguMNxPpyD7ntZSjth6AwrqJ/0o/XVBKUPz0YelSeVni5PQO1kd983pXXAwlR2wCzs5Cl9Y+3mXIDiSdl8b4cFX6PonQUywhmeUW2zPmaoDxp3J6YUY8yVviFM6ytVN/9U/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105195; c=relaxed/simple;
	bh=3gDZsk2A3D/pEYugevyHrBygtLAgaecfyjqDZoJz+ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ohkyI2kLWLajYs2qNhbQ3xKZgLqMfsMyLPaqjI2U7m8C+89fhs7gR3HzQTjNgMoskQqmiSXEo4qiyap/ukKkVzqb6bf+UB0+8k+jJh7LYQGtYS1tQp6BSEysmDwgVi339ZCTk1OCrmRmIwEphAV5WWY+TaA/ZFg2yaO3hs5HhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5A1IDII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B36CC4CEE8;
	Tue,  8 Apr 2025 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744105194;
	bh=3gDZsk2A3D/pEYugevyHrBygtLAgaecfyjqDZoJz+ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j5A1IDIIFWFx4rOC3LpeaZaioc4nMhF8+bFl07kRiP6CCqTTKHa1YJPC2xFq4lwsF
	 Dr4NtEgGmcWtgVlQg+KbNKXAJOlbbSAR2FEAiq61TRol93Wk1eIa77PSS2DIABPfOb
	 A2rQ0ogTUc77v0mCVNurooK7EE0kuotI7daj34wrLy2GqR6J4aoqbUij+RxyRAz8pV
	 bwZRTZQqVvXF9aWbw3mwCOmiMbnoODuhkcfd9efzulrKh/vf6qNIj0YnFQc+NCxKxn
	 4D6G9dHTGfjbMojbiOzm39gxmZC5iK8NJHoExd3A7Oo4NY6Rf86WKcBSb1gTostdWW
	 cY7bIVp72yqLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340B638111D4;
	Tue,  8 Apr 2025 09:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: detect and prevent references to a freed transport
 in sendmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174410523201.1843579.6108769809547984395.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 09:40:32 +0000
References: <20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com>
In-Reply-To: <20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com>
To: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro_=3Crcn=40igalia=2Ecom=3E?=@codeaurora.org
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 revest@google.com, kernel-dev@igalia.com, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 04 Apr 2025 16:53:21 +0200 you wrote:
> sctp_sendmsg() re-uses associations and transports when possible by
> doing a lookup based on the socket endpoint and the message destination
> address, and then sctp_sendmsg_to_asoc() sets the selected transport in
> all the message chunks to be sent.
> 
> There's a possible race condition if another thread triggers the removal
> of that selected transport, for instance, by explicitly unbinding an
> address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
> been set up and before the message is sent. This can happen if the send
> buffer is full, during the period when the sender thread temporarily
> releases the socket lock in sctp_wait_for_sndbuf().
> 
> [...]

Here is the summary with links:
  - sctp: detect and prevent references to a freed transport in sendmsg
    https://git.kernel.org/netdev/net/c/f1a69a940de5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



