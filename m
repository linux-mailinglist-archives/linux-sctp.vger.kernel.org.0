Return-Path: <linux-sctp+bounces-735-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C1C2EBAF
	for <lists+linux-sctp@lfdr.de>; Tue, 04 Nov 2025 02:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BF384E3904
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Nov 2025 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE61E51E1;
	Tue,  4 Nov 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZUyN0iK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0248CFC;
	Tue,  4 Nov 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219236; cv=none; b=VsvGSSHnqYs1OWUiIaDgdKbae+9lThLV0eICNRSyRiysz4gTASgr/D9EP3o7R1srOggfmLn4ilC8RdI/Otb8yJNL3y0HihI1ekohMZcaYrnLsC4H13nW76gT8zSrS3VJsLhaAJJZc1uPFz89ybhFrn6m005wqeE2wtZggAyXPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219236; c=relaxed/simple;
	bh=TD/qBiut8Q3fOUSVUkya54d2NdpKJWqCLCGtedg2LM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sWIRoi+T043FWhVwKHGhKYrg8zO9jdGC6UkyheoZfNlvtlnIKIRojtKn3JdXL3QdXS7yODDR+EYLMjgVeXOQtuKFI0FLPGdfW218mrf43EhHpmiuJbwa0WEevX7587n3753IeRtpps+KDka+IEnctL8kn46r3XHdHu8S03NS8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZUyN0iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD65C4CEE7;
	Tue,  4 Nov 2025 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219236;
	bh=TD/qBiut8Q3fOUSVUkya54d2NdpKJWqCLCGtedg2LM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RZUyN0iKHdF4zwSREGsV280MOjNTJ6hKDtfiqgQcZw++etDYt/dbAVBQcyRxqHAcb
	 9HCpVXGdHzcvSdAHBUBChJ+HMlHxc95zm7Xkh4Yhb3QaPdJxWjPwtWbWW0+XspzxNu
	 x9Mh0bc18WvhhhGz3GymMQ7jTkwGAnHwnvMPlSzEY27nrlaqfJGJ2LFa17Y7dCgUUH
	 d9DMLTOMXuLns99+K79IIQclhMW8ju8fX9Xdae7PComjXmKqPWLo/O5lFYVoRPEmp+
	 uWBzG8TYrv7vaccVSynQVgwHNARhMEB8WdgRZdwxMdVwIX/n3GfwA7/Sqsamnqt28m
	 3wpAPjcopTllw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD403809A8A;
	Tue,  4 Nov 2025 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] Fix SCTP diag locking issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221921049.2278528.4515165353981721128.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:20:10 +0000
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: lucien.xin@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 17:12:25 +0100 you wrote:
> - Hold RCU read lock while iterating over address list in
>   inet_diag_msg_sctpaddrs_fill()
> - Prevent TOCTOU out-of-bounds write
> - Hold sock lock while iterating over address list in sctp_sock_dump_one()
> 
> v3:
> - Elaborate on TOCTOU call path
> - Merge 3 patches into series
> v2:
> - Add changelog and credit, release sock lock in ENOMEM error path:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027102541.2320627-2-stefan.wiehler@nokia.com/
> - Add changelog and credit:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027101328.2312025-2-stefan.wiehler@nokia.com/
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251023191807.74006-2-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027084835.2257860-1-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027085007.2259265-1-stefan.wiehler@nokia.com/
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] sctp: Hold RCU read lock while iterating over address list
    https://git.kernel.org/netdev/net/c/38f50242bf0f
  - [net,v3,2/3] sctp: Prevent TOCTOU out-of-bounds write
    https://git.kernel.org/netdev/net/c/95aef86ab231
  - [net,v3,3/3] sctp: Hold sock lock while iterating over address list
    https://git.kernel.org/netdev/net/c/f1fc201148c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



