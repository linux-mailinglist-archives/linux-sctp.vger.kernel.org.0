Return-Path: <linux-sctp+bounces-154-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060348BACA9
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897E51F22E34
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED5153573;
	Fri,  3 May 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpTqqxGO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632E1509B5;
	Fri,  3 May 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740032; cv=none; b=L6xPmDXrH9ljH/IKjKIchrOYbVbKi4rXHhuW8N5vKRyb0X2DQwyrIuip1kKRdqDCHsUY+arSKPr0Tx0pZFIkFxXdtavye60UAPsLoKDkn87zg9npehElpEi5DoNGZhvcFmfCXdhf8hvF0QCfR7VcL8Vw6HhaexysY3inqFyY890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740032; c=relaxed/simple;
	bh=ZQIGy3VXyjpVMSPeQXlgXY8wIwpxUclQuAZTLhiqvb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PMOCsOGadK1SDPphmkkrSPEq0If1OlTCplRc2e1ctrqFQi4Q0hF7Fn6S4mR0CvNyTBNSrPqUUgy/Je99EEi9Mq3OSgh18ACms8Ih5QXkDuXzGwGCc4IY2lAnccfSwfSCplCitx4WpwG9fHfhEadhceKHiR2g/i8UVIL2C3kEH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpTqqxGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EFC9C2BBFC;
	Fri,  3 May 2024 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714740031;
	bh=ZQIGy3VXyjpVMSPeQXlgXY8wIwpxUclQuAZTLhiqvb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lpTqqxGOOyeBYFaVqPWVBOSrF1uEPcrBw9mt9i+INNn+8jXFXP1MQGWTLdtQ08+gy
	 WxB8nqmJCrdGXrQ69iXoStWWonk0xC1+hRY3pMr4qKwunZJvDGjQV0osOVqDM/CSkY
	 ewO7OhWFQ8Di78EP3uuxgdyczZsW6HKMpxqIbmiviGq0XjEuT7FxAon/a6wcYHd1Ze
	 cWNvFRYQc34ntJ7l1Udkf0twoBHQzUYhVry2lhblNdvbY7Esza3PMZzDMGHlTIrBt0
	 2gasi9LrYO65R9XiWHOETtBCQYSrm6fQnW1ly4m/gjzukVTaXrvsjeaLoC4jRhFXh/
	 0BUWTyFLcInxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35AB9C4339F;
	Fri,  3 May 2024 12:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171474003121.32261.9596059257751321282.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 12:40:31 +0000
References: <20240501-jag-sysctl_remset_net-v6-1-370b702b6b4a@samsung.com>
In-Reply-To: <20240501-jag-sysctl_remset_net-v6-1-370b702b6b4a@samsung.com>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, ralf@linux-mips.org, courmisch@gmail.com,
 allison.henderson@oracle.com, dhowells@redhat.com, marc.dionne@auristor.com,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, trond.myklebust@hammerspace.com, anna@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, jmaloy@redhat.com,
 ying.xue@windriver.com, ms@dev.tdt.de, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, roopa@nvidia.com, razor@blackwall.org,
 horms@verge.net.au, ja@ssi.bg, jreuter@yaina.de, mcgrof@kernel.org,
 keescook@chromium.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org,
 j.granados@samsung.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 01 May 2024 11:29:25 +0200 you wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/8] net: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/ce218712b0f6
  - [net-next,v6,2/8] net: ipv{6,4}: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/1c106eb01cee
  - [net-next,v6,3/8] net: rds: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/92bedf07836b
  - [net-next,v6,4/8] net: sunrpc: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/ca5d1fce7994
  - [net-next,v6,5/8] net: Remove ctl_table sentinel elements from several networking subsystems
    https://git.kernel.org/netdev/net-next/c/73dbd8cf7947
  - [net-next,v6,6/8] netfilter: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/635470eb0aa7
  - [net-next,v6,7/8] appletalk: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/e00e35e217c0
  - [net-next,v6,8/8] ax.25: x.25: Remove the now superfluous sentinel elements from ctl_table array
    https://git.kernel.org/netdev/net-next/c/78a7b5dbc060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



