Return-Path: <linux-sctp+bounces-1181-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOp/CRWG3WnvfAkAu9opvQ
	(envelope-from <linux-sctp+bounces-1181-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Apr 2026 02:11:01 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A38123F45C3
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Apr 2026 02:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC9F3048099
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Apr 2026 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39383D561;
	Tue, 14 Apr 2026 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPbnAcas"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0428690;
	Tue, 14 Apr 2026 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776125436; cv=none; b=UArlhEPsYpFWEFa4GBb0X//+wEDAJThcqL0yLNvLOdtK+SOO08Wallc8Y5Uuwm3iyx0JmBEpG8bC3EJ0sOsqZnhGDv0GKPAD7LugzcjriKe1dq0NHkIF47c5EtFHM2LEWsh2gwzN8f+oPUkzPKRv5sdikmvtViDdvYZZ7leylS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776125436; c=relaxed/simple;
	bh=Eu+qBXQ0+iV40Eeis3c36B7eCiVgHHCRrqCby4ACBts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgSEmyNCV2soI7O3Wo7kUrqiMBN7dfTyfS894bNVYor9Vxl4LckVhe0QidJ8SDnDrSO82m+Zh/rXscacq6C1lzLh59/+lfBoKcth0eguvYET7YIgezeH+1eh++OqXvX/9S7bLttPZ+fCNgKUSRM3E/PhkpzuH1JdhJrebgcI0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPbnAcas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1A4C2BCAF;
	Tue, 14 Apr 2026 00:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776125436;
	bh=Eu+qBXQ0+iV40Eeis3c36B7eCiVgHHCRrqCby4ACBts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPbnAcasW+0mu9IcilWJJZl7EAfcowfRXIEtzMDq4jdQOOv9Rb6DTBBGeLiKTAjt4
	 wE1hfxtysMRBpsfvrubYeDbaAxyw13ay/TuDkJliEvesq0Qu5Pr/GMlgG+HKsg1V1q
	 MUJawO929TCu4P1apNR6jEr9Bi1slR4G15IxXuhMmPb8RLqjR9f0qEqP+3CoUvKVBz
	 f/5kUOKpoJNDvTLkH62hNbhCPWks+An1o4FOWWl3AY5dAO6URplPQXoHVu/7P7/7ex
	 PhcN5YtocNGUStRvEv8RMprgKxXO6q97K24EQAz7cox2tgcU976G25m+ZQg38H11mj
	 Ybn+PtOs1bBVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C2C3809A0B;
	Tue, 14 Apr 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sctp: fix missing encap_port propagation for GSO
 fragments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612540779.609150.15418632387140324971.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 00:10:07 +0000
References: 
 <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
In-Reply-To: 
 <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 marcelo.leitner@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-1181-lists,linux-sctp=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A38123F45C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Apr 2026 14:13:51 -0400 you wrote:
> encap_port in SCTP_INPUT_CB(skb) is used by sctp_vtag_verify() for
> SCTP-over-UDP processing. In the GSO case, it is only set on the head
> skb, while fragment skbs leave it 0.
> 
> This results in fragment skbs seeing encap_port == 0, breaking
> SCTP-over-UDP connections.
> 
> [...]

Here is the summary with links:
  - [net] sctp: fix missing encap_port propagation for GSO fragments
    https://git.kernel.org/netdev/net/c/bf6f95ae3b8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



