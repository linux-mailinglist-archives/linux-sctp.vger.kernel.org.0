Return-Path: <linux-sctp+bounces-1224-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HGpHa/UGGrSnwgAu9opvQ
	(envelope-from <linux-sctp+bounces-1224-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 29 May 2026 01:50:07 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF0F5FB840
	for <lists+linux-sctp@lfdr.de>; Fri, 29 May 2026 01:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3EEB300DE04
	for <lists+linux-sctp@lfdr.de>; Thu, 28 May 2026 23:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C352C11F1;
	Thu, 28 May 2026 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1M2HvAn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A0358373;
	Thu, 28 May 2026 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012203; cv=none; b=mkl7yQ+4wgHeB3rS2gWx6/DpPieexc2nXJBx91ySZ0VEqx/be0EHpwYtxlre5AfpIOgQY7p+DxJt6HwpOXRzJCnv3h8Hb4qdiiRvYoKd9Ppdt88t2aD5NUu1h90g4R62tMNUlEEs5zPCKDLDPpDu97L97p4kplA72WBa0tS+uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012203; c=relaxed/simple;
	bh=JUBxoIQo0a+3Jp9H5T4n9Mlmxmtp9ORrbg+1cKyKbA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rj1LlyvFf4h2qi3+fLyUZgJUiG5iE+oULnBTwLYESsm+hhGfED2oqlw/HZmxluihUvSwWYE20ShcJtCQkUnJ0GjTguRYWMGG72U4CfWsXqtbbHV3CFYEgX/aoTRtY05blVCqT6hbQL1EutWh793j7bhcJSBofuzAQaX6hxCSaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1M2HvAn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD861F000E9;
	Thu, 28 May 2026 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012202;
	bh=TnewTf/UeTPmfmF2rZDh13iKul5dxapRJTpRDRu7E5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c1M2HvAn1b9N1WbUzMoCcW4xsS+yG3+BEXcmrFklpaCugUu4bcbmjfQBUXdwFo9gB
	 Z2u+UHjxvVIQqHQ0GvBpC9WtfkL4PjZI3PTUqejPIeHFaYOKSVOXOz+O4rB2XeqoZ0
	 clZr1wNgukkYKLpKgDco290F68fnXnbEcohEiktI29hMrIjC86exDWtB9g1q6Lhw4G
	 23xkHWWwaQru/+PzSvvlcrDiOhb9YWCUGe6lDZ4my+0wMQImtj5SMOIXW58pqNkPeY
	 JCQIw1KgaUqgS/Dxf8uGG6a33waHlcy+9G9tzV35CWa512Xqpptvl66NnFtUKYYRU/
	 g1IKCpNpge37w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AB73811979;
	Thu, 28 May 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: fix race between sctp_wait_for_connect and
 peeloff
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001220615.1560944.11263521787130041641.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 23:50:06 +0000
References: <20260527032411.60959-1-kipreyyy@gmail.com>
In-Reply-To: <20260527032411.60959-1-kipreyyy@gmail.com>
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-1224-lists,linux-sctp=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CBF0F5FB840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 11:24:11 +0800 you wrote:
> sctp_wait_for_connect() drops and re-acquires the socket lock while
> waiting for the association to reach ESTABLISHED state. During this
> window, another thread can peeloff the association to a new socket via
> getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
> re-acquiring the old socket lock, sctp_wait_for_connect() returns
> success without noticing the migration — the caller then accesses
> the association under the wrong lock in sctp_datamsg_from_user().
> 
> [...]

Here is the summary with links:
  - [net] sctp: fix race between sctp_wait_for_connect and peeloff
    https://git.kernel.org/netdev/net/c/f14fe6395a8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



