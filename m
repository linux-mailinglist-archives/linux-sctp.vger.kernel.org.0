Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0140424D935
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Aug 2020 17:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgHUP7z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 21 Aug 2020 11:59:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43616 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgHUP7q (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 21 Aug 2020 11:59:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-190-661JrkFrO--2u5nm-EcQcQ-1; Fri, 21 Aug 2020 16:59:42 +0100
X-MC-Unique: 661JrkFrO--2u5nm-EcQcQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 21 Aug 2020 16:59:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 21 Aug 2020 16:59:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: 64k streams not supported
Thread-Topic: 64k streams not supported
Thread-Index: AdZ304CTRD4hQQAhQWucKVTj4yro3g==
Date:   Fri, 21 Aug 2020 15:59:42 +0000
Message-ID: <bedd13a72afd427ca4dbbdfa61985533@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Isn't SCTP supposed to support 65536 data streams?
If I try to enable that many I get 10.
Not surprising since the number of streams gets stored in a u16.

The whole code base may need changing to save the highest
valid stream?

Since I don't actually need that many I'm not writing the patch.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

