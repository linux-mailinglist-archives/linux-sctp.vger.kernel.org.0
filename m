Return-Path: <linux-sctp+bounces-563-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3AAC50C9
	for <lists+linux-sctp@lfdr.de>; Tue, 27 May 2025 16:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8661516504B
	for <lists+linux-sctp@lfdr.de>; Tue, 27 May 2025 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E627603C;
	Tue, 27 May 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDkruEgR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE319CD16;
	Tue, 27 May 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355831; cv=none; b=gKC8XCdPfJdB6IgZKOcWH5PB2Av4wIndQcKthx1BVEILjR5+0bZj2l6fwVq1F/HUq4zYUUBThvaQ2eojW9p4KUDlbnQ4WJ4E4hZWI6IDRneYfwAVbOfmDzM3WuPWQfHSNh6c1xVDgL21Wxqa2mzlULGv/b2DsFWNADT/kz+l8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355831; c=relaxed/simple;
	bh=xEvAthQl04RfIia9XZaGNG0pijIVN4yQy6i+18RddsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBliVQNO4qXyP3B9bZUAkvTO0HVmyWUj2MyD5tHLXlIqxnIrfzRUwQ/0zGA/1+FtouC4TBIEYB6D5Olz7bdE2C4WU2Quu6beGq3te4kayUR7TU0iL5JfYEFob6gruRpjDXf2B9O6ueUr+DZOoHfffgLgVAtxjkk575s0CsHsYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDkruEgR; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86a52889f45so80500639f.3;
        Tue, 27 May 2025 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748355828; x=1748960628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmTjDT2LiyYwF2wR/qWfUuuEJKevqGe/HgmBHDb7hgI=;
        b=CDkruEgRZ+MZTVeuxgiq8mRSRpmWDP49Y/vovQ+X5QFGas35g44Ioj22kq2HpfUMtn
         /NWGpWnf5GFsJTdXWd/WRg3PPQhQ4S3qKXk9HV3d1jCDvFXxVvK25iygUrIEMoMbsxiE
         4QXDeKYmNzXnddbCvy/RIWO+fXT2DfrrXgNK9Yjw/dt01neRnTk29bJvAcuJKHrrSwq+
         S7B9MAquFxLhJ5qjE5fWIfERkA8zso7bl5YY4DPkXGewePiANTOtoBv4PVFkRBCxst1m
         IjI97BYf/I8iwEKho6MUG2gwIEbbc/qNfoMkAVmAQMdfnf7brG7lHiFrY328xJzoOM91
         gFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355828; x=1748960628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmTjDT2LiyYwF2wR/qWfUuuEJKevqGe/HgmBHDb7hgI=;
        b=vZHMX98FhKtbbp9QDE2nkILTgkslsdi0giFmIFSySv64LcJrZGmJ3zTx7Yz1E+gBtF
         5ojc6FsDxNR1kazL+Sj2AkbcaHaSpITfL/iiexVuTiqG8EdqnwKjK2C8MExgGAuODIUt
         uJADs8GwycoWmX8AimO0LP1LxtipLKKaI+yaMAGwVydJjE5tMzWzh7xnrw9HyRc0Tgji
         KYvQTvzX1TlbFa3bxqGYgSrMhtuJVFOU+Q0u1qKkZzxqDCajZyaoZNr+XX7ZPqyhLSgY
         srxv7nDtUI96MLxU52N0/mq4JhiFSxidFDGnukYU3a7yPIoBLyddMRDZrradYwXOF4L4
         lhrA==
X-Forwarded-Encrypted: i=1; AJvYcCWWm6hDOLrxiH/nGCA6wnUOBpuxSNyBKexRg5reEV15xYsaUrFm3dQwefgSE159jzYSSoFwkrSkfvPI@vger.kernel.org, AJvYcCWjqeFl97XwTqYOcQiiR0TlcH9Ddi9xqP70BwQs1nz347on3CHT+3qgRP0qmKpPqhhxfihMNsXc@vger.kernel.org
X-Gm-Message-State: AOJu0YyBv03pm/K0xvcgZW53s/HIkprgNJPfsRx/dMPhxnQPuz1QqeT/
	RUfg9dMpUA1Mrpf2oyVIZPp7FDsimdhKroyH0QySisUlYapMVlcXSi3gFSZOaJmVqAME6NKzWoE
	NdX4WoWwyPCLrOZGqbJ6NnChEqZvTITjjTRr7
X-Gm-Gg: ASbGncuzIpjEyDcm4NzsGreLcEl2ZlvV88mP59gxqE2M7BiFC3/F1qsbbmH5ajgx1ZU
	iOZtJOaPwql+JMa2+tdd89fgSsN1WSmYkzlyU/KRlUhRJxuqHlr2ibamrTh6sLjlbHuO6KUer+d
	HnVB4ZgjOMVgg+JWVT+QjvDnOwDLh83gY=
