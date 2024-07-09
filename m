Return-Path: <linux-sctp+bounces-178-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0A92B41F
	for <lists+linux-sctp@lfdr.de>; Tue,  9 Jul 2024 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2839F285780
	for <lists+linux-sctp@lfdr.de>; Tue,  9 Jul 2024 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9215575F;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPPo5X/b"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C9155753;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518031; cv=none; b=Omp1agKuKjoEXdFOSpcgFrwSa6m1ED9Gq7lEmhVBkK0t5RcQtvsNT/lTahpQxzBvon3YpogufiWWV7Al+gHtARHI1HK9VOzHF7Q/1TIEABDe9LNQHapqhjK8C13zbk/JPbHnDoSsPoPYIvJkYKbdF5bDprCIwJEmL1k8dpyCtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518031; c=relaxed/simple;
	bh=5TIaHQ1h+ppVKyq5g+uP5cTKU9LcAIWcDNPYXCulD7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X/xH+sAsbTML/SW7TiUAMi8rgdT101tmXoc6ynFw+i/eZ0mXTkjpBQsg+b2/rb10SXnA1ZGfe4CG12ro0yzulfN27RB5wetQoGBvoCfHs4lMg2l1p1cssdRyzeeW9VXh4ip8nTJS+ibt10aCAIkL+jHTTVtPeeydVQti/Ep9Aos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPPo5X/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22348C32786;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720518031;
	bh=5TIaHQ1h+ppVKyq5g+uP5cTKU9LcAIWcDNPYXCulD7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SPPo5X/bCtv3Mi1LdAJlKQ1K8op5SsPFs1QeUOSihKjA1ELyFoCCqNXxDVlK1W8E4
	 GyPOcwgApIP4s7KxpDIQRs/uZ1tw2uDn5A6jixd77GyypWBtw3znpszVN6Sizy4ykv
	 lcIRVHGPxGesMxRvFERH+9Zrq7eiSn6SIoBEUqxAGHNtm9izL4mJgA+7c8sxy/1YVf
	 oM5vmp5IqLupI7ZmCoavt4v13BYgdd1wg1/vhZCCz+BKu6fMI8l4zO0qYEz6zttOPs
	 A3l6D//cViNp9hRVyZbQw3bS6wNcAv23xjKyYS0qMVROYareEA/9QU44uIvLiqn32m
	 hqoH5PqQ8Vr3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 109D2DF370E;
	Tue,  9 Jul 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Fix typos and improve comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172051803106.11180.11030029705775228284.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 09:40:31 +0000
References: <20240704202558.62704-2-thorsten.blum@toblux.com>
In-Reply-To: <20240704202558.62704-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jul 2024 22:25:59 +0200 you wrote:
> Fix typos s/steam/stream/ and spell out Schedule/Unschedule in the
> comments.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: Fix typos and improve comments
    https://git.kernel.org/netdev/net-next/c/417d88189ccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



