Return-Path: <linux-sctp+bounces-1292-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LxKqLQVHPWq00ggAu9opvQ
	(envelope-from <linux-sctp+bounces-1292-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 17:19:33 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8286C701A
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 17:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LLVuMNlr;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1292-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1292-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 453E7301422D
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17853E8337;
	Thu, 25 Jun 2026 15:19:18 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479133E833B;
	Thu, 25 Jun 2026 15:19:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400758; cv=none; b=CrQ4ZP/9fmcN5bVAq+LyGouG5LsnVn2U3MPK927NqkAQwQuwdv2dlRsSl7UoTYE/rRcvytRbm/jE39YP/FbQEMYnQ+OASeaek/eUNUac8x1Ir7z4W3MO/wj8Ye37i+aKrs+I9ivLX72r95alXVQjLngRHQu+fwjuIF6UWxy+wIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400758; c=relaxed/simple;
	bh=Odath91MlpqQ/3qQChDCDqq8dVzrLYccrdUW0VNOaz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2z2CajJ+3OayEsjSAeTun9ImoOrUJJEUe8DrLi85g8lGaLH6LtcvXFX+nEuVrZDho2Ndigef3FRDi+Yhh8ufmrY+yHvj6uCa29u1vVly6QRFsH3dFeASoHYK+PfkGgVhaQVqdQXbnI9S2ygLwtkxB54jEQGikiwAop9oK0Qh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLVuMNlr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C3F1F000E9;
	Thu, 25 Jun 2026 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782400757;
	bh=Odath91MlpqQ/3qQChDCDqq8dVzrLYccrdUW0VNOaz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LLVuMNlrHeAjkZgtNByRv3n0b6TXqMFjZPg/CyEYStf350c39UMN1LnLZK7NOyC8h
	 LG66ugrqxna4iV03De/mW9P6E3R3jaDKVpOanOLLJz98kaQThby4CWE+/sGvnmOyeP
	 /V9gJIok6XwMSxOto2i9lKNi2ongcO7ar6ccYiDjOHnKPK7IpARqXOsOoUbwSliM3z
	 xdQ7vKz1XTIX7h+nNmhBQe7WWU8N8U0Ki9vM4svG2WDqzqfpSxli/50/ePetRzsYmf
	 zO2hl+Pw1YMtEMUrMTBOMO4Vlwd5S2OHNn/cFCo96BrCBg5nn5IIBsqQF7+DApPUm8
	 He2T9EfkCwTmQ==
Date: Thu, 25 Jun 2026 08:19:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] sctp: fix SCTP_RESET_STREAMS stream list length
 limit
Message-ID: <20260625081916.77a017f3@kernel.org>
In-Reply-To: <20260625142354.2600-1-alhouseenyousef@gmail.com>
References: <20260625142354.2600-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1292-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-sctp@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A8286C701A

On Thu, 25 Jun 2026 16:23:54 +0200 Yousef Alhouseen wrote:
> Changes in v2:
> - Add Fixes and Acked-by tags from Xin Long.
> - v1: https://lore.kernel.org/r/20260624122213.4052-1-alhouseenyousef@gmail.com

You don't have to repost patches for networking just to add tags :/

