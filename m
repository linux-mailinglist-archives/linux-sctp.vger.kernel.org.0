Return-Path: <linux-sctp+bounces-342-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94A5A34B3D
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A213B6645
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C816245030;
	Thu, 13 Feb 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS3GpLPS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20524245029;
	Thu, 13 Feb 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465411; cv=none; b=Ms+cpEtxVM4DlxMGfzlOu8VLl6deQg23WBpynUPiA176fZbAKMjntkJo2xZi/hMqCDd1aaR4bAAwFSYNxlPpZRC29YNL0HUzASzmHoWTjNiSNExaNqz4GSTi33k+mqAQso6vRMd5+ONShNDH1NpX59FIbJqlER14G+ebmL2KRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465411; c=relaxed/simple;
	bh=wVRUJW0e3QS5h6vZL/XOGPhvMENMUgZ34deORxSJCmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gqAUr6Nc0jy6TsyNWvGI9Fo2XRnddMbZifFNQpw5E8UY52DlHi8keC8SoervvWQGJwqew5hBd53iBS3mkYS9Kn8WK4TLcKksv3o0G0IjCwSUrY9Vm2dS3ohaW8JHvGSxM0d4NUrmYTf3Ua8ZynkQ6pqAcyKEe0GL08QxYUA3fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS3GpLPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FE0C4CED1;
	Thu, 13 Feb 2025 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465410;
	bh=wVRUJW0e3QS5h6vZL/XOGPhvMENMUgZ34deORxSJCmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RS3GpLPSbWEJynhx5YlHQC5U/FGlFmSKjKMwQJPc7Vx5wek7ptJapiqyklsZm9s2A
	 pHJx7NsMVaa4fMDaqcc6d4TsxSmGwJKIEhZ8lDBTE38JRk+Wrf2qK/l71F5e60M1gS
	 tPhG1l2gCPMckXR0ZVyWqdWMYKzB7Z91kAiNpccypj2qfWx3Z++1DyBB47/LIGNCma
	 xAAgy2thk+JEr+jxVW7tw52wxoBT0qCQrMFPWuP6DXiu7SapT9MzP2ZGOLigvMQZsm
	 2O/UUOioB/RKo5klZE6+jb9iBHqs7OaIrSIae8Lh4SjwWcKZlQdygaJrQEfw9ej0FF
	 6XizU+X5m8RsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2DB380CEEF;
	Thu, 13 Feb 2025 16:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove commented out code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946543949.1295234.12177039099324481218.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 16:50:39 +0000
References: <20250211102057.587182-1-thorsten.blum@linux.dev>
In-Reply-To: <20250211102057.587182-1-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Feb 2025 11:20:56 +0100 you wrote:
> Remove commented out code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/linux/sctp.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] sctp: Remove commented out code
    https://git.kernel.org/netdev/net-next/c/34dba73b231f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



