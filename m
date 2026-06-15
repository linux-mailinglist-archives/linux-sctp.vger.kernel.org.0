Return-Path: <linux-sctp+bounces-1264-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HNOIDwCEMGokUAUAu9opvQ
	(envelope-from <linux-sctp+bounces-1264-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 01:00:16 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBCF68A837
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 01:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kxhEiBZD;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1264-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1264-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48678302206A
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13673BBFA9;
	Mon, 15 Jun 2026 23:00:13 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C83B71C0;
	Mon, 15 Jun 2026 23:00:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564413; cv=none; b=ZQveNt20frHZSYjTFCekWYZqUPJU+TYckqnozQn1GPsUlI9367Ku972HuGtIlzdHzFThgAWkNGv4fEKfXZB/XAyxqKpgDseAPti5unfg/jTK0kdhVCKA2hCBoqqUQwLmvztQw07NSmOIqvNDWIsALTzJT7FZiUaVsFxLV1BBBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564413; c=relaxed/simple;
	bh=IXdZke4y9BqRA9F8w7OCGsvqlHACVG+NOOuMi6AcxBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i1+uKkwhJCnlTNpI2TS+HCgb5WKvfbwuyV41cIIDrpum/UzfCCp2NC1sNKWkXJBXHb3Z2VBsebPKruTVIbJUvWxtwh70ZEO4KnX7qk7VcNmyXbRAWn4Nn6oyMnpff7PGdoMpsuiRmTUb1Uf/ejP3ZxVVz/FJfhxrie/qmeT8iPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxhEiBZD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB21F000E9;
	Mon, 15 Jun 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564412;
	bh=7cLFQ7pDCeyxEWsPfrCMcDWyGM3TML25G9cDWaQHnPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kxhEiBZDJ6qxPznuFC7P+ORpnGGgTNgwgFcS2eydD2y/3Tp3YtxKnfRVXDG85prtb
	 HwwUCMm+nh0fsdSJo9PPOt7pXWLUrnt+KRHIrIsPEy0xtnOQLHPN5INl1DmYURjd9l
	 L2HDKH8qMukkAlwt6xsvD55mNR1JP1xG/SIDt0orzmsCCoyVdUd53tNITbetr+23Oc
	 6qyCZIyPibJmLkdaVZKenM1rIRVK0Jp01xWq86reXxGbLYGsmjk78FM00SX/qXiAO5
	 xqPnCskfaUwPPgXelc67LU/LRVPeMjNsKthDcBiYQ5oQXcHlBGDI0qwngYlh7SbbgB
	 HYcH6jPP+fNbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AEF3839A08;
	Mon, 15 Jun 2026 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: correct CONFIG_SCTP_DBG_OBJCNT macro name in
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156440739.329386.7040852757692922793.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:00:07 +0000
References: <20260613233725.162470-1-enelsonmoore@gmail.com>
In-Reply-To: <20260613233725.162470-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: horms@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-1264-lists,linux-sctp=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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
X-Rspamd-Queue-Id: 7CBCF68A837

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 16:37:25 -0700 you wrote:
> A comment in <net/sctp/sctp.h> incorrectly refers to
> CONFIG_SCTP_DBG_OBJCOUNT instead of CONFIG_SCTP_DBG_OBJCNT. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - sctp: correct CONFIG_SCTP_DBG_OBJCNT macro name in comment
    https://git.kernel.org/netdev/net-next/c/eb82367bca56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



