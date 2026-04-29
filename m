Return-Path: <linux-sctp+bounces-1201-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMRJNvhf8WmogQEAu9opvQ
	(envelope-from <linux-sctp+bounces-1201-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Apr 2026 03:33:44 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E648DFE6
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Apr 2026 03:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7029307B4DC
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Apr 2026 01:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A1423ED5B;
	Wed, 29 Apr 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkhxHw5h"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD461632E7;
	Wed, 29 Apr 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426280; cv=none; b=ljABqxkxqltVu7c6OAFwEUwW03TCSk2MfArzbHexz5kuYdbCJog4A4NEpFymLCurDXqzrhTn4XsBP037xLh0sCOGj9Y/8zZTtSSOy/4X20zN1IwhwRIlmlRxrD9bQmde6X1JOVTdw8p4dg9auQtgggTNtnQ6SC1//k/By564i/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426280; c=relaxed/simple;
	bh=h89ZhOK/2rQgO5t9c/4hJ80hHOJV3qTYWpj9r/xokQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pK3tO8EkXKgRT97jekvtwUJYBqKiSLX/DctW/kQILzhf4gxSFXDvV+gMx9/HuAa2MNmVtjaoZPgxkFsXS9LbA50PeiZovQG+4l0wnih3TsOTDDn9Udujp1MS18iRtf27qM5XkRRCMkL7AUEXfSkslmU1Qh9ljDqqqtxLMNPT+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkhxHw5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108EEC2BCB7;
	Wed, 29 Apr 2026 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426280;
	bh=h89ZhOK/2rQgO5t9c/4hJ80hHOJV3qTYWpj9r/xokQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GkhxHw5hSueH+mFTZ5ORmH6pLrNTPAjf9pwATZQT0rWZSpnVL8AHiyPI1vGmYXb3U
	 7LQkdXNRA4QtBSdX9SqjibsC7PvEYoQ9r3ZqzqcKX2Txb3BgHkKAsxjSfKB/0VcNch
	 RggFqhkXq3CUya+yIh0lYC+UX7G5E6CZ1SiCsLU+I6Dt4O7ZWXsxlcOpa0q1JqdJCL
	 rBtRiqCa19RNFcTus5h+oXGKTQyZyZORBfEiOifKHUnIsaCTtI/XLEr8nkHBgrxdCn
	 v2rwp0E8tHKoUC2kUARzh2aru6DuwYdqyZU4oZMnQwe05fXgbIG79VFnb2yJ7JM6/N
	 2rQ7CaC+KVwdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCFE39302C2;
	Wed, 29 Apr 2026 01:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] sctp: fix a vtag verification failure caused
 by
 stale INITs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742623604.1288483.6985872404359862871.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:30:36 +0000
References: <cover.1777214801.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1777214801.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, marcelo.leitner@gmail.com,
 yiche.cy@gmail.com
X-Rspamd-Queue-Id: 3C5E648DFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1201-lists,linux-sctp=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Apr 2026 10:46:39 -0400 you wrote:
> Similar to Scenario B in commit 8e56b063c865 ( netfilter: handle the
> connecting collision properly in nf_conntrack_proto_sctp"):
> 
> Scenario B: INIT_ACK is delayed until the peer completes its own handshake
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] netfilter: skip recording stale or retransmitted INIT
    https://git.kernel.org/netdev/net/c/576a5d2bad48
  - [net,v2,2/2] sctp: discard stale INIT after handshake completion
    https://git.kernel.org/netdev/net/c/8a92cb475ca9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



