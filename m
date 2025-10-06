Return-Path: <linux-sctp+bounces-630-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B6BBEE37
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Oct 2025 20:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0076B4E74A7
	for <lists+linux-sctp@lfdr.de>; Mon,  6 Oct 2025 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DC248F58;
	Mon,  6 Oct 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6hVmrQG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB817DFE7;
	Mon,  6 Oct 2025 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774218; cv=none; b=bBL6ER0uci3MgT8Rwec87x20MI1KFZ8QvrDPzVpp/aXsvBhJ8CpQpLe0bKD+S2VM7Fgi/Bhli8SgmEE/PWaZnc5A8QxgCmYQKTGDYJ8PYC7OYfL0vzpJCfdYldJLTwFFGfIv4cl3Q81BSHUqBK56a6NM4QscQq+0iUdLM1k8xas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774218; c=relaxed/simple;
	bh=ayzhTwguH/mNDlAop01j/HIjxlM5VBsEW34/71Ke+7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UOwkqnPnVbFQ3/36ETbG22cL9UhMM0+aCo2RQWYVtwHyHf0srncVqS3aSQy/BoacBEjM23h0glRBt6mroTlswbighrord5z0EdtXIb5UJnFwBMHdMO5+XM6zfeyqaCd3W1PqXZrH4zX5FVEqXpYSnRO+vS7zgjc9C3Yz5SpxgpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6hVmrQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EECC4CEF5;
	Mon,  6 Oct 2025 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774217;
	bh=ayzhTwguH/mNDlAop01j/HIjxlM5VBsEW34/71Ke+7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L6hVmrQGs6et0DiE6qxE+9wgs7rmjW9MtE/DXdgXUbkMRohzJMaKZiCV7l9jySc73
	 hgbxOxqaAY8ixG1ssyc3dRWEaRKBrI4D7lzhs64Xkver3hZWKD34F6Kwh++yK8bmD9
	 +WC8O/t1M12qyna36cRGUsVyh9qYwpNXwv5Uc84UGtMBwi1RASTZWgMOwAUw+ITNqg
	 QvwnnZ0fr8ldLXS2hXfAiY7Tk/FQiUjppgtzOuTR6Xsvs9sPiD7wy9zyEbYUSinNAz
	 Ur9ek0te5lnd8ogI6f27h3B6xgA8XgszCa4+a8JqC7npplovdAAm2m7LlM0FAmTFwy
	 D0Pa/OfB4kw7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFFA39D0C1A;
	Mon,  6 Oct 2025 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sctp: fix a null dereference in sctp_disposition
 sctp_sf_do_5_1D_ce()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977420676.1501685.10709505503696041179.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:10:06 +0000
References: <20251002091448.11-1-alsp705@gmail.com>
In-Reply-To: <20251002091448.11-1-alsp705@gmail.com>
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Oct 2025 12:14:47 +0300 you wrote:
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
> 
> If new_asoc->peer.adaptation_ind=0 and sctp_ulpevent_make_authkey=0
> and sctp_ulpevent_make_authkey() returns 0, then the variable
> ai_ev remains zero and the zero will be dereferenced
> in the sctp_ulpevent_free() function.
> 
> [...]

Here is the summary with links:
  - net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
    https://git.kernel.org/netdev/net/c/2f3119686ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



