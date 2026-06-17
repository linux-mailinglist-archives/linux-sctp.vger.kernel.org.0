Return-Path: <linux-sctp+bounces-1269-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jOzjB+V7Mmqj0gUAu9opvQ
	(envelope-from <linux-sctp+bounces-1269-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Jun 2026 12:50:13 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A6698A7E
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Jun 2026 12:50:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cw9I84iX;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1269-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1269-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D81C831082CD
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Jun 2026 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E26D438FF3;
	Wed, 17 Jun 2026 10:40:15 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966A3A0B3B;
	Wed, 17 Jun 2026 10:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692815; cv=none; b=dadStLedgiDuuLjGxx37rKpVmjyQfL4zpBkJyYvAlHJ3/WDhG6wFaNiiAYJVuJpo66aCjwfEhKzzAAjRWprDscB/1ZrUXXbV2UxavtqF+SDoHjjKSfLMehTbLvWSLwHQmeXm2QsZ3WtySgJqCFHRH6TIkv/HT/h5N1rOeqOlOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692815; c=relaxed/simple;
	bh=bRbTsJKDd101SonEYCJYcjtIV7UjH1kVn83V+mLtoL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAEyv3nYWtEoXqlzGd2GC3vgiq9qnJwZ8GF65VoPUyOu1jtQvvt3cCDZmDJor7rakAOkX8Z+jPiOKGjqh0sFxpbBXbEnBjc4uzqwbzX4Irc/q5i9AsBPzNsoRAdRfRtzWqteLKHU3lTaQ40Lpb8fpoL3uQFb4pIMTTA5aDuPHA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw9I84iX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965061F000E9;
	Wed, 17 Jun 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781692813;
	bh=DlEfR9pICvUBBGSXETGuzZRx9EsFEDYiPNGSgg6HZf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cw9I84iXpFui6tafPbyA4eOU/n6fMEfwHloW46x2UlIuo/K958WJcdPEZwaywXzpA
	 1Ho4zWSK/gsQCudPvEI/8qRQ9szTyRyIVTadnIRQ6gXdalr9vtuQMFkg6/VS0anqki
	 ovJQl5BistsWCMYVp0/5XLUixqwNZqmWcBCz+/mVsxN/+l3OSH8jNhNbzEiqKqqPHD
	 QdWqyUMY2UkD0ocC54mWfggxxrBUjn2eebzTrLjDWTBcRrLAs9LJic1p8W5dsz0/RY
	 XPGnBh3rTE9FaO9M7JUTlYUV/5r+V2su07UC1GUJ6joyUk8f8QhJIOmopKE4xT80w3
	 o+a0dSbYeyLXQ==
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
Subject: Re: [PATCH net 1/2] sctp: factor out INIT verification failure handling
Date: Wed, 17 Jun 2026 11:39:54 +0100
Message-ID: <20260617103954.852101-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6fb546c80126a410349e724045ce16a41413c8a6.1781570014.git.lucien.xin@gmail.com>
References: <6fb546c80126a410349e724045ce16a41413c8a6.1781570014.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1269-lists,linux-sctp=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB9A6698A7E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
sctp: factor out INIT verification failure handling

This refactor moves the duplicated INIT/INIT-ACK error handling out of
sctp_sf_do_5_1B_init(), sctp_sf_do_5_1C_ack(), and
sctp_sf_do_unexpected_init() into a new helper sctp_abort_on_init_err().
The commit message states "No functional change intended."

> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 9b23c11cbb9e..544f308ee527 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c

[ ... ]

> @@ -548,50 +531,9 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
>  	err_chunk = NULL;
>  	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
>  			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
> -			      &err_chunk)) {
> -
> -		enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
> -
> -		/* This chunk contains fatal error. It is to be discarded.
> -		 * Send an ABORT, with causes.  If there are no causes,
> -		 * then there wasn't enough memory.  Just terminate
> -		 * the association.
> -		 */
> -		if (err_chunk) {
> -			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
> -					(__u8 *)(err_chunk->chunk_hdr) +
> -					sizeof(struct sctp_chunkhdr),
> -					ntohs(err_chunk->chunk_hdr->length) -
> -					sizeof(struct sctp_chunkhdr));
> -
> -			sctp_chunk_free(err_chunk);
> -
> -			if (packet) {
> -				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
> -						SCTP_PACKET(packet));
> -				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
> -				error = SCTP_ERROR_INV_PARAM;
> -			}
> -		}
> -
> -		/* SCTP-AUTH, Section 6.3:
> -		 *    It should be noted that if the receiver wants to tear
> -		 *    down an association in an authenticated way only, the
> -		 *    handling of malformed packets should not result in
> -		 *    tearing down the association.
> -		 *
> -		 * This means that if we only want to abort associations
> -		 * in an authenticated way (i.e AUTH+ABORT), then we
> -		 * can't destroy this association just because the packet
> -		 * was malformed.
> -		 */
> -		if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
> -			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
> -
> -		SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
> -		return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
> -						asoc, chunk->transport);
> -	}
> +			      &err_chunk))
> +		return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
> +					      commands, err_chunk);

