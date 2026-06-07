Return-Path: <linux-sctp+bounces-1243-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bhZnI/IBJmr3QQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1243-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 08 Jun 2026 01:42:42 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3E651EB8
	for <lists+linux-sctp@lfdr.de>; Mon, 08 Jun 2026 01:42:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hHnFmrn0;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1243-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1243-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F15B230062F1
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2026 23:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3533343B;
	Sun,  7 Jun 2026 23:42:39 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498CB32AAD6
	for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2026 23:42:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875759; cv=pass; b=AVVB8Uhsltc3Id7eKzeA0dMc9VY1avI1Xl3AW28y0jtRSplQ5st5X3/n1f9j6GrH9sxCskqQntzfj/5vCF/N3NjzvDzI4xRV53hDpEZ7pcI5YO7ZokJJ5Ly/Bmy6B5VT4O+hSQIvj0JhBkCxDQ1IJOzLHApOUFpWVAJCOQdxzNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875759; c=relaxed/simple;
	bh=lL8p7x6mVEzais/C1T5Ny6DwjN0hjNCCjCChcQazOss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKN3lY5ZX3/t/ybM4V1aASmAu3r1P7hiSYV6T3r3N9G4HUE0vvSI6TQEJ7vaIj6luAX1cJzccKCfiz+BR/Ff9cC+twduiMGdhQ9p6qvnsdmDrlpc2uMEuhc6QSArlsxBAiudfeRDofqXNlpXSEz+gStTKWelOR1k87ZvvEzsaFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHnFmrn0; arc=pass smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423f52af13so2635165b3a.2
        for <linux-sctp@vger.kernel.org>; Sun, 07 Jun 2026 16:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780875756; cv=none;
        d=google.com; s=arc-20240605;
        b=P1G27kzfObziv+qT/6W2mV5VlRz5mif1/GdI4eSNfxUuc4ecCoDVG2ogty/y+3Kh7n
         H7EJ1TSVBOGzRRFPTNY7wVl/G7K+KZxhpkJFDDb/hSD7QTTBM8n2PJL4ebpoB9bj87XN
         ieefrmi7sOvvRStYunCwt/i9PkGIYc0DWM6tyB+uqah97v6tn2hO/mCEsW+NhhgGlsnr
         hBiPQqKM83HN1ffDqD5x3fOI7crS7FBOsawZx7rm6kkGcBucEenF40eTI1mwLG6KsWP8
         G3s4PYtQArnYsvwzGA+EFfPDzqqXQBtgSa4fJmn7dAZJ0Le6wxm3DCpC8aZJBHjJwpIP
         xC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KYTypw3DJBd160Saxf9XWOyGcTF6fluXB93SvpCLjts=;
        fh=Z963M/mUgxrlhWEpD1+ILE6J5dww5/ncTJWd/SBQSIE=;
        b=at9qa64OvGHJwvAQBJzyX2mKx3EX+/1vthNIvVdfXSF8cO+AqgPQunbYKJ+rlsUgWi
         cyrMku47LvInZHGGHQfO7Cl8HQVcm38keWszyd2c8OIzTxU8nnaK+bWrGmbcdsYfR+Oy
         nv3ucd4XaGq3T/sV+lCTY6n7wJpfqPSJ3KjQOlBOxmOBa+pMqBVZ7Fjx1vhJJAb+OWz+
         H4lUjy7bhxGg0Xaa+9r8y2zS446wyZx53M0ponw8Vhh3vJrxBRaBKgpiWfmGd4EJYoE1
         3/UhfHB0BI3RUxVpfLgrKWwm/5HgsKJHniPH/3TdutNkkQEs3voqpfDg0z9HLN3MpqkV
         9hmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780875756; x=1781480556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYTypw3DJBd160Saxf9XWOyGcTF6fluXB93SvpCLjts=;
        b=hHnFmrn0HrwjCSGAVQM4NjBeVsasj59UZcj6ckqKorsJ8YMQV42uOvB1BtSiNZjVnO
         OLAo2EmS+R7FMlzvYW3I9vvrCyDN/KA9Y7SKy3B64WRe0S/RdMLNDB1nWsBAjqcvaxel
         5mS5W92TPLUFIltJEz+HdfPvXpWxs4Tc50f1KDFV5rWQu10IVR0SgPQHbr51tHQWvNaU
         ErA0kyMk/Isl1bJODAmUpkqU9KR8YG/shmwJYFFRtD1oWKnGONAA4kuy4Gy2v7XrXGzT
         oDRkls6tt7jjjhO8rG2fCotsNiN+Wlsnnng36f+DLXdRJxbXEZ7sRt78RaYLHGhs06TQ
         JISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780875756; x=1781480556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KYTypw3DJBd160Saxf9XWOyGcTF6fluXB93SvpCLjts=;
        b=HoUzJ76GufzMJbQO+OukmSejj2qfztCo9rqL4SWMO4JqOnTJISkJtx+uKo/1qSnF5d
         DJLBY8NTzlufSmxskXolmzeTtVdvdTGG2gsMuLyc48g0ySdyOpIESyC/p0FUzbCxT5iz
         YtDCvP7ibrmC+NH8+W0pyNomffIlIpSvUfU0tcu5MZhT32sYA6FcBLrO2/MmyWjW+gZN
         4e2pk0llIOwZCRGfbAeqlgdC6QGG5qeRxdUGaceuH4x2K8EI/ZKuRbj2OdBpSdNWT5Iz
         6JOCPefMighQP3+pEdRFKyNJ3CtLO0l+nqUEAOjmABJOj/zBaqABWdxzMK6hJ0P8UsI9
         taZA==
