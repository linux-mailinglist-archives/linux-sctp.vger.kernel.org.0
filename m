Return-Path: <linux-sctp+bounces-709-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB7C0C9ED
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8493A8F47
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A643226863;
	Mon, 27 Oct 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqHJYXQa"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619262E7BB4
	for <linux-sctp@vger.kernel.org>; Mon, 27 Oct 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556569; cv=none; b=fCSwiq0sqbqwp70X6iuM+zqQ2bjp5jVMyN2zbIsdhVf9DQuh73WzF+OdMYYTtIqe7xKW5854fH0YRQyJwQZGMhZnxzc36iemRMC/nMEVTqFnoA5BNpwmiEGkOCj+BF4IdaEfF6NMWwFbg7jobWtyoyEEgTvWaMRyogR6VczqnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556569; c=relaxed/simple;
	bh=oN9S/ByE6z4oE1dK1xupBGPnFsMKYjqe/Wd1H2/tmxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3cZt+GxIHhgJV+7TolFsfNEpShNMjmsHq1Ou9uaG+X3mwWt2MGD4UIQmKeRR3TvvNsdXScxrNHuIDeJFEMqiHgZ8bKm1Tggj8qPu88zMUIpDcwTf6vKVCZX9Zb51uo2ghmOWx7CskZiAKspacYMYuuwimQs/nHf9z2GHCKW4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqHJYXQa; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8a1744d9b8fso239595085a.1
        for <linux-sctp@vger.kernel.org>; Mon, 27 Oct 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761556566; x=1762161366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M7flweXiGej+Q06p6wHFNjm3oIgkIVuhJ5x8DaGW0s=;
        b=RqHJYXQa8BI0kdiRX5hfZ6cTTGLHHJnd8QRkhPsf1baR6dvrQqjYGn+LGLLouyE3R6
         a8cIYdCU1UVugipVqjn1cy6WfDBwxckNvOxCxGfirYr90y4YLWJWKZVSvYt0oLh9O6ep
         PyQJK7sBiJhyxDAZfq6r2V1XVvf6Qm8PMmj21WFpZaH1VQBJUWOAQJ8sxwWoF2PaVsPa
         DpU/nIoj035V1nlRYoXur9iwx/2IVsAXEfDgaOxEA+2/suiu8Sh+Mqbrufumb660jXT6
         4IPHASMImGwckrHpeKzfchWrBDiHCvlr1ZdlVwUrNVDiH9VVnfp/M+UiqZBBe91KsAi0
         DEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556566; x=1762161366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M7flweXiGej+Q06p6wHFNjm3oIgkIVuhJ5x8DaGW0s=;
        b=ZOW0Oe/n3WM9cFpYn49CyxEzCTEKryVWIhqyx6UaQaCSkJp63+hxsSrT2Oz41gUugh
         xIn9TQFAwVlMzAD/KNV+g/q/CDKwTbDdpykjxtrDglhksY/akHc1sthyFeqeF1YI23ne
         Is3JqYNihUVFHR0g/HXsMCjdatP5I2zUyZBxYVK9q7PtSJaI4Q3ICy5r+MF5fBuAINx+
         ASfgxCNOXBLXH1KniixF0gCkZJCX/ixs7tw711udegdD+NwO6hDZnFeQDq1WCp7vQd9B
         f+zKs/50RSvfITeyHkWIYKV2KMfB944tc7SV474RIgeScS8r36zXXDJaFNnCpaAdbPRE
         8Yvw==
X-Forwarded-Encrypted: i=1; AJvYcCUWzN9t29B8Y3tW0tkATUqHvrJvth0fTsRrP+R3P++tnYzuysgwistyxr4HskD3tjja7TliZvXeXYBU@vger.kernel.org
X-Gm-Message-State: AOJu0YxlY/fcnI9S/7yoo5xvxCmVlBKmcOau6uq/00p8b5rTIF2QRhCy
	Z62Ng32xAkRYWziZVBzlTfGdxs4uBj7MLzQ1PjEkfWpIFAceDA7tZyhkTlWERZK+40T4N6BV4O6
	otV6Dxly0XJM3lMAtLFuvN2ws9Kk9i1WnT6TYitvs
X-Gm-Gg: ASbGnctXvCS+oE/tVrXA0Vz4fL8Zq383OiSD9ARJfBj1NJ31nvoY9ED2qzQBXGiVLLL
	vNbzah65uC3rn2y+0aP6yAnsSxKA9g5hCXz/umAU1NUV4+gZLOETyw8NOpMeJsU1u5qLshnO2i3
	5Am/Whl/M+9PHBpn4lS2whzdtHxPtGR1ABHwWqm0RoWfUr1D6ALUA+qKmKpY5OmiBhiifsJ1esV
	/UU8eXzZEeJpoUbtKuALplCWwRvNMLLJrJXDHZmYtDbikSIUJhUArDnyy98W35cLQsb8yg=
X-Google-Smtp-Source: AGHT+IG0vxrk8P548hMiYXEr5yuQrLVzL4lCysrZOaHo4+AlkvkNAKs2QduZs+9ZwIJ4FPzozx2n/rIWJmZ0OVid1xI=
X-Received: by 2002:a05:620a:4005:b0:89e:6902:3e11 with SMTP id
 af79cd13be357-89e69024424mr914542685a.35.1761556565812; Mon, 27 Oct 2025
 02:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 02:15:54 -0700
X-Gm-Features: AWmQ_bmDUmU_tcEMhsKWxImXqueUJYr--H9ftZLY576HiZQiOI1zh4Y5ZwoSHbo
Message-ID: <CANn89iKSP6pCtn2vu8D=5-Y7LSxCtQA4s=qXjvHsMeOTstfbOQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No changelog ?

Also no mention/credits of who diagnosed this issue ?

Please do not forget to give credits.


On Mon, Oct 27, 2025 at 1:49=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
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

