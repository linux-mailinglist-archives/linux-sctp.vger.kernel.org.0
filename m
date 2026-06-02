Return-Path: <linux-sctp+bounces-1228-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCCqF3lOH2rpjwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1228-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Jun 2026 23:43:21 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D4632273
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Jun 2026 23:43:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dQhS4naD;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1228-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1228-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF34304C2CE
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Jun 2026 21:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA743A9DA3;
	Tue,  2 Jun 2026 21:40:08 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E383A6F04;
	Tue,  2 Jun 2026 21:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436408; cv=none; b=PhK5ZLrFULe9Ke/umoqEYf/HNTss+PmHSYU4cNuW3mulh/S+4daIm9ja5MZIzONihxd7oXCoel2LsgRld0fBYFqks2KUXhIVdV7d0r0K7b4S2S1iqO79TZCQYbKTAHQD+1D4IXDSNPHwkKzlfKoi/qaRgSJ1RL4eDjqNX75J4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436408; c=relaxed/simple;
	bh=Lr0JViZaCQ0abfS+wAoXYSyoDHPs8vYS1qYHR79jbT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=se0bz8dbhHcjsifk1nOzdlCm6zZ1N7J1nfHvqM+Tef37uQWl2QPuRyiKDJC+crRIeMLWMCVxH40DYaOp/S2wf2EI1sW0J81NSmIx00lBzI4LtHYMmik3Pt2Jh5VYYQ2aPSIsSE3GOuwj0apq9tPl7SwnBy+n9oqIj3TFJgWwRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQhS4naD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1028A1F00898;
	Tue,  2 Jun 2026 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436407;
	bh=fyTVzTTd2kN5hwLs/+fk3goVFXV6LaupjoQ/Nx9fVSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dQhS4naD27d2BHQ4eMCWhGZvlYXCoEFFzfxN5ZjYWPxsVmAuI9jfprvakaOaDVtUq
	 yjQr621W2v7ZlX6G9RgmlyXuz3/lWBXsTYq7ZZTbKnGvLvkXm0GMA++IRy1yCUkrlm
	 R+RvG8O3ELTgDEcUM6Qk4LnqqDi5MAQHSAgoKTu3/iZHJq0Zs3xf03ZLPirl3dEF+F
	 7unzmEZORyBXVEgjZphTtq7TbG5w7MZMDeJpOL3CC6DJ1/wKJ0hJP2E1SYHJBUUZYb
	 1zqN66cYwfQVb9kEj+ZXhUYkVmGM4005TW08pVNRYWyrnvsnX+26tAv/jUNG7WkMmp
	 AUGpHDVoHXIaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1984D3811A76;
	Tue,  2 Jun 2026 21:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] sctp: diag: reject stale associations in dump_one
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043640864.1060922.17628384170173948088.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:40:08 +0000
References: 
 <fac6043fa20a2ff68e12958c431836f692c51268.1780113823.git.zzhan461@ucr.edu>
In-Reply-To: 
 <fac6043fa20a2ff68e12958c431836f692c51268.1780113823.git.zzhan461@ucr.edu>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 zcliangcn@gmail.com, bird@lzu.edu.cn, zzhan461@ucr.edu
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1228-lists,linux-sctp=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,ucr.edu];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:zzhan461@ucr.edu,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A56D4632273

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 23:57:14 +0800 you wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
> 
> The SCTP exact sock_diag lookup can hold a transport reference, block on
> lock_sock(sk), and then resume after sctp_association_free() has marked
> the association dead and freed its bind address list.
> 
> When that happens, inet_assoc_attr_size() and
> inet_diag_msg_sctpasoc_fill() can still dereference association state
> that is no longer valid for reporting. In particular,
> inet_diag_msg_sctpasoc_fill() may read an empty bind-address list as a
> real sctp_sockaddr_entry and trigger an out-of-bounds read from
> unrelated association memory.
> 
> [...]

Here is the summary with links:
  - [net,1/1] sctp: diag: reject stale associations in dump_one path
    https://git.kernel.org/netdev/net/c/5eba3e48d78e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



