Return-Path: <linux-sctp+bounces-172-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7F9007EA
	for <lists+linux-sctp@lfdr.de>; Fri,  7 Jun 2024 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C61C23568
	for <lists+linux-sctp@lfdr.de>; Fri,  7 Jun 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D021990B2;
	Fri,  7 Jun 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qql82WAN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534C197A68;
	Fri,  7 Jun 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772032; cv=none; b=oVGZ5IQTbEtWwg48dkC3DV6rq0eLA4RFIk+rXBGGoiuPp37Eza6wvPzk238b2W7cCEaws3iL2riLBZsdjDSZIE7QKkx425f8pvmqsfxan5lEoG6G8EEmvBFy/WSzuxKHvT3X+sJMarwT8DZm1T8u0JT/iUdwb67/w9ij/djKuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772032; c=relaxed/simple;
	bh=qN0K4Vhm1CmfQJv8lTUuvuTmBDZntjnq3l4O0tLeuSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcGizZMpuPuvM+EzMpuB7Z6+4YvB2qf1oEXe9ZN7+eWVPKtyF4rcvb18DZpDU9Is1BXQtOsyIkMjvMrFw+IQFv+iClPLqHXSJKC7yVZnX+A63hB/bvquESEym7lbwU+ds6SqGfQMMkl3glyzvnNqoeQnYi6RpYf3jZLvq/BlXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qql82WAN; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-37585fc3eebso2580605ab.0;
        Fri, 07 Jun 2024 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717772030; x=1718376830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBo/lajgxqd57WhsKdw0GslmVGXqhBJ5KLjNbHAH6pQ=;
        b=Qql82WANYdpNboaL1A8gcR0gF9ua5tFXOA7KErFG80sfbQsTrngUgy2kEyGq6/4bY+
         fHfZw/qXJ+agMyugb6CM1+1vDncFYdRZBSxhbCy3x/+jEwXKRe/FkXir3sATxUxMApWL
         bYU8vkapnjYK+5QNFIa4nTgixqzwxg4N3ChHS6g0QWZZW0MMF/5/2ngEfZLIEE+6nEKv
         q6VOvHHfTNvE7BGWZnBB7IBLb+Z7syoDahvj2GOVVuKK4VOjBppbAE6Zimhoyi6kPnrx
         K7rEqQkUm/UDGXikyWnh5tD6/VTbDgyWTyDZWbT9FPyW6zesAy2XOkQXXZn4SB9+PWHG
         fPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772030; x=1718376830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBo/lajgxqd57WhsKdw0GslmVGXqhBJ5KLjNbHAH6pQ=;
        b=jlSq8GxA6Shi5ld9uXPJG1UhmJmCpMXiq++867YuoMyzSVdkIIqfecaF0MTiCFWQZq
         lAOfJiGx7m8y8ooTYft0OKQmOo8mMpNaWIWS19sT4a15+hS/SEVJyBNYvPvBIuYCoA+n
         oKBMj95X0iWxpsiQPwPQWnN6V5KbhOH/1Q+FctdHNOsaSfSVMqVvWvnjw5Sn198Uvb3K
         rp+08wvqBTIpmCSsettafwx/I+OErOY9p+tYrntjNOx5cXO5iJY/kaz274hAlJxXYsfE
         AckKNWfYoEIuV9dmDKSprOcscGKZyxpUPcDSnTJeSORNWqufZiIf91uSkeznVactKYop
         aNtw==
X-Forwarded-Encrypted: i=1; AJvYcCWudAACp9QROGRCePRK/xD5XHtWa4Bvo8LUMB5hF9V2vHJvc9XqhjmhWDszAxYYQt86/srCqwBsKwmMoy/OfhV+jd32Dg5U
X-Gm-Message-State: AOJu0YzA7lSvmYvflcwAPXJZ7sriztkqdIxzYGweoRVxIhiC2nLao5u6
	vzLK9xCmerVheZcwEGhIBAyKIIE5HY11i9VXwri69wVilTiDVi+n9eBqcU6vJOEButkIczGQ4tm
	YX6vjnIBoy6glCRV3c9kYf/TJ6+s/HrBFKPU=
X-Google-Smtp-Source: AGHT+IFggGLap5bjvbfo6DzymifGGYaCdEH0Kgw/BqUTeDoJEegk34aWS+D513qZNeKZryzDFJVal7Mvcq2cAZxkcks=
X-Received: by 2002:a05:6e02:dc9:b0:375:8af5:8d17 with SMTP id
 e9e14a558f8ab-3758af58f87mr4157795ab.31.1717772029822; Fri, 07 Jun 2024
 07:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4faeb583e1d44d82b4e16374b0ad583c@AcuMS.aculab.com>
 <CADvbK_emOEPZJ8GWtYpUDKAGLW2z84S81ZcW9qQCc=rYCiUbAA@mail.gmail.com> <0b42b8f085b84a7e8ffd5a9b71ed2932@AcuMS.aculab.com>
