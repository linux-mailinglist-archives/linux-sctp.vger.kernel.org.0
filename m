Return-Path: <linux-sctp+bounces-378-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF23A5E05F
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Mar 2025 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84263A8B90
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Mar 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122617E00E;
	Wed, 12 Mar 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjXIm20"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA722318;
	Wed, 12 Mar 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793467; cv=none; b=sXa8zYnQvxNVQVNRQaxGwExcGhdwNwiD88RdCXFwB9Yl7kXRx7EpeR4TAYDcQFKABp3i18JLC30FsYOtZe+X7sou/Uaqjs9t/8pvLBKB2dGF32gnL62v4bg7UbbwqX8pHze2+cL8D3nQL9Tir4cZugQWZI63Fx0UZ2ZwPenqbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793467; c=relaxed/simple;
	bh=C119CQDqhlIZjEkrI1QNxjzCi8Vs5dPxeF4pdolefqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEWXHLryYGLZndvvu/f42v8schsEvuwbY4nwBQ1omqXOhwbmh7dCLMLxxROj5fTI34YdDO4MDd9LGuKU6E/QiufZiIwTbCDhIoKIgTIwjl0JsmheFYx18ZzG+Vy+ADjYDA/q2IFxa3dA7PhAfAV3yFrogM9iK5Ct48sOV7iNL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFjXIm20; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b4277d0fbso109546939f.0;
        Wed, 12 Mar 2025 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793465; x=1742398265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgr4+5cGFZYrVuh3qsM5dC0EureuWz9Kwi+t1hlD0DA=;
        b=LFjXIm20blIgrEP21vOGaK9OMMW2cMaufNmDUkJ4Vw2GVL7QEbNoEUw7DE8o6cW8A4
         cYaPhLKQfPG18UzC7HYg/0e0LmzVQyMSzBpiRnSWkixhIcTvtLzFBD7k/463L2usmKEH
         IkRDjn6Q3QXpoJVWrEYf0kiKZ2qWSyHqVnCJQyDKfwVyXZNhmpDqSXIVGJjCgfzl8sCF
         HVCvjPa85D4CNrSHEiYTg43ByCSuL5G9iSx3YjIFox6gsqQLBbwK4CSpm2rxBNHXn8xz
         gRJIOqNWxK0kDUDhxOxqEXxOHQp8gqBDvDvcDUN9fyns2OgXWm+D/rnuowjFtl5vNr+1
         lahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793465; x=1742398265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgr4+5cGFZYrVuh3qsM5dC0EureuWz9Kwi+t1hlD0DA=;
        b=YETV9mcUXw2TRLkpfKukywyoSDwWngtcqQ+2Q/c7ziU630iG0tUmvMo6EPhs9sgHwm
         f1yhQX2HDS2mRqeDRaYiPOXFzQRR1RShDfluoeo/X274VUKmrhl+GBckeV/ey+qn8a99
         0R/qYawSRGNJutEfzMPpX17fLFQKfIe2pfSqWNd8npHRUENBeoiwQtVyXFFT18xbps4V
         EtRzT8q2WzQsU4WylSyG4zgdAZ1mRPdkwIWu1B4zZ8JQMn7PXE78eg2SD1Ni7v9+eNkv
         4zPKivP9EH7342pGX8tj+Skbg6BTpdalrKT4SV/4VSj/gTiKp97QNn1h+//wLBsOuCZP
         fZNw==
X-Forwarded-Encrypted: i=1; AJvYcCU1gGhXbDuL7ctXur0wxOfImjKaGqbmQPGEXOQKm/4YY7dF86S/HAIsMHz5Gq54H8qNh6LfADiw@vger.kernel.org, AJvYcCW+PW793UXrEug/SC7gTCIZoGT5jK4ZGVd3lEbsf8l4QB2Z0rH6BYI7UdNjdGENKD65ch7luxsnuetcUr4=@vger.kernel.org, AJvYcCXbQSBJwF1o3uJ1hyRlVQ2qCGtUDFnpT1+pEjEx18BYOS2RUQbFyqhNSNY7qvMianrfdOoItDGRwmlM7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBg/YwsKSQksL6mnjR6VwnRnzfhPOLfXRxNJOn/AspILMbgcY
	EyGhOFKvFDCVhbX2oQb7Fm8v3cB0KNEAW3pne1BgPX+Xi+Eozj9kvK/AoWFMP+cS0eCRyDYkvlo
	rLRAv13PXSSr8HBNj/+vmYNI0c0c=
