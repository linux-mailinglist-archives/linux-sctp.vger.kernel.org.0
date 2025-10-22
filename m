Return-Path: <linux-sctp+bounces-666-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B4BFE75B
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 00:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700D23A245E
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4372FF15F;
	Wed, 22 Oct 2025 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjRyB3Sr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6522D9499
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173822; cv=none; b=JfAkMzILRbvzEyvSrYsnQOLSLbPO/i6yFqFtJND6oeJ8NJq3vu+Ue9zNj2zkeXA0hNJyzTlrev5R3znX32eHtOR6jOYbOOCOfQlw0Qw91cJN3IWgBjN2ih8hEP5yPhDpOsS5r5tW2pAXQnS2QQT9gTQ3rd4QAqfsxiqv/Azambo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173822; c=relaxed/simple;
	bh=trZcEH5fbIfpy/dy4uIh80UnlmTcj8EtKaSfbZVY90c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYJyVB3aIoMVI/JHHNQtOoCzC0SUSF06F1JaIhkT2FK4N1Y44wfemWQYdxrM+w/FjWQ61N3jXpA2Hb0RxRNjQwpjxTYtZu6aUb3po1LWUtplGikcfqJBljyIz2eMfDs31mOPMOginy+ILiACdks92pbHQW7y5X1YmNS7yoa5a14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjRyB3Sr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so67505a12.1
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761173820; x=1761778620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0E4BJaLARHiiBGcGtJuIEWLcE6spNNO+nXwVK4hnAA=;
        b=yjRyB3SrHAzUgxF19tdzC8rd47tPMrErsaKsfPRfu8dNjMebsFgTP4ABSbwSQoHp3c
         liOfqSaK5VfGWpPGGvM/RC7MXQUpnWQJiY3Kxpyu2+kE8njXI7GSSdHaYtfjQCTG6BlX
         mijMWu4HmGhWndZcJpCQID2KxmwIsOEiA3RMmgKJ7HfK4ylCfskn6BoCPSVcYEqqPiFr
         IvQuCEeLalDwLJvo7Mr0HJji7INpJIwmp2C64Z8MLEhiopEw8dmz8UgHVWtNPGD2c2rI
         VC+mTcdR/qrZNHBa9qbqJvkahdnLhlWDGwnKyR9UDBQZstpDgCa783VdKNJ1R5awzCjk
         PDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761173820; x=1761778620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0E4BJaLARHiiBGcGtJuIEWLcE6spNNO+nXwVK4hnAA=;
        b=DkQnpelfmbKwLE2+elPNU6P+xQ0K269PRL8onFVnkXEFcmGJd4kiLM3Ugksj9AiG6G
         WOxlqegKaWyINhpe7n5I5FQxPgGsGVW59+VZsdUi5sNW1IZw9S25LmCDSCdA48Hz7v+K
         G5PAm25fkYHklC8MqZgbGRnAfYDrUjw91iB36GlvA6uy7xi2MQS9eXDPFR7EtlJseNzC
         rwdHLrK7aijfv8QdMKS3/2M0TGt7+yKZy8ZYmoKaiXNAI6+gPNqbAVr8E/ppDkNdADlf
         QUsqb+xJ7y1+8Bi2+VU/JtT3DZDV6+ExiZ7oNg76kLj8aQZamvBuLG0j/SzCEV3RABQB
         PiLA==
X-Forwarded-Encrypted: i=1; AJvYcCXKfrYlMbgN3/TqaqTLc21EpR/ogOlG6gdZ5/UG8RIgyjgzQHEpn4UIZcWcomp6hS18dLNEKzVLHtlD@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRHatannU/9uFxki9lmRdOCSbFmf1oV0LhEdnqcXVa/uLgLdd
	EDWU6fB6huJNcL7Ph9PyK2Z6PDwI/LdGzw9Br8LcOPYt14R1nGu9whY3mTYdGeGqbAC+VY8wTq/
	FjxZmk4+8u3pRY9kYXn2BhmsCs1Cba+NzY18p3CrF
