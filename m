Return-Path: <linux-sctp+bounces-298-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9C9FB3EB
	for <lists+linux-sctp@lfdr.de>; Mon, 23 Dec 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EEA1884A10
	for <lists+linux-sctp@lfdr.de>; Mon, 23 Dec 2024 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BD1B6D0F;
	Mon, 23 Dec 2024 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky4Vv1AS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F638F82;
	Mon, 23 Dec 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978014; cv=none; b=GjOF9yg6usxiyMUCJRoM7DjqRZAlbZFxVwNipuxAv9Rwc33DpxT+34S4kfMNhPJ+13iY4n/dBv2kok3+8x2BX4v6qNufv7Mu6Br8xz9K7pL2duE24v+RlIJrxmpZSOETM0sltTqt3fSWjo90BTzv0PV6ZR0eYZ+dJOQ+THZUrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978014; c=relaxed/simple;
	bh=x8b2+EwkygP4Uk7vVtE8jxKJWFIXJhtbzkshEYALIsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrR/e7kN8lXgBs6siseL0TyigUnwqxsrnTqF14zorKKXlRiYST/TmAzn03tDJ66WENV/4awL2QA+nTyhETqKaRC2lTJmE6hEP5BoB5Fm3N+us63JA2ZhnudmXlgdt0mbjgebJBvcrWYzDfitqE3o9GZUgXdf1YgDk67UOQYktdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky4Vv1AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E62C4CED3;
	Mon, 23 Dec 2024 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978014;
	bh=x8b2+EwkygP4Uk7vVtE8jxKJWFIXJhtbzkshEYALIsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ky4Vv1ASRcH2DLSbUJxcouDhwGg0Jca+5h8rsbJIPM7Y9CkbcPLXM7lavGssYOlK5
	 GE+HxA6JTbXZRv7J5mpkpnEaCdOAAb4WsZ4lOW5VvOqkT/id4MvsMlbjxfGWjAUipy
	 Rw287OAkeXoHIETB+oa7c+N8LP9EgC+OymPmA1eHl653jv86Mob0/92E+eaMPsX8k6
	 0SZgz5ipczYMrvATysH/ByqBSSF/O3qM3fQlFRsRBh1ZjyQ9CrC7d+KqVPsA/tZM70
	 6gHsns3OaLrQWoa1lH2XqXN/PDPuYceoIp1X+YLi8I1ub2I6CZJKAoY8ir2fa/yUcu
	 kIqPebB9kh84g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD43805DB2;
	Mon, 23 Dec 2024 18:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sctp: Prevent autoclose integer overflow in
 sctp_association_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497803275.3923395.9352566913708265576.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:20:32 +0000
References: <20241219162114.2863827-1-kniv@yandex-team.ru>
In-Reply-To: <20241219162114.2863827-1-kniv@yandex-team.ru>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 xi.wang@gmail.com, nhorman@tuxdriver.com, vyasevich@gmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 19:21:14 +0300 you wrote:
> While by default max_autoclose equals to INT_MAX / HZ, one may set
> net.sctp.max_autoclose to UINT_MAX. There is code in
> sctp_association_init() that can consequently trigger overflow.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9f70f46bd4c7 ("sctp: properly latch and use autoclose value from sock to association")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> 
> [...]

Here is the summary with links:
  - net/sctp: Prevent autoclose integer overflow in sctp_association_init()
    https://git.kernel.org/netdev/net/c/4e86729d1ff3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



