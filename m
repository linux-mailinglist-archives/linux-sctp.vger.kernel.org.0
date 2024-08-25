Return-Path: <linux-sctp+bounces-214-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4495E28C
	for <lists+linux-sctp@lfdr.de>; Sun, 25 Aug 2024 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A682825C2
	for <lists+linux-sctp@lfdr.de>; Sun, 25 Aug 2024 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A15FBBA;
	Sun, 25 Aug 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="VZ+kPanN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054A2BB1C
	for <linux-sctp@vger.kernel.org>; Sun, 25 Aug 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724572762; cv=none; b=h98YQoLR3gJzwmfTsOs4FAkfySYXhcH3inKzJ4f4nKDIkTwL6R3/jP4FNB4ITVALOLi2FJeQBA8aR1DE6qzKbEPzrVV+sG0Ms1IyeRuBQII1/IRxjZJPohEZW3Zc4mXwoaLwhe1KJw207paScxYoUk1OWDFIIXfJwyd1a5YCj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724572762; c=relaxed/simple;
	bh=b5jvJK0AMaVKVjEU/QSxJuyWABdVPFGVB1lHl/yigV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejcvI3bkLvA1cLQERvc+NfRUorQP8MAiww2uumbe4vT7gjnqnnmfy+ybIwk3zMU75HPgY7ymTpSPZrpQW6r7noT3eKUY0WBazpN02CSgcp/4HcmDL6Q7ph9XH225vYeToqpWodlbw15mG8K8bwXawIrmmhUQovAsredIPSGjh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=VZ+kPanN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 90217240027
	for <linux-sctp@vger.kernel.org>; Sun, 25 Aug 2024 09:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1724572369; bh=b5jvJK0AMaVKVjEU/QSxJuyWABdVPFGVB1lHl/yigV0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=VZ+kPanN7i1IVpKTmSytJjgcWyh6zlBoxmSPhNZGBe87ghKuoFcmioVJTISfPamsY
	 uRxowBbAlhYHLPdfU3MvbzBvtRq/4bM8EUGoyg86jj8LwXlkkDiY9AlqwUMug44Sr0
	 urSKW6aKToSStWJiDcybgWruD6cRfenfq+Y1aH1srCfTZmhKXjkYAeo3mtHi1GOIZD
	 nNRN5ckkNvyW0+3yGXMq7Brh25gzAsrvZc2gMgjizB3jOnfmR+Bzot/EdXw8eVROF6
	 E/zZ8DIuf12y8wMArEqZ+RVAVg9uqBBhBwN9HWNkGcxirL8NU1EbVdN9DRuLS1GmWa
	 yeOrpOx3C2U4Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Ws5dB1bS3z6txy;
	Sun, 25 Aug 2024 09:52:46 +0200 (CEST)
Message-ID: <d15e45f17dcb9c98664590711ac874302a7e6689.camel@posteo.de>
Subject: Re: [PATCH net-next 00/13] net: header and core spelling corrections
From: Philipp Stanner <stanner@posteo.de>
To: Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,  Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern
 <dsahern@kernel.org>,  Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Subash Abhinov Kasiviswanathan
 <quic_subashab@quicinc.com>, Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Martin
 Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-x25@vger.kernel.org
