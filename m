Return-Path: <linux-sctp+bounces-1342-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0i50L01RVmo93QAAu9opvQ
	(envelope-from <linux-sctp+bounces-1342-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 17:10:05 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27898756419
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 17:10:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=WxcFCLaG;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=JHtsnZYa;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1342-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1342-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32B30300D622
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DE47ECFE;
	Tue, 14 Jul 2026 15:10:03 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990B478846;
	Tue, 14 Jul 2026 15:10:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041803; cv=none; b=W6fHyBbqjxWz3jS2mhsmEz5NWvSon0eo4vv+i3aeBWFegES6Mbk6GCjjAfi37AYB+4F+p/F+81zAuyEp+6GAzlvP5tVqf2ozf9m96BCW3lqq11uT4NZI449p3gQlqHe4jqy122k5NAsNWFgcNigbjylQ71BAyGZzkR1VMROzvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041803; c=relaxed/simple;
	bh=eEfmaqmblyqWr0QgB6GVbRkYbGyJt8bWatRVKeD8hoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYNDunHBdFt7XhndqH6RaT5gbFCjeSD5rho4+AS2RnmXR1kOJ5wwpLVPFW0NF/s4cf24ol499rhijSpvLX2LkN8RgxP/hT36D5+7d/GiD5np9nXQfV0VX9/ou5fKXasQQR6+yeH3YsdrJsCoHBanzqeMdUNVH7EBEMNjFzfuAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxcFCLaG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHtsnZYa; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 14 Jul 2026 17:09:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784041799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr0TUUq56lUK+O7gJmjg7IOoSJ19pJ6NQdkj+KRYx3Y=;
	b=WxcFCLaGGmnAR+5PjupNfSTY5XCm6rv6pT2Ow6yt2unRiXOJ0znYGTSM3FbjLDPjb6BNJL
	d6nrqloGSSIbLlUk6aeb9HjCg5/TM4Ff0K1NA9cTAFGWs8MKPqQhrb3Ap30zSQq/8+lUiZ
	JyeOqxMLyjHlLEyGxKcqoTMoUtnncIUEriObAC3x6ZnhIDtI/3Z7LJKLu15hlscEhAAFP7
	tO7meC2OyPkcGhx/lDS2+5eGPh9CQMiA1QDSXYZdqIVaK8vmo3S/bdroDZIZHc3VkYJWM8
	n1UAzykv0bwyIjqzwamKjtWcawvv1VSvYuh+cfpIy2HoWpIeffbElMrUmB/dHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784041799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr0TUUq56lUK+O7gJmjg7IOoSJ19pJ6NQdkj+KRYx3Y=;
	b=JHtsnZYa3gOYVJQTmYHnKvC5d2cM+GY5FiTlGWJSWiFvJo4qBKteFunHFkgM95DX0DrAi+
	JebyxhyZ58KO2TAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kees Cook <kees@kernel.org>
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
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH net-next] net: Convert %pK back to %p
Message-ID: <20260714150957.GY4aiPiH@linutronix.de>
References: <20260706073824.xixrLxoD@linutronix.de>
 <202607090916.7731D36D@keescook>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202607090916.7731D36D@keescook>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1342-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-atm-general@lists.sourceforge.net,m:linux-can@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:kuniyu@google.com,m:mkl@pengutronix.de,m:marcelo.leitner@gmail.com,m:ncardwell@google.com,m:socketcan@hartkopp.net,m:pabeni@redhat.com,m:courmisch@gmail.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:willemdebruijn.kernel@gmail.com,m:lucien.xin@gmail.com,m:pmladek@suse.com,m:thomas.weissschuh@linutronix.de,m:marceloleitner@gmail.com,m:willemdebruijnkernel@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-sctp@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,davemloft.net,google.com,gondor.apana.org.au,kernel.org,pengutronix.de,gmail.com,hartkopp.net,redhat.com,secunet.com,suse.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27898756419

tl;dr: Do the networking folks mind switch it to 0 instead the pointer?

On 2026-07-09 09:18:44 [-0700], Kees Cook wrote:
> On Mon, Jul 06, 2026 at 09:38:24AM +0200, Sebastian Andrzej Siewior wrote:
> > This is a revert of commit 71338aa7d050c ("net: convert %p usage to
> > %pK") which is from 2011. Back then the default behaviour for %p was to
> > print the pointer. The %pK modifier was introduced to be able to control
> > the behaviour of specific pointer output without changing the behaviour
> > of %p for everyone. It was dedicated to avoid leaking pointers via
> > /proc.
> 
> Given the policy on bare %p, and that there are so few in this list (15
> files), how about review those that can just simply be removed or
> switched to %pS, etc:
> https://docs.kernel.org/process/deprecated.html#p-format-specifier

It is not a new use, but an old one ;)
The pointers are data pointers of sockets and so on, not code. So using
%pS will reveal the exact pointers even with hashing enabled (in case
you think about changing the behaviour for __sprint_symbol() for cases
where kallsyms fails to resolve the symbol).

The things here are "reports" such as /proc/net/icmp where you get
|# cat /proc/net/icmp
|  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode ref pointer drops
|   53: 00000000:C9F2 00000000:0000 07 00000000:00000000 00:00000000 00000000  1000        0 4569 2 000000001145b7f6 0

so this is probably considered as ABI. lsof, lsfd (util-linux) are using
this file. So I don't think this entry can be removed. These kind of
files have usually a flexible ABI and are fine with adding new
attributes but not removing existing ones.
In this cases we usually put 0 if we remove an entry.

The pointer in icmp has been added int commit c319b4d76b9e5 ("net: ipv4:
add IPPROTO_ICMP socket kind") and no explanation why. But the order is
the same as in the tcp or raw file. I traced the tcp pointer inclusion
back to 2.3.15pre3 with no explanation. It just appeared with bunch of
other changes so maybe making debug a bit easier.

Anyway, given all this, do the networking folks mind switch it to 0
instead the pointer? 

Sebastian

