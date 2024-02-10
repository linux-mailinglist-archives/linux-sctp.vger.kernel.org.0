Return-Path: <linux-sctp+bounces-19-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DF850584
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 18:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F4B1F22619
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Feb 2024 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9255CDCC;
	Sat, 10 Feb 2024 17:03:31 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9F5CDD3
	for <linux-sctp@vger.kernel.org>; Sat, 10 Feb 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584611; cv=none; b=R4r/b3bI/4hSS2SjNBriDrMSES/VjlyeOp7UL5j0yKlDg7ITJzgX8MBKmv9Mdyq2rcuPNfkkjFpzW0iwEb7wxc8bt5T/nZfq/jddE++KilNBds8VvEQsnnkbZJuJzKyyBv2Pq4DvDZUUb7bwxregG/FM34AcXcgxrWPS/LmtcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584611; c=relaxed/simple;
	bh=3er7fJ6tTjahhCzBZ80DC/b8pR6own5oJzhrubwl19s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lGMEyS4TOUscrQXFTbqO4902TSkpzcCKsuwPgNfTMOcRHumRUti1LZx0B3FVnyg8/R2+n1O64hrJj1uzXrZk9tX/bblc2zxHhmCa7RLLm3ltUIu5Y+AmZ3Jc3O8CVhygSV6MGAMpk0PFHip14C6V1CZ6zHdH4o8PfsBRGocu0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-31-AOCRNjtsOuGpqvYUUTtIUA-1; Sat, 10 Feb 2024 17:03:25 +0000
X-MC-Unique: AOCRNjtsOuGpqvYUUTtIUA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 17:03:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 17:03:04 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'o.evistel@free.fr'" <o.evistel@free.fr>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>
CC: linux-sctp <linux-sctp@vger.kernel.org>, 'Andreas Fink'
	<afink@list.fink.org>
Subject: RE: Linux SCTP multihoming question
Thread-Topic: Linux SCTP multihoming question
Thread-Index: AdpcQw7o42LnVkYaSYSLKU43k+X0CA==
Date: Sat, 10 Feb 2024 17:03:04 +0000
Message-ID: <6455bdeb746c4236a1ecc430ba05e707@AcuMS.aculab.com>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net>
 <YsbiDrG1PQ2Gng5T@t14s.localdomain>
 <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
 <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
In-Reply-To: <1024792113.114715673.1707473146836.JavaMail.zimbra@free.fr>
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
Content-Transfer-Encoding: base64

