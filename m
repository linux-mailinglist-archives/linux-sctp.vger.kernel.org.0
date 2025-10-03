Return-Path: <linux-sctp+bounces-628-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF6FBB7526
	for <lists+linux-sctp@lfdr.de>; Fri, 03 Oct 2025 17:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F3BF4EBAAD
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Oct 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4052376E0;
	Fri,  3 Oct 2025 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hcskOQdf"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD0EAF9;
	Fri,  3 Oct 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505446; cv=none; b=PFXbtY7CTUrNZxIFbP5OosNgDOsIJ+2XuuVF3rCbeWVCndnw/gKO4x1iWwXscZD3UNxZqZIkWy1sJ8+BNqwmTxH5O1ig3V77P7N4KYIXV11fhbyfLJf2cEJx+8jzlWa9zv2lDNTOV6+UoWsVciNOUyxYwmDKibGtfn6Omy3eEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505446; c=relaxed/simple;
	bh=Cs+QHuRdKIy99OT9oLJNh6W4SkH251Aw31QlW1Rr0p4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Trb+y7Bs1WCDx+w4MjzHIkmqI7YZ9JzV5eOcGLEMXQeK+bKMJEaygu2GGTObj+TuoaYEhrRozjXAaR9G7L+xfE4398HPTrVnimH18xwDaEUPWpDLbm97ucDlMdJCKA7T+xiYa2WhVdSB1/LwVK9a0x3Qumtx9nd8HzDjE9/yPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hcskOQdf; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759505435; x=1760110235; i=markus.elfring@web.de;
	bh=Cs+QHuRdKIy99OT9oLJNh6W4SkH251Aw31QlW1Rr0p4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hcskOQdftSvPlB1C64N3SR2xWbnRDkQnFXpJIZJ6lFstk2qegs/gJ+tLsOrxXsX+
	 Sz5rLHXYW6xzCU/X7pGQh18jbNtyVjRJocwHd8mijH1eMzNXcbpzm7uJEa7a/ooRj
	 t0UCbKPPm5Y9a3hwZGzujcU70xMGk+Y8zgSgQuJYTzQItYNG/t6HK7qAKbFQXIQeD
	 q+9pmeMRzTAyMJHQoAr9g5tAWaukKfJWKkHKiMmgnrM5n/xd5xrFDPeP8SGB1k4U6
	 ZBhmOQaDauADa8+2Y4/skYNP6Uw3BSZqSSXURAuns8y3tq27dvI7xZxiOHkeivIiT
	 Xu0U+VeDF+9/ICY/Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1vBGFv0XNI-008enj; Fri, 03
 Oct 2025 17:30:35 +0200
Message-ID: <5175df68-f587-450a-b73e-4caf737d9cc7@web.de>
Date: Fri, 3 Oct 2025 17:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexandr Sapozhnikov <alsp705@gmail.com>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>
References: <20251002091448.11-1-alsp705@gmail.com>
Subject: Re: [PATCH] net/sctp: fix a null dereference in sctp_disposition
 sctp_sf_do_5_1D_ce()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251002091448.11-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B/BU/BiWLVInv1fU2HI+HxwFifgBk6zqICbTEgWwT2z1pSBYB+g
 xRo5bkYttQwYhP97D1O4XAFysBYY4uhywDtCP92pM3ZlYZo1QHtD/mPIDqVrazT2ccFwKhu
 3mTfgZXVa1eEr7o6tawq7rXdwth4iz2TDviNJyWhR9fuA79fppGaihxwY6NpeVkyLrUNTMc
 3eF6AbkBwQxM7gmDVT5SQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:INKFdA9HvWE=;weGRq/pXP1HyESJsR5jGAd6+y/7
 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

=E2=80=A6
> and sctp_ulpevent_make_authkey() returns 0, then the variable=20
> ai_ev remains zero and the zero will be dereferenced=20
> in the sctp_ulpevent_free() function.
=E2=80=A6

Would a corresponding imperative wording become helpful for an improved ch=
ange description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94

Regards,
Markus

