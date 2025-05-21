Return-Path: <linux-sctp+bounces-547-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E28ABE8F8
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 03:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315477B5DFD
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BE190472;
	Wed, 21 May 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozhp8qRN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA918FC80;
	Wed, 21 May 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790420; cv=none; b=clZw1ZMqlHWQcYhcU7LcN/OomA7ycv3NP5Iyod5KHForHIzz8FgZ61zrKwa8TDUmgbhpncoUJcG7JD9JyvRHiM6lQu3LP7DEGiMNIJ2Oum9NIjeKSqT1lg2u/2h5qCXsqYZLPlzUXl9gp+449uPltIporFJ35drWwgWyvpytptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790420; c=relaxed/simple;
	bh=X3CVAGPtJAeUMBOAhMThiN5wbimJFSIBytMVTLCCCsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l0flLVx+wL2wHbsIww2IHkkrLanpxuqtsXfDYyhQeKa5AzC5PjD4VxW+XlcXdKfQLWi45xc8+kZrNPTion3xBV/RR5fogJf/29OK1jI44wGtLyAG5b0OLbUfUeUSfqwj3nGpVxbBB9CO/BlR+tjvIMlfqRQ/co3U7byC6VbRDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozhp8qRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E80C4CEE9;
	Wed, 21 May 2025 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790419;
	bh=X3CVAGPtJAeUMBOAhMThiN5wbimJFSIBytMVTLCCCsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ozhp8qRN43gjD0eESqhjCzep/HMLodsCUPy9+5FFuWDyE6z5k5uf63Q2wD7e0JQLv
	 cKdHrgEvaidVysDoFXE7TW+AeU4ITMG0MqNz/pC7Q4pCkjOxcZJk2Lat6wnvrgTDkb
	 SmM7EcRbmSlnZ9rGHHOZggAeiZWZIKF4RNZYX55PQ1DTUiC/mJc1ms/amOPFqXolv8
	 oEXTzN2dx3b2QDKCOWqhslMKb/rGMVtYzV/VDKUbC4oXzSBPbHOFlDDr/baXhMjMao
	 1HCqQ8SMg82CR5zUL3CNkEn0/rmxa/lrb0ZDPggH0MqA5pYmbbW/DI2mzwpkCoLeFx
	 SBYTxRHLHjz8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6D380AAD0;
	Wed, 21 May 2025 01:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: Do not wake readers in __sctp_write_space()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779045574.1526198.16807580460563727004.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:55 +0000
References: <20250516081727.1361451-1-oss@malat.biz>
In-Reply-To: <20250516081727.1361451-1-oss@malat.biz>
To: Petr Malat <oss@malat.biz>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 10:17:28 +0200 you wrote:
> Function __sctp_write_space() doesn't set poll key, which leads to
> ep_poll_callback() waking up all waiters, not only these waiting
> for the socket being writable. Set the key properly using
> wake_up_interruptible_poll(), which is preferred over the sync
> variant, as writers are not woken up before at least half of the
> queue is available. Also, TCP does the same.
> 
> [...]

Here is the summary with links:
  - sctp: Do not wake readers in __sctp_write_space()
    https://git.kernel.org/netdev/net-next/c/af295892a7ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



