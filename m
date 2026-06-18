Return-Path: <linux-sctp+bounces-1271-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lbJIDNI6M2om+gUAu9opvQ
	(envelope-from <linux-sctp+bounces-1271-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Jun 2026 02:24:50 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0069CE04
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Jun 2026 02:24:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DUjcXrL7;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1271-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1271-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D76430CBBA3
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Jun 2026 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA523505E;
	Thu, 18 Jun 2026 00:21:05 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCAF20D4FF;
	Thu, 18 Jun 2026 00:21:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742065; cv=none; b=ktCkVr9GdSGDekPQs2w0dLgwDE3Uy+ufwfmHBupwNqqWcpbsIDapm5Nze2zM2ku829T2/vD69zm1GNaakGJIZBuV11eTZa6OHy0y+BcpcSQFlYwCYF6koiLQHjEwBJF6wmYpCmz2fncdfeji+fiTlycGR/y2OULtywZwZrpj350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742065; c=relaxed/simple;
	bh=DWrceq2OhH6aFez2ixZtaml5shxwVq/SuVD3h8iyi34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ptZZH5r7aujWvldavcEuoYaAVdSLQ0yj0bA9PUIqeO/KKEeFFuQdaYjJPouwDxL5XFav2Rcz8qcMjoKdqAoZT5XNIkzVZPKKm16TKyVDUejtRJku7xqTp97sRifpb4KmRuxLI25udJZTNd6MgRmSUwndnQQzPX8g/wpQyV3Te8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUjcXrL7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A331F00A3D;
	Thu, 18 Jun 2026 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742064;
	bh=uL1gQff5ono3NPytk0J8Nf9toqilNRN+4zKvHHyXafM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DUjcXrL7MaxA6BQEYM7doXUPfknrd26gNOMbHMwkc4D04dKnH6hkZfHpUS1frjaYW
	 m3hnvfAAPhHFRKqxQkl76vNij8KKoLKp89m0dDbBBASmqer8pbQSTJwxAY/pEGTIIo
	 xbuXa2Y5oZpnGr9P7XW+2xb2u6xrYFyxHpqHRwVpiRhIpkVwa0p4Qj4U6TSp4gLZ+o
	 UZX3TMIaJsmGx7pp5+x3qzdTWhZSCptPE1+9rU90F5GwzPVF4v8JalMO9qLcDOVBC+
	 AV30ppqPbwspnj0TJtI3gmJnm4tAnxLdYL7FojAXrLdWCor+D5YgSAZzzi777eX/Q9
	 tW+MW2sIDQ9Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395B393102B;
	Thu, 18 Jun 2026 00:20:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] sctp: hold socket lock when dumping endpoints in
 sctp_diag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205813.1875263.14770021083117878767.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:58 +0000
References: 
 <4c1b49ab87e0f7d552ebd8172b364b1994e913c9.1781552190.git.lucien.xin@gmail.com>
In-Reply-To: 
 <4c1b49ab87e0f7d552ebd8172b364b1994e913c9.1781552190.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, w@1wt.eu, zdi-disclosures@trendmicro.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	TAGGED_FROM(0.00)[bounces-1271-lists,linux-sctp=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AE0069CE04

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 15:36:30 -0400 you wrote:
> SCTP_DIAG endpoint dumping was traversing endpoint address lists without
> holding lock_sock(), while those lists could change concurrently via
> socket operations (e.g., bindx changes). This creates a race where
> nla_reserve() counts addresses under RCU protection, but the subsequent
> copy may see fewer entries, potentially leaking uninitialized memory to
> userspace.
> 
> [...]

Here is the summary with links:
  - [net,v2] sctp: hold socket lock when dumping endpoints in sctp_diag
    https://git.kernel.org/netdev/net/c/7d8297e26b4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



