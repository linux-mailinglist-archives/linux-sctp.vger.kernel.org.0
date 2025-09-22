Return-Path: <linux-sctp+bounces-624-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721BB9266C
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Sep 2025 19:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3357216D493
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Sep 2025 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C5305E33;
	Mon, 22 Sep 2025 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EekZSBTX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A083126BF
	for <linux-sctp@vger.kernel.org>; Mon, 22 Sep 2025 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561763; cv=none; b=PqeqRolZj9mhOr9Tw6y74KUvQK1BuoaMuFfmTidVS+rMFFw+xQpbq6iLGtmtgtzCmljt1KOc/a+IJ1e/Pw3dg9e1whIchj4VHzd6ytOGEn6Vs6NeuH0dbKKQvMvWV4RVATu3Rgb11n5wGICI/mvhuo0lPgFSV6+C2Yl+DVBL+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561763; c=relaxed/simple;
	bh=wQ4Kp0VTDMCvPe0uQc5TGGt4U0+rpHS7hHdjK/E4c14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEpUcc7kDSxGPrqz/PaUJ2aPtYaORvhwfM7OycqCCTZMtpZTkYrGPbaN/JChXI6xnuK99PiOjOQ6n8WoK77EtKgB/JQXltSzhl1h2LrHzPt3P2iXz6Opke4ESkvnNH1Cb4s9kbcsPfrB1Cv4cHzotC6jM5AZBykR005PgxVuuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EekZSBTX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so3036996a91.0
        for <linux-sctp@vger.kernel.org>; Mon, 22 Sep 2025 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758561761; x=1759166561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ4Kp0VTDMCvPe0uQc5TGGt4U0+rpHS7hHdjK/E4c14=;
        b=EekZSBTXF3QPM7rqtQ7q5e71yCiPW8LMlJr2uhaJmJ0T8X8PTBy7sCFQOqHtk86dkk
         ivtUMH621d0iqF5np2QXlpcsHiBPRHiA5bi5eSBc22vLtc8m+tXlD+VSFh+q9LPdXO9b
         IAI48Dkoglv0XfgIpuA30MWj766qXEcHIZNYQBSwBZBmcFOP5VJeilMkaunwsKShk4k1
         VFRMJj7ApC5wx3JF7+R3kWapq7tDgS+U2rWRvLs+qTljBVk0oNdFyhmKrI4tBxNdx4HB
         olby0chP8WeLT5OY1izJ3Tboc+dA1zvYeLAlMDZwVSZKvGtUUMKKiF2qgtfodbZK8Yt+
         5mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561761; x=1759166561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ4Kp0VTDMCvPe0uQc5TGGt4U0+rpHS7hHdjK/E4c14=;
        b=R4XquNM5ON6Q1l326+d+cTNR9F/PsnHDtb8UGMsTxJNC6MbhXDsnrYjfoSrghKeH5r
         0NJyAhHCjkvG66dJKKE7VPwoMh2AVlyQQRvhZVA0mA/sqCQRo/gblFFwqG4hBs4J4dhQ
         8lkqb4bf5R9szJ546/UyZEFPL4kF9w+ZLb3TnScudz/CBsg7W+/Fa5luh5ti1yEXMwaI
         V7h7uqB60tPi2aG2NQwnOOqxWez4iVYMtTE/J7IBYf22ub9ABvJ6QC1IuKCFCWysnTyl
         QdwVoEPsxY/R4CAb4G0QtB93vuMsnQzcJgS4y2M5N7hk8pRox0xE7xkszbppBrW93hki
         b/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUS53JDmY3Q8mYpjknII9CtQerNkvGLjoVBy0+TjS3rCKcKDKhbt0oOsCErvxA/E6yUYYdW0Vi7gFEA@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRYLax8GmYEWOSNeJfMcTbSmgU5M2pz8Y9U8R9pmmJJpLaXcP
	D2MG1bcVbVlwnL0iJeMziE1x5S4NzaxJRYUqByKOg+9V3X4sqWyI+Gk84+DLQfnS+zJ/AUxbiff
	aDdvWfuG/cXFJe2iKxULF6sPQHeJOAGvbSP9C
