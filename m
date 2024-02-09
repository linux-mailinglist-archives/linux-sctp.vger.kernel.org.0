Return-Path: <linux-sctp+bounces-17-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85684F4FF
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF00281F9D
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9D2E644;
	Fri,  9 Feb 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="E78pSaSl"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A53611A
	for <linux-sctp@vger.kernel.org>; Fri,  9 Feb 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480222; cv=none; b=ismHzXkPVXU/aeAXBTCckwozJYJzXZTeME2ZT33FTe5rYsKSOchbcuWw09ErItYdAXazMMaw58EEQSU17B2ZrichdGqTaukW3c893pnH0uKgczQCviYSRpdemNKt1O5CDZvlr+8KFRBto1y3sTVPr8m3Ce8kgJlHZuvfsmJCdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480222; c=relaxed/simple;
	bh=RGXc1zX4Vrle39lXkAMLobeUN8zGP0KM5jFVMbG4++Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bc97GBxmiJHENiXV/14e03dGYqm6ldpVSAo3Bl5wyJsbmgFR1kCsm3BwnZCvJGkPd9BI/Ulv6qjPK9gjzezG3b1gxINmg5toUMz74nurXK45ZkZGDXPFhSHurUZlew/Z28kol7Esh6FedxIhqysgYS0Hb8ubWcBrn134te3J8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=E78pSaSl; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
	by smtp1-g21.free.fr (Postfix) with ESMTP id EF9C1B00596;
	Fri,  9 Feb 2024 13:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1707480210;
	bh=RGXc1zX4Vrle39lXkAMLobeUN8zGP0KM5jFVMbG4++Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=E78pSaSlrkpxQ4h5o92427QqBYub2UUAse1Mhfr2cB4gJIDP7u0G0MQbGLEZP0F1C
	 XiEG9GBO+xhXA1n3I2/mjuf0SJu6kUUgsOvQSse6ECaxhb9brHjyaxdyZaRU3Tv/fn
	 ArB5wVGxoJ6xBIsJTVdnBnwBlmG+ScReVVw4M/GcibbWEUHmDXKmee1gqx1GyPpBQg
	 WTOGogJ6Dg1IMg6fTjsSPn2I9Ow1qjfVlnfLa1x9HyBMVpmk1432wTYX2+bW1fWHer
	 pPvMb0Wz+BG84QMc0h5/9spmz+sxdwgQxtUMnYGcmXEr2hZ661rpmcueiHmHFbmYXW
	 ggQWMMPCj2amQ==
Date: Fri, 9 Feb 2024 13:03:30 +0100 (CET)
From: o.evistel@free.fr
To: Andreas Fink <afink@list.fink.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	linux-sctp <linux-sctp@vger.kernel.org>
Message-ID: <1053910852.115494076.1707480210747.JavaMail.zimbra@free.fr>
In-Reply-To: <483A5123-AA38-48EC-8158-120DFFC1E5D8@list.fink.org>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain> <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr> <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr> <6709B96C-917E-4E70-9DD6-D555534F791F@list.fink.org> <1499880370.115105615.1707476512676.JavaMail.zimbra@free.fr> <483A5123-AA38-48EC-8158-120DFFC1E5D8@list.fink.org>
Subject: Re: Linux SCTP multihoming question
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF122 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP multihoming question
Thread-Index: tj1L2UeBaofTTcKxfRBytKDYVqn6oQ==

Andreas

Do you where I can find the description these ioctl calls.

Regards
Omar
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----- Mail original -----
De: "Andreas Fink" <afink@list.fink.org>
=C3=80: "OMAR AIT AMRANE" <o.evistel@free.fr>
Envoy=C3=A9: Vendredi 9 F=C3=A9vrier 2024 12:09:48
Objet: Re: Linux SCTP multihoming question

I don't think the SCTP protocol allows this to choose. As it's a hot/hot se=
tup. Multiple path can be used at the same time. But there might be some io=
ctl calls to force it.


> On 9 Feb 2024, at 12:01, o.evistel@free.fr wrote:
>=20
> Hi Andreas,
>=20
> My explanation was not clear enough.
>=20
> I would like to know if it is possible to force sctp to use alernate addr=
ess instead of primary address while both of them are available.
>=20
> Regards
> Omar=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ----- Mail original -----
> De: "Andreas Fink" <afink@list.fink.org>
> =C3=80: "OMAR AIT AMRANE" <o.evistel@free.fr>
> Cc: "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>, "linux-sctp" <=
linux-sctp@vger.kernel.org>
> Envoy=C3=A9: Vendredi 9 F=C3=A9vrier 2024 11:10:22
> Objet: Re: Linux SCTP multihoming question
>=20
> yes this is possible. My eSTP does this exactly this way. for M3UA and M2=
PA You simply use sctp_bindx to bind to exact local address you need.
> You can add or remove local IP's and alter the association. But I'm not s=
ure if you can force a specific path to be used as primary. SCTP basically =
can use any and switch over to the other.
>=20
> If you think of something like hot/standby setup, you might want to do th=
is on M3UA level which means having two SCTP associations (two ASPs in one =
AS)
>=20
>=20
>=20
>> On 9 Feb 2024, at 11:05, o.evistel@free.fr wrote:
>>=20
>>=20
>> Dear Marcelo
>>=20
>> I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 with mul=
tihoming (sctp_bindx(), sctp_connectx() API functions).
>> I would like to know, after association setup, if it is possible to inst=
ruct SCTP to use a specific local address from the list of bound addresses =
to reach the peer.
>>=20
>> Regards
>> Omar AIT AMRANE
>>=20
>

