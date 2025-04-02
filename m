Return-Path: <linux-sctp+bounces-469-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C35A79604
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 21:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1ED188C88B
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E131EA7D5;
	Wed,  2 Apr 2025 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPRpkg7Y"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52D2AF19;
	Wed,  2 Apr 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622871; cv=none; b=PQz1LZIIBpkt57j82sJYzbcg8WMZbwEkxAy8wNfZfqg6KRZ1DHUgqDXVL/vioD5HUlccCQbRSU2/6eMExyG/e3nll8pCrwQLqTpgA/mdVIW4gCEALhTJje5keo6ze+sJrT41sZU5XbmV0ZKGowCTygJLSmOi9zDkXJVawg0CVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622871; c=relaxed/simple;
	bh=HQYrUf3Z4hmCPC+YCNHa1UrZ8jCM/O8ktaJyaaK/ih0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjsbhG6NAgVfVfnApBM6JFkOdNb3Mjjnh6AYet03/DNZnTSe8p4yGzXn/XKIrokdoYLWwZ8Et7szqp3h/D8/CqQJ1oO1KfVBtofXJR4Xdt9gI2nxW75veci54l7I64WTq40RiOwTNBSdOKT11xDJtuxkJZ1LPf3ICWUc0wv1Ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPRpkg7Y; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so1023175ab.2;
        Wed, 02 Apr 2025 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743622867; x=1744227667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUS1J/z9kQSq8/4qkw4zIETjzLEsRP7cJOaot+HzQu4=;
        b=QPRpkg7YO04K4i4HBCrRyMVHktAD3FvaDpxWS7ECioowhpKNlFAIvQy66WHY20T2lh
         oLw7NtNSXU+l7WF0nQVP4jO6hEsvFwsbOEUbVIuNJBRhFm43OizYArC8bksAh9xb7/p4
         INSrSASlpz5I7x10vFlmUdNXiue5SKPvepI/Dj+R00itQPO0PeR5n+6OoyqNCky5wYMT
         pvuAz4dgbe8cQzaVxkCqgH7Kac2a84Cfo8HaVlId7Ufo7YiHmprKp6Qmna/RffFelPTg
         7745ijdr1V1gtTgtX1AF9ZSf9Wix6LYi54i2STKYx9rYq49csLwx4O0PD2PPbxFxd2d0
         JOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743622867; x=1744227667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUS1J/z9kQSq8/4qkw4zIETjzLEsRP7cJOaot+HzQu4=;
        b=qW6i+8uk/y4nwjd5ddf/+cNGrNew+yWlVQHonE+tBJIyRTxmoqey1OV7WZqsBMp0G8
         96Roetg1naUkIJEbbxzW6CEzJwDCD43Fur5afbQnvd+NJ5mJlFV7HRfsdd9aFgzW3rIG
         BLTf1kLhVsQ8MScyxYAFDfwspJhhOFR0DoxZjqguxB7BFjNvmgrKlFg7L802kj1aBrCY
         EVM1AUkN8K6tihaM6EmIrvzIg5KjlgsqRhwCOG/BL9edRNUjvWKurivLNEpYEfbflw04
         pEicrfEsW7uxYlqT+BdXVntPbeMVsjxD7FPpu48gpR+KE5yRvoVXVUYis4HhAYWX6Eaz
         OrYw==
X-Forwarded-Encrypted: i=1; AJvYcCUV/PZmRQwIbViIaLEpn03Zvt8zoUgTeUUr6oZTsAA4XcczyfUxM+kIYz9lDXPk9vhhaCtwN7nq@vger.kernel.org, AJvYcCVUjyXIkWhKKe/zR63dtgV30PEIeeN6PZ5+Pjid7Xf7gq6yB1UD5eDUbsyAipMo97qB8b7evMFH+4UoNg==@vger.kernel.org, AJvYcCXuOCXNUyD6VeKDErxWKmc9hrlAuFsgdsH6/q0K4paDtibWqywbeBBQZ8lwd63felAwSaVTtFInSzfNOgs=@vger.kernel.org, AJvYcCXuiRJYDuXNdujpS5grrZS+dSvJ9tLrIITVd3lITsAKS8U8RrjaCN9LkTrsHHrexQfHnwLVtSQJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzM81CJxuP+oLf+VTeEwH5I8aXj8xh4itJyKWFUQbQKuRdHXWQf
	wpXKVGl+/b5SmPkiCrCS4ZtAgg5GZPe/Qi8Nb0/sZ9A6g4FyGJYdC+WJFvfmgOuq5wkCDK2sQ/4
	1PuVNEeEgvmFG8v14umYiuUjElvDa+wlZ
X-Gm-Gg: ASbGncu3qYUw6iipZPWmVzIEByY8cld9eBpo01A9W05+VUK/3awC048Z8j+Y73Tiezb
	0bamOt1CJm5cAeEg+DfGPWm+ZmWR950M+Xyl5cHc6iLZkB8eFN+GnhFua22ebX3SzUp6vRdrYPU
	eDPCGEAWTmnXA8s+TQvNv8tAGjmew6cq/Zoen8zWI=
