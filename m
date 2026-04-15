Return-Path: <linux-sctp+bounces-1182-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAG8Df4F32lLNwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1182-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2026 05:29:02 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C03FFFDD
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2026 05:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31F4930093BE
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2026 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4D3148DD;
	Wed, 15 Apr 2026 03:28:55 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10267318EFF;
	Wed, 15 Apr 2026 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223735; cv=none; b=FZ0/9oClLTA6znDtmTtoSVeVKr2x6FftgWeZkOwjdMK9RmYxMLMUv7nJM2q9h2t5ga6uMwcq8hiHpblI6T2diyNq0PPlFUSj6Ol7Xqbr+omMVo2sNCQDhwCFEqycuH4e6GjdRahfBnjnLOkwlirZA/6oZx5TWFZ5t2PdPUe6MUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223735; c=relaxed/simple;
	bh=Lkg27d0pkfehN8pjz/Fvz2RN9N5b739erfbrV5qI3So=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=FKxVPNikjdroS1J5CCDUPgphGiVPfeZI6vR0jCdn/Q4xc5GKUCAMtAsLclzMUGsFHiyEVJ+OIUtJji41Q9ONU3JjdgGsjOlBldnQTUwiKGpeU5O1JXT2Pm3f5UBUJBmrmnPfJxLS4E/Va9zMPuPu25W8fjvRMGCmqOduxNVkIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from xudongjie25$mails.ucas.ac.cn ( [111.199.66.103] ) by
 ajax-webmail-APP-12 (Coremail) ; Wed, 15 Apr 2026 11:22:18 +0800
 (GMT+08:00)
Date: Wed, 15 Apr 2026 11:22:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6K645Lic5rSB?= <xudongjie25@mails.ucas.ac.cn>
To: marcelo.leitner@gmail.com, lucien.xin@gmail.com
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	zhaoruilin22@mails.ucas.ac.cn
Subject: [BUG] KASAN: slab-use-after-free in sctp_addto_chunk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7e897c44.4cb35.19d8f29411c.Coremail.xudongjie25@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tgCowADH0dFrBN9psSoeAA--.42518W
X-CM-SenderInfo: p0xg00pjmlvj2v6ptx1ovo3u1dvotugofq/1tbiBwoSB2ne2qmaAw
	AAsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWkCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ucas.ac.cn];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1182-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xudongjie25@mails.ucas.ac.cn,linux-sctp@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mails.ucas.ac.cn:mid]