X-Gm-Gg: ASbGncuBhgM4nFXY34PEOz2fzN2h4OUft1leJPQBPn/6VOegHPmv7sSbEDgnbPEQA0x
	CFTEedZ8WHmz7Aj/oXGAOkMUWGSsrN8xki1OqiOCwF2mzOWNHQjbuEDesO0yv11ChC9vZCzVgR4
	RhIeh4+4D+SEYGAflNhFwFmNnMBwQ2ZnoDT5elEft5t8Y4Hve4FxzgBllcDAphVS8UWV0CxpPwR
	7mFFvlEErP5hx4rXctcY6VsWs7RBeflE+8fV582ESE9ZiBUZmzQYVnGR/agiZc+3mS5yiNhKTZu
	rTO+PmcCNLoTRr0=
X-Google-Smtp-Source: AGHT+IGxpDwt4YvjZ56YxobTy3ltNAHy7C7Pud3TA9U1beR9QmaCB+kX/1DAeKFCc4faFAeG8XREdykN8LEjQHPkT0c=
X-Received: by 2002:a17:902:f551:b0:290:9576:d6ef with SMTP id
 d9443c01a7336-2946e27fb28mr4220875ad.54.1761173819769; Wed, 22 Oct 2025
 15:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
 <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
In-Reply-To: <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 15:56:48 -0700
X-Gm-Features: AS18NWD_AvQFuKAQMs4vtLDRJ1JQ043_7Ul1gYcUTwYE2sK9UaiNk_RN_p3beqA
Message-ID: <CAAVpQUCCT-3tV+i19gNjvcQUZkHVUEOuPohiLgqD56MvUmQO4A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:04=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > sctp_accept() will use sk_clone_lock(), but it will be called
> > with the parent socket locked, and sctp_migrate() acquires the
> > child lock later.
> >
> > Let's add no lock version of sk_clone_lock().
> >
> > Note that lockdep complains if we simply use bh_lock_sock_nested().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/sock.h |  7 ++++++-
> >  net/core/sock.c    | 21 ++++++++++++++-------
> >  2 files changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 01ce231603db..c7e58b8e8a90 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int famil=
y, gfp_t priority,
> >  void sk_free(struct sock *sk);
> >  void sk_net_refcnt_upgrade(struct sock *sk);
> >  void sk_destruct(struct sock *sk);
> > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority=
);
> > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority, boo=
l lock);
> > +
> > +static inline struct sock *sk_clone_lock(const struct sock *sk, const =
gfp_t priority)
> > +{
> > +       return sk_clone(sk, priority, true);
> > +}
> >
> >  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int =
force,
> >                              gfp_t priority);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index a99132cc0965..0a3021f8f8c1 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
> >  }
> >
> >  /**
> > - *     sk_clone_lock - clone a socket, and lock its clone
> > - *     @sk: the socket to clone
> > - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > + * sk_clone - clone a socket
> > + * @sk: the socket to clone
> > + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> > + * @lock: if true, lock the cloned sk
> >   *
> > - *     Caller must unlock socket even in error path (bh_unlock_sock(ne=
wsk))
> > + * If @lock is true, the clone is locked by bh_lock_sock(), and
> > + * caller must unlock socket even in error path by bh_unlock_sock().
> >   */
> > -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority=
)
> > +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> > +                     bool lock)
> >  {
> >         struct proto *prot =3D READ_ONCE(sk->sk_prot);
> >         struct sk_filter *filter;
> > @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *sk=
, const gfp_t priority)
> >                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns_track=
er,
> >                                       false, priority);
> >         }
> > +
> >         sk_node_init(&newsk->sk_node);
> >         sock_lock_init(newsk);
> > -       bh_lock_sock(newsk);
> > +
> > +       if (lock)
> > +               bh_lock_sock(newsk);
> > +
> does it really need bh_lock_sock() that early, if not, maybe we can move
> it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clone()?

I think sk_clone_lock() and leaf functions do not have
lockdep_sock_is_held(), and probably the closest one is
security_inet_csk_clone() which requires lock_sock() for
bpf_setsockopt(), this can be easily adjusted though.
(see bpf_lsm_locked_sockopt_hooks)

Only concern would be moving bh_lock_sock() there will
introduce one cache line miss.

