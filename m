Return-Path: <linux-sctp+bounces-282-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E34B9C0915
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2024 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D267A1F21DA3
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF61212196;
	Thu,  7 Nov 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzyM5AJr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5B1F8EFF;
	Thu,  7 Nov 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990333; cv=none; b=NfOvI6P4L6HChT6qvsC9hNvBJuuIRKqKDBfDvOysHBLbR7G4HGr2Y+vcJcSDxCvd1mRvqaDp4dE9/6R3ZjdQNBJLBo9wYyJo62ir8SIDMI/hjenlcot7iI6stqslmhJyMg3MHrt2qga1nyIETH0qDQgZzBiTeOX39m5ijMpr76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990333; c=relaxed/simple;
	bh=l7JvSxJBHZ38vac4UEzAmhJXOGtxKvkL40j9n0BIF7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEGFw+Dc9iqvLuyR51hql8p2Lk9jEZZcomRLh+/wKOt33hkmKbku65PO6rXKrNmhg2pGlNdLazFySeuYUaQq+efAe6SSzirnxHGpk8UOw8BBc5ZMNBo4kTmb7IsLZyWuH0xRdV6/Bo78YBEHwKzszfEQIp7r5IjLfKky0/WQ9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzyM5AJr; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so3987085ab.0;
        Thu, 07 Nov 2024 06:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730990331; x=1731595131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+8oT9nfItu+kQ69xKVVdOmaZDkdDh7Tg4sB6xTZL6w=;
        b=UzyM5AJrkXarkCvAYiucWyn2ow0ZE2Jtx42bgI6kFrhPrkM+6hwVESblVXj1wb7kDx
         qUq/90nLZo5J6VKnnpTbgpMR3ieE/TwsR0t8paiXbdyIDf/7zy3L/gaGR/t5WQOxCd2A
         qKM8B4wgw9QsFWo/KaCL6Px3b1Ao3IovYVdEG4TQ1Ca/nAK1AF77EEdaWP90rZAK1YPC
         4O6hhVb83kvsFI9defCqYnlMvpZh1naGnzMYmXT1ufRpPoJx1OU44bZfk3fjvvacRVLF
         nfVSOw42MplgvAFBL67RUJFXqqcxmByGgvCaMEwCUThIcKRAI8Qr/uCDk6nOx59eEKyx
         iHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990331; x=1731595131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+8oT9nfItu+kQ69xKVVdOmaZDkdDh7Tg4sB6xTZL6w=;
        b=kE3nrxNYqaxInkgKiBPkuk4DE9KzefcqqnYZAgXBtkipEpSMc+U2nuM49v7SINXfvi
         nhkMeeE5yV9jLS6M5FcAb5pnEIJOeOMgf2qqHsv3msYKTauP+4+Z1T8/qXoAsvzQPHcB
         afzksEuootW7Zwx3bWKv3FkIuPBpOYp27evkcg3M9IU8zAspn9lBhd+ExEyvYnwAG+6S
         nmFN7wTIzj9CB8ST8Sf5Pvfi2kl6F/IZ3yre/wr6wlxrDUGnEnM6IUdAhFsJLn1f6tl5
         lK3uhuObFMWZZHauTmzreR0L2w+2fBSYaqym6rpNiP4d6H2qW23vX9be1Vm/pJj+2TYr
         evcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAQc5gyC21T1YqxuI+YUA8XmkgV6URKoOgTwjQgBziS/V1u/TgT30zgtA3ZxkHvvVMhSd1JJC6@vger.kernel.org, AJvYcCXWv3I0JubMdchaGAHJacCXg2lO6D63MNPkJ8/UIZ2R1Gb63f2tLP3I8IXYz+2J5MWNwfzaVr/168YC@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCSbfE0CQeVOTDdBdGZLvxjh2r9cs0ukijDP3dx6kKBWwxaG+
	y5IoyO0lTI0thodJBwbSaIZ+DrsQ+93sJPEPaJTl3VnoC822C5bS0n5fL32bZanKjSlHSf1v4Bk
	yTJZEQJiq0gm0aCtfzjmWwKQkvZc=
