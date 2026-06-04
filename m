Return-Path: <linux-sctp+bounces-1233-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FwTwI+2eIWp7KAEAu9opvQ
	(envelope-from <linux-sctp+bounces-1233-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 17:51:09 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB864194E
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 17:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ga2BEjp1;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1233-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1233-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62AF030F2CEC
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Jun 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9E35AC13;
	Thu,  4 Jun 2026 15:40:15 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7903659FB;
	Thu,  4 Jun 2026 15:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587615; cv=none; b=rCiaLv8JLR8U7qsuK5Ot+uW99X+MJ1hveawQ63jMCULfgbGRa72xvSddA8kdQlGULxqKl8V9DExFVYXmTWXgWPAOX3TxL0r7mid8b4xEfHmDqXmkSRUsQtUDZIJyjY1fqscUBCeqNPTio94HUhyj+1uutRSyMttkhkZehglDFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587615; c=relaxed/simple;
	bh=BGfNWLg0nFfLJxtfV1ze186PqzVhVVk14syTYFjlc7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YWQh8Cmdzs7HquurOPFxBa+PkDIWZqSSy3BhAquqDYtM7Y5yvueggyvKq8prdCx+Ik/GNQSQ+sLvsGtBsOpKWeyxhgBFa5Egka9Xn+XCBsJaIiOUbYHuE1yvVVOFrtHpCvuxhPF1qniSACIloAHTVOmFWHMDl8CRFHrJtlFc2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga2BEjp1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB801F00898;
	Thu,  4 Jun 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587612;
	bh=X0Hikw9pEEkvXaQ7eRhaPHqUPrN82xx9YDraaItADIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ga2BEjp14QbJXE/PfOw548zLMGPOk2iP+18BJcD2EfXhuBTdVJEUMf5pOBlbF2Z9h
	 KlSR3RA0V+P3spcUom4pYtraIjVzZBtBe9MhhISqGKgxdNk+7qqPMnOf+mCIuSvsko
	 reRp8Hdj7rs2OlQNys9bsZhh4+SddWW/MJqQWWLTWs+Z8kLpk8vq8JNnNzOG5prfXA
	 x7X2fYvPOB54eOwIGITlTP+1WQlBmbMKrYbG+uh8BzoV7JuHBTmsvhqarZ+4R+BCXq
	 PrB6kah8TjVwhISITl3dhXBV12vRRacQAMxxk0UFzwrswpn7yUXW/CfRF3pjTZ+QiE
	 LS95vJ9YkK0Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987239309B7;
	Thu,  4 Jun 2026 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: validate cached peer INIT chunk length in
 COOKIE_ECHO processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058761264.2484354.11440643164708781484.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:40:12 +0000
References: 
 <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
In-Reply-To: 
 <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, bgeffon@google.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1233-lists,linux-sctp=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:bgeffon@google.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8AB864194E

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 21:06:06 -0400 you wrote:
> When a listening SCTP server processes a COOKIE_ECHO chunk, the cached
> peer INIT chunk embedded after the cookie is parsed and its parameters
> are later walked by sctp_process_init() using sctp_walk_params().
> 
> However, the chunk header length of this cached INIT chunk was not
> validated against the remaining buffer in the COOKIE_ECHO payload. If
> the length field is inflated, the parameter walk can run beyond the
> actual received data, leading to out-of-bounds reads and potential
> memory corruption during later parameter handling (e.g. STATE_COOKIE
> processing and kmemdup() copies).
> 
> [...]

Here is the summary with links:
  - [net] sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
    https://git.kernel.org/netdev/net/c/0861615c28de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



