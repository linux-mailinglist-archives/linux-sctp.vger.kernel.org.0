Return-Path: <linux-sctp+bounces-715-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7CCC1285C
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 02:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4D6E4FD075
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D22253EC;
	Tue, 28 Oct 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzmcPUpK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A422236FA;
	Tue, 28 Oct 2025 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614452; cv=none; b=dO/3ycecrUUSCuSiYpGcSNIvAmdhFE7gspPbTs7yScgAJ9lYFTLAEeq0Z0SRrq1NCfLoD7q4khueJIXXNR9bfIYv3pXRwSIypHRZYGB/vIT9CqnvOYKIBJBIbM96a8zwt3us1pQmy9QgM4ExAxgyq+q7tXp0gKSmSHTDAUenVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614452; c=relaxed/simple;
	bh=yrcBwH2XXOkOdtxLeN4gWFNmIm8tCpGg1cn6gXY9UDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zo/4S3pD3EJH+A5/vS6tnDEb1DlLz0hvUhGHIq9Vh05BFk5jy3pVIsmJRCTguvc2+3Yd6yYqONQV11FR/4vd/pduD/02SLHnM0616BrMLZBFWU5H8S7egZzx47D64hPJDfRM1Ir5X2+m74ekPvwZBnS987aNg6yUhmFMDnmx7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzmcPUpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C7EC4CEFB;
	Tue, 28 Oct 2025 01:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761614451;
	bh=yrcBwH2XXOkOdtxLeN4gWFNmIm8tCpGg1cn6gXY9UDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KzmcPUpKt8vwH07caBjcJ6bq6gqr1breDACWYwlbOlnOVB6r+Y80NqX9O3IM8kXoZ
	 QxtIFTHeEUvbD4Km84UvCY02UD2C/juINQDHLHHCl4CJAUizRQHGhqZ0hfD60vi4fF
	 CMTMSh7IPi7sMIPOEvZ0qILV0nKB1Vzd+AhWkm1Ba9hDbDNpqHauxR0/Mg9idyAzZM
	 gLebOUFH5l2jl551EdztMnw392kv0I7Lywi6ih5Vl/EnjKhoNfeaocrNpPscBWH5xm
	 wrqk5Ha1z+FcGJonI3biNhM14X+CZJq7Cc8c5lXZqdw1KAQUQmFVMdC0bfIBFKE7D7
	 7yd2UPdjwt8AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09C39D60B9;
	Tue, 28 Oct 2025 01:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/8] sctp: Avoid redundant initialisation in
 sctp_accept() and sctp_do_peeloff().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161442950.1651448.1798701747287698660.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:20:29 +0000
References: <20251023231751.4168390-1-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, linux-sctp@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 23:16:49 +0000 you wrote:
> When sctp_accept() and sctp_do_peeloff() allocates a new socket,
> somehow sk_alloc() is used, and the new socket goes through full
> initialisation, but most of the fields are overwritten later.
> 
>   1)
>   sctp_accept()
>   |- sctp_v[46]_create_accept_sk()
>   |  |- sk_alloc()
>   |  |- sock_init_data()
>   |  |- sctp_copy_sock()
>   |  `- newsk->sk_prot->init() / sctp_init_sock()
>   |
>   `- sctp_sock_migrate()
>      `- sctp_copy_descendant(newsk, oldsk)
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
    https://git.kernel.org/netdev/net-next/c/622e8838a298
  - [v3,net-next,2/8] sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
    https://git.kernel.org/netdev/net-next/c/2d4df59aae91
  - [v3,net-next,3/8] sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
    https://git.kernel.org/netdev/net-next/c/b7185792f80a
  - [v3,net-next,4/8] net: Add sk_clone().
    https://git.kernel.org/netdev/net-next/c/151b98d10ef7
  - [v3,net-next,5/8] sctp: Use sk_clone() in sctp_accept().
    https://git.kernel.org/netdev/net-next/c/16942cf4d3e3
  - [v3,net-next,6/8] sctp: Remove sctp_pf.create_accept_sk().
    https://git.kernel.org/netdev/net-next/c/c49ed521f177
  - [v3,net-next,7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
    https://git.kernel.org/netdev/net-next/c/b7ddb55f3127
  - [v3,net-next,8/8] sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
    https://git.kernel.org/netdev/net-next/c/71068e2e1b6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



