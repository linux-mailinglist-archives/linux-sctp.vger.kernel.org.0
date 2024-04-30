Return-Path: <linux-sctp+bounces-131-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764198B6EF6
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Apr 2024 12:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8744DB21624
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Apr 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8041292C1;
	Tue, 30 Apr 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUW17jeW"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE0127B52;
	Tue, 30 Apr 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471229; cv=none; b=o4NFsB+vI0jxqigemrPyx/WGt5XKh383g/w/Gwk0IwTkAcwoQ+8nUFJ4MwmR0/k1qCJUSYp5+biqT9tUAEtdBNRUs0rlhHQC+1+hKLvFdzOfHKgHOxGZGzo8RSqdXVnn6ct/Lyk92dzceFz4+rvvKzJGpHzF9G7/6fUfk5JgCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471229; c=relaxed/simple;
	bh=MHyZeaS+KsqiVPyuRvBCY6fQF1j4giypol4OIFp2woU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iO5O35wWH2Hqk4bb/b1z6AkFtzqss+AnrcydCB95EZry7M5H2PmJ5UrlHtP3oa0QOUQcs96QJkhl2i4Q6NJ1bhtCEhrvd9Z5AhVYJ1xboIksGgRvXHljir3h5yikvprgFAaBzt6PSZLaeov6urlx8S6BJekSCNBiavqdcFeDbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUW17jeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCCC7C2BBFC;
	Tue, 30 Apr 2024 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714471228;
	bh=MHyZeaS+KsqiVPyuRvBCY6fQF1j4giypol4OIFp2woU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jUW17jeW3GnlgGV/snuIvTuQPb1MDqNEQy9Ic+rwX905MzYk5ZOvQuzUBWfLzWdkH
	 ndKs+91rKHk+opObKK2Q8uIDdOLeb4hDH0do0SOMxCHJmUMHD7N5iu493d0DiVm7bU
	 QitGTzqG5u6gYOClgkhUO7ngUq/GbArRE7RIJkb01S9wUBrF+PN+4E3bFdGBiXRi3T
	 LZ81btDHeNIZkdqDidAB5e3VY406WIreQb5hMQ6z1ib1JyBX/IzctUwHINrAP8hvDG
	 KjbQCHNWb1a4EKADHcGAllTWPAl1PGKPZoAF8RlmeFJgunBXE7pADjisSxE0Qj1oi3
	 AF2bgpYNS7dzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAFDEC43440;
	Tue, 30 Apr 2024 10:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sctp: prefer struct_size over open coded arithmetic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171447122882.13432.12922160974724151108.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 10:00:28 +0000
References: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
In-Reply-To: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 keescook@chromium.org, gustavoars@kernel.org, justinstitt@google.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Apr 2024 19:23:36 +0200 you wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "ids" variable is a pointer to "struct sctp_assoc_ids" and this
> structure ends in a flexible array:
> 
> struct sctp_assoc_ids {
> 	[...]
> 	sctp_assoc_t	gaids_assoc_id[];
> };
> 
> [...]

Here is the summary with links:
  - sctp: prefer struct_size over open coded arithmetic
    https://git.kernel.org/netdev/net-next/c/e5c5f3596de2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



