Return-Path: <linux-sctp+bounces-653-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDAABFA999
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D3C18859B1
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 07:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F82A2FABF8;
	Wed, 22 Oct 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUY/wzPi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F42F8BF7
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118580; cv=none; b=dGN1RqVVTYYZ48BtQoY6aCa6vBUcLATFt1421DkdbOkQFfX13o5ZM2LcsFATS7z7zhCSSgJImV/U1pmG6m62URtFQlfofyciKPdHC/LXjd6QI+dFSR0SO2qKhADXsfNJE+RUjmpXB1kKq5e8oAAfo9aZa+NcUcsZHT4pq7zv+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118580; c=relaxed/simple;
	bh=HtL0aGay5CU8yJyT2Iu8i0PDBnx2pTOwklzMoFah6lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as2fr4AFuP/39k3BvrLEt1FsJM4A2BW70pfYMAzaVUwfLTBrRFsOKCywyzruWYibZYKcjRrlzm3X5KgUxbW6XsTYtFuYwPOCWoraXLShYu20m2qT2wAJ22sjli28SlaTJZxzxirbYvPQzWl/mzU5cwnVNSVVjYetVJjq7KIZtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUY/wzPi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso547538a12.2
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761118578; x=1761723378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne8X6oQ4TY+MTpe6fx1BsCXP/E1vxBBg8ZkVw63H44g=;
        b=uUY/wzPifgUsJFUghCJryyQaEuc6ihbjoqkj6Wkcqzd1/nrYhrL4eIr+4Un9uJs5z3
         fEMwkIBT/rGMMXaLONqULUCRot4M+tiRTBn4mZVSNpfl8g/w4wVMPovgvilM3ZubqYz9
         m1wieEl+be7LC2nrn8jXhXlhNnNwejhHSNotWEJDgtvVRgt9rjWIFygOzi0J1MeSTs0F
         p/Dc4mi9PMI0d+4mdVIpplQD1Gg0WQ5r9LkzcqWNlbDjPCK0vZ96w4pkUY+pOp7gF3KG
         uc5xlVZYdDbMbW5hpmysJ8aqgebAxyTuUzw6N0wZFU9q03ItESYdChqjolr933FVMKf7
         lxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118578; x=1761723378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne8X6oQ4TY+MTpe6fx1BsCXP/E1vxBBg8ZkVw63H44g=;
        b=FrOcl6LwXc632/4psYXW+NgVsF/aEnLJbtcJdI3ZM1TX5S6UpsibDjx2eMGCc5noay
         P2DGHAIUtckwBoNy2W1Fw9oYcxD4DIrN1oKxtxwWZqMZJJNpV58s5HvPJ/+4sQPvrYq3
         9yviXpfkHHnpD6VU5TUQ9qkS39X5H8htCYG+Jit32LrIy+YBIYjidbQYI3z7CV+AGZ3s
         2HZgolVorIfBMf/OpPlFL3ZC10Bxg2ASc+b7VY78/J0jXZndsMXdPpqdRqRGcgWpqCg5
         l+RJMSCEEF//LzKYEQPQqpD7OCSQGdomUIk1HTBclr02vKo/LodIXsnvBCOU3Go29SPq
         J8cA==
X-Forwarded-Encrypted: i=1; AJvYcCWNqrcLu7wEyQWmezoGtVUCBUOdGae/U0SnY+jqxRCmxz/Pr1ph4fkLgpF6h+OVMAp87Z59+nvlLKwy@vger.kernel.org
X-Gm-Message-State: AOJu0YyAr203NWY9b3RCUE8GOZzTNLIo/es7jUWmvsUykqfKXJkjHCsz
	s5hbwO859efk1H5Jc85A/n0viLTZW2czZnAtt0ICudEfnDR5d+K5pTlxUcKRIGiP6vy03cEYy5P
	Uhx1Z/XdX5zFeJBqU+HXdE0PhqnqBgRI5Oo4DUXdR
