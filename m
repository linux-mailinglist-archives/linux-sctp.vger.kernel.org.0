Return-Path: <linux-sctp+bounces-1189-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G7RTEuPb42npLgEAu9opvQ
	(envelope-from <linux-sctp+bounces-1189-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 18 Apr 2026 21:30:43 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C334C42217F
	for <lists+linux-sctp@lfdr.de>; Sat, 18 Apr 2026 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07B7C30087D6
	for <lists+linux-sctp@lfdr.de>; Sat, 18 Apr 2026 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952133D509;
	Sat, 18 Apr 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDF3HwY0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C833BBC8;
	Sat, 18 Apr 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540639; cv=none; b=jtoTWErxCbq8oAIGH/UzA6HTHuDmTMZ/aARTW4k9uR/IEot4kRq8VhyYjNAWLWF28YsT4J+zYZ3/u8Ch0Et2nUK+6f8PtPkMi5/3allBOrZYolKqpxUZOTJO9h8bl18Dz2oJ7IR5ijD7Wa+d0Dm4S47PbHWWCZ937FaJ0JJMvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540639; c=relaxed/simple;
	bh=wGQOCsSS06p/rFWrgL/Trsm4HlHBagLql0oCFPElMbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bpJUkWYjTh5GG1zJtRQUApOcNubCXmaXBwW+irNZNnqwzHPoBxpXyxvwrGGh7l5pWNitQVq8rQ9qPiyLlPwAMD+Wbt1m8Pba73WDpGrLDUINO5fVIeCwcqK6I2k+iCLj/L8unI8yio9aCe4Fy7fB9XHVSlOAYDd1UoBKXQHVJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDF3HwY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0281C19424;
	Sat, 18 Apr 2026 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540638;
	bh=wGQOCsSS06p/rFWrgL/Trsm4HlHBagLql0oCFPElMbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TDF3HwY0+VVwCumWyXo34WxK6kMYbr8S+co8byYKqt2B2GYitG9qEdBoWm/oepwB3
	 hyZAQA9kdbgPu8wE1WeeqpfeOhSJRtamMqMcpaVCx5tjOJuFNEFZtTXJOhltw8EF66
	 znMgI90pxhwtYZ9DiZxpKayv4FjirgjW36V7hPXCzXoCINs9hxr2EX6D6jDvD9fA5f
	 Jocz8uzubUt5hrfa4vDIb2xeE1U+naEEOvPp3nqklFEYSHFt7XvB4PaJwqLxL3y02G
	 NTkmjc8H9qUz2spYH1V5p3f3U5qQua3V9UdtxpeF9LMvpeAZbUWVgoW1WcoFYTEIDG
	 +ypNIaBD72stA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDBF380CEDD;
	Sat, 18 Apr 2026 19:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: fix OOB write to userspace in
 sctp_getsockopt_peer_auth_chunks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177654060505.511621.5389852857637218563.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:30:05 +0000
References: <20260416031903.1447072-1-michael.bommarito@gmail.com>
In-Reply-To: <20260416031903.1447072-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1189-lists,linux-sctp=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C334C42217F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Apr 2026 23:19:03 -0400 you wrote:
> sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
> buffer is large enough for the peer AUTH chunk list with
> 
>     if (len < num_chunks)
>             return -EINVAL;
> 
> but then writes num_chunks bytes to p->gauth_chunks, which lives
> at offset offsetof(struct sctp_authchunks, gauth_chunks) == 8
> inside optval.  The check is missing the sizeof(struct
> sctp_authchunks) = 8-byte header.  When the caller supplies
> len == num_chunks (for any num_chunks > 0) the test passes but
> copy_to_user() writes sizeof(struct sctp_authchunks) = 8 bytes
> past the declared buffer.
> 
> [...]

Here is the summary with links:
  - [net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
    https://git.kernel.org/netdev/net/c/0cf004ffb61c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



