Return-Path: <linux-sctp+bounces-1248-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LN3HDe8sKGpe/gIAu9opvQ
	(envelope-from <linux-sctp+bounces-1248-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 09 Jun 2026 17:10:39 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E436618FD
	for <lists+linux-sctp@lfdr.de>; Tue, 09 Jun 2026 17:10:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ERz7Efvz;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1248-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1248-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C0B30B5E01
	for <lists+linux-sctp@lfdr.de>; Tue,  9 Jun 2026 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8E2D6E6C;
	Tue,  9 Jun 2026 14:58:56 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292FF43C05F
	for <linux-sctp@vger.kernel.org>; Tue,  9 Jun 2026 14:58:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017135; cv=pass; b=tElX1GmX8zyPq4guj6+daJTYTmWofCUa4oKn/vStADN2B80tztUgFApwIgacowpcb+rl+u8PJpdXi+E1BQyW56tsqS6UkCjXad/wT3oIK0OUvtzn86DCJXRhRXWEMOuwrhw2yGNh7OqyNfSI5wO1J8LK9/UKjHWBC/hCcRD7EIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017135; c=relaxed/simple;
	bh=fMh62eLOhdvO0usy4iUY0pf1PF0Zf7FtoOnXowWBotI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfxoWFGyb1VwY08aLLZEia8bhSRBes1Yl7EnI/ghESQupYLBYd7WLz5Ei2x/c1L7w/vrdIaav3HFf3fno8D+LQU9MnS1Mw2XaI3LGQRbENGAamEwDrXJbLggo3ki44rQB9BY/ViMaRqt0s+Vjm4GrQxQK0vNUI7ydKkGKKNJn+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERz7Efvz; arc=pass smtp.client-ip=209.85.217.54
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6c87709aa26so3236789137.0
        for <linux-sctp@vger.kernel.org>; Tue, 09 Jun 2026 07:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781017130; cv=none;
        d=google.com; s=arc-20240605;
        b=aELm5oiyt59g2rMmrg8VWHoNVVyqa/koe4/bsZXr4a4QgUhHhCws1+h5Gd7+UhKl8Y
         SRiZspLL5TO14H8S2pWCiYWnwxFQFQ4DsXraAXy+MIUpzwPGahn0ID653kriHPqyv6Ti
         KWPjBHC+lxLbP1TKqmus7dskwU76AZgvXLLhN6YFn66ah+1xIv7Px4IM3hxRDxIOzBYm
         lGBpLE6FrAPBBX+1l7vZO5lZoiANvmJGu7JfOP+N9j47S2rl4euUIK3LZcOMoJzaaKfN
         /5RHXli7SzOVSp76MRswTke+4XGADxEzyjWGWs781toNz0bfVa7jxsvGte7vYfoGuuLk
         S00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H57Owih5QKKzWEDODczf7OTcTvzt7lC+ATYjGHBhng4=;
        fh=cXba0Ca3d8Q9QKREOlVEZKadqnCjZ1rkubSQDTJe4Jg=;
        b=DYwOk0k0sx43e/YpIjMlOj+jpXWaTE98DEG0ypchG5l0OjzLDnlfhJGhn4Ho2drUm9
         LrBjqf8bifomrDQth27C6Wy3UiesYFyEZ0SBsHA8FLCbsMkRr2UIyDgVtfhGhDpyP7n4
         Cw3YG57O8yr2+uSviVv1tJ858FiJfkZqrIq37P/PIdGB3F002bn03jJSXtIbaoDQ2Geu
         OFiCqh54GGB9MxdMgI1ZhcVefFD0GCXQ2+B2OqJkZuc1S7EcjDmTeQuEeGOBoYDouDdd
         RSCjlGe6h4vGgyYUKvY5eaa0lSOp6xw52bMaYUOBRKeREdKHmSZaEqrgB97HKB/6MoqU
         n3sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781017130; x=1781621930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H57Owih5QKKzWEDODczf7OTcTvzt7lC+ATYjGHBhng4=;
        b=ERz7Efvzss+oIrWfuAQM51JuSf5iuhPf3GAG7+vuM/8Bw8OmHP4zsQBbWSZrHUYknP
         2clPmlZwWSpsKcohPRII72UAXYFc5ho+nrBqF0GJLtcvFToOEBFvHMzLNAxsbyR/IqjS
         a6o52pnmZGvFker90Cdf/hrCM4FlGq5Ce7X7Ze4uMVD+6nctSdanHH/7cSDbk+snC6QH
         xAJdEZkEfG7j8aVSns5Mj5xzs9VtswHtlrHBs+Ugt5JeimHj4U2GmJ1UBgYbJ+OxV0CF
         tMq8vSkKuE7r6yJysUXeGsdiGBqq+iBLGXhdsGdfla2EJwaRBwrt/nj2tu2J3rL1h9zt
         Ltsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017130; x=1781621930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H57Owih5QKKzWEDODczf7OTcTvzt7lC+ATYjGHBhng4=;
        b=fxgP32V6bGGiBGGkTjery6pnyic3FXqBcrYVRUDouOIWG68lJP2CDS/lmlQ0NOWWVv
         QeBoM1BhQIpX5pdlNnMGZSBTRhXFhO08riYlxLT2op3R59psT86vuA/xa6/1CoaKYkrV
         VwlQv28+2rMmDzX9pUhdkk7Ti9TneDqFx2jjIc00ZHnQ0laM6oaPdlbm/f9o7Mdnv6NW
         BdsQLn5SqrjYySBTsxJIsiJSGDt2fy/w4Th6+KtUOypNVZVkBMoQuQUg9hjiokGU1z3o
         YMe6DwMC04XkdM5tFzp6eZD4eEQp94OoIcnv7Xr5PJFTkx7xl0V6xEnBBsmutpcSTzdV
         D3CQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DEqazl83aDaRQOI8SUw85TwExyYefdbmImkM722jNmbrvrz6rBEbDp+lUYa18twbSQ+2pW6N2Uvf1@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBNK8D+rWZfg48kaDxkDbBvdSR9LUbpOk0AKDl2L38ApAJ+1N
	5rXHdYb9QYNIYLbe/I4Y+GWCCfxDWsFaHaCZlq+Vw/lx2EiivrvjqAjC6GT5ouWgL/oWNEqy4RD
	DckbDK8zLOBBeIrvnmagI4nevorZ/+iA=
X-Gm-Gg: Acq92OHwrBsQ5RIUiepNCjZGuut7a3VfZYH7LYK+5NM0zCyeN0ZMKrZrLAJjr+AyYsl
	WKq51dqbPCtgTzyptJLxhWyYt+AKFLRVTSdvf9qvm+/eigriDWloF/Dt8r3wErQfkRLMpltGifP
	BpnK8pVf708xWHNi7PDfLinXF5OCfK3BCbiEEmnoT1elXAkx6BgoOL7K+MvqyWyma/04+3VA2hQ
	9OLMMHTbobEMQxS44H4askI2FG54/dyuKmQ4rkkJGs4Tfdu9onWkd+paHIk3FFVk/NeCiuJZpn8
	la5GBFxfU3fG7owb4KflQEjneSHgJhVuV7CCdMJ2NxA6qOZalCBlNGbRGW27dKL7UZ8BfU4fvAH
	lU0HIsSpjdZbZrli1wVOX9KhZKjbeu6NY3B9r24CjKA6tp70w5KXTi4bP6u+UAQ==
X-Received: by 2002:a05:6102:8001:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-6feff813ee1mr11333035137.10.1781017129848; Tue, 09 Jun 2026
 07:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608122234.459098-1-michael.bommarito@gmail.com>
In-Reply-To: <20260608122234.459098-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 9 Jun 2026 10:58:34 -0400
X-Gm-Features: AVVi8CfBBT7d0bAskWAVYMw__d7eXDupmpTg3qFr9V9XwUvjdbrVkT6ocmLEXwg
Message-ID: <CADvbK_ed+J=k+xBFQYszROgK9f9zevTmxEsjrX3Ow1rN3rp8Sw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Yasevich <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1248-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,hp.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85E436618FD

On Mon, Jun 8, 2026 at 8:22=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> __sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCON=
F
> chunk can hold the ADDIP header and a parameter header, then calls
> af->from_addr_param(), which reads the full address (16 bytes for IPv6)
> trusting the parameter's declared length.
>
> An unauthenticated peer can send a truncated trailing ASCONF chunk that
> declares an IPv6 address parameter but stops after the 4-byte parameter
> header; reached from the no-association lookup path, from_addr_param() th=
en
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
> Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF=
 chunks as well")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v3:
> - Simplify to a single bounds check that the whole address parameter
>   fits in the chunk, written as an addition to avoid unsigned wrap
>   (David Laight); drop the redundant lower-bound test and the
>   param_space/plen locals (Xin Long).
> v2:
> - Regenerate from net/main so the patch has index lines and applies
>   cleanly (Xin Long).
> - Use unsigned int for the decoded length and compare it against the
>   remaining parameter space after the ADDIP header (David Laight).
> v2: https://lore.kernel.org/all/20260606183821.1688525-1-michael.bommarit=
o@gmail.com/
> v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommarit=
o@gmail.com/
>
>  net/sctp/input.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index e119e460ccde0..864741fae4187 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -1204,6 +1204,14 @@ static struct sctp_association *__sctp_rcv_asconf_=
lookup(
>         /* Skip over the ADDIP header and find the Address parameter */
>         param =3D (union sctp_addr_param *)(asconf + 1);
>
> +       /* The whole address parameter must lie within the chunk before
> +        * af->from_addr_param() reads the variable-length address; other=
wise a
> +        * truncated trailing ASCONF chunk lets it read uninitialized byt=
es past
> +        * the parameter.
> +        */
> +       if (sizeof(*asconf) + ntohs(param->p.length) > ntohs(ch->length))
> +               return NULL;
> +
>         af =3D sctp_get_af_specific(param_type2af(param->p.type));
>         if (unlikely(!af))
>                 return NULL;
>
> base-commit: 9988931df99cf5d68af360e1f23b9c674a0b1b4f
> --
> 2.53.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

Note in:
https://sashiko.dev/#/patchset/20260608122234.459098-1-michael.bommarito%40=
gmail.com

The pre-existing issue reported looks real to me, I may address it in
sctp_verify_asconf() and sctp_verify_init() in a separate patch.

Thanks.

