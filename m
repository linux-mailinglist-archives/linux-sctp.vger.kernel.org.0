Return-Path: <linux-sctp+bounces-741-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F7C49DFE
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Nov 2025 01:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127F13AB7D4
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Nov 2025 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165E21420B;
	Tue, 11 Nov 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ8i5NJO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D822068D;
	Tue, 11 Nov 2025 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821046; cv=none; b=SF1YPwa3fdkA7+Ut9A6FznTNZF1n6eTtQEmP6OOwBk/HxT/cGTq9sE5dAB1qbZf6LEoKvnxnyVtFfAv481aXr0TRu0khJZq61aShAwYF2J4HdR6n/g0gA76hhHlXB8xGWE/J/IXyqBARTTKa2s8A0362fUxB/qq6rpemOo5iynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821046; c=relaxed/simple;
	bh=997n7yfXBzWYN/GZqzINN3GVRFz/H+Mi41fGmIzE3ss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WUrZKCa14t2Yqz3I1ebajGsMFt2K4ywGFiOY4JiHGehKeWjDhK5f/5+bglS2WQQBYxPkueOnIkYWaUeYu+p5dOTYjexDuPRoavXk9zY88k3+L/e4VT4CA1RUu5wM5Hd2bh+cJjofsUPtFUypumL5oTfS7SSsTG0Gr+fXWHMuhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ8i5NJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C89C16AAE;
	Tue, 11 Nov 2025 00:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762821045;
	bh=997n7yfXBzWYN/GZqzINN3GVRFz/H+Mi41fGmIzE3ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SJ8i5NJOva6RTwCPqwZakQQxv9KLDj5rfWd3Schpx7JrAAfaWsgIFYCOBvDBoz8y7
	 dtfJRTZ2hH+oAHz/GevySL2hZr4R2lDtW+mEKCJLXMZqqea18NJHzmWgq5nS6sZ5vj
	 wYW1yHzswX2N+mG3XrihLEWHZlgADb/QMi2jF0dN2ExTx62yNcOMmrP92yuEjDamKn
	 9Yhwjnn87alXMEuuNjCaBQGdOQEe43g0V+Hzz13S7F2VEA+pWiXh8COqQRC2Jmk6eI
	 J1+eJ0RcAgbkgzes0mZy2XwDzYI2DSdjkfTrDMAH0yw1zqmzmIjXQ0r4Bz8V6FTO7k
	 g9R9+EjRZBqqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB2380CFD7;
	Tue, 11 Nov 2025 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] sctp: Don't inherit do_auto_asconf in
 sctp_clone_sock().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282101624.2823873.16207859066756956702.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 00:30:16 +0000
References: <20251106223418.1455510-1-kuniyu@google.com>
In-Reply-To: <20251106223418.1455510-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 syzbot+ba535cb417f106327741@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 22:34:06 +0000 you wrote:
> syzbot reported list_del(&sp->auto_asconf_list) corruption
> in sctp_destroy_sock().
> 
> The repro calls setsockopt(SCTP_AUTO_ASCONF, 1) to a SCTP
> listener, calls accept(), and close()s the child socket.
> 
> setsockopt(SCTP_AUTO_ASCONF, 1) sets sp->do_auto_asconf
> to 1 and links sp->auto_asconf_list to a per-netns list.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] sctp: Don't inherit do_auto_asconf in sctp_clone_sock().
    https://git.kernel.org/netdev/net-next/c/73edb26b06ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



