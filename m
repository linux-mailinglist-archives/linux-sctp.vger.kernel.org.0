Return-Path: <linux-sctp+bounces-479-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD9A7BF0A
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Apr 2025 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A339189B4C5
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Apr 2025 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272F1F30C3;
	Fri,  4 Apr 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjSrOLJM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCD847B;
	Fri,  4 Apr 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776572; cv=none; b=cl/RXQKqtjiRPZCXBULvQcy2bSqKyd7ae/C9JKxkQFddfmRaAYnlvAz3C1SEYZ7oe3rEog7HyhPUhxN4LaZ2IuWlljJWkvheLKvt6eJZw6C6t4eSokW8NE2lF3yVpJLIFgr5wcxLUViCTyKZU8zPfkshgJ2mVuLKcydarrLNQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776572; c=relaxed/simple;
	bh=mFBXTwEhQKFDjcZ3xXqeDdUzR3kLcAmTHhPWdwLV2j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftV3VtHwbngu10u3Nl9yiOXggXx9bnB0w2yoWBeeMmSN+Oq1YkeApeGQYVbiwRpk8Gkdd1VY2ouCmkUIJ1MoHGlRecdHDudtBldXPh8NPGl/HxflDRy4x3rqXIomy7XQmqXuK8wB57QZKw6Zx9IwRr848at1t5tVg7pxi8J9pMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjSrOLJM; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d589ed2b47so7087515ab.2;
        Fri, 04 Apr 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776570; x=1744381370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF8Eg/CK7XzuoF+shmNXDLBMaetMNlz/WflJhGpXfFc=;
        b=JjSrOLJMpt3Qy3SLjC0TDd934nEY1JVljGtSRzVQ+UilCIn3mChPSy0C0a99V5zwoM
         MMLh21rYi+JYzyTceWjNKk22AXshqt3vrnkOQH4Lxw9cqvSKCue523V70/TfpdHbjwcw
         jajH5Z9YZJTbVbr7VVHAZfhMnLTab5IUuDmGC6T/4NgWlLfsXmfZ3OBX8jF/J6aXsUdq
         KaRSIGeO1b9d+vfX4y8teTjFvhMBvi/JJ7pzA3ZzNFEBpubebX7JgmHAZBen+2zq/rDm
         zh4sZcWM6UV4Ig1xWtciLcr66x7s/q+/B2u0V/jzDbF9t/GGYQZKIfQLnKS7IzKBoXQ2
         sLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776570; x=1744381370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uF8Eg/CK7XzuoF+shmNXDLBMaetMNlz/WflJhGpXfFc=;
        b=bMzJcNn7joZzP5E8VPKzge+sWxRcIGLOzjWbkazsp7h5thGzd/+cOUMrr0UuBt369m
         kuioUya/KZygW+slC/GxWQ9A5RDo1YfegzOD81gBWOXBkou57EAoF7UfKgKBaamAjEHL
         KveZUVlkAc3OP2Z/Yl8uq1d+NPdxLhZhr/E+Zu3p3g1YgRM+Xv5LBXa0gtdAnrcVj9KD
         509m2nigMTvcW7bgNNPXFrJiVtYR+jtkOsvMuRUWwBJs7BY3k9U26rfnSGyvSmDQYyaD
         /bhiEt0w03nBEBCNoaPg/Obbih+OabqSd/tWyBCVBxiKoQ6UpK+pz6NI7F6siFwAzb5d
         nn8A==
X-Forwarded-Encrypted: i=1; AJvYcCV3jc/MU/Y30AEM2jaH4KNEAJNJGv70s0lmgkivbuH6AnxUEUIWiKslejhSIpRReQVVdJ7pOCwvR77H9bo=@vger.kernel.org, AJvYcCW/CjTVQabZXCvp+Y6kLcBq59NAGjkbF172WRXCsC+H8GeMUJNvXVPKz3MXp096pgBYh/p7bMJV@vger.kernel.org, AJvYcCWx/G+J4aA2zv9pe8oY2NRhCuIwr2P6M83xRGAv+DiCavUDKTA3EHqYHLpbPSWhY8nFf0qagfYD@vger.kernel.org, AJvYcCX1uAVaPz63tT9sFAMQS0jcW+3Z9mvEGMSuZQy9fxxjiJRfmWuT1k3UOOdqntym94gnMyrEnHmq6R64FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/3cQnxHYMKzzaGod9zN0fiW5VJp8fnMbt2Xjpms6SnEPaVbD
	XVBr+3EzXdNlUUiFt/Rn6hFbEYBNezlyZCXJSZ5eczxyY4+KpQGENZynNA3tiFRdxfzhgZNwWfL
	AQKsdieOgNDwNUuyE8pwMPM4T9+8=
X-Gm-Gg: ASbGnctH4r1CYiSHTpT0f6R/ynyZppuxXloze2/h31gYVrZ2RO+oefqOPDWMYRph5iS
	7QcBBmK2tJM+t1pJMC9ZC/jSIKOHpF0Gn6Ky54IEKye04tKRdZRzr+92TgJxkvqlIYVQHiw2pA0
	sS6+I8s1k2hLAcWHmkPiY5SKNjGguh
