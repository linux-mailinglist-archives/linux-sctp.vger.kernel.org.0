Return-Path: <linux-sctp+bounces-476-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD0A7A584
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Apr 2025 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A512816C215
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Apr 2025 14:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997024EF95;
	Thu,  3 Apr 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQhtYpCY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42A24EF7D;
	Thu,  3 Apr 2025 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691342; cv=none; b=ICyYrfwEFo50LNkk1YjJ3dKSs3YQ8YSk783Xe/2n7L85ccRPVE7Hrhxp34IJQaA3j8AhSfVYo6sR5tMQYfRySnCaIyf2aVy3EFFseEZh2f0WNK4Kpn9ONKCqp/mkGmJoYJG9tK8856EobaFv6fNcAO5l0EyeN6K2vPcHpKKgzbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691342; c=relaxed/simple;
	bh=Zry1Yrol56/KX1aeEhCxv0Cg25fLUtDNop8HonNdjPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMtiw2YCSTYjMG47BE9v5cWT4ovC8hf/xDJ/QogSbNMQwMX6yApPltNLjbRxkdUTL/+LUZ02L4Z564tqnVyG5l28J69Nd1mlcPl4Ux0bO5xzDRdJNGxbuLhcFKeMs52QekYDtRa4fbPl01Wp9nWEW/3t4MAeI1z0QTwdDBwJcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQhtYpCY; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85d9a87660fso88182739f.1;
        Thu, 03 Apr 2025 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743691340; x=1744296140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeoDb9T68HON4+pT2o4m+OL30KX0Z6zhqrCCdtzjaWI=;
        b=BQhtYpCYRdqQhScW52gcZgDHo/5auY8GDde5ivG+tpeeFEKQZB/CFa1/IhAhehsapR
         GDowryAeH/DuEJuC1nT4np75jaS8o9sY+1w2a43olEo4An6ht+JJUYyQ/vF3lgslb24c
         upHMeouJnIBhyAMQ29eQap398rsmcffO8+w9qUgvt43cdgHtdLt9VcNIM0eoHz/tbieJ
         YQ3LeFVHABEZq9m0GZKpr5Akgtp6BSRUSWY++cyvGvgZl0aw8TFyEK2Yp0e9OPp21lVq
         ofSPCkSe9MH4Yq/cgaPj50ojOg7hncxt7pS0dI09fJjNvKr2BA8otPL/sn9J86k8TAf7
         2ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743691340; x=1744296140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeoDb9T68HON4+pT2o4m+OL30KX0Z6zhqrCCdtzjaWI=;
        b=bC3Zs6BUCUUrKEHnn0BJULI2jG5bSj5r89VOdMZmjxb/StoMgo64Y67nh4jMm0AC3+
         dGJ3byA7OydJdnYVqfCb/U4kggcbQOAd07by1HYeMmllUjgRmszvIk1J0FuM0nbs1WxH
         4aZWEXD8W0Wch5X9vFE/Lw7GkWDfrIJjp3Z0cVgVcMfqje0qwRgBwHpl1QaakHHYVCwy
         fuDhvnayI9O7oxnbH+juiVFkTgilHCFsLQvLrPWOEFS0HBDhfsM5TQtnKblXH0VBLHBS
         ath39NjM8HDc2H48prDczRncsvPgJshNC6RbLBgLsvvUcsLjEGIVFAa+JgX9KX4gXo4U
         Eugw==
X-Forwarded-Encrypted: i=1; AJvYcCU/kKh0odlXTDynai+yrkQcKAawUK9I9EeBVFr6vW4nHiDoQk+3YJMNCmJRPnH5zaTmsd5xiqPmHHxlExk=@vger.kernel.org, AJvYcCU3TKQ1IkHJ2ajPLk26UX2ARtb4YYVY7IQMozyjxgle4VYjtCpYDv3nns/DemTGeSkL4dL1uNixhwzqBg==@vger.kernel.org, AJvYcCUOx9wAftOQxRKmjfWP/i3lkLCtn8p3aV2DQUKcAygwHvv0TgTkXr+2MirsozjO1F8Oa6CY4q7C@vger.kernel.org, AJvYcCVBUyPMKsnlOdJE8l3RuqsGl95e19cbaXahXMMnUwOSjIG8U26Tq4L0zNy8J0DD47sEfUsFEcWL@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5cDwBqSOfTLcWhZ6iGnhnNgOwpIvkQ1/rQaQs1QpTybGWdSK
	T30yeBWD4dN5dE3J6/8pZ5WFp4AdEfGXgbbjPWF4RdK5Tzlwy70goYoH40GcIl25mKVAyQXMetP
	hDl3HueZwwmuxYOEfDgeFJ2PO+pI=
X-Gm-Gg: ASbGncsYJxVHC1hzxNXSDHFsq/5RJbK5ntvz/50NdOQHLRISp3VT1nbT8BwfpUNtC9Q
	69fQT/OF+/IyEjuUsV7AOv75GPIG95V6nry+Z40RIkWrLnPuPw4Mt+SptEZjZD2xX1ho4Bm0nTu
	Y2TBhPjrVMJ3JfOUq/XFQNR4DNqYHozP3hN3dYrvbFaCQMIh7WNzHBYV311OU=
