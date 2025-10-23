Return-Path: <linux-sctp+bounces-674-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD54C0329F
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 21:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF541A648A1
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80B34CFB7;
	Thu, 23 Oct 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vN21+PCD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C534B433
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247369; cv=none; b=Jjq6gG+8OQEvY63+Q6TdEHofRiY414ouFMNy5vdk4LtYXrynH6hCnbCFmUJPsxCqFgcUqkBprTbcQrW9+XQkfZYt6CJQyHy8oh8Ai1xARTshp0krPwJcc20pRvG0/gv1LbF4LPAiL9JweQvwU4/46S1hyGSFETX61gHFN/SAdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247369; c=relaxed/simple;
	bh=RI/ibw6eqY5V3UF1zKJHWHcRVM8wwZGWnP2ES7ZEi6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZUtMCpyQH321ZP1FBzbOueyxw+VmJz7tN9FxHJ8oKEtHIrpedFKgjEE+Tm3PazlqIaFm+4l9isSNfYNYnrr9MfC2b/6lP9Z8KkOmVigAtxYZSyFAj+yT/BVs+N7St4Tg5JhL+pCFXtwZEdpdOJW39Ngnme39OdUmciAqIca5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vN21+PCD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so866314a12.0
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761247367; x=1761852167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypbb0xmdJO9/GhZRCL+HhBJmndv+E1fqLVhOYRgfu/c=;
        b=vN21+PCDNCYmf0FjiXaswvlIXvjJ5w3u6a2QubH6bmh0yFI4BjeecE+8y0+HEfzpVz
         7KP00ki26OiTAk824zrMMbTLGFkPJl0uW4nkUt4xgjnkx5xbPfY96rFe49qFl4l3kuJl
         r/ZFyGI5Z5ewsU7IMVcVg/BboaMQiumQVDmlhEZCBCmVJwHOsUbbDZuREKs7S3llcSaa
         v0PuIAWgh/Wy0u5kxV7ck+QiFcGHMEpbJxiek9WugKVLib7ckvUpCAmagxC5IfOnJMh5
         OCP5ez/5S3FlB7NdUDJxeUHJLT6K6TN+anYfFGLY5YZfpMEBjrmjnfYUbW6SM4PbbGR7
         QTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247367; x=1761852167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ypbb0xmdJO9/GhZRCL+HhBJmndv+E1fqLVhOYRgfu/c=;
        b=FQLvlu3eSSH2tNY8n330g6U/plnB2FFllwElIblA0LKcAP7HUgzXgLTKz++zbWT60g
         fXcWuKWbM8w6eAE9iHSoNFnQRMYolfFknPRNdpKmP8D8+I3wPelRMYOk0qEQGfcxQ/4N
         n7jGFckJF1sNucU6KiBOIeY72+Bf9rUUuzlVz2M0eHwDWLm3TXvzr3kVfo60CqrNauHI
         pDJiUZUB2bnqaULUFZMgPo8zRKr1Ly7Qnbn2srar7XLyr49DR9rk05qxnVy1Yx3dsUxF
         nOCi4jAvaz51OGC3z9B7ckXBAPgBdu8EQnsyWQqkefjO+sLTgLMDKSmgU3Prlh08R7Kk
         KbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRkmZtarM0pTIHeYIU+sKChSd8ZUE0ivLgWeaJIUxjYdZQDbiKdASW3Z+UM6G3zO4G7/1dephQj4Gb@vger.kernel.org
X-Gm-Message-State: AOJu0YxXouOr572oRIh0l0PhD6nofVLnmHYaYJ1mAtlmHwt0iXtwu6mm
	S1cIAejuyI2LhwWsJKXsTtR7pZv6XMCep0Z3EOCiVMsHQx1dIWg/1iVn8QJHf6Jb+d1rApzOFPo
	jXty4Qi5pQJeHHlPiFVK0BVxNX9N5PDDjXElETW7d
X-Gm-Gg: ASbGncvENxYvz9JsdZTtJhgJwKLrsdfAlpNPsZ0JGNZjYRGunHGLENlryxcZECMjLC1
	cp6ajPexlVwHkrRsz39M1NU8SLEQc5n5igjU0uI1hbzzKvf/nBp9H9n33K06Zz6mNeFGXvv1/XB
	1uDMpayurxj6rotSD4di34FSS0y4mHu5Aq+dHR2hkmIslWECbnh3GJi71KYN2RHfd0jgjWWDUh6
	hxxw8I2SZLZhDwPeLRw/PIFtnR6ruHSYC2F6ycdhl3+C53e74ZEJCiZxPFPJ1TrQM9sqL0jd0Xa
	iYtiEfWle+x9SgU=
