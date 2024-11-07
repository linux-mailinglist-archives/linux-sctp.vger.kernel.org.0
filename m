Return-Path: <linux-sctp+bounces-283-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40A9C0941
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2024 15:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED811C237DC
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2024 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69644212D1A;
	Thu,  7 Nov 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq3yWYmg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B9FC0B;
	Thu,  7 Nov 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991021; cv=none; b=BXYgVjehlB80AOwiEjKtheVk7WK5twofNHzmKyXl9qsTrU2A+9Kf97Y0z9hxCKBwUYixy29ktXKVNuYYghanYAri9gxeu5IlcdT2V6P8klW4bjPKNXcvFJjcY3nn9k6vNI2Q3Xe38V75bI6j7REl2wSYuR1hrGdzCJY+qi6G/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991021; c=relaxed/simple;
	bh=3Gyuz2SfGh3s9UUS1lWkFaC0Alg555DvHaLch5ZZqC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=osIaX76h7xWOo7WyfxSsp6cHcP6MY87EnmJgqW+jHlKl31VcWm3VGMqW9UGP1mBGDwolzVXiSjAkrvlqPlJVgdvVuFAaMGFgpVjs7Md2OJpO16L4Ev+zyo6gfwd8kZvExoZcGT/a9PkMnNxqp6JWKe6SUDQmxDbJ3HYtKDb6ZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq3yWYmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93F8C4CECC;
	Thu,  7 Nov 2024 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991020;
	bh=3Gyuz2SfGh3s9UUS1lWkFaC0Alg555DvHaLch5ZZqC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uq3yWYmgiInsQF4i0gQ20a20xNIrkyisdeoRNB5Dd/JCyGL+VZiBQX9RRHxKJqFRB
	 4b7unqicZk+34uPb+6MIC+3lDmCssGyhOg5r4dDq0qOK8UQSghxXeJE9E/agDNkv0W
	 4mscLxcTQM2SpYkOTjMQwkb7GIG/qx2cBqX4IuSmIAet4+p66akv96/XO3KUQiTDTX
	 9Olp4Aa/H9GHl/up7iwsemVpUfZRQ5HBca1Y9ObUcGM0dkRymQF0gquSwovgdjd5lD
	 v6z2w6XGpw6Snid6atYtvcoBqB8OQN2jLTI2NkHq+DW4NIPVtYm9jqm9fJnDY9c3z9
	 qwaCZI2/JvT+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3400F3809A80;
	Thu,  7 Nov 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sctp: Avoid enqueuing addr events redundantly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173099103001.1988427.15472677540469067222.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 14:50:30 +0000
References: <20241104083545.114-1-gnaaman@drivenets.com>
In-Reply-To: <20241104083545.114-1-gnaaman@drivenets.com>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Nov 2024 08:35:44 +0000 you wrote:
> Avoid modifying or enqueuing new events if it's possible to tell that no
> one will consume them.
> 
> Since enqueueing requires searching the current queue for opposite
> events for the same address, adding addresses en-masse turns this
> inetaddr_event into a bottle-neck, as it will get slower and slower
> with each address added.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sctp: Avoid enqueuing addr events redundantly
    https://git.kernel.org/netdev/net-next/c/702c290a1cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



