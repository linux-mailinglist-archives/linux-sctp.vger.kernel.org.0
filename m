Return-Path: <linux-sctp+bounces-486-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89572A8507F
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Apr 2025 02:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2127B5644
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Apr 2025 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06C36D;
	Fri, 11 Apr 2025 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=juno-software.com header.i=@juno-software.com header.b="WU4xJfhJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IcufjYLJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from a2-11.smtp-out.eu-west-1.amazonses.com (a2-11.smtp-out.eu-west-1.amazonses.com [54.240.2.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4C2F2F
	for <linux-sctp@vger.kernel.org>; Fri, 11 Apr 2025 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.2.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744330978; cv=none; b=X+AaTNpgYArFv07yAOUCqot0mCpjkec4i8ZUtG8boPFWKfn65CtBHSqfhP6OjzHqrclm1RnahVDsyGBITFrTEIOSD+kR08j/voH3ZtVvOFdyNMvednrPlEaqO1HkU83qgrH1XEBbRHRFfe7+7NfrcmFannA5/P/0QR83PbzMOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744330978; c=relaxed/simple;
	bh=oW5FyFkET8hnD7Fdt6kSisRxcbDuSOKAfURDD5e1rwc=;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=ak4PnfwV/3NCYeKztjxKTwq8wylMyzEpuG8uT4aocxZmmSoh4qsvkgZp+w32N1B5SmWqwQn5aVRXen5X/MZUDmTVjRi5b7dB4tZnQ7vyHnYKA7SQmBEXVlS/0b0RD7qKbVYnToIuhpZeD6N3fh/9W44qRcNYP7hX0pfowiOW+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=juno-software.com; spf=pass smtp.mailfrom=eu-west-1.amazonses.com; dkim=pass (1024-bit key) header.d=juno-software.com header.i=@juno-software.com header.b=WU4xJfhJ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=IcufjYLJ; arc=none smtp.client-ip=54.240.2.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=juno-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-west-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=m5m3gt5kvbpdgqt23nyd5oszciklvtxm; d=juno-software.com;
	t=1744330971;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
	bh=oW5FyFkET8hnD7Fdt6kSisRxcbDuSOKAfURDD5e1rwc=;
	b=WU4xJfhJQ5OiiVJgYuggjaZsRumJePYwU+n0/EhSrTrbMt/crP534S+Q047CNhWT
	pretEYV7mTP0yJFdpYAUHES/y6/9zlH6gsh2Icxxc4IhG4SJ9/zC2HsoREpzabmaYrQ
	wRN0qL6lZHUBGePGug76Ry5tPkpacyfOwxnlZJqQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1744330971;
	h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
	bh=oW5FyFkET8hnD7Fdt6kSisRxcbDuSOKAfURDD5e1rwc=;
	b=IcufjYLJsmBVEsCaNVpoIkX0mcGYBmWOtW/fgQuAtbI4N9HJlZdGg4K1mufXE1nc
	G6/iGKsiL1yzu7g6uQGry2wc//hAB7bwEdzN0czliRB6RCM+Lj9g8nXBw5rlopJk+FY
	91pDdSFj8tEBTw7FC3bIHGd+rOTVJ2mwgybiGyz8=
Subject: PATCH lksctp-tools - add test case 7 that does nothing but associate
 and waits
From: =?UTF-8?Q?Warren_Crossing?= <warren.crossing@juno-software.com>
To: 
	=?UTF-8?Q?linux-sctp=40vger=2Ekernel=2Eorg?= <linux-sctp@vger.kernel.org>
Date: Fri, 11 Apr 2025 00:22:51 +0000
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="=_q36-TwEDxbd077b5i+TE-fb7Pyer6+j8G0uUCl-gbKoyKa5a"
References: <5b28d850-8d45-48ef-874b-ca67d552da12@juno-software.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHbqnfbooL5CSxoTSOE1jThnUv9sw==
Thread-Topic: PATCH lksctp-tools - add test case 7 that does nothing but
 associate and waits
X-Wm-Sent-Timestamp: 1744330970
Message-ID: <01020196223a58be-c1b6564b-c697-49ae-9835-f81ee01295bb-000000@eu-west-1.amazonses.com>
Feedback-ID: ::1.eu-west-1.b24dn6frgCi6dh20skzbuMRr7UL8M6Soir/3ogtEjHQ=:AmazonSES
X-SES-Outgoing: 2025.04.11-54.240.2.11

