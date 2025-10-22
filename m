Return-Path: <linux-sctp+bounces-665-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C9BFE5E3
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 00:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FF3E4E2728
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F730595A;
	Wed, 22 Oct 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo6csdbg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D51DF75C
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170687; cv=none; b=kcKDGyc2q0MHqTzOPLZvqKVOO5tFb5wwixw4QatpAggs3MDFCaG0axbpoy3m+aoZSKDc4Fvp/t47t2wDgliMmaIB12JTyPtGbZSp/V4XQM9ML77B1kXxPddCV02nPapbBtiYoC1XaGJ9AL3y99I8tqhHUNzYa9nt0WvGczq2UZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170687; c=relaxed/simple;
	bh=rWoxjM+PGkWnxVG9HCf/WTeZ1d8rynXAymqZXZkH/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HujPgTvsNeelH+5+3S9mdzy8/mTQ78cDvNT3DFxzjqnrUS2Ro/LqfskkduVhnBlmL0qEt3uSO3iv4J1Wi7l4Z0+A8OLw4UYmH7EIry9+EFgEYOLVMsruxB/ANZuhr6AWzy88vvBaaLhCoVyOxwqmM8ZvBkIn1NMNkLVYyu0QF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo6csdbg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290aaff555eso726785ad.2
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170685; x=1761775485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qAhHCjmv5gkTy1a2o5t0ybUHeKCUs2J/4+wewPDG1E=;
        b=Vo6csdbgj7bRbWF8hSQOERde3ehr1F4MhRW9oZ34N/OH+axgnWJ+drcHu8QfYUf12N
         dCcEtv/Rs/kvv0X7og0u3hIFu5BPF3ojKnn3aLqyKRtMhqmHBrt2IQYWPaN2b7GIQmZ1
         GoePD9wNT7hDeYD9M8lsO30L+HYeOzUTcOuv8s+EgLv79+/ip+Y+baJwv5oqhIC0NOqR
         QEPQE3o4YuQ46tINgFaHfA7omy7aORd80dtiKQAt9ryE7IbtXtF4VDpQYdD/oG3cZFIR
         uFs4H92j4BkwR4DsGZiWt/e7MP37msQLDkZn1GEbJ2gSIWkBULF6Z4s97SGZdp44c6iI
         iX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170685; x=1761775485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qAhHCjmv5gkTy1a2o5t0ybUHeKCUs2J/4+wewPDG1E=;
        b=H+UUcP63JptfI9QFejTkloVV6Yn6ATqBVEnkYL4SbkgN/6aLlZUul6dsbRj4EbR5T9
         yOthFQikd8y6BXZ5SpF9rNeI3pcyFcs1gmX8XIYEl2VE9yTYNwj/s1OmwZJqSCZDbb9U
         Id9v2PTVMzHUHrsmE+VSdO0xt9BZiFX1L8sOzbJNB90w69PoTuxvmdCdXa4txRF9co8v
         LDy6W3DxayuS9cqwfAZSVAyZAJk15RnU+OW24cy24lwuxL1Y1UkG4jmgAyCMp3SIASP6
         Waqv7dlL8/nUjj6h0GaBOYY0FUjUxbdbPJ4/jc092sUXy1h+6AgoCjEYkL2N1uiv6lAR
         Wqow==
X-Forwarded-Encrypted: i=1; AJvYcCX0bgySrUleXsVU0qRM4mxzXKtnl5wDcRXxFTDAv780ThdSDGL1TFu0BCBP+qtZ9Il1LYN8wgBMj0OW@vger.kernel.org
X-Gm-Message-State: AOJu0YxVL97ZzSYbkqeV2zt183OJkFc+Wr4kscgXEAsHVr23toc4LDBi
	8B+2a0ila/jOtbGumN4Yc4TN4+r0oWe+OiDDgtal4ysWCwGt5Yzlp960a8x8qFcurOXaQi/wEAE
	Gf5ksrWzON+apnOlOqisYA3pBsvT0Gi4=
X-Gm-Gg: ASbGncsXeKzU511vTUm8LNSrF/GuPnhsj2UWFWnKvRDBIFOs0QXR4AFPWuxm8Knpr89
	ywmy4IdReA9qfXVax1dZAot4o/7cjBmtsoRV3vUUmxnmrmW2UCFWw78q3dCJ6krzOk1Q097bhVZ
	PuSTzQB4TdwNO1tmunRYnCtcqv+0qybV9RruHQ6oJpzDy22cfJos1us2bfZ6ZDTt/mbfUjcK6nf
	EEIOfc4ZAh2IcW9JOgkD/JL4KLTPg2DX3AnnNL4U2jss80JrDKT63H0d+XSKsA=
