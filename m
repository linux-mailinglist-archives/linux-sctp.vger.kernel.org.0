Return-Path: <linux-sctp+bounces-30-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03128568A6
	for <lists+linux-sctp@lfdr.de>; Thu, 15 Feb 2024 17:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F6CB212EB
	for <lists+linux-sctp@lfdr.de>; Thu, 15 Feb 2024 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB70133988;
	Thu, 15 Feb 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1iZzhPJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705053369;
	Thu, 15 Feb 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012831; cv=none; b=u3Bb2Vy+n4VfQZZGxiA1Hz8KVY4CJwcfxYx6/OxJt7pO13OP+Ho+mF2B3RhDEukKVpFaqbn+2D+OgexxH+uahinCeJYtWcAw8WAbeLMPyuup01LIAqmikHCUv+ssGBhMREJT6vc6DgJRk+fUsOOyM4MrHLZLu3/lXNn5JaSFuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012831; c=relaxed/simple;
	bh=jVl6RIQfO+ykWLPFOq/qj8zG4RmnkDO0QquABQhgzCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fZPwDbM5G6WCZjEOsBRIWBFWZKT57ToP8GhEWF8sCR7XD4AuLzcH80jNgQgo50NMgNsilkXTzdz1wg6Mc45bYumk+6AlJfRkTFTYorcsWd2WeDxvhipnKC6EioCzEOBxGreztVWGbbXc19U8TsrWZTbrU5bCnFBX8ruEBEuVfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1iZzhPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13595C433C7;
	Thu, 15 Feb 2024 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012831;
	bh=jVl6RIQfO+ykWLPFOq/qj8zG4RmnkDO0QquABQhgzCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K1iZzhPJTrSCg6ftU4a1RQcUyxoF4Bl9FmTf7RB1L7LM9m7DTusFPUMjbh87yippQ
	 Wfn0hfnQkWMKACcNLWHHiLfso23vjfF//CPOKyYTQjzcsDXosVzruq7h20Kj1lfRYS
	 8KxOhEew2ZNOvw4QFXjGIJACfpSKOMGPd/sGXLjkXyWHf33LHcGJvwRsIpyY9ws/I3
	 iSrKYmL1RDi1ZGaBS+xxhjFFDYSy6EzOz7darQUOvdBr8eNNJz8LD6zuhYPVkxamBy
	 MCNVV0ndjrQTLU+JTnCfZhBCzs9fgEJTrdA+pD8/QInVGxxx3kzM7zg9aXikbaP8Xk
	 v94knrCMLpZ5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED7ABDC9A04;
	Thu, 15 Feb 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v3] net: sctp: fix skb leak in sctp_inq_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170801283096.9967.10675822819256962996.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 16:00:30 +0000
References: <20240214082224.10168-1-dmantipov@yandex.ru>
In-Reply-To: <20240214082224.10168-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: lucien.xin@gmail.com, kuba@kernel.org, marcelo.leitner@gmail.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Feb 2024 11:22:24 +0300 you wrote:
> In case of GSO, 'chunk->skb' pointer may point to an entry from
> fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
> random fraglist entry (and so undefined behavior and/or memory
> leak), introduce 'sctp_inq_chunk_free()' helper to ensure that
> 'chunk->skb' is set to 'chunk->head_skb' (i.e. fraglist head)
> before calling 'sctp_chunk_free()', and use the aforementioned
> helper in 'sctp_inq_pop()' as well.
> 
> [...]

Here is the summary with links:
  - [v3] net: sctp: fix skb leak in sctp_inq_free()
    https://git.kernel.org/netdev/net/c/4e45170d9acc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



