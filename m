Return-Path: <linux-sctp+bounces-170-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9C8FF5B8
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Jun 2024 22:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074DD1C25E82
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Jun 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE040BF2;
	Thu,  6 Jun 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Z1wIPj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE219D89B;
	Thu,  6 Jun 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717704942; cv=none; b=n2TAmWRypFeDoJf+UGvbK7ZQSF9QM62D4hSIlbgJWi2+7fAvKl5DVcTyWAjkGIFHhQkS4grvH28vIEhrmNPWjE6DxtSw9RYueK7LRNnk7IVxipBIKn95VQuufwpYoAtLLuDleWY1F/aDn1cqFZMqbwSze5PR/P2kaAUhWwovPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717704942; c=relaxed/simple;
	bh=AQ7GF4q/1Yb7iHnQ7ukC+hvO3kvAMdYOrcqxegTRy7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlWL5rQm/AUvo6DKqk+UUMdHeCN3jjtpjeGYm6MW8rCGmN6sCyIhnxepsIaLJiBRpzeyCoZTR8Pgw/s04RBRbG7a5Gv1ErlMrouFMYoyI7FcgfVz/+iPAmXhVaRClC1WjC/TbI0hXWKrhSHDpJ49/dylsFqT26VGnY1sZWyd/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5Z1wIPj; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-374a82e20deso8120365ab.1;
        Thu, 06 Jun 2024 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717704939; x=1718309739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pYG/DVDnxzBFRqp9E2ijRMkZnIWCZqG6UTAVccwf7s=;
        b=R5Z1wIPjJn+9rBUz1qdShNnhXdoNOQ/SiUZxLYfoHuZ+5nkgX1DvdkbZbMvPZnnM/n
         YCJN4M4T9JGu0locgmpkkxDYcX4TmRQKoFrKPst4GC+nNsvDB1xH42RQ3ZGAVOj2kUEJ
         D54KMfHEV1eyjMFHfJydgkFrPu8UAWczzqtJHLpx1xo34WSNcZ84HljBzaLO8HLofN0p
         +QE/CEwBY0Q8+pEXmxoiVbtNI7ijFExhuBERAELez3Vjkx5Fh22HerbdaOOHIMUsi4rh
         94PDecL3bxLQ2Z0+bRG6KgS6oGx+DSNDPVMQNusw8aDlaVP6iuKcojt8rKUIq4Qvwb++
         zKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717704939; x=1718309739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pYG/DVDnxzBFRqp9E2ijRMkZnIWCZqG6UTAVccwf7s=;
        b=hd8lcy70not5vpy+NgcsHP2QSkjvEKekv+FvKCAvXm2rgg6Zw3vRH6VpK2n43OVCxb
         Q6ZOixU52/lUwJtn3iRxsya6zXOA1PoEurDt2xXSLy1ec7pPUNCF++Dsoqypu4WEEIzj
         G5luzwb+O5hlhpiyDI2tS8D78Mz3qbe/iV2x7ZCfUQlw2MoHY/Ir2YeQHEHh590cSpmD
         O7NAgmmWNx3rkKGxbakeVY4a9OQXJirykmb5+GkwVIzoDyVBRbQzAXeGsm8rnj/K5qC/
         SwmIQzBlP7HdNjuye1Dr+93CXXG0KNQunC6ERmdyw36KMBpC0kF9MVT0venLs3PBIz57
         hF6A==
X-Forwarded-Encrypted: i=1; AJvYcCXrP0YQw5GFbxouaWAtvzV1f4rYZJKrqGuAC5nEkyOSbIr2v83iGCYEWHsC+YsPV6UzBQYPvdy6HkGgVtDiZO8jlvy9y2va
X-Gm-Message-State: AOJu0Yz1ZceWhYCCeRNqeJBDRin07IlatRAIF86CYMygxxnt0GovT3Ar
	eSeFViNOKATO8MtZQf8d9UGhi9N7Pc5KeAzHzVIySSd8LfozfbZvgvCXoNJR6osl55Oh+eq6qR6
	fnbbwGH0ewcyHZWFtYaZOSF97MaY=
