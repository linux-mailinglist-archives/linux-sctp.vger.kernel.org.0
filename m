Return-Path: <linux-sctp+bounces-1194-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ItzI56c6Wm3ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1194-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Apr 2026 06:14:22 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2412844CD14
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Apr 2026 06:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F14283043D6D
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Apr 2026 04:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A9A1A3166;
	Thu, 23 Apr 2026 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ+h5C9s"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459A3CD8A6;
	Thu, 23 Apr 2026 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917452; cv=none; b=HX62oyxhmiikKLntqwZtBUi01g8CPcDtjqrJbiFFkiKl/iGlkn84O+j3J+qC1Um6sZyLOdJbD0+gw5MHW4JYXKsfUN6c6RYAP31xI2Mxu8tF+p48MkNC5eIs6xbELMEKMvpAoh50FoC2zy5lw01rkk9Mnfzq5XoHDIceFn+1XF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917452; c=relaxed/simple;
	bh=HAjchdSIR516yxEHb4YmEGjklp5bYhrwsv8bJpaUrS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EF9QUV7eUfmh4Svx7YEGsbSCswakXa9AU/KJP0gYYP5Nap61zO4KXFN0TDhArGHMe+XEk/z4WCf8J2d3udjG9tkVGzwHVIACyAB4guL04bFaHfUgxul5tZZ4isASPREeVK2xRX9f1s4U+EUQQ3OYPXAeY9HIYkokIQFUadOWqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ+h5C9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93763C2BCB2;
	Thu, 23 Apr 2026 04:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917451;
	bh=HAjchdSIR516yxEHb4YmEGjklp5bYhrwsv8bJpaUrS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gQ+h5C9sfOin/6I65PsHp4THPHGS3t2QJFsMKjphPBLfdnYl5AmdZJqJgUedHC/41
	 P/4QjiSTGhA1HFIYGCvLXg4lLcBzisNkxCKFPPm4R39QZd4swBjQgxMSdsEVD8aYeg
	 cNJg7XtrW2Okm9dE+YzXs6viTaEnainQKEWJMsxJdn14VMEPIJtZeCToI6hkOFZTSr
	 LWpEi4Se/hfHU5DUKrH6/MMliG1hOeUPKStXsXxOc15kyhCpQ3K0En0SiLghn83HiE
	 DWYVPX9XcaMWusWDCeXqe3RYKSm90ZLZWyLCXygddV0/BJmluwZv9o9u+tnUpp2cNC
	 YMFC6iV2Xc6+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EEB3809A86;
	Thu, 23 Apr 2026 04:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: fix sockets_allocated imbalance after
 sk_clone()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691741355.4152232.15250739127421929666.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:10:13 +0000
References: 
 <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
In-Reply-To: 
 <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com, kuniyu@google.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1194-lists,linux-sctp=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2412844CD14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Apr 2026 17:09:40 -0400 you wrote:
> sk_clone() increments sockets_allocated and sets the socket refcount to 2.
> SCTP performs additional accounting in sctp_clone_sock(), so the clone-time
> increment must be undone to avoid double counting.
> 
> Note we cannot simply remove the SCTP-side increment, because the SCTP
> destroy path in sctp_destroy_sock() only decrements sockets_allocated when
> sp->ep is set, which may not be true for all failure paths in
> sctp_clone_sock().
> 
> [...]

Here is the summary with links:
  - [net] sctp: fix sockets_allocated imbalance after sk_clone()
    https://git.kernel.org/netdev/net/c/7c9b012d6367

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



