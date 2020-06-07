Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A903B1F0B98
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFGOAG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 10:00:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49528 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgFGOAG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 10:00:06 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2020 10:00:04 EDT
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-129-aFxd0jdTPgiUnIUgYX1cSQ-1; Sun, 07 Jun 2020 14:53:19 +0100
X-MC-Unique: aFxd0jdTPgiUnIUgYX1cSQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 7 Jun 2020 14:53:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 7 Jun 2020 14:53:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Tuexen' <Michael.Tuexen@lurchi.franken.de>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: RE: packed structures used in socket options
Thread-Topic: packed structures used in socket options
Thread-Index: AQHWPLpUTq2nADe9c02l9PzEMhJDA6jNLBzw
Date:   Sun, 7 Jun 2020 13:53:18 +0000
Message-ID: <ec8c26c792ea414dbe50bda45725d26f@AcuMS.aculab.com>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
In-Reply-To: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de>
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
> 
> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
> of packetdrill, which supports SCTP.
> 
> Here is why:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
> .7
> contains:
> 
> struct sctp_paddrparams {
> 	sctp_assoc_t		spp_assoc_id;
> 	struct sockaddr_storage	spp_address;
> 	__u32			spp_hbinterval;
> 	__u16			spp_pathmaxrxt;
> 	__u32			spp_pathmtu;
> 	__u32			spp_sackdelay;
> 	__u32			spp_flags;
> 	__u32			spp_ipv6_flowlabel;
> 	__u8			spp_dscp;
> } __attribute__((packed, aligned(4)));
> 
> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
> Why is it packed?

I'm guessing 'to remove holes to avoid leaking kernel data'.

The sctp socket api defines loads of structures that will have
holes in them if not packed.

OTOH they shouldn't have been packed either.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

