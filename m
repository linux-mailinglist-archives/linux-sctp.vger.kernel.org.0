Return-Path: <linux-sctp+bounces-225-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E363B961A69
	for <lists+linux-sctp@lfdr.de>; Wed, 28 Aug 2024 01:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1523284DB1
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Aug 2024 23:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDAB1D47A4;
	Tue, 27 Aug 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrfHSGiR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44B1D4618;
	Tue, 27 Aug 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800831; cv=none; b=l1nGJenntmXvFDo38reSTK65yQ6FI2Q7LRmHLcaA5AtzCa10EAeElkaEztTO/WbBW4j5An+2iglrSxNONcWup/qFWmayGDSwWcGRK8ScNlfJK9it3+WVMkHrVGLJlfPdeJ5a0O02M2EwRA+gpUxvCIpYH0yIR9GV5E7Klqb1jEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800831; c=relaxed/simple;
	bh=kwLKKjeVrbCsWWOOaGFaaEgALyESZIHFayJqbW+xteE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=twaPLskt6c6TXFrLVbAQMDEvd3bnpknmWC2wRcZ5b06Sh5R8keNcz9kdosz2PzmvtpbfSL8/e/NdLGXR8TGMuW/s3GroZhXsreKzQsW2Ve9hGZ3orO+skzUWCc3Sx+gKdnvQ5oKYhUx2jJdcHUv6SzdvVv9ih4Ezc+kA2Py3KV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrfHSGiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249EEC4AF61;
	Tue, 27 Aug 2024 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724800831;
	bh=kwLKKjeVrbCsWWOOaGFaaEgALyESZIHFayJqbW+xteE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CrfHSGiRmHGRTVgMEyvIXORgnoLcCaBDn7cE8JMKLSN9/WwF53xGLK23TOSMMppJ0
	 MYIlFiJN+iYcZkzTNCWArOXBHaUU54xq6yFwt76Al8lGgsZD1ito/37C2sujz/OP6a
	 SxegJXMjycIJvHppgtvh+//eFW18oSI/xPn+CsueouuJH5tA8jLUmatGyi4ASz+enY
	 O5HnrfBULs9dMcrDPWLTL9UenIp3ogGaHRNs/ogjHmMvG788lqbAdesy0SLqSArikJ
	 yDO/qMVMmrEfxRGkYKgb9v06v+/5Xr1uJJpPzgTCcjtzVkjdhSkZLeK5ceBV3bR8tJ
	 ZKMQoDEhqBnfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0A3822D6D;
	Tue, 27 Aug 2024 23:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: fix association labeling in the duplicate
 COOKIE-ECHO case
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172480083124.787068.2952553408915985956.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 23:20:31 +0000
References: <20240826130711.141271-1-omosnace@redhat.com>
In-Reply-To: <20240826130711.141271-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 lucien.xin@gmail.com, vyasevich@gmail.com, nhorman@tuxdriver.com,
 marcelo.leitner@gmail.com, paul@paul-moore.com,
 stephen.smalley.work@gmail.com, linux-sctp@vger.kernel.org,
 selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 15:07:11 +0200 you wrote:
> sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
> on new_asoc, but as it turns out, this association is always discarded
> and the LSM labels never get into the final association (asoc).
> 
> This can be reproduced by having two SCTP endpoints try to initiate an
> association with each other at approximately the same time and then peel
> off the association into a new socket, which exposes the unitialized
> labels and triggers SELinux denials.
> 
> [...]

Here is the summary with links:
  - [net] sctp: fix association labeling in the duplicate COOKIE-ECHO case
    https://git.kernel.org/netdev/net/c/3a0504d54b3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



