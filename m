Return-Path: <linux-sctp+bounces-1305-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EiJsJ5EZSGpZmQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1305-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 03 Jul 2026 22:20:33 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D4705778
	for <lists+linux-sctp@lfdr.de>; Fri, 03 Jul 2026 22:20:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O1VZSQ4m;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1305-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1305-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28ECD3006159
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Jul 2026 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0D30D416;
	Fri,  3 Jul 2026 20:20:29 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D683254A8
	for <linux-sctp@vger.kernel.org>; Fri,  3 Jul 2026 20:20:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110029; cv=pass; b=p8qy+R29JTDdGiU1OMzMwCOJoNrv3CD/MOKncFaqUF+9OB1FKj1TwuySKQcGuqVD9/kO8fOGKau5HrIL70BpmsGbp2HQJS+gZzwILvSP4gLMFrdQqc8955rDXlcX1DdtL4GEU31HCpC3WAALYfxYLtM7me4cfK+NrqU++Ggz5U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110029; c=relaxed/simple;
	bh=MZaSDZbIsGKPO5iamZxXJcXj5gxxHuIU5T5iRXZGMo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi7C2gApVFpcBXi3mrEaQRel+z0eKKw8GlZ5yL0mPpXIP5SLyJdAnQyvWm3Pr7Snvtwr9Gtk75cJW0WmscPPPVCiHEtE4L/PUSG/TijmRaFw4hIZ0/7z44XNjdSs0PMur8Iq+BzRlygO3e8Nhjid5I5gW83Ce4W5c2gzv903lQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1VZSQ4m; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845ea8924fdso949196b3a.0
        for <linux-sctp@vger.kernel.org>; Fri, 03 Jul 2026 13:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783110027; cv=none;
        d=google.com; s=arc-20260327;
        b=T1ZSQ7wKVF/J5l0QwBmCDxhL4ilgcyE/WdVtRCAb+Rzdi+KZesERaeZOWGeslapP4y
         7RrblOJJh1FucWL0qu8zIq3gyk9kLxUtZSjUCC4MFWhiWDhb9f56JGvENDGRvj2W8C57
         CnqqCqbBOw3D9fYrF55lszqoFhpiUo08s1FwSJg+ynYY6xFShrHB2CqKjssTwJsIn1LI
         Lvp1s68nZ8qhydbmTDvniBobWJCrGlOtmJVwTXTCqwIWHlunNV+psx8ghrp/tzSWbntG
         V/Wy+NT6FClaN9MDV6k08MGl8hdZPyMFGCvfj/1eO24tz36GMv80dIVxK6i9MxY5WX2h
         U8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBwO0HLXnTzvJ7ulzeXmj3dtZfisJSDVwZYhfGTddaQ=;
        fh=EVzO5E39GnFm18eOAGDmN+/+NPC11BW6ZJg8hahOs+s=;
        b=k+fhrBx4/i4v644O57uS+DlouA66bnLI16lYq0o4djm3lT/0ms8R43EuH8/Oc2wI9n
         pxtqcG55nJviBIKha3FvxujGRctp8rKYR1lHDAeRCFuUpVBREmC1OXdATyrlN80LBjOc
         XKTuwFEkAHYi8PLYvOfqgIuXl7cpkt/phi/ACRnPAr0IpdiRb0A/uQ7pSvobgK95aBI4
         wSyzkUGeBiQqSk78N6f2bKmS2hV1eO+tuXPJziLyr0iW9i9CJfFk1Tvg/fxRgl4lgv2q
         viryHJMbZmgm1D7FviNoH3AnS3QCEjo5nCZOA9aMCUKUNViizUWGOur7a1DmPmILzoRV
         prPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783110027; x=1783714827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBwO0HLXnTzvJ7ulzeXmj3dtZfisJSDVwZYhfGTddaQ=;
        b=O1VZSQ4miK4CwxFfA+3OCJLrkTPjUP4lCkkTp3GN7TAyVT4Xa6VOfx4CDaLGcOd2F6
         o1Q+8ZT08P2RNlxzSzxzJ+UvrVrsm9Lo1DeCoFW/AlxnCGV5hcs4uYF2WSWh41ZOk9Z2
         Jaes+Ka9C6v073gjQe0JDosgLCHSQeF/W0P5/vBStB9O5wxC6BnBhTC485KUk2BQDMVq
         8ngRjGMGwj6PZeD81130JhkvJKTFqLXxG4RwhAZoJXfDvz5uR0mEu9Q2DDDt18F0wMMj
         O1ou8+Hu0xDSNOpRvID9iip7+ZF4PeASrgeEQBOxxtEc+rEzBbAfBMxTMA6Bp6CH/Jb1
         +YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783110027; x=1783714827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBwO0HLXnTzvJ7ulzeXmj3dtZfisJSDVwZYhfGTddaQ=;
        b=E1GxisNP4Sp+b+7BkayxYvwieKAyrRfp3dInx5m/SEZElmACJeajiYrzRC11lGFYFp
         KA04r25Iy2CVIznmuYN5+Xedz1HdyLGLouKkxsbYE80XJSaCXtBgxQ+hF6sQajprGwZZ
         IkvNjKs3iN/pE0HPZPIcbn6LohCMp6l7PXMxRja7uRbiBny68EYH0Ioo0k21rJQUxl3M
         epbZ28suGkKrbPO/eShZUzIVF8D+UmRuam6ZNx9VXkd3v7FANFhoQIuk/KiChLd4HM70
         hfQ39cG5sVPcScUyfC7XhWmkkq6+EczZNsG+q4cPtAWoNVCYZpz85wvoNrnCQ3yOrFHB
         FMgA==
