Return-Path: <linux-sctp+bounces-1270-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BRnaDwh8Mmqr0gUAu9opvQ
	(envelope-from <linux-sctp+bounces-1270-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Jun 2026 12:50:48 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1183698AA0
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Jun 2026 12:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SKjgQH2N;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1270-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1270-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9144305E166
	for <lists+linux-sctp@lfdr.de>; Wed, 17 Jun 2026 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B246AF21;
	Wed, 17 Jun 2026 10:40:25 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7A3F8254;
	Wed, 17 Jun 2026 10:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692825; cv=none; b=HMFOZPl8aJD5uF2+b66sCbr98OwAkzY0hLPt9wCjTQbfG4tSS1/71ClUSRW4fpX9Ut9IdrMCzmJtvDcglIkB0F43ISatLqN4GGnrAWA3VOmPKg1vSnt31yha+tm65eSSoGRlYwJRaRgD4sYcQQkkg27qaK0uA9TQouKzd1J/ymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692825; c=relaxed/simple;
	bh=GKymhiW7J+Bv2PO/m6Er2PZh6RPu1LI3/vh/N10tnag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krPTtkWipvJek8hOFtJJ7K+pYlDMA3fzOv/Q2Y0K3PIvtrjsfs7u/IEo51Xs1DyVJApUWh43H0M9xc00bMj5oVCi7Rxgy6vIE48e2eNpgapcLSZHweZXEMEz061t2l5mfhyT4ZRRZPAExtU2vqXfUHhlafdM9QjOuMDQKcVWB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKjgQH2N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193001F000E9;
	Wed, 17 Jun 2026 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781692823;
	bh=BeKuMeN+yf8YgyloKPkee4kXcdZ1FQ41bWTALJCTD08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SKjgQH2NVlk8VOzaFMIrdwtdlQ+r64DZcnQ6OC1kvWEk0hPjHcbRORA3CRJy0pd/Z
	 cIqsAXLBVGi5BlaJL9tT9oPZ/vQ2jcMl9oO05CszQcOXSRHc3xCPODlFihvZKYwcUu
	 cam7SvdtHCX82fJEdZJmliqINd5n7j6yPkn+iiOPhfaTDYNwmDEfAQ4xgUXgPWtBvw
	 lndGxeteDm0tPT0es8PNRuC82dzlhhrKCFNQ+85f9cPt9t/DOuj4t53s6i4ecYUhHi
	 6y7F8FArK8vms+XKTOwktDC7UPXFC5gOwzbU7DScrZYU8ZDF3Iqc2qGiGdgU6JvIt3
	 Hbov427S3X0xg==
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
Subject: Re: [PATCH net 2/2] sctp: add INIT verification after cookie unpacking
Date: Wed, 17 Jun 2026 11:40:13 +0100
Message-ID: <20260617104013.852168-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <13a54c38586e0e1c7d46dfc16c3f6e1a7685001b.1781570014.git.lucien.xin@gmail.com>
References: <13a54c38586e0e1c7d46dfc16c3f6e1a7685001b.1781570014.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1270-lists,linux-sctp=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1183698AA0

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Now I have enough verified information to produce the report.

commit 9d74027bfd0cb22a103cca034883f0fcb4e2535a
Author: Xin Long <lucien.xin@gmail.com>

sctp: add INIT verification after cookie unpacking

This commit adds sctp_verify_init() checks after cookie unpacking in
the COOKIE-ECHO processing paths when cookie_auth_enable is disabled.
It also changes the bounds comparison inside sctp_verify_init() from
chunk->chunk_end to peer_init + ntohs(peer_init->chunk_hdr.length).

> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 41958b8e59fd..21b9eb1c02e9 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2298,7 +2298,7 @@ int sctp_verify_init(struct net *net, const struct sctp_endpoint *ep,
>  	 * VIOLATION error.  We build the ERROR chunk here and let the normal
>  	 * error handling code build and send the packet.
>  	 */
> -	if (param.v != (void *)chunk->chunk_end)
> +	if (param.v != (void *)peer_init + ntohs(peer_init->chunk_hdr.length))
>  		return sctp_process_inv_paramlength(asoc, param.p, chunk, errp);

[High]
Can this new comparison reject INIT chunks whose final parameter has a
length that is not a multiple of 4?

sctp_walk_params() advances pos.v by SCTP_PAD4(ntohs(pos.p->length)) on
every iteration:

  include/net/sctp/sctp.h:
  #define _sctp_walk_params(pos, chunk, end)\
  for (pos.v = (u8 *)(chunk + 1);\
       ...
       pos.v += SCTP_PAD4(ntohs(pos.p->length)))

so when the final parameter has an unpadded length L that is not 4-byte
aligned, pos.v ends at peer_init + offset_of_last_param + SCTP_PAD4(L),
which exceeds peer_init + ntohs(peer_init->chunk_hdr.length) by 1..3.

The previous comparison used chunk->chunk_end, which inqueue.c computes
with the padding included:

  net/sctp/inqueue.c:
  chunk->chunk_end = ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));

so the old check accepted unaligned-length final parameters; the new
check returns 0 from sctp_verify_init(), and the callers then invoke
sctp_abort_on_init_err() and emit an ABORT.

Note that this change is in sctp_verify_init() itself, so it affects
every caller, not just the new COOKIE-ECHO sites: sctp_sf_do_5_1B_init,
sctp_sf_do_5_1C_ack, sctp_sf_do_unexpected_init, sctp_sf_do_5_1D_ce
and sctp_sf_do_5_2_4_dupcook all reach this comparison.

Realistic triggers include:

  - Locally-generated INITs constructed by sctp_make_init() when both
    auth_enable and asconf_enable are set: with the default chunk IDs
    ASCONF + ASCONF_ACK the AUTH-CHUNKS parameter has length 6 and is
    typically the last parameter, leaving chunk_hdr.length unaligned.

  - Peer INITs containing any final parameter with non-4-aligned
    length, e.g. SCTP_PARAM_SUPPORTED_ADDRESS_TYPES with 1 or 3 types
    last, AUTH-CHUNKS with N=1,2,3 entries last, or any unknown TLV.

Even in the COOKIE-ECHO context the new bound seems too strict, since
sctp_pack_cookie() copies the INIT verbatim with memcpy(cookie + 1,
init_chunk->chunk_hdr, ntohs(...->length)) followed immediately by
raw_addrs, so unpacked cookies recovered from peers that sent an INIT
with an unaligned-length final parameter would also be spuriously
rejected.

Would comparing against peer_init + SCTP_PAD4(ntohs(peer_init->
chunk_hdr.length)) preserve the long-standing semantics of chunk_end
while still validating the cookie-derived peer_init bounds?

> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
[ ... ]

