Return-Path: <linux-sctp+bounces-773-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10527D3ABAE
	for <lists+linux-sctp@lfdr.de>; Mon, 19 Jan 2026 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FAE830123C1
	for <lists+linux-sctp@lfdr.de>; Mon, 19 Jan 2026 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6FB37C111;
	Mon, 19 Jan 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuFRiVJa"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FA37C0FB;
	Mon, 19 Jan 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832528; cv=none; b=S+Bh6VLAy2JFvVKveWzTBzLe5Licqp3o57vz4Fjgsgtv6icfC5ro9YCymSK3lHwNdaMEXHhv5x0N5NzCIXJmi+gVRHc3KLV5CmlUIdqqc0GUWDy+Rf9JZPRpmV5WmpUOh+yaxPR8bDZ0LQ2kLCliVxcJIFvhjqYnBBA1VOSDIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832528; c=relaxed/simple;
	bh=69sXKoTlBiiO4UeEQzqSLMVHACYvBajo0H7/jA5i4pQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RA1/H697qpexT9oKvX/qlunC9PDAOLXANzQ+aNmMrCItfKIU6bjsAYzIwXbS4nq8xIVezXuhav44AXgtqeQzP8htyP12cRMEjM1YR767t1+VHR/s5G+2q6AE+RMGgFGHnY5JGuh8Ukg0hKVGt2v+/SOQy6wA5lNL4gw6dYfQRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuFRiVJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D6FC116C6;
	Mon, 19 Jan 2026 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832524;
	bh=69sXKoTlBiiO4UeEQzqSLMVHACYvBajo0H7/jA5i4pQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fuFRiVJaQLjxjYRxdxnkvrfcM3tzjs29yvEPQmESNyTZadqbcpgrEStBh/7Y4dWZb
	 hC80BWSpb/Lyu/gwsXmKT0vNEMy+ooBTUCcXaFvLfMCiPumwSahTefYSBdFZDR3tkW
	 qPiNy5tnzLAeORqStnppmWvfszwnbsjc2OheqzjR9R0551hBd6ozsiGhgV4t6ugxvi
	 SDFXJfAE+yR8CtnLdyQ4gPLOz02NF/X9JeY1s9qlE8UgxMwkgwXRaKL4CtFdQw/GoE
	 dREMJd8b+g9wxUgzZWYCEx8GsHS8KEa7CGLMQ/0MiXjcZo08/SP/MMVjenOkMecDQs
	 W4h0Em8KFp8Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A073A55FAF;
	Mon, 19 Jan 2026 14:18:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: move SCTP_CMD_ASSOC_SHKEY right after
 SCTP_CMD_PEER_INIT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883231402.1426077.8380219771898907922.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:18:34 +0000
References: 
 <44881224b375aa8853f5e19b4055a1a56d895813.1768324226.git.lucien.xin@gmail.com>
In-Reply-To: 
 <44881224b375aa8853f5e19b4055a1a56d895813.1768324226.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, vyasevich@gmail.com, chenzhen126@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 12:10:26 -0500 you wrote:
> A null-ptr-deref was reported in the SCTP transmit path when SCTP-AUTH key
> initialization fails:
> 
>   ==================================================================
>   KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>   CPU: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G W 6.6.0 #2
>   RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
>   RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
>   Call Trace:
> 
> [...]

Here is the summary with links:
  - [net] sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
    https://git.kernel.org/netdev/net/c/a80c9d945aef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



