Return-Path: <linux-sctp+bounces-1238-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z6tvLkyRImoxaQEAu9opvQ
	(envelope-from <linux-sctp+bounces-1238-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 05 Jun 2026 11:05:16 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A91646AE0
	for <lists+linux-sctp@lfdr.de>; Fri, 05 Jun 2026 11:05:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UxlDRdTk;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1238-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1238-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DFE53081947
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Jun 2026 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3724A2E23;
	Fri,  5 Jun 2026 08:52:34 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7C37F8C6
	for <linux-sctp@vger.kernel.org>; Fri,  5 Jun 2026 08:52:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649553; cv=none; b=NY1usGju4tNHDw8vFtwTeVCzIFS0SQolxWkXvrJl9FbJfiCiggJa8oIoyt/PyGdwv+cIV4wclgq1l3HUtywdxjQuOwUAzLkGNDsIECH7V6NCT+R6xC1IDznCtJgVWzBoPq3pTJAlQLa7O0oJo38qEENNgezoTrcqVpygc0BPctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649553; c=relaxed/simple;
	bh=/wI/UxY2JP6RcLCr7H6wSJdtL+VOLO3RPdEB5IDxA/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R406a9tWhAHI3C2pM7XFNpgQNeByIeuar83gDKKvPRNDPKazYj839Kcyz+2sIhOWUrc+bnhDhKLqXF9J0srp9RGr90UDLZIL6JC58JCUSRBGE5Ik+nEagf8jV66RG4kn49AAdTXMkpRzkdn9Rv96G90hgEbScaRl+9GYH+ww448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxlDRdTk; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1278012f8f.2
        for <linux-sctp@vger.kernel.org>; Fri, 05 Jun 2026 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780649550; x=1781254350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+yeXgyUFJ16Hxtz3HlfZ6J7s+54zwh5KcpUkTsryFU=;
        b=UxlDRdTkZFexMTzeRiG8v4lS6xH7KcrrX8fVSE/gymCT5W0sZn2UgYvwpz0ZQQjKYA
         cQKhgdpgVBsVV8Xu/dCXR9EsORk8ogP9fJrRYKR0XOQMcr9jFH1LhorCTKEZzpQqulnm
         p54NjNPL4h8DnbbAGmhT1JjI8b8ydcstyK+3AzAuQxRLgTLZV8GTMYMNIAZX6X6kXbXy
         EfsyAuNUv0RLPQdXO0A+hMyninRGMQUePsIDaPoS5dHwA5oA+QNFAwncPKg17+U02scZ
         /0XdNokCN78dQFE3ic/MXdmXfWIDxF5zenW/ycGtl+4igQcumeLyfxEsc5Z//UeLpXa0
         OQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780649550; x=1781254350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+yeXgyUFJ16Hxtz3HlfZ6J7s+54zwh5KcpUkTsryFU=;
        b=RpJYq3nSb88ADZyoTqoYfyF38oCXLiccjGj7yOpKsIyNeVvyqY6I+IOe6ClgSaOwBj
         bqNOekQcZYuLl/iKUuMWGv2kswhCo0qBN3DNZNiNR0pYygf8OOChGIz5RwuebEMfPLBk
         Rv0n7aIGN0qYdymZeHu9KOVDaWgUWrZLiPQHMrIbNft+QnFRFejfnaXtMp7zWk4oUq7Z
         mMoYQzUjYfqDj4RCI+XVkjpWCEMGVfCbH9tSgDKtZ1axR86SublzQFdWJSW9rsbY1uj1
         gQsbbGJcmBvPq+u330utL9zPlQBip/yHSwOub1W4eqOF6zd4knpdiluSnfqXMULwg0MO
         jfuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zjSCTkHUFDvzvPCDHEPU7LkF+MHzVi5C+feCQTLdsinQuQcydk1Bxh2WGWEoZWclF5Dg/Xb6G0p8d@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqIbxkpmlH2hNzRQVBR2qgrbHc+yxwHtSSCg6mSuZBu3mreDj
	G6yfhULUmponKNjAnHbZoruFziNM/ug9hxNNs8APiGCbKXd9pbhT+aBp
X-Gm-Gg: Acq92OFzMsLgC8sP7P7HVRn94zGernYy7P9ur/a5w4OiqAqY1MToZVg/1HnawJNiNR8
	ru550GuGwf98W3ozfWJj0b6dPgIbM2MLpYzan/gzafkYhC/kj/m7+hC1bDfTXVcWGGfc3nZLlfI
	LhCG+uUkJ/XwCGO2xKefXpoyYBpb6MBDpLTRBw9eVqQDNrrpNopVoNo2oNXizDRPcMc2H4leohZ
	Jv/oriZ/BQJ/sq+b2X5SyAubuvEh9P/QutSjxysa27XwOqUy0j1SGLGxp7X5t7janVRW/796zWc
	UTP6PG3kcUb8h6SbSrsJvv0q0ZsQTiWlyIMrO6e/5k5oT2cWyO+0Tx8nmvqr6z9vHE3tKp+rs7I
	TYYEHoQzkERtVxArbRhbA90aTTv2ixShOCJFddzG1XPc8GnFjfH8gXeRXhezuQa8CpM9Wl3L5O5
	cr+ef+DiI77C7vQcVESSdMRcMQTY/G2xXWZkgCf7AMoGPwazOGqgANU3UQgpz0HP4zUphaicA=
X-Received: by 2002:adf:e004:0:20b0:460:2eee:4e21 with SMTP id ffacd0b85a97d-460302f0702mr3055000f8f.17.1780649549937;
        Fri, 05 Jun 2026 01:52:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm24595547f8f.4.2026.06.05.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:52:29 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:52:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vlad Yasevich
 <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] sctp: fix uninit-value in
 __sctp_rcv_asconf_lookup()