Date: Sun, 25 Aug 2024 07:52:45 +0000
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QW0gRG9ubmVyc3RhZywgZGVtIDIyLjA4LjIwMjQgdW0gMTM6NTcgKzAxMDAgc2NocmllYiBTaW1v
biBIb3JtYW46Cj4gVGhpcyBwYXRjaHNldCBhZGRyZXNzZXMgYSBudW1iZXIgb2Ygc3BlbGxpbmcg
ZXJyb3JzIGluIGNvbW1lbnRzIGluCj4gTmV0d29ya2luZyBmaWxlcyB1bmRlciBpbmNsdWRlLywg
YW5kIGZpbGVzIGluIG5ldC9jb3JlLy4gU3BlbGxpbmcKPiBwcm9ibGVtcyBhcmUgYXMgZmxhZ2dl
ZCBieSBjb2Rlc3BlbGwuCj4gCj4gSXQgYWltcyB0byBwcm92aWRlIHBhdGNoZXMgdGhhdCBjYW4g
YmUgYWNjZXB0ZWQgZGlyZWN0bHkgaW50byBuZXQtCj4gbmV4dC4KPiBBbmQgc3BsaXRzIHBhdGNo
ZXMgdXAgYmFzZWQgb24gbWFpbnRhaW5lciBib3VuZGFyaWVzOiBtYW55IHRoaW5ncwo+IGZlZWQg
ZGlyZWN0bHkgaW50byBuZXQtbmV4dC4gVGhpcyBpcyBhIGNvbXBsZXggcHJvY2VzcyBhbmQgSQo+
IGFwb2xvZ2lzZQo+IGZvciBhbnkgZXJyb3JzLgoKQXJlIHlvdSBhd2FyZSB0aGF0IHRoaXMgbGVz
c2VucyBnaXQgYmxhbWUncyBhYmlsaXR5IHRvIHByb3ZpZGUgdGhlCmxhdGVzdCByZWxldmFudCBj
aGFuZ2UgYW5kIGFzc29jaWF0ZWQgY29tbWl0IG1lc3NhZ2U/CgpNYW55IHNvZnR3YXJlIHByb2pl
Y3RzIHN1ZmZlciBmcm9tIHdoaXRlc3BhY2UgYW5kIHNwZWxsaW5nIGZpeGVzCnByZXZlbnRpbmcg
Z2l0IGJsYW1lIGZyb20gZmlndXJpbmcgb3V0IHllYXJzIGxhdGVyIHdoYXQgb3JpZ2luYWwgY29k
ZQp3YXMgaW50ZW5kZWQgdG8gZG8uCgpJJ2QgY29uc2lkZXIgdGhhdCBpbXByb3Zpbmcgc3BlbGxp
bmcgbWlnaHQgbm90IHdpbiB0aGF0IGNvc3QtYmVuZWZpdC0KcmF0aW8uCgoKUmVnYXJkcywKUC4K
Cgo+IAo+IEkgYWxzbyBwbGFuIHRvIGFkZHJlc3MsIHZpYSBzZXBhcmF0ZSBwYXRjaGVzLCBzcGVs
bGluZyBlcnJvcnMgaW4KPiBvdGhlcgo+IGZpbGVzIGluIHRoZSBzYW1lIGRpcmVjdG9yaWVzLCBm
b3IgZmlsZXMgd2hvc2UgY2hhbmdlcyB0eXBpY2FsbHkgZ28KPiB0aHJvdWdoIHRyZWVzIG90aGVy
IHRoYW4gbmV0LW5leHQgKHdoaWNoIGZlZWQgaW50byBuZXQtbmV4dCkuCj4gCj4gLS0tCj4gU2lt
b24gSG9ybWFuICgxMyk6Cj4gwqDCoMKgwqDCoCBwYWNrZXQ6IENvcnJlY3Qgc3BlbGxpbmcgaW4g
aWZfcGFja2V0LmgKPiDCoMKgwqDCoMKgIHMzOTAvaXVjdjogQ29ycmVjdCBzcGVsbGluZyBpbiBp
dWN2LmgKPiDCoMKgwqDCoMKgIGlwX3R1bm5lbDogQ29ycmVjdCBzcGVsbGluZyBpbiBpcF90dW5u
ZWxzLmgKPiDCoMKgwqDCoMKgIGlwdjY6IENvcnJlY3Qgc3BlbGxpbmcgaW4gaXB2Ni5oCj4gwqDC
oMKgwqDCoCBib25kaW5nOiBDb3JyZWN0IHNwZWxsaW5nIGluIGhlYWRlcnMKPiDCoMKgwqDCoMKg
IG5ldDogcXVhbGNvbW06IHJtbmV0OiBDb3JyZWN0IHNwZWxsaW5nIGluIGlmX3JtbmV0LmgKPiDC
oMKgwqDCoMKgIG5ldGxhYmVsOiBDb3JyZWN0IHNwZWxsaW5nIGluIG5ldGxhYmVsLmgKPiDCoMKg
wqDCoMKgIE5GQzogQ29ycmVjdCBzcGVsbGluZyBpbiBoZWFkZXJzCj4gwqDCoMKgwqDCoCBuZXQ6
IHNjaGVkOiBDb3JyZWN0IHNwZWxsaW5nIGluIGhlYWRlcnMKPiDCoMKgwqDCoMKgIHNjdHA6IENv
cnJlY3Qgc3BlbGxpbmcgaW4gaGVhZGVycwo+IMKgwqDCoMKgwqAgeDI1OiBDb3JyZWN0IHNwZWxs
aW5nIGluIHgyNS5oCj4gwqDCoMKgwqDCoCBuZXQ6IENvcnJlY3Qgc3BlbGxpbmcgaW4gaGVhZGVy
cwo+IMKgwqDCoMKgwqAgbmV0OiBDb3JyZWN0IHNwZWxsaW5nIGluIG5ldC9jb3JlCj4gCj4gwqBp
bmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNlLmjCoMKgwqAgfMKgIDIgKy0KPiDCoGluY2x1ZGUvbGlu
dXgvaWZfcm1uZXQuaMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9saW51eC9uZXRk
ZXZpY2UuaMKgwqDCoMKgwqAgfMKgIDggKysrKy0tLS0KPiDCoGluY2x1ZGUvbmV0L2FkZHJjb25m
LmjCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBpbmNsdWRlL25ldC9ib25kXzNhZC5owqDC
oMKgwqDCoMKgwqDCoCB8wqAgNSArKysrLQo+IMKgaW5jbHVkZS9uZXQvYm9uZF9hbGIuaMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDIgKy0KPiDCoGluY2x1ZGUvbmV0L2J1c3lfcG9sbC5owqDCoMKgwqDC
oMKgwqAgfMKgIDIgKy0KPiDCoGluY2x1ZGUvbmV0L2NhaWYvY2FpZl9sYXllci5owqAgfMKgIDQg
KystLQo+IMKgaW5jbHVkZS9uZXQvY2FpZi9jZnBrdC5owqDCoMKgwqDCoMKgIHzCoCAyICstCj4g
wqBpbmNsdWRlL25ldC9kcm9wcmVhc29uLWNvcmUuaMKgIHzCoCA2ICsrKy0tLQo+IMKgaW5jbHVk
ZS9uZXQvZHN0LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVk
ZS9uZXQvZHN0X2NhY2hlLmjCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQv
ZXJzcGFuLmjCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKy0tCj4gwqBpbmNsdWRlL25ldC9o
d2JtLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKystLQo+IMKgaW5jbHVkZS9uZXQv
aXBfdHVubmVscy5owqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBpbmNsdWRlL25ldC9pcHY2LmjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKystLQo+IMKgaW5jbHVkZS9uZXQvaXVjdi9p
dWN2LmjCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQvbGxjX3BkdS5owqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBpbmNsdWRlL25ldC9uZXRsYWJlbC5owqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQvbmV0bGluay5owqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTYgKysrKysrKystLS0tLS0tLQo+IMKgaW5jbHVkZS9uZXQvbmV0bnMvc2N0cC5o
wqDCoMKgwqDCoMKgIHzCoCA0ICsrLS0KPiDCoGluY2x1ZGUvbmV0L25mYy9uY2kuaMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQvbmZjL25mYy5owqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA4ICsrKystLS0tCj4gwqBpbmNsdWRlL25ldC9wa3RfY2xzLmjCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDIgKy0KPiDCoGluY2x1ZGUvbmV0L3JlZC5owqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDggKysrKy0tLS0KPiDCoGluY2x1ZGUvbmV0L3JlZ3VsYXRvcnkuaMKgwqDC
oMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQvc2N0cC9zY3RwLmjCoMKgwqDCoMKgwqDC
oCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQvc2N0cC9zdHJ1Y3RzLmjCoMKgwqDCoCB8IDIwICsr
KysrKysrKystLS0tLS0tLS0tCj4gwqBpbmNsdWRlL25ldC9zb2NrLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDQgKystLQo+IMKgaW5jbHVkZS9uZXQvdWRwLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS9uZXQveDI1LmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaW5jbHVkZS91YXBpL2xpbnV4L2lmX3BhY2tldC5oIHzC
oCA3ICsrKystLS0KPiDCoGluY2x1ZGUvdWFwaS9saW51eC9pbi5owqDCoMKgwqDCoMKgwqAgfMKg
IDIgKy0KPiDCoGluY2x1ZGUvdWFwaS9saW51eC9pbmV0X2RpYWcuaCB8wqAgMiArLQo+IMKgbmV0
L2NvcmUvZGV2LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKystLS0K
PiDCoG5ldC9jb3JlL2Rldl9hZGRyX2xpc3RzLmPCoMKgwqDCoMKgIHzCoCA2ICsrKy0tLQo+IMKg
bmV0L2NvcmUvZmliX3J1bGVzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgbmV0
L2NvcmUvZ3JvLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKg
bmV0L2NvcmUvbmV0cG9sbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gwqBu
ZXQvY29yZS9wa3RnZW4uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKystLS0t
LQo+IMKgbmV0L2NvcmUvc2tidWZmLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCAr
Ky0tCj4gwqBuZXQvY29yZS9zb2NrLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDYgKysrLS0tCj4gwqBuZXQvY29yZS91dGlscy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMiArLQo+IMKgNDMgZmlsZXMgY2hhbmdlZCwgOTMgaW5zZXJ0aW9ucygrKSwgODkgZGVs
ZXRpb25zKC0pCj4gCj4gYmFzZS1jb21taXQ6IDAwMWI5OGM5ODk3MzUyZTkxNGM3MWQ4ZmZiZmE5
Yjc5YTZlMTJjM2MKPiAKPiAKCg==


