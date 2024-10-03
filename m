Return-Path: <linux-sctp+bounces-265-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA898ECF8
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Oct 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F611C217F2
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Oct 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92314EC4E;
	Thu,  3 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGGQZlVZ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138EB14EC60;
	Thu,  3 Oct 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951427; cv=none; b=mjUrh8t/dH39gr2TZ5bt3hacQCtNev8OUSatVuiHZjuQ/r7EMNCOW20amPrTmagWteey+NoXbKwm+p9RDBVyhleEIFaU+mcWsB9MvUhChhoYHSJwF5PlgdldmdSn8VBWdGK8a/880wLu2RMItZwrygIrbUXSMwqf1obtYthA/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951427; c=relaxed/simple;
	bh=WHb5EjIVqQZuPDTCAGFQUzBk26A6HlRGgsUc4/1davU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cw+O7IFQmHTPSlaD8AIfHKYsgz4j/X2O2Wy7eJwW6WvPpfI6+i8KPKx5iNxwue3AIA8fAfCo1UYOnKJ18rIIJYy/bmoQYvxwC8YfLERMfqmXU0r5yl9QngrR8hhk1RkmGFecc4rSKZqjDsc3HNZ3zoLGcUkgyns6/qkEza0mZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGGQZlVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5812C4CEC5;
	Thu,  3 Oct 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727951426;
	bh=WHb5EjIVqQZuPDTCAGFQUzBk26A6HlRGgsUc4/1davU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MGGQZlVZd6AhdKWmjKut5pJ7RTnC7ZknP3mDdPRBS2p3TbGQqyIkHd5YwKsTuB8PV
	 OwDK8UKYugdrgd7cJUlye2mBaaG62eCsziqycN+GcQFgEbs5gIC5m8G/z54cnnfPbW
	 idoc3xQ/UW9iKJ7bx+2oinclW2MQQAF5hcVdvqoMW5yx6pUFRB7sNXEXBV0/zF1FJn
	 d5uzvLGX4Cfispf8iVB4/dO2YjoHEGDySyD409lwyK9xspxW0RhQhTOGywKnvK2x0m
	 36TJrmTUWjdGrxFSUPWMiXPCZrWK8qmNUh5g2n9M4AXiWuiPLlXsNV0Hq2hgfTzYh1
	 PjuuPo64uapMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7F3803263;
	Thu,  3 Oct 2024 10:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: set sk_state back to CLOSED if autobind fails in
 sctp_listen_start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172795143002.1810156.3681345459806079483.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 10:30:30 +0000
References: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>
In-Reply-To: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Sep 2024 16:49:51 -0400 you wrote:
> In sctp_listen_start() invoked by sctp_inet_listen(), it should set the
> sk_state back to CLOSED if sctp_autobind() fails due to whatever reason.
> 
> Otherwise, next time when calling sctp_inet_listen(), if sctp_sk(sk)->reuse
> is already set via setsockopt(SCTP_REUSE_PORT), sctp_sk(sk)->bind_hash will
> be dereferenced as sk_state is LISTENING, which causes a crash as bind_hash
> is NULL.
> 
> [...]

Here is the summary with links:
  - [net] sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
    https://git.kernel.org/netdev/net/c/8beee4d8dee7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



