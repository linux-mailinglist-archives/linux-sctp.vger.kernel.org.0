Return-Path: <linux-sctp+bounces-1319-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2PB5AHQLUWoS+gIAu9opvQ
	(envelope-from <linux-sctp+bounces-1319-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 17:10:44 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166173C19C
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 17:10:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ikfk9ise;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1319-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1319-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780E43055D43
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7CB1DED4C;
	Fri, 10 Jul 2026 15:00:29 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA6223DE7;
	Fri, 10 Jul 2026 15:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695629; cv=none; b=hTrDpCXGzJwYYg7PIQqQBZeo9vHbeimj+OLDBFohFVj3/4pI8GIq309PzM5aE5nnI/OQYz8MFNutpDiVTIxGJrAexaI4cPlDfLf/GUfA7uUdkXw/O/USnFSCoFUs8s8cjW3yFmVpdIQFl6pCh1RcNFVXAcFLLFvcvhVoT0H3X2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695629; c=relaxed/simple;
	bh=WIzAkP8OyPVA8uAWxkJkDpECORMBAFVM5Vjg+fymZw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L0F1Q/nsY9UorkNzPR6ggcsFJqjoDM6pi1DjKp/Hb94JFyAFsObCGON3hN2VlOEquFJ0a17lzD6vvngtZ54FXkldvBeRKmo6foS+G0KLDGRrqU7oCwTtRK8aIhYpE2XyJJViHsbdsmp4ZjS5LwEnL1devz63DR7MPYB6nC2F7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikfk9ise; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B00D1F000E9;
	Fri, 10 Jul 2026 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695628;
	bh=gIVfiGDljpqCKA5ERFNw/PTnn3K8M+76q6/Myzas50A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ikfk9ise9kwxt7eFSbbJGnpbbhtidHoXuYfeXHSjQXrGODnMTOJNQLcgKnOkwKt20
	 qFdUnyu6cW0EZWm31VVd6nyp7Ljm3kP2l2Fvq5b0HMIM2da4IlCXKoeTtw/8E5vXOR
	 4e3fRg7+rvgq3yJYX1ATtHtdxxDt2fpjt4gHtZ7RjcfPjSpK8zUln9voq/dtcQHz+E
	 l9uLXTiKMr0FGHRcbskNXijPVrPIEEI18VQuG5QxQ0bA+m94XJ/fJDh2d2mcpT/TFj
	 BRefFbpZo6+o0+NpzYQGV+A7MIgddyIe4BSuvIJpSo/+bKTYZcCMHQWm8D3XK4d+Y/
	 pVfFMkxovGFdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9397F3924F9B;
	Fri, 10 Jul 2026 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: validate STALE_COOKIE cause length before
 reading
 staleness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369560614.725168.2626506030480279304.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 15:00:06 +0000
References: <20260704033545.2438373-2-bestswngs@gmail.com>
In-Reply-To: <20260704033545.2438373-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, xmei5@asu.edu,
 stable@vger.kernel.org
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,asu.edu];
	TAGGED_FROM(0.00)[bounces-1319-lists,linux-sctp=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:linux-sctp@vger.kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:xmei5@asu.edu,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7166173C19C

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jul 2026 20:35:46 -0700 you wrote:
> When an ERROR chunk with a STALE_COOKIE cause is received in the
> COOKIE_ECHOED state, sctp_sf_do_5_2_6_stale() reads the 4-byte Measure
> of Staleness that follows the cause header:
> 
> 	err   = (struct sctp_errhdr *)(chunk->skb->data);
> 	stale = ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
> 
> [...]

Here is the summary with links:
  - [net] sctp: validate STALE_COOKIE cause length before reading staleness
    https://git.kernel.org/netdev/net/c/1cd23ca80784

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



