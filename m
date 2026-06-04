Return-Path: <linux-sctp+bounces-1234-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EecmFDioIWr3KgEAu9opvQ
	(envelope-from <linux-sctp+bounces-1234-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 18:30:48 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAD641D96
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 18:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gO1LsM8s;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1234-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1234-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F138F30F54C1
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Jun 2026 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61683480955;
	Thu,  4 Jun 2026 16:20:22 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649D2C11FA;
	Thu,  4 Jun 2026 16:20:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590022; cv=none; b=RL9MuG//jAFPqyRY0rPl/y+mJaQZXqbZULoUWr1XLEdDyKtKPbRXe/TuhsvFa5vvQ4RcTgEvn2clGTK9QY7Wa98gn0oqpz6nZ16q/QAlHksW6CqKfQ6TfxV1Gvi3NMUPNq8NQWTFUYHmGx0J/IRFKhtB1H7cDYcHZsQAlhUhIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590022; c=relaxed/simple;
	bh=iq+ni599eOdwgPQ91V8xvsCHsD7V86D88tIQfeEhKHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ief9p15NGqMNJv4m3jGUqeQxW5NpbN2F/Ci8PowMeQO94sXz7BOSvLi+sGvguUE+6SGm2vD9gaeoOM2MeK0qq6z4yAlYjS42u3koDSYcpsY2FJCDLCL5FMEu2t/PNfVC7EYrhpbqvA/9ajQvBUpUgNdZEEMAxnx+5X6UbGuiXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO1LsM8s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F211F00898;
	Thu,  4 Jun 2026 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590018;
	bh=0iZUxqEK+ViJWTJOCRa9D/05WrOB3xf1jaBtFVoEDm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gO1LsM8sLvOVAlJaKlGcrH3b4IKF/X+pP7OuGZcFL7VZnUEm2uzMElKtqmFsenLEA
	 TU+idbCBU6smNSIde/Hu2cp6lWIo5tXRRxEhmqYw1w8GZVXyaVjGEd6ZrgASvcAZxA
	 4vXDx7sHQICpwFEScaQD0V3VxPzcvGpiFRQ5To8K0XkntzOCIqscEZIJlzrc3EeZcD
	 KXjZM0gzUeQ7DO4sviLTuuYk6DlfDbqr4BBccCdw0cjt4xZWfIA3ijWkgshbBci44M
	 m4LhmumSJm8PsF5dfcH8Con6+Qe2YIEvzSM846vgPIUutH5E9yY2kryuVXLdhqP6Vo
	 7NXsuZgQr9NWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B6C39309B7;
	Thu,  4 Jun 2026 16:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: purge outqueue on stale COOKIE-ECHO handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059001964.2502005.1832706734432444090.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:20:19 +0000
References: 
 <94318159b9052907a6cbb7256aee8b5f8dfbfccb.1780510304.git.lucien.xin@gmail.com>
In-Reply-To: 
 <94318159b9052907a6cbb7256aee8b5f8dfbfccb.1780510304.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 xuyq21@lenovo.com, n05ec@lzu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1234-lists,linux-sctp=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:xuyq21@lenovo.com,m:n05ec@lzu.edu.cn,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,lzu.edu.cn,lenovo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6CAD641D96

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 14:11:44 -0400 you wrote:
> sctp_stream_update() is only invoked when the association is moved into
> COOKIE_WAIT during association setup/reconfiguration. In this path, the
> outbound stream scheduler state (stream->out_curr) is expected to be
> clean, since no user data should have been transmitted yet unless the
> state machine has already partially progressed.
> 
> However, a corner case exists in sctp_sf_do_5_2_6_stale(): when a
> Stale Cookie ERROR is received, the association is rolled back from
> COOKIE_ECHOED to COOKIE_WAIT. In this scenario, user data may already
> have been queued and even bundled with the COOKIE-ECHO chunk.
> 
> [...]

Here is the summary with links:
  - [net] sctp: purge outqueue on stale COOKIE-ECHO handling
    https://git.kernel.org/netdev/net/c/e374b22e9b07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



