Return-Path: <linux-sctp+bounces-9-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857D847020
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Feb 2024 13:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C8B25D7A
	for <lists+linux-sctp@lfdr.de>; Fri,  2 Feb 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7686F141984;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZJjQswF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86314078B;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876430; cv=none; b=nkQromOi7yUWWH1Bc+IgrZVQfFqeHUhk9fqDdY9mkFu3tsCrZSammdXMTcIfxAjFlLuD3l+jutL0lrvA68w30YYK2sdXTxJazHfof+ZdTG57i8kt2XUS/STqGL82NGdjuNTJC7FYZKk/sGutC5ifKSZ9kT65Z9Q1vybP4iZbVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876430; c=relaxed/simple;
	bh=IL/RsTxguukES3K6D9bZQJx9fwT2/FPmdHvDvCi6g1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rf9q96++qMEHN7lzEe6jhTzDJzKTZIa0VMX7K2H5B7iNO/TQlN6vc703SUJjy+eILF5Y72r+yX8cexkB6ZoDbCeUW9kdphxW5F3MS4+jWVoDAJSyAj5DxpnWWns34pN9Q3Myd7MqN5Dvt7nwW36qd4m5pzbulQDZIQmzpx9DNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZJjQswF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 150C8C433B1;
	Fri,  2 Feb 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876430;
	bh=IL/RsTxguukES3K6D9bZQJx9fwT2/FPmdHvDvCi6g1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mZJjQswFWz0sphtUTQvUY1tc3wOr/Rn+slmeQU6Y8V3PAD+dwg07grzyervqykxNA
	 NV9friCwPmc+qYfw9ZXduB+h92Hk4sQJCRYpM82S8H3P2oYsUp0tsAPmZYhcfNDpm8
	 Nf7M0LB5DPmctNo4mSPk5DegZz66PnfaQG0Lu5aJSnl6VLk0zlOSDm+zSh7bCGn04I
	 +bI6Q+lQC/lUbURW67iI4LzbQ5qDskuLCaBe8Ot+b/XplhVMxIGqs4+YrMruw/5Bo5
	 +suc1IqH/oceqkp9Vwe950YB6PeeEmFHRn/q9WYcyS+JS36FME0cs5YpjoV875Sn3L
	 HL0R02kjIMzCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7E8EDC99E9;
	Fri,  2 Feb 2024 12:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Simplify the allocation of slab caches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687642994.27809.1168775974359008539.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:20:29 +0000
References: <20240131084549.142595-1-chentao@kylinos.cn>
In-Reply-To: <20240131084549.142595-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 31 Jan 2024 16:45:49 +0800 you wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: Simplify the allocation of slab caches
    https://git.kernel.org/netdev/net-next/c/fa33b35f86b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



