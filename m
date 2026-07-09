Return-Path: <linux-sctp+bounces-1315-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SRVsIZfLT2rmoQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1315-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Jul 2026 18:25:59 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B5733701
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Jul 2026 18:25:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ReI3OB5Y;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1315-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1315-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334F4305AB1D
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Jul 2026 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E774343FD;
	Thu,  9 Jul 2026 16:18:54 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B24252C6;
	Thu,  9 Jul 2026 16:18:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613933; cv=none; b=Hs2eJZk14O2ZBbJhHUGwf/tp9yKoQhrPNBDnOoojIpfWf+FdHZ4UeTNRRFI+bF6M39Yw8EXRpo9X/X0tU/XEv927GHfPpd4L2gCKInJQyOinTGRv/vUUBEVc9s89+xee3tEBfEWq74GVP43fIWfX4Ra6W9EGhs+qRPxtemwFCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613933; c=relaxed/simple;
	bh=AsailK8F37XDf6dcGFjdUTsjDgb9MVOWzdP5r9LYmHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U64rbnHJkGop/QEbzpfTjcfLIdf9NF/zD9OQwOqcbjUhmi0+M43xsNlGt+o9n0fqinsy+LicStJj4/hXu33Ut041iHa72mIDx48IXMWH/sBQA24vxI7xW1JBOi0y9AbjG0egH38p+AkS6XgTRtPwPSC/ZdIBTS7jPPYCiSnhstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReI3OB5Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91221F000E9;
	Thu,  9 Jul 2026 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613924;
	bh=+c800ITVYyf0HQortvRIAgN2/p9RkJsrk68oS9gg2HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ReI3OB5YQQMOrVPAHVH9nU9vT0kJx40oXUtXWU3yZRmSuSycR8b2uG9TiG58WMMb3
	 pRz2BDgimBsUcM0L+vlcMoxQYENYIYCjYo7XhvIRSPYMHHiutilz6dOFm2v3vkNO/B
	 syFeuOgoboklXNnQpz6GUaeCi3fbiDJiLJqqseX9TeNfB8Bq7R9XO9GAOnd4PiXjbz
	 8Rqur66twNmP535APYhnaDdaLTTn6WyKDzhIV0uXSF1+f4z5P6hDdO5N+ByN/EUukL
	 yDEqM+A8xapUb0F419oNc3kWJ4+3klSi6S+R6mv7ADyE5koVq1qKXPHdfH3gYamWMC
	 Z46muTatq1BDA==
Date: Thu, 9 Jul 2026 09:18:44 -0700
From: Kees Cook <kees@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-atm-general@lists.sourceforge.net, linux-can@vger.kernel.org,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH net-next] net: Convert %pK back to %p
Message-ID: <202607090916.7731D36D@keescook>
References: <20260706073824.xixrLxoD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706073824.xixrLxoD@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-atm-general@lists.sourceforge.net,m:linux-can@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:kuniyu@google.com,m:mkl@pengutronix.de,m:marcelo.leitner@gmail.com,m:ncardwell@google.com,m:socketcan@hartkopp.net,m:pabeni@redhat.com,m:courmisch@gmail.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:willemdebruijn.kernel@gmail.com,m:lucien.xin@gmail.com,m:pmladek@suse.com,m:thomas.weissschuh@linutronix.de,m:marceloleitner@gmail.com,m:willemdebruijnkernel@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1315-lists,linux-sctp=lfdr.de];
	FORGED_SENDER(0.00)[kees@kernel.org,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,davemloft.net,google.com,gondor.apana.org.au,kernel.org,pengutronix.de,gmail.com,hartkopp.net,redhat.com,secunet.com,suse.com,linutronix.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keescook:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E24B5733701

On Mon, Jul 06, 2026 at 09:38:24AM +0200, Sebastian Andrzej Siewior wrote:
> This is a revert of commit 71338aa7d050c ("net: convert %p usage to
> %pK") which is from 2011. Back then the default behaviour for %p was to
> print the pointer. The %pK modifier was introduced to be able to control
> the behaviour of specific pointer output without changing the behaviour
> of %p for everyone. It was dedicated to avoid leaking pointers via
> /proc.

Given the policy on bare %p, and that there are so few in this list (15
files), how about review those that can just simply be removed or
switched to %pS, etc:
https://docs.kernel.org/process/deprecated.html#p-format-specifier

-- 
Kees Cook

