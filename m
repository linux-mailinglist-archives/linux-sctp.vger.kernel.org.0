Return-Path: <linux-sctp+bounces-346-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7362A3CFE1
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Feb 2025 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF843BB5D8
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Feb 2025 03:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB91D79A6;
	Thu, 20 Feb 2025 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSoejoHx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063D10FD;
	Thu, 20 Feb 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021002; cv=none; b=s2lQbEk7mhxWdvObVYUNF4Mhs6xpQMdLU/NkpC59G7RQcpRJRKLRWRvGk1UiN1FtUePQrk1NH0oobK2s+C08Wngfg8VubnvBKs0S6xo64NeST2iFKn38W0uv6JL7jRDbgjoSf7N/0X8HoLpbv7BNau8v6uCPn6wi2vukWB5U0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021002; c=relaxed/simple;
	bh=sQPO5yuAP9YNK0zeHKSGAGdpOKFDWLU/81x17qsIr5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rIZTF26pP7RJRZlz+UTIJp1ey/KjERwG9Cq8aK1E8RCP8Yv/PDbCBtPt7VeafCQ3F3fiufDNDYFVcs6dUhKNRfUpqqzeFW53iPCsQpHurmILz37x4N5HBAW9WvRkOsoJjZMo/Sgyp3wp4fCBdg3UlMQzCaKGb3KZGAAEs9PkvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSoejoHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745A3C4CED1;
	Thu, 20 Feb 2025 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021001;
	bh=sQPO5yuAP9YNK0zeHKSGAGdpOKFDWLU/81x17qsIr5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VSoejoHxbjpsTolzXUDNI61+xocZk0QFS2UnWIo8fIicAvwsH8USYVir+FVZZDCpj
	 3iYj85KKzCdTSrlwnxJ/iuHg4SWT3rYw24C9D3O8u3A7Lwjngajp/jvVmHU9Usf8nZ
	 i6QTcM0jOEwcFsC1MEUjPyaxGqYw56sIvNavCzIADWt5a3hzF0ld2P3vW4cQmsuXom
	 JahTbaN7Tm5/Jl4ZjsgJly57IT+/KWJdbzY0JMzfqO+h1IaRo7V92/WOlsDP6aGMAD
	 +azdfKsqk/4buk0Vu57iC+/QujoO1HZ6bGd1HQYrSY4ExJvcctX2rPOcnB95GNUA/y
	 c/Ku6ZdsE7gfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAA380AAEC;
	Thu, 20 Feb 2025 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: Fix undefined behavior in left shift operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002103182.825980.16973479436826416109.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:31 +0000
References: <20250218081217.3468369-1-eleanor15x@gmail.com>
In-Reply-To: <20250218081217.3468369-1-eleanor15x@gmail.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 16:12:16 +0800 you wrote:
> According to the C11 standard (ISO/IEC 9899:2011, 6.5.7):
> "If E1 has a signed type and E1 x 2^E2 is not representable in the result
> type, the behavior is undefined."
> 
> Shifting 1 << 31 causes signed integer overflow, which leads to undefined
> behavior.
> 
> [...]

Here is the summary with links:
  - [net] sctp: Fix undefined behavior in left shift operation
    https://git.kernel.org/netdev/net/c/606572eb22c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



