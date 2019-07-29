Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C602789B4
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jul 2019 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfG2KjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 29 Jul 2019 06:39:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:31963 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728151AbfG2KjU (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 29 Jul 2019 06:39:20 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-24-dISn8bX0OCytxGZ1hwsOwQ-1; Mon, 29 Jul 2019 11:39:17 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 29 Jul 2019 11:39:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 29 Jul 2019 11:39:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Qian Cai' <cai@lca.pw>,
        "vyasevich@gmail.com" <vyasevich@gmail.com>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
Thread-Topic: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
Thread-Index: AQHVQ/TTkQHT5kEjjEefGhuj7/2hGabhauMA
Date:   Mon, 29 Jul 2019 10:39:16 +0000
Message-ID: <158b26b6f3b24164aceacd2428095315@AcuMS.aculab.com>
References: <1564174659-21211-1-git-send-email-cai@lca.pw>
In-Reply-To: <1564174659-21211-1-git-send-email-cai@lca.pw>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dISn8bX0OCytxGZ1hwsOwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Qian Cai
> Sent: 26 July 2019 21:58
> 
> There are a lot of those warnings with GCC8+ 64bit,
> 
...
> Fix them by aligning the structures and fields to 8 bytes instead.
...
>  struct sctp_setpeerprim {
>  	sctp_assoc_t            sspp_assoc_id;
> -	struct sockaddr_storage sspp_addr;
> -} __attribute__((packed, aligned(4)));
> +	struct sockaddr_storage sspp_addr __attribute__((aligned(8)));
> +} __attribute__((packed, aligned(8)));

What happens to this one if you change both to aligned(4) ?
Much the same way as:
	struct {
		int a;
		long b __attribute__((aligned(4));
	};
is only 12 bytes on (most) 64bit systems.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

