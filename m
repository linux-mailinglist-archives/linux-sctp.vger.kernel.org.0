Return-Path: <linux-sctp+bounces-301-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAAA00B91
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Jan 2025 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EFE1884507
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Jan 2025 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDFC187848;
	Fri,  3 Jan 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DioZ2SdT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD94EEBB;
	Fri,  3 Jan 2025 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918569; cv=none; b=l8vFRA0Jvs+KSrb+NCsyX0i41fK6ICV6CzIo0dU7C38MjEFBVubf0ZFHczMm1EAfZhOUoO1stHc51OxfunRpkXqMkmbdHlZj68Sz8o1JBkrPoNSJW8ZxOPEa8KIJZKYPadDho0YOWWZe0xA1P+oJzTJW24GEeNKHC8pMDcc8vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918569; c=relaxed/simple;
	bh=BP57r48by4OEYie9Qo8+k9Xp0WXIh7qmhsh31IIUX7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fmt8SqAF/kEkoyQrvBo12SbnuicnCgM5AfR8SnH+VBVR11RWCx2zaiP63GM+RbvrDK2L1/cA7DvWjJFtB1aSHPog3tZtHIQfvVOYseSzV7R4IrVd3PQs4vV8f6uSgiEm869+S580dXp+IhQLE/zU7hgRXs5myUISC8xGftZjEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DioZ2SdT; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844d67eb693so992824439f.3;
        Fri, 03 Jan 2025 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735918566; x=1736523366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5aoFzxt3ammeH1Kyflvq1OY39O6WB2KH3gw979wCWA=;
        b=DioZ2SdTO2zqMHEeJeNhSvEq9uKoYfLBbiNJOPIZafMYNXFOF67bVeqHMPge30jV43
         7ljOJ+wauQ6X9wn2Ct6m5b0zzTX4P6XNNksKSgKDybAzdSiJbmqODrQJ3xZc78SGvOAX
         gRkFKrOcFuhtCkUA7lNFVzC0U9wcIw5Y34cjUFvy6UjVqOyP5Hw0AVFvPSXCFbN5ecyK
         i2zyH8MOGMiss4pdW3Dn4zF8DXgX/dSxG3PwK9TKUxvTegWG+TtEnp6lX8a47pPKofA5
         joePg5KhpfjeTb8tpOHAfZwx/j0yxNOVjFODp6RHl+Da0dQZ8vjiIZeZBC2H/i4E0aam
         wDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918566; x=1736523366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5aoFzxt3ammeH1Kyflvq1OY39O6WB2KH3gw979wCWA=;
        b=LE7pcFLm9GZh/tJyAl9d+mYbnc40HoTBcJ4ToR8QuADL/muw0pzulHYRLcYiabcRww
         yDLvXDcrTzdMDJEfGbiuE3appwru1msQ3VDT04fVUqDURO9A9YShNA30xDqV6iQmeNZg
         WkJNFpf/RjD9bjxqfuhGGFXkNQbDVNZUG608fXtFmu8xwuzlZRDvQ9luiu9UMcpn8OOd
         26bZV5gWlgqxWDlohS4z5TsicMfN3fW1ZkNQzk9pAzgbLtBX0+os/WAzVu78FQFuYByz
         trQr3lxeUpn7o4XEN5qvR0FdUXEkCzol0NZHJy9zxBPkYfPGBeM9Mr9PbNNxRTP209mA
         dqhA==
X-Forwarded-Encrypted: i=1; AJvYcCXNEw0SsNkFIgNQ1BIiP9iEYmEN5Fgqete0tr8ToF72eXl7MpX+/KHpzekuctEdqd1i7YovyrOnonk3@vger.kernel.org, AJvYcCXweFmC4CARxHDdTpY7DI1TvSuQoEOy8lRXBnexFBBp2Ch4yDR8bR4PLgGuj2EZlg2dDYZ5XpKD@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWjiCgfAZcs0BPpP9xJVimOuZP5YTU5u1w6XFGtuxvsC2Bnf1
	RUmvwDZ3BNlHlj3yc6k+qMw9FHqZNR8lPmsHfRGEOIoLoqVrBadT2cHk4rbgqQuLPRzaTLjKdnF
	UcE1+6L0bx/BWJvPqFi510tlLwRQ=
X-Gm-Gg: ASbGncsZySXV7e6F9ngnO6qDhqwLg5hYt4OCR5OAn4UJ0vsHB0Ft097QhVyCJxaMBhG
	34OUod0uX6BsUVXspVpga6pFfc1BjKHpL8dZge4o=
