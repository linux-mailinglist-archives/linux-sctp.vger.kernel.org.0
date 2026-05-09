Return-Path: <linux-sctp+bounces-1205-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHMTOQB+/mnjrgAAu9opvQ
	(envelope-from <linux-sctp+bounces-1205-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 09 May 2026 02:21:20 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2754FD026
	for <lists+linux-sctp@lfdr.de>; Sat, 09 May 2026 02:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC7E302BDF6
	for <lists+linux-sctp@lfdr.de>; Sat,  9 May 2026 00:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A721C3F0C;
	Sat,  9 May 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJAexo0v"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5811B4156;
	Sat,  9 May 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286065; cv=none; b=NKBWSrapel+py1/Ls7UirsM4SITC3BDe9xV/ZhnX2mAVF0Tfo+YV7LfwcxsSFbjsRyzxdNSPF27MEU8pjSY22goAsk58vrkmlDdGpI3GPVFdOdlyLWjrVFVgcEJ2IIeMDW5Ni0MwH4sCKghVOTJVYh6RwxGKyQB3AKvCc3wLIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286065; c=relaxed/simple;
	bh=e8J5Oh7vK65QnYfChl4AgUq6KL00loPB/hOAtaZB0wY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EgaD+PdMuCMdTC2iFv2bcYtOPBiORNeGvlknBH0loywTZ0Q0u+7zl9mlwTwxjJ1oep8Uaky323Tg/Hk5gCEEThzezwNaTBJTTtSnyw+i5MMsMk8Zzmxp4yNYFQOOw51baA+0tM3GZaJbAFXChd5sfPtXXwGnoUN6FvWSkTO1AAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJAexo0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2064FC2BCB0;
	Sat,  9 May 2026 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778286065;
	bh=e8J5Oh7vK65QnYfChl4AgUq6KL00loPB/hOAtaZB0wY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bJAexo0vYA2FSXXnATvzgn1foEYbO3boNag3kkLJILTbBoCEy0m1zUBaum5MhwzTA
	 8WediI9JmjwL3Cg5bbNCd4afG75520YCkJ5XGLCcjEohXBf57/XRRgwLRWxfYI9Fx1
	 mJroQy4nhVeBrU24eZ2GYR9X09WwQSPC8xw4MFfb3zRDwXCb5iHiDj+cy2dp0wXk1v
	 wbTf82JERwzJIHOsVmAKUMjMUHv27QW5ozthF4auhzaXrc/x710+1xCqFpVnzazIqI
	 YhoFh8NOiBcQdcKsDIDb3tctg/Reu+o4wwn5kMd55m+RBkdw+8xtQtoPkHUE1XGuKz
	 koY+IfvYT9YRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09B38119E3;
	Sat,  9 May 2026 00:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] sctp: Fix typo in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828601329.907663.13737666629392193621.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 00:20:13 +0000
References: <20260507105758.25728-1-shofiqtest@gmail.com>
In-Reply-To: <20260507105758.25728-1-shofiqtest@gmail.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 4F2754FD026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-1205-lists,linux-sctp=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 13:57:58 +0300 you wrote:
> Fix a typo in a comment in sctp_endpoint_destroy(): "releated" should
> be "related".
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  net/sctp/endpointola.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/2] sctp: Fix typo in comment
    https://git.kernel.org/netdev/net-next/c/c7ea0d2b4d76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



