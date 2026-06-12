Return-Path: <linux-sctp+bounces-1256-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UVCWAToRLGo3KwQAu9opvQ
	(envelope-from <linux-sctp+bounces-1256-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 16:01:30 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A167A094
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 16:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Uvzkse3t;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1256-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1256-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0763036744
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Jun 2026 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8A54723;
	Fri, 12 Jun 2026 13:58:19 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0E37883D
	for <linux-sctp@vger.kernel.org>; Fri, 12 Jun 2026 13:58:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272699; cv=pass; b=ZK9UkbqquSJjhfOF1XFUz0EYgpzJVb7pIM8o61H/eucZgtYGcW6jd4QfYVdRAWsrebW2OezIRWikbPrplhD5sDo9MH0vmWxEor+W4om3d0XOnxt4dcMycDi61XpWb8lJPmvkb/uIuYG3B6HJUsQSFBRrrqws1BRqdVFteEFbqrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272699; c=relaxed/simple;
	bh=7nkmyuk+mVPRHuMjba29kjsd8mvWEce3DORmTPAygTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhwTFYAOun5BgYu3DdB3MrX6Q1yPKUNDWHHm1IUFEifNjtgQHZ/33pyQ9iTBPMJ8gIgIwjECApfhpYG6fGOoxUQvVPPNo3waVY0gSxiPM7nG0J9GebjrEaxENjGzfP0mc6UhCZ0MJMds18lkhz7OEsj99v2LlBT6bCujer6/qkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvzkse3t; arc=pass smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842273a2c4dso726263b3a.3
        for <linux-sctp@vger.kernel.org>; Fri, 12 Jun 2026 06:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781272695; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7NHWjBBrXKxuUeOmMq01j23qQ+ahwLJ8/E8u/RPf5eY+rG121ocplqJYRGOhEeXUh
         lk7X/neLS4YrNPbFIFP9TKZ20HGkFGT9dgMbtFeFv3HmodDA9IGxPsTQv4uklWYrBqrd
         MmKC4tbSzWxH0tDvOQ+qLa4NiknNldE192/g7Gx6lVQWX9Aq0WskdoYjXbM8P9DKILZu
         79RTObxF5cBFUqGz+jrVix/oWlTZnsx4L8QEhqbHXkuUU9NuZA4iuIomNhp0Ybj3MZ8C
         fTeWdqxofQB97pdbKKk72/VKbwriJVFfeLKo7GbHibPBJfp8SwjmAKp/k3fOyb+kTmLh
         YibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        fh=RN64zlGyAcfr5v3bGLCs1XQwJJgTZgsToFLMt5BeXxY=;
        b=Bg0A0EGvy1/SfnMDSqdB9905TP8qydu1dbAgvZ9JyLtpJfdPxE4gFG7744zz/P9PIZ
         7roJU8N2NBn8POY6qrxLQ4RwBPLFMqKTTaE/pnLB489Gn8+Sz7g5Gp3H+mNcjY1NmAIX
         z9J3kLYm1SKr5AXipyVg++aHuJhJgRWiaW6Wzt+H+RISAwHVKA/MahnGwtMHl+tajDdT
         ffKMjePzCM3AHFqDr1vm5ZQ+78+MKHSGggqDbsa07s297SokQVpa1wwV5diCmwJaAAfW
         4C+OT1ZIxnwvEu/icVg6yi7cZI+h+i8zwluaKfyik2A4qFFw7q+T0+Arfy6LNhe2LBVd
         XL3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272695; x=1781877495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        b=Uvzkse3t6M4ckXfvjk3Dlo+4IHwe/pS0AIOu8/D+u+EsH6RRqbZK4F3nKFv14I28wv
         fOzP/Dz6vHuorsA61dOZmcxHvuJvsRKcD+Xz9wtEk/eON7HDutc/89yuaz9NQGiVbh0O
         cUpTyYdxv5ysumMmoIOmtcERqvU24+GH4qL0X1cyKY8oBJTbcCu2VpZuhauxdKa9KPta
         NQNF8SWIB72XYi/iErktdgmEucuKSCHk8hWn4edjStKc1SKiB194WIbGTS6LRS5PMlR7
         GA5uy1f8H5FVasaUoC+HpGSbQuIacUqk95e8echa8+OREBWN6aa+N/HTMoKdXYoZ8vnT
         fDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272695; x=1781877495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        b=cvocNdi/Fu8HoQCwq2BxlRQixf7/eLQL+wBH1K+N8FmxlfjZI8r3fmkdWeV2J26ygQ
         iLJ2HfONdEJ+uq0nratdhSD/s4idAlwKuC6LveCi+LRRNCsn0pjwA/gWXEVsVAqFl+wR
         hR0Idb83ITdIiAOKOiqkflTxGJHF0vp2g/bf+WHAUB2nQd567LtIoGl0HG5PKjyWQBAn
         IJ+GyEmbyh5NnvwbuVAMwxSUfefvv8WR+yXCzXXANiEQD82Yk4jRezTkrtm9gBe4A97S
         UxoN3Ci7eeG/lo0qtgj6hgVMP5WFwd5UMb+wxVgvxTAAZNN/DunL2oPTB81A2WLU+ftd
         0xBA==
X-Forwarded-Encrypted: i=1; AFNElJ/h0xh+WbHKuA0fe8sSBHhtzcCtOgnlX3BDY949mtSl1uCxWIN9VxRGb7iVU6W8hxCkLa+78oUlvXaj@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNFQKDZpPwuzkl7kWzA1yQGA423l06GCxF1/n8UiWOoCtRZ7J
	n8g1/AmgY27LIaltpC3Jyyu5SNKbKDME/FBmwdaz4B6/X3m7NeByrRCRQoeY4Vx2GhxW7liHR+0
	jTUFyJcmWxELW/Zq+MQDgdGF4Ngo00m8=
X-Gm-Gg: Acq92OFJpzsCOG6nyr9iuv+T5BKQt70HXB2N34pSVZaJWA7u8UvVIL9wVCFbwXw+FWz
	fHf2O0IKTdEPxPq2x9yi+yMmarBpfo/1CDNyDafp+FjOh6gfmbT9ZXm0I0K1wInZ/eK8CXbiTuQ
	M2A3+Z6er/laAHI5hkdrLPtUAK9/hkuHKyKoU6AgHxiwzRDyhuERv1gJ6MALQvf9XwQVr4YJhwg
	BrOFh3xotIocZx0PWGJoIkg9qhR8BikA86Xc6u5OaZ7kzZ3OlsFa2LExNFfJzwy3bcggnnSBRDT
	9RB4ljYqNwhy52VlGDEvUk8bIQ7WFcEjoSfq/PNjBkJQoyoww7SEvdSRxEvDZ73ObX7bWI2CyzO
	oSbRR5BjL8Q2d9J49
X-Received: by 2002:a05:6a00:1884:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-8434cc0b172mr3363582b3a.13.1781272694689; Fri, 12 Jun 2026
 06:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012530.7889-1-vulab@iscas.ac.cn>
In-Reply-To: <20260612012530.7889-1-vulab@iscas.ac.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 09:58:03 -0400
X-Gm-Features: AVVi8CdGRRqHLxpu5pXSGqJ6sSUoP3MuudWkexvLo07GnoDx744Nx0AV02fwFSE
Message-ID: <CADvbK_fTdr7rtwK7jgO8wveVptnAK=JhBr_L+d7NaDv-6td6DQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: auth: fix inconsistent key release in
 sctp_auth_set_key error path
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-1256-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[iscas.ac.cn:query timed out];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D6A167A094

On Thu, Jun 11, 2026 at 9:25=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> When sctp_auth_create_key() fails in sctp_auth_set_key(), the newly
> allocated shared key was freed via kfree() instead of the proper
> refcount-aware helper sctp_auth_shkey_release(). While both are
> functionally equivalent in this specific error path (cur_key->key is
> NULL, refcnt is 1, and the key is not yet shared), using kfree()
> bypasses the refcount abstraction and creates a latent bug if the
> code is later reordered (e.g. cur_key->key set before the allocation
> check). All other error and success paths in this function correctly
> use sctp_auth_shkey_release().
>
> Cc: stable@vger.kernel.org
> Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/sctp/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f50..84708f87392f 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -753,7 +753,7 @@ int sctp_auth_set_key(struct sctp_endpoint *ep,
>         /* Create a new key data based on the info passed in */
>         key =3D sctp_auth_create_key(auth_key->sca_keylength, GFP_KERNEL)=
;
>         if (!key) {
> -               kfree(cur_key);
> +               sctp_auth_shkey_release(cur_key);
>                 return -ENOMEM;
>         }
>
> --
> 2.50.1 (Apple Git-155)
>
This is more of a defensive programming change, so please target it to
net-next and may drop the =E2=80=9CFixes=E2=80=9D tag.

Thanks.