X-Gm-Gg: ASbGnctLeJPGAOD/QJppZhINpwWQaqk9/k6+cpIecIqRHYGhzJ5QdZV4pvqrbx1NZ49
	fzNNe/wO2R6KE18qoaOJAjxWwnuhc3RWo5W82Vb80U8K1FeVHBfK+W/ZGlHNfuzaeXV0L118ss0
	Cgwl7/CGTVLfJpnH2N8JcjsAmO
X-Google-Smtp-Source: AGHT+IH05VdG9uhB5qzxGMUOauQ8zCZYTwMLftZ7hCszIsRPrUJXx5u+KoUicgoN1yMuIKF5PRc3EGcPfJSwaVhGtZQ=
X-Received: by 2002:a92:cd8a:0:b0:3d3:e2a1:1f23 with SMTP id
 e9e14a558f8ab-3d441a46fa4mr213019825ab.20.1741793464622; Wed, 12 Mar 2025
 08:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312032146.674-1-vulab@iscas.ac.cn>
In-Reply-To: <20250312032146.674-1-vulab@iscas.ac.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 12 Mar 2025 11:30:53 -0400
X-Gm-Features: AQ5f1JqQDRy6IqWhTw6URh4LI4G4sVueGzVZbB0J1rjje3tObaYQ_VAvs5dHbcg
Message-ID: <CADvbK_dZVJktQexS+4y7XNJy8s3FPXz5w1duUe3R1OMwrkXp6g@mail.gmail.com>
Subject: Re: [PATCH] sctp: handle error of sctp_sf_heartbeat() in sctp_sf_do_asconf()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:22=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> In sctp_sf_do_asconf(), SCTP_DISPOSITION_NOMEM error code returned
> from sctp_sf_heartbeat() represent a failure of sent HEARTBEAT. The
> return value of sctp_sf_heartbeat() needs to be checked and propagates
> to caller function.

Returning this error to the caller will only result in the packet
being discarded, without reverting any changes already made in
sctp_sf_do_asconf().

Moreover, this error is not fatal. Instead, it serves as an
optimization to confirm the new destination as quickly as possible,
as introduced in:

commit 6af29ccc223b0feb6fc6112281c3fa3cdb1afddf
Author: Michio Honda <micchie@sfc.wide.ad.jp>
Date:   Thu Jun 16 17:14:34 2011 +0900

    sctp: Bundle HEAERTBEAT into ASCONF_ACK

Ignoring this error is entirely reasonable, especially considering
that running out of memory (nomem) is an unlikely scenario.

Thanks.

>
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/sctp/sm_statefuns.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index a0524ba8d787..89100546670a 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -3973,8 +3973,10 @@ enum sctp_disposition sctp_sf_do_asconf(struct net=
 *net,
>         asconf_ack->dest =3D chunk->source;
>         sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(asconf_ack))=
;
>         if (asoc->new_transport) {
> -               sctp_sf_heartbeat(ep, asoc, type, asoc->new_transport, co=
mmands);
> -               ((struct sctp_association *)asoc)->new_transport =3D NULL=
;
> +               if (SCTP_DISPOSITION_NOMEM =3D=3D sctp_sf_heartbeat(ep, a=
soc, type, asoc->new_transport, commands)) {
> +                       ((struct sctp_association *)asoc)->new_transport =
=3D NULL;
> +                       return SCTP_DISPOSITION_NOMEM;
> +               }
>         }
>
>         return SCTP_DISPOSITION_CONSUME;
> --
> 2.42.0.windows.2
>