X-Rspamd-Queue-Id: 357C03FFFDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksCgpXaGlsZSBydW5uaW5nIGZ1enppbmcgdGVzdHMgb24gNi4xOS4wLXJjNSwgd2UgaGl0IGEg
c2xhYi11c2UtYWZ0ZXItZnJlZSBpbiB0aGUgU0NUUCBtb2R1bGUuIFRoZSBjcmFzaCBvY2N1cnMg
aW4gc2tiX3B1dF9kYXRhKCkgd2hlbiBwcm9jZXNzaW5nIGFuIGluY29taW5nIGNodW5rIGFuZCBh
cHBlbmRpbmcgZGF0YSB2aWEgc2N0cF9hZGR0b19jaHVuaygpLgoKTG9va2luZyBhdCB0aGUgdHJh
Y2UgYW5kIHRoZSBjb2RlLCBpdCBzZWVtcyB0byBiZSBhbiBza2IgcmVhbGxvY2F0aW9uIGlzc3Vl
LiBJbiBzY3RwX3NmX2JlYXRfOF8zKCksIGEgcG9pbnRlciB0byB0aGUgcGF5bG9hZCBpcyBleHRy
YWN0ZWQgZnJvbSB0aGUgaW5jb21pbmcgY2h1bmsncyBza2IuIExhdGVyLCBhIHB1bGwgb3BlcmF0
aW9uIChlLmcuLCBwc2tiX3B1bGwpIG1pZ2h0IHRyaWdnZXIgcHNrYl9leHBhbmRfaGVhZCgpLCB3
aGljaCBmcmVlcyB0aGUgb3JpZ2luYWwgc2tiLT5oZWFkIGFuZCByZWFsbG9jYXRlcyBhIGxhcmdl
ciBvbmUuIEhvd2V2ZXIsIHRoZSBwcmV2aW91c2x5IGV4dHJhY3RlZCBwYXlsb2FkIHBvaW50ZXIg
YmVjb21lcyBkYW5nbGluZyBidXQgaXMgc3RpbGwgcGFzc2VkIGRvd24gdG8gc2N0cF9tYWtlX2hl
YXJ0YmVhdF9hY2soKSwgZXZlbnR1YWxseSBiZWluZyByZWFkIGJ5IG1lbWNweSgpIGluIHNrYl9w
dXRfZGF0YSgpLgoKSXQgc2VlbXMgd2UgbmVlZCB0byBlaXRoZXIgZW5zdXJlIHB1bGwgb3BlcmF0
aW9ucyBhcmUgY29tcGxldGVkIGJlZm9yZSB0YWtpbmcgdGhlIHBheWxvYWQgcG9pbnRlciwgb3Ig
cmVjYWxjdWxhdGUgdGhlIHBvaW50ZXIgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHB1bGwuCgpXZSBo
YXZlbid0IHByZXBhcmVkIGEgcGF0Y2ggZm9yIHRoaXMgeWV0LCBidXQgd2UgYXJlIGdsYWQgdG8g
aGVscCB0ZXN0IGFueSBwcm9wb3NlZCBmaXhlcy4KCkNyYXNoIGxvZywgY2FsbCB0cmFjZSwgYW5k
IG1hY2hpbmUgaW5mbyBhcmUgYXMgZm9sbG93czoKCltNYWNoaW5lIEluZm9dClFFTVUgZW11bGF0
b3IgdmVyc2lvbiA2LjIuMApDUFU6IEludGVsKFIpIFhlb24oUikgR29sZCA1MjE4IENQVSBAIDIu
MzBHSHogKDQgY29yZXMpCktlcm5lbCBWZXJzaW9uOiA2LjE5LjAtcmM1LTAwMDQyLWc5NDRhYWNi
NjhiYWYKCltDcmFzaCBSZXBvcnQgJiBDYWxsIFRyYWNlXQpCVUc6IEtBU0FOOiBzbGFiLXVzZS1h
ZnRlci1mcmVlIGluIHNrYl9wdXRfZGF0YSBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oOjI4MDAgW2lu
bGluZV0KQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbiBzY3RwX2FkZHRvX2NodW5r
KzB4ZmEvMHgyYTAgbmV0L3NjdHAvc21fbWFrZV9jaHVuay5jOjE1MzUKUmVhZCBvZiBzaXplIDU2
IGF0IGFkZHIgZmZmZjg4ODA0ODc4YmI2OCBieSB0YXNrIHN5ei42LjExNC8xNTM4NgoKQ1BVOiAz
IFVJRDogMCBQSUQ6IDE1Mzg2IENvbW06IHN5ei42LjExNCBOb3QgdGFpbnRlZCA2LjE5LjAtcmM1
LTAwMDQyLWc5NDRhYWNiNjhiYWYgIzEgUFJFRU1QVChmdWxsKQpDYWxsIFRyYWNlOgo8VEFTSz4K
X19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6OTQgW2lubGluZV0KZHVtcF9zdGFja19sdmwr
MHgxMTYvMHgxYjAgbGliL2R1bXBfc3RhY2suYzoxMjAKcHJpbnRfYWRkcmVzc19kZXNjcmlwdGlv
biBtbS9rYXNhbi9yZXBvcnQuYzozNzggW2lubGluZV0KcHJpbnRfcmVwb3J0KzB4Y2EvMHg1ZjAg
bW0va2FzYW4vcmVwb3J0LmM6NDgyCmthc2FuX3JlcG9ydCsweGNhLzB4MTAwIG1tL2thc2FuL3Jl
cG9ydC5jOjU5NQpjaGVja19yZWdpb25faW5saW5lIG1tL2thc2FuL2dlbmVyaWMuYzoxOTQgW2lu
bGluZV0Ka2FzYW5fY2hlY2tfcmFuZ2UrMHgzOS8weDFjMCBtbS9rYXNhbi9nZW5lcmljLmM6MjAw
Cl9fYXNhbl9tZW1jcHkrMHgyNC8weDYwIG1tL2thc2FuL3NoYWRvdy5jOjEwNQpza2JfcHV0X2Rh
dGEgaW5jbHVkZS9saW51eC9za2J1ZmYuaDoyODAwIFtpbmxpbmVdCnNjdHBfYWRkdG9fY2h1bmsr
MHhmYS8weDJhMCBuZXQvc2N0cC9zbV9tYWtlX2NodW5rLmM6MTUzNQpzY3RwX21ha2VfaGVhcnRi
ZWF0X2FjaysweDU0LzB4MTEwIG5ldC9zY3RwL3NtX21ha2VfY2h1bmsuYzoxMTk4CnNjdHBfc2Zf
YmVhdF84XzMrMHg0ZjYvMHg3YTAgbmV0L3NjdHAvc21fc3RhdGVmdW5zLmM6MTIwMQpzY3RwX2Rv
X3NtKzB4MTcyLzB4NTUyMCBuZXQvc2N0cC9zbV9zaWRlZWZmZWN0LmM6MTE3MgpzY3RwX2Fzc29j
X2JoX3JjdisweDM4YS8weDZjMCBuZXQvc2N0cC9hc3NvY2lvbGEuYzoxMDM0CnNjdHBfaW5xX3B1
c2grMHgxZGMvMHgyNzAgbmV0L3NjdHAvaW5xdWV1ZS5jOjg4CnNjdHBfYmFja2xvZ19yY3YrMHgx
NjcvMHg1YTAgbmV0L3NjdHAvaW5wdXQuYzozMzEKc2tfYmFja2xvZ19yY3YgaW5jbHVkZS9uZXQv
c29jay5oOjExNzcgW2lubGluZV0KX19yZWxlYXNlX3NvY2srMHgzOTcvMHg0MzAgbmV0L2NvcmUv
c29jay5jOjMyMTMKcmVsZWFzZV9zb2NrKzB4NWEvMHgyMjAgbmV0L2NvcmUvc29jay5jOjM3OTUK
Li4uCjwvVEFTSz4KCkZyZWVkIGJ5IHRhc2sgMTUzODY6IGthc2FuX3NhdmVfc3RhY2srMHgyNC8w
eDUwIG1tL2thc2FuL2NvbW1vbi5jOjU3IGthc2FuX3NhdmVfdHJhY2srMHgxNC8weDMwIG1tL2th
c2FuL2NvbW1vbi5jOjc4IGthc2FuX3NhdmVfZnJlZV9pbmZvKzB4M2IvMHg2MCBtbS9rYXNhbi9n
ZW5lcmljLmM6NTg0IHBvaXNvbl9zbGFiX29iamVjdCBtbS9rYXNhbi9jb21tb24uYzoyNTMgW2lu
bGluZV0gX19rYXNhbl9zbGFiX2ZyZWUrMHg2MS8weDgwIG1tL2thc2FuL2NvbW1vbi5jOjI4NSBr
YXNhbl9zbGFiX2ZyZWUgaW5jbHVkZS9saW51eC9rYXNhbi5oOjIzNSBbaW5saW5lXSBzbGFiX2Zy
ZWUgbW0vc2x1Yi5jOjY2NzAgW2lubGluZV0ga21lbV9jYWNoZV9mcmVlKzB4MTVmLzB4NzgwIG1t
L3NsdWIuYzo2NzgxIHNrYl9rZnJlZV9oZWFkIG5ldC9jb3JlL3NrYnVmZi5jOjEwNjYgW2lubGlu
ZV0gc2tiX2ZyZWVfaGVhZCsweDFiNy8weDIxMCBuZXQvY29yZS9za2J1ZmYuYzoxMDgwIHBza2Jf
ZXhwYW5kX2hlYWQrMHgzYjEvMHhmODAgbmV0L2NvcmUvc2tidWZmLmM6MjMxNCBza2JfbWlnaHRf
cmVhbGxvYysweGIxLzB4ZDAgbmV0L2NvcmUvc2tiX2ZhdWx0X2luamVjdGlvbi5jOjMzIHBza2Jf
bWF5X3B1bGxfcmVhc29uIGluY2x1ZGUvbGludXgvc2tidWZmLmg6Mjg1MCBbaW5saW5lXSBwc2ti
X3B1bGwgaW5jbHVkZS9saW51eC9za2J1ZmYuaDoyODcxIFtpbmxpbmVdIHNjdHBfc2ZfYmVhdF84
XzMrMHg0MTkvMHg3YTAgbmV0L3NjdHAvc21fc3RhdGVmdW5zLmM6MTE5OCAuLi4KWHUgRG9uZ2pp
ZQpVbml2ZXJzaXR5IG9mIENoaW5lc2UgQWNhZGVteSBvZiBTY2llbmNlcw==

