Return-Path: <linux-sctp+bounces-621-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E91B2E091
	for <lists+linux-sctp@lfdr.de>; Wed, 20 Aug 2025 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4A660323D
	for <lists+linux-sctp@lfdr.de>; Wed, 20 Aug 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341D36998D;
	Wed, 20 Aug 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTs1lLk/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233236997F;
	Wed, 20 Aug 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702015; cv=none; b=pOau8KZy+RSVFjtMDRpmIBkzM2GNJOM3qXsrxtLXJGk/fTTYO/T1X3ljFVoEPDiIEZ68E9B3JYiYbFzVq42xab8YEytEUp1Tdi+r5fzIDbyBlrxxLdpMmnVnVoNNLRBfTR7CHg6XHc3MllHRPVWiFSZsqGPoQ4hwepRc56p+eMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702015; c=relaxed/simple;
	bh=djRjEZpHr3njE9TC9l8pfnazmpDUiF/8PuqxoqJGmOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A1d5JCHmJpUM/OkihhOY2DFaOX51EGElj4FThM2HVo3U62UkCX/MBqgKzMRQliHCG7RzqILatmLpFm7YFeXgrEsZKJ1crLvYCRm7aUU2X8LLxOuJswzuzQuA8bjqf+GlrNU07eI+BosIsK4N7kU+Uo2Bz4RohPWJ/xeL23Qrqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTs1lLk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B918C113CF;
	Wed, 20 Aug 2025 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702015;
	bh=djRjEZpHr3njE9TC9l8pfnazmpDUiF/8PuqxoqJGmOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hTs1lLk/syCdBejoyIk992U6msUJnqrC6Qp1RE+XZ0u2Nvm+w3RH/B1F7z2ciREu2
	 +MiOZVitfn6utxXoNaFBXXmj3xk7n5pbe5HaEqIqltLyOsgI7vI5VwqEaNik1Xv4yJ
	 iQK9UkjgFbU+lsrF8AoYNaolka6DO1FtBuh8bYY5he1czUpPrkRh8/vmbu9ALBqqBy
	 QwmA9jVzj/mxnkhbD7ZGA27cAz+0ZL1brUTyesV7eSQqZjZ9KpxtXYkHvF5sY+vu3p
	 Yc71dicMaTrF018aD9C+Mk8mOeVDWM+hVlfYyxYMVwNm6O2fTej0THyNCnX44Ze1zs
	 5DxHZX7q8Cgrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5A383BF4E;
	Wed, 20 Aug 2025 15:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] sctp: Convert to use crypto lib,
 and upgrade cookie auth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175570202481.267477.17609756872767538276.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 15:00:24 +0000
References: <20250818205426.30222-1-ebiggers@kernel.org>
In-Reply-To: <20250818205426.30222-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, lucien.xin@gmail.com,
 marcelo.leitner@gmail.com, linux-crypto@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 13:54:21 -0700 you wrote:
> This series converts SCTP chunk and cookie authentication to use the
> crypto library API instead of crypto_shash.  This is much simpler (the
> diffstat should speak for itself), and also faster too.  In addition,
> this series upgrades the cookie authentication to use HMAC-SHA256.
> 
> I've tested that kernels with this series applied can continue to
> communicate using SCTP with older ones, in either direction, using any
> choice of None, HMAC-SHA1, or HMAC-SHA256 chunk authentication.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
    https://git.kernel.org/netdev/net-next/c/490a9591b5fe
  - [net-next,v3,2/5] sctp: Fix MAC comparison to be constant-time
    https://git.kernel.org/netdev/net-next/c/dd91c79e4f58
  - [net-next,v3,3/5] sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
    https://git.kernel.org/netdev/net-next/c/bf40785fa437
  - [net-next,v3,4/5] sctp: Convert cookie authentication to use HMAC-SHA256
    https://git.kernel.org/netdev/net-next/c/2f3dd6ec901f
  - [net-next,v3,5/5] sctp: Stop accepting md5 and sha1 for net.sctp.cookie_hmac_alg
    https://git.kernel.org/netdev/net-next/c/d5a253702add

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



