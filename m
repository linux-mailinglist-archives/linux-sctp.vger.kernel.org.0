Return-Path: <linux-sctp+bounces-632-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 496CDBCC2A0
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Oct 2025 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 413AE4F0C84
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Oct 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E87262808;
	Fri, 10 Oct 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9/m0vvY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17928231830;
	Fri, 10 Oct 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085465; cv=none; b=T7Df6+iTokdMPESaJ4qVF+9rgtPiJd2aGEKibWeMrE/YrccsJNogrnWznmbBDxToEzNn632+tP8+Go1BbhjNW+Udgmmp7qZj6MD97b9gYtDhUsR0G+PiNy8hsDG4ngA42ECSIyky4uSHVvMZe+Qjl5HRnrfCAtVr13KLf64m5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085465; c=relaxed/simple;
	bh=5+7FAFQvEbx0nCLkl9k5jQtyt5DhxSRUiJ/Gon3zUFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HH5MNeCRt+aEA9VD8erASzC7lr+BU0Oypz+1HPrxIFlU4f46uGrBoPzfmrGvqY41oQW1Tc9cUZnGFvZSL6D+zvaFcuHGWLack+QwJB2HZFJ2deWHWD7Lf1PGEA3UDHVxGlVXSw7NTMi9ChQvc+AIyZGSBjOKmcq0Ilf7XwhDZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9/m0vvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A21CC4CEF1;
	Fri, 10 Oct 2025 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760085464;
	bh=5+7FAFQvEbx0nCLkl9k5jQtyt5DhxSRUiJ/Gon3zUFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T9/m0vvY6pD/wZxD23OK0RaeydTfP8STU+RO5s3m+5Ytdn0JDgwDQbyQFYnImRS7u
	 +/FNESYapAKiM3hPvl/TIJVPeDUbiXnVbDARbP5tqb2unWBTPBVo+Oh7AYaTu2308X
	 kqv2LEV9TCz8w8uwdww2dh63O+a/gMb0/+5U5NiYgs8fKwChbKURRqSBAi77jl1iDV
	 LH40Crz1kRpmQyjEy5c+DN6HxMAOb+1wV1lBks/IX2gk0HyYE1QBWRsipsqK+zdGWA
	 vMRnBdMK1KrzaFGm+IJ9ISwvPoRK5bmn0OjH0Dr3SX/Wpm7fpakj2dDCcrsLyXR7ih
	 pBCgjuv8vK+sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C823A72A60;
	Fri, 10 Oct 2025 08:37:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: fix null derefer in sctp_sf_do_5_1D_ce()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176008545226.469542.15958145151013253820.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 08:37:32 +0000
References: <20251009173248.11881-1-bigalex934@gmail.com>
In-Reply-To: <20251009173248.11881-1-bigalex934@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Oct 2025 20:32:49 +0300 you wrote:
> The check of new_asoc->peer.adaptation_ind can fail,
> leaving ai_ev unitilialized. In that case, the code
> can jump to the nomem_authdev label and later call
> sctp_ulpevent_free() with a null  ai_ev pointer.
> Leading to potential null dereference.
> 
> Add check of ai_ev pointer before call of
> sctp_ulpevent_free function.
> 
> [...]

Here is the summary with links:
  - sctp: fix null derefer in sctp_sf_do_5_1D_ce()
    https://git.kernel.org/netdev/net-next/c/2f3119686ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



