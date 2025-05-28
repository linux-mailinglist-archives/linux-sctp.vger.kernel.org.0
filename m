Return-Path: <linux-sctp+bounces-565-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96792AC68C6
	for <lists+linux-sctp@lfdr.de>; Wed, 28 May 2025 14:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7245F1BA505E
	for <lists+linux-sctp@lfdr.de>; Wed, 28 May 2025 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461B27AC56;
	Wed, 28 May 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFkRyBf0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3AE215789;
	Wed, 28 May 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748433897; cv=none; b=sMX6/plhGoS81nNm6qpP+sE3ecqyJNzTIuUsfdGkz9l+AtWy9y9TnT0hI8elMm8kGOQPeaIyVk4HZfTPZeZ8t8RZbK/mPZzbrrBeVJK3RN2F1A2m2nInduPA/5rzdutMc5nrRp3cVENDrFL3lwli1X8Oxf0fU7T2e4s8cIAgwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748433897; c=relaxed/simple;
	bh=RoGHGChwtbOy+sfOXKMb48wRo0w/WA7Y4z/Aca77rmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4j15ejNHtFb1AZBaGJnlee2GQVQ0Eb/5i36nzv5zXOkKcKwVUjdOTAtRpxQDSvO+wReJlmiypfJjRBFbNEbV6iK9xpANbSh4x/rust1h4FYO2DYO9x8ly754Enc/F2gr3RcoZ1GShHNyMLOvjlMoEwi1o5ybQHTqvVwc5yd1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFkRyBf0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso47210205e9.0;
        Wed, 28 May 2025 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748433894; x=1749038694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VmHlr7Z4zrk9pRHBfeJ2K5eXUzwBXbKq6/2Cos+GoY=;
        b=QFkRyBf0QQM3yvXRnt23Lkg2NNKOVGMdkY06gLnLnj1B1xbggor145iK/19ptcJkIT
         J4mTeLPB9oIrkcf/68CmlG0J9fFxXeY/dsUBrvsDeqSxhNMFL7c6FHAV2PXsOpcr5lhn
         7dFEIiI1rd7vAwFMdL9AGdnt57QBZP1dWDELpsaZrCjIuE3VK13IvD65MfS9Nty5cmoG
         M4iAaqIy1dluuT2j4irRBie3PL5T8iq/ex7d02StJPT5XnOo7gNYujX6tO3EensmKJoU
         nuA3q0/YHkoRv0+ZmFhLbuoQMi4eUsnzpM5U/0YBcCZloELigZD5TSqPDlgPA+2/sD+2
         8qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748433894; x=1749038694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VmHlr7Z4zrk9pRHBfeJ2K5eXUzwBXbKq6/2Cos+GoY=;
        b=VNKbZguJv4Yo30+IEUKxOrQ4QdRlKGpancSqJGvtMyrOZJ9b0x3Coxk3fvRW0iNITN
         40W+P30WmblzB/4RLlYT6hI+M0HLXemwkhW0VSs1T7JR/QUCv8xgr/dy8wn+ZsAJzOkn
         7ziPUzYqi3QDiN2yEVpaqzRt6NP18SnZvgwYA5APLuOHbZ9Wj74bsXJeoXgFhiMkp6Lq
         7dE+iJU5QlsHrtiP5cMnnejNN1L6AD1tU8rybqiT72vHjRx4AhtxPd1+tpCI2VC6sPWR
         P8LwRE9Nd8VLaw+Pgyk13T9K8PA1Jx5ZXgAo0RR0zW7uGs3c2o1yHLFfqo5+4zSFwR9s
         Tt4A==
X-Forwarded-Encrypted: i=1; AJvYcCVi8iLET6R7KX//Wg9kGuyD4dLMXIephQddm9IWH//QiPwxdBacPT0qSkoboz9GM3olmW4Mamvu@vger.kernel.org, AJvYcCWzIGyBw4OfdGdbTZ6UTAivhvD/eBpE/wkkg/infjEtei05HCeKo0KrLx5gzaaFoSZfYDyZ62Doq1ji@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1cx5FDvX+7u8mEzb22MaoBpii4EKlwOCKUbADlu6Z9AsO6Vi
	O1l/XbbA9eMj/WEVDOqflYmqjUs6oyBxFUn9neTiihHrz7gu+IT3/35b
