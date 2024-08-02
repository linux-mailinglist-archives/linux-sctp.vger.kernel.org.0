Return-Path: <linux-sctp+bounces-193-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F43946628
	for <lists+linux-sctp@lfdr.de>; Sat,  3 Aug 2024 01:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FA72834D2
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Aug 2024 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A931386D8;
	Fri,  2 Aug 2024 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsEP2s4m"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FD22EF4;
	Fri,  2 Aug 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641443; cv=none; b=VoBXTcUNhE28gEiOYS7rwO1XjEhb8rCaqbTnXOK5Na1ZSuY62OXhigC1V9iec3u9ow5kobopa2Nwj4XKuIeantGNVnpSeuThSIzWu+Ye491nCUk8HnWZ8JSd5U1BqtzXq2V64Bmg5U9IrskYY+hVD2JgIK45/gDbNbeIpzXyvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641443; c=relaxed/simple;
	bh=ombx/vDU7e6aHlagjh3TNbAoCag63PZ+EnbT0J+2y0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CxMtem4JjCas6hCp8/HLvpKhK41gmoslxCsj1Jk7wa4fsnow0a2KYwcRtiKoOKeq4zNkdqqQNIZW5S8CXC8qGTiVV9AKYbBGJEF31yGouO1c6SmiLoS96zzhxP7ZB/Bqh0eYRgHN4blGTJjjfi/hlHvsHZhpYz2owucXpzR3oIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsEP2s4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6BF4C4AF0B;
	Fri,  2 Aug 2024 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722641442;
	bh=ombx/vDU7e6aHlagjh3TNbAoCag63PZ+EnbT0J+2y0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QsEP2s4mn3KzBgU2sKZiftF5uWiJ+HSf1HVzB+rBZ2zSXRGRGpeDGJhvChaP9NbKC
	 T9K4CYSUxTTYiFnoz4piLQJf4DxqgQCr8JbdC2xOEyn1VArKaBWk1KPJH+s2AuYhO5
	 ds/TyP4kDZdPRmDu64rXkn3t6esNb95UIwPfeSi4uDUprG3o6jj/pNMOIvxllf3PTw
	 rO1hjg1OMgVfrG1d7ed1iMTJzyDDsJkHWJhgCnCGnhTDrNeexBTA0MpFs4MFGLTJT1
	 a4Y6OaJiOtub2IlQTXOevbRvxWMB1HkVAMVW9jYb25L/nJJE+I/4QTbmGtC1arIeVF
	 sr94KlpdS0LEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9498AC6E39D;
	Fri,  2 Aug 2024 23:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264144260.25502.3555531804004999359.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 23:30:42 +0000
References: <20240731234624.94055-1-kuniyu@amazon.com>
In-Reply-To: <20240731234624.94055-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 16:46:24 -0700 you wrote:
> syzbot reported a null-ptr-deref while accessing sk2->sk_reuseport_cb in
> reuseport_add_sock(). [0]
> 
> The repro first creates a listener with SO_REUSEPORT.  Then, it creates
> another listener on the same port and concurrently closes the first
> listener.
> 
> [...]

Here is the summary with links:
  - [v2,net] sctp: Fix null-ptr-deref in reuseport_add_sock().
    https://git.kernel.org/netdev/net/c/9ab0faa7f9ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



