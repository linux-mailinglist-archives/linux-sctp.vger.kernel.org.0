Return-Path: <linux-sctp+bounces-641-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF83BF4108
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 01:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C06918C4F20
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Oct 2025 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA53238C1F;
	Mon, 20 Oct 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2J3U4zK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F943EA8D;
	Mon, 20 Oct 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004224; cv=none; b=OJXOgUNs/niIUOM6vjQR43Qd/j7TbKZ5mF+9bzMig4OLsWyG0oi96EJLoay4wBsd9d0RENV+FovwVMH9Giw/icjxUd1Fu52FA7TrWiP8VrkuAwpcMZnNEVnvcaaxMmQG8vznRKjUftNVXpbxhL4IQwvy4V+zgYskUjoFFTdjieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004224; c=relaxed/simple;
	bh=I6sY7AN7V8Z8BYUg64U7j7nvW1Z8z4b+gQaRtfoslnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qoa4udZU1QdgDj05alT5uRRz4MAYX5apiMEVNdcL2UzA/9kOiJ66yw0pRVgZLJBw8ZTn2gZ9D9PENBw9SSCOFdmHIQqS7QDuEQLjiyhT9FeI9eZ9bS4A9pHikUTzk9vsNHCA9msxZoQAdmvF8yUEgHuABEPyX1cEhMpus2HDmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2J3U4zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE5FC4CEFB;
	Mon, 20 Oct 2025 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761004223;
	bh=I6sY7AN7V8Z8BYUg64U7j7nvW1Z8z4b+gQaRtfoslnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W2J3U4zKX09Ztpk1aav755qhxGug2Jd+fvzzc3JlABCC74fAjAQmIu8ByN9ReGZlj
	 pDv4O/hHH5uFPlPcx1JeWT8RXz+hBQfINUuXfBdGuwdXIQk26H3fwKDnJzNK8NaAvh
	 VF9nTPrmO9ceBR+SNivz6DtuqWXOk4LAeBKjdhqec/97w1Sts9o8USd0TYpsVKMG4q
	 lKo8Awr8VjZsc4f9blI74zWcYxHCfvmqxuqEUOO/1qLZz2EGy6YeMYoipg7/A5p1Cl
	 33uOU3bQjFw+rHDk02ROh6mhrCs+5ZchqftB7hCvw/uB9vL1K1udNvmFO+x2DxZfYW
	 EWS8E+C10i93Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCA3A4102D;
	Mon, 20 Oct 2025 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: fix server bind failure in
 sctp_vrf.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100420551.458842.8594143558422977698.git-patchwork-notify@kernel.org>
Date: Mon, 20 Oct 2025 23:50:05 +0000
References: 
 <be2dacf52d0917c4ba5e2e8c5a9cb640740ad2b6.1760731574.git.lucien.xin@gmail.com>
In-Reply-To: 
 <be2dacf52d0917c4ba5e2e8c5a9cb640740ad2b6.1760731574.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, liuhangbin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 16:06:14 -0400 you wrote:
> sctp_vrf.sh could fail:
> 
>   TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N [FAIL]
>   not ok 1 selftests: net: sctp_vrf.sh # exit=3
> 
> The failure happens when the server bind in a new run conflicts with an
> existing association from the previous run:
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: fix server bind failure in sctp_vrf.sh
    https://git.kernel.org/netdev/net/c/a73ca0449bcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



