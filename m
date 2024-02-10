Return-Path: <linux-sctp+bounces-22-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD28505C9
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AE81F24D6F
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1295D468;
	Sat, 10 Feb 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="OM1jPip0"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE35CDDA
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707587337; cv=none; b=RkId4/QlMSVG+uqUK5qOqowkDo8pv087pbbvtYplifOKQVWxaGDGlNaG5CzoPbal81fqOWV/BMaiTjm59nWEFkK0Mig92ox/OWFqrtPhRm+bGw0jkCafA0gXtR0i7t4yUWJXnnxdVWIv47boSd40opoj7P1z8iOgeuKorEaI+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707587337; c=relaxed/simple;
	bh=qDJt6rRrBpsgOnLZHa07+WW4fWj80m4HNHrXW75475o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DZeXGD8gTy2l9F/XbNmIY1vZGC8/0mhr9VZc5lD28wVi0uODjLffnmIPapDGJF3eoZ2yxqskSM1JumxOrCis8Zo5UP08uVp5rL/8J+Jt9Azu95uCA2ipBpcp/HImCrZqIn92wqhH3M3MeJSK/xJlqeLFnq2Y/S4A3Mf1KyNsBWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=OM1jPip0; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1EA47240028
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 18:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1707587326; bh=qDJt6rRrBpsgOnLZHa07+WW4fWj80m4HNHrXW75475o=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=OM1jPip0VU2IN0+X1zdDELKVbzaj214iGGPL/ArEHkk5ZX/5W8KFcJ3sj8wb6W5WG
	 BEnVD4yJwcVKfeTS8ptr1v/BppObYavyGu4+YbqZb5K1B1ShCMo9M5d34md2n1/78w
	 pV6vdkhckM5LgBvQz23EHGA+3cz3FcA7alTfxHI6cvepAFJQCLP7dQMB/VBLKGfDV7
	 gbACH5MBGTSiVZgoFu/I27a3NCEpl1/c3ruZUtm6mtXY7r3EAVFj1mKcjvm5COf1sL
	 qHq44Ylmm2vwsJMTpXTS0D81VDerJbvIO5LilOVftgaa5c+zpaaVWyX28iRUewfwkt
	 WMs1ZlsOX5zEg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TXJ9n1Qznz6tvp;
	Sat, 10 Feb 2024 18:48:45 +0100 (CET)
Message-ID: <04c483f34daaebb95d8de56e8e6a49a473c04fe4.camel@posteo.de>
Subject: Re: Linux SCTP multihoming question
From: Philipp Stanner <stanner@posteo.de>
To: David Laight <David.Laight@ACULAB.COM>, "'o.evistel@free.fr'"
	 <o.evistel@free.fr>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-sctp <linux-sctp@vger.kernel.org>, 'Andreas Fink'
	 <afink@list.fink.org>
Date: Sat, 10 Feb 2024 17:48:44 +0000
In-Reply-To: <557a01dfcfd440e6b1b1b1762839d033@AcuMS.aculab.com>
References: 
	<6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
	 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
	 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
	 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
	 <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
	 <365e312e60de89031d2c816e502f18b4d74b98c7.camel@posteo.de>
	 <557a01dfcfd440e6b1b1b1762839d033@AcuMS.aculab.com>
Autocrypt: addr=stanner@posteo.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Samstag, dem 10.02.2024 um 17:34 +0000 schrieb David Laight:
> From: Philipp Stanner
> > Sent: 10 February 2024 17:09
> >=20
> > Am Samstag, dem 10.02.2024 um 17:03 +0000 schrieb David Laight:
> > > From: o.evistel@free.fr
> > > > Sent: 09 February 2024 10:06
> > > >=20
> > > > I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4
> > > > with
> > > > multihoming (sctp_bindx(), sctp_connectx() API functions).
> > > > I would like to know, after association setup, if it is
> > > > possible to
> > > > instruct SCTP to use a specific local address from the list of
> > > > bound
> > > > addresses to reach the peer.
> > >=20
> > > Unlikely in the extreme.
> > >=20
> > > If there are 'n' bound local addresses and 'm' remote addresses
> > > (IIRC from the INIT_ACK - but they come from the far end) then
> > > Linux only verifies a route to each local address and picks an
> > > appropriate local address for each one.
> > > So it only sends heartbeats to 'm' addresses, not on 'n * m'
> > > address pairs.
> > >=20
> > > So if anything of this nature did exist it would limit the
> > > remote addresses used, not the local ones.
> >=20
> > I've been told once that using the socket option SO_BINDTODEVICE
> > should
> > serve the trick, i.e., it should provoke Linux into choosing the
> > picked
> > device's IP addr as the source IP addr.
> >=20
> > I've never tested / verified that, though.
> > I'm also not sure if it would have other negative consequences,
> > such as
> > limiting the reachability through non-bound devices.
>=20
> But won't that defeat the entire point of SCTP multihoming?

I guess it defeats the philosophy of the OS with its routing table
being solely responsible for choosing a source address.
I don't see how SCTP would be affected by that, though. SCTP doesn't
demand a certain number of interfaces being available, nor does it make
statements about how the networks behind the interfaces might or might
not be interconnected.

> You need two interfaces in different subnets that use entirely
> separate IP networks to connect to the two addresses the remote
> system gives you.
> (There are really only ever two addresses for each system.)

I assume you're coming from the perspective of a user where SCTP is
utilized with completely redundant and separated networks for
redundancy.
I, however, have only used the protocol in the normal boring Internet =E2=
=80=93
and there it's definitely possible to reach N endpoints from just 1
outgoing interface. All the endpoints are connected to the Internet,
after all, so the routers will ultimately direct your packages to the
target addr.

>=20
> I don't know what the standards people were smoking, but the
> default 'send all my IP addresses to the far end' is so broken.

How else could you implement it?
Only alternative I can think of would be to have some sort of multi-
homing DNS that provides you with several addresses.

P.

> Requiring the application to know which addresses are 'local'
> (typically 192.178.x.x and 10.x.x.x) and pretty much must never
> be sent to a remote system (where they can easily mean something
> else) is just wrong, it ought to be a property of the protocol stack.
>=20
> Never mind that the fact that API calls like bindx() were originally
> implemented using socket options being embedded in the standard.
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)


