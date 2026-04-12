Return-Path: <linux-sctp+bounces-1172-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICtaLfjJ22nzGgkAu9opvQ
	(envelope-from <linux-sctp+bounces-1172-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 18:36:08 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A30EC3E4DD0
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 18:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 412FD300290D
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E1A231A21;
	Sun, 12 Apr 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIM+XRpq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323127082D
	for <linux-sctp@vger.kernel.org>; Sun, 12 Apr 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011761; cv=pass; b=hEI0MZdzVrj3ODUtI//1wB4bf0Yypt22eucWt8zIeeKjVxZjp77d9+wZxbfDVR9zpWu3vwpqrURM0sZzwvb4XT1gK9uzy31RchVxKj3bhfCVWXLgM8xp0n3vyT/5uUdDjKbeFVUwzAoKvtc/BfF8ijPrTcd34ikbmsvKCY0ARic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011761; c=relaxed/simple;
	bh=mIanxl7aSG5J8DWKMf6Ozl/HKq3UFkyMm+8iPvpP5ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVCYAnsVHGAHT20CgomYhKVvREx0Lr0zh8Y8jLzSgrQnVklZkN6srNHL6KKV+zsD2oQ0xolPWcH9ulx8arsVJIyU6A+5iYKNR1D/APPm4vq8mfyyRQgeNJnljk7rZZlqVfzLI+BIrns2YrSlMydcNb+6KETm+EwqiY/pmQVUhdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIM+XRpq; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1702507b3a.1
        for <linux-sctp@vger.kernel.org>; Sun, 12 Apr 2026 09:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776011759; cv=none;
        d=google.com; s=arc-20240605;
        b=Tc8YhG6hMET1zpY+fwoMyx3JpzKek5iHVsVRWD301n27p3e+uN0YkrJQ44jaKYc4tV
         sUsyNEKE2xDq2p+Pfo5TZ8EXqJBmbYQW90cVInlm623QCybFPegSmzWg5zswMdAPwhd+
         f9CZq9oMR2MgndUqgmqpdonpseRH0hgfPS55yAdd7dUiKsdLMGZu0bxdjchDuFYAuZxs
         DqNPeUFCiApTIswxYSt0mGmv8Cai4loSD+XazJcrW2Q+LQop50MCbpAtBo/5k71ToJsQ
         91uCiyfK+sJgeNIqnA7y4/SUzXytKSkskcAchTIWT4FU/qpoSPD/iCvEjJ3z0xutPCvE
         3o9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NQ9NvNayGMyZ+dVCnpodNX+JAbkBTvtmDGNN9xFuIxk=;
        fh=6UCbP4Mo560UVDnZ5bgTV9oF8WMxaShZ0qX3FWyRKeE=;
        b=PV/NPvjM5mAAB0JL6KMVdrVWIPS87SXANJHW5qG9YewMCz0K86256u3PnbzIv6H9Wk
         /ooepYUB+KOXCPHml3yGNT/6tIZcjabozTH3COTEM1zZYHK0PfxKEFHTcOcfJNmgU/ZH
         NkmkFZ992U+TIYNITRedlSuUP9TiZUgcHOHXgBYmqm5LqFW/9DMnWA9tFTOn7nx69aTM
         kE/YaD/Ob+LTo4ScwXJIxQcO44nArHWXunBtDmA0aTisO3A+7fW/befKa9kh/XQxVQg2
         IVLf66vV8IY5EMbmRmnH1tYzEuf6eT94hh7dFYUSs6BUZqd/Y/r/Ww/BVpZxiqPTfIYT
         eM2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776011759; x=1776616559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ9NvNayGMyZ+dVCnpodNX+JAbkBTvtmDGNN9xFuIxk=;
        b=fIM+XRpq69x2sa5xz3IGTfLDycnnBMu8PL6vj/QJmLOnXAHmLDykRiN9OlZbBwIIXa
         0QCWgsWYitDH7H6tmHAJ8yh70mYwvxQIHxB4tdy7C3XWv/w7N/P0VlLaT5PRbxu0mI+J
         crqrY8Y5FOb+0p6NAdmkhJAnM79VnLgN0LIqj9++TkBD7bTsvO0IsCYCwsNBNK6yBZ3Y
         ov/U99P6D9tDTG5zZpqjY5YiSgqeuZHteQnaV23UT4xDxcIx1be0AhNjXg3ZyjGhNREP
         MT/CMbRZwtOFJhPqJ8jozUDtRhQcVQYamwJCs/2A+SQoj2lpZ2r1mhZUc2j56LD2vXDl
         hyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776011759; x=1776616559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQ9NvNayGMyZ+dVCnpodNX+JAbkBTvtmDGNN9xFuIxk=;
        b=Cjl7YHE3CPrby4LP2SV/JapiLdAuq/7DctUk2TmIwcYgGJrVR/lgqiYrEIrHMOYSWt
         gwI9u6J3CxUvIidkIB4urNSiOWDiGr+pkJPnSBHc34RAB/vJEHAZYYE2CTjWbqIgD0DA
         fk0Od/6Fn1m3XcsUn+Xlne+3MZNQ1c0OPSU2A5PzBc5YCeIxTFTltf0FhBma3/iYZNMH
         px4S8N7QQOdqIjEM8VNRZFmLe3tMNubg+FU+GfJOSB2hj7/zJkxtNWByT5Yjl6uFyiI9
         xMGPJutLmWxIVtpCx6cKP/69RFJGtUAn4Bg+C4xNRnMl0xTcRyT7TG/9K4PZ5IRQvlEz
         Vb4g==
X-Forwarded-Encrypted: i=1; AFNElJ9GLwkpGGwh/UnrTi70lbEs3F1A8wdi9XBBd45je4szujq+OGevqCCtFK5muvBOf1HTyBmboifyj7h1@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGw/TFI+AUMEMfXXHBLBCpOTvurQ/eUsviyI3kmAO+0Acrj71
	Kmc1kbgpsDkeo3wCKrJYrxxtVdGsB5Fzve/M9UbVzkm1E+vTLpY38VGHhQSO6pzR0EaqrmpgO3t
	x9Jux/hmezCBJpU0u7t6KNMSISp8t8Aw=
X-Gm-Gg: AeBDiesfcxhXn2kMLucxmpv45h7KiZEpA4Mdqz8P0Xg+XewEMPbOLNHDw5gp9po29CR
	rWWHVKbjlAORY3c4HRmEY9a0bdOlBhzwY0pLg6p/RWAU6TUGP70IiW2oPldfE4JLCKAhNiC0VxC
	t+TFkAq5NauH+LxXXxvlmX2w8KjwaKrMtAUacqfdE66Vh7zq0j+UfO78WHXxW5/lv3DyPY2AKay
	6es069D/ZLkCFdu4GafRFFOiLBfyLe1PJiLyoOFwxhuJaLSoHMUHdYwXo3QoOUYmZ4kqx787u73
	yObfJc0x4/dt/O6KBCgJHtbrKruz1Pjece3oFPN0gVglTv2HWsp4hI92EdnpijldY2350ZPeXZP
	XeM32Mw==
X-Received: by 2002:a05:6a00:2a06:b0:829:7a62:6a with SMTP id
 d2e1a72fcca58-82f0d3530d0mr9367525b3a.22.1776011759466; Sun, 12 Apr 2026
 09:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775847557.git.lucien.xin@gmail.com> <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
 <adqsEmki7ppz9T1g@strlen.de>
In-Reply-To: <adqsEmki7ppz9T1g@strlen.de>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 12 Apr 2026 12:35:47 -0400
X-Gm-Features: AQROBzApleORXuHh2o6vMtozQ8NYBzR5LhVc2PGYSEkZSDGn2fRU2yAsiYhwJkg
Message-ID: <CADvbK_f1Cvqx0_-J1jGaT865eWiW2ZHsJT8EkN6kr21j88Y9kQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] netfilter: skip recording stale or retransmitted INIT
To: Florian Westphal <fw@strlen.de>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Yi Chen <yiche@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1172-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A30EC3E4DD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 4:16=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
>
> > diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf=
_conntrack_proto_sctp.c
> > index 645d2c43ebf7..7e10fa65cbdd 100644
> > --- a/net/netfilter/nf_conntrack_proto_sctp.c
> > +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> > @@ -466,9 +466,13 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
> >                       if (!ih)
> >                               goto out_unlock;
> >
> > -                     if (ct->proto.sctp.init[dir] && ct->proto.sctp.in=
it[!dir])
> > -                             ct->proto.sctp.init[!dir] =3D 0;
> > -                     ct->proto.sctp.init[dir] =3D 1;
> > +                     /* Do not record INIT matching peer vtag (stale o=
r retransmitted INIT). */
> > +                     if (old_state =3D=3D SCTP_CONNTRACK_NONE ||
> > +                         ct->proto.sctp.vtag[!dir] !=3D ih->init_tag) =
{
>
> Should    ct->proto.sctp.vtag[!dir] =3D=3D ih->init_tag case also
> set ignore =3D true?

It should for a stale INIT, but not for a retransmitted one. At this point,
though, we don't reliably distinguish between the two.

Also, as this patch only aims to prevent updating ct->proto.sctp.init[]
(introduced in 8e56b063c865) in this scenario, it=E2=80=99s safer to avoid
changing other behavior.

Thanks.

