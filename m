Return-Path: <linux-sctp+bounces-24-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04AC8505FC
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 19:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B571C21D05
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6AD5CDF4;
	Sat, 10 Feb 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oUVh7tD1"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A175C8F3
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707590249; cv=none; b=tYR7Qj9HTK5wlNQbaL7DJ7FsqcJC+6zs7diOx5znHorzJ8UsOgECdtR2qFgE+say/cPtn4vkOLBmBvL8EgXFq81eSlmKoETAJkxXE+tNCU5phicXX0GYClZm502F/PBoO2pGjV2KIDHA3LFnjsG/FyH4P08rG6Qpmn8GAfrHXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707590249; c=relaxed/simple;
	bh=PrQAkGlfHVXwd91QUTYymDSWCqOSdFgjjZfJ7u9rDRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RBIadQoTgysy1jhUKhCO9CO13om+oSfV60xK5HxexyngJYozF5uihSjZYexwz+nmmtBdd3wdfNedhnyLx6q65o32iQzahwWmpdv0RdjwXZmRada3yr0nCaXE/Np5Fh4Kb27lp0yRaRBv0gr6No1b9kCrJN39+KWoKf/OR/s16N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=oUVh7tD1; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 411AA240103
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 19:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1707590244; bh=PrQAkGlfHVXwd91QUTYymDSWCqOSdFgjjZfJ7u9rDRU=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=oUVh7tD1nRlH+QP5CfMg2AYHlWnlHSh+gs+bUTW9s2OJeFYPFccz5cN4YZ4gTnORM
	 NwJibqtOhqq+XChWoOgJ7nU3HGOV0uaYYQP4yyCbFzz1scT/iJWN4VOOaNzeh2JDdZ
	 wUKLJkd0zOvslmgzdh9bNoNJ5d3jcEpg6F44DidukAJjGgIlC4imlkXDIkptajN3F6
	 03Y09NXKrTeDxbx7UbFMpFVnuoVz4+woVKWDtIotSn3WqjXCMKNNZU2B9JQBBViaVN
	 XE2j4DKPoWjlTvJaSQOo4BJVylhWv+PCHbvylZZoq1RGYco1B5wwBgDnVsRszXGWTW
	 KqgwzslH7MB+A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TXKFv2vhVz9rxB;
	Sat, 10 Feb 2024 19:37:23 +0100 (CET)
Message-ID: <deee97b3aeb2637434d27ea36ff70e5b1f35655f.camel@posteo.de>
Subject: Re: Linux SCTP multihoming question
From: Philipp Stanner <stanner@posteo.de>
To: David Laight <David.Laight@ACULAB.COM>, "'o.evistel@free.fr'"
	 <o.evistel@free.fr>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-sctp <linux-sctp@vger.kernel.org>, 'Andreas Fink'
	 <afink@list.fink.org>
Date: Sat, 10 Feb 2024 18:37:23 +0000
In-Reply-To: <ddc189ebea24410c9387bff2de543f34@AcuMS.aculab.com>
References: 
	<6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
	 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
	 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
	 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
	 <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
	 <365e312e60de89031d2c816e502f18b4d74b98c7.camel@posteo.de>
	 <557a01dfcfd440e6b1b1b1762839d033@AcuMS.aculab.com>
	 <04c483f34daaebb95d8de56e8e6a49a473c04fe4.camel@posteo.de>
	 <ddc189ebea24410c9387bff2de543f34@AcuMS.aculab.com>
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

Am Samstag, dem 10.02.2024 um 18:02 +0000 schrieb David Laight:
> From: Philipp Stanner
> > Sent: 10 February 2024 17:49
> ...
> > > But won't that defeat the entire point of SCTP multihoming?
> >=20
> > I guess it defeats the philosophy of the OS with its routing table
> > being solely responsible for choosing a source address.
> > I don't see how SCTP would be affected by that, though. SCTP
> > doesn't
> > demand a certain number of interfaces being available, nor does it
> > make
> > statements about how the networks behind the interfaces might or
> > might
> > not be interconnected.
>=20
> You need to look at why it exists, and what it was trying to
> replicate.
> SCTP is all about carrying telephony signalling over the IP network.
> So it is trying (and failing for all sorts of reasons) to give
> the same sort of error detection and redundancy as SS7 MTP2 and MTP3.
>=20
> The normal level of redundancy is to have two separate MTP2 links
> (a linkset) to each of two different remote MTP3 systems.
> If you are doing it right each MTP2 link is on a separate physical
> cable.
> The SCTP connection is trying to replicate the linkset to a remote
> system - so you need two local interfaces connected to two remote
> ones.
> You can have more, but it is basically pointless.
>=20
> > > You need two interfaces in different subnets that use entirely
> > > separate IP networks to connect to the two addresses the remote
> > > system gives you.
> > > (There are really only ever two addresses for each system.)
> >=20
> > I assume you're coming from the perspective of a user where SCTP is
> > utilized with completely redundant and separated networks for
> > redundancy.
>=20
> That is what it is designed for.

All that may be true regarding the original _motivation_ behind the
protocol, but the relevant documents, the RFCs, make no such
statements.
And rightfully so, because a transport protocol should never be tied to
a specific narrow usecase, although people seem to have a hard time
learning that lesson (looking at you, QUIC).
You can even use SCTP as a mere TCP replacement, plainly writing to it
with write(). It's completely up to you. Just as the number of
interfaces you use is.

The protocol even specifies the upper layer protocol number field,
specifically designed to multiplex all sorts of payload protocols (SSH,
HTTP...) over it.


P.

>=20
> > I, however, have only used the protocol in the normal boring
> > Internet =E2=80=93
> > and there it's definitely possible to reach N endpoints from just 1
> > outgoing interface. All the endpoints are connected to the
> > Internet,
> > after all, so the routers will ultimately direct your packages to
> > the
> > target addr.
>=20
> I hope you aren't running any of the SIGTRAM protocols...
>=20
> > > I don't know what the standards people were smoking, but the
> > > default 'send all my IP addresses to the far end' is so broken.
> >=20
> > How else could you implement it?
> > Only alternative I can think of would be to have some sort of
> > multi-
> > homing DNS that provides you with several addresses.
>=20
> Given the security in all the SIGTRAN protocols you always used
> fixed IP addresses and (in reality) better be using VPN tunnels
> if you go anywhere near the public IP network.
>=20
> You need some property that can be assigned to the local IP /
> interface
> to indicate which ones can be grouped together.
> This is already done to exclude localhost.
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)


