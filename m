Return-Path: <linux-sctp+bounces-677-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF79C03A02
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1114C3B1958
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 21:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4231245006;
	Thu, 23 Oct 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq+/+ze9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42744230BEC
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761256674; cv=none; b=BSawTFKwnq20sXEC8Z+Cvxynwj334lDcKHJW0ChPL1nrO9acvfezAQ/ZM5fXoI9eHjwlWYguHxWpicgNZpqgmDwa7aCigLXXFGQcCgfMZhLqpkdVi5JUBfOvIpaCJWlVNbipXUpJoKaxgHWGA0fjV/cD2Pa85UBdxRT6evFb4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761256674; c=relaxed/simple;
	bh=gDkOmzoP14z1GCVebJrdLtoXgwM0uE5dVdX8pgmVjII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdHYBh6cHTtONUwwxGgTnBG43uUw4A10cf2v3sXOpH/HPtmV/tMKqwMsPZR2u1hOqnjixKtUsrD2YwX06oDTM73MqWjeFD/KG/ERGUKoPx90Rs3bmHS39fPWfTgaOkTZVcII+0nnYAV2hfxqMDm/N5i58Vtg4KT9j22gFOar27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq+/+ze9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-269af38418aso17003295ad.1
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761256672; x=1761861472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9WG+KOo9BCHH3lanx8NKocqYMchJGDyHo5r4QpwNmk=;
        b=jq+/+ze9q9lnk6F0AUcW9fTDPFGk2+5tkDNwkYDv0a7p3BG8i+2xKgMR2dtE291Psw
         gHeHZ5QGDRPmRrq6J3G7L0/Jt3zPgjdoJx9WwvXEAoXOO49s/XNsJnHjeIR+KfEDk6nz
         qDoqQy1r0GJcfYlsVdKyiukow4DVP5shOrD6ivJ1GDiI0NCqoV+1CjK3nlQLTnbJTWOs
         NLOPMWA5XsRrfV3acQj66zpmtMM9dniSyJjsmGWD0AZYril80GuwZyMcUOXC/T1g1oh0
         VUMQtij6w62KgT7FXvSrFBvpn0AOt4YjkCFqHpfT2jRk8pbe7OplP5vC3EETWTLsHUd3
         wcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761256672; x=1761861472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9WG+KOo9BCHH3lanx8NKocqYMchJGDyHo5r4QpwNmk=;
        b=tN8xrSZbeIAJxrcbkqO8OTLz/FBqaV3i5+kwyoNLgm3WPcKZ9aMGE8MPN1i8/SttcI
         61cWWPuYFugZLQP/Rs5PZjVjysG3+FTc7eKDCb+KtyE7IqJtO1KbgmqvNkON6XgQwbsv
         KDDgmesrnEfQDu5A9wBmP7xh+5NvzvfY0LDRbgITvwBS++y4HqzdXWZSq8RGryTfPRf/
         mIg22w41A0D46TraTsVuBL4IhHIBx1WNh3Tzj/On0eWqGydxLRh24jJHekzpx1nzshES
         EEUCHPwDVh+15mPopMMQu37y8JMQljFGb8J1rtRWgDQhH4rn+kYQ68iB82kBBv7S0Fx9
         6dbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0HXn6rzFPo3XYM17XOGF2DPjr4Ds0QQEODdrGCFNGSWWe18aTgBuh6/R8GvrxVYU+KWV7wfS7y6qL@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9fpw2DGu8lHdBnhYK3rWE/3m4V8WUkxQsJh40rC0I5BiCJvB
	LmfaOYms4D9Ns8DpU0eYVT6/PQTMRs4hWkzSx7PhP/qJNCvmX02+jQqlVUTJAaKU5GDb62J9Kv7
	s/A/2GKGF4Vwaz4KJjtenuE89oe9HctfeWA7y
