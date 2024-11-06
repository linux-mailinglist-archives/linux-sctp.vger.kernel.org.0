Return-Path: <linux-sctp+bounces-280-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B569BF7F8
	for <lists+linux-sctp@lfdr.de>; Wed,  6 Nov 2024 21:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD331F224B1
	for <lists+linux-sctp@lfdr.de>; Wed,  6 Nov 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9120C035;
	Wed,  6 Nov 2024 20:26:09 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71A20C03A
	for <linux-sctp@vger.kernel.org>; Wed,  6 Nov 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924769; cv=none; b=OF50B5e9PNSMWZWh/nX3HZtWX0iodeWkyOcQBhV9EFCnD039mT7yDUDPHcNdFHY7gs77M84wROVnbshKcFolixlJtsKNoGySnh4z372kec13hXByDvlXL0jWXuYEHWzFMCoMCJBGmyup/CTqTAZDghxE69J4iR2/hImlD2DiIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924769; c=relaxed/simple;
	bh=wm5auVu7lepT1RgCi1Ph+VnsmSMAsE1lH7xAq+00fyo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=n7w891U5+q/rmdD6OglL7aElsRMap97FWMtszLOGDuo2qj39eK9bvDujg7B2cDVXU+6RbICVnxyFbDtsBngxSLxwcSpSjzq/9l49+foHGyI/zX9UrbyZWpdyS5LJ7ihadqwXPuoMYKnlHkzO61y+0DJvXjJdFrTBx+38x7s1HBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-139-Y9pSwt7JNfKftukdoehEKg-1; Wed, 06 Nov 2024 20:24:39 +0000
X-MC-Unique: Y9pSwt7JNfKftukdoehEKg-1
X-Mimecast-MFC-AGG-ID: Y9pSwt7JNfKftukdoehEKg
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Nov
 2024 20:24:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Nov 2024 20:24:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gilad Naaman' <gnaaman@drivenets.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: Solving address deletion bottleneck in SCTP
Thread-Topic: Solving address deletion bottleneck in SCTP
Thread-Index: AQHbKTfUlFxD3u3SLUymStEPmRsdV7KqvpHA
Date: Wed, 6 Nov 2024 20:24:37 +0000
Message-ID: <f94c0197f6c74d7db1f56b82c459c42a@AcuMS.aculab.com>
References: <20241028124845.3866469-1-gnaaman@drivenets.com>
In-Reply-To: <20241028124845.3866469-1-gnaaman@drivenets.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yh_0UGlXHGLzcZRBlc84ECaG3-hMiL0pNSzzQkEfRYg_1730924677
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Gilad Naaman
> Sent: 28 October 2024 12:49
...
> the list `net->sctp.local_addr_list` gets obscenely long.
>=20
> This list contains both IPv4 and IPv6 addresses, of all scopes, and it is
> a single long list, instead of a hashtable.
>=20
> In our case we had 12K interfaces, each with an IPv4 and 2 IPv6 addresses
> (GUA+LLA), which made deletion of a single address pretty expensive, sinc=
e
> it requires a linear search through 36K addresses.
...

Is that the list that SCTP uses in order to pass all of its local addresses
to the remote system during connection establishment?

In which case it really makes no sense to have the list at all if it contai=
ns
more than a handful of addresses.

Indeed the whole notion of 'send ALL my addresses' is just plain broken.
What happens in practise is that applications pretty much always have to
bind to all (typically both) the relevant addresses to stop the system
sending IP addresses that are unroutable from the remote system - and
may even refer to an entirely different local network.

Passing this buck to the application isn't really right either.
It ought to be a property of the network topology.
But that is hard to describe.
The two systems 10.1.1.1 and 10.1.1.2 could both have private 192.168.1.x
networks (without IP forwarding) and other 10.1.1.x hosts could be
randomly connected to either network.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


