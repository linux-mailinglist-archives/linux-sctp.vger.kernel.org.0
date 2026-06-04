Return-Path: <linux-sctp+bounces-1232-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ysVvNzdYIWrFEQEAu9opvQ
	(envelope-from <linux-sctp+bounces-1232-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 12:49:27 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06B63F311
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 12:49:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IWXxxFUM;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1232-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1232-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A2C302351A
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Jun 2026 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29303379C49;
	Thu,  4 Jun 2026 10:48:47 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8025228D;
	Thu,  4 Jun 2026 10:48:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570127; cv=none; b=OFmQlB1H2N4GylFB9Ieq/gaALKrhgOSWNdOmJvhThiM6bKA6rxUQGGA+cRbp34no2nOSUDYZAxvOhcWyPSBW7WpTysgNK+ef+c2JlSZkRUwN8RI5uEdkrcMtBE5pzmhxvkIfluErmYQgc06IKO7uZpMp/rQA+1dom+y36aMmeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570127; c=relaxed/simple;
	bh=NhjpSV8kbwwztydJJsEocMCjGECxphNrWHWb/NbWx9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch6iOKKVy2+6lf3IUP16rPe5H0syzmcXPpL+/h+F0Fqu28poOtxCxApgI2LRchL4NYJBTB9piDiVsXgUMD9azAgBiD5qP+Y9K7KfdqWsZFYKDqnnwXC23uaSzOrRjYtDQ2ZFq0n0LZlQ+L6cSxxNPYGpdNva9H/i2IUM/9f/Do0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWXxxFUM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E97C1F00893;
	Thu,  4 Jun 2026 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780570125;
	bh=utFnp8XY1auOWu4UYvkAONYE8LSpdtHRf3hdQz1NicY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWXxxFUMOZQVqLMQJ4XMGLOBO/v2xfF5PzFfTzhPms9ZxrMaDQMTw0TUUiyv8dz3C
	 4Q2Tp0xZT5GypW7hsULy8VUsL85QLUPYn1d6L6DYJt48YE5Ueam1AHAJal2LLwj6nY
	 UkOw1zQeqkUHGAaWqm3fZdlDP68NumeiiGMWcaxbHEOXeuMl3VxWT59GvSoLHiKhH4
	 WXHi0oVj2X8KFMYSDEsx1iw7VJ/zhn0LjSuHeMdMbWj+azjEENYtwpLGLgPcEJT/ly
	 CbOovmDU4qPuakhPDhrxuvfLJyFrgerbUKwHGZz6MD/0E1vuo9c/idNXHoLJG6pM3o
	 6QBvKf6lYUomA==
From: Simon Horman <horms@kernel.org>
To: lucien.xin@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	marcelo.leitner@gmail.com,
	bgeffon@google.com
Subject: Re: [PATCH net] sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
Date: Thu,  4 Jun 2026 11:47:14 +0100
Message-ID: <20260604104712.3904260-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
References: <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1232-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:bgeffon@google.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B06B63F311

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing

This commit adds a bounds check to ensure the cached peer INIT chunk
length does not exceed the available data in the COOKIE_ECHO buffer
during unpacking.

Simon says:

Hi Xin,

Although the issues flagged below are flagged as pre-existing I am
wondering if they directly impact the effectiveness of this patch.
Could you take a look?

> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index de86ac088289e..85264862fb6b6 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c

[ ... ]

> @@ -1759,6 +1760,10 @@ struct sctp_association *sctp_unpack_cookie(
>  	cookie = chunk->subh.cookie_hdr;
>  	bear_cookie = &cookie->c;
>  
> +	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
> +	if (ntohs(ch->length) > len - fixed_size)
> +		goto malformed;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this check also
need to ensure the length is at least the size of the INIT header?

If ch->length is small, for example 4 bytes for just the chunk header,
this check passes. However, sctp_process_init() appears to unconditionally
read the init_hdr fields:

net/sctp/sm_make_chunk.c:sctp_process_init() {
    ...
    asoc->peer.i.init_tag = ntohl(peer_init->init_hdr.init_tag);
    asoc->peer.i.a_rwnd = ntohl(peer_init->init_hdr.a_rwnd);
    ...
}

Could an attacker send a COOKIE_ECHO chunk with an embedded INIT chunk
truncated to 4 bytes and trigger an out-of-bounds read past the SKB payload?

[Severity: High]
This is a pre-existing issue, but is cookie->raw_addr_list_len properly
validated against the remaining payload length before use?

If SCTP cookie authentication is disabled, an unvalidated
raw_addr_list_len could lead to out-of-bounds reads when
sctp_assoc_set_bind_addr_from_cookie() calls sctp_raw_to_bind_addrs()
to parse the bind addresses:

net/sctp/bind_addr.c:sctp_raw_to_bind_addrs() {
    ...
    while (addrs_len >= sizeof(struct sctp_paramhdr)) {
        param = (struct sctp_paramhdr *)raw_addr_list;
        len = ntohs(param->length);
        addrs_len -= len;
        raw_addr_list += len;
    }
    ...
}

If the unvalidated addrs_len is artificially large, or if a supplied
param->length is larger than addrs_len causing an integer underflow on
addrs_len -= len, could this bypass the loop condition, read into unmapped
pages, and cause a panic?

>  	/* Verify the cookie's MAC, if cookie authentication is enabled. */
>  	if (sctp_sk(ep->base.sk)->cookie_auth_enable) {
>  		u8 mac[SHA256_DIGEST_SIZE];

