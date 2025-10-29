Return-Path: <linux-sctp+bounces-724-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87EC17DD4
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Oct 2025 02:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427D41C63717
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Oct 2025 01:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8AD2DA74C;
	Wed, 29 Oct 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HseJI8EQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE12450FE;
	Wed, 29 Oct 2025 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700844; cv=none; b=AqgwN6BOMb8vJgjNgICoAk8boERyLSE/hZTtb9Ce+O/qrIPpSATpm2pxC+z0X/6lyrxceal6VQckox0TXdSFHdQfmZljZ+yBNH5LPEkZsR2MBuYllUuD5Niy/a+3HNrdaV1ktN2LqlQSBxgqeOqOYm4mzWGCDduTchyLXHCysMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700844; c=relaxed/simple;
	bh=eV6b7SDHP+Vkl1TiP3mbIiNQrJ+BdkqQValezmyauns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JxYyF6qfZM9zqQ8m2lP+ov5s5HFq7by/oLJMhZnbKkIwFDOgjNbhOPCDfBlksz8OFx08nuZQVl4924vpmWhtRF0ytmskg+aVqzUyDF9vmO/aqDqkrdoZmvX90KNaV0S1J43MvPUGLx7AIT5TI+4ls4+Q8SUjtiZ/oa6rc4Vr3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HseJI8EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3393CC4CEE7;
	Wed, 29 Oct 2025 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700844;
	bh=eV6b7SDHP+Vkl1TiP3mbIiNQrJ+BdkqQValezmyauns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HseJI8EQQGsOI/qFp2mPKLVdymRJJgQa4B1Xw4QqJqMl0nI8oG9gVNB1vqsebNxPC
	 ncs0ZhA0w20LBj88eYmBNMx+HRRZ2MxFmY3VarUBP6JkLzgMydHzZc61EgmITCOD3Y
	 enb6BmJjQISczkvXAvZDt463WPkgl8h04R/NcNuXkJUWQCwkkdXDGfIe7vnNxOQMW+
	 xM/2AIOlwEgbfuYOUGzXUhoyg054lFf4b8amF8m9Eum7T222A3zFH3iXAnrIuBRYSK
	 GtraIC8N5dqjTcKXALDzsNBnpPq/yLx4RDkpJlRolr2TOO/SyG+ohGB7VWeAWtUcmA
	 QjUmckuYnmR3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF1739FEB6D;
	Wed, 29 Oct 2025 01:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sctp: Constify struct sctp_sched_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170082175.2452213.16789449106811751302.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:20:21 +0000
References: 
 <dce03527eb7b7cc8a3c26d5cdac12bafe3350135.1761377890.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <dce03527eb7b7cc8a3c26d5cdac12bafe3350135.1761377890.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 25 Oct 2025 09:40:59 +0200 you wrote:
> 'struct sctp_sched_ops' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    8019	    568	      0	   8587	   218b	net/sctp/stream_sched_fc.o
> 
> [...]

Here is the summary with links:
  - [net-next] sctp: Constify struct sctp_sched_ops
    https://git.kernel.org/netdev/net-next/c/294bfe0343da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