X-Gm-Gg: ASbGnctLtR4KJ5TzSw75cAXVkN3a+jlCGWdfeJQBvX7AD3m8YX802GMzCOrSqLYP0y1
	5NhOk4smqcgC9s/y+tXXfH4J7eYVbtW5LKLcuNHCl5auNDmjucoDI859VI1IPTHUEgRd2u+U2kx
	taZRx4Rp03BOUMuPwmqgaCSCsmc93xfR1AbPvmWM9LeNq9oybGSzXijr3DSq5ZcQtcA92QT7Oga
	8lqj/+TTO1wXdU9o82j5J42eRdYKkLa2qeIdTwp+a6CfdwTYNaSD/4EUk0RjXEII78vIMlHksmo
	uMzoeJC4M0uluNNIuXLAQ3lQGADKtQ==
X-Google-Smtp-Source: AGHT+IHT71u2lGyclYwLkstTK2gIVOr5R+zvwzIUtz5iOzpZIwYnd2M+Eglq5zNM3G0PQ0V1gAnlJXHXBnY0BFqhWsQ=
X-Received: by 2002:a17:903:19e5:b0:24e:593b:d107 with SMTP id
 d9443c01a7336-290caf85236mr311281715ad.32.1761256672434; Thu, 23 Oct 2025
 14:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_eGSkXO1F168tCKd37hNqTVhPLprWpXOM-Z3KN29dB=Zg@mail.gmail.com>
 <20251023204833.3749214-1-kuniyu@google.com>
In-Reply-To: <20251023204833.3749214-1-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 23 Oct 2025 17:57:40 -0400
X-Gm-Features: AS18NWDsx_UZlCPi1WP_2w7PSPPLODZDwSODMiCEI-KmDydayqlE_1iKzCLPUuI
Message-ID: <CADvbK_eObVPH9GJfkpCsHt1obg6sDY0jQ0cpA=c6yyjRiQEaYw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuni1840@gmail.com, linux-sctp@vger.kernel.org, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Xin Long <lucien.xin@gmail.com>
> Date: Thu, 23 Oct 2025 15:55:57 -0400
> > On Thu, Oct 23, 2025 at 3:22=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > On Thu, Oct 23, 2025 at 12:08=E2=80=AFPM Xin Long <lucien.xin@gmail.c=
om> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 6:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@g=
oogle.com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmai=
l.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuni=
yu@google.com> wrote:
> > > > > > >
> > > > > > > sctp_accept() will use sk_clone_lock(), but it will be called
> > > > > > > with the parent socket locked, and sctp_migrate() acquires th=
e
> > > > > > > child lock later.
> > > > > > >
> > > > > > > Let's add no lock version of sk_clone_lock().
> > > > > > >
> > > > > > > Note that lockdep complains if we simply use bh_lock_sock_nes=
ted().
> > > > > > >
> > > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > ---
> > > > > > >  include/net/sock.h |  7 ++++++-
> > > > > > >  net/core/sock.c    | 21 ++++++++++++++-------
> > > > > > >  2 files changed, 20 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > > > index 01ce231603db..c7e58b8e8a90 100644
> > > > > > > --- a/include/net/sock.h
> > > > > > > +++ b/include/net/sock.h
> > > > > > > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net,=
 int family, gfp_t priority,
> > > > > > >  void sk_free(struct sock *sk);
> > > > > > >  void sk_net_refcnt_upgrade(struct sock *sk);
> > > > > > >  void sk_destruct(struct sock *sk);
> > > > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_=
t priority);
> > > > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t pri=
ority, bool lock);
> > > > > > > +
> > > > > > > +static inline struct sock *sk_clone_lock(const struct sock *=
sk, const gfp_t priority)
> > > > > > > +{
> > > > > > > +       return sk_clone(sk, priority, true);
> > > > > > > +}
> > > > > > >
> > > > > > >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long =
size, int force,
> > > > > > >                              gfp_t priority);
> > > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > > index a99132cc0965..0a3021f8f8c1 100644
> > > > > > > --- a/net/core/sock.c
> > > > > > > +++ b/net/core/sock.c
> > > > > > > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct soc=
k *sk)
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > - *     sk_clone_lock - clone a socket, and lock its clone
> > > > > > > - *     @sk: the socket to clone
> > > > > > > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, =
etc)
> > > > > > > + * sk_clone - clone a socket
> > > > > > > + * @sk: the socket to clone
> > > > > > > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > > > > > + * @lock: if true, lock the cloned sk
> > > > > > >   *
> > > > > > > - *     Caller must unlock socket even in error path (bh_unlo=
ck_sock(newsk))
> > > > > > > + * If @lock is true, the clone is locked by bh_lock_sock(), =
and
> > > > > > > + * caller must unlock socket even in error path by bh_unlock=
_sock().
> > > > > > >   */
> > > > > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_=
t priority)
> > > > > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t pri=
ority,
> > > > > > > +                     bool lock)
> > > > > > >  {
> > > > > > >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > > > > > >         struct sk_filter *filter;
> > > > > > > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struc=
t sock *sk, const gfp_t priority)
> > > > > > >                 __netns_tracker_alloc(sock_net(newsk), &newsk=
->ns_tracker,
> > > > > > >                                       false, priority);
> > > > > > >         }
> > > > > > > +
> > > > > > >         sk_node_init(&newsk->sk_node);
> > > > > > >         sock_lock_init(newsk);
> > > > > > > -       bh_lock_sock(newsk);
> > > > > > > +
> > > > > > > +       if (lock)
> > > > > > > +               bh_lock_sock(newsk);
> > > > > > > +
> > > > > > does it really need bh_lock_sock() that early, if not, maybe we=
 can move