X-Google-Smtp-Source: AGHT+IEWfma6X5ez4B84XHaA8Hg5GU9L8meSLHJ4iYrb/qIwt8c4/Ivb+o9zQV621QfArJuMXBAKElx8oRo/JcJFASg=
X-Received: by 2002:a05:6e02:3a04:b0:3d6:cbed:3302 with SMTP id
 e9e14a558f8ab-3d6dd76c89emr2439975ab.2.1743622867040; Wed, 02 Apr 2025
 12:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
In-Reply-To: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 2 Apr 2025 15:40:56 -0400
X-Gm-Features: AQ5f1JorQaO0HCtrnUXO4s6aGuDFn3xGfel9XaXoLYeySmPI2omcRJXHShX-dDs
Message-ID: <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
Subject: Re: [PATCH] sctp: check transport existence before processing a send primitive
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, kernel-dev@igalia.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 6:26=E2=80=AFAM Ricardo Ca=C3=B1uelo Navarro <rcn@ig=
alia.com> wrote:
>
> sctp_sendmsg() re-uses associations and transports when possible by
> doing a lookup based on the socket endpoint and the message destination
> address, and then sctp_sendmsg_to_asoc() sets the selected transport in
> all the message chunks to be sent.
>
> There's a possible race condition if another thread triggers the removal
> of that selected transport, for instance, by explicitly unbinding an
> address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
> been set up and before the message is sent. This causes the access to
> the transport data in sctp_outq_select_transport(), when the association
> outqueue is flushed, to do a use-after-free read.
>
The data send path:

  sctp_endpoint_lookup_assoc() ->
  sctp_sendmsg_to_asoc()

And the transport removal path:

  sctp_sf_do_asconf() ->
  sctp_process_asconf() ->
  sctp_assoc_rm_peer()

are both protected by the same socket lock.

Additionally, when a path is removed, sctp_assoc_rm_peer() updates the
transport of all existing chunks in the send queues (peer->transmitted
and asoc->outqueue.out_chunk_list) to NULL.

It will be great if you can reproduce the issue locally and help check
how the potential race occurs.

> This patch addresses this scenario by checking if the transport still
> exists right after the chunks to be sent are set up to use it and before
> proceeding to sending them. If the transport was freed since it was
> found, the send is aborted. The reason to add the check here is that
> once the transport is assigned to the chunks, deleting that transport
> is safe, since it will also set chunk->transport to NULL in the affected
> chunks. This scenario is correctly handled already, see Fixes below.
>
> The bug was found by a private syzbot instance (see the error report [1]
> and the C reproducer that triggers it [2]).
>
> Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-=
after-free_Read_in_sctp_outq_select_transport.txt [1]
> Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-=
after-free_Read_in_sctp_outq_select_transport__repro.c [2]
> Cc: stable@vger.kernel.org
> Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list ch=
unks in sctp_assoc_rm_peer")
> Signed-off-by: Ricardo Ca=C3=B1uelo Navarro <rcn@igalia.com>
> ---
>  net/sctp/socket.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 36ee34f483d703ffcfe5ca9e6cc554fba24c75ef..9c5ff44fa73cae6a6a0479080=
0cc33dfa08a8da9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1787,17 +1787,24 @@ static int sctp_sendmsg_check_sflags(struct sctp_=
association *asoc,
>         return 1;
>  }
>
> +static union sctp_addr *sctp_sendmsg_get_daddr(struct sock *sk,
> +                                              const struct msghdr *msg,
> +                                              struct sctp_cmsgs *cmsgs);
> +
>  static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
>                                 struct msghdr *msg, size_t msg_len,
>                                 struct sctp_transport *transport,
>                                 struct sctp_sndrcvinfo *sinfo)
>  {
> +       struct sctp_transport *aux_transport =3D NULL;
>         struct sock *sk =3D asoc->base.sk;
> +       struct sctp_endpoint *ep =3D sctp_sk(sk)->ep;
>         struct sctp_sock *sp =3D sctp_sk(sk);
>         struct net *net =3D sock_net(sk);
>         struct sctp_datamsg *datamsg;
>         bool wait_connect =3D false;
>         struct sctp_chunk *chunk;
> +       union sctp_addr *daddr;
>         long timeo;
>         int err;
>
> @@ -1869,6 +1876,15 @@ static int sctp_sendmsg_to_asoc(struct sctp_associ=
ation *asoc,
>                 sctp_set_owner_w(chunk);
>                 chunk->transport =3D transport;
>         }
> +       /* Fail if transport was deleted after lookup in sctp_sendmsg() *=
/
> +       daddr =3D sctp_sendmsg_get_daddr(sk, msg, NULL);
> +       if (daddr) {
> +               sctp_endpoint_lookup_assoc(ep, daddr, &aux_transport);
> +               if (!aux_transport || aux_transport !=3D transport) {
> +                       sctp_datamsg_free(datamsg);
> +                       goto err;
> +               }
> +       }
>
We should avoid an extra hashtable lookup on this hot TX path, as it would
negatively impact performance.

Thanks.

>         err =3D sctp_primitive_SEND(net, asoc, datamsg);
>         if (err) {
>
> ---
> base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
> change-id: 20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_tr=
ansport-46c9c30bcb7d
>