X-Gm-Gg: ASbGncsIbsIln6zA8aH1G/CNez3xy573tGLPrPhUWmPS2sDbiHZ2hDOkeQ2dFHC9X7N
	lDOaJwx1xjM4avASic3+7t4q7UD/+/zjCxquI6nt6XZg6Imyri7yk2U5GEbGVRhV6HpnkpmBBix
	zL8dFU8XbX3mMm8U4siDGu/UpHw5KISPD+oMr9Bf9uRafzG1Eag2BFGsLdPxZpxFkqVikhr5d6d
	J8HddHYQ1by87uHnfY3ko4S1OExpIjAuNDs2Il47ZWl+4KtsT19faIblQB5F6wSZq0hGnDF/s0P
	FjLZwi58a0XU2OwNOazzj0tGVO9QzzQqOglWNmnePm4xH0Fgivk6yfhcLvVcl77LLdOgehkCJWT
	tMpGCPJkDNiyxGg==
X-Google-Smtp-Source: AGHT+IFn1yyvWoI5RoHYwFSLD7Ity5bFJc0yVWi6F1hSRC0s6DQRAWp9avrmnluhH8IXNnEbwpXfsQ==
X-Received: by 2002:a05:600c:4448:b0:442:ff8e:11ac with SMTP id 5b1f17b1804b1-44c91ad6fd3mr145503345e9.12.1748433893551;
        Wed, 28 May 2025 05:04:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450787cc3b9sm15663375e9.26.2025.05.28.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 05:04:53 -0700 (PDT)
Date: Wed, 28 May 2025 13:04:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Benjamin Poirier <benjamin.poirier@gmail.com>, Christoph Hellwig
 <hch@lst.de>, marcelo.leitner@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] sctp: mark sctp_do_peeloff static
Message-ID: <20250528130445.391f90ca@pumpkin>
In-Reply-To: <CADvbK_d_3YQh0s_aOts3YiyHu_uxUxO4okCZDdi=+F4xbVnmKg@mail.gmail.com>
References: <20250526054745.2329201-1-hch@lst.de>
	<CADvbK_d-dhZB-j9=PtCtsnvdmx980n7m8hEDrPnv+h6g7ijF-w@mail.gmail.com>
	<aDTDOgqCrVryvr0_@f4>
	<CADvbK_d_3YQh0s_aOts3YiyHu_uxUxO4okCZDdi=+F4xbVnmKg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 May 2025 10:23:37 -0400
Xin Long <lucien.xin@gmail.com> wrote:

> On Mon, May 26, 2025 at 3:38=E2=80=AFPM Benjamin Poirier
> <benjamin.poirier@gmail.com> wrote:
> >
> > On 2025-05-26 14:25 -0400, Xin Long wrote: =20
> > > On Mon, May 26, 2025 at 1:47=E2=80=AFAM Christoph Hellwig <hch@lst.de=
> wrote: =20
> > > >
> > > > sctp_do_peeloff is only used inside of net/sctp/socket.c,
> > > > so mark it static.
...

> > I don't see a problem with marking sctp_do_peeloff() static again.
> > =20
> > > While there=E2=80=99s no known in-tree usage beyond SCTP itself, we c=
an=E2=80=99t be
> > > sure whether this function has been used by out-of-tree kernel module=
s. =20
> >
> > The mainline kernel does not need to cater to out-of-tree users. =20
> Thank you for chiming in.
>=20
> I didn't know it was exported for the in-tree kernel dlm, and this
> patch should be applied to net-next.

The most likely module use would be bpf or io_uring.
But they'd probably end up using the sockopt interface (the same
as applications).

Mind you 'peeloff' is all a strange idea that seems (to me) solving
a problem that has nothing at all to do with sctp (as a protocol).
The entire 'many-to-one' seems to be there to avoid the overhead
of a lot of sockets when the data data is low.
I'm sure epoll() solves the actual problem.

	David