X-Google-Smtp-Source: AGHT+IGYxCBoyWvdN/VSG8pA0bcr4l1tn5ydnzTb6Pqhj+Nv75wr3lySUDaqralKwaL5k87KpZ8lQzvkP5mpnSGUVHw=
X-Received: by 2002:a17:902:d506:b0:290:c5c8:9412 with SMTP id
 d9443c01a7336-290c9cf37demr306635615ad.5.1761170685314; Wed, 22 Oct 2025
 15:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com> <20251022211722.2819414-5-kuniyu@google.com>
In-Reply-To: <20251022211722.2819414-5-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 22 Oct 2025 18:04:33 -0400
X-Gm-Features: AS18NWAe9qGCNUxQfSkBRK1m93hvTLQCEetKXxHtraeklL49ANOwRClJpLhBhFg
Message-ID: <CADvbK_eYHxO4sU3sOvRvpOoKwdbvZBLq86bPtQ7kK1Zf5z0Juw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] net: Add sk_clone().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_accept() will use sk_clone_lock(), but it will be called
> with the parent socket locked, and sctp_migrate() acquires the
> child lock later.
>
> Let's add no lock version of sk_clone_lock().
>
> Note that lockdep complains if we simply use bh_lock_sock_nested().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/sock.h |  7 ++++++-
>  net/core/sock.c    | 21 ++++++++++++++-------
>  2 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 01ce231603db..c7e58b8e8a90 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1822,7 +1822,12 @@ struct sock *sk_alloc(struct net *net, int family,=
 gfp_t priority,
>  void sk_free(struct sock *sk);
>  void sk_net_refcnt_upgrade(struct sock *sk);
>  void sk_destruct(struct sock *sk);
> -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
> +struct sock *sk_clone(const struct sock *sk, const gfp_t priority, bool =
lock);
> +
> +static inline struct sock *sk_clone_lock(const struct sock *sk, const gf=
p_t priority)
> +{
> +       return sk_clone(sk, priority, true);
> +}
>
>  struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int fo=
rce,
>                              gfp_t priority);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index a99132cc0965..0a3021f8f8c1 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2462,13 +2462,16 @@ static void sk_init_common(struct sock *sk)
>  }
>
>  /**
> - *     sk_clone_lock - clone a socket, and lock its clone
> - *     @sk: the socket to clone
> - *     @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> + * sk_clone - clone a socket
> + * @sk: the socket to clone
> + * @priority: for allocation (%GFP_KERNEL, %GFP_ATOMIC, etc)
> + * @lock: if true, lock the cloned sk
>   *
> - *     Caller must unlock socket even in error path (bh_unlock_sock(news=
k))
> + * If @lock is true, the clone is locked by bh_lock_sock(), and
> + * caller must unlock socket even in error path by bh_unlock_sock().
>   */
> -struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
> +struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> +                     bool lock)
>  {
>         struct proto *prot =3D READ_ONCE(sk->sk_prot);
>         struct sk_filter *filter;
> @@ -2497,9 +2500,13 @@ struct sock *sk_clone_lock(const struct sock *sk, =
const gfp_t priority)
>                 __netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker=
,
>                                       false, priority);
>         }
> +
>         sk_node_init(&newsk->sk_node);
>         sock_lock_init(newsk);
> -       bh_lock_sock(newsk);
> +
> +       if (lock)
> +               bh_lock_sock(newsk);
> +
does it really need bh_lock_sock() that early, if not, maybe we can move
it out of sk_clone_lock(), and names sk_clone_lock() back to sk_clone()?

>         newsk->sk_backlog.head  =3D newsk->sk_backlog.tail =3D NULL;
>         newsk->sk_backlog.len =3D 0;
>
> @@ -2595,7 +2602,7 @@ struct sock *sk_clone_lock(const struct sock *sk, c=
onst gfp_t priority)
>         newsk =3D NULL;
>         goto out;
>  }
> -EXPORT_SYMBOL_GPL(sk_clone_lock);
> +EXPORT_SYMBOL_GPL(sk_clone);
>
>  static u32 sk_dst_gso_max_size(struct sock *sk, const struct net_device =
*dev)
>  {
> --
> 2.51.1.814.gb8fa24458f-goog
>

