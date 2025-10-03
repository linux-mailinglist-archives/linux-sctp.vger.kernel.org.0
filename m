Return-Path: <linux-sctp+bounces-629-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D84BB7558
	for <lists+linux-sctp@lfdr.de>; Fri, 03 Oct 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AD119E546C
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Oct 2025 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4F28031D;
	Fri,  3 Oct 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dO9Pcu01"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D91F5846;
	Fri,  3 Oct 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505802; cv=none; b=SQY3Sre7rIqdzjneUqbE/v2DI4ztzsG5+xFa3uCCF4OmmzR7BJ4TI6ogwYK9d+7Gt3XJXO23MQ0dG88WBCmTek6IZwX4ELl4aGvyyzrrGN3+M5336oO3Y3GiMRD8Rx/RIwVYlHuNdn08Wz0akq5TSTgkDit7dbdmE0TjKvplCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505802; c=relaxed/simple;
	bh=bYPyaONfd7BB2jZ8laR+STd/TArlmcbZgT04Vq/FeUA=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:Cc:
	 In-Reply-To:Content-Type; b=frEfIek/+PEJfdHoDUB6g68EmcK/UYwDJHSd5xX8aWCXyO/0DGcVWMjLIV00sq6rRzqhdBljuSxYIdyDA7j9gJ6Dv7j3A4wXR2FFZ6avSQBkhGT9SniVxI2meVQ41dEBK8nkbwuCmnRcbbVB9PYFhiY2lpZwFeYESlwJM8+em/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dO9Pcu01; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759505782; x=1760110582; i=markus.elfring@web.de;
	bh=bYPyaONfd7BB2jZ8laR+STd/TArlmcbZgT04Vq/FeUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:References:
	 Subject:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dO9Pcu01ALZfDKXENdvYLbwmXJSHGbgrTPpGwDvCWG2AhxsUnPQmBtzh1RlTSvSs
	 TH/ZMPXO+Qdb+RvdfCGrJadDr6aX3ALq0TmvuO1QdRFRLCGomBZdUv0maTz5Rmy+w
	 /zqltT07/dAaN7W3KbZ9hVn/o2O6DoGYbmSjZ+DiMnyr45a4z+6i7iEh7qDPb/67R
	 kKRHj3QkLoeHylA5G759KkxzXoFsNVBUrWE6cPIW7Q7PEEAasvILY6D/70ZaazRbc
	 ETbRf+hmEdlLc9RsxMGvTychS55zq5lmV3ySdGysZGlVFf1J6PlYE1pmMJTr7iCk+
	 m28YDyblpw1PxJ13KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.196]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1v5EBU2gZi-002as8; Fri, 03
 Oct 2025 17:36:22 +0200
Message-ID: <a6e99e68-3964-40f4-8512-44f16bd058ee@web.de>
Date: Fri, 3 Oct 2025 17:36:20 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xin Long <lucien.xin@gmail.com>, Alexandr Sapozhnikov
 <alsp705@gmail.com>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <CADvbK_frvOEC4-UbuYixCu2RbQuAOQLmTsi5-sGnO8_+ZSpT8A@mail.gmail.com>
Subject: Re: [PATCH] net/sctp: fix a null dereference in sctp_disposition
 sctp_sf_do_5_1D_ce()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADvbK_frvOEC4-UbuYixCu2RbQuAOQLmTsi5-sGnO8_+ZSpT8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mzvHYJrvuTFBecbRBQD+ii42JZVHXMNQQeTibEJzNMqaw/9twi0
 l2SW7vY3txojAqSlx2XKr6PYzIzhjvCqNv/FhYOC1WkEOkJ0ikTpzZ7DPVDI9WFLwpstpAd
 rKZRFXNeGK+WhyVTKrJo+9o8R7IpqFnhRmZmP4oNTmyn09CHWOR4doWlScIzPkhmQz8H149
 hykTb6sTvlt8Ks7p5ySqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SBPcf4lK+j0=;VxiIWI6q1tnugqdIYm6KJvOONSn
 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
 zJQusrGJWueL09iv41U3SF7n4/8r1hVq4SU=

=E2=80=A6
> > and sctp_ulpevent_make_authkey() returns 0, then the variable
> > ai_ev remains zero and the zero will be dereferenced
> > in the sctp_ulpevent_free() function.
=E2=80=A6
> Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for
> AUTHENTICATION_EVENT")
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n145

Regards,
Markus