X-Google-Smtp-Source: AGHT+IGqE3jq7vSaeNlWZlaY6Rmf5YCoZyFZnfH4P/4GbXj+4pcuknK8aVGw3rlDDBSWZaMH1HIrWw3SGnuf2u0S7Lc=
X-Received: by 2002:a05:6e02:16cb:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d6e3ee1632mr36224115ab.4.1743776569662; Fri, 04 Apr 2025
 07:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
 <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
 <87tt75efdj.fsf@igalia.com> <CADvbK_c69AoVyFDX2YduebF9DG8YyZM7aP7aMrMyqJi7vMmiSA@mail.gmail.com>
 <CADvbK_d+vr-t7D1GZJ86gG6oS+Nzy7MDVh_+7Je6hqCdez4Axw@mail.gmail.com> <87r028dyye.fsf@igalia.com>
In-Reply-To: <87r028dyye.fsf@igalia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 4 Apr 2025 10:22:38 -0400
X-Gm-Features: ATxdqUFqJZzOz7__HX2olSvI6YOoUaTBczjRn0Vq4YkQ2y534PCmeDUmyD3BkGU
Message-ID: <CADvbK_evR93rj1ZT_bzLKFqNQLPQ2BM0mzKnriGGsO5t07GAHQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: check transport existence before processing a send primitive
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, kernel-dev@igalia.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 6:05=E2=80=AFAM Ricardo Ca=C3=B1uelo Navarro <rcn@ig=
alia.com> wrote:
>
> Thanks for the suggestion!
>
> On Thu, Apr 03 2025 at 14:44:18, Xin Long <lucien.xin@gmail.com> wrote:
>
> > @@ -9234,7 +9236,7 @@ static int sctp_wait_for_sndbuf(struct
> > sctp_association *asoc, long *timeo_p,
> >                                           TASK_INTERRUPTIBLE);
> >                 if (asoc->base.dead)
> >                         goto do_dead;
> > -               if (!*timeo_p)
> > +               if (!*timeo_p || (t && t->dead))
> >                         goto do_nonblock;
> >                 if (sk->sk_err || asoc->state >=3D SCTP_STATE_SHUTDOWN_=
PENDING)
> >                         goto do_error;
>
> I suppose checking t->dead should be done after locking the socket
> again, where sctp_assoc_rm_peer() may have had a chance to run, rather
> than here?
>
It shouldn't matter, as long as it's protected by the socket lock.
The logic would be similar to checking asoc->base.dead.

> Something like this:
>
> @@ -9225,7 +9227,9 @@ static int sctp_wait_for_sndbuf(struct sctp_associa=
tion *asoc, long *timeo_p,
>         pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
>                  *timeo_p, msg_len);
>
> -       /* Increment the association's refcnt.  */
> +       /* Increment the transport and association's refcnt. */
> +       if (transport)
> +               sctp_transport_hold(transport);
>         sctp_association_hold(asoc);
>
>         /* Wait on the association specific sndbuf space. */
> @@ -9252,6 +9256,8 @@ static int sctp_wait_for_sndbuf(struct sctp_associa=
tion *asoc, long *timeo_p,
>                 lock_sock(sk);
>                 if (sk !=3D asoc->base.sk)
>                         goto do_error;
> +               if (transport && transport->dead)
> +                       goto do_nonblock;
>
>                 *timeo_p =3D current_timeo;
>         }
> @@ -9259,7 +9265,9 @@ static int sctp_wait_for_sndbuf(struct sctp_associa=
tion *asoc, long *timeo_p,
>  out:
>         finish_wait(&asoc->wait, &wait);
>
> -       /* Release the association's refcnt.  */
> +       /* Release the transport and association's refcnt. */
> +       if (transport)
> +               sctp_transport_put(transport);
>         sctp_association_put(asoc);
>
>         return err;
>
>
> So by the time the sending thread re-claims the socket lock it can tell
> whether someone else removed the transport by checking transport->dead
> (set in sctp_transport_free()) and there's a guarantee that the
> transport hasn't been freed yet because we hold a reference to it.
>
> If the whole receive path through sctp_assoc_rm_peer() is protected by
> the same socket lock, as you said, this should be safe. The tests I ran
> seem to work fine. If you're ok with it I'll send another patch to
> supersede this one.
>
LGTM.

>
> > You will need to reintroduce the dead bit in struct sctp_transport and
> > set it in sctp_transport_free(). Note this field was previously removed=
 in:
> >
> > commit 47faa1e4c50ec26e6e75dcd1ce53f064bd45f729
> > Author: Xin Long <lucien.xin@gmail.com>
> > Date:   Fri Jan 22 01:49:09 2016 +0800
> >
> >     sctp: remove the dead field of sctp_transport
>
> I understand that none of the transport->dead checks from that commit
> are necessary anymore, since they were replaced by refcnt checks, and
> that we'll only bring the bit back for this particular check we're doing
> now, correct?
Correct, only the 'dead' bit and set it in sctp_transport_free().

Thanks.