X-Google-Smtp-Source: AGHT+IHaSLNq/a7u4BuDR3RQj0zHqkw3iqoefK+C5Iv838Wd9iujSSJDth0zXNgL7hbllUifbcwF7vP2bFgPqqcYQ6U=
X-Received: by 2002:a05:6e02:220a:b0:3a6:c89d:4eb5 with SMTP id
 e9e14a558f8ab-3a6c89d50e2mr177221665ab.15.1730990331386; Thu, 07 Nov 2024
 06:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104083545.114-1-gnaaman@drivenets.com>
In-Reply-To: <20241104083545.114-1-gnaaman@drivenets.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 7 Nov 2024 09:38:40 -0500
Message-ID: <CADvbK_fV3t8Txh73gOVGh8NV401xb0dQDNJjc-YsW9kUeEkhEg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] sctp: Avoid enqueuing addr events redundantly
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 3:36=E2=80=AFAM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
>
> Avoid modifying or enqueuing new events if it's possible to tell that no
> one will consume them.
>
> Since enqueueing requires searching the current queue for opposite
> events for the same address, adding addresses en-masse turns this
> inetaddr_event into a bottle-neck, as it will get slower and slower
> with each address added.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

> ---
> Changes in v2:
>  - Reorder list removal to avoid race with new sessions
> ---
>  net/sctp/ipv6.c     |  2 +-
>  net/sctp/protocol.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
> index f7b809c0d142..b96c849545ae 100644
> --- a/net/sctp/ipv6.c
> +++ b/net/sctp/ipv6.c
> @@ -103,10 +103,10 @@ static int sctp_inet6addr_event(struct notifier_blo=
ck *this, unsigned long ev,
>                             ipv6_addr_equal(&addr->a.v6.sin6_addr,
>                                             &ifa->addr) &&
>                             addr->a.v6.sin6_scope_id =3D=3D ifa->idev->de=
v->ifindex) {
> -                               sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DE=
L);
>                                 found =3D 1;
>                                 addr->valid =3D 0;
>                                 list_del_rcu(&addr->list);
> +                               sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DE=
L);
>                                 break;
>                         }
>                 }
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 39ca5403d4d7..8b9a1b96695e 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -738,6 +738,20 @@ void sctp_addr_wq_mgmt(struct net *net, struct sctp_=
sockaddr_entry *addr, int cm
>          */
>
>         spin_lock_bh(&net->sctp.addr_wq_lock);
> +
> +       /* Avoid searching the queue or modifying it if there are no cons=
umers,
> +        * as it can lead to performance degradation if addresses are mod=
ified
> +        * en-masse.
> +        *
> +        * If the queue already contains some events, update it anyway to=
 avoid
> +        * ugly races between new sessions and new address events.
> +        */
> +       if (list_empty(&net->sctp.auto_asconf_splist) &&
> +           list_empty(&net->sctp.addr_waitq)) {
> +               spin_unlock_bh(&net->sctp.addr_wq_lock);
> +               return;
> +       }
> +
>         /* Offsets existing events in addr_wq */
>         addrw =3D sctp_addr_wq_lookup(net, addr);
>         if (addrw) {
> @@ -808,10 +822,10 @@ static int sctp_inetaddr_event(struct notifier_bloc=
k *this, unsigned long ev,
>                         if (addr->a.sa.sa_family =3D=3D AF_INET &&
>                                         addr->a.v4.sin_addr.s_addr =3D=3D
>                                         ifa->ifa_local) {
> -                               sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DE=
L);
>                                 found =3D 1;
>                                 addr->valid =3D 0;
>                                 list_del_rcu(&addr->list);
> +                               sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DE=
L);
>                                 break;
>                         }
>                 }
> --
> 2.34.1
>

