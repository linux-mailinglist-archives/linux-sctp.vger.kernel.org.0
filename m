Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833278B349
	for <lists+linux-sctp@lfdr.de>; Mon, 28 Aug 2023 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjH1OiT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 28 Aug 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjH1OiN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 28 Aug 2023 10:38:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FACA1
        for <linux-sctp@vger.kernel.org>; Mon, 28 Aug 2023 07:38:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-126-q2zIimRsMIeatVzQlQ0RBw-1; Mon, 28 Aug 2023 15:38:07 +0100
X-MC-Unique: q2zIimRsMIeatVzQlQ0RBw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 15:38:10 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 15:38:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andreas Fink' <afink@list.fink.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Subject: RE: SCTP MTU issues
Thread-Topic: SCTP MTU issues
Thread-Index: AQHZ2aeraev+CNFitk+eTWiMmqbe+a//xiZw
Date:   Mon, 28 Aug 2023 14:38:10 +0000
Message-ID: <46f2149013fe4ecbaa0d3146e7265ff6@AcuMS.aculab.com>
References: <27FDC8D4-B7DE-4A3D-B681-2070C9D53D8C@list.fink.org>
In-Reply-To: <27FDC8D4-B7DE-4A3D-B681-2070C9D53D8C@list.fink.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Andreas Fink
> Sent: 28 August 2023 13:03
> 
> I have a specific issue related to SCTP and MTU size and I'm not sure how it should be solved
> correctly.
> 
> I have this setup
> 
> Host A <---> router <---ipsec-tunnel--->  router B <----> Host B
> 
> Host A is my Linux machine and  has a default MTU of 1500
> the IPsec tunnel reduces the MTU to a lower value (1476 or something like that)
> Router-B and Host B are devices we do not control

A thought I had is can you do something that might enable IP-fragmentation
in the ipsec-tunnel so that the longer packets can be transferred?

I rather hope our M3UA customers use ipsec tunnels (or similar) and
no one has ever asked us to limit the mtu.

...
> The other side is a ZTE mobile switch and the partner has no way of controlling the MTU (or they have
> no clue).
> So we can only control the Host A and Router A side.

I'd bet 'no clue' :-)
You'd expect they'd get the same problem with connections to
everywhere else as well.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