[High]
In the original sctp_sf_do_5_1C_ack() the "if (err_chunk) { ... }"
block is non-controlling: when err_chunk is NULL the code skips the
block, falls through with error == SCTP_ERROR_NO_RESOURCE, consults
sctp_auth_recv_cid(SCTP_CID_ABORT, asoc) and either pdiscards or runs
sctp_stop_t1_and_abort() to tear the half-open association down.

[High]
In the new helper, can the INIT-ACK + NULL err_chunk case still reach
that path?  Looking at sctp_abort_on_init_err():

  if (!err_chunk)
          return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(0),
                                      arg, commands);

  ...
  if (chunk->chunk_hdr->type != SCTP_CID_INIT_ACK) {
          ...
  }
  /* SCTP-AUTH, Section 6.3 ... */
  if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
          return sctp_sf_pdiscard(...);
  SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
  return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
                                asoc, chunk->transport);

[High]
The !err_chunk early return runs before the INIT-ACK type check, so
when sctp_verify_init() returns 0 with *errp left as NULL on an
INIT-ACK, control now goes to sctp_sf_tabort_8_4_8() rather than the
auth-check + sctp_stop_t1_and_abort() path.

[High]
Is the NULL-err_chunk case actually reachable on an INIT-ACK?  In
sctp_process_inv_mandatory() and sctp_process_inv_paramlength() in
net/sctp/sm_make_chunk.c, *errp is allocated via sctp_make_op_error_space()
or sctp_make_violation_paramlen() and the function returns 0
unconditionally:

  if (!*errp)
          *errp = sctp_make_op_error_space(asoc, chunk, 0);
  if (*errp)
          sctp_init_cause(...);
  return 0;

So an allocation failure on a malformed INIT-ACK reaches the helper
with err_chunk == NULL.

[High]
On that path, does the new code skip several actions that the original
performed?  sctp_sf_tabort_8_4_8() emits an OOTB ABORT and pdiscards;
it does not stop T1-init, does not call SCTP_CMD_SET_SK_ERR(ECONNREFUSED),
does not issue SCTP_CMD_INIT_FAILED, does not transition the asoc to
SCTP_STATE_CLOSED, and does not increment SCTP_MIB_ABORTEDS.

[High]
As a result, would connect(2) wait for T1-init to exhaust its
retransmissions instead of receiving ECONNREFUSED promptly, and would
SCTP_MIB_ABORTEDS no longer be incremented (with SCTP_MIB_IN_PKT_DISCARDS
being incremented in its place)?

[High]
Does this also bypass the SCTP-AUTH section 6.3 check quoted in the
comment?  Previously, when AUTH-ABORT was negotiated and err_chunk
was NULL, sctp_auth_recv_cid() caused sctp_sf_pdiscard() to be returned
and no ABORT was emitted on the wire.  In the new path, sctp_sf_tabort_8_4_8()
sends an unauthenticated OOTB ABORT regardless of AUTH negotiation.

[High]
Finally, does the disposition return value also change from
SCTP_DISPOSITION_ABORT to SCTP_DISPOSITION_CONSUME on this path?

[High]
Would moving the chunk->chunk_hdr->type check ahead of the !err_chunk
early return restore the original semantics for INIT-ACK while keeping
the sctp_sf_tabort_8_4_8() fallback for INIT?

[ ... ]

> @@ -6485,6 +6403,61 @@ static void sctp_send_stale_cookie_err(struct net *net,
>  	}
>  }
>  
> +static enum sctp_disposition sctp_abort_on_init_err(
> +					struct net *net,
> +					const struct sctp_endpoint *ep,
> +					const struct sctp_association *asoc,
> +					const struct sctp_chunk *chunk,
> +					void *arg,
> +					struct sctp_cmd_seq *commands,
> +					struct sctp_chunk *err_chunk)
> +{
> +	enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
> +	struct sctp_packet *packet;
> +	struct sctp_chunkhdr *ch;
> +
> +	if (!err_chunk)
> +		return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(0),
> +					    arg, commands);
> +
> +	ch = err_chunk->chunk_hdr;
> +	packet = sctp_abort_pkt_new(net, ep, asoc, arg,
> +				    (__u8 *)ch + sizeof(*ch),
> +				    ntohs(ch->length) - sizeof(*ch));
> +
> +	sctp_chunk_free(err_chunk);
> +
> +	if (packet) {
> +		sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
> +				SCTP_PACKET(packet));
> +		SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
> +		error = SCTP_ERROR_INV_PARAM;
> +	}
> +
> +	if (chunk->chunk_hdr->type != SCTP_CID_INIT_ACK) {
> +		if (!packet)
> +			return SCTP_DISPOSITION_NOMEM;
> +		return SCTP_DISPOSITION_CONSUME;
> +	}
> +	/* SCTP-AUTH, Section 6.3:
> +	 *    It should be noted that if the receiver wants to tear
> +	 *    down an association in an authenticated way only, the
> +	 *    handling of malformed packets should not result in
> +	 *    tearing down the association.
> +	 *
> +	 * This means that if we only want to abort associations
> +	 * in an authenticated way (i.e AUTH+ABORT), then we
> +	 * can't destroy this association just because the packet
> +	 * was malformed.
> +	 */
> +	if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
> +		return sctp_sf_pdiscard(net, ep, asoc, SCTP_ST_CHUNK(0), arg,
> +					commands);
> +
> +	SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
> +	return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
> +				      asoc, chunk->transport);
> +}

