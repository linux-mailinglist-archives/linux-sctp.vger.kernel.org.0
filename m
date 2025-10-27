Return-Path: <linux-sctp+bounces-714-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FBAC0FCAF
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 18:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FFE3AF339
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73081314B80;
	Mon, 27 Oct 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nk/yeswB"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315B2C1587
	for <linux-sctp@vger.kernel.org>; Mon, 27 Oct 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587516; cv=none; b=X+Q7L92squUPSRRhvW6kjPU8jxbS+n2Aona/ehXi1/Jy4yGZPWUdQ7euXsmqT3O/4XJodOgAn/AjNtKBjFSS9vAHcjaAU81oivjsmPQGUou3WHP2fguhs5/0oLoKFiiB1Nj2kCI+MvQ9iQ5QiVxstgAsIy8R2Mop8JNn1FLHnfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587516; c=relaxed/simple;
	bh=Pg2jiCsm7MjJMHV2SEC6hKWPL2RUsUBkTbRD1RGwq2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCUtVf6w3/AwsM2MRwrhD4fYTjrtlqVffg1MmGtce+Boh36/VbBtRRx91KWK8raR8owm1lr5jTpAkD+8skTtqWpngVYc30Rm84F7qPZBf4EceGRjtQkjumL/H/9DIcC85XFBTWZ4WcjmBn97OBtz6dYX4qSTsLk1yL6dTTb0Gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nk/yeswB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26a0a694ea8so35480165ad.3
        for <linux-sctp@vger.kernel.org>; Mon, 27 Oct 2025 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761587514; x=1762192314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVq9+t2z/NnSc3zlKxkYc+qBrK62MLq4an44lN9h9dA=;
        b=nk/yeswBmTnxXounw3aPhlzYPwWh7NEIoJkopv4vycNcJ/xmOt2LFGfqLawqJHx2pA
         nFk3T80AS6XP0eqfEqzVk57olfM4/D0y4nWT8Tp3WweiKQ6MfigATYY+MaAzZSllnPbV
         iBoTOtYEChULfv21ZaKMzovhjvOUkDdk0l4wIbBiSgjfg+6mQSUBBSva1uUJnb1Fwbzk
         OqbK11U4H8zNZS5NVbenUxZq/8EPKVe943J7qwOu6Byr4zSF1PQeYKcZfpSxZVm/JrlI
         F9f0lWK/nXWxZzNUNKTWEGT5sSgkY0sa1K/jVgSthilLBxYE16yhbcFuFwi0XCNG8gWJ
         zk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587514; x=1762192314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVq9+t2z/NnSc3zlKxkYc+qBrK62MLq4an44lN9h9dA=;
        b=pem2NOD8Bl8i1pNbv40QxbkQtA6k0GgGRR01cq/bcA+knFOWy/FbxLtEwPvLOK8KXC
         Q7rItrhimM5Gnl0DGJdf8gfrZG5giKZcaN2VVLDnE3NdSbdsEICZxA1qCdZaLCxYl/lV
         A/1bczQVmbHqfjMUsa6qtQ/8IN+XayeUgl3PJtYx5LdWYLZvY/yv3N/BbnDX9ExS3Q/R
         Wl69IEUV0DM93tDn3rIcoe/VtSn5JG8Dx9zO3KrmP4XwzbXRMt/W+OdlerXjUD9hPcKk
         l6Gcl5z3mqOW4UvF3r6ZVa9SBv9Rlh67gRteIf808BpJcOd21UYJ2hmb4xdxCnEN6OU+
         DqHA==
X-Forwarded-Encrypted: i=1; AJvYcCUQRD4+z3OaGljHa8Z1E00WaLpQace0k1xZoSIJrlAf0thgrWRH3MMTNxq4MppBp3MAsFaJHwxU27sD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jtlXBbljikg0Bhvv30g+K5G9tXVeF3VqqFQyXXO9/ajqQGDA
	o9h92PlWgfqTkxHIF1wWxF7jb4W7Ib8UmGUKqZEyvdD41KNKr+cyT3l8NqfIGY/ZrlRq29TrLrF
	PEf96b4OIfC3DDxjkjBG8tx9Mrho07HqCaEYh1NgS
X-Gm-Gg: ASbGncvWJ0PwGHTYGCpfsp6bUHy0kR+msLyighPt8aCpE4/4P1yigQYifMYbbOqhRIV
	pkvIv5jWCAYq0Q3iro+G8Lk36rhn4xJ57P6GDePXvUy8vuNsoRWEaAein4yelukqj0sCq6OJgTA
	I4e73r6/X2KO1MArMvKk0YekEEzA21cCMF3+WyBl/LZdP3K62TV+nMYfDsVJ2qWbZcHMFOvG6WB
	g22RytOFeWrq8ir7N8od3hgpSvfUEAWJfVsme+qfj+5PnxLHIAabz005jGEg/C5M8xXV4e3qYXG
	61i7XPOSVbCaTqE=
X-Google-Smtp-Source: AGHT+IEgeUScsspPK8q8p9oorihY8OHMO9eGLp+b80KlldnZRcxNn7o3fr7kcpHMvGThxV1x5hS5JU0hjK137hWgArI=
X-Received: by 2002:a17:902:f681:b0:290:7803:9e8 with SMTP id
 d9443c01a7336-294cb5002d3mr8474465ad.48.1761587513938; Mon, 27 Oct 2025
 10:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 10:51:42 -0700
X-Gm-Features: AWmQ_bn9wyih5qWJDlxLaH23hKlmKl93Y9fku_GJoCm-usUlu6PJrInmbaQTXSk
Message-ID: <CAAVpQUAHHVUBQZ=fgCUe8Mg9CD6d=CutyEsE4m82TGdt+VqpNQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch.

On Mon, Oct 27, 2025 at 3:16=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Make sure not to exceed bounds in case the address list has grown
> between buffer allocation (time-of-check) and write (time-of-use).

Could you elaborate a bit more context here like which path
we don't hold lock_sock() as Xin confirmed in this thread ?

https://lore.kernel.org/netdev/CADvbK_ddE0oUPXijkFJbWF6tFTq5TntpFMzDWH+uV_k=
c+KB7VA@mail.gmail.com/

Also, it would be better to post the two patches as a series

git send-email --annotate --cover-letter --thread --no-chain-reply-to \
--subject-prefix "PATCH v3 net" \
--to ...


>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
> V1 -> V2: Add changelog and credit
> ---
>  net/sctp/diag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..4ee44e0111ae 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -85,6 +85,9 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff=
 *skb,
>                 memcpy(info, &laddr->a, sizeof(laddr->a));
>                 memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
>                 info +=3D addrlen;
> +
> +               if (!--addrcnt)
> +                       break;
>         }
>
>         return 0;
> --
> 2.51.0
>

