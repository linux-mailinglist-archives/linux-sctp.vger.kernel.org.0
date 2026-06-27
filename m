Return-Path: <linux-sctp+bounces-1297-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HEUtND5UQGpXewkAu9opvQ
	(envelope-from <linux-sctp+bounces-1297-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 28 Jun 2026 00:52:46 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8166D2C8F
	for <lists+linux-sctp@lfdr.de>; Sun, 28 Jun 2026 00:52:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yp3dH8pZ;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1297-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1297-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81842303DA8C
	for <lists+linux-sctp@lfdr.de>; Sat, 27 Jun 2026 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E437DE8D;
	Sat, 27 Jun 2026 22:50:50 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C03016E0;
	Sat, 27 Jun 2026 22:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600650; cv=none; b=tpB2/H3Y7DGblKgF2nGHnoOIQAkVFe6rrntER2gMXalQPhwJLQXrnDfC7u6Dcit/x+3lJWdvugynElSYCvbgM9s7VwkrDYY3tLXSP4AtGGroqbydSjTsZeF6WgmUCL/mCenm4W3MZSJdCIa4QmLqZXIrlFpLH7JmCb5bL2m2HrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600650; c=relaxed/simple;
	bh=3Pnqf1f/5VxowyidrigA+RqxFhZhcTgyBCAjsoy/zUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZX49E6vuA9iMtxM0BtdiuK1IQ0WaFM7axltyVL3i9pGfR25wBQ9ZUq4ycCrY9tdYAuOEaMvB9Yl7fZKPHAoPaYQ1qngIm1O4EbGQokVNLLGcIML4W8k62rDnv7K+szBrs+IkQcaMcJ3CAepD/9FXlJk1dLf6gDsV5ob0HCY/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp3dH8pZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9BB1F00A3D;
	Sat, 27 Jun 2026 22:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600649;
	bh=dGHcDsGOrD4TVd5B/eHXrzmMA+KKXUboBgjSGm4gJ28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yp3dH8pZ+5lRHbODLoms7YcgXCcllDN+zoNnTxcYPEhrqzFx0f6lgEJmvvbXNGaYD
	 z2tr/ayG1YJb7wNLszJGiJzipMQUpho+gcBp41WR8G41OQc8RArHW0E2gJr7XE3olR
	 Wwgeuiqfs8fZUwYKFclEMSMyIe26md/oto9VDdTZlh2fZ3z2a+KvFYJn7E+bFSLREo
	 eGd4+Jad12WI2hg4cYeWKX4tuQudLAOIh6Por+UUKMRsQqFB0tEV5eHbpLZ911w7ZN
	 TLVEDMvOBiwkzqAS/EjXHrsVo6PbqZHmkFNFhPapHei4C25iPe2bkL6jlV4sBMgO7W
	 qANxA9jJy4J+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938113938452;
	Sat, 27 Jun 2026 22:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] sctp: add INIT verification after cookie unpacking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260063522.1451849.11621475280238770353.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:35 +0000
References: 
 <ebcbbac574815b0850f371b4bdb02f2e602b94d3.1782341592.git.lucien.xin@gmail.com>
In-Reply-To: 
 <ebcbbac574815b0850f371b4bdb02f2e602b94d3.1782341592.git.lucien.xin@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-1297-lists,linux-sctp=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: 2D8166D2C8F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 18:53:12 -0400 you wrote:
> In SCTP handshake, the INIT chunk is initially processed by the server
> and embedded into the cookie carried in INIT-ACK. The client then
> returns this cookie via COOKIE-ECHO, where the server unpacks it and
> reconstructs the original INIT chunk.
> 
> When cookie authentication is enabled, the cookie contents are protected
> against tampering, so reusing the unpacked INIT without re-verification
> is safe.
> 
> [...]

Here is the summary with links:
  - [net,v3] sctp: add INIT verification after cookie unpacking
    https://git.kernel.org/netdev/net/c/414c5447fe6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



