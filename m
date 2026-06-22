Return-Path: <linux-sctp+bounces-1279-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S3NhNaBoOWr3rwcAu9opvQ
	(envelope-from <linux-sctp+bounces-1279-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2026 18:53:52 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D26B14F5
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2026 18:53:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PDdfs9Wk;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1279-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1279-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3113002F82
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jun 2026 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C433A9CB;
	Mon, 22 Jun 2026 16:52:48 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908A31326A;
	Mon, 22 Jun 2026 16:52:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147168; cv=none; b=ulQdoAEORw1qKGG5AkJxZxPlhObNABTaYU86CoZHm1cnAVO+q0R62vC3r4296EZIRgu5HB0rjHw2AWYqRdYsU+jjI+3nP9XC0XkjWRm2KzH5X3142MBQl8G8lMSrAaIEeHB/5er//IIWLuo1+432IAb2Vbh7Gq+rc/lHfrqCbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147168; c=relaxed/simple;
	bh=hdmyDBZvJFv2ypv0m60STOgovFI8tJes/rMIJriC02U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsZoKsKwlFBvmAR3zvJOGNh0WxfNx8AlIAFXVBlC4avU7+erzA9Sx6/HaU1I2Cokiibf1o6/B1n33OzQ71Gx6YT56cM6Jn8NELA/deyGZ8813yQLBcFEV7uKayF5Yzai20mDaMGZneTFqkQ4HESCYYCfrqxYZigvJLG/YvHaOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDdfs9Wk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3FC1F000E9;
	Mon, 22 Jun 2026 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147167;
	bh=sI6QYUNAN5jLSkKdijbouaFNMU/a6U0w9W28F1y0CPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PDdfs9WkivkDC04gEY/gQvXUEZVy7q+XZr5eEWf5yf9i7NhtNd3CpkIHyvjFu2h/H
	 cP0RYrhXGTAkLnATkhae+3TLiyd/b0ZHNVJF40uLEKAubPPwcqmi/wL1b0AbUYNThD
	 du59Yi/R9RyROdT6il+4iSJn9UKvO13OdKCqkMx8VBRbuCut0lB/nsUODkpCGmaKjn
	 iWDU7ibkj8/MMjET7uE6IrhkvLbgTIh9nGR8K/+xTOroDTpGYzZ2ySHW3WhlKaxVUU
	 0iS0jNCabA/X28cp19iBvZzkAHXazsRNF68JpsANVz4stoeQHxjWUphIUxaMzl45ED
	 7tSfRsy25NH0g==
From: Simon Horman <horms@kernel.org>
To: lucien.xin@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	marcelo.leitner@gmail.com
Subject: Re: [PATCH net v2 2/2] sctp: add INIT verification after cookie unpacking
Date: Mon, 22 Jun 2026 17:51:59 +0100
Message-ID: <20260622165200.1050676-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <c34fee6105f9051a52f8e774fe4c35f0e6ba0afc.1781968162.git.lucien.xin@gmail.com>
References: <c34fee6105f9051a52f8e774fe4c35f0e6ba0afc.1781968162.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1279-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 367D26B14F5

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
sctp: add INIT verification after cookie unpacking

This commit adds sctp_verify_init() checks in the COOKIE-ECHO processing
paths sctp_sf_do_5_1D_ce() and sctp_sf_do_5_2_4_dupcook() when
cookie_auth_enable is disabled, and updates sctp_verify_init() to bound
the parameter walk against peer_init length rather than chunk->chunk_end.
On verification failure the new association is freed and an ABORT is
generated via sctp_abort_on_init_err().

> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 8c636f045e45..6967e889d1bd 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -650,11 +650,12 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
>  					 struct sctp_cmd_seq *commands)
>  {
>  	struct sctp_ulpevent *ev, *ai_ev = NULL, *auth_ev = NULL;
> +	struct sctp_chunk *err_chk_p = NULL;
>  	struct sctp_association *new_asoc;
>  	struct sctp_init_chunk *peer_init;
>  	struct sctp_chunk *chunk = arg;
> -	struct sctp_chunk *err_chk_p;
>  	struct sctp_chunk *repl;
> +	enum sctp_cid cid;
>  	struct sock *sk;
>  	int error = 0;
>  
> @@ -728,6 +729,18 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
>  		}
>  	}
>  
> +	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
> +	cid = peer_init->chunk_hdr.type;
> +	if (!sctp_sk(sk)->cookie_auth_enable &&
> +	    !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
> +			      &err_chk_p)) {
> +		sctp_association_free(new_asoc);
> +		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
> +					      err_chk_p);
> +	}

