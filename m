Return-Path: <linux-sctp+bounces-1253-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f1WAHPiGKWrpYgMAu9opvQ
	(envelope-from <linux-sctp+bounces-1253-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 10 Jun 2026 17:47:04 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0114466AFD5
	for <lists+linux-sctp@lfdr.de>; Wed, 10 Jun 2026 17:47:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ktQtiqPZ;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1253-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1253-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C596D3071C1B
	for <lists+linux-sctp@lfdr.de>; Wed, 10 Jun 2026 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F1F426D19;
	Wed, 10 Jun 2026 15:40:15 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60B3F888F;
	Wed, 10 Jun 2026 15:40:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106015; cv=none; b=icim9MtQWA4Oi4OqLZadrDWXiGUNwE1hDJ1xO5b4Y7spnITik5t9hEAWJSEFLkM3XcUqQ43z++GDy22DKfCLfr5y2LDDSmwM55OShNb9ELiFVxYgiSSOsTPEe5zPxC1g4pVrsLEYggniokXp8U0FFzMYhIE2ftxt63y36DJ882Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106015; c=relaxed/simple;
	bh=Pz8CJYzkk+3QFCr8ITB1Dm0MU9lyNYEBlXPWcuGCiyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2FhT2WB8AK5PDYfnslKGrhy8amnmofXd/Lg8pkiQqJY2Z7BozI19SFLbf5g0wLHHU5ouuGC0Yd04aOLxeDRFLm4SL8LHDH0FthSFlIlLTUolUgaB5ZpmYR9sb9/JiEnrv4Nq7JgqCUrWRId8rkFcGT43TqSP1lTfGPWmP0HqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktQtiqPZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051711F00893;
	Wed, 10 Jun 2026 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106014;
	bh=Q7lovTf2xKEHzRVxc4iwR3F8yM6ku67mHT7Spol2pdQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ktQtiqPZ7OCKLEl8T+adV9HRxkS9Cv9cs3lrtnKMZBKsZkmaBvVQyow2O6cwEq7yZ
	 JLAtTTqXoIOHRQoahAJbIwUDPISC3U2oUsZpzqOQxmbTtaM8VsXgYtXekPM9Tf2WXK
	 7kUbp8eSy+hCDPfueco2DhiwsmT8K+DJaRGJKsJopVWchvT/7Rdw2Epkf3PM43rZNv
	 mFK4PFeGg+u8KrL26ZHUxRQnCxpImxcMFwmzg1X237kUrutIyv39kpGRUBmutxgJO1
	 U9lV1tWnwqYeGviGTvBJUfxf/Iyrt1h9HMayEis6q2Tx6VxHvto8PDuVvtMvz5y7js
	 x9IKStdvZNxmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F43930D7A;
	Wed, 10 Jun 2026 15:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] sctp: Unwind address notifier registration on
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110601163.3101197.898544218115899092.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:11 +0000
References: <20260608162230.46644-1-dbgh9129@gmail.com>
In-Reply-To: <20260608162230.46644-1-dbgh9129@gmail.com>
To: Yuho Choi <dbgh9129@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-1253-lists,linux-sctp=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dbgh9129@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0114466AFD5

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 12:22:30 -0400 you wrote:
> sctp_v4_add_protocol() and sctp_v6_add_protocol() register their
> address notifiers before registering the SCTP protocol handlers. If
> protocol registration fails, the functions return without unregistering
> the notifiers.
> 
> Unregister the notifiers on the protocol registration failure paths.
> Also propagate notifier registration failures instead of ignoring them.
> 
> [...]

Here is the summary with links:
  - [net,v1] sctp: Unwind address notifier registration on failure
    https://git.kernel.org/netdev/net-next/c/c8459ee2fef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



