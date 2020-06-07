Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7961F0B9D
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgFGOEE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 10:04:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53058 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgFGOED (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 10:04:03 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-GPni-pMpM5S8hCZ5rppRFg-1; Sun, 07 Jun 2020 15:04:00 +0100
X-MC-Unique: GPni-pMpM5S8hCZ5rppRFg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 7 Jun 2020 15:04:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 7 Jun 2020 15:04:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Tuexen' <Michael.Tuexen@lurchi.franken.de>,
        Andreas Fink <afink@list.fink.org>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: EAGAIN
Thread-Topic: EAGAIN
Thread-Index: AQHWPMnW/N1MQUClykqBA+7CPBbJvajNLX5w
Date:   Sun, 7 Jun 2020 14:04:00 +0000
Message-ID: <021ba1317114431290cc2aae12a4ee64@AcuMS.aculab.com>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
 <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
In-Reply-To: <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Michael Tuexen
> Sent: 07 June 2020 13:48
...
> If you killed the peer, I would assume that there is an SCTP message containing an
> ABORT chunk in the wire. Is that true? If that is true, you could subscribe to
> SCTP_ASSOC_CHANGE notification, which should tell you.

Actually for TCP-style 1-1 connections you must subscribe to
SCTP_ASSOC_CHANGE.

If you don't and the far end is killed (eg kernel crash) and
restarts with the same port number pair then you get no
indication that everything has disconnected and reconnected.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