This is a multi-part message in MIME format. Your mail reader does not
understand MIME message format.
--=_q36-TwEDxbd077b5i+TE-fb7Pyer6+j8G0uUCl-gbKoyKa5a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

IEZyb20gYzgyN2ZhMzAyNDVkYjZjMDI5ZTMyM2IwMjM2NmZkYzRmMWI2NTkyZCBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDENCkZyb206IFdhcnJlbiBDcm9zc2luZyA8d2FycmVuLmNyb3Nz
aW5nQGp1bm8tc29mdHdhcmUuY29tPg0KRGF0ZTogRnJpLCAxMyBEZWMgMjAyNCAxNDoxMzox
MCArMTEwMA0KU3ViamVjdDogW1BBVENIIDEvMV0gYWRkIHRlc3QgY2FzZSA3IHRoYXQgZG9l
cyBub3RoaW5nIGJ1dCBhc3NvY2lhdGUgYW5kIA0Kd2FpdHMNCiDCoGZvciBoZWFydGJlYXQN
Cg0KLS0tDQogwqBzcmMvYXBwcy9zY3RwX3Rlc3QuYyB8IDI5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tDQogwqAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NyYy9hcHBzL3NjdHBfdGVzdC5jIGIvc3Jj
L2FwcHMvc2N0cF90ZXN0LmMNCmluZGV4IDUzOWEwOTguLjk1ODVhNzIgMTAwNjQ0DQotLS0g
YS9zcmMvYXBwcy9zY3RwX3Rlc3QuYw0KKysrIGIvc3JjL2FwcHMvc2N0cF90ZXN0LmMNCkBA
IC00Miw2ICs0Miw3IEBADQogwqAjaW5jbHVkZSA8Y3R5cGUuaD4NCiDCoCNpbmNsdWRlIDxz
dGRpby5oPg0KIMKgI2luY2x1ZGUgPHN0ZGxpYi5oPg0KKyNpbmNsdWRlIDxzdGRib29sLmg+
DQogwqAjaW5jbHVkZSA8dW5pc3RkLmg+DQogwqAjaW5jbHVkZSA8dGltZS5oPg0KIMKgI2lu
Y2x1ZGUgPHN5cy90eXBlcy5oPg0KQEAgLTkzLDcgKzk0LDcgQEANCiDCoCNkZWZpbmUgQVNT
T0NfUEFUVEVSTl9TRVFVRU5USUFMIDANCiDCoCNkZWZpbmUgQVNTT0NfUEFUVEVSTl9SQU5E
T03CoMKgwqDCoCAxDQoNCi0jZGVmaW5lIE5DQVNFUyA2DQorI2RlZmluZSBOQ0FTRVMgNw0K
IMKgI2RlZmluZSBNQVhfUE9MTF9TS1MgMjU2DQoNCiDCoCNkZWZpbmUgREVCVUdfUFJJTlQo
bGV2ZWwsIHByaW50X3RoaXMuLi4pwqDCoMKgIFwNCkBAIC0xNzEsNiArMTcyLDcgQEAgaW50
IGJpbmR4X2FkZF9jb3VudCA9IDA7DQogwqBzdHJ1Y3Qgc29ja2FkZHIgKmNvbm5lY3R4X2Fk
ZHJzID0gTlVMTDsNCiDCoGludCBjb25uZWN0eF9jb3VudCA9IDA7DQogwqBpbnQgaWZfaW5k
ZXggPSAwOw0KK2Jvb2wgZmlyc3QgPSB0cnVlOw0KDQogwqB1bnNpZ25lZCBjaGFyIG1zZ1td
ID0gDQoiMDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3
ODkwIjsNCg0KQEAgLTE4MSw2ICsxODMsNyBAQCBzdGF0aWMgaW50IG1zZ19zaXplc1tOQ0FT
RVNdW01TR19DTlRdID0NCiDCoMKgwqDCoMKgIHsxLCAxNDUzLCAzMjc2OCwgMSwgMTQ1Mywg
MzI3NjgsIDEsIDE0NTMsIDMyNzY4LCAxfSwNCiDCoMKgwqDCoMKgIHsxLCAxMDAwLCAyMDAw
LCAzMDAwLCA1MDAwLCAxMDAwMCwgMTUwMDAsIDIwMDAwLCAyNTAwMCwgMzI3Njh9LA0KIMKg
wqDCoMKgwqAgezMyNzY4LCAzMjc2OCwgMzI3NjgsIDMyNzY4LCAzMjc2OCwgMzI3NjgsIDMy
NzY4LCAzMjc2OCwgMzI3NjgsIA0KMzI3Njh9LA0KK8KgwqDCoMKgIHswLDAsMCwwLDAsMCww
LDAsMCwwfSwNCiDCoMKgwqDCoCB9Ow0KDQogwqBzdGF0aWMgY29uc3QgY2hhciAqc2FjX3N0
YXRlX3RibFtdID0gew0KQEAgLTIzNCw3ICsyMzcsOCBAQCB2b2lkIHVzYWdlKGNoYXIgKmFy
Z3YwKQ0KIMKgwqDCoMKgIGZwcmludGYoc3RkZXJyLCAiXHTCoMKgIDUgPSAzMjc2OCBieXRl
IHBhY2tldHMuXG4iKTsNCiDCoMKgwqDCoCBmcHJpbnRmKHN0ZGVyciwgIlx0wqDCoMKgwqDC
oMKgIChkZWZhdWx0IG1heCByZWNlaXZlIHdpbmRvdyBzaXplLilcbiIpOw0KIMKgwqDCoMKg
IGZwcmludGYoc3RkZXJyLCAiXHTCoMKgIDYgPSByYW5kb20gc2l6ZSBwYWNrZXRzLlxuIik7
DQotwqDCoMKgIGZwcmludGYoc3RkZXJyLCAiXHTCoMKgIC12ZSB2YWx1ZSA9IFBhY2tldHMg
b2Ygc3BlY2lmZWQgc2l6ZS5cbiIpOw0KK8KgwqDCoCBmcHJpbnRmKHN0ZGVyciwgIlx0wqDC
oCA3ID0gZG9uJ3Qgc2VuZCBhbnkgcGFja2V0cywganVzdCB3YWl0IGZvciANCmhlYXJ0YmVh
dC5cbiIpOw0KK8KgwqDCoCBmcHJpbnRmKHN0ZGVyciwgIlx0wqDCoCAtdmUgdmFsdWUgPSBQ
YWNrZXRzIG9mIHNwZWNpZmVkIHNpemUuIChmb3IgDQpleGFtcGxlIC1jIC05OTk5KVxuIik7
DQogwqDCoMKgwqAgZnByaW50ZihzdGRlcnIsICJcdC1tIG1heCBtc2dzaXplIGZvciBvcHRp
b24gLWMgNiAoMTUwMC02NTUxNSwgDQpkZWZhdWx0IHZhbHVlIDMyNzY4KVxuIik7DQogwqDC
oMKgwqAgZnByaW50ZihzdGRlcnIsICJcdC14IG51bWJlciBvZiByZXBlYXRzXG4iKTsNCiDC
oMKgwqDCoCBmcHJpbnRmKHN0ZGVyciwgIlx0LW8gb3JkZXItcGF0dGVyblxuIik7DQpAQCAt
OTMyLDYgKzkzNiwxMiBAQCBpbnQgbmV4dF9tc2dfc2l6ZShpbnQgbXNnX2NudCkNCg0KIMKg
wqDCoMKgIGlmIChzaXplX2FyZykgew0KIMKgwqDCoMKgwqDCoMKgwqAgbXNnX3NpemUgPSBz
aXplX2FyZzsNCivCoMKgwqAgfSBlbHNlIGlmICh0ZXN0X2Nhc2UgPT0gNykgew0KK8KgwqDC
oMKgwqDCoMKgIGlmIChmaXJzdCkgew0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmlyc3Qg
PSBmYWxzZTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zZ19zaXplID0gMTsNCivCoMKg
wqDCoMKgwqDCoCB9IGVsc2UNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zZ19zaXplID0g
MDsNCiDCoMKgwqDCoCB9IGVsc2UgaWYgKHRlc3RfY2FzZSA8IE5DQVNFUykgew0KIMKgwqDC
oMKgwqDCoMKgwqAgbXNnX3NpemUgPSBtc2dfc2l6ZXNbdGVzdF9jYXNlXVttc2dfY250XTsN
CiDCoMKgwqDCoCB9IGVsc2Ugew0KQEAgLTExMDYsOSArMTExNiwxNSBAQCBjbGllbnQoaW50
IHNrKQ0KIMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBtc2dfY250OyBpKyspIHsNCg0KIMKg
wqDCoMKgwqDCoMKgwqAgbXNnX3NpemUgPSBuZXh0X21zZ19zaXplKGkpOw0KKw0KK8KgwqDC
oMKgwqDCoMKgIGlmIChtc2dfc2l6ZSA9PSAwKSB7DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmcHJpbnRmKHN0ZG91dCwgIlNsZWVwaW5nIDEgc2Vjb25kIG9uIHplcm8gc2l6ZSBtZXNz
YWdlXG4iKTsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNsZWVwKDEpOw0KK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29udGludWU7DQorwqDCoMKgwqDCoMKgwqAgfQ0KKw0KIMKgwqDC
oMKgwqDCoMKgwqAgb3JkZXJfc3RhdGUgPSBuZXh0X29yZGVyKG9yZGVyX3N0YXRlLCBvcmRl
cl9wYXR0ZXJuKTsNCiDCoMKgwqDCoMKgwqDCoMKgIHN0cmVhbV9zdGF0ZSA9IG5leHRfc3Ry
ZWFtKHN0cmVhbV9zdGF0ZSwgc3RyZWFtX3BhdHRlcm4pOw0KLQ0KIMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHNlbmRfcihzaywgc3RyZWFtX3N0YXRlLCBvcmRlcl9zdGF0ZSwgbXNnX3NpemUs
IDApIDwgMCkNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQogwqDCoMKgwqDC
oMKgwqDCoCAvKiBUaGUgc2VuZGVyIGlzIGVjaG9pbmcgc28gZG8gZGlzY2FyZCB0aGUgZWNo
b2VkIGRhdGEuICovDQpAQCAtMTI4Myw2ICsxMjk5LDEzIEBAIG1peGVkX21vZGVfdGVzdCh2
b2lkKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5fb3JkZXIgPSBhc1th
c3NvY19pXS5vcmRlcl9zdGF0ZSA9DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBuZXh0X29yZGVyKGFzW2Fzc29jX2ldLm9yZGVyX3N0YXRlLA0KIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3JkZXJfcGF0dGVybik7DQor
DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChuX21zZ19zaXplID09IDAp
IHsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcHJpbnRmKHN0
ZG91dCwgIlNsZWVwaW5nIG9uIHplcm8gc2l6ZSBtZXNzYWdlXG4iKTsNCivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbGVlcCgxKTsNCivCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCivCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQ0KKw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG5fc3RyZWFtID0gYXNbYXNzb2NfaV0uc3RyZWFtX3N0YXRlID0NCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5leHRfc3RyZWFtKGFzW2Fzc29jX2ldLnN0
cmVhbV9zdGF0ZSwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cmVhbV9wYXR0ZXJuKTsNCi0tIA0KMi40Ny4yDQoNCg0K
--=_q36-TwEDxbd077b5i+TE-fb7Pyer6+j8G0uUCl-gbKoyKa5a
Content-Type: application/pgp-keys; 
 name=OpenPGP_0x2AFC3C937048838F.asc
