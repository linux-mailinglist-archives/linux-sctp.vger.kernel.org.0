Return-Path: <linux-sctp+bounces-328-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF5A2F3E4
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42F63A3393
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714D1F4632;
	Mon, 10 Feb 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFBtI9gU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC62580D8;
	Mon, 10 Feb 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205865; cv=none; b=TPOe3SJQFZ9PR3Pb8H6DeEegyKB0yPuqTmpYzj8jsufr45SI7HvQsh7gP/CYioQoh3yRl99CoTJ8nu0olspXqfOUAxrXu2SAnC4B9/rBE8GeOgii/li/1Acm9Nf0I/s/Dgd1zCK8F4qn30Wc4KAaxwTDs4366bn3pEmM6W6jAeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205865; c=relaxed/simple;
	bh=DLLNIR2LPPCobRYdsJqDnKKJwwcVg/3WpLPAPX9ibM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaC3ZxFybyfnn4K0+w/tFYI8UiV0CHSJCL2egzEASqT4Pj7k7QZAv+xI6nDXnx3TH3kx+8IXBdnvh7orcwTWI1POl/wsm1VHjrlq3hXC/oderxGOpcmfa/NEBLSwyZ+SyDyyKcFjWfIS5jc57fH0p9nceHYtH+v2b5y7w/Dp5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFBtI9gU; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so14326925ab.0;
        Mon, 10 Feb 2025 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739205862; x=1739810662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPpEY5RIO5eaVLxLgovJSjTf6ZwKjzUAU3yoX/8apS8=;
        b=KFBtI9gUJgdBnl280ek5wHlKZQVabD2at39GtPtL86dAvHt8qCCn2ABcwd5QXkm/Uq
         vhMpBDal3B3R+jU5hSbwPeDVyEJOSsO8U/UFtr4UPh5k6EQK/junRZj6sponspcA3dTS
         7fR/kJuZVDCczOd0Ndtwz1n5PIu3BH1VzRP1SSSN2JaCHQD7vHjvvNX6KBuvXAF5bimI
         RZz3POwPe2TxaWt+1YqqYIeVVGyrssgi5+TmMkhG6Ovncy87RoBo/EfvfrkYOf4h3yKx
         25acaefy6kmSbXegTkJMWjgQu+s9AyPhB0AIMZDQX/MvWOa10z0XxFMN/NMCn5pQsKKA
         n1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739205862; x=1739810662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPpEY5RIO5eaVLxLgovJSjTf6ZwKjzUAU3yoX/8apS8=;
        b=Dha8v5JOoEXtw0IHo6MZHmy5Y08l+dMb0dNxpQRJq+h+bm3w8GxqV8JzHWozgcoF4M
         Elto2VfA62lwBWKgbIkxUn8tfFvAoZ/C1R4R/PGJ0E2IuQ4sjAdjxixDSKA+H6uQB2c8
         tWHIf/FiyvO6U9G7GgWC879JBiiwBaLPasy8+mScLMbSc32o0NEzL39pfgLJk3xOX2lG
         ZhaFH0FUFG6uA284QwSiFlMekT5UCqMmqm2zGMfur7ziRtVMrTxYknD2vIXE4TbTtyoR
         brEceR9pEbzOV9tjz1RYtb1D/aVLiH+DuNB8mqn4hSftY+BIvuKIbpN+H855Clt2/Aq/
         D1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXQuY24/J/RsgewBwG1LAemCHfdzOS311YHwVk5EctuKVeQCrnL7kAOMiiyJV4TyIAl0VNceezE+rw5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qxz3gcOh9aspXFpFlqcBsy0hFD9HzBeEPf+6CT3emd+yAmg9
	IcmZma8Lmw0kOZSxVewbsJNQNL2sTCqe663odKb+ijp+Atm9rtvq3oEFPdV+Sjm2UcBjm+0k59W
	fCoEQjTeXU7EkH6W6YZuXsKfYiwA=
X-Gm-Gg: ASbGncvd6eHDlut3yBye+JgqMf6TcmfalA6F/u85Lck1qQ7iIDIYPWgJ3zSU6gixWn6
	yq7UOeLlvHuqstkq3tu0vuBvLs234yyZBmXW9RTAhHgEHviIwxKez0uSddnT/MMlCzN/ebJdY
X-Google-Smtp-Source: AGHT+IGVQrV0JzayK1BGapeStMdewIARXEY8Cj7kPvjvcA2Zs85eH3o2pbyXTbwh72+hbS9BvcKdDQwujbs+VhtLI6A=
X-Received: by 2002:a92:c243:0:b0:3d0:353a:c97e with SMTP id
 e9e14a558f8ab-3d13e2e3680mr98844235ab.10.1739205862500; Mon, 10 Feb 2025
 08:44:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
In-Reply-To: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Feb 2025 11:44:10 -0500
X-Gm-Features: AWEUYZkU1FH-8tzmzujlYTgDp447ZVRZH2rz5cE62oPHFUdXLFr-zHvabV2bvgc
Message-ID: <CADvbK_dtrrU1w6DNyy_OxizNwx_Nv=mjs5xESR+mB8U6=LKXdA@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev entry
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	thorsten.blum@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:25=E2=80=AFAM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> All SCTP patches are picked up by netdev maintainers. Two headers were
> missing to be listed there.
>
> Reported-by: Thorsten Blum <thorsten.blum@linux.dev>
> Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 873aa2cce4d7fd5fd31613edbf3d99faaf7810bd..34ff998079d4c4843336936e4=
7bd74c0e919012b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16509,6 +16509,7 @@ F:      include/linux/netdev*
>  F:     include/linux/netlink.h
>  F:     include/linux/netpoll.h
>  F:     include/linux/rtnetlink.h
> +F:     include/linux/sctp.h
>  F:     include/linux/seq_file_net.h
>  F:     include/linux/skbuff*
>  F:     include/net/
> @@ -16525,6 +16526,7 @@ F:      include/uapi/linux/netdev*
>  F:     include/uapi/linux/netlink.h
>  F:     include/uapi/linux/netlink_diag.h
>  F:     include/uapi/linux/rtnetlink.h
> +F:     include/uapi/linux/sctp.h
>  F:     lib/net_utils.c
>  F:     lib/random32.c
>  F:     net/

Checking some other subcomponents like: MPTCP, TIPC, OPENVSWITCH,
HANDSHAKE UPCALL ...

It seems that we should append:

  L:      netdev@vger.kernel.org

after:

  L:      linux-sctp@vger.kernel.org

in the section:

  SCTP PROTOCOL