X-Gm-Message-State: AOJu0YwKEdEO5Ybk4HKCDLWsbkFydjPga3Zv8Z1vHhYTl1pXJUSbC3Me
	qr0tvnxqREC5R+XlGwIdLE3ktV7aBKh4iVuy1gUfnmdxZ4bow/lYMV/nSR7bSiwVWDGAJs4MkCx
	nGPry1vRBDRRuixF8Ve5siDrm5ixfGrE=
X-Gm-Gg: AfdE7cnddXjy2XBO+1xdLVL2fgFZoj2cd/n8P7IbGPDBW6xNsFBmxKZyzyd92qwjoU0
	F66O0xyjxAsib4biSBnxW6oPUlTt3CBcI0mgMJjfBPdkX0n52W7HYdKnMTD8i8iMTUcz9Bamlx4
	lafdsAV8npZejCjKlj6JEtUucdn8LfWFSMbSlXlLD/rk1mBILwvfWFaeLhCz1lxWhnNrZyOnaf6
	jzEQaRdtNsliIYms51dSdE2l1wGEDKxbM1REqaWkqQk/FbZHqIdqril3syUa1Buz7N2MEMLO766
	5R9C1Wl7PYu3ZZ+dz5lxQ8inudH9Rhx3WicOYCdnChPs5hZm0olLn9+t9yNrz2M4r4NvoNnwA9E
	yBgnvg6hb4n/uqOKTVzkC0dMmsvx5TQ==
X-Received: by 2002:a05:6a00:8d6:b0:847:997b:1182 with SMTP id
 d2e1a72fcca58-847f6fe98f9mr789555b3a.59.1783110026811; Fri, 03 Jul 2026
 13:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782798905.git.xizh2024@lzu.edu.cn> <e62943a59f5e1c7a68beddc1dbebe50a9a036c16.1782798905.git.xizh2024@lzu.edu.cn>
In-Reply-To: <e62943a59f5e1c7a68beddc1dbebe50a9a036c16.1782798905.git.xizh2024@lzu.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 3 Jul 2026 16:20:14 -0400
X-Gm-Features: AVVi8Cchq3Ik_ZvAHeFYTBg5iJ2SK4hiW8mxIoJVb97RzOxxGipeMSZfow_CVuc
Message-ID: <CADvbK_fsEC=dViaQMDVD4BQY_i=Yv=GHfyQdFkHxSVeannjjhg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sctp: fix AUTH HMAC list overflow into auth_chunks
To: Ren Wei <enjou1224z@gmail.com>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, vladislav.yasevich@hp.com, 
	yuantan098@gmail.com, dstsmallbird@foxmail.com, xizh2024@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:enjou1224z@gmail.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:xizh2024@lzu.edu.cn,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1305-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,hp.com,foxmail.com,lzu.edu.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C8D4705778

