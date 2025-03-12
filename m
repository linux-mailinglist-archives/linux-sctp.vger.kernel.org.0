Return-Path: <linux-sctp+bounces-377-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCCA5DCBD
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Mar 2025 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B724918930BF
	for <lists+linux-sctp@lfdr.de>; Wed, 12 Mar 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D31241C8B;
	Wed, 12 Mar 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oWTp6Zv1"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1EF1E489;
	Wed, 12 Mar 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782811; cv=none; b=cjBDX6EdWDiyCiV74DFFIAQVOOooGyVm7HtXDYQRUshSX4a97fQC0eUaBsBb3lBlqDHprZhn9rtcXHZHsDyhZ4TtNJPMfuyxIQMyEUy+l5pTuA1t82b49s11nbF+trjJmAKH46IMxb7wWJOTeRVLfaPPNqPIkqQnfjfIoYYfoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782811; c=relaxed/simple;
	bh=YRkj4sqSqQQgNr59IaP83gwr/KbDIvv0V3DJyw6R3qw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ymc0GpizyXxBKaEqlbyNtXouYSXOjun/jyYFmrHOZBlmE/lxRS3rYpq0UlqK1aVdnoh8OKpKUxgFHtJqOpFzHCfAuwvvD6qoeAHmv6hQokppXk4N6HW0zXm2qkhkDYIt26rijPE8k7g7sjJ73MDhNVo3fTWRJn7JocjTCAO5qlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oWTp6Zv1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741782805; x=1742387605; i=markus.elfring@web.de;
	bh=hh5c+Zd/kuAhAL/TqLeBv/5gR6i+du8FtsJSY8grQxo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oWTp6Zv1VJUeIQsrL85La3RFRFzx9BQg+RwFBAoGGdziUzn69ak1M9IDngQIlez3
	 AyFRYIXY7021i2jz/9WUurtj8+0aXgVEz38tkMf1qAH1tHBXEbMT1eTTzYODKnTLG
	 HHt6ZHll0IpT+MQTDMd7LDz9IPVJq4FTgHHWchyW1A48gELkKctz37kaToArMaVKo
	 Sy2Rli5vmzOLJFQnq2EPhQQAULok5vLuw5z1NcnPWFTW3Wne2IdgM8CpCJ+TWt+2o
	 eXs/OT6ObTPy+WziW30mvKmvfrpSegZymbafrHQtje45fLqU5+kgReSpV+mBj2Lqx
	 89p5bZuotyNQM8yoHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1t44uF3V9v-00siwh; Wed, 12
 Mar 2025 13:33:24 +0100
