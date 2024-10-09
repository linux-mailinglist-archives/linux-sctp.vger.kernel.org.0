Return-Path: <linux-sctp+bounces-268-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89278996A3A
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Oct 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357821F24DFD
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Oct 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3505194096;
	Wed,  9 Oct 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA2mnX04"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAD1922E5;
	Wed,  9 Oct 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477627; cv=none; b=jdSc/GOSZlkgx0TAfdCtK2HTqNHhuNyVJDRFvEwbC8T49C8rEPLvLolBQPzSnF9TshtIlwptl9HHs1hMlCm87PEYwAOol6GUXpZk3sTXsIONdvKqDmjl8Tccnpu0TxygB+3NCNC8aiQKS7UHa0geVPHFGHvNGzJ2XY83SiRDGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477627; c=relaxed/simple;
	bh=Ee8cRUkaiYMDvin0hMYAT/ky5BHU1sTDYnZQ6aw5tOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ca6be6kLxjd1tzVe4byLbaAp2OBkGtFdotTauCVuMekr/23z3R0su6g0iF1/6D2+Tf6TDKgvPW0ctWQBzGjMqGVMhISn6vvsphTZRf0T3Yf9f/cLlAk/ztUrPeI8G3rhOLUnAsq8UY+Pp+VykGO75P4R+sBEWO+++G72rj9ms18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA2mnX04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E54C4CEC5;
	Wed,  9 Oct 2024 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728477625;
	bh=Ee8cRUkaiYMDvin0hMYAT/ky5BHU1sTDYnZQ6aw5tOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XA2mnX04ZPoNbYdhAF4SyGBo/opw07Pye37fxEWqSrrfaeDAudt1EWvfb7bIBplJJ
	 gk6jO0YQRQBvhIHcrJEMFyxnOmxk72OxUQqTcwLVkAJtPhuOiTiyqCr0i4Ee46WshE
	 noxEyJDZpMpSmfkSjrP+8X/06HOe76zlcDaHGMnf6umm1zf/nNQ6xmgdDuba+vYqC1
	 8csORjgNZHC0AYtjfSVPUjF4Va4gjdPkP3YUPSOvf/8GM9Ivn4BirKXKEF5jKzd8BU
	 gOhSNxfrCfx/6Kb91CzMUxLaNsv5JH+DwMCVIiE6f1phgvY7PjBzIJXEKvt1IwwLhG
	 ckV6LPms/Adfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC73806644;
	Wed,  9 Oct 2024 12:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: ensure sk_state is set to CLOSED if hashing fails
 in sctp_listen_start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847762975.1253149.9634978529186307261.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 12:40:29 +0000
References: <43b03d2daa303fee1995f6b16f5003a1fc0599bf.1728318311.git.lucien.xin@gmail.com>
In-Reply-To: <43b03d2daa303fee1995f6b16f5003a1fc0599bf.1728318311.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  7 Oct 2024 12:25:11 -0400 you wrote:
> If hashing fails in sctp_listen_start(), the socket remains in the
> LISTENING state, even though it was not added to the hash table.
> This can lead to a scenario where a socket appears to be listening
> without actually being accessible.
> 
> This patch ensures that if the hashing operation fails, the sk_state
> is set back to CLOSED before returning an error.
> 
> [...]

Here is the summary with links:
  - [net] sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start
    https://git.kernel.org/netdev/net/c/4d5c70e6155d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



