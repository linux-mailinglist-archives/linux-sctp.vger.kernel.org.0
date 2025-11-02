Return-Path: <linux-sctp+bounces-731-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D565C29159
	for <lists+linux-sctp@lfdr.de>; Sun, 02 Nov 2025 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBF944E686E
	for <lists+linux-sctp@lfdr.de>; Sun,  2 Nov 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90021146C;
	Sun,  2 Nov 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQf9zryt"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46C13635E
	for <linux-sctp@vger.kernel.org>; Sun,  2 Nov 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762098677; cv=none; b=D1HMFTuFUP6muVXf28iE798vYZvpaL6aQexpYYMXZ8r9IS/RyVol/j+gQIXOax0wgmHJFzN2jzqFFX7k6NLZYaxiiHhUvdUhcrLWqahJVkmLicBdMwrH7Hbs2ESVFxlISVrWG4xP5yc7l7gUxP3krRjkLWIqxKfMPfrsOjsLku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762098677; c=relaxed/simple;
	bh=IVGRhEx6SwwcuiB/43BUyx3KBlWNJ/Z9V62kRKtkTWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTqYAouLQytYn6j5oUgtuIdarykI+FJC+3SN7FtprWj/+MvOJjTUO+cTvZHYdrSHyeYBGlvWwcCtlrPcm4swEV5mXdKoCew6cDO+6YWzsnG7uDqKM2w5apZYvJ1s5Rj0i9TKALxJ5YobScOVDFGYsRHYzuL99t2IEu7qbJQDPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQf9zryt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34029c5beabso3328966a91.1
        for <linux-sctp@vger.kernel.org>; Sun, 02 Nov 2025 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762098675; x=1762703475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8zabFFXO/kK05h5IRuopTuEr8QgfbyLWlJrEPONgeY=;
        b=VQf9zrytheMhxs5YMPKkJdiLX1HAcVEvvMLEaqi1y4ix0raiW5BBki5mdeHWMTBaG2
         5kKdbiEKBw6fUP8n0euuwvs2ukubvZO4ZHYrc4TSTqOid6X5TQVfCSTMLaU8l42fDuRS
         h1w59tpgsMJBSwff1LbdKkI+USEoYRP7WXnKuumYDvyewtrhbFJRNaw8GhI33si5dqzt
         HZ67jLhNwEXkGZxrW0KZ11fe1T6QB6hNk34r3Mg1lOb+fg8EqatHxcqu1jyq3nG+raQB
         J+OPQbkCewc3jylay35DVrfIkP10k9JJvxRXmczhR6DnnVPdHUblSSIYeVH8YnRgSCcv
         7+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762098675; x=1762703475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8zabFFXO/kK05h5IRuopTuEr8QgfbyLWlJrEPONgeY=;
        b=g6PeKZQfy8l3azWvr67xxvOFYX1cbeFAYQxvWCG6PILAiKIJ8vDivmyhenq3KnisQD
         E2dqfVoSWOwGaUhGZLxBgXzlbbOfpN17JbTUTxYs6SpMcwFU6nwVSnOdIMMZtHLjDp5F
         rBTuqBTpaV4hO/r58xi45g7GSNPN4k0lyCZosKPrpQ215t7GRKpakKZVkIeiPSdIMY4m
         U3UhXfMd51IdldJ+juufkV8gPM83unB8ixzQWc/9i55fPv/lED/+Yj5hy+sQe0ItUyjW
         xXSaBmAgiNjo/I4nBEHump+tR2LEeEALTir9/0EWdz++CQoA4O19AIrd8SkIhBje6gd/
         9GzA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Q7vzPoiUBUcXIq+uQwOoeu294zRv6FuV4mkPGh7AT0x2NzGTLQBh0EpGiZVeVhXTVPOQcvnW/CzK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx21IMKkpVjjfMQy6gSnP6OinuYAiaiZmQEJsDG7ve1GOjw03V4
	jZIdlyGm+2BF4/eX/NAEmzQ85N5B5p1qia7szjeoU+eSLTB1VCjbHjS7sQfrYMsIuRFzbZP1zlc
	s8WHlzhoxCqn1U+Fj0wrOkehP34I3XY8=