Message-ID: <b7821109-e0b6-441d-a15a-580bd7bd4c50@web.de>
Date: Wed, 12 Mar 2025 13:33:21 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Xin Long <lucien.xin@gmail.com>
References: <20250312032146.674-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] sctp: handle error of sctp_sf_heartbeat() in
 sctp_sf_do_asconf()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250312032146.674-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mWcFtUCxvmz9Gb74Yp8WaL/ErrzkTk2RefOaUE0nkbRlU8XpM0+
 LTdl9LUhZx6mnPtK2eQKMG6qwgSItnYQx+12XVUUuCsHI9G2ysBHXMcfHTb42P0yLo4p00M
 jmQYFvZvLdUYLlmAaSi6eoXOWckJgpGzJJ5WS0Uw5NTTWwykK5E8ImeZ7HDpdynh0ikrkKn
 ylFKlwX2rkZYZ27hnXu9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hkz3EDrPPW0=;nTgY/D+sLpMHv6vElkVQvVfcrTg
 d2+uzk43jo1EEjsMXcli6jBXwe1MYwlraSxEFmJ/NAPL3cKNVGd7FS46/faUTsJMKcMf6aE2H
 eR6PUTw4O+S/3KxTgDPCm4qseuD0mYTEY5sfuf3LrjC8LginXoEY1UX6YJM4Mv3WJFGISbyjs
 AUBMyBJQVif1nkcYIYBH7mvC2f+Evkla+kQ/aGm0ujV6LGbp2vqxC094AwsFsZsEP0MCmDDu4
 p1oR6i7+LtFB5Up+a4TqZ+N35cv7PxnxlX32xRwrlG0/m/WRF83TlpvGFa14k2slRA8gQfLOq
 5nLwUo1oWkqKRa0mHR+y+dHZ7ho0w1q/Rmj5TgvkC6UjtZMzSR7XaxdzFiTBStyWUbOwxxc6t
 r30qwQPWxUbYdxqUAzE2sIQ9duUYOBHR5f9H0Cs9eEyYBOwPmChXzRW3sJnhVK9iwgUwMaj98
 aFrKoU6OLoUGQz7kh12CWTkQgshoGSS1HGbkhJXNnjymJ45nq243FF7YCCqxp3rl0y++ibPAR
 MqMw91z0mu04Nl1OeLGecXa+olWg2mknkMXEFDZPF2gd+ngORFjfPjziIiMqNlZOWUML3EzPE
 9xXbKBykPPIsnsnPn6YNB0t9o0Wy5s5+ZX9+NriEaZH7+Zp5d4OQD1CpaMqRaN3XaNLtouYq6
 KPzpf8lsrPrCknyO2utj8ikfQcvltIfIronxQPVYxHmx6Uh+vY4PVuuq/Yyoe0p1H9yInuqHZ
 UxpTTTTyzydjdOGdpH2tdeqA4UAcbwYEkk1EyA8ynDl/8fHOHqjnFXOrnOiYrRXqtPZJftuXp
 52U/sg21cJyIGPQoz0qtqJXvZF18qlFMb0de3O3LLFOe6oBQ4P015JzqMraTnOdK8BGKFkD40
 O4tDCxxmm6nJSVY1u/4WpG8ykOY0kKYqFin26NJdLGp4EzRoQ797rBhGyvouBqkNZq4rxTjZ6
 z6pZhaBaj90E+lYMV7m8dqZoY3vE2ICHl0ua+gGZf2FCQLl37Efj4mSCnHNltczWOrBayKv8g
 5wZHpvM+IwVW8/2dNKPGaZ92MqTnq29GRdWvZnh3w8M/EctfIZW+r9+Ocr3mgQ8Lflm9vw5vX
 8xLUTmmEDbvPTeJ+lh6tyCwHEnGQF/XuCZ4XEUMwuSI3Z9mpAoThrgwOio8XxsqhZPqUScDFR
 FpxumDCQmnUjoomPIFnLTupxw1y+mk5r10HdXNXTKLoRCLwHSryDhRihtuAOBW0KjHye+eoRL
 8MS/wyKdDt89OoQ/naPLvuXezjV0AfFItzRHotEp4pTIVr5ou+4BO2Ur22w6OKiYyHEEejwmT
 /aY93/eox2M1uA2UoyEvkkVcjp8Oo6rpg6ltPD2b/onFtP4JMHDbw1s57nhFyqzujSK5omRSW
 r0/kBrOJVSSTqMgwuVLsTvyGKpBRu138M9AiRSyybPaoOS9eTjipqxeOhIRtSqC5AKVw+AY6Z
 EtO+F9fFJuASs7VTkUuc//8Mugq/f0jX45w8jhc1UKuQ8iY0t

> In sctp_sf_do_asconf(), SCTP_DISPOSITION_NOMEM error code returned
> from sctp_sf_heartbeat() represent a failure of sent HEARTBEAT. The

                                                       heartbeat?

Would the error predicate =E2=80=9Creturn value !=3D SCTP_DISPOSITION_CONS=
UME=E2=80=9D be safer?
https://elixir.bootlin.com/linux/v6.14-rc6/source/include/net/sctp/sm.h#L4=
3


> return value of sctp_sf_heartbeat() needs to be checked and propagates
> to caller function.

Will imperative wordings be more desirable for such a change description?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc6#n94

Regards,
Markus