On Fri, Jul 3, 2026 at 3:19=E2=80=AFAM Ren Wei <enjou1224z@gmail.com> wrote=
:
>
> From: Zihan Xi <xizh2024@lzu.edu.cn>
>
> sctp_auth_ep_set_hmacs() may advertise a 12-byte HMAC-ALGO parameter when
> four identifiers are configured, but the association only stores ten byte=
s
> in c.auth_hmacs. sctp_association_init() copies the advertised length and
> overwrites the adjacent auth_chunks field, so sctp_auth_asoc_verify_hmac_=
id()
> accepts forged HMAC identifiers and sctp_auth_get_hmac() indexes past
> sctp_hmac_list.
>
> Clamp the stored parameter length to the association buffer, copy only th=
at
> many bytes when initializing an association, and reject out-of-range HMAC
> identifiers in sctp_auth_get_hmac().
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <dstsmallbird@foxmail.com>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/sctp/associola.c    | 10 +++++++---
>  net/sctp/auth.c         | 10 ++++++++--
>  net/sctp/sm_statefuns.c |  2 ++
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 62d3cc1558..760457def6 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -260,9 +260,13 @@ static struct sctp_association *sctp_association_ini=
t(
>         asoc->strreset_enable =3D ep->strreset_enable;
>
>         /* Save the hmacs and chunks list into this association */
> -       if (ep->auth_hmacs_list)
> -               memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list,
> -                       ntohs(ep->auth_hmacs_list->param_hdr.length));
> +       if (ep->auth_hmacs_list) {
> +               size_t hmac_len =3D min_t(size_t,
> +                               ntohs(ep->auth_hmacs_list->param_hdr.leng=
th),
> +                               sizeof(asoc->c.auth_hmacs));
> +
> +               memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list, hmac_len)=
;
> +       }
>         if (ep->auth_chunk_list)
>                 memcpy(asoc->c.auth_chunks, ep->auth_chunk_list,
>                         ntohs(ep->auth_chunk_list->param_hdr.length));
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f..4d14bd6185 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -447,6 +447,8 @@ struct sctp_shared_key *sctp_auth_get_shkey(
>
>  const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id)
>  {
> +       if (hmac_id >=3D SCTP_AUTH_NUM_HMACS)
> +               return NULL;
>         return &sctp_hmac_list[hmac_id];
>  }
>
> @@ -510,6 +512,9 @@ int sctp_auth_asoc_verify_hmac_id(const struct sctp_a=
ssociation *asoc,
>         hmacs =3D (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
>         n_elt =3D (ntohs(hmacs->param_hdr.length) -
>                  sizeof(struct sctp_paramhdr)) >> 1;
> +       n_elt =3D min_t(__u16, n_elt,
> +                     (sizeof(asoc->c.auth_hmacs) -
> +                      sizeof(struct sctp_paramhdr)) / sizeof(__u16));
>
>         return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id);
>  }
> @@ -708,8 +713,9 @@ int sctp_auth_ep_set_hmacs(struct sctp_endpoint *ep,
>                 ep->auth_hmacs_list->hmac_ids[i] =3D
>                                 htons(hmacs->shmac_idents[i]);
>         ep->auth_hmacs_list->param_hdr.length =3D
> -                       htons(sizeof(struct sctp_paramhdr) +
> -                       hmacs->shmac_num_idents * sizeof(__u16));
> +                       htons(min_t(__u16, sizeof(struct sctp_paramhdr) +
> +                                     hmacs->shmac_num_idents * sizeof(__=
u16),
> +                             SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2));
>         return 0;
>  }
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index d23d935e12..21cda509a0 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -4431,6 +4431,8 @@ static enum sctp_ierror sctp_sf_authenticate(
>         sig_len =3D ntohs(chunk->chunk_hdr->length) -
>                   sizeof(struct sctp_auth_chunk);
>         hmac =3D sctp_auth_get_hmac(ntohs(auth_hdr->hmac_id));
> +       if (!hmac)
> +               return SCTP_IERROR_AUTH_BAD_HMAC;
>         if (sig_len !=3D hmac->hmac_len)
>                 return SCTP_IERROR_PROTO_VIOLATION;
>
> --
> 2.43.0
I think real issue is the member:

  __u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2]

in  struct sctp_cookie.

It's supposed to include a 'struct struct sctp_paramhdr' + N * hmac_id.
However, sizeof(struct struct sctp_paramhdr) is 4 not 2, which causes
the overflow when copying it from ep to asoc.

The right fix should be:

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index affee44bd38e..cccc662561aa 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -312,7 +312,8 @@ struct sctp_cookie {

        __u8 auth_random[sizeof(struct sctp_paramhdr) +
                         SCTP_AUTH_RANDOM_LENGTH];
-       __u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2];
+       __u8 auth_hmacs[sizeof(struct sctp_paramhdr) +
+                       SCTP_AUTH_NUM_HMACS * sizeof(__u16)];
        __u8 auth_chunks[sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNK=
S];

        /* This is a shim for my peer's INIT packet, followed by

Please give it a try in your test env, Thanks.

