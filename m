Return-Path: <linux-sctp+bounces-303-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A415A01B5F
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Jan 2025 19:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F318832DA
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Jan 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC28155A34;
	Sun,  5 Jan 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdAgqThn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF879CD;
	Sun,  5 Jan 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736101710; cv=none; b=JWDDMW9a/Ng7Nwfjv77ddKymACxhFDIyesUR43VejnSZsrivSCYjIJG4TNXqjfFzJUGyDeMkE4EZMyiYRhdjVgB+CLNempZnkJrx40ZnU5L7DqCcTGfSG87GJbCB7cOVdtXw7QBkjR6xvxxP5qaGvTcRBOn7Am2ptpAjt2AsXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736101710; c=relaxed/simple;
	bh=T4bWzApkroQ25gJuFymme4H5pFKho0yEvxsdNGE9c4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/EIVqQFe6u5AMvXrlb4EFwnbnmFOIv2qgKpq7HRDAyPCr6QxTcQgWILB+ZgxO2H9hV10+CoJFtZKklWvrp76z6x9tylHgSTwXdKHvf6/xvLlfV+H7Y/cRlS+49zlUJsMZb/yJP1iSIvrlbFmgDOoTkjetLr5ZUOOOd0YDY1tCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdAgqThn; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3c6b0be237cso105942075ab.2;
        Sun, 05 Jan 2025 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736101706; x=1736706506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIJ1uoZcq3El37Epg4ECRzVlmxCiVAYQEwVu4xI6zkA=;
        b=mdAgqThn9DLVWublVr06YnjmBKAVKMjyNj+f0U/HPwhqd20RDOb5xNIdrUbqGAzAFK
         ovdRs060kubQwdXm4dwzWLRDSz+vRrP6S3Z5O1t60vhdOnPDiHazx0LUnontuQ+8VJPh
         CcW2L52OifY3fLQVKgOD22oI1tUS5/HZtc9OWqiEGeYi8Rw0B3Eg/l6z0yD8FlUOX/U4
         PCRdWjmjzL/CsTw+A4RHdiAH9jzrgqwORA3Re+JEoQy3acxeIg7g1cAji5eB6HJH0iNL
         ob1DfEEr7AM79WNALTvnluS5js2tJXAMobpMZCw9JGl4LJ3xpYn6LKzZ2Cg79LWs0eU+
         uyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736101706; x=1736706506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIJ1uoZcq3El37Epg4ECRzVlmxCiVAYQEwVu4xI6zkA=;
        b=fcXKkixvhyCBfJdEU1BWYtAT+fSrLGf2LgGJe1DkqyrG2hq1pddb/wWzTk3hnQVAo4
         9gCzyVfilZJqbQDSWXMnSAPEejsYcgqIM2+DguCwhKsJ1zNkazGk712zjxqUZ6Np0UuR
         2mFxHxZftenRK2oQZV7rJ/shF1mpKFdAnsQ86x2XiEigT+mbXPOaK8+YPUae6irVz7Hf
         O3NlbXNhVSrlcjK2wytDcSdy09KdA+TVIxgNEvP4zflejaZMEJyzHnJ+Lmw33FuxBZdG
         Bklnh4Xv5UsV8BnNXTcGkkydPNGlk5aV7pe40TtK1WSAfzSxqZs+zcwIN9u55aE15EK8
         7XUA==
X-Forwarded-Encrypted: i=1; AJvYcCVmu9y8Crz22oETwPYfDZQaJUaonxIV5VAXdaixJkxEV0We4UkLvEBuxC2gZIkxaPSlAm+CUccX@vger.kernel.org, AJvYcCXrVppVUgMMH5mXZAbQgvs1ZVz0ALS5hvGvMEHAPspmK34dnm1TrH2o2rvT8kpv9HEWYENdSF7EtDqW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpfw5bcxwoGP8odmixpzlc0Ci1BYOJVBB5BGhVdR51gTYnNb5o
	2mWcGFqnL7QRTdIDd/OSSgUi3PudRydQo1U/lsOvpVERmuoGnrdak/rhVyhCTA27WFfP3DVwlsD
	Y3zRgm4+yKmjim8ARyk9ky4lcjws=
X-Gm-Gg: ASbGncvERG5TfwM2/g8zCpFGWsg88vUl2WQyLv3dbo8fEfV2ZjgbpyuLjpVzuW22hLI
	nXQydajZII4eOMTbO9K0SOK8C4yqSUSS1ED0IiKQ=