Message-ID: <20260605095228.75430455@pumpkin>
In-Reply-To: <20260604175803.2142975-1-michael.bommarito@gmail.com>
References: <20260604175803.2142975-1-michael.bommarito@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-sctp@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-1238-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,hp.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41A91646AE0

On Thu,  4 Jun 2026 13:58:03 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

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
> Impact: an unauthenticated SCTP peer makes the receive path read up to 16
> bytes of uninitialized memory past a truncated ASCONF address parameter.
> 
> The sibling __sctp_rcv_init_lookup() bounds parameters with
> sctp_walk_params(); this path open-codes the fetch and omits the bound.
> Verify the whole address parameter lies within the chunk before
> from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
> ("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").
> 
> Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF chunks as well")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/sctp/input.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -1196,6 +1196,7 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
>  	struct sctp_addip_chunk *asconf = (struct sctp_addip_chunk *)ch;
>  	struct sctp_af *af;
>  	union sctp_addr_param *param;
>  	union sctp_addr paddr;
> +	__u16 plen;

Just use 'unsigned int'.

>  
>  	if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_paramhdr))
>  		return NULL;

It might be more obvious to check the 'free space' from the test above, say:
	int param_space = ntohs(ch->length);
	param_space -= sizeof(*asconf) + sizeof(struct sctp_paramhdr);
	if (param_space < 0)
		return NULL;

	param = (union sctp_addr_param *)(asconf + 1);
	if (ntohs(param->p.length) > param_space)
		return NULL;

-- David

> @@ -1204,6 +1205,16 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
>  	/* Skip over the ADDIP header and find the Address parameter */
>  	param = (union sctp_addr_param *)(asconf + 1);
>  
> +	/* The whole address parameter must lie within the chunk before
> +	 * af->from_addr_param() reads the variable-length address; otherwise a
> +	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
> +	 * the parameter.  Mirror the bound sctp_walk_params() applies on the
> +	 * INIT path.
> +	 */
> +	plen = ntohs(param->p.length);
> +	if (plen < sizeof(struct sctp_paramhdr) ||
> +	    (u8 *)param + plen > (u8 *)ch + ntohs(ch->length))
> +		return NULL;
> +
>  	af = sctp_get_af_specific(param_type2af(param->p.type));
>  	if (unlikely(!af))
>  		return NULL;
> 


