Return-Path: <linux-sctp+bounces-175-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C59255E1
	for <lists+linux-sctp@lfdr.de>; Wed,  3 Jul 2024 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A21F25F9C
	for <lists+linux-sctp@lfdr.de>; Wed,  3 Jul 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA813B2A8;
	Wed,  3 Jul 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1Dmcnfn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13747136E1A;
	Wed,  3 Jul 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996629; cv=none; b=OsjGzHykrl5YP20UINMjdq/j2AazKNKxIa23CBPhmvYasf596S7hDnWj4WJk2CZbp2JMWhoqjdjLHpld5/93i46sTlBYIfbix5wdIVrtqwVEah+g0EO5Z45t5AgKlgF0TzxPkYRIZ2SdpXJiXVHP8XM2AHd/JTnrJFfnwEmnOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996629; c=relaxed/simple;
	bh=QpW/y9mR6h/dZGgMgi6r9Baz55Cpel64JOPR19QFtcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NHNiDhCrDOthpzilmYkSgsWlGaJCToZ+NS1MWUHtgyshslD6VwOSAxbDfNoeVVN4WYu38J78fbAWllOVBFju/qgqwg5t7OBtJd16xFK1qp54BRAMGdHCkgR8tKeubTcTcYGI7xIlH53DgFq++spzKBYfMv0SacqBBPt4Q4/T2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1Dmcnfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EA46C4AF0A;
	Wed,  3 Jul 2024 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719996628;
	bh=QpW/y9mR6h/dZGgMgi6r9Baz55Cpel64JOPR19QFtcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s1Dmcnfnp84NT9c4uuQFsxS3lYZ/7ZDtctCSoPkbFxt89BvZfY2A8+zcFQh8ygw6w
	 L2k7NhNe2kbJQNWklfhDGfWWSMoIjf/sS+sIyPmEv9xSjmz6d0R0ZHUW/5OqtJp1Qh
	 8PkjI80K+zKZc2nsKtzviE/6TUba1TRq+CCvtpleoKTivu/KEOXxt592I0jTak+Zcw
	 W0MArVQZ8AE3a/HFAEKRacSpGo0fMk5BQ4Y8ZVyhNK84HGN1Qs40FEdH+aMm2nsfUc
	 NB1UHJDptki0+WllAkbQDPbFly6hcCzJ0D7nRAOpMdQ7diARiqV3EGgI04/50cOfKH
	 1tPIKAnaiZCyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89349C43446;
	Wed,  3 Jul 2024 08:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: cancel a blocking accept when shutdown a
 listen socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171999662855.24990.17495213341507066699.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 08:50:28 +0000
References: <ee35ac9d519708ea0ba16f8288e42f215a0dbbcf.1719856129.git.lucien.xin@gmail.com>
In-Reply-To: <ee35ac9d519708ea0ba16f8288e42f215a0dbbcf.1719856129.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 marcelo.leitner@gmail.com, david.laight@aculab.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  1 Jul 2024 13:48:49 -0400 you wrote:
> As David Laight noticed,
> 
> "In a multithreaded program it is reasonable to have a thread blocked in
>  accept(). With TCP a subsequent shutdown(listen_fd, SHUT_RDWR) causes
>  the accept to fail. But nothing happens for SCTP."
> 
> sctp_disconnect() is eventually called when shutdown a listen socket,
> but nothing is done in this function. This patch sets RCV_SHUTDOWN
> flag in sk->sk_shutdown there, and adds the check (sk->sk_shutdown &
> RCV_SHUTDOWN) to break and return in sctp_accept().
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: cancel a blocking accept when shutdown a listen socket
    https://git.kernel.org/netdev/net-next/c/cda91d5b911a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



