Return-Path: <linux-sctp+bounces-667-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A100CBFF090
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 05:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885E63A86A7
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 03:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEDF2C3262;
	Thu, 23 Oct 2025 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5Js8vt4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AE2C159C;
	Thu, 23 Oct 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191183; cv=none; b=Sw+sv9Vf+Np9uWuczwfSrEAysfGSxVeUv2qtu7CrMgXPnVXPkk7t7j5HO5KvoeVGLUUvszpGK8zNDwiTqL4KGEbVOscp+oVLTg1ggMmmDhItL9vzeM0T7cfJ1ZdWcF6Q817Vs3GGxrJzrP8UWtkgeNllyLBxFMNwzqYpxQ8U+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191183; c=relaxed/simple;
	bh=p1nIg3wimGoUr7TVQqdkmiApzB5J9/v/yH/6DHBMiGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pEhMESpoHwaKE/77H9+WPasZsF3GyxzAxokA/bKw2mawJue8CJVTfby35ddouRl5/WN2u3Ts+0/8U4R16pi0EV/7nxZ62E8GnZbRqrmews1Og6iTz5sBLbLfuwSiNe1M1yoGizCsKUWetps0lJwOrlAPiCn4b054uma1/hdi9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5Js8vt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5C5C4CEE7;
	Thu, 23 Oct 2025 03:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761191183;
	bh=p1nIg3wimGoUr7TVQqdkmiApzB5J9/v/yH/6DHBMiGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M5Js8vt4R7KtivdPpLcTbVa3y1DuWnHBOx6CmCtBI48GiUa1p7KfcowQayKfO+PlS
	 m2tosN+D1i68Qgrr30r1W8MHNRfmVNZAvMWRJxHO+tEZEJkydSU0bOB29R3W6iV4OS
	 VDGdzg2hnuX+sDuCy5PVdSvS7NJ4G+n9fLVaaUD/csaDvgyQXwnjSAjMPWY8OpHy9t
	 T37S14xNKqZtdTo41j8fXeOnOSxrGE8mptwxDH9lvMyC9UUsyhoBxqTPBdNNdY4LlO
	 cUW2W9+0GWN04JGWc6blC51+0S/HmxucQ5JBzE913+r0NRc+4HgGw3HpyaQbrMegIh
	 9TTCtcOdT3Zrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345AE3809A04;
	Thu, 23 Oct 2025 03:46:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] sctp: avoid NULL dereference when chunk data
 buffer is
 missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176119116374.2145463.5595697305521112833.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 03:46:03 +0000
References: <20251021130034.6333-1-bigalex934@gmail.com>
In-Reply-To: <20251021130034.6333-1-bigalex934@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 16:00:36 +0300 you wrote:
> chunk->skb pointer is dereferenced in the if-block where it's supposed
> to be NULL only.
> 
> chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
> instead and do it just before replacing chunk->skb. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> [...]

Here is the summary with links:
  - [v2,net] sctp: avoid NULL dereference when chunk data buffer is missing
    https://git.kernel.org/netdev/net/c/441f0647f767

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