X-Google-Smtp-Source: AGHT+IGNRyxDi7DahaAnymdSbr7DQycN0ZdLw//2LEvSHgTrzxm8aOaPQKMKp2kUdY5SWnF/e0614nQcpCl/EzjRxG4=
X-Received: by 2002:a05:6e02:12ec:b0:3d6:d179:a182 with SMTP id
 e9e14a558f8ab-3d6dd824cb5mr37846045ab.20.1743691339808; Thu, 03 Apr 2025
 07:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
 <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com> <87tt75efdj.fsf@igalia.com>
In-Reply-To: <87tt75efdj.fsf@igalia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 3 Apr 2025 10:42:08 -0400
X-Gm-Features: ATxdqUHaFX6L76fecmJqYz3mIbUdj6YZ5tkatolAjwkKUce-j3bzGLhgqW-KjgY
Message-ID: <CADvbK_c69AoVyFDX2YduebF9DG8YyZM7aP7aMrMyqJi7vMmiSA@mail.gmail.com>
Subject: Re: [PATCH] sctp: check transport existence before processing a send primitive
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, kernel-dev@igalia.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 5:58=E2=80=AFAM Ricardo Ca=C3=B1uelo Navarro <rcn@ig=
alia.com> wrote:
>
> Thanks for reviewing, answers below:
>
> On Wed, Apr 02 2025 at 15:40:56, Xin Long <lucien.xin@gmail.com> wrote:
> > The data send path:
> >
> >   sctp_endpoint_lookup_assoc() ->
> >   sctp_sendmsg_to_asoc()
> >
> > And the transport removal path:
> >
> >   sctp_sf_do_asconf() ->
> >   sctp_process_asconf() ->
> >   sctp_assoc_rm_peer()
> >
> > are both protected by the same socket lock.
> >
> > Additionally, when a path is removed, sctp_assoc_rm_peer() updates the
> > transport of all existing chunks in the send queues (peer->transmitted
> > and asoc->outqueue.out_chunk_list) to NULL.
> >
> > It will be great if you can reproduce the issue locally and help check
> > how the potential race occurs.
>
> That's true but if there isn't enough space in the send buffer, then
> sctp_sendmsg_to_asoc() will release the lock temporarily.
>
Oh right, I missed that. Thanks.

> The scenario that the reproducer generates is the following:
>
>         Thread A                                  Thread B
>         --------------------                      --------------------
> (1)     sctp_sendmsg()
>           lock_sock()
>           sctp_sendmsg_to_asoc()
>             sctp_wait_for_sndbuf()
>               release_sock()
>                                                   sctp_setsockopt(SCTP_SO=
CKOPT_BINDX_REM)
>                                                     lock_sock()
>                                                     sctp_setsockopt_bindx=
()
>                                                     sctp_send_asconf_del_=
ip()
>                                                       ...
>                                                     release_sock()
>                                                       process rcv backlog=
:
>                                                         sctp_do_sm()
>                                                           sctp_sf_do_asco=
nf()
>                                                             ...
>                                                               sctp_assoc_=
rm_peer()
>               lock_sock()
> (2)          chunk->transport =3D transport
>              sctp_primitive_SEND()
>                ...
>                sctp_outq_select_transport()
> *BUG*            switch (new_transport->state)
>
>
> Notes:
> ------
>
> Both threads operate on the same socket.
>
> 1. Here, sctp_endpoint_lookup_assoc() finds and returns an existing
> association and transport.
>
> 2. At this point, `transport` is already deleted. chunk->transport is
> not set to NULL because sctp_assoc_rm_peer() ran _before_ the transport
> was assigned to the chunk.
>
> > We should avoid an extra hashtable lookup on this hot TX path, as it wo=
uld
> > negatively impact performance.
>
> Good point. I can't really tell the performance impact of the lookup
> here, my experience with the SCTP implementation is very limited. Do you
> have any suggestions or alternatives about how to deal with this?
>
I think the correct approach is to follow how sctp_assoc_rm_peer()
handles this.

You can use asoc->peer.last_sent_to (which isn't really used elsewhere)
to temporarily store the transport before releasing the socket lock and
sleeping in sctp_sendmsg_to_asoc(). After waking up and reacquiring the
lock, restore the transport back to asoc->peer.last_sent_to.

Additionally, during an ASCONF update, ensure asoc->peer.last_sent_to
is set to a valid transport if it matches the transport being removed.

For example:

in sctp_wait_for_sndbuf():

    asoc->peer.last_sent_to =3D *tp;
    release_sock(sk);
    current_timeo =3D schedule_timeout(current_timeo);
    lock_sock(sk);
    *tp =3D asoc->peer.last_sent_to;
    asoc->peer.last_sent_to =3D NULL;

in sctp_assoc_rm_peer():

    if (asoc->peer.last_sent_to =3D=3D peer)
        asoc->peer.last_sent_to =3D transport;

