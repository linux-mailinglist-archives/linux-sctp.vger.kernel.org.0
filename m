Return-Path: <linux-sctp+bounces-121-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3CE8B4ECE
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125F4B20A56
	for <lists+linux-sctp@lfdr.de>; Sun, 28 Apr 2024 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2118635;
	Sun, 28 Apr 2024 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIdA54SQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD98F59;
	Sun, 28 Apr 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714347199; cv=none; b=S9wEqZkRUgNERSo52v11FSRr9IwO8o0tbjV3r/qFlK7svYecy07fpCyuycp05t6l/FEuFqV1mTXKOrKWgBi5fmqQ+5eIVYdyJ+hRWsF6Uul9QubljJG+hO2m/UG2cO0fZ1cRrTuui669PJe686NXDQOWqOat9pLPSQUvGcRAo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714347199; c=relaxed/simple;
	bh=xDaba65KckNGBSBw/5AkYIu31Tz1T5W9rXAMjCi+Wyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMsl+3uZYjHfot8kyAawb5qQG5pPYCZeQ43XT/NlHyr9N+3tOIuh1odvrMJo8Uj4pz7SrH+qyCYVvqR03JAqI3aZIoMjNfUjfQlnzGMqEvfaaY2grEA/2tqoOJgq8Tf6s1AJLOGi+uppbnLmJQTFZyk8lMjqa/EH/oUFLE2iP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIdA54SQ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7decd9851dfso30234239f.3;
        Sun, 28 Apr 2024 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714347197; x=1714951997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctrf2NTRu/52wNcPKKuuzrfv0/JstMQrnj9zQHxr5yI=;
        b=VIdA54SQYLagKzpI1tW5MneGbuNCZYOzdcmoosBW4Ctom37oflgfop9u3B6L7kuUq5
         70lYiP3JAP/Tpaiksmw5uE56shJIkaucYJ/PK53ztJ8fiptW86gM/Sk+qEPuBMf6TiZR
         TmCWTb+4Qv7sV42UydImv7IhtnQR08VDEUVy42R5vyewUKcHG/LhTxgfLxN408zlL8Wu
         XOt08+dImLfW++QvDoT7XMYpzSbwEdQAPsf8vj/YQanSmEVBjGHi0ugGFO022HZdOIff
         QoU2SVBblUoLWdEe7Yt3amDLv2zOxD/KSScjogPiZD8liuc1KES7ZBPVZtqasJrXkPG7
         g8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714347197; x=1714951997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ctrf2NTRu/52wNcPKKuuzrfv0/JstMQrnj9zQHxr5yI=;
        b=urapqv+JcYnLG7ZtTAUR3OQXopp0SkiM2rK81oUE7b6dWMAMSYDXvTkjoW5C7nvGMD
         c8PfyqmxMPe4nzR+dzI5m37nLZim4/86K7UJS3HUgyhVG5q3nGEP7bOMZR0G2R1NrG/n
         DDsRiDICGtTVxNH4aEGfsLqvUiQ5WD0XYYSdGowCZva8ntA8n/1xnbq9NO352wW5R3VX
         0u7nw81EXsBsYB6Ca4t8kfJI9IRF4o4r7vyIt7R1qBxOKy4L/M9lAcTNNutRNUhI3WIs
         APK+XhsHIrPVhqmJKUsTlAo5WdDEuySqn/qjCzB8Fsdxn2nWT6gQTbpWEaXqeqIfKPmV
         7h4A==
X-Forwarded-Encrypted: i=1; AJvYcCWkLT/3PzdPd94B15HiXZK0XmqAygCSPY4X/7GeS1kg3UdGt3ywqy+h1GZbndlygan2wKagUAAAwv6zyGYPr1bJLx2Ga+/mOhLWo8n78wC0TWEGU1/howCsKSwBfbnX79yDM93pJGFfrWctYhW1vCN9Xq4RjR4iUmYRGmkVZ0hfFkUzx86x6d9qMpke8VcXUTMjOp532Fb6caWaSRrYJp15YA==
X-Gm-Message-State: AOJu0YyjFl1xbUEfBLmAmUCWzAc+WDfEp939ZYLI4UJ9xhzlN/jJ6rol
	L+MAW6AMqC63nJncBSaNq2doluJxpI01T/q3lVCqhjn/2hKCvSaKOXvdq6VuxdYwAOi66aG5Tuc
	k4arHz5Y2DgXfLIDgsljoTLUXdXw=
X-Google-Smtp-Source: AGHT+IHHboIpq9hG3uegI72AijSqf6Woq7uvAYi4N65G/zY61OPhRDfGRaFbk5fCPCiiBTciWRN+CiBfumCTX0cJvRQ=
X-Received: by 2002:a05:6e02:1aaf:b0:36c:4c5b:cd3 with SMTP id
 l15-20020a056e021aaf00b0036c4c5b0cd3mr2471381ilv.11.1714347196843; Sun, 28
 Apr 2024 16:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
In-Reply-To: <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 28 Apr 2024 19:33:05 -0400
Message-ID: <CADvbK_fzB3z-f-SJz+E6Q6hac5UyyqDPMB4r8GnCwYK8N8f=2g@mail.gmail.com>
Subject: Re: [PATCH] sctp: prefer struct_size over open coded arithmetic
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 1:23=E2=80=AFPM Erick Archer <erick.archer@outlook.=
com> wrote:
>
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
>
> As the "ids" variable is a pointer to "struct sctp_assoc_ids" and this
> structure ends in a flexible array:
>
> struct sctp_assoc_ids {
>         [...]
>         sctp_assoc_t    gaids_assoc_id[];
> };
>
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + size * count" in
> the kmalloc() function.
>
> Also, refactor the code adding the "ids_size" variable to avoid sizing
> twice.
>
> This way, the code is more readable and safer.
>
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open=
-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
>
> The Coccinelle script used to detect this code pattern is the following:
>
> virtual report
>
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =3D~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|=
vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
>
> i0 =3D sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 =3D ALLOC@p1(..., i0, ...);
>
> @script:python depends on report@
> p1 << rule1.p1;
> @@
>
> msg =3D "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
>
> Regards,
> Erick
> ---
>  net/sctp/socket.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index e416b6d3d270..64196b1dce1d 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7119,6 +7119,7 @@ static int sctp_getsockopt_assoc_ids(struct sock *s=
k, int len,
>         struct sctp_sock *sp =3D sctp_sk(sk);
>         struct sctp_association *asoc;
>         struct sctp_assoc_ids *ids;
> +       size_t ids_size;
>         u32 num =3D 0;
>
>         if (sctp_style(sk, TCP))
> @@ -7131,11 +7132,11 @@ static int sctp_getsockopt_assoc_ids(struct sock =
*sk, int len,
>                 num++;
>         }
>
> -       if (len < sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * =
num)
> +       ids_size =3D struct_size(ids, gaids_assoc_id, num);
> +       if (len < ids_size)
>                 return -EINVAL;
>
> -       len =3D sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * nu=
m;
> -
> +       len =3D ids_size;
>         ids =3D kmalloc(len, GFP_USER | __GFP_NOWARN);
>         if (unlikely(!ids))
>                 return -ENOMEM;
> --
> 2.25.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>

