Return-Path: <linux-sctp+bounces-222-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F795F722
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9071C2138E
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022B019754D;
	Mon, 26 Aug 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q45WC5lK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2E1946BB;
	Mon, 26 Aug 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691028; cv=none; b=KaeFelZOoaD3Rh0ehgBozAXpxG7jgTko/gYpA1pi2mXz/tJmMyTdg8jBOjN/tCV7hMg1dYAwa2xLA6eV+E7low3oC9+lFmSjWB0AUPHX25wQlyj/CWa05jvhvVDRmjllMPiUN4iiZHqJPIdgX5UtSnta8x6uf8rDrexfZRfypYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691028; c=relaxed/simple;
	bh=Z+nM13pnLmDsTBNfVDKA+YqeuZzbs5Ifw349S3oky7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h8rhIWOvvSZcZ5xXYK85NAkzeX76TsWS9GdkQH0N6KWZtj93ZMHgLpbr1kjS3aGjQtC5EIcIx8GzSI+vsHLAZaa2Lx8hEqDKmgKFd74SoOWVaKEVAjs9dm/NDujFsA0B+vp+GqnzHs1IGmwA3+mduJwsd+6qLf5K3fFcyQp2TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q45WC5lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397DAC52FC5;
	Mon, 26 Aug 2024 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691028;
	bh=Z+nM13pnLmDsTBNfVDKA+YqeuZzbs5Ifw349S3oky7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q45WC5lKg/LkyteFnRbpI1iVwrc9eTD/Da68nGGe2YlnxLncY/jJgOsVR9s3Titvd
	 dBgkZNU1Rqw4anGmADeZa5HXJuVBAfr6oMEf6Xt5OhVrePmo3B8G4k53Sk2NiRloQB
	 ISL+3I8b6r3AGuf2gw+HmJnL4NgRx4YOmnrQ4ywPT+JczgW+zKi53lxtvc0ysLApRZ
	 upSfKB+5eyy9Wnxntr1Ryfs4oCeUgPQ5+BjVVBpb9cbnBU2kFiULsTV5g+aKNM0RR7
	 PYQ0zCLA1X0W9EQOIn5lgEOi/Lg9lDUfBldl120A973U/vmbbqnWAYmKVA63ccJr9J
	 KQg6V3VRGYL7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710CA3822D6D;
	Mon, 26 Aug 2024 16:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] net: header and core spelling corrections
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469102801.67399.18155018116632832948.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 16:50:28 +0000
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, dsahern@kernel.org, jv@jvosburgh.net,
 andy@greyhouse.net, quic_subashab@quicinc.com, quic_stranche@quicinc.com,
 paul@paul-moore.com, krzk@kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com,
 lucien.xin@gmail.com, ms@dev.tdt.de, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 13:57:21 +0100 you wrote:
> This patchset addresses a number of spelling errors in comments in
> Networking files under include/, and files in net/core/. Spelling
> problems are as flagged by codespell.
> 
> It aims to provide patches that can be accepted directly into net-next.
> And splits patches up based on maintainer boundaries: many things
> feed directly into net-next. This is a complex process and I apologise
> for any errors.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] packet: Correct spelling in if_packet.h
    https://git.kernel.org/netdev/net-next/c/d24dac8eb811
  - [net-next,02/13] s390/iucv: Correct spelling in iucv.h
    https://git.kernel.org/netdev/net-next/c/c34944603248
  - [net-next,03/13] ip_tunnel: Correct spelling in ip_tunnels.h
    https://git.kernel.org/netdev/net-next/c/d0193b167f27
  - [net-next,04/13] ipv6: Correct spelling in ipv6.h
    https://git.kernel.org/netdev/net-next/c/507285b7f9b2
  - [net-next,05/13] bonding: Correct spelling in headers
    https://git.kernel.org/netdev/net-next/c/e8ac2dba93ea
  - [net-next,06/13] net: qualcomm: rmnet: Correct spelling in if_rmnet.h
    https://git.kernel.org/netdev/net-next/c/19f1f11c9a8e
  - [net-next,07/13] netlabel: Correct spelling in netlabel.h
    https://git.kernel.org/netdev/net-next/c/6899c2549cf7
  - [net-next,08/13] NFC: Correct spelling in headers
    https://git.kernel.org/netdev/net-next/c/10d0749a38c3
  - [net-next,09/13] net: sched: Correct spelling in headers
    https://git.kernel.org/netdev/net-next/c/a7a45f02a093
  - [net-next,10/13] sctp: Correct spelling in headers
    https://git.kernel.org/netdev/net-next/c/7f47fcea8c6b
  - [net-next,11/13] x25: Correct spelling in x25.h
    https://git.kernel.org/netdev/net-next/c/01d86846a5a5
  - [net-next,12/13] net: Correct spelling in headers
    https://git.kernel.org/netdev/net-next/c/70d0bb45fae8
  - [net-next,13/13] net: Correct spelling in net/core
    https://git.kernel.org/netdev/net-next/c/a8c924e98738

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