In-Reply-To: <0b42b8f085b84a7e8ffd5a9b71ed2932@AcuMS.aculab.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 7 Jun 2024 10:53:38 -0400
Message-ID: <CADvbK_cLMuLYA-ADXr2Vn5kRHZ0UpeL7G-u710g1En9t7h6SYw@mail.gmail.com>
Subject: Re: SCTP doesn't seem to let you 'cancel' a blocking accept()
To: David Laight <David.Laight@aculab.com>
Cc: linux-sctp <linux-sctp@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 4:36=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Xin Long
> > Sent: 06 June 2024 21:15
> >
> > On Mon, Jun 3, 2024 at 11:42=E2=80=AFAM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > In a multithreaded program it is reasonable to have a thread blocked =
in accept().
> > > With TCP a subsequent shutdown(listen_fd, SHUT_RDWR) causes the accep=
t to fail.
> > > But nothing happens for SCTP.
> > >
> > > I think the 'magic' happens when tcp_disconnect() calls inet_csk_list=
en_stop(sk)
> > > but sctp_disconnect() is an empty function and nothing happens.
> > >
> > > I can't see any calls to inet_csk_listen_stop() in the sctp code - so=
 I suspect
> > > it isn't possible at all.
> ...
> > >
> > > I also suspect that a blocking connect() can't be cancelled either?
> >
> > For connecting socket, it calls sctp_shutdown() where SHUT_WR causes
> > the asoc to enter SHUTDOWN_SENT and cancel the blocking connect().
>
> I'll test that later - the test I was running always connects.
> I'm porting some kernel code that used signals to unblock synchronous
> calls to userspace where you can't signal a thread.
> The only problem with the kernel version is secure boot and driver
> signing (especially for the windows build!).
>
> > > Clearly the application can avoid the issue by using poll() and an
> > > extra eventfd() for the wakeup - but it is all a faff for code that
> > > otherwise straight forward.
> >
> > I will try to prepare a patch to solve this for sctp accept() like:
>
> I'll test it for you.
>
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index c67679a41044..f270a0a4c65d 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -4834,10 +4834,13 @@ int sctp_inet_connect(struct socket *sock,
> > struct sockaddr *uaddr,
> >         return sctp_connect(sock->sk, uaddr, addr_len, flags);
> >  }
> >
> > -/* FIXME: Write comments. */
> >  static int sctp_disconnect(struct sock *sk, int flags)
> >  {
> > -       return -EOPNOTSUPP; /* STUB */
> > +       if (!sctp_style(sk, TCP))
> > +               return -EOPNOTSUPP;
> > +
> > +       sk->sk_shutdown |=3D RCV_SHUTDOWN;
> > +       return 0;
>
> I think you need to call something to unblock the thread as well
> as changing the state.
shutdown() will call inet_shutdown()/sk_state_change(sk) to awake the
sleeping thread in sctp_accept()/connect().

In sctp_accept() it checks sk->sk_shutdown & RCV_SHUTDOWN to return,
while in sctp_connect() it check asoc->state >=3D SCTP_STATE_SHUTDOWN_PENDI=
NG
to return.

In inet_shutdown(), only with RCV_SHUTDOWN flag calls .disconnect() for
LISTEN sockets, and SCTP doesn't do many things for RCV_SHUTDOWN, I would
just set this flag to unlock the thread, and leave the real disconnection
to close(listen_sk);

>
> ...
> > -       if (!sctp_sstate(sk, LISTENING)) {
>
> Any chance of making it much clearer that this is testing
>                 if (sk->sk_state =3D=3D TCP_LISTEN)
>
> The token-pasting though
>         SCTP_SS_CLOSED         =3D TCP_CLOSE,
>         SCTP_SS_LISTENING      =3D TCP_LISTEN,
>         SCTP_SS_ESTABLISHING   =3D TCP_SYN_SENT,
>         SCTP_SS_ESTABLISHED    =3D TCP_ESTABLISHED,
>         SCTP_SS_CLOSING        =3D TCP_CLOSE_WAIT,
> makes grepping for changes to sk_state pretty impossible.
>
> You might argue that the sk_state values should be protocol neutral,
> and that the wrapper gives strong typing - but together they make
> the code hard to scan.
>
> The strong typing could be maintained by changing the constants to
>         SCTP_SS_TCP_CLOSE =3D TCP_CLOSE
> (etc) so that grepping for the constants still works.
I understand.
I guess the author didn't want to have TCP named things in SCTP.
Maybe it's the inet layer that should use neutral names for states. :D

Thanks.

>
> I keep thinking of ways to do strongly typed enum in C.
> The main options seem to be embedding the value in a struct
> or using a pointer to a struct.
> Neither is ideal.
>
> OTOH the compiler can't default to strongly typed enum.
> Although perhaps that could be a per-enum attribute.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

