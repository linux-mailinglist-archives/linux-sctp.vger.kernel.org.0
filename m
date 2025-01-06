Return-Path: <linux-sctp+bounces-305-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B27AA0333D
	for <lists+linux-sctp@lfdr.de>; Tue,  7 Jan 2025 00:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88D97A2576
	for <lists+linux-sctp@lfdr.de>; Mon,  6 Jan 2025 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6CC1E04B8;
	Mon,  6 Jan 2025 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS5p67aq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEF1BF58;
	Mon,  6 Jan 2025 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205619; cv=none; b=oD4myHF62zQcv55m7gQn0uJ42mxId3mPZSJQ6EBKO2vilw4YyIheLXT4F0Sfnu+eG/84rH/HOHtZV4iO8Udc1IisnJAVzs7rAHTTvPUwWeZT5tRzNIefEc4O8QUnIAmVADo4wT6f4RyrhxMy3jxxp0WfBeuR1djv6bcgz3eGSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205619; c=relaxed/simple;
	bh=v2Z31pb+D3DKW1tVr+VNOZ2I3zvW+FoyimSEvTATJ08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rf1Zm5X+TYn5tBChrIvgXCfJwbppooo9tgYVrW8hC6YlPbr6eusAtQOIEGLgVWr9/40PWr87XLMUW3t03J5FOQP6p5aAN/C/SmIkdNV6GS+89D/yyP9uZhTPajAEnbArGVnK4xYGeZpCYmTz9BAc7+3l7/kC5dskdAcfKTttGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS5p67aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3C5C4CEDD;
	Mon,  6 Jan 2025 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736205617;
	bh=v2Z31pb+D3DKW1tVr+VNOZ2I3zvW+FoyimSEvTATJ08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YS5p67aqkcBBsB+jd9AUKHDBd6GGqZYUmG4jM3ZArm5MaHyOo8SU6JQbHbBJ3nckU
	 6dt7w3Y5ma5BHZI6j4abfqY4NybWkXel+A1vTzydexquUJokLPX4e1bvmbmIdXs5vO
	 Bd3Xb0J4L48ZqZVdgEg4FzkzpcxR5gJ7Lq5elH3Z9FNDwH1aS5ZJvI6ASIoItB1Sbe
	 TcwS22NeS5jTichq59yyNIFleUi2+3qUWBh8mglTTGetCoCOIELH/Fky3pCOHG9mfv
	 m0BNEEzEnwmymNm/k8PhCObcMalu4IhQz1IIT73KWGt26vGdSrOaso4tk9pvoYKoda
	 17O3/BT/3l4JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF1380A97E;
	Mon,  6 Jan 2025 23:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t
 conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173620563874.3645633.11324978870881606097.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 23:20:38 +0000
References: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
In-Reply-To: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com, linux-sctp@vger.kernel.org,
 idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 2 Jan 2025 17:34:18 +0100 you wrote:
> Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
> that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
> variable. For the SCTP_DSCP_SET_MASK case, we can just use
> inet_dsfield_to_dscp() to get a dscp_t value.
> 
> Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
> to drop the inet_dscp_to_dsfield() conversion function.
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t conversion.
    https://git.kernel.org/netdev/net-next/c/3f9f5cd005f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