X-Google-Smtp-Source: AGHT+IEig+7CQxOThACqzl3DXplD5w4wiM9ncxbPqGhnpi6Tsi99xuB6/kgzFPu4PkXo/knDdvy/9u+gVNscMIzk2Xk=
X-Received: by 2002:a05:6e02:1a0b:b0:3a7:e0c0:5f27 with SMTP id
 e9e14a558f8ab-3c2d1c915a9mr425555945ab.2.1736101706550; Sun, 05 Jan 2025
 10:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
 <CADvbK_fsM_EfoNjhybKJr92ojqFo6OdnuA2WiFJyi6Y1=rX4Gw@mail.gmail.com> <Z3gXieFRj+xqozJE@debian>
In-Reply-To: <Z3gXieFRj+xqozJE@debian>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 5 Jan 2025 13:28:15 -0500
X-Gm-Features: AbW1kvZAGyf9zajSgb0eV8lacVYh4ZPQ0aXBftrck1zLzFkMS7ZOH7W2Y_bnSDA
Message-ID: <CADvbK_daHuittutNqWaiRR-GzaZ8g5iWw-WCEP5GNhiqFcwySg@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t conversion.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 11:59=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> On Fri, Jan 03, 2025 at 10:35:55AM -0500, Xin Long wrote:
> > On Thu, Jan 2, 2025 at 11:34=E2=80=AFAM Guillaume Nault <gnault@redhat.=
com> wrote:
> > >
> > > Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
> > > that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
> > > variable. For the SCTP_DSCP_SET_MASK case, we can just use
> > > inet_dsfield_to_dscp() to get a dscp_t value.
> > >
> > > Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just ha=
ve
> > > to drop the inet_dscp_to_dsfield() conversion function.
> > With inet_dsfield_to_dscp() && inet_dsfield_to_dscp(), the logic
> > looks like: tos(dsfield) -> dscp_t -> tos(dsfield)
> > It's a bit confusing, but it has been doing that all over routing place=
s.
>
> The objective is to have DSCP values stored in dscp_t variables in the
> kernel and keep __u8 values in user space APIs and packet headers. In
> practice this means using inet_dscp_to_dsfield() and
> inet_dsfield_to_dscp() at boundaries with user space or networking.
>
> However, since core kernel functions and structures are getting updated
> incrementally, some inet_dscp_to_dsfield() and inet_dsfield_to_dscp()
> conversions are temporarily needed between already converted and not yet
> converted parts of the stack.
>
> > In sctp_v4_xmit(), there's the similar tos/dscp thing, although it's no=
t
> > for fl4.flowi4_tos.
>
> The sctp_v4_xmit() case is special because its dscp variable, despite
> its name, doesn't only carry a DSCP value, but also ECN bits.
> Converting it to a dscp_t variable would lose the ECN information.
>
> To be more precise, this is only the case if the SCTP_DSCP_SET_MASK
> flag is not set. That is, when the "dscp" variable is set using
> inet->tos. Since inet->tos contains both DSCP and ECN bits, this allows
> the socket owner to manage ECN. I don't know if that's intented by the
> SCTP code. If that isn't, and the ECN bits aren't supposed to be taken
> into account here, then I'm happy to send a patch to convert
> sctp_v4_xmit() to dscp_t too.
From the beginning SCTP sends its packet via ip_queue_xmit() where it
allows the socket owners to manage ECN, like TCP. So let's just leave it.

>
> > Also, I'm curious there are still a few places under net/ using:
> >
> >   fl4.flowi4_tos =3D tos & INET_DSCP_MASK;
> >
> > Will you consider changing all of them with
> > inet_dsfield_to_dscp() && inet_dsfield_to_dscp() as well?
>
> Yes, I have a few more cases to convert. But some of them will have to
> stay. For example, in net/ipv4/ip_output.c, __ip_queue_xmit() has
> "fl4->flowi4_tos =3D tos & INET_DSCP_MASK;", but we can't just convert
> that "tos" variable to dscp_t because it carries both DSCP and ECN
> values. Although ->flowi4_tos isn't concerned with ECN, these ECN bits
> are used later to set the IP header.
>
> There are other cases that I'm not planning to convert, for example
> because the value is read from a UAPI structure that can't be updated.
> For example the "fl4.flowi4_tos =3D params->tos & INET_DSCP_MASK;" case
> in bpf_ipv4_fib_lookup(), where "params" is a struct bpf_fib_lookup,
> exported in UAPI.
>
> To summarise, the plan is to incrementally convert most ->flowi4_tos
> assignments, so that we have a dscp_t variable at hand. Then I'll send
> a patch converting all ->flowi4_tos users at once. Most of it should
> consist of trivial inet_dscp_to_dsfield() removals, thanks to the
> previous dscp_t conversions. The cases that won't follow that pattern
> will be explained in the commit message, but the idea is to have as few
> of them as possible.
>
> BTW, the reason for this work is to avoid having ECN bits interfering
> with route lookups. We had several such issues and regressions in the
> past because of ->flowi4_tos having ECN bits set in specific scenarios.
>
Got it, thanks for the detailed explanation.

Acked-by: Xin Long <lucien.xin@gmail.com>

