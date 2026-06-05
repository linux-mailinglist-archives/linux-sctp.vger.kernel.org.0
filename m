Return-Path: <linux-sctp+bounces-1239-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qzHFBZvxImo4fgEAu9opvQ
	(envelope-from <linux-sctp+bounces-1239-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 05 Jun 2026 17:56:11 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427264986A
	for <lists+linux-sctp@lfdr.de>; Fri, 05 Jun 2026 17:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EED1K7WV;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1239-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1239-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE627304B729
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Jun 2026 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731E3C73F6;
	Fri,  5 Jun 2026 15:44:51 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3C3B7B7A
	for <linux-sctp@vger.kernel.org>; Fri,  5 Jun 2026 15:44:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674291; cv=pass; b=Jzw0Y0SuLDTJHoxyzIaTLXame5tqxkMum7c8LsbENtzKzEaW+KuYEb7pp0GOW8/lVOzG17kuoHuAq+qzBp7+t/eXOWIPIfs9CJdGDbatR5Mn5k5P67NvLnMTcX0tFOqS8k2XT3lwUA+oBSDZibbV9hUHKrqdaizS33fSNUM+DDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674291; c=relaxed/simple;
	bh=SIGgm/L1alKIv4HN6O02Y8AvR/R4pzEs/XXPa+5prPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVMkSfYow96bO5l/9qGqdNBFRPlLAZCrc0q5F2gx0D0nX1kf0lcVBA9kMPFp856zBSwm/Uj5BnqA7A4mo3rA9DWiMve12PSj/NC4//gv5h2uSBPWGXiYtXzlYJEfJRCh6kTeQYDu7TR7kbgS1CZDFmlhQm6VYyXmAKhs9P15ORc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EED1K7WV; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8419ab3a297so901923b3a.2
        for <linux-sctp@vger.kernel.org>; Fri, 05 Jun 2026 08:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674289; cv=none;
        d=google.com; s=arc-20240605;
        b=jIs/ImV3I8MlwEk1iuicLJmOW1foZZKAtdqQ0RsTAaZuH7fT70Od9GaR+SCN1LwiHx
         ZKgb1VhLAsNMEpVL+hhfhwxdvV01ug9SEWrUV+DvkNgulXcTDipg5R5Jq7zPfPW8kSuf
         P0pkYkuBtNh3yeoLOUKq1LUPyyIaVhw8l/TMYZVj4+1ri0eUCCzzJSDTSdoB3iytqbHh
         wYG7amX+SNQ+JzSf/u3MMs+ioq0Fc9oFO5JVq0gUKO23UEeXsXJYA4IW3ZOMlP2lYOO6
         j4Z46oY8DoziN+dWeaOw30KjQjE84MshBZbGQMADgwZR0H/0VG2eBSaFsTXtIh8M7rrf
         MbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91XmWNp/2iuNXAgWrEcWczmYAUf6TIOw0lYEdA91tpA=;
        fh=m0m5reZUcoyUqtJ13kg8Ya3nFdyjOow4AlK0UfgDDlI=;
        b=Xh9qzjl2+ecORHtkZwH4BxJp06HgpVDLsQMZueo9NWbm0zoX8ce+M5hyuRh4KrZ8yr
         hEsZTLk5KOq1jdR4os6oExzSnEIevdf2oyFoum8DV/03zuZnJhodoJHbSsmSGF1nz7mL
         zK8IqP6ZISZEaGuEAIizoxhI8lJcXzO9bmsZQu3A/RxPmbj74pSX5sjCq1VdGmaI32yI
         UWZNVYwSRSOi29tNZz3b4kNrEOQtABLzJOxOHpl+dEV9JCAxYUzXe0IFDnXFoipmqZAx
         oM3hxkpZ2LjBmRQbePHjFTWVBrc1QFt7y4yjvuXt8zTvNv6BZh/zpaM34fAnAndmtvaS
         KzIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674289; x=1781279089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91XmWNp/2iuNXAgWrEcWczmYAUf6TIOw0lYEdA91tpA=;
        b=EED1K7WVmN65zfZ6kY3DmsF5XSMrrbruJRVL99TDp1ST9ei4VUudLzE/swtQGV+NeU
         71xRLn1qGon/1v9RYZthCFAFTXFHCLBG1m3wikzuZUkLYezyQE/45lnJgNP23CDK+/33
         oP4CQ8K08O6pG47DEAleQ1fGx/snmJEBdanUdAOugDyry3wTFjjUZKKbRWkSsXG09V/B
         OoA/V1IHXudq0SzCua4eJoBWUN+9FdMX/iPeAvz4p3KiTEotRDLmvLCQL73QvD7094KQ
         BNecaCWgMyomVNir5YoKK24OwY4+XzyHtietKgiuwoM7CQPfhc2VVcl33wfIFXuCNZQI
         nQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674289; x=1781279089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91XmWNp/2iuNXAgWrEcWczmYAUf6TIOw0lYEdA91tpA=;
        b=OXufON6BICR8lGtkwwnGMklZgKjroOCSaDxq9ww5BGSeqxTM9fOw3X9zup9j8vFOck
         cXOBtn6s+lmFsnaWD1+wJbZ8Zluxhn7W9qDK2rLViSqLocK/oiypitlP1/2z+iCUATHv
         oA7QbLV9xymHsV7Sn44A3nTNo6F0yH0FrBDyTSeN4nMwY0A6zryTJ6wx+EXjpAYK+ltv
         oK7xTfsPke8HF82Jl8N/qjTajuTlt64tyWlzMiQlQtOoBypvwKGoaPioCnha3x2XLXXV
         MHlNrNVNfMF7ydWYCaV/Kw071LwA72+qFPDmowaX+GvcMdVjVVWnq/lp+9iPI7rzUmk8
         tNkg==
X-Forwarded-Encrypted: i=1; AFNElJ/J0Xa2k9jgLNIHUb10aKLUhW4OSPsF8XpOoFlqnL6PWFQaRyZEub319Qh9qEJXN++ukeU8o50TRiDI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15OCKRcKg/Mo01/yFX8x57mM6dsC+0UKjnvavfI11l3CZxAOv
	8jkM3ccoCP4ul8HdPr95WLCmueH+Q4zwhIbSnykNtRWz+BwNe3PUJFfoEli+vAb3h7PXRdcC+cY
	3QxcnOg0oNI9xoVpflZA3EQO5nTR4t4Y=
X-Gm-Gg: Acq92OHO5STiUIhAR9Favizidp0ILSQqwT2RrKHCJ/k7GnsKAySe98qkcuC/Au7UW5W
	zZYStY9W2QDCpF7lWJgagnYbfHRD8MxdLnWIkH01Hd4Xf+N/P9oTspV2A+iyG0p4cAKJ0RRDJwr
	P3NMLM3ieoecoTWI47xcbtPwLf9B3YpXaLAmwS7sSm+5u38Aj6igPabr8bUlrI45kZhvuO+FmBC
	bQyX90OZ6A7Vk2bSSa+75ygtLJiY9ru8WchZ4np2/KD8hwezsNacQJGCOtLdlLnQxs46KX58kiw
	UhMFkLraD9zmlQNkYSF0bpay320vuJeRXyP1bkYCgx4kTtktmENvTgmzcmPLAyvPphTaao9OUVP
	vyY1pl1pGsqbhm5sso70O9H4sjRjB3UebIjIbX4JNxnO85fdBxg==
X-Received: by 2002:a05:6a00:9098:b0:842:8985:340 with SMTP id
 d2e1a72fcca58-842b0fa550fmr4179929b3a.35.1780674288619; Fri, 05 Jun 2026
 08:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604175803.2142975-1-michael.bommarito@gmail.com>
In-Reply-To: <20260604175803.2142975-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 5 Jun 2026 11:44:36 -0400
X-Gm-Features: AVVi8Cc57qodMTHcO3Ah7wF-7tLXcfiDwzWLYHPyJXuCdUMFogbSOhqiEe0qEc8
Message-ID: <CADvbK_eKM8qD6p141W1y0KsbTTm9bjRijg8ZnyyRbce7DBf9zg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1239-lists,linux-sctp=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0427264986A

On Thu, Jun 4, 2026 at 1:58=E2=80=AFPM Michael Bommarito
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
>  net/sctp/input.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -1196,6 +1196,7 @@ static struct sctp_association *__sctp_rcv_asconf_l=
ookup(
>         struct sctp_addip_chunk *asconf =3D (struct sctp_addip_chunk *)ch=
;
>         struct sctp_af *af;
>         union sctp_addr_param *param;
>         union sctp_addr paddr;
> +       __u16 plen;
>
>         if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_para=
mhdr))
>                 return NULL;
> @@ -1204,6 +1205,16 @@ static struct sctp_association *__sctp_rcv_asconf_=
lookup(
>         /* Skip over the ADDIP header and find the Address parameter */
>         param =3D (union sctp_addr_param *)(asconf + 1);
>
> +       /* The whole address parameter must lie within the chunk before
> +        * af->from_addr_param() reads the variable-length address; other=
wise a
> +        * truncated trailing ASCONF chunk lets it read uninitialized byt=
es past
> +        * the parameter.  Mirror the bound sctp_walk_params() applies on=
 the
> +        * INIT path.
> +        */
> +       plen =3D ntohs(param->p.length);
> +       if (plen < sizeof(struct sctp_paramhdr) ||
> +           (u8 *)param + plen > (u8 *)ch + ntohs(ch->length))
> +               return NULL;
> +
>         af =3D sctp_get_af_specific(param_type2af(param->p.type));
>         if (unlikely(!af))
>                 return NULL;

This patch can't be applied:

https://sashiko.dev/#/patchset/20260604175803.2142975-1-michael.bommarito%4=
0gmail.com

I cannot apply it on my local repo as well.

Please fix it.

Thanks.

