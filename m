Return-Path: <linux-sctp+bounces-614-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E6BB2AFA7
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 19:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59513B42F0
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEF3320CCE;
	Mon, 18 Aug 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGgciPgN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89042773E8;
	Mon, 18 Aug 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538939; cv=none; b=aDH46+urrW7q7eIe6p93W0pDvFCqqwjY5AKLnzvRE7/xgZa+TOdazqWvTu1xLppO6PK+SvRn4BNIVsR/dmZOzJC8koA/oZVq6+wUUfBduKiG9ImPUGAYt9izSTWteXctGDVrYrlkB9uOeCM8adVftipC+8/jd6iPEsYMgIa6pcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538939; c=relaxed/simple;
	bh=RrvDux+Lx/XTZFwTOGzjvmyW/h6xwQh+7vPyz1hA90I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt58eojt1O+3N2mTYbQaS0eeXJV4m334fUqWkVMDLgB7PpjlTz+xI4ZoFMjKKMfVJJDmssM+82P/gtgCsGr6r04aOoTrOm6pSM0GuAzw9TrrB/+q4MDopCf/kmzaPypcu9D/4E3T66F8c05Fprb/n/XSUOUDSGTw5MrsALPhM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGgciPgN; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-884328c9473so54464139f.0;
        Mon, 18 Aug 2025 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755538936; x=1756143736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVtLrlXMr05QoNhGVNAMFq2WN3EtCUqtvxnx/TDgHKw=;
        b=MGgciPgNPv9kB0Hj1EoUDLzsZFW7dJm9/jBCh7ERaix9jrhJ4ql0SrzKIYdLAV/QNo
         Qo6AebH8cAIXEPC5LOvwgU39w5uMH+UyQD2QQWOEeoHqUozLCSCK08W4GupN6I5e7tfm
         y6yQs3p01Gj/QE7mQs834+kwa9Q/PWYNJtFv6ga0FKBsWt5TkZsHV7ngxrx+EshTdcM0
         5DQ0ut3WG2+IgKfRpPJ2uW74CpVhCaNUdhzGB3wd9b64fEzdh1pa3OB56ltn15N1nHp8
         h+P57Ec2iMZbTBuUeezNb6c0o59eu05RUgFrKEBmr5k4ZGueQkkG3jfsHYnbm0I/Tate
         G/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538936; x=1756143736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVtLrlXMr05QoNhGVNAMFq2WN3EtCUqtvxnx/TDgHKw=;
        b=m9jZyRe/gq/umC4Sgu2GKPh+r8iLM7saKl2ppJqZz2FKNEByIgLf9nLGoWCIBfbakf
         ZOO40HWvLcv9QjlekEFpLkCl+BARhWCISyZh0zEgYHKAj5L4QvVNpOhObvTxGiUj+A2j
         Xx895h7R3C5JYk6tqh/3AJ5bWxPlxz4KKr2S1smL0UTC04ovFExlrS4IPBTBNf86Kn2l
         4gSGcubvPtiZz/FYEktybLurhvhci7q4k0WIp++k8QAT5iyF3gt1fN7QkRzMlACKVqNQ
         gIEfinUkhjcQRmVkhgPTHGN/k3kqij/xr0QdGLrhPDdxMPUIySW5fAUm5rDG5Yl8FDPT
         oirA==
X-Forwarded-Encrypted: i=1; AJvYcCWdAc9YYf55YfqBI03bWBVe58DGiXnNbtEsCPkYmTKfYot3xNzwGahJKlSR8Ru5sLGBpBDvr9I5@vger.kernel.org, AJvYcCX/+VaOPEPcBjR4DGx0D3ZZ+Yy2/d4HmNK/WrgwZifzf4XdnU4PbkDijo/K3D4cWrCQa6OYd4QA5gPEfNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzm9KO1tNwCIqu35ukenu8BIACvAsNcqmQ13luDdosoK0G5Dq1
	sHXI9oGShnR7ESdp1toLHsLylwMtn/cPRdIZIA+BRvdiy2Js98haC+1r1dZC+guj4VRkSMdfbjg
	VrY8zj/mnOLb8izVP1WS0jE49Mi1IZVk=
X-Gm-Gg: ASbGnctn3r2xmdBFI8jFN8T0DmVS9dmVpazLIiqKMV05GGLb3uLhtGcK6e7qaF6Fyag
	HCYLpl307rAIIfDkU2BolquFvfaqexPreRGrfHjAAbebo6FzRl5b5ujYJ8pGEQ3FgdYbSG2fkYE
	nul3T4jdWSxlKJ80VUWdVilvERYiAg2JN/qmEFx5hG5RrMI12Zl31iBLAka6p5/98aTAQg6L/F1
	0WfM0730ySNneBWHGWx
X-Google-Smtp-Source: AGHT+IErxtt599bf1vSaG8tgEn9hx/UdjhH8RNUGA3QRxTj/dIAqWyiawi7o9QIa/1UDdVwUBrZbZo9bheov04VRF20=
X-Received: by 2002:a05:6602:3417:b0:881:886b:9bdd with SMTP id
 ca18e2360f4ac-8846667ac20mr75605039f.5.1755538935682; Mon, 18 Aug 2025
 10:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813040121.90609-1-ebiggers@kernel.org>
In-Reply-To: <20250813040121.90609-1-ebiggers@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 18 Aug 2025 13:42:04 -0400
X-Gm-Features: Ac12FXzuY3rqG20iHwnIVyWeOvXo7pZ4Wb8UMPOwftRSqCje7LiizkRNlN0boUE
Message-ID: <CADvbK_c+5SjTXx18evELOuKEVpnr3CpXAJ9H61LBYD4YbYo1mw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] sctp: Convert to use crypto lib, and
 upgrade cookie auth
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 12:03=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> This series converts SCTP chunk and cookie authentication to use the
> crypto library API instead of crypto_shash.  This is much simpler (the
> diffstat should speak for itself), and also faster too.  In addition,
> this series upgrades the cookie authentication to use HMAC-SHA256.
>
> I've tested that kernels with this series applied can continue to
> communicate using SCTP with older ones, in either direction, using any
> choice of None, HMAC-SHA1, or HMAC-SHA256 chunk authentication.
>
> Changed in v2:
> - Added patch which adds CONFIG_CRYPTO_SHA1 to some selftests configs
>
> Eric Biggers (3):
>   selftests: net: Explicitly enable CONFIG_CRYPTO_SHA1 for IPsec
>   sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk authentication
>   sctp: Convert cookie authentication to use HMAC-SHA256
>
>  Documentation/networking/ip-sysctl.rst       |  11 +-
>  include/net/netns/sctp.h                     |   4 +-
>  include/net/sctp/auth.h                      |  17 +-
>  include/net/sctp/constants.h                 |   9 +-
>  include/net/sctp/structs.h                   |  35 +---
>  net/sctp/Kconfig                             |  47 ++----
>  net/sctp/auth.c                              | 166 ++++---------------
>  net/sctp/chunk.c                             |   3 +-
>  net/sctp/endpointola.c                       |  23 +--
>  net/sctp/protocol.c                          |  11 +-
>  net/sctp/sm_make_chunk.c                     |  60 +++----
>  net/sctp/sm_statefuns.c                      |   2 +-
>  net/sctp/socket.c                            |  41 +----
>  net/sctp/sysctl.c                            |  51 +++---
>  tools/testing/selftests/net/config           |   1 +
>  tools/testing/selftests/net/netfilter/config |   1 +
>  16 files changed, 124 insertions(+), 358 deletions(-)
>
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> --
> 2.50.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>