[Critical]
When cookie_auth_enable is disabled the cookie HMAC is not validated by
sctp_unpack_cookie(), so every byte of the embedded INIT (including
peer_init->chunk_hdr.type) is attacker-controlled.  Is it safe to feed
that byte directly into both sctp_verify_init() and
sctp_abort_on_init_err() as cid?

Inside the COOKIE-ECHO body the embedded chunk is by RFC always an INIT.
Could the cid argument be hard-coded to SCTP_CID_INIT (or
peer_init->chunk_hdr.type be validated against SCTP_CID_INIT before use)
instead of trusting the wire byte?

Two attacker-reachable consequences look possible if cid is forged to
SCTP_CID_INIT_ACK (3) and the STATE_COOKIE parameter is omitted:

sctp_verify_init() then returns 0 via this branch with *errp populated:

	if ((SCTP_CID_INIT_ACK == cid) && !has_cookie)
		return sctp_process_missing_param(asoc, SCTP_PARAM_STATE_COOKIE,
						  chunk, errp);

control transfers to sctp_abort_on_init_err(net, ep, asoc, cid, ...) with
cid == SCTP_CID_INIT_ACK and a non-NULL err_chunk.  After sending the
ABORT packet, that helper falls through to its out: label because
cid == SCTP_CID_INIT_ACK:

	if (cid != SCTP_CID_INIT_ACK) {
		if (!packet)
			return SCTP_DISPOSITION_NOMEM;
		return SCTP_DISPOSITION_CONSUME;
	}

out:
	...
	return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
				      asoc, chunk->transport);

In the sctp_sf_do_5_1D_ce() context, asoc is typically NULL (the function
itself opens with if (asoc && !sctp_vtag_verify(chunk, asoc))).  Can the
SCTP_CMD_NEW_STATE / SCTP_CMD_TIMER_STOP / SCTP_CMD_INIT_FAILED commands
queued by sctp_stop_t1_and_abort() against a NULL asoc be dispatched
without the sideeffect interpreter dereferencing asoc?

> @@ -2205,6 +2219,19 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
>  	switch (action) {
>  	case 'A': /* Association restart. */
>  	case 'B': /* Collision case B. */
> +		peer_init = (struct sctp_init_chunk *)
> +				(chunk->subh.cookie_hdr + 1);
> +		cid = peer_init->chunk_hdr.type;
> +		if (!sctp_sk(ep->base.sk)->cookie_auth_enable &&
> +		    !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
> +				      &err_chk_p)) {
> +			sctp_association_free(new_asoc);
> +			return sctp_abort_on_init_err(net, ep, asoc, cid, arg,
> +						      commands, err_chk_p);
> +		}
> +		if (err_chk_p)
> +			sctp_chunk_free(err_chk_p);
> +		fallthrough;

[Critical]
The same attacker-controlled cid is propagated here as well.  In
sctp_sf_do_5_2_4_dupcook() asoc is the existing established association.
With a forged cid of SCTP_CID_INIT_ACK and missing STATE_COOKIE, can a
single unauthenticated COOKIE-ECHO drive sctp_abort_on_init_err() into
its out: path and have sctp_stop_t1_and_abort() tear down the established
asoc and report ECONNREFUSED to the application?

Would constraining the verification to the well-defined INIT case (for
example, hard-coding SCTP_CID_INIT or rejecting any cid !=
SCTP_CID_INIT before calling sctp_verify_init()/sctp_abort_on_init_err())
avoid both of these paths?

