Return-Path: <linux-sctp+bounces-1282-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cZ0OHmI/O2q2UQgAu9opvQ
	(envelope-from <linux-sctp+bounces-1282-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2026 04:22:26 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F246BAE99
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2026 04:22:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NCaqVmmQ;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1282-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1282-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73CE30C589F
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2026 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4072F5A13;
	Wed, 24 Jun 2026 02:20:59 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C862F7EF8;
	Wed, 24 Jun 2026 02:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267659; cv=none; b=fBGDDdQiixJ6s0Bx+n/xUNtIWsyWdRmG36bUffNZPvN3YSimQdX4stRh3enJOxvW0NMVdKSmnlwRzttk6NHqFsGYAetpesokK7ZJMF1dcQZAIwKSZIR5iwe8cJNMmA+V+soHKUEC0x2KWzXSNwmYD9b9nMwl9X+77Lrgq8Gx6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267659; c=relaxed/simple;
	bh=S8mQWUG2xdWqD0xKmTxiVna4Q2173cdbX3sJgid8E0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ef+RFtnXIllEYg3fHa9/oXT4MX7Qg8byKjucAKaxoItem/A15KETLFY5C0Dlm+RLkW2mLGtEk242hugBLUoJw5VjSzCkk3OoXaamPR8h6gphw17kJPszxB7ILJao4jgBpDwBgvT9NAsKpsO/r9COl2q3KtmDmIAxrp4d1HmIyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCaqVmmQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02CE1F000E9;
	Wed, 24 Jun 2026 02:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267657;
	bh=20qhPFs4jfS6A2FZHHt9pJpxY+Ulu5XXoPBBKDJcdHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NCaqVmmQmAOd7/v9XIjsFrOKoZyv8UVia1oCSIJYhPCq6+VxPITgSOh7Rw7Wuycr7
	 gfp0yGaMjMhlqkvEvSv9F8yPQ/qaxtNWddg2KW9fNB0XpeFUaCsVHEYoERAFZ5l3S0
	 3j5u145fMOTZzg4DNvR962p8zRIjihhSe1vYfMKclmbEu2J/qciYluWv7rEEA2hu90
	 7UaoftLsmQhyBA1LyipixaUH8f8gbIYlOd5SOzYs3vh0GS+e4BJvEZ9SGTFqBW2e13
	 NE5Dd/v1beddo9WiSHBDGAGBR7We3J1K8ALUxV9zMs0c3OvlCY1KHpm8Vunelw960W
	 98FT4czApFbBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568DB393102A;
	Wed, 24 Jun 2026 02:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: fix err_chunk memory leaks in INIT handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226764683.2513445.821387304486136433.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:46 +0000
References: 
 <0656704f1b0158287c98aec09ba36c83e4a537ab.1781970534.git.lucien.xin@gmail.com>
In-Reply-To: 
 <0656704f1b0158287c98aec09ba36c83e4a537ab.1781970534.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-1282-lists,linux-sctp=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3F246BAE99

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 11:48:54 -0400 you wrote:
> When sctp_verify_init() encounters unrecognized parameters, it allocates an
> err_chunk to report them. However, this chunk is leaked in several code
> paths:
> 
> 1. In sctp_sf_do_5_1B_init(), if security_sctp_assoc_request() fails after
>    sctp_verify_init() has populated err_chunk, the function returns
>    immediately without freeing it.
> 
> [...]

Here is the summary with links:
  - [net] sctp: fix err_chunk memory leaks in INIT handling
    https://git.kernel.org/netdev/net/c/9f58a0a4d6c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