X-Google-Smtp-Source: AGHT+IEzhvRylgL4Lg5B9lACn7wqepAmw9N6nweq123PmCKJlorN11ofcRaDFsLRWTidec4KVIEwsLoM3DMq2B6kN0o=
X-Received: by 2002:a05:6e02:1fe1:b0:374:9277:bfab with SMTP id
 e9e14a558f8ab-375803c3b43mr4066355ab.16.1717704939480; Thu, 06 Jun 2024
 13:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4faeb583e1d44d82b4e16374b0ad583c@AcuMS.aculab.com>
In-Reply-To: <4faeb583e1d44d82b4e16374b0ad583c@AcuMS.aculab.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 6 Jun 2024 16:15:28 -0400
Message-ID: <CADvbK_emOEPZJ8GWtYpUDKAGLW2z84S81ZcW9qQCc=rYCiUbAA@mail.gmail.com>
Subject: Re: SCTP doesn't seem to let you 'cancel' a blocking accept()
To: David Laight <David.Laight@aculab.com>
Cc: linux-sctp <linux-sctp@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 11:42=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> In a multithreaded program it is reasonable to have a thread blocked in a=
ccept().
> With TCP a subsequent shutdown(listen_fd, SHUT_RDWR) causes the accept to=
 fail.
> But nothing happens for SCTP.
>
> I think the 'magic' happens when tcp_disconnect() calls inet_csk_listen_s=
top(sk)
> but sctp_disconnect() is an empty function and nothing happens.
>
> I can't see any calls to inet_csk_listen_stop() in the sctp code - so I s=
uspect
> it isn't possible at all.
I guess SCTP doesn't take action due to the description
in rfc6458#section-4.1.7:

      SHUT_RD:  Disables further receive operations.  No SCTP protocol
         action is taken.

>
> This all relates to a very old (pre git) comment in inet_shutdown() that
> shutdown needs to act on listening and connecting sockets until the VFS
> layer is 'fixed' (presumably to let close() through - not going to happen=
.)
didn't know that, it's better to have it on some standard doc.

>
> I also suspect that a blocking connect() can't be cancelled either?
For connecting socket, it calls sctp_shutdown() where SHUT_WR causes
the asoc to enter SHUTDOWN_SENT and cancel the blocking connect().

>
> Clearly the application can avoid the issue by using poll() and an
> extra eventfd() for the wakeup - but it is all a faff for code that
> otherwise straight forward.
I will try to prepare a patch to solve this for sctp accept() like:

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c67679a41044..f270a0a4c65d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4834,10 +4834,13 @@ int sctp_inet_connect(struct socket *sock,
struct sockaddr *uaddr,
        return sctp_connect(sock->sk, uaddr, addr_len, flags);
 }

-/* FIXME: Write comments. */
 static int sctp_disconnect(struct sock *sk, int flags)
 {
-       return -EOPNOTSUPP; /* STUB */
+       if (!sctp_style(sk, TCP))
+               return -EOPNOTSUPP;
+
+       sk->sk_shutdown |=3D RCV_SHUTDOWN;
+       return 0;
 }

 /* 4.1.4 accept() - TCP Style Syntax
@@ -4866,7 +4869,7 @@ static struct sock *sctp_accept(struct sock *sk,
int flags, int *err, bool kern)
                goto out;
        }

-       if (!sctp_sstate(sk, LISTENING)) {
+       if (!sctp_sstate(sk, LISTENING) || (sk->sk_shutdown & RCV_SHUTDOWN)=
) {
                error =3D -EINVAL;
                goto out;
        }
@@ -9392,7 +9395,7 @@ static int sctp_wait_for_accept(struct sock *sk,
long timeo)
                }

                err =3D -EINVAL;
-               if (!sctp_sstate(sk, LISTENING))
+               if (!sctp_sstate(sk, LISTENING) || (sk->sk_shutdown &
RCV_SHUTDOWN))
                        break;

                err =3D 0;

Thanks.

