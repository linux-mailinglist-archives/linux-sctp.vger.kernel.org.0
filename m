Return-Path: <linux-sctp+bounces-1251-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9i3FDtS7KGpMIwMAu9opvQ
	(envelope-from <linux-sctp+bounces-1251-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 10 Jun 2026 03:20:20 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BC6652C7
	for <lists+linux-sctp@lfdr.de>; Wed, 10 Jun 2026 03:20:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TmpnhpTT;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1251-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1251-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89E013016B1E
	for <lists+linux-sctp@lfdr.de>; Wed, 10 Jun 2026 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FB258EFF;
	Wed, 10 Jun 2026 01:20:12 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AE23EAA0;
	Wed, 10 Jun 2026 01:20:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054412; cv=none; b=LXRROMOYrmxXg+bSwMX23AaXcepRNZp0TFESUrMAPbnqZoWqRr39CN2SgcZKMPfGTH2Wfcep6BromUtKftstQFO3/yEes1TGMbyKi0L59A9lpqmsSCyOzBojOAiK5+IWUgVZw54UjZjTq1LSYFOqUSnGzUCu0Z80k9n2ksL31Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054412; c=relaxed/simple;
	bh=YZd3be3IXnDZ/5Yj+BTL31xQ9xwaraRHtHu5Obu2grg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L8dMadoYHCwB4KQu5gdAJ7mMBcIrdz35QWirNHiDHJ/KiufDrW7BwB0O+hw6WTx1/qg4KM1rERJOmI0DCt+mVc1TDBumOR6sM8S2UW9K9hICsMYVnz/vK8LKwKp4pmEoDDWuyLBcWqq1/nebHSXxuNNm339KxoOkHrq6vDpxLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmpnhpTT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF27B1F00893;
	Wed, 10 Jun 2026 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054411;
	bh=0vyG63OBWEbKlctZRJlU9wsCWVVM5Z3bEQFpubuwNp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TmpnhpTTSaRC1u6MqD08AGBWqHD2qvukcdUTc5pVFAC4jnfh/ClrgseiH7p+eTuxf
	 /nTjvIkuoK6GMLyc8rYjcy8ZkC+UhSI9DkzZzv3sFOn0axlq/m3kbvBtfNhA8PfVq1
	 CtHfhSxfXY1jEeIkVNP0ltWzbJE/XBaxLbxYjlbbTStTEslZ+SxVvRK3PTpmiHRTLn
	 mq5Z6LRWVdr9Fa3Z2CpUhGD40URXdoBWWjEBqCgiHUpVd7Cs27/F3IeTEHRwnPUsJk
	 /4+aC+q+9F0Ixhqfj4yYfeAtC9Xa6DGxkYaAEg1SayC0i5HQaqayhquY5bzZ3OGnsn
	 g9/DZ6iYObkIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A33930A12;
	Wed, 10 Jun 2026 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] sctp: fix uninit-value in
 __sctp_rcv_asconf_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105440888.2779729.14941795177786710168.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:20:08 +0000
References: <20260608122234.459098-1-michael.bommarito@gmail.com>
In-Reply-To: <20260608122234.459098-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladislav.yasevich@hp.com, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,hp.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1251-lists,linux-sctp=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E1BC6652C7

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 08:22:34 -0400 you wrote:
> __sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCONF
> chunk can hold the ADDIP header and a parameter header, then calls
> af->from_addr_param(), which reads the full address (16 bytes for IPv6)
> trusting the parameter's declared length.
> 
> An unauthenticated peer can send a truncated trailing ASCONF chunk that
> declares an IPv6 address parameter but stops after the 4-byte parameter
> header; reached from the no-association lookup path, from_addr_param() then
> reads uninitialized bytes past the parameter.
> 
> [...]

Here is the summary with links:
  - [net,v3] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
    https://git.kernel.org/netdev/net/c/f8373d7090b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



