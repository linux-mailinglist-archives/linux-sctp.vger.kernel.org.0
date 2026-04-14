Return-Path: <linux-sctp+bounces-1180-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGSVIv+F3WnvfAkAu9opvQ
	(envelope-from <linux-sctp+bounces-1180-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Apr 2026 02:10:39 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B023F45B4
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Apr 2026 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0929C302172B
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Apr 2026 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F23FFD;
	Tue, 14 Apr 2026 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmUIj45N"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5554186A;
	Tue, 14 Apr 2026 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125435; cv=none; b=T4qwOnDU/MdZknLoN4JxhfdLbZ93g4qacsdBIXq18AoH44snUgWQ15iYwLeOfEJHlXUew22TDVYRqn0agEiTIMx+9qgUiVPxk3kWq9HMe3dFhcygicAFiQ8ynefrqoUryeMntZtImRtA+3yJ8GffiMAP21Myab2MT1NeKkyWDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125435; c=relaxed/simple;
	bh=odzBk0d1cxJ7qIPUl9GfrbC9f6IsJQUZWUHQdvegsP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=umOevmIga7QJKbgpKp2cTeR4tXSp2hTBMvdYytbsPsMJ166ZEFcnr6Pra08Zoa8/IX0EFYKBH6Bh6RR9QSXh338OrM3K/MVFi+XCADAGRXJ8CuDW2eQYNaKi6OnW3nzIrub3O8rhqoyztCwbZnr0Ck0HOcmuvPnXVv7cfRQShlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmUIj45N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F00FC2BCAF;
	Tue, 14 Apr 2026 00:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776125435;
	bh=odzBk0d1cxJ7qIPUl9GfrbC9f6IsJQUZWUHQdvegsP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nmUIj45NP2n2mJmArsMEHrHgVmgYujiiLpYLiMUDoHtU2kUClUzRhHd7juLnxdl+/
	 HTLGrLxROYmRrDAMdbl/Cdf3Il5WaFaKsg8keFdhVHGPduaKDZwloqiW4p6fiA/jjh
	 pSObihhh+L2tBso5rm2/9O0s4xO9bvy+4nDgSyUHBx7VGE1AyagDZG7TBUByyNGmCx
	 g8UqTs3euIpe7qaETI2hpAY0/LBvZQDKFEtZ8p2ghHipFb72oMgUpjrWZUM4HB6zU7
	 qrhANMtsyknHvXQs9Z+JYeJYPivITXH44NyK3n66G5LzHk/y2Ds7lvoWeo2UofY5Bo
	 JIilWWqLfAjvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EB33809A0B;
	Tue, 14 Apr 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: disable BH before calling udp_tunnel_xmit_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612540655.609150.13642676010473271907.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 00:10:06 +0000
References: 
 <c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com>
In-Reply-To: 
 <c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, bestswngs@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-1180-lists,linux-sctp=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5B023F45B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Apr 2026 14:15:27 -0400 you wrote:
> udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
> BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
> tunnel xmit functions"), on the path:
> 
>   udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()
> 
> dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.
> 
> [...]

Here is the summary with links:
  - [net] sctp: disable BH before calling udp_tunnel_xmit_skb()
    https://git.kernel.org/netdev/net/c/2cd7e6971fc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