X-Google-Smtp-Source: AGHT+IH7SsEHzLIjf82CLttgDNusdzC3nK2flv09oI166QJqd/Na89p4fl/qYeMiT+DyrfRaMRKeRM7Gq3YGwE0nIek=
X-Received: by 2002:a05:6e02:2307:b0:3dc:88ca:5ea9 with SMTP id
 e9e14a558f8ab-3dc9b69abe2mr102343175ab.10.1748355828452; Tue, 27 May 2025
 07:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526054745.2329201-1-hch@lst.de> <CADvbK_d-dhZB-j9=PtCtsnvdmx980n7m8hEDrPnv+h6g7ijF-w@mail.gmail.com>
 <aDTDOgqCrVryvr0_@f4>
In-Reply-To: <aDTDOgqCrVryvr0_@f4>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 27 May 2025 10:23:37 -0400
X-Gm-Features: AX0GCFs56UMPA4XnZrQcO6bX4-CWh7fuN5QGdKyDYNTtGOxk1zR6_0Jj2cgEnQw
Message-ID: <CADvbK_d_3YQh0s_aOts3YiyHu_uxUxO4okCZDdi=+F4xbVnmKg@mail.gmail.com>
Subject: Re: [PATCH] sctp: mark sctp_do_peeloff static
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 3:38=E2=80=AFPM Benjamin Poirier
<benjamin.poirier@gmail.com> wrote:
>
> On 2025-05-26 14:25 -0400, Xin Long wrote:
> > On Mon, May 26, 2025 at 1:47=E2=80=AFAM Christoph Hellwig <hch@lst.de> =
wrote:
> > >
> > > sctp_do_peeloff is only used inside of net/sctp/socket.c,
> > > so mark it static.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  include/net/sctp/sctp.h | 2 --
> > >  net/sctp/socket.c       | 4 ++--
> > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> > > index d8da764cf6de..e96d1bd087f6 100644
> > > --- a/include/net/sctp/sctp.h
> > > +++ b/include/net/sctp/sctp.h
> > > @@ -364,8 +364,6 @@ sctp_assoc_to_state(const struct sctp_association=
 *asoc)
> > >  /* Look up the association by its id.  */
> > >  struct sctp_association *sctp_id2assoc(struct sock *sk, sctp_assoc_t=
 id);
> > >
> > > -int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket =
**sockp);
> > > -
> > >  /* A macro to walk a list of skbs.  */
> > >  #define sctp_skb_for_each(pos, head, tmp) \
> > >         skb_queue_walk_safe(head, pos, tmp)
> > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > index 53725ee7ba06..da048e386476 100644
> > > --- a/net/sctp/socket.c
> > > +++ b/net/sctp/socket.c
> > > @@ -5627,7 +5627,8 @@ static int sctp_getsockopt_autoclose(struct soc=
k *sk, int len, char __user *optv
> > >  }
> > >
> > >  /* Helper routine to branch off an association to a new socket.  */
> > > -int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket =
**sockp)
> > > +static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
> > > +               struct socket **sockp)
> > >  {
> > >         struct sctp_association *asoc =3D sctp_id2assoc(sk, id);
> > >         struct sctp_sock *sp =3D sctp_sk(sk);
> > > @@ -5675,7 +5676,6 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc=
_t id, struct socket **sockp)
> > >
> > >         return err;
> > >  }
> > > -EXPORT_SYMBOL(sctp_do_peeloff);
> > >
> > I believe sctp_do_peeloff() was exported specifically to allow usage
> > outside of the core SCTP code. See:
> >
> > commit 0343c5543b1d3ffa08e6716d82afb62648b80eba
> > Author: Benjamin Poirier <benjamin.poirier@gmail.com>
> > Date:   Thu Mar 8 05:55:58 2012 +0000
> >
> >     sctp: Export sctp_do_peeloff
> >
>
> Thanks for digging that up. The purpose was of course for the commit
> that followed:
> 2f2d76cc3e93 dlm: Do not allocate a fd for peeloff (v3.4-rc1)
>
> Since that usage was removed in
> ee44b4bc054a dlm: use sctp 1-to-1 API (v4.3-rc1)
>
> I don't see a problem with marking sctp_do_peeloff() static again.
>
> > While there=E2=80=99s no known in-tree usage beyond SCTP itself, we can=
=E2=80=99t be
> > sure whether this function has been used by out-of-tree kernel modules.
>
> The mainline kernel does not need to cater to out-of-tree users.
Thank you for chiming in.

I didn't know it was exported for the in-tree kernel dlm, and this
patch should be applied to net-next.

Acked-by: Xin Long <lucien.xin@gmail.com>