X-Gm-Gg: ASbGncveeRq70K3Ctq3kObISmancEm7BY3nQ+EW9w1rhiAeqFxE37aj3HoiG18QydgP
	p2V6njRvFwxRj0sw9jO9nYmIfJfLENq5PlE/H34OC9fjUYZ2TTAweAlThejP6cLGltnXcU3bV4Z
	A/Ni0kPMwIdBEH+I6zqIWKImyQZ0LdEQIv0eGOfS3hvD1o5vniyliS5oI7tXJawmw8tokEOTU97
	9hxjIgdlyt7bfbnbMVgHjvY+CPHnwc5aDTkrBlithxR91JxXfs3Iut7786aDQHwGAs2ul2WYw==
X-Google-Smtp-Source: AGHT+IFTwYjObHjVACXx+yKhmx3nHerpwqmx/UegK6/vDIN0wNRsze92crbnrrslfRfu6uaTLgeVSRptXrdqwClZN5M=
X-Received: by 2002:a17:90b:2e07:b0:341:194:5e71 with SMTP id
 98e67ed59e1d1-34101945f39mr2615733a91.29.1762098675493; Sun, 02 Nov 2025
 07:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101163656.585550-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251101163656.585550-1-hehuiwen@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 2 Nov 2025 10:51:04 -0500
X-Gm-Features: AWmQ_bmS4T2uL37JePpWdJiTenPBPVlMVaI2XJrFASO8Jy7GhhDEL4pW3BmfvMc
Message-ID: <CADvbK_cUA1TR2+=-k8iUu=y6rxEj7Qn+EcvRzKy7xkAhGrE6Ww@mail.gmail.com>
Subject: Re: [PATCH] sctp: make sctp_transport_init() void
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:37=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wro=
te:
>
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
>  net/sctp/transport.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> index 4d258a6e8033..97da92390aa7 100644
> --- a/net/sctp/transport.c
> +++ b/net/sctp/transport.c
> @@ -37,10 +37,10 @@
>  /* 1st Level Abstractions.  */
>
>  /* Initialize a new transport from provided memory.  */
> -static struct sctp_transport *sctp_transport_init(struct net *net,
> -                                                 struct sctp_transport *=
peer,
> -                                                 const union sctp_addr *=
addr,
> -                                                 gfp_t gfp)
> +static void sctp_transport_init(struct net *net,
> +                               struct sctp_transport *peer,
> +                               const union sctp_addr *addr,
> +                               gfp_t gfp)
>  {
>         /* Copy in the address.  */
>         peer->af_specific =3D sctp_get_af_specific(addr->sa.sa_family);
> @@ -83,8 +83,6 @@ static struct sctp_transport *sctp_transport_init(struc=
t net *net,
>         get_random_bytes(&peer->hb_nonce, sizeof(peer->hb_nonce));
>
>         refcount_set(&peer->refcnt, 1);
> -
> -       return peer;
>  }
>
>  /* Allocate and initialize a new transport.  */
> @@ -98,16 +96,12 @@ struct sctp_transport *sctp_transport_new(struct net =
*net,
>         if (!transport)
>                 goto fail;
I think you can return NULL; here, and delete the 'fail:' path below now.

Thanks.
>
> -       if (!sctp_transport_init(net, transport, addr, gfp))
> -               goto fail_init;
> +       sctp_transport_init(net, transport, addr, gfp);
>
>         SCTP_DBG_OBJCNT_INC(transport);
>
>         return transport;
>
> -fail_init:
> -       kfree(transport);
> -
>  fail:
>         return NULL;
>  }
> --
> 2.25.1
>

