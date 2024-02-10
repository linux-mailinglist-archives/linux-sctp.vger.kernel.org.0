Return-Path: <linux-sctp+bounces-20-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4966F850588
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 18:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55ED1F247D0
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D551016;
	Sat, 10 Feb 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="rIAG8sg9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400A4F8B5
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584962; cv=none; b=LmNN6CvpFWRMZ4+LGbNHVOlVdD1JpsIoVajuku7I0I4bffKfcNGYMbppbTNiVzcQnplRnaRZU0uH1zM2ZDgSBSSwExvwg1WSY9o/nuS0Sr25h78jY/ktT2VViMLYGcFU2e5Kxi2GQzVvSRl8UOmh7voarK4fdwvoLD1bWiQDjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584962; c=relaxed/simple;
	bh=tS85dAHq18M0/E3SEbSnUenMVOVngwQlCarway5FGwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN7lk8wP4BPxxsETucroraWE154vsjCvN/MedAC+bQ+THQpmr6BYBgDiuSokOoD17DzvKGDCtni+kz7pyDkAIHdfJx2RdRqnOFlUiwm+Lql3MxDRrqRQL1IKmq52yZ+YlGm/WT3ClSJ88MNexWPMYdmTe/k+CExe1r8VzhhN9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=rIAG8sg9; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 5F3C0240101
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 18:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1707584952; bh=tS85dAHq18M0/E3SEbSnUenMVOVngwQlCarway5FGwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=rIAG8sg9CKnr+maIyeQmSj8taEPjpgeim/cLy/SxCHQZib5wRcOIJ+35viNZwU05V
	 /MLHlM9cC7qbeXpORTDaR5wsjZZz1FCEekIgM0PFUHkb1zFdODkfZwQCaJgBWXPrE0
	 7TvWuQXnozuIoUdWMBbRTrsk/oantPxGs+yvVNrXBc4bLwPlYgp6SCQTqp3NZlP6FF
	 Xc8EF1uQRciCqwh58fKAxI2xX5+IKQDhpzjTiK/x6mrHNFr5GGET65ttlZvZiXjgar
	 rJ6etPKeqjZ1WcSbiHgoq04nb6Epm6zhGFPdh+OQqAAX/V5z0O4g8nJQ+bddfThLQh
	 jlu0HgT46YexA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TXHJ71MX2z6twP;
	Sat, 10 Feb 2024 18:09:10 +0100 (CET)
Message-ID: <365e312e60de89031d2c816e502f18b4d74b98c7.camel@posteo.de>
Subject: Re: Linux SCTP multihoming question
From: Philipp Stanner <stanner@posteo.de>
To: David Laight <David.Laight@ACULAB.COM>, "'o.evistel@free.fr'"
	 <o.evistel@free.fr>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-sctp <linux-sctp@vger.kernel.org>, 'Andreas Fink'
	 <afink@list.fink.org>
Date: Sat, 10 Feb 2024 17:09:10 +0000
In-Reply-To: <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
References: 
	<6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
	 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
	 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
	 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
	 <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
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

Am Samstag, dem 10.02.2024 um 17:03 +0000 schrieb David Laight:
> From: o.evistel@free.fr
> > Sent: 09 February 2024 10:06
> >=20
> > I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4
> > with
> > multihoming (sctp_bindx(), sctp_connectx() API functions).
> > I would like to know, after association setup, if it is possible to
> > instruct SCTP to use a specific local address from the list of
> > bound
> > addresses to reach the peer.
>=20
> Unlikely in the extreme.
>=20
> If there are 'n' bound local addresses and 'm' remote addresses
> (IIRC from the INIT_ACK - but they come from the far end) then
> Linux only verifies a route to each local address and picks an
> appropriate local address for each one.
> So it only sends heartbeats to 'm' addresses, not on 'n * m'
> address pairs.
>=20
> So if anything of this nature did exist it would limit the
> remote addresses used, not the local ones.

I've been told once that using the socket option SO_BINDTODEVICE should
serve the trick, i.e., it should provoke Linux into choosing the picked
device's IP addr as the source IP addr.

I've never tested / verified that, though.
I'm also not sure if it would have other negative consequences, such as
limiting the reachability through non-bound devices.


P.


>=20
> I think you'll also find that specifying multiple address with
> sctp_connectx() only affects where the initial INIT is sent to
> (I suspect the addresses get tried in turn).
> Once the connection is established the addresses received from
> the remote system are almost certainly used instead.
>=20
> We don't use connectx(), just try a list of addresses in sequence.
> This can then contain the addresses of alternate systems as well
> and alternate addresses for a single system.
>=20
> If does have to be said that M3UA works a lot better over TCP!
> As well as being a far lighter protocol it is much easier to
> get multiple M3UA messages into a single ethernet frame with TCP.
>=20
> If you've got 10 messages to send, you can use a single send()
> to send them (etc). A single recv() can read lots of pending
> message and you can cheaply debatch them in userspace.
>=20
> This all starts mattering when you are trying to send 10000
> SMS every second (we don't know what they are sending...)
>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)


