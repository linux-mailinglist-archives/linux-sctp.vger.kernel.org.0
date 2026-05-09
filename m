Return-Path: <linux-sctp+bounces-1207-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFtbO1SO/mkzswAAu9opvQ
	(envelope-from <linux-sctp+bounces-1207-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 09 May 2026 03:31:00 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E134FD491
	for <lists+linux-sctp@lfdr.de>; Sat, 09 May 2026 03:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133F330115B1
	for <lists+linux-sctp@lfdr.de>; Sat,  9 May 2026 01:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B22F8EBE;
	Sat,  9 May 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRQ7T6cw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515A145B27;
	Sat,  9 May 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290258; cv=none; b=sJgQeg/I2ms8++fE7OFghZ09AEnyCNuyx+15ZqOA+a+YQJVdomOZnolDhSxcSSUcBbYju9z1ABOj8bcYeC9ajA4Db+TL66tSBlYpcFogCrOSF1N7tpfiqO+vlkb0jnanGLCKjIk2FL2gZRUCzVmUkwkyf++vlC2HyhI39YQ0pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290258; c=relaxed/simple;
	bh=HtXbw8Tdfb3ugmr2Reo1Vein4WL5+C7pziG06U8Q2Yk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V/ygSMaxuUxE5EJFrasj2/UJcX8ogVLnmPJfmBGj69Y+a9b8MvtfyYkmxzdwtjvIu9ZAacm6Tg/5tqrgTxzErw1rvYQ3NZBirFru06t+azRebgPNbBbIQvdRJNAJvmj2d70jmQhvzRf8S/WB1bZv0SIjAQlyt3/YsRiAx7GrfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRQ7T6cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB21C2BCB0;
	Sat,  9 May 2026 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778290258;
	bh=HtXbw8Tdfb3ugmr2Reo1Vein4WL5+C7pziG06U8Q2Yk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRQ7T6cwr4NT71Nq0VFbxgMhDrPHWtGoMoplqMbwtTFPXd6sERzRpNt6YlYr5uNYW
	 E7YHvtjS/vd03d1qd00jR4FJGzLovMeQ7fyBXYYPxXiQfiZZ7MkCqzEcnOi7XXcygt
	 wVDzuHRt8dMhm43tGb+h/6qgTVMO9HT1z29R3n9X9idy289CpxHKKmQRk06Z+yJVHP
	 HWMG4TQXesAjlR1zXlZjYD8zWEnYE6J/HCKQjfUYNHsGGXIeFV5o1Wfzt+2TYUrjf6
	 fAJ5/DXt9oJGPh1qT8vCMWxnDfmG1vz4C+90f73IF19/hM/MZMC+HJ8lInLDHhJlBw
	 c+WDmIirK9p1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0B238119E4;
	Sat,  9 May 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc()
 in SCTP_SENDALL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177829020630.925974.4773311620023474680.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 01:30:06 +0000
References: <20260508001455.3137-1-joycathacker@gmail.com>
In-Reply-To: <20260508001455.3137-1-joycathacker@gmail.com>
To: None <joycathacker@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, bmorris@anthropic.com,
 stable@vger.kernel.org
X-Rspamd-Queue-Id: 76E134FD491
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1207-lists,linux-sctp=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,anthropic.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 17:14:55 -0700 you wrote:
> From: Ben Morris <bmorris@anthropic.com>
> 
> The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> list_for_each_entry_safe(), which caches the next entry in @tmp before
> the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> drop the socket lock inside sctp_wait_for_sndbuf().
> 
> [...]

Here is the summary with links:
  - [net] sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL
    https://git.kernel.org/netdev/net/c/abb5f36771cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



