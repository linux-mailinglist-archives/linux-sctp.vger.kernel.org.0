Return-Path: <linux-sctp+bounces-736-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C020BC2ED4D
	for <lists+linux-sctp@lfdr.de>; Tue, 04 Nov 2025 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809AE3BF7D1
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Nov 2025 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5340223ABBB;
	Tue,  4 Nov 2025 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAUYiWRa"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C7239E88;
	Tue,  4 Nov 2025 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220445; cv=none; b=hzyIJqe08PWNdpu31wTl1pu0V2SpUYJfo2PdSQjZGzs7tseUnEA6zOa20uZMPcKpQs9eD32I3/jzt2eYKLWl6v949pynKywcrJNUpis5b8++zFEMMoHesk9VQ8E361p+uHV2jG6UF3q+7lRW8zyRxjqd5IZzPVFViWpJLprj+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220445; c=relaxed/simple;
	bh=73Pjjvc7WLzHbVCXATUaK9SpagUiN43X9DBPaZOQnz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWag2ye+oVKSW4hGjp7aw0o1gKFh4CX3ugXlObmH1lKOQlPffrEAfYeJkdk0e1Xk0qB+8K5IZZkSf+UwK1cvEPquhx4G2RgnUM2IF53+I2nnYQGxB1zRpsqWx2IeoteRHfEjuOm1fMOh1entf403/7bYR6DTM46mLy4r9aTDBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAUYiWRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5766C4CEE7;
	Tue,  4 Nov 2025 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220444;
	bh=73Pjjvc7WLzHbVCXATUaK9SpagUiN43X9DBPaZOQnz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cAUYiWRao0KXIUiBqw3RkY9Eoy/14k8smbyWGvRTj5Y0JEnWquPNnhyzaBYmWoz9z
	 BZkCyKQtBQtntxfrk+3UPBY5teQzupdaNxlQmwNpd7isk470pEE19ENU7jI41VDz+e
	 2r3U7MWYAWH9/eQ+TB7YAG/Cvt6d/uzrGdsiykw33gHOeTE8SDQKOX630CAFXypzpW
	 DGQAL1or8PHpu3iaUoym2+onJjbqcQp4MzkaYtXD5xEIIoyMciIyxxdkYC69xjdN9F
	 Z1WLLagbwBTYoOthbq3gkfw6j3CxjNDgUWTOFXd3NM2H/GOddFvF2dqEVqeKNXyug+
	 FYEXppXcrb9cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCD3809A8A;
	Tue,  4 Nov 2025 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] sctp: make sctp_transport_init() void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222041899.2285814.807865914343081273.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:40:18 +0000
References: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 10:36:19 +0800 you wrote:
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
> 
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
> Changes in v2:
> - Remove the 'fail' label and its path as suggested by Xin Long.
> - Link to v1: https://lore.kernel.org/all/20251101163656.585550-1-hehuiwen@kylinos.cn
> 
> [...]

Here is the summary with links:
  - [v2] sctp: make sctp_transport_init() void
    https://git.kernel.org/netdev/net/c/59b20b15c112

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