X-Gm-Gg: ASbGncsJ4LoMo3LJXM6E5qmgNo487wwdikf+Ucxl6o7+KhsAGKOzSJVFIMZ5OSbHmdk
	Rv5YnQ62WWiE9Zd6QC6Pa0+9ATWrexYUz4dwXPRcf0faTnwvGYfHBXjTjFVPUH5cnfYOUdoR+iQ
	bw/nx2wkfkzCsg30rOWdGLYi2693fPIF9WjyZGPmfokQHr3KYN+0j4djBwVyXTvfLOw2MydO9iy
	btVHVbQrA==
X-Google-Smtp-Source: AGHT+IF4a8L+Gmh3SxmysL4rvnDDWcAChe6o9DbOwVVQLOKVcYLRU2VnuJVxJYpSuc/zmXLIdQjnBJ0Q8w+L3PMD+2c=
X-Received: by 2002:a17:90b:5585:b0:32e:23e8:2869 with SMTP id
 98e67ed59e1d1-3309838e21fmr15656095a91.30.1758561761304; Mon, 22 Sep 2025
 10:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922161557.2716-2-a.simakov@securitycode.ru>
In-Reply-To: <20250922161557.2716-2-a.simakov@securitycode.ru>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 22 Sep 2025 13:22:29 -0400
X-Gm-Features: AS18NWBCoM5w3HKw-kks4t48uEDueLAFNfDZDdfj2_mrI2oct77SEJoVpk6i7zA
Message-ID: <CADvbK_dNusmGm2Bc34ZUZznTLM1W6DcvGwyotYhP5=cdikvXkQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: fix null deref in sctp_sf_do_5_1D_ce()
To: Alexey Simakov <a.simakov@securitycode.ru>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBTZXAgMjIsIDIwMjUgYXQgMTI6MTfigK9QTSBBbGV4ZXkgU2ltYWtvdg0KPGEuc2lt
YWtvdkBzZWN1cml0eWNvZGUucnU+IHdyb3RlOg0KPg0KPiBUaGUgY2hlY2sgb2YgbmV3X2Fzb2Mt
PnBlZXIuYWRhcHRhdGlvbl9pbmQgY2FuIGZhaWwsDQo+IGxlYXZpbmcgYWlfZXYgdW5pbml0aWFs
aXplZC4gSW4gdGhhdCBjYXNlLCB0aGUgY29kZQ0KPiBjYW4ganVtcCB0byB0aGUgbm9tZW1fYXV0
aGRldiBsYWJlbCBhbmQgbGF0ZXIgY2FsbA0KPiBzY3RwX3VscGV2ZW50X2ZyZWUoKSB3aXRoIGEg
bnVsbCBhaV9ldiBwb2ludGVyLg0KPiBMZWFkaW5nIHRvIGEgcG90ZW50aWFsIG51bGwgZGVyZWZl
cmVuY2UuDQo+DQo+IEFkZCBjaGVjayBvZiBhaV9ldiBwb2ludGVyIGJlZm9yZSBjYWxsIG9mDQo+
IHNjdHBfdWxwZXZlbnRfZnJlZSBmdW5jdGlvbi4NCj4NCj4gRm91bmQgYnkgTGludXggVmVyaWZp
Y2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS4NCj4NCj4gRml4ZXM6
IDMwZjZlYmY2NWJjNCAoInNjdHA6IGFkZCBTQ1RQX0FVVEhfTk9fQVVUSCB0eXBlIGZvciBBVVRI
RU5USUNBVElPTl9FVkVOVCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBTaW1ha292IDxhLnNp
bWFrb3ZAc2VjdXJpdHljb2RlLnJ1Pg0KPiAtLS0NCj4gIG5ldC9zY3RwL3NtX3N0YXRlZnVucy5j
IHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL25ldC9zY3RwL3NtX3N0YXRlZnVucy5jIGIvbmV0L3NjdHAv
c21fc3RhdGVmdW5zLmMNCj4gaW5kZXggYTA1MjRiYThkNzg3Li45M2NhYzczNDcyYzcgMTAwNjQ0
DQo+IC0tLSBhL25ldC9zY3RwL3NtX3N0YXRlZnVucy5jDQo+ICsrKyBiL25ldC9zY3RwL3NtX3N0
YXRlZnVucy5jDQo+IEBAIC04ODUsNyArODg1LDggQEAgZW51bSBzY3RwX2Rpc3Bvc2l0aW9uIHNj
dHBfc2ZfZG9fNV8xRF9jZShzdHJ1Y3QgbmV0ICpuZXQsDQo+ICAgICAgICAgcmV0dXJuIFNDVFBf
RElTUE9TSVRJT05fQ09OU1VNRTsNCj4NCj4gIG5vbWVtX2F1dGhldjoNCj4gLSAgICAgICBzY3Rw
X3VscGV2ZW50X2ZyZWUoYWlfZXYpOw0KPiArICAgICAgIGlmIChhaV9ldikNCj4gKyAgICAgICAg
ICAgICAgIHNjdHBfdWxwZXZlbnRfZnJlZShhaV9ldik7DQpUaGUgcGF0Y2ggY2FuIG5vdCBiZSBh
cHBsaWVkLiBJdCBzZWVtcyB0aGVzZSAzIGxpbmVzIHN0YXJ0IHdpdGggc3BhY2VzPw0KWW91IG1h
eSBydW4gLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgYWdhaW5zdCBpdC4NCg0KVGhhbmtzLg0KDQo+
ICBub21lbV9haWV2Og0KPiAgICAgICAgIHNjdHBfdWxwZXZlbnRfZnJlZShldik7DQo+ICBub21l
bV9ldjoNCj4gLS0NCj4gMi4zNC4xDQo+DQo+INCX0LDRj9Cy0LvQtdC90LjQtSDQviDQutC+0L3R
hNC40LTQtdC90YbQuNCw0LvRjNC90L7RgdGC0LgNCj4NCj4g0JTQsNC90L3QvtC1INGN0LvQtdC6
0YLRgNC+0L3QvdC+0LUg0L/QuNGB0YzQvNC+INC4INC70Y7QsdGL0LUg0L/RgNC40LvQvtC20LXQ
vdC40Y8g0Log0L3QtdC80YMg0Y/QstC70Y/RjtGC0YHRjyDQutC+0L3RhNC40LTQtdC90YbQuNCw
0LvRjNC90YvQvNC4INC4INC/0YDQtdC00L3QsNC30L3QsNGH0LXQvdGLINC40YHQutC70Y7Rh9C4
0YLQtdC70YzQvdC+INC00LvRjyDQsNC00YDQtdGB0LDRgtCwLiDQldGB0LvQuCDQktGLINC90LUg
0Y/QstC70Y/QtdGC0LXRgdGMINCw0LTRgNC10YHQsNGC0L7QvCDQtNCw0L3QvdC+0LPQviDQv9C4
0YHRjNC80LAsINC/0L7QttCw0LvRg9C50YHRgtCwLCDRg9Cy0LXQtNC+0LzQuNGC0LUg0L3QtdC8
0LXQtNC70LXQvdC90L4g0L7RgtC/0YDQsNCy0LjRgtC10LvRjywg0L3QtSDRgNCw0YHQutGA0YvQ
stCw0LnRgtC1INGB0L7QtNC10YDQttCw0L3QuNC1INC00YDRg9Cz0LjQvCDQu9C40YbQsNC8LCDQ
vdC1INC40YHQv9C+0LvRjNC30YPQudGC0LUg0LXQs9C+INCyINC60LDQutC40YUt0LvQuNCx0L4g
0YbQtdC70Y/RhSwg0L3QtSDRhdGA0LDQvdC40YLQtSDQuCDQvdC1INC60L7Qv9C40YDRg9C50YLQ
tSDQuNC90YTQvtGA0LzQsNGG0LjRjiDQu9GO0LHRi9C8INGB0L/QvtGB0L7QsdC+0LwuDQo=