RnJvbTogby5ldmlzdGVsQGZyZWUuZnINCj4gU2VudDogMDkgRmVicnVhcnkgMjAyNCAxMDowNg0K
PiANCj4gSSBhbSB1c2luZyBsaW51eC1zY3RwIGFzIHRyYW5zcG9ydCBmb3IgU0lHVFJBTiBNM1VB
IG9uIFJIRUwgOC40IHdpdGgNCj4gbXVsdGlob21pbmcgKHNjdHBfYmluZHgoKSwgc2N0cF9jb25u
ZWN0eCgpIEFQSSBmdW5jdGlvbnMpLg0KPiBJIHdvdWxkIGxpa2UgdG8ga25vdywgYWZ0ZXIgYXNz
b2NpYXRpb24gc2V0dXAsIGlmIGl0IGlzIHBvc3NpYmxlIHRvDQo+IGluc3RydWN0IFNDVFAgdG8g
dXNlIGEgc3BlY2lmaWMgbG9jYWwgYWRkcmVzcyBmcm9tIHRoZSBsaXN0IG9mIGJvdW5kDQo+IGFk
ZHJlc3NlcyB0byByZWFjaCB0aGUgcGVlci4NCg0KVW5saWtlbHkgaW4gdGhlIGV4dHJlbWUuDQoN
CklmIHRoZXJlIGFyZSAnbicgYm91bmQgbG9jYWwgYWRkcmVzc2VzIGFuZCAnbScgcmVtb3RlIGFk
ZHJlc3Nlcw0KKElJUkMgZnJvbSB0aGUgSU5JVF9BQ0sgLSBidXQgdGhleSBjb21lIGZyb20gdGhl
IGZhciBlbmQpIHRoZW4NCkxpbnV4IG9ubHkgdmVyaWZpZXMgYSByb3V0ZSB0byBlYWNoIGxvY2Fs
IGFkZHJlc3MgYW5kIHBpY2tzIGFuDQphcHByb3ByaWF0ZSBsb2NhbCBhZGRyZXNzIGZvciBlYWNo
IG9uZS4NClNvIGl0IG9ubHkgc2VuZHMgaGVhcnRiZWF0cyB0byAnbScgYWRkcmVzc2VzLCBub3Qg
b24gJ24gKiBtJw0KYWRkcmVzcyBwYWlycy4NCg0KU28gaWYgYW55dGhpbmcgb2YgdGhpcyBuYXR1
cmUgZGlkIGV4aXN0IGl0IHdvdWxkIGxpbWl0IHRoZQ0KcmVtb3RlIGFkZHJlc3NlcyB1c2VkLCBu
b3QgdGhlIGxvY2FsIG9uZXMuDQoNCkkgdGhpbmsgeW91J2xsIGFsc28gZmluZCB0aGF0IHNwZWNp
ZnlpbmcgbXVsdGlwbGUgYWRkcmVzcyB3aXRoDQpzY3RwX2Nvbm5lY3R4KCkgb25seSBhZmZlY3Rz
IHdoZXJlIHRoZSBpbml0aWFsIElOSVQgaXMgc2VudCB0bw0KKEkgc3VzcGVjdCB0aGUgYWRkcmVz
c2VzIGdldCB0cmllZCBpbiB0dXJuKS4NCk9uY2UgdGhlIGNvbm5lY3Rpb24gaXMgZXN0YWJsaXNo
ZWQgdGhlIGFkZHJlc3NlcyByZWNlaXZlZCBmcm9tDQp0aGUgcmVtb3RlIHN5c3RlbSBhcmUgYWxt
b3N0IGNlcnRhaW5seSB1c2VkIGluc3RlYWQuDQoNCldlIGRvbid0IHVzZSBjb25uZWN0eCgpLCBq
dXN0IHRyeSBhIGxpc3Qgb2YgYWRkcmVzc2VzIGluIHNlcXVlbmNlLg0KVGhpcyBjYW4gdGhlbiBj
b250YWluIHRoZSBhZGRyZXNzZXMgb2YgYWx0ZXJuYXRlIHN5c3RlbXMgYXMgd2VsbA0KYW5kIGFs
dGVybmF0ZSBhZGRyZXNzZXMgZm9yIGEgc2luZ2xlIHN5c3RlbS4NCg0KSWYgZG9lcyBoYXZlIHRv
IGJlIHNhaWQgdGhhdCBNM1VBIHdvcmtzIGEgbG90IGJldHRlciBvdmVyIFRDUCENCkFzIHdlbGwg
YXMgYmVpbmcgYSBmYXIgbGlnaHRlciBwcm90b2NvbCBpdCBpcyBtdWNoIGVhc2llciB0bw0KZ2V0
IG11bHRpcGxlIE0zVUEgbWVzc2FnZXMgaW50byBhIHNpbmdsZSBldGhlcm5ldCBmcmFtZSB3aXRo
IFRDUC4NCg0KSWYgeW91J3ZlIGdvdCAxMCBtZXNzYWdlcyB0byBzZW5kLCB5b3UgY2FuIHVzZSBh
IHNpbmdsZSBzZW5kKCkNCnRvIHNlbmQgdGhlbSAoZXRjKS4gQSBzaW5nbGUgcmVjdigpIGNhbiBy
ZWFkIGxvdHMgb2YgcGVuZGluZw0KbWVzc2FnZSBhbmQgeW91IGNhbiBjaGVhcGx5IGRlYmF0Y2gg
dGhlbSBpbiB1c2Vyc3BhY2UuDQoNClRoaXMgYWxsIHN0YXJ0cyBtYXR0ZXJpbmcgd2hlbiB5b3Ug
YXJlIHRyeWluZyB0byBzZW5kIDEwMDAwDQpTTVMgZXZlcnkgc2Vjb25kICh3ZSBkb24ndCBrbm93
IHdoYXQgdGhleSBhcmUgc2VuZGluZy4uLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