Content-Transfer-Encoding: base64
Content-Disposition: attachment; 
 filename=OpenPGP_0x2AFC3C937048838F.asc

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQoNCnhzRE5CR00weVlNQkRB
RFlOUTVmRmVxSEI3dVhrOVR3cCs1YTV3TlphcTRXSjI1NjJqbUFCMlBQUHhneS9qSGoNCkVP
REVKYW5NODM3TkQ1ZklNdmdTRW9ZVFdzUWkyVlp2V2h6b0Q0aWRqTVJOaWFGYk1ZTUJ4cGVx
UGNBTmZ1TDANCmhvbkdvMEFXWUVMOStUcjViOERyV2F0M2tCOUtUU0x3MW4xeDVXZ0NxYmc3
VUNVazhMWlBscnRzZXNXd0hzL2oNClhxMXZOOWdGR1RReUswdlpPZTFlR3h4TnNib2NNbHZn
Z0xwR011U0RtUlJWc3NKOUQzZjRJdHdqK2llVDRhUXkNCmZoWUhLcWw5ZWNMNk1xa2xWTXE3
cVFVZWdIMDg4cEpoQVl5Znl3V3ZRVEJicCt4eXVmMDV1ejhqRmNnYmFTRlkNCnRvZWJxU1lO
KzdQWGx0VHAzMkpGM2FVamZ4Zk9tOW1aS2xUNkc1dTNPNEZLL29COS9Hc2VuWFpGTmhuamlW
Q1oNCkVDYmVXR2VsM29TcWZjRlRUUGlRVk0rLzNaRU4rK3E2TmpsUFhEb2thTmREOS9sNWhE
eTZqRFovSGhUalgveTANCmkzVy9BY2tMelpvT2JUd0dSYWFET2M0dU52Zkk3UVd6T29XTFo1
U2dVQ1RnVUVMK2RUZGYxSWJveEs5d3pJc2QNClVxOVdRU2QxbjcxYWQ0Y0FFUUVBQWMwelYy
RnljbVZ1SUVOeWIzTnphVzVuSUR4M1lYSnlaVzR1WTNKdmMzTnANCmJtZEFhblZ1YnkxemIy
WjBkMkZ5WlM1amIyMCt3c0VOQkJNQkNBQTNGaUVFYnpLSTlWUXhmZW5rOVJZT0t2dzgNCmsz
QklnNDhGQW1NMHlZTUZDUVdqbW9BQ0d3TUVDd2tJQndVVkNBa0tDd1VXQWdNQkFBQUtDUkFx
L0R5VGNFaUQNCmorakJEQUREdDZuOHNBbDBJS2RLT1duUEFxS1V3K2lRRjZkU0NyR1Iyb2x1
M1FDaG5DYkM2SXJydlhPeWE3emINCkljVk50N05jTXhVRHhHWWFCSXdZN2VDMC93ZnAyZXV4
T3U0Z2lkUXV6SEJ0UVgrRHVMa1JXRmk4Um5uVVlvaWwNClRiYkxMdS9NQ0JaaDNOdEtxbStJ
ZlZPSGc2ZzMvRFJ4aDlST2ZhTXB0bWJPczR5dnVVV1JKSXFpS1l1SlA1VVYNCnYxY2s2QVlM
Q0p2d3Exdy83elUwcnlpeUhSZW9qaHdXVHhYV0ZVU3ZWM2d4ZkxxLzNSVTBqUGovMVUyTzEw
RmINCldncUdTVjY3bk96RTV3anFUbHJxM2xPS0I1eXkzVlVVd2lKYnNZSUZKdS9MZGM5TVpz
NlJYLzlSV3BvNGdCK2oNCjZBSFdibXNVZWdxcHFScWE5Qmh0ak9PQ1phZVltQW9hZndENkVO
RUh1L2JEZUc2MjhoV1E2cDAvV3BOWUprajINCjA1V1E2MDZEVE41NEszNTZCR21kNk9VSVMr
K3RWUkRXMFBaOTRwWjl5ZnVMV3Uwc0c2ZWJyVlhaL2dSMjdmY2wNCm14djJiYWhRRUtsWk9n
U1lIV3JiNitoZktjVmdFNUZKU1VobElZalpiMGFyOHJpMWtHQ3RqMjUwYUZocUZ4MGYNClcx
c1pNMG5Pd00wRVl6VEpoQUVNQUx6QlZ2Q2ZuR0RzUWVIQ0cxUUpKTDYrNStOa3ZBSXdYQlNJ
bURMVkt3Qm8NCmR1QTgwS0dUZTRNZzBlVXlsaGltOW5rY2Frazg4cVltYXNnRHdzcXNrS05N
ZHJlKzVkODRrWnd0RENqZ3pJQnANCjQ1SWhpSTRPS2RiNkVvUWx0YTJIelZFYUFaajk1OFpQ
TVRVditFYnh4OUludy9CSmFPTk1rWTdTbm9FbjUxOXUNCkswbHQ0aTJSRDJtWWRpYXJBYlVr
b3lIajhPbDIrU3RSRU9BQTZoWkRmRE9lUzU5bVZCdzM1bnM0NlhkUC9kL2ENCklVVXJyakxC
SkI5eHYrVHBlcXNORkw4Y1hmT1RrNzg4TXFWckZTRUtvUS91cGNQS2plc2Y3WlFSbHVhNldW
U2INCitEV0Y2c0ZhdWhxb3M3SGFjOWxSbHJJUHJENVZuNEQ4NzMzdFAzMW15T3V2UXNDbUxz
STlTc1dTczduNEF5RUINCkRKTzZuZndXTFQ1eWc0SUZJTE1tWlhLdHZscXFLSUxTYkwrTHhP
Kzd5MThxU2x6MGRqcHp2Mk9oL3pMYkNPZFkNCjh4VGRVWWlNZkcrT3B6WkM3YTZkRmEzb3dG
RlA5aGZtY01Ia2U2bEN1YUQzeEJOUWhSVDNya2hmbjRwbnhuSDANCnh5aDdzR1NaSjgrQ0ZP
cVVPNHRDTHdBUkFRQUJ3c0Q4QkJnQkNBQW1GaUVFYnpLSTlWUXhmZW5rOVJZT0t2dzgNCmsz
QklnNDhGQW1NMHlZUUZDUVdqbW9BQ0d3d0FDZ2tRS3Z3OGszQklnNDlwMkF3QXdvMTJOL3hy
WXVzb2tkT3MNCklSa0I4Sk16OW5UdVV0VWxIcDRYVHdzcjVpRmJoZXRnZ0xIdG1keTJHWjNm
RDU5QWxTTkMrd05DclhCc3N5Nm4NCjV4Uiswc1RKdENHc2lBcERaUU4yV21hTWx4U0d4SEhG
QVhwU0ovdWY2UzZQOFU1a1I3NXNGNlo2S0drZlZUMkUNCjVUM1N1akdna2ExVnk5Zm94bC9u
dzZTVmZnK0d2K1lpdlVHWEdGbUVBUjE4WjVxTmMzN3lPSE1pRkYyTkhqdEENClhTT1ZXRWp4
RGJ5cVdHOE9ObjR2N05RbXVvZzNxNlJOMDVWUWpMVWVpYU9NNTRZZ0FCQTFVbkhIdVU5YmxG
ODYNCnR3TzRBZzFpOTRHc2FSa1ZaNDlvWHJlNVFMek5wdnhPR29lUFdTLzlaOFJxMzVVRnFm
bS93elB2bFFkNEJiR2INCk54NlRheUV4TllBeXBBSVRWc0ZnMXRFaEkveUZvTkdhMTZDMVM2
SXhrRTVIcUdsaTcyZ3plblZzSFlRejNCZzENClN1ZFFnQkRRdzkxU3Jhc0NjRlY4R0t1VEVv
azJXSUllZ0pOSHM0U0h5L2o5WUZ4U2g2eks3YnpoQkR3NUh3c2kNCk5sZzhpcHprMHJTT2lr
ZGQrNVordU1HbEwwaGd4eU9uVm4zem1ybzVFelVqOFpRMA0KPWlZdWENCi0tLS0tRU5EIFBH
UCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg==
--=_q36-TwEDxbd077b5i+TE-fb7Pyer6+j8G0uUCl-gbKoyKa5a
Content-Type: application/pgp-signature; name=OpenPGP_signature.asc
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=OpenPGP_signature.asc

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0Kd3NENUJBQUJDQUFqRmlFRWJ6S0k5
VlF4ZmVuazlSWU9Ldnc4azNCSWc0OEZBbWY0WU5ZRkF3QUFBQUFBQ2drUUt2dzhrM0JJZzQ5
OA0KN0F2OUZrT3dySHBMMytGanZaMEdjMzl1b0NCUWF1dmlCMmp5d2hBcDVpcGFqSHd3eTUr
bDJjR3pFbXE0bVM0WngxZkMyaE0rdVlOTw0KMEJ5NGpwRWVIaGhnb1ljYUJ4Tlh3amdWSDdU
eGtaSUF3ZS9LYllKWnJEVkkyVUEzenNybGVab2UzazJ5S0RUVXJLWTJCTnZpV2czSg0KeUVx
dWFZM0owL3N1cjNWU2FSL0hhdm4xaUhIUDZvUUh5dzFjS1RFeWtieTFISGR3UW9SOXdPY04v
OUwxQ203eXpkWHpRT2NFK0RvOA0KZllHWlV4MGtHV3dHWkhvUFQ0L1VkKzBmWGVNMVM3L0E0
TUorSXRFbXcwSktnTmxITzVhSUZ6d3BWU0dGcXdieUgyVVk4MnVjajdwaQ0KWCtGYU92b0hz
Y2RmZkRlMzhaL0Q3bE5ycElHTWtQSTI4NlFZamhnSGVORWxpZWh5VVF3S211VDJSMy9mQ0RG
NXF1b085NG81dmZoRg0KbTBJblBPYmJEYVRYWkNvb2hjWHJNcm9VYVN5YmRSbVRnb0VwNE1w
azV1VGtGb2lXV0p3ZXIrcFVHNjBGSGl4ZHNXZFNNLzZWY3I0dw0KcWJmQTR6M2RCbzBUZnlp
QUN0S3A3aEF1MXhsV09ybHBVWnhrOWFUdW9KNlFwTmtJNnA3dUc2Z2RKbUo2DQo9UDlzKw0K
LS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=
--=_q36-TwEDxbd077b5i+TE-fb7Pyer6+j8G0uUCl-gbKoyKa5a--

