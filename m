Return-Path: <linux-sctp+bounces-12-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A784AE18
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Feb 2024 06:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB431C23024
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Feb 2024 05:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08037E787;
	Tue,  6 Feb 2024 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b="NuAmSVbR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail03.softline.ru (mail03.softline.ru [185.31.132.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455575B1F2;
	Tue,  6 Feb 2024 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.31.132.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707197426; cv=none; b=sxEG2WyXD7rGnoe1SgMMIQ3TkEv/9Sfs/Z5z6dVvPnE/uMb7cQbXKinEeiACKVHrd+Hncy5sI8RHDgNUEuZ9q3L40aSvUK8GyJ4EfNe5fsilKrs1b1GvfZkBtIkxAqarAlwbIhe572Rsu6aOhvhEec/zGDU0eJ2sog4vFVgxZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707197426; c=relaxed/simple;
	bh=UINi1/hQG8XCOZurLMNsE7igoGeVZZX4DkwpyG/7l7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gi4AyXWlNwVR7RMv+vQxOK1P/04tO3cCM1bF+vo/IzlZjRnBW/tGY+lM9n16JdXUZoam4obzboWjc0zPlLFjem5lUyHKoQ9IH08BQtRw2B8HkdkBiFLyPE0O5K4XLqcrvdZE2BplCmx4awTVbcR4wU2q4nIei7PnbGLzWnCA69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com; spf=pass smtp.mailfrom=softline.com; dkim=pass (2048-bit key) header.d=softline.com header.i=@softline.com header.b=NuAmSVbR; arc=none smtp.client-ip=185.31.132.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=softline.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softline.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=softline.com;
	s=relay; t=1707196551;
	bh=UINi1/hQG8XCOZurLMNsE7igoGeVZZX4DkwpyG/7l7o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NuAmSVbRBXSLQbayCSrNLbOjGHrdH+ggSK6kxFYbIaVGI2lFebcyOgSdh18xcd7f/
	 4mlqbJ+/e08lysA+h/JrdxghRUtssfge5DdkrwNhDP0TN2INntPDLID+M7DPz342zf
	 f3TthX8E6+uTS/hgS4jDnsDhg57wAP4sGMF3Ef/yRCRqzdN6nm4/hPQLPuwq9h1AdR
	 ld1TU1b1X/3ld27dmbMWVvHydRMRrcX0VqE9gNRqqQvZamUp7q6d9iq0b1UaHkwAXP
	 XuiXZFRYS0km14FXwTbLcMacu81wwxHRqgeF+lRKC9Olf7rs3KrwJWMtu6cofMDAqu
	 ZcF5kgX6vyfIg==
X-AuditID: 0a02150b-b29a1700000026cc-21-65c1c087e9db
From: "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
To: "lucien.xin@gmail.com" <lucien.xin@gmail.com>, "dmantipov@yandex.ru"
	<dmantipov@yandex.ru>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com"
	<syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com>,
	"marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>
Subject: Re: [lvc-project] [PATCH] net: sctp: fix memory leak in
 sctp_chunk_destroy()
Thread-Topic: [lvc-project] [PATCH] net: sctp: fix memory leak in
 sctp_chunk_destroy()
Thread-Index: AQHaWLuNBd2f1JRN90uP68gODAzIEQ==
Date: Tue, 6 Feb 2024 05:15:50 +0000
Message-ID: <c2426a6783239355d7af5c3673588258e884947c.camel@softline.com>
References: <20240205170117.250866-1-dmantipov@yandex.ru>
	 <CADvbK_fn+gH=p-OhVXzZtGd+nK6QUKu+F4QLBpcx0c3Pig1oLg@mail.gmail.com>
In-Reply-To: <CADvbK_fn+gH=p-OhVXzZtGd+nK6QUKu+F4QLBpcx0c3Pig1oLg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF28D786B4B5114CAD5FF4B2CC608C53@softline.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDE4OjI5IC0wNTAwLCBYaW4gTG9uZyB3cm90ZToNCg0KDQo+
IEluIHRoaXMgY2FzZSwgc2N0cF9pbnFfZnJlZSgpIHNob3VsZCB0YWtlIGNhcmUgb2YgaXRzIHJl
bGVhc2UsDQo+IHNvIGNhbiB5b3UgdHJ5IHRvIGZpeCBpdCB0aGVyZT8gbGlrZToNCg0KWWVzLCB0
aGlzIHNlZW1zIGZpeGVzIHRoZSBsZWFrKHMpIGFzIHdlbGwuIFdvbid0DQppbnNpc3Qgb24gbXkg
dmVyc2lvbiBhc3N1bWluZyB0aGF0IHlvdSBrbm93IGJldHRlci4NCg0KRG1pdHJ5DQo=

