Return-Path: <linux-sctp+bounces-490-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD0AAB86F
	for <lists+linux-sctp@lfdr.de>; Tue,  6 May 2025 08:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C643B92FB
	for <lists+linux-sctp@lfdr.de>; Tue,  6 May 2025 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CEC1C1F02;
	Tue,  6 May 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwcstDNv"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5207260B;
	Tue,  6 May 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489655; cv=none; b=RrpsYX9eZ4WGdeeT74Os2ac8PFqi7CcTi+HwUF4LFnYKOi452N3ktcZGD4vpbUVDI2OSV0X1PVvdr8KWZaitgCedJ/SvqrD2SghUVVYHp9B9TTIv2namE54jpgU/NBsfGRBs82fM9Ti0QWNrUFyXBctU8Q7lImXDxRBZupEWOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489655; c=relaxed/simple;
	bh=7UmPEgd2stUZWNUlGXSMSq6FvDhWJiXCAAfS3fJyJ1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VDRpjRA8BRHg5Aso4bmaP5gcy9E+MLIHLgpyOanC070onQg5i/xdQDKO5kxtuGxLbCb3NQyWwHMMveqjBt4EV4twKpWe64nBd3nlnp1YyfgemGOK+M54e5aHp7T95bTJltHAFbi/Dx2Ja4OnUXo8Q0cUipNZxzhOQTHPHNR0nmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwcstDNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D584C4CEEE;
	Tue,  6 May 2025 00:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489655;
	bh=7UmPEgd2stUZWNUlGXSMSq6FvDhWJiXCAAfS3fJyJ1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WwcstDNv0IYwi2wq87TsuMr9MWdc5QXmmH2BNldNLphEjLvv3oR7Qda4S68+IuTgt
	 owKKYKH1Mj3UAaTR2KAZICcsreWZWAcpwnhJHi4h5lRbjpohAei/rlw3qolAgtPShg
	 GDqiHYhwzEzf0gZ80lrPeQQsAXrteMpCQkiTOgDfB/Sh8GOMbHpZPmk6tdb6G1ZxHC
	 dHSL4KMpyVX9GZJJtyZQ46YlDHTkckuUEbiSRXAD62pMnfvOjJP3oxEcZWkPiRiwqj
	 LRatn3dWsFJHkUCS9wOduPd1l6I9Hnl1ZUkVrCZN+l+n17P0RiQtyZf94eVcSpybzq
	 p8lU6dLAcrU7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD71380CFD9;
	Tue,  6 May 2025 00:01:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Remove unused sctp_assoc_del_peer and
 sctp_chunk_iif
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648969424.970984.5023891788546204578.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 00:01:34 +0000
References: <20250501233815.99832-1-linux@treblig.org>
In-Reply-To: <20250501233815.99832-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 May 2025 00:38:15 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> sctp_assoc_del_peer() last use was removed in 2015 by
> commit 73e6742027f5 ("sctp: Do not try to search for the transport twice")
> which now uses rm_peer instead of del_peer.
> 
> sctp_chunk_iif() last use was removed in 2016 by
> commit 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too")
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: Remove unused sctp_assoc_del_peer and sctp_chunk_iif
    https://git.kernel.org/netdev/net-next/c/ac8f09b9210c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



