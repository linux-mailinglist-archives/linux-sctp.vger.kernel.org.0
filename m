Return-Path: <linux-sctp+bounces-357-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F208BA442D3
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Feb 2025 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B168603A9
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Feb 2025 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4426A1BB;
	Tue, 25 Feb 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5+51SdR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F5269D06;
	Tue, 25 Feb 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493806; cv=none; b=QwCvFSR1p1J5s4rCuNk9ODiqJxPDXvpiDkPM8RuStUE39hy+9XQjAFeinL3H4ECUIJa1uuXMbEcV+ta5Zmz3ep9wGJGum6III0L1ILmeCSpIdV8YQV4Kgzn+fMrhmDGpPtNeGwz700GUHwyQaKlBTPE0iBrLIQ6cULXreZCcSSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493806; c=relaxed/simple;
	bh=lYjpObcEnEszvzK+aJGxjwhQQRARi3ET5qF3EhUkLIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2yitnnQMnd2Fv+JvZCof/Zxgh8KzyJ3AHQhlPUGzKowBdP0TRNZlprOLO8pMjHOxUm48QX+RA9pz7JChkbHR+1OdwnLoGu5DcZRCsIFj9gTPeeb10/FV+wVNqkVCJ12QAHjla8B3QB1HfwqBD9RWR8adrhjcUZ84RbP3HIKgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5+51SdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4244C4CEE8;
	Tue, 25 Feb 2025 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740493805;
	bh=lYjpObcEnEszvzK+aJGxjwhQQRARi3ET5qF3EhUkLIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U5+51SdRk8hGafYwIxqpUFe+KIvMBMPUF5N6l1wHBHNVO2oRK1ZVz4EdvUFJ5H9xB
	 1QCvX6E5vMYDsIgEnfkjRMpMhJO42jndtzxC2swYJmRW24YSZ223W1EHDCBGONX1uG
	 sXlhBdz2e8Eimk0uRrBaA6u2tZ4f5hNkjJ3cQj2GRp8YTpwOcQXL/sds3dULh4dfzQ
	 e8TVHgWhX7JNRz5FYOQPJZEyhIxUxRCJASnxU5axSaFtapFiTYa7zLgDFrVtdLwNaa
	 Z3ApKyxAixo8ve/KOT0LvnGw7tIkm5kkrqEqExq7gKIdMpdCxe5yWikZrS0PivWXMq
	 gdZd7nNTty3fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7120D380CEDC;
	Tue, 25 Feb 2025 14:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused payload from sctp_idatahdr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174049383727.4190834.5787481246783621819.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 14:30:37 +0000
References: <20250223204505.2499-3-thorsten.blum@linux.dev>
In-Reply-To: <20250223204505.2499-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, kees@kernel.org, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Feb 2025 21:45:07 +0100 you wrote:
> Remove the unused payload array from the struct sctp_idatahdr.
> 
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/linux/sctp.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] sctp: Remove unused payload from sctp_idatahdr
    https://git.kernel.org/netdev/net-next/c/287044abff82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



