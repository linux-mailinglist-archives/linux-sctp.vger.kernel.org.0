Return-Path: <linux-sctp+bounces-317-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13594A07E37
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Jan 2025 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C893A76EC
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Jan 2025 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B1618871D;
	Thu,  9 Jan 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE6Xm4jQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C17273F9;
	Thu,  9 Jan 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442027; cv=none; b=KX6/JqE5IoXQPNTHPflq2T/yxownLHpouZw8YQoBqX2YBiF/tCCDIdVvjNiYHbXvtnFsewym2wjK3CB3a/PejuhMtSzQGWiEUUh/Hs2/ovZVtOGeZ4uqZ393UFGPSp+eG3+DSefhtKQXVJMfYBpVsq6XM68eVvoPStroryWAjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442027; c=relaxed/simple;
	bh=6634pWrQTlGcDLuTISOrV8M6pjKmd4U2P6WyzGzAO3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ze0Qipqvb7sJJDKFZP/0UP8TUSiDlZmLQAiviwbMekKfnH4UppqjJUMyBo+mgGCV6dpzXFcqIuxnT1nGvntZRklCElE+w1IotecuOFwCsJVNs3Va1fdob2RgrabKC7yENghzK06t8i8jOO58RZn+dDhIltcTSt3T9gIdYa37w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE6Xm4jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17558C4CED2;
	Thu,  9 Jan 2025 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736442027;
	bh=6634pWrQTlGcDLuTISOrV8M6pjKmd4U2P6WyzGzAO3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JE6Xm4jQ6mEZi9FORUN2gyXIXB65b7G0CYX7nJVDbttIb5NGG7z/BXt0cYjUEYeLj
	 oC61tbkL086I408rPggj+00McFDrRh6u78SgIAErW29sEA8TpoV26qPezD+aDh1Ibr
	 MsOOucmTu/dPHzb2sLJJQAAQkLLNAAAtT2BE/i5TZnqMoPata8SovE8Aic6YHBGSiZ
	 Z/AEEp5cL8YG3Vy5tA49WxL9egHPvRoIBnBi4eVykRAYqH4mNTL5ki1JahhOnEpZLx
	 BqV53oREO3yLsD46pgMNbDRojtyagmslvptpmODgbcLnJmiTPAIiEXicy0VcddIMYL
	 cWH3DgMcZSCgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB79D380A97E;
	Thu,  9 Jan 2025 17:00:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] net: sysctl: avoid using current->nsproxy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173644204876.1449021.3388211513784045754.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 17:00:48 +0000
References: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
In-Reply-To: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gregory.detal@gmail.com, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, vyasevich@gmail.com, nhorman@tuxdriver.com,
 wangweidong1@huawei.com, daniel@iogearbox.net, vyasevic@redhat.com,
 allison.henderson@oracle.com, sowmini.varadhan@oracle.com,
 viro@zeniv.linux.org.uk, joel.granados@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, stable@vger.kernel.org,
 syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Jan 2025 16:34:28 +0100 you wrote:
> As pointed out by Al Viro and Eric Dumazet in [1], using the 'net'
> structure via 'current' is not recommended for different reasons:
> 
> - Inconsistency: getting info from the reader's/writer's netns vs only
>   from the opener's netns as it is usually done. This could cause
>   unexpected issues when other operations are done on the wrong netns.
> 
> [...]

Here is the summary with links:
  - [net,1/9] mptcp: sysctl: avail sched: remove write access
    https://git.kernel.org/netdev/net/c/771ec78dc8b4
  - [net,2/9] mptcp: sysctl: sched: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/d38e26e36206
  - [net,3/9] mptcp: sysctl: blackhole timeout: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/92cf7a51bdae
  - [net,4/9] sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/ea62dd138391
  - [net,5/9] sctp: sysctl: rto_min/max: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/9fc17b76fc70
  - [net,6/9] sctp: sysctl: auth_enable: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/15649fd5415e
  - [net,7/9] sctp: sysctl: udp_port: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/c10377bbc197
  - [net,8/9] sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/6259d2484d0c
  - [net,9/9] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy
    https://git.kernel.org/netdev/net/c/7f5611cbc487

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



