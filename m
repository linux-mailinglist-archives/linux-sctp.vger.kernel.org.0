Return-Path: <linux-sctp+bounces-168-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CF8D8640
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Jun 2024 17:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D56F1F23247
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Jun 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A21132110;
	Mon,  3 Jun 2024 15:41:24 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758BD132105
	for <linux-sctp@vger.kernel.org>; Mon,  3 Jun 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429284; cv=none; b=o8wU5IS39nlrQCY4DosE9sX9fYOTMHtc9al8qOHCYbeiBZUh3gWmcylhcSng8KqTnirXC3z6rSBYea51cyE6uYh51cA/ML1kLOOIQngvcb1MB5yeZ3+fC0TWmD93H8SqC4nmRLoVgaf7k7/IfmZ36/c8/5HMCRCLtfDJmi0GXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429284; c=relaxed/simple;
	bh=3VudYg20/y/EaXfg1mqXl0DAjnCh9ZSW1omJW3es4Sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XG4y4G4wLPqe3BGuYbDQg9oqslRZXRwepeOjlRjQG5CGlf44eRfhPa6aDKROV+y4T2T5/nzVc24jNEJ7cmvm6xhzfCOCzTq2JZRCSqiJMflgqIrhmpcUzz7yswkAE8WXNJRg4kBfb23zsEQkkdOge6lzfr6U+oZH49A6Cr0lyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-147-GAt3ON1kPJqDSfIJeMpDEA-1; Mon, 03 Jun 2024 16:40:03 +0100
X-MC-Unique: GAt3ON1kPJqDSfIJeMpDEA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 3 Jun
 2024 16:39:22 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 3 Jun 2024 16:39:22 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: linux-sctp <linux-sctp@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: SCTP doesn't seem to let you 'cancel' a blocking accept()
Thread-Topic: SCTP doesn't seem to let you 'cancel' a blocking accept()
Thread-Index: Adq1ybjOUyi6xNR1Tiu+WEi2iGmOKw==
Date: Mon, 3 Jun 2024 15:39:22 +0000
Message-ID: <4faeb583e1d44d82b4e16374b0ad583c@AcuMS.aculab.com>
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
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In a multithreaded program it is reasonable to have a thread blocked in acc=
ept().
With TCP a subsequent shutdown(listen_fd, SHUT_RDWR) causes the accept to f=
ail.
But nothing happens for SCTP.

I think the 'magic' happens when tcp_disconnect() calls inet_csk_listen_sto=
p(sk)
but sctp_disconnect() is an empty function and nothing happens.

I can't see any calls to inet_csk_listen_stop() in the sctp code - so I sus=
pect
it isn't possible at all.

This all relates to a very old (pre git) comment in inet_shutdown() that
shutdown needs to act on listening and connecting sockets until the VFS
layer is 'fixed' (presumably to let close() through - not going to happen.)

I also suspect that a blocking connect() can't be cancelled either?

Clearly the application can avoid the issue by using poll() and an
extra eventfd() for the wakeup - but it is all a faff for code that
otherwise straight forward.

=09=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