X-Forwarded-Encrypted: i=1; AFNElJ/ikrmgVVDQ9edFiE4YHwWSVErXbXsSL+8M22iCyFkIkVh2OLgYBO5iYLSKgBCQMYEWLgB5nviixYt3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2OLbil/srjO5dYES/0UU5KYiERxwbiRf8SKJ/vEZ53aAzyqdH
	am6VY9xjfwSzxTO+WJ58bV8znvx6acM0hb/CXvPMgNIZ6nWB6FThK6gRDOyqf2RWzevXMcjb1QS
	Z/a5FhgyOCw7UudiagKVOd6FE167hu1c=
X-Gm-Gg: Acq92OF9VbY28sdH30cRoKji4GK07/LJJNZZWxJdfbEotJ480glivrd/kAbgOWzF+aL
	3CN7FDArmUs20kOiSO9/ylzaxjOqjviFdHNUo10+SkIDmrfSE0G08cdx0nQwW3mOyd+t3D+jbVk
	G/1n3z+q0SxBknQnfbExEzH2wihxgYSqsB/XpjjvYYJgYAqsR5cc0ObzYVdO+/e+VraS6iaJXfj
	B+YxZeh1GA4/sMdRzI5lb33aQjq4B+rmV/6lCFqf6/b17pLSAY2kQ169x5unRTRpfFLdBbqmmDC
	5JceoQE5iQF5QZdZMlOjk5rShAoDx3xjczt5Uil/BV6xC7c9sOiu08s8DFnhc/Mop3Qx9jxuE8Y
	nBVlBtjgz29jzTaqVlg==
X-Received: by 2002:a05:6a00:4c0a:b0:842:708f:39a6 with SMTP id
 d2e1a72fcca58-842b0e1e208mr12893143b3a.10.1780875756515; Sun, 07 Jun 2026
 16:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606183821.1688525-1-michael.bommarito@gmail.com>
In-Reply-To: <20260606183821.1688525-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 7 Jun 2026 19:42:25 -0400
X-Gm-Features: AVVi8CfTsnPopiWzGHgbpLRDeCqCWt8x_k1kMT630iuL1r90uRL4m9fVlh133fM
Message-ID: <CADvbK_fn=t8+8cg5hCRUKrO_dF+-ikrzsSPmzgaeMT83jB_T-g@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1243-lists,linux-sctp=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAD3E651EB8

On Sat, Jun 6, 2026 at 2:39=E2=80=AFPM Michael Bommarito
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
> v2:
> - Regenerate from net/main so the patch has index lines and applies
>   cleanly (Xin Long).
> - Use unsigned int for the decoded length and compare it against the
>   remaining parameter space after the ADDIP header (David Laight).
> v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommarit=
o@gmail.com/
>
>  net/sctp/input.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index e119e460ccde0..c63d42500aa28 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -1197,13 +1197,26 @@ static struct sctp_association *__sctp_rcv_asconf=
_lookup(
>         struct sctp_af *af;
>         union sctp_addr_param *param;
>         union sctp_addr paddr;
> +       unsigned int param_space;
> +       unsigned int plen;
>
>         if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_para=
mhdr))
>                 return NULL;
>
> +       param_space =3D ntohs(ch->length) - sizeof(*asconf);
> +
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
> +       plen =3D ntohs(param->p.length);
> +       if (plen < sizeof(struct sctp_paramhdr) || plen > param_space)
> +               return NULL;
> +
I think we don't really need to check plen < sizeof(struct sctp_paramhdr).
This check is to ensure param->p.length can be safely accessed, but it's
already guaranteed by the early check:

if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_paramhdr))

I think you can just simplify your patch to:

if (ntohs(param->p.length) > ntohs(ch->length) - sizeof(*asconf))
        return NULL;

Also note  ntohs(param->p.length) < sizeof(struct sctp_paramhdr) will be
caught by af->from_addr_param(sctp_v4/v6_from_addr_param) and return NULL.

Thanks.

>         af =3D sctp_get_af_specific(param_type2af(param->p.type));
>         if (unlikely(!af))
>                 return NULL;
> --
> 2.53.0

