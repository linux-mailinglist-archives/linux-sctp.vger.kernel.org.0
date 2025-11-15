Return-Path: <linux-sctp+bounces-744-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DEC5FE13
	for <lists+linux-sctp@lfdr.de>; Sat, 15 Nov 2025 03:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BF6802415B
	for <lists+linux-sctp@lfdr.de>; Sat, 15 Nov 2025 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1751EC01B;
	Sat, 15 Nov 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDR/zVwP"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1271DF27D;
	Sat, 15 Nov 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173252; cv=none; b=MJYEH5I64PneBDNrWnE6FLfE4D42uWU0DbWK1Hl1GmL/I/cCTf+0fxxqafgwd8CyFw30RgB4yLZxQko5Zo7EoHB1DZTxnSqCcYu4HIpVObFoppy9ar3AkKxds6eDj7HO6tfVMASMopt9i8kpgpMw8xsDgCT1vDOuPAK6wLb9o2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173252; c=relaxed/simple;
	bh=9QfDyCm4V/9mKzSlYViXTU/+kcyUr+j9Ub1eup8YlxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rKK9mITjljHKLdBjyaLf2sy2236iAzHDkdwXUeeovySUS2zQqRHA7SY3zE+4qJ0QFFG30gCLUkevkjJ1HeAN0wd/o2G+oZHmYXlIAR5tXbJ/9r6GPdBslAC2ZXwYahNWQPMIaDo5JEn+W9BwycIJItvTKw1narybomo5iAQ0Soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDR/zVwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC03C116B1;
	Sat, 15 Nov 2025 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173251;
	bh=9QfDyCm4V/9mKzSlYViXTU/+kcyUr+j9Ub1eup8YlxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PDR/zVwP/UfmVfgQHy5Kz3mfiWG79aFxgJzwkwuHZm80+NjlviOBhG9p4z8/ZJVA5
	 A6B1RBJyTUT+TWzCvRKgEDaVAMjkqpk10SDHRIoRBcsF2+pHj1XYbeOIF0BTz7Zpe5
	 eEYFJyzyIhWXloOmQKNw4Pde3XaP0rWZpoexKmLq09DCUMhwlKzcvKRPrqASTl8z66
	 G2x+3Ow7QpvN5XuwHV8sIHVXbpoxIfAvarxaBUhVurDxUICXLTiuY2gu9vGlnDYihk
	 qRIvJlZuHTDIF6dYA055NvsTTCdjmsn/qb3Gxi91Z/zp/af5U9l4nsvDK6pXjLsdEq
	 LiBcVga1PDtlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F443A78A62;
	Sat, 15 Nov 2025 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused declaration
 sctp_auth_init_hmacs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317321999.1911668.1938013986428501562.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:20:19 +0000
References: <20251113114501.32905-1-yuehaibing@huawei.com>
In-Reply-To: <20251113114501.32905-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ebiggers@kernel.org, linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 19:45:01 +0800 you wrote:
> Commit bf40785fa437 ("sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk
> authentication") removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/auth.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] sctp: Remove unused declaration sctp_auth_init_hmacs()
    https://git.kernel.org/netdev/net-next/c/06ac47065819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