X-Gm-Gg: ASbGncslgKpVCAobphc6oDdWyL+5B3jPhYTduV3QC/muW2pE+yeNyAT+uB9urDZ28uY
	AV0sdy6PNscyuHGI8zC7bg1CPINukZ7aArAhelSLj99KDRgEwOv58XLfuXQu0dv/V2v9HjWslUm
	yAzr63idAV9mtI/STy5RhqRvB0SixCDcfqANCTlcerCgEK0MtLSE+INAmwkp6mDznPxFnePUCjV
	nWnW1qrq0VtTCyyGO9QaZJIbhtIyUqUmV7tvabPleUqgtUPhTCRycK11xDiVCvGhnb9GSMj6dgF
	WJMC8nnr0jMsX/KbLA==
X-Google-Smtp-Source: AGHT+IF46vH0gAmljTCW6BchroEOcDOXkUgTIvPI2YZtYG9N39bSh/pHYkEmo3qgB6WjMhviNr012jnggIGiG1snhbI=
X-Received: by 2002:a17:902:e74a:b0:267:776b:a315 with SMTP id
 d9443c01a7336-290caf844ddmr249836795ad.32.1761118577438; Wed, 22 Oct 2025
 00:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com> <20251021214422.1941691-8-kuniyu@google.com>
In-Reply-To: <20251021214422.1941691-8-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 22 Oct 2025 00:36:05 -0700
X-Gm-Features: AS18NWBKLOhVXyIMHsuYPqRGPiGNf1_PCd92__b5F-phGX71rLqYea5U9RwDCTA
Message-ID: <CAAVpQUAxenM9_MRAo3z5ChFnr3-DN8yq+mR2xC4+ceuOaSL3=A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:44=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_do_peeloff() calls sock_create() to allocate and initialise
> struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
> and sctp_sock_migrate() overwrite most fields.
>
> What sctp_do_peeloff() does is more like accept().
>
> Let's use sock_create_lite() and sctp_clone_sock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/sctp/socket.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 826f17747f176..60d3e340dfeda 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -5671,11 +5671,11 @@ static int sctp_getsockopt_autoclose(struct sock =
*sk, int len, char __user *optv
>
>  /* Helper routine to branch off an association to a new socket.  */
>  static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
> -               struct socket **sockp)
> +                          struct socket **sockp)
>  {
>         struct sctp_association *asoc =3D sctp_id2assoc(sk, id);
> -       struct sctp_sock *sp =3D sctp_sk(sk);
>         struct socket *sock;
> +       struct sock *newsk;
>         int err =3D 0;
>
>         /* Do not peel off from one netns to another one. */
> @@ -5691,30 +5691,24 @@ static int sctp_do_peeloff(struct sock *sk, sctp_=
assoc_t id,
>         if (!sctp_style(sk, UDP))
>                 return -EINVAL;
>
> -       /* Create a new socket.  */
> -       err =3D sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, =
&sock);
> -       if (err < 0)
> +       err =3D sock_create_lite(sk->sk_family, SOCK_SEQPACKET, IPPROTO_S=
CTP, &sock);
> +       if (err)
>                 return err;
>
> -       sctp_copy_sock(sock->sk, sk, asoc);
> -
> -       /* Make peeled-off sockets more like 1-1 accepted sockets.
> -        * Set the daddr and initialize id to something more random and a=
lso
> -        * copy over any ip options.
> -        */
> -       sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
> -       sp->pf->copy_ip_options(sk, sock->sk);
> -
> -       /* Populate the fields of the newsk from the oldsk and migrate th=
e
> -        * asoc to the newsk.
> -        */
> -       err =3D sctp_sock_migrate(sk, sock->sk, asoc,
> -                               SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
> -       if (err) {
> +       newsk =3D sctp_clone_sock(sk, asoc, SCTP_SOCKET_UDP_HIGH_BANDWIDT=
H);
> +       if (IS_ERR(newsk)) {
>                 sock_release(sock);
> -               sock =3D NULL;
> +               *sockp =3D NULL;
> +               return PTR_ERR(newsk);
>         }
>
> +       lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
> +       __inet_accept(sk->sk_socket, sock, newsk);

Oh I assumed __inet_accept() was exported to MPTCP,
but it's built-in, and SCTP=3Dm needs this.

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 77f6ae0fc231..ffd4d75d0a7a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -788,6 +788,7 @@ void __inet_accept(struct socket *sock, struct
socket *newsock, struct sock *new

  newsock->state =3D SS_CONNECTED;
 }
+EXPORT_SYMBOL(__inet_accept);

 /*
  * Accept a pending connection. The TCP layer now gives BSD semantics.

--
pw-bot: cr