X-Google-Smtp-Source: AGHT+IGjlzjnKrvqXUywDcLjWtiJd1TMgtN9g0YS3sb3QRClaBXzLYHIJLhy0b6D9yy1UNtP3KsgEcZSKpLgOiluUmU=
X-Received: by 2002:a05:6e02:3201:b0:3a7:e0c0:5f25 with SMTP id
 e9e14a558f8ab-3c2d1b98ac9mr386005915ab.4.1735918566347; Fri, 03 Jan 2025
 07:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
In-Reply-To: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 3 Jan 2025 10:35:55 -0500
Message-ID: <CADvbK_fsM_EfoNjhybKJr92ojqFo6OdnuA2WiFJyi6Y1=rX4Gw@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t conversion.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:34=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
> that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
> variable. For the SCTP_DSCP_SET_MASK case, we can just use
> inet_dsfield_to_dscp() to get a dscp_t value.
>
> Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
> to drop the inet_dscp_to_dsfield() conversion function.
With inet_dsfield_to_dscp() && inet_dsfield_to_dscp(), the logic
looks like: tos(dsfield) -> dscp_t -> tos(dsfield)
It's a bit confusing, but it has been doing that all over routing places.

In sctp_v4_xmit(), there's the similar tos/dscp thing, although it's not
for fl4.flowi4_tos.

Also, I'm curious there are still a few places under net/ using:

  fl4.flowi4_tos =3D tos & INET_DSCP_MASK;

Will you consider changing all of them with
inet_dsfield_to_dscp() && inet_dsfield_to_dscp() as well?

Thanks.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/net/inet_sock.h |  6 ++++++
>  net/sctp/protocol.c     | 10 +++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 3ccbad881d74..1086256549fa 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -19,6 +19,7 @@
>  #include <linux/netdevice.h>
>
>  #include <net/flow.h>
> +#include <net/inet_dscp.h>
>  #include <net/sock.h>
>  #include <net/request_sock.h>
>  #include <net/netns/hash.h>
> @@ -302,6 +303,11 @@ static inline unsigned long inet_cmsg_flags(const st=
ruct inet_sock *inet)
>         return READ_ONCE(inet->inet_flags) & IP_CMSG_ALL;
>  }
>
> +static inline dscp_t inet_sk_dscp(const struct inet_sock *inet)
> +{
> +       return inet_dsfield_to_dscp(READ_ONCE(inet->tos));
> +}
> +
>  #define inet_test_bit(nr, sk)                  \
>         test_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
>  #define inet_set_bit(nr, sk)                   \
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 8b9a1b96695e..29727ed1008e 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -43,6 +43,7 @@
>  #include <net/addrconf.h>
>  #include <net/inet_common.h>
>  #include <net/inet_ecn.h>
> +#include <net/inet_sock.h>
>  #include <net/udp_tunnel.h>
>  #include <net/inet_dscp.h>
>
> @@ -427,16 +428,19 @@ static void sctp_v4_get_dst(struct sctp_transport *=
t, union sctp_addr *saddr,
>         struct dst_entry *dst =3D NULL;
>         union sctp_addr *daddr =3D &t->ipaddr;
>         union sctp_addr dst_saddr;
> -       u8 tos =3D READ_ONCE(inet_sk(sk)->tos);
> +       dscp_t dscp;
>
>         if (t->dscp & SCTP_DSCP_SET_MASK)
> -               tos =3D t->dscp & SCTP_DSCP_VAL_MASK;
> +               dscp =3D inet_dsfield_to_dscp(t->dscp);
> +       else
> +               dscp =3D inet_sk_dscp(inet_sk(sk));
> +
>         memset(&_fl, 0x0, sizeof(_fl));
>         fl4->daddr  =3D daddr->v4.sin_addr.s_addr;
>         fl4->fl4_dport =3D daddr->v4.sin_port;
>         fl4->flowi4_proto =3D IPPROTO_SCTP;
>         if (asoc) {
> -               fl4->flowi4_tos =3D tos & INET_DSCP_MASK;
> +               fl4->flowi4_tos =3D inet_dscp_to_dsfield(dscp);
>                 fl4->flowi4_scope =3D ip_sock_rt_scope(asoc->base.sk);
>                 fl4->flowi4_oif =3D asoc->base.sk->sk_bound_dev_if;
>                 fl4->fl4_sport =3D htons(asoc->base.bind_addr.port);
> --
> 2.39.2
>

