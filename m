Return-Path: <linux-sctp+bounces-1254-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUNdI4w3K2q/4QMAu9opvQ
	(envelope-from <linux-sctp+bounces-1254-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 00:32:44 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9A675A4F
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 00:32:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GrzOLSYh;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1254-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1254-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4DF33F23BC
	for <lists+linux-sctp@lfdr.de>; Thu, 11 Jun 2026 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1043CEED;
	Thu, 11 Jun 2026 22:30:25 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59863CF025;
	Thu, 11 Jun 2026 22:30:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217025; cv=none; b=GUD2XrM6IvIn4usVxP4xC4/+mJtO9GtbtCqkxqruQ3KBg0KVYxy3MYzsOX5MUNCrz2n2u22pEHmtBvYnXhDfewO87WFb1qSU0U/Qqt3dGDP1dQu8UzVaFvz1Bvaps3fyg1VKcZCTuhFiU8n1GQC8w+ijB+eXW3JIjLNniQKEhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217025; c=relaxed/simple;
	bh=Q7QX7aOuVpFHWd23Lgvjq/uXtFI7WY/mskuHCNmlphw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pOzEYfcTs5rawixv/UD11I0ershRS+AhfPNk48r9uOVVX5tOWMFXLw/67EGp94MURlPWsBhlscYp5U/zoPI/hNW3rF/ACsmsrWdXxjSkznZhBrC39sZ+KqeZgYIeaXywNqZBsPkMNlLm0fuj55PJX9FyC7noB3f+c9XLHELK+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrzOLSYh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB491F000E9;
	Thu, 11 Jun 2026 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217023;
	bh=RIlIDUHGcKjCHfmOtBGc3q5oHD7TDpjiPKi+UKNilgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GrzOLSYhOwaXh1r19ps6AYaVvkk/MDmkZG5zWWAhb5UU+IV2Al97uz+gV1059x5aT
	 /gmZQNP7hsYg1IVAhVXn9K9X9YQdSQRBmjOSzqJNTmROWElOcUjIiwHTLF1L8kTM4Q
	 OJkKdPGnWdFBq9FdM74HjQguyXEv8VI7GAR3NzxQZAobXrxscZeb8nXHNBND6ekXzb
	 JNayBYmxLSe3CZR5LY8dLPAT8agqD4//F5Gl1AFVrYPQP8smp8+6VX2I3UNYTMuglt
	 I9NSZ6iL5YW7Qru8lcyuESNAoX4XkiCxC58TrcpGId53B+Nm0Rp1gLmzThc/lj7LKo
	 5uY975ez22vZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389D3930FAD;
	Thu, 11 Jun 2026 22:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: validate embedded address parameter length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121702013.389578.4099391378396702786.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:20 +0000
References: 
 <7838b86b69f52add28808fb59034c8f992e97b2d.1781043268.git.lucien.xin@gmail.com>
In-Reply-To: 
 <7838b86b69f52add28808fb59034c8f992e97b2d.1781043268.git.lucien.xin@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-1254-lists,linux-sctp=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3B9A675A4F

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 18:14:28 -0400 you wrote:
> sctp_verify_asconf() and sctp_verify_param() only validate ADD_IP, DEL_IP,
> and SET_PRIMARY parameters against a fixed minimum size of sizeof(struct
> sctp_addip_param) + sizeof(struct sctp_paramhdr). This ensures the outer
> parameter is large enough to contain an embedded address parameter header,
> but does not verify that the embedded address parameter's declared length
> fits within the bounds of the outer parameter.
> 
> [...]

Here is the summary with links:
  - [net] sctp: validate embedded address parameter length
    https://git.kernel.org/netdev/net/c/e9361d0ca55c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



