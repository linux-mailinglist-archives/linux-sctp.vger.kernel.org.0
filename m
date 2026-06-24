Return-Path: <linux-sctp+bounces-1284-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VhmEHvz7O2oAhggAu9opvQ
	(envelope-from <linux-sctp+bounces-1284-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2026 17:47:08 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1346BFC41
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2026 17:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kcxXEc95;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1284-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1284-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75C133007B8D
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jun 2026 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A523DA5CC;
	Wed, 24 Jun 2026 15:47:05 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34A83B47E0
	for <linux-sctp@vger.kernel.org>; Wed, 24 Jun 2026 15:47:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316025; cv=pass; b=sDzXbz5zh5egYdAc/Imfgh0QF3+bsozpsyS2uvXhn94QRVpPezXXHM7zKwPi/F332FvxUSzR8zNy+0VK92MuaM5yv68AkBtd+ssAZkBVj++gHpdO9TvgSdQXMswc0jiuRMGS7q6UcOV9DC2uq6t4uIRQ5ny5eHv6yEO/3eJgcq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316025; c=relaxed/simple;
	bh=znUxrD+rX+i/jcgUUcYUF+WyNVpxg3869R1rpe5nPjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjwMtSwwFzustYb43F512tJz2UXd8N1iv3tSjaISmxeGryKImg53o9ZBeaVJ4uCpPFxVPmleWUu76kpnL3LNoWIBIke5vY2dixsuDQYDkWVyuysD0UY+m01bLQeXq37pPBv3B4Y5aeiv7kaABZ6zzMWcbFuJkihblY1ByvoM7W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcxXEc95; arc=pass smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c892a0ef503so694153a12.2
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jun 2026 08:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782316022; cv=none;
        d=google.com; s=arc-20240605;
        b=PWvrNnwnRW3Ys+9XFtIXSJieTS7oIV84GC3I56HcKU+B6HdyVKZqm0OJQvuCEna7tV
         DXLgqNtGmt+zqjAw6xK39BhEIoZt9hJ2yPYp47mAYfje3Vpofhzi4un4lFpyKH0oH/Co
         MNdhcjDj6TShJlYNREJI9/IiQyEC+xydsAxf+Y9uK8cE59l4Juz/GWgC79zx7U+Dzhn7
         Ev+Ts/xyu624kzbaact7RQ6tuD4xQeRXOB3tFMO7bH2nwkmVbMRE+WkUP3PSL4rXermG
         I5PRfg5elvbgoa0rUFpd43W8jPo7VTMt3qfjuZHe9cwUULCcuRKDvS8WH6hZVudIFL2G
         4cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8d/r44UUrv5OQGX8QnhBsaeNXrdn7O0arE90X+fL80s=;
        fh=jh90QAWTPnKhUw8tswE9sb1b9nWzGpCbVBwvMpLpBo8=;
        b=JYgD9tLYwVM4HilGMI1H5p+aeoYPSHUQ0kElF/9QJhLsBPPcrDtJmBRO13sajR6RuE
         Kkpb4j4F4W79soXGTtdkbyIsGoevWv/rJIAu7/SQN4T4OwssyzwLrJ+MU1vL3rwTwbcx
         RscvRDuHrgIbn6AZke6J5i34Xx+icZxfkf99G+jnm6dK/qQaMVYXRQUFSUg6IlaIHV/W
         DBhdkMSumc9Y8/PdrpXNe88AghUq2QS5qGS2E2uDv3xgB8aFmLij9vGTbgG411ierFZx
         vinxod7If6hRHGKwc6gBEt+8mMT0geafDeOyil2xx/xHUE4wiEPJie0NFtjBjrhn6Th+
         sTZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782316022; x=1782920822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d/r44UUrv5OQGX8QnhBsaeNXrdn7O0arE90X+fL80s=;
        b=kcxXEc95NLLp8KsrKMWU+POlguXr6cFInNmY5G6UforbDFASoqOPb7/FxnWMR0frJy
         sRNgzOMPPWQyx1SlApBJ7cmBRFm4/EzvlNsp+/yX7Z6T32Z871Z5SfqOCxQTDcx5ByAp
         f+tIweHGmU6jJX3Wae40z5nQ3UXZWr8gHb1MpEwv4baTcIn6ZnXCw0FEZHAY1HFxGS86
         8OsGcph5SjswZuk2rGOPNeFpRhYtXbDu5s3bjdY6H4gFh/72fJf376iTVLbZjkaY4Fao
         8em1wB4GCanZunELRts6lOLyas5Vofkdiir51eNMomkCBijE1YX22wZEbrlsGPcoyQdM
         19Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316022; x=1782920822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8d/r44UUrv5OQGX8QnhBsaeNXrdn7O0arE90X+fL80s=;
        b=nW6QBACmC8vaIes+056UIfkZu3/k1KiE5Z+yrHaIIBJOxWQEgDv/5YoLn6+dbBD3vO
         BKtaLlF2+PuFFfSeXwkB2dGLY6rhnjjCgRp0GmL3tZeJUuNZN1uEb4N1L1nktUaK1FaH
         7M+mOLFfXAvt3ZxdXUjGg4UyKVCbG6PvEfTB9pnOCucfDS5L/X8BRBsM2gXwJRQsYZOV
         hn4ZNwFgxzEvxSXe8CBnzV3D1PoeTgD0GHZPIRoUR2lIrjyD1Y2YNHjxQnBHZS/M+kih
         GLNMxAcBzx4kZ6xNzktLlykayeDpFOvPdxIpLD+QX1wprL7tCqalfSJEx2KKNoxEXX8g
         TXSA==
X-Forwarded-Encrypted: i=1; AFNElJ8+2X/8NxckIs6d4C2Ln+3VGZJrCkh2beSq5xVf5nMUC2otSsgQIdkjknzlw5A/T0oqRCdK+IuLlBC2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0rDBnXOl5O4sporPvQZNEholS+kVsFOgHsdeglfGCa1IhUyf
	pKVdPmZl6RtjwdiS0hCGyX4FXPpxobcMYoqnwF2Sb8edvihVVg6Mo4sXGR89oMHYLSyVzJoF8zT
	t/gaU8f7S7cUNgEi05z7QGG970g/BFZw=
X-Gm-Gg: AfdE7cmHipDPrHeOyd+t+WEM13Az1tBHm7BUq19pnM/rSkIWgTWuRxDMw4r8GI73z3k
	LrnVKUvFSKyCNQgvTbtZXsUhpf76rgy33UdIKMYJqWCpkR/42r9Wl9aDGhIJf6DTSTV7rBxt36b
	jzikGb+0akho3gGtOn8RWjfTzVk912mi/2Rvg8oiK+YS4LHXzadeQTTOP9oNWN+FOi2/WLPLNnI
	GO4UAQ8gwSapk1JAEy9jdbMcgA7/ENXHM2XxtequvIzUHbpYqmxIYl+Fa8gwS8sGit+MjjS9zqq
	L/yDySxrmHhguIVxjdjfTuJQPdq2gslyP/Qwri9TSiF8ZjqtvK1igVosdtWFV5McLhq53aPtOHh
	HzS84
X-Received: by 2002:a05:6a00:e88:b0:842:459b:d61b with SMTP id
 d2e1a72fcca58-845a2794eb8mr5393941b3a.32.1782316021875; Wed, 24 Jun 2026
 08:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781968162.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1781968162.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 24 Jun 2026 11:46:49 -0400
X-Gm-Features: AVVi8Cc8PzO46k6yEZ6LLOuvoH5XLopWZO-tuRx__W0v_vZgFLXs5tHhAMxdpIk
Message-ID: <CADvbK_e7806edOZ7xxV-JBdK4hTeFUPwf4=Vt7k=OZF7PWauEA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] sctp: validate INIT in COOKIE-ECHO when auth disabled
To: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1284-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F1346BFC41

On Sat, Jun 20, 2026 at 11:10=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> This series fixes a security gap in SCTP's COOKIE-ECHO handling when
> cookie authentication is disabled.
>
> Currently, INIT chunks embedded in cookies are not re-verified after
> unpacking, creating a vulnerability when cookie_auth_enable=3D0. This
> series first refactors error handling, then adds the missing validation.
>
> Changes in v2: see individual patch changelogs for details.
>
> Xin Long (2):
>   sctp: factor out INIT verification failure handling
>   sctp: add INIT verification after cookie unpacking
>
I will drop Patch 1/2, and call sctp_sf_pdiscard() for err path in Patch
2/2 on v3, as it makes more sense to discard the packet if embedded INIT
chunk validation fails, consistent with malformed cookie handling.

>  net/sctp/sm_make_chunk.c |   3 +-
>  net/sctp/sm_statefuns.c  | 220 ++++++++++++++++++++-------------------
>  2 files changed, 117 insertions(+), 106 deletions(-)
>
> --
> 2.47.1
>