> > > > > > it out of sk_clone_lock(), and names sk_clone_lock() back to sk=
_clone()?
> > > > >
> > > > > I think sk_clone_lock() and leaf functions do not have
> > > > > lockdep_sock_is_held(), and probably the closest one is
> > > > > security_inet_csk_clone() which requires lock_sock() for
> > > > > bpf_setsockopt(), this can be easily adjusted though.
> > > > > (see bpf_lsm_locked_sockopt_hooks)
> > > > >
> > > > Right.
> > > >
> > > > > Only concern would be moving bh_lock_sock() there will
> > > > > introduce one cache line miss.
> > > > I think it=E2=80=99s negligible, and it=E2=80=99s not even on the d=
ata path, though others
> > > > may have different opinions.
> > >
> > > For SCTP, yes, but I'd avoid it for TCP.
> > Okay, not a problem, just doesn't look common to pass such a parameter.
>
> Another option would be add a check like this ?
>
> ---8<---
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c7e58b8e8a90..e708b70b04da 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2904,6 +2904,12 @@ static inline bool sk_is_inet(const struct sock *s=
k)
>         return family =3D=3D AF_INET || family =3D=3D AF_INET6;
>  }
>
> +static inline bool sk_is_sctp(const struct sock *sk)
> +{
> +       return IS_ENABLED(CONFIG_SCTP) &&
> +               sk->sk_protocol =3D=3D IPPROTO_SCTP;
> +}
> +
Oh, better not, I'm actually planning to use sk_clone() in quic_accept() :D

https://github.com/lxin/quic/blob/main/modules/net/quic/socket.c#L1421

>  static inline bool sk_is_tcp(const struct sock *sk)
>  {
>         return sk_is_inet(sk) &&
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 0a3021f8f8c1..ed5f36c6f33e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2470,10 +2470,10 @@ static void sk_init_common(struct sock *sk)
>   * If @lock is true, the clone is locked by bh_lock_sock(), and
>   * caller must unlock socket even in error path by bh_unlock_sock().
>   */
> -struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> -                     bool lock)
> +struct sock *sk_clone(const struct sock *sk, const gfp_t priority)
>  {
>         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> +       bool lock =3D !sk_is_sctp(sk);
>         struct sk_filter *filter;
>         bool is_charged =3D true;
>         struct sock *newsk;
> @@ -2597,7 +2597,8 @@ struct sock *sk_clone(const struct sock *sk, const =
gfp_t priority,
>          * destructor and make plain sk_free()
>          */
>         newsk->sk_destruct =3D NULL;
> -       bh_unlock_sock(newsk);
> +       if (lock)
> +               bh_unlock_sock(newsk);
>         sk_free(newsk);
>         newsk =3D NULL;
>         goto out;
> ---8<---
>
>
> >
> > There is also bh_unlock_sock(newsk) in the free path in sk_clone(),
> > does it also need a 'if (lock)' check?
>
> Good catch.  Will fix it in v3.
>
> Thanks!

