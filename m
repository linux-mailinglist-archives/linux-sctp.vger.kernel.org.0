Return-Path: <linux-sctp+bounces-511-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0102AB5E9A
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 23:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAE81894D70
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B32581;
	Tue, 13 May 2025 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz9Nmv/G"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4D1B0409
	for <linux-sctp@vger.kernel.org>; Tue, 13 May 2025 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172894; cv=none; b=OIpKwJbkF9bKuhSBZf3xeQB4TRrcyFagNQgbQ5tQE8sgx/baooFJuj9jZts3nQVFI1YH6HkYqc9136NnPjLw2bBCvgO7mdDlfTWNJwPLw7F90yErY20Vhj6ulaPn70p620I1ODmmUuJWW5TE9SQG5EI1PfWvM6JN/zoDxbhurHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172894; c=relaxed/simple;
	bh=lk3HOIXOVZsjKlBQllFA9bdkU6Rpy9p0N+YiZeilems=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1QX9CtHxxsQl2FKzrDZHHoOVQ17HQIoQXbCN7wk8m7bMOJRBkOA8ZRt+5aTF5+cIFmHWIfbiZmV9NghRmC7IGBgplEhbipA1ty9UeYeSQNpCGTmmbC6UPyNPXRCbNXqPoiF+D7E5X+8+SCMPigtTKMtmRaQMFN/9bNmJpzrOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz9Nmv/G; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3db6cda65efso1132615ab.1
        for <linux-sctp@vger.kernel.org>; Tue, 13 May 2025 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747172892; x=1747777692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UguZ54t4xwHxRFVsXB4hxUmwYwu/AWTUKMu6tySqc/s=;
        b=mz9Nmv/GyIoGdHbv+irh8VqaN36lSDnPpIH0r6I1qObEelEtfH5jnBKyds2IDMG+oT
         Q8TPxMWIhZ0AJsdrXKXnNJYsSavIMN96s9hV+Tzh/teEeeYBGlbnKWNOglCBD4tSmMel
         IKz4+ds3yQEg1wVazNMuAK2ht5yPzWpz7gRAPLqJzIpWpw+Dx2KpJ07oATB8y762eZej
         SPKrkehfl6czBKegpAEoevtyiUlX697/3zj9duXZ6GmFMtFiiMJbczUrY5B/YpsbQ0WQ
         tnF08FVbRVLtpTnjtC/UE/TxIhtkymEwBZ9oz7/rqiFAccSJnpHFI3le/+k2Abf2GC8H
         iOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747172892; x=1747777692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UguZ54t4xwHxRFVsXB4hxUmwYwu/AWTUKMu6tySqc/s=;
        b=KTp4o/iA+OEg8LXHpJ0x0pNo0A6FdYGrYkKpYjTWLnTEKprTdYSpaav51DVSAQinAY
         Ew8znIK9xxDCB3sm56/Wg34X5ImODBn94/sBJ9ir4vIAX6fqmPk3ZNfPlTb7sXq7Tl9T
         3c9I8/4+anUG2zhASh9W4O9dLu0DqZSLL710I1+fSd2nZgqnl/5kqbJwLA7QEdm7tmqP
         mljtjBaL1asWFDrcDVwSzKbe5VU0Mu8fsaXd1holRknLfwLCanP8HvzkuRLlXZexPM6n
         bldwirRoqsufDDShw9YTMJxLdrkEziA7CivY7m3D/v2tcD9i401uNp/tqA9A+HlJoMke
         MTgg==
X-Gm-Message-State: AOJu0Ywr/Aa5QKyBTDo1784Z0QQ67m+Y3myxuxNqZVsjiKnyqrSwaeLn
	mIt9nreg96NU6rFMgI8eGWOaLYe//WmnI/IcgK9NXq7Lp4rI8SEHiyaJj0wIrxQPZwweCPj4t3y
	wbjiNuw9KFTZdBB02QlJLd7jYGWkB3WeZ
X-Gm-Gg: ASbGncvicX9tpN0vh8cxwHAESy6wVgNQ7dTQG7QxQdZBAJCqejWZzzRUkMqiCK6/+uY
	KwFIAWGyBXSeScP5f09VM5GJFbgi6F0DrPmQKSBd6yJ5nlQ1P65OHRCWvbYn7lTYSPyxflxH779
	3vQdMBlVLVWxfq2sT0Qd1DGAB1G5okjuVzN+4jxnltn5j7xUuIJ4kDnzPRxg7tAn6tKw==
X-Google-Smtp-Source: AGHT+IFjJYSNa1ooLxQ4x62w1+IOP72vgV0Yb6ptdGVtaARx1ENvsmElt37VOowx/Z0O7yBmWtCrlw406c5+BBkjIIM=
X-Received: by 2002:a05:6e02:3f0b:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3db6f5ba6ccmr15313945ab.8.1747172892083; Tue, 13 May 2025
 14:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512123224.1231301-1-oss@malat.biz> <CADvbK_ctiip5mu3zfAu5zmD6W9BuHmP+cL-WGvFQYtyT8u_HyQ@mail.gmail.com>
In-Reply-To: <CADvbK_ctiip5mu3zfAu5zmD6W9BuHmP+cL-WGvFQYtyT8u_HyQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 13 May 2025 17:48:00 -0400
X-Gm-Features: AX0GCFuzmh54IZlj0nVGlEl8BY8WlNcLWg08rzxk-TQnTughmbHwng_a36m_PTM
Message-ID: <CADvbK_fuv7_Hoo3BGL2_b2r9yY7VT=x6K3a+yBuDd9LAN9bZ=A@mail.gmail.com>
Subject: Re: [PATCH] sctp: Do not wake readers in __sctp_write_space()
To: Petr Malat <oss@malat.biz>
Cc: linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 5:45=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Mon, May 12, 2025 at 8:33=E2=80=AFAM Petr Malat <oss@malat.biz> wrote:
> >
> > Function __sctp_write_space() doesn't set poll key, which leads to
> > ep_poll_callback() waking up all waiters, not only these waiting
> > for the socket being writable. Set the key properly using
> > wake_up_interruptible_poll(), which is preferred over the sync
> > variant, as writers are not woken up before at least half of the
> > queue is available. Also, TCP does the same.
> >
> > Signed-off-by: Petr Malat <oss@malat.biz>
> > ---
> >  net/sctp/socket.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 53725ee7ba06..b301d64d9d80 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -9100,7 +9100,8 @@ static void __sctp_write_space(struct sctp_associ=
ation *asoc)
> >                 wq =3D rcu_dereference(sk->sk_wq);
> >                 if (wq) {
> >                         if (waitqueue_active(&wq->wait))
> > -                               wake_up_interruptible(&wq->wait);
> > +                               wake_up_interruptible_poll(&wq->wait, E=
POLLOUT |
> > +                                               EPOLLWRNORM | EPOLLWRBA=
ND);
> >
> >                         /* Note that we try to include the Async I/O su=
pport
> >                          * here by modeling from the current TCP/UDP co=
de.
> > --
> > 2.39.5
> >
> Acked-by: Xin Long <lucien.xin@gmail.com>

Please re-send the patch and add:  netdev@vger.kernel.org to the CC list.

