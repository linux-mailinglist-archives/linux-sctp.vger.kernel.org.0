Return-Path: <linux-sctp+bounces-338-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA23BA336AD
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 05:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319EE1692EB
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 04:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED58207644;
	Thu, 13 Feb 2025 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9nUgfY5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8B2063FA;
	Thu, 13 Feb 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419807; cv=none; b=Gp17SOZUIdml/uWoWkzOwHBgHvhfW6+7nH9ebV1HcJ7/iS3xZDDe3cNY7UWgEPfllmcxpN5HnqEH1e+frPYWG3dQ7nsYfoDmuS1ab7dQVxbSfenKA1GCSjw133evsJw371CmOnpqVRt+fAXYB9w6iASMwwdv23HNvxHghr1peLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419807; c=relaxed/simple;
	bh=KskuWRIgnX1ICvstdm39ZQS6EwUeH0DTwefJxgEQuro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pskSymYSjG0T6RufAtkgOTaXepmfb/CvMagkBSzjgEGNCqKTs2/NBedja2E9TolMuC0nWWXX71Mbb/krkx4dE9Pp3252jSGTciqwuRcuGj4OEMdDue+SO+iwtwYsSYKx4SiPhiq/d10hSve5EZREljFe/TylpKAVWQN7C61TXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9nUgfY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552D5C4CEE6;
	Thu, 13 Feb 2025 04:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419807;
	bh=KskuWRIgnX1ICvstdm39ZQS6EwUeH0DTwefJxgEQuro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X9nUgfY5yhFu98TIPc3/kcJnI25wjuCL2qtuUja4H53DtrmzfjWdIchiStDt/nOKM
	 98irUsecHUCM2gQOQACwiRhHhhPTvwexuOp5PaTrfPmRDOjAOZ0x2WNjjPzaeWMs3B
	 KWQVzsL5oibD3kVlaJZU1gkpSQXDDh2lCEXyeKVKA+6AWY8CFlUuyv6yT3aAbc78+Y
	 tClfKvIJPaDRBwUva514LP40osHlSLUhGvuf1KvgxlCtqcmJtG9auBvKEednRcbANY
	 Ik3k1sc9d4xMXLC9yIVjVsOxl9GBs+LLjkUfbypl/ZgKgN+fpHjqQTAMpY5aiTRWop
	 Mzsv9fRxd7oiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECC1380CEDC;
	Thu, 13 Feb 2025 04:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941983650.756055.1175139816039895035.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 04:10:36 +0000
References: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
In-Reply-To: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
 thorsten.blum@linux.dev, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 10:24:55 -0300 you wrote:
> All SCTP patches are picked up by netdev maintainers. Two headers were
> missing to be listed there.
> 
> Reported-by: Thorsten Blum <thorsten.blum@linux.dev>
> Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net] MAINTAINERS: Add sctp headers to the general netdev entry
    https://git.kernel.org/netdev/net/c/15d6f74f03f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



