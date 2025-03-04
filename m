Return-Path: <linux-sctp+bounces-375-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD4A4D16F
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Mar 2025 03:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE57017355A
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Mar 2025 02:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4663153836;
	Tue,  4 Mar 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF+czT7R"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639333D8;
	Tue,  4 Mar 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054202; cv=none; b=HRxzW0BiX1XIdvVtX8waMkUg80RrRFV2sHC7AsYP4oKbmQmM6m16lcfZmJUsPSO2T8UkMn6igZ/iq17xB0cYhyDPfj8OMUSCiJkxpKtwtBaozDMWIucsDkOoaKq8/qb4tdvDQBa0sZmttVUtOEoAjb2hg64XfvHE0TEdTVYqTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054202; c=relaxed/simple;
	bh=gDz7jPKhwI5o2NYRXck79Ja6LSh4lD7YLzweCdtUnHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L7rhXmeWTgKpihZXv9YOfPG8XjqOy8104isMQRMw3JGHuZy214DxX4Ww1LlnzLrRCij0vEMcP1fxKB1qTK548KYp+TzzsdzAFeWCiguBwzxa7woGDSLPQeoODznFCKm64JkLu6p7XN3wqxNxivBrCHWSttgYDZS6cxLyFPDfMnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF+czT7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B749EC4CEE4;
	Tue,  4 Mar 2025 02:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741054201;
	bh=gDz7jPKhwI5o2NYRXck79Ja6LSh4lD7YLzweCdtUnHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hF+czT7RBf8iRMo8I5kGAzQP8gyNHC3T+7ZKirsaUXcKyryxv37EK9xWGI5ZAXfDh
	 PtbU9RIjr9MUmU6+MN9NSs76fkabxehgccisQFY3MSw62LGgUpYhqbWj+sh2Q3NuLF
	 NNV26Nf3CGW3OO9UcaNXcZGKfPEmy5ouwsx1hElMh0xl+vH5xdtxFioUks5UqHL30z
	 4XyuWTDKPH+oTr9jghc4SpYokZp9R7ddA6nPJEmzpP6QWxeJGf4rhSUwsoCQ60JEgj
	 9EmIK2grIOUffvTr9bvZat84/HigDOufqsP7lJ+n+2pZLB8uBO4RNIBqVX/hsBcwGO
	 7Cutr1U8uEB1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE63380AA7F;
	Tue,  4 Mar 2025 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] add sock_kmemdup helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174105423423.3834266.11247119550844608140.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 02:10:34 +0000
References: <cover.1740735165.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1740735165.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 ncardwell@google.com, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 tanggeliang@kylinos.cn, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-sctp@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Feb 2025 18:01:30 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v2:
>  - add "EXPORT_SYMBOL(sock_kmemdup)" as Matthieu suggested.
>  - drop the patch "use sock_kmemdup for tcp_ao_key".
> 
> While developing MPTCP BPF path manager [1], I found it's useful to
> add a new sock_kmemdup() helper.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] sock: add sock_kmemdup helper
    https://git.kernel.org/netdev/net-next/c/456cc675b6d4
  - [net-next,v2,2/3] net: use sock_kmemdup for ip_options
    https://git.kernel.org/netdev/net-next/c/483cec55c1cc
  - [net-next,v2,3/3] mptcp: use sock_kmemdup for address entry
    https://git.kernel.org/netdev/net-next/c/52f83c0b5f85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



