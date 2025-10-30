Return-Path: <linux-sctp+bounces-727-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC9C1FA40
	for <lists+linux-sctp@lfdr.de>; Thu, 30 Oct 2025 11:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83461884290
	for <lists+linux-sctp@lfdr.de>; Thu, 30 Oct 2025 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE63164C8;
	Thu, 30 Oct 2025 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFmtIKw2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B252F6912;
	Thu, 30 Oct 2025 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821429; cv=none; b=urcdKMYMFPJjzGRLVhu3n0fTjrsP9Oswe80oCo5hKqVDYpamGki69oxdzSX5MHLXDLof1ONL18E8Y26k4NF4SprTbAGtPWZBWn2LwjLm2FYxDNNgLk+4G+NY5Mipdby3rnrSPjsO2K+mbertlw7girK04kfrJuWIJ/MsBYapDZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821429; c=relaxed/simple;
	bh=98kXD/+Z28d/KmYrnZjd8hjURwtKxTpVlrgw3abxKU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMWfbHBeV1T1meTsEvttNR3ErylqrLjqttscz+WQaVOz3NnpkLVk014l2Vb9nZavG2UckwjPpI1kxz0mAcd6CxOIUR/5/NWD052zmq3ErB+zwT+BKsARJ5c8T9QnIRJmYIviKJD+yzC0PVS1zfuOU/z31UfdfjSIOAci/v6JUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFmtIKw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CA1C4CEF1;
	Thu, 30 Oct 2025 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761821429;
	bh=98kXD/+Z28d/KmYrnZjd8hjURwtKxTpVlrgw3abxKU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DFmtIKw2czgnewzuT9btvEUV8O1damXZSfOxfwVLDo1ymC9bknvwP/E5mD8of/gEJ
	 wt9/l2VtQ02Ep/WV3dPj2/VYEp//G16kaVPqXQioazFrsZkj9ZO5Nrx+Zqap4j/f+G
	 ZIgJLYTrfGcctwl0kfjao//hqzjTXzkvOcNdohP1Pd14yiLbH/X5LwcMhMmYBQE9xx
	 vWK9F2zbtcNQLSKwpe1FUZn0xsLsdbM1t3DOt4XOSXTS92cgbpR/8HBElmbBcG8yez
	 9rUTDJYyKlMaM8mI3eZQ3e3T3KRib+DQ1i2fGaZV+khzCNwggMFuevaj5lhXK7G5dv
	 pAef4CqCZvEgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F263A55FB0;
	Thu, 30 Oct 2025 10:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176182140601.3798636.15774437371836976916.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 10:50:06 +0000
References: <20251026-kmsan_fix-v3-1-2634a409fa5f@gmail.com>
In-Reply-To: <20251026-kmsan_fix-v3-1-2634a409fa5f@gmail.com>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 26 Oct 2025 22:03:12 +0530 you wrote:
> Fix an issue detected by syzbot:
> 
> KMSAN reported an uninitialized-value access in sctp_inq_pop
> BUG: KMSAN: uninit-value in sctp_inq_pop
> 
> The issue is actually caused by skb trimming via sk_filter() in sctp_rcv().
> In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed the
> original check:
> 
> [...]

Here is the summary with links:
  - [v3] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
    https://git.kernel.org/netdev/net/c/51e5ad549c43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