X-Google-Smtp-Source: AGHT+IHO7XiADiu4yp32jG4ihDazzS4PDYyxG6NtOND6r4Zd1wugGLjxr9fVc1NnK4gJyXXbozISr1ChDDM4VvBx3ZM=
X-Received: by 2002:a17:903:2f88:b0:235:e8da:8d1 with SMTP id
 d9443c01a7336-2946de3ddbcmr30826575ad.8.1761247366766; Thu, 23 Oct 2025
 12:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
 <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
 <CAAVpQUCCT-3tV+i19gNjvcQUZkHVUEOuPohiLgqD56MvUmQO4A@mail.gmail.com> <CADvbK_crn204Q5Ce6npx=zPuWfEb8NAV9gPveDUMHQgOB_tYeQ@mail.gmail.com>
In-Reply-To: <CADvbK_crn204Q5Ce6npx=zPuWfEb8NAV9gPveDUMHQgOB_tYeQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 12:22:34 -0700
X-Gm-Features: AS18NWBz37BhY05EoOYSkf6RbHaamRAASowMslR24YWyDSUEE_MtssRfEc4PFwk
Message-ID: <CAAVpQUB1c5Y0w_ddrFfJnvOQGTi3SsrhgsbB9ni7KrOzx9Tejg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Wed, Oct 22, 2025 at 6:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmail.com>=
 wrote:
> > >
> > > On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> > > >
> > > > sctp_accept() will use sk_clone_lock(), but it will be called
> > > > with the parent socket locked, and sctp_migrate() acquires the
> > > > child lock later.
> > > >
> > > > Let's add no lock version of sk_clone_lock().
> > > >
> > > > Note that lockdep complains if we simply use bh_lock_sock_nested().
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > >  include/net/sock.h |  7 ++++++-
> > > >  net/core/sock.c    | 21 ++++++++++++++-------
> > > >  2 files changed, 20 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index 01ce231603db..c7e58b8e8a90 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int f=
amily, gfp_t priority,
> > > >  void sk_free(struct sock *sk);
> > > >  void sk_net_refcnt_upgrade(struct sock *sk);
> > > >  void sk_destruct(struct sock *sk);
> > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t prio=
rity);
> > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,=
 bool lock);
> > > > +
> > > > +static inline struct sock *sk_clone_lock(const struct sock *sk, co=
nst gfp_t priority)
> > > > +{
> > > > +       return sk_clone(sk, priority, true);
> > > > +}
> > > >
> > > >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, =
int force,
> > > >                              gfp_t priority);
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index a99132cc0965..0a3021f8f8c1 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
> > > >  }
> > > >
> > > >  /**
> > > > - *     sk_clone_lock - clone a socket, and lock its clone
> > > > - *     @sk: the socket to clone
> > > > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > > + * sk_clone - clone a socket
> > > > + * @sk: the socket to clone
> > > > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > > > + * @lock: if true, lock the cloned sk
> > > >   *
> > > > - *     Caller must unlock socket even in error path (bh_unlock_soc=
k(newsk))
> > > > + * If @lock is true, the clone is locked by bh_lock_sock(), and
> > > > + * caller must unlock socket even in error path by bh_unlock_sock(=
).
> > > >   */
> > > > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t prio=
rity)
> > > > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> > > > +                     bool lock)
> > > >  {
> > > >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> > > >         struct sk_filter *filter;
> > > > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock=
 *sk, const gfp_t priority)
> > > >                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns_t=
racker,
> > > >                                       false, priority);
> > > >         }
> > > > +
> > > >         sk_node_init(&newsk->sk_node);
> > > >         sock_lock_init(newsk);
> > > > -       bh_lock_sock(newsk);
> > > > +
> > > > +       if (lock)
> > > > +               bh_lock_sock(newsk);
> > > > +
> > > does it really need bh_lock_sock() that early, if not, maybe we can m=
ove
> > > it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clone=
()?
> >
> > I think sk_clone_lock() and leaf functions do not have
> > lockdep_sock_is_held(), and probably the closest one is
> > security_inet_csk_clone() which requires lock_sock() for
> > bpf_setsockopt(), this can be easily adjusted though.
> > (see bpf_lsm_locked_sockopt_hooks)
> >
> Right.
>
> > Only concern would be moving bh_lock_sock() there will
> > introduce one cache line miss.
> I think it=E2=80=99s negligible, and it=E2=80=99s not even on the data pa=
th, though others
> may have different opinions.

For SCTP, yes, but I'd avoid it for TCP.

