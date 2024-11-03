Return-Path: <linux-sctp+bounces-277-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F09BA7B7
	for <lists+linux-sctp@lfdr.de>; Sun,  3 Nov 2024 20:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C22F2813DC
	for <lists+linux-sctp@lfdr.de>; Sun,  3 Nov 2024 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926417DFF5;
	Sun,  3 Nov 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdgF8cZ0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A214F9E9;
	Sun,  3 Nov 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730663421; cv=none; b=P4fQJUx7mq6kDpJUANHpaaxhdTCuNrfRZyWEjf+0/SMubeIy8ALxOwhLvuhTRlIjYLL2u8GzTuQtn7AswHPle0GxHBgFT015wozZb6/YkNYEbRwo8QK3eEz1gstvS7pu0kIOTNLzAkm/x5s0Il8Ew3zWJ71THhW+Mh7HTX3ATuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730663421; c=relaxed/simple;
	bh=JQbnY43PrChKJLt7habydEMBSx27ekMiwbGzgRZo9YQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ohfdfmU6cmRObszEKz4pKjjExKaXCfU/3rREBmhMFIQ9ID5n49PgRv/S9QcQVAkkx9vLBILWE+Hf7hlfrRa0M4dPKuNbaUN7e87JiEiFncUIMih90UlT9XXpyIXG3x8bOXsn+rZKDoDGk1l648ii4cgyqy44b4TtfY40NyldUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdgF8cZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6EAC4CECD;
	Sun,  3 Nov 2024 19:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730663419;
	bh=JQbnY43PrChKJLt7habydEMBSx27ekMiwbGzgRZo9YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JdgF8cZ0Wi/24CY2PuMSO0v0b7Q9mGbjnPAaduLuA7jhwuOjio0SIr2zfx0W+Fu+c
	 m4kKQ1IxSFybTNI5XtfIWsPF6bMdvspjfD9DsQ+ivPKp+GsMnqRWNJvzyToIwprf9J
	 oraFfp52wvZ6SGxUyqmCQuju2EQgjWf5CqBz7cO4h32eUN/ET1IBsu5uEK3gMGoPj+
	 BJYdCjS6V0tZ/eRyCEnn2Tj/k2dulYZA6jN86dLKOQE8OXp35QIi8KMFxd6/84Rf6s
	 Y2qTvFxmv56IIK4U2CmRSV0upZd8Xk36WTkJzNgdBib2Dcol6PKPZ2fnkChy2ocFkV
	 Y/03WUq5mLiVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE038363C3;
	Sun,  3 Nov 2024 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: properly validate chunk size in sctp_sf_ootb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066342826.3240688.17815293611049051589.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 19:50:28 +0000
References: <a29ebb6d8b9f8affd0f9abb296faafafe10c17d8.1730223981.git.lucien.xin@gmail.com>
In-Reply-To: <a29ebb6d8b9f8affd0f9abb296faafafe10c17d8.1730223981.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 13:46:21 -0400 you wrote:
> A size validation fix similar to that in Commit 50619dbf8db7 ("sctp: add
> size validation when walking chunks") is also required in sctp_sf_ootb()
> to address a crash reported by syzbot:
> 
>   BUG: KMSAN: uninit-value in sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
>   sctp_sf_ootb+0x7f5/0xce0 net/sctp/sm_statefuns.c:3712
>   sctp_do_sm+0x181/0x93d0 net/sctp/sm_sideeffect.c:1166
>   sctp_endpoint_bh_rcv+0xc38/0xf90 net/sctp/endpointola.c:407
>   sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
>   sctp_rcv+0x3831/0x3b20 net/sctp/input.c:243
>   sctp4_rcv+0x42/0x50 net/sctp/protocol.c:1159
>   ip_protocol_deliver_rcu+0xb51/0x13d0 net/ipv4/ip_input.c:205
>   ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
> 
> [...]

Here is the summary with links:
  - [net] sctp: properly validate chunk size in sctp_sf_ootb()
    https://git.kernel.org/netdev/net/c/0ead60804b64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



