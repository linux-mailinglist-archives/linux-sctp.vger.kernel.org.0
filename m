Return-Path: <linux-sctp+bounces-16-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742B84F40B
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 12:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B13E28A194
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDBA1EA6E;
	Fri,  9 Feb 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="mq8PAZP5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399861F615
	for <linux-sctp@vger.kernel.org>; Fri,  9 Feb 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476523; cv=none; b=rMHfjmb7eG7Ypi0zfvPNTpzlYrqlCxTPNfbDAjvfRHo4IcT7IzF6ZZVJrQARC7dIUFeugQ4s8736Ts7vpiggCMzG+nzpAiYq5gJb9HE3nXTe5tD8TFf71BzPJxiuFHWTnThCrZEv8XScdwV2PXzsbTtqx+iKZdDaoq8GFG3/FnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476523; c=relaxed/simple;
	bh=3QvCBorV068L8PmAcUnLYSLL2VNOaR5jTqIQ/qALYoM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YFRyX6a3p3QNVP2gkL/VE4nEfNehit+jtCs94VZUgFtsve9/xAizcSx5Wu1iubrPTuW6/BEC3CpRt3VZre+V1vebkGCIc9Me2/tp5xaHafUXPUpdr/6efBctNX0rgjJlG0vvarGUD4mTZZFDFTwW7Zupfaf5OGHygY5PuG/Y9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=mq8PAZP5; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 22C7DB0037C;
	Fri,  9 Feb 2024 12:01:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1707476513;
	bh=3QvCBorV068L8PmAcUnLYSLL2VNOaR5jTqIQ/qALYoM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mq8PAZP5/sO+OJ7g7SVBN7dZck2GQUk2Br49B04RO18vDoqvih2cIRklR5DldqRck
	 XD8gUT9JLHARZpGc3dKMob00s74cXK6/iy9kiUvQDGFBeYG+w0SUodT+fpwbQRv7VY
	 VApeqY4C/lA5VsnVa1OWhnU8KqMkBF+Oq0rhQla36Fp/uo2KazQLDmoMlQJCi4iZnQ
	 i2SwTGZYwC2K4XuvNgGoEvfhbYn7JXwUyHTflM8jC7bOEzsJfS8cFO1o2+lSk785I+
	 8lpnSuhchp0qY1Z4LLsUkxiLpDMentCHwpWWoc9SERxYfyMoWqfQIwqoIOQzOotLHv
	 ZocsoI1mERYXQ==
Date: Fri, 9 Feb 2024 12:01:52 +0100 (CET)
From: o.evistel@free.fr
To: Andreas Fink <afink@list.fink.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	linux-sctp <linux-sctp@vger.kernel.org>
Message-ID: <1499880370.115105615.1707476512676.JavaMail.zimbra@free.fr>
In-Reply-To: <6709B96C-917E-4E70-9DD6-D555534F791F@list.fink.org>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain> <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr> <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr> <6709B96C-917E-4E70-9DD6-D555534F791F@list.fink.org>
Subject: Re: Linux SCTP multihoming question
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Disposition-Notification-To: "" <o.evistel@free.fr>
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF122 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP multihoming question
Thread-Index: LOCPKHU2xthZ5JLeLRZf/eXvTXbr3w==

Hi Andreas,

My explanation was not clear enough.

I would like to know if it is possible to force sctp to use alernate addres=
s instead of primary address while both of them are available.

Regards
Omar=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----- Mail original -----
De: "Andreas Fink" <afink@list.fink.org>
=C3=80: "OMAR AIT AMRANE" <o.evistel@free.fr>
Cc: "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>, "linux-sctp" <li=
nux-sctp@vger.kernel.org>
Envoy=C3=A9: Vendredi 9 F=C3=A9vrier 2024 11:10:22
Objet: Re: Linux SCTP multihoming question

yes this is possible. My eSTP does this exactly this way. for M3UA and M2PA=
 You simply use sctp_bindx to bind to exact local address you need.
You can add or remove local IP's and alter the association. But I'm not sur=
e if you can force a specific path to be used as primary. SCTP basically ca=
n use any and switch over to the other.

If you think of something like hot/standby setup, you might want to do this=
 on M3UA level which means having two SCTP associations (two ASPs in one AS=
)



> On 9 Feb 2024, at 11:05, o.evistel@free.fr wrote:
>=20
>=20
> Dear Marcelo
>=20
> I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 with mult=
ihoming (sctp_bindx(), sctp_connectx() API functions).
> I would like to know, after association setup, if it is possible to instr=
uct SCTP to use a specific local address from the list of bound addresses t=
o reach the peer.
>=20
> Regards
> Omar AIT AMRANE
>

