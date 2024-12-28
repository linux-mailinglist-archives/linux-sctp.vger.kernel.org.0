Return-Path: <linux-sctp+bounces-299-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9344A9FDA5B
	for <lists+linux-sctp@lfdr.de>; Sat, 28 Dec 2024 13:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510E3A11AD
	for <lists+linux-sctp@lfdr.de>; Sat, 28 Dec 2024 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032841531E2;
	Sat, 28 Dec 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpL88f9E"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AEEC147;
	Sat, 28 Dec 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735387822; cv=none; b=M9Zg71HeUt2vQKWOJ3EApZxSz9cUeALlIR7joPUUiFIPG3bP3GVe3tBqnaEOSb5IMGp6G0Gx3q/PZn/eU57TFZh8bX8o9fV6T2uZsoKGbNM0DjO/0uL7lhxs7xNHvW3AqoArfu8H8VFus7oA17bjOYsJW4COcsIU7gk/s7K+Lz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735387822; c=relaxed/simple;
	bh=0QGXNaFJjk1c0fNs0wWeOtd9rF+1wlCEw/cKHTrnC/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFB4yIjJHmE5lKz/yq/4zuTWEBpKR10mZQecC5BUaB4EergQ5yLhpdGZGwzM9U70TNnPO2h2827sQv30HjOxbq7sy9hohWhcuURtBFe3lGhrf7wDW63J6TMcZpXMG36OWzAK0l7ZV8Ko5Vy9Kkj3E7RVDJWcuZj/DNpmu6eEhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpL88f9E; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863494591bso4257758f8f.1;
        Sat, 28 Dec 2024 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735387819; x=1735992619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA6eTDteXLTTcDUHaQ/HA6RP/xb4w/Mt2bZYijpFrSs=;
        b=GpL88f9Eqr5EHDmbhrP4nSztSlmLtLAZReKSEUfR47UZL3qRKFXyuBIRxekQKTLR0O
         Jacnpe4QURb7PQ4WjIz+Djhd0due/2ND7fzeFkg8DlUlYvItfa90xFegAqpAVnpj+1E/
         ON2MzphY3arOjiSzXfGBN+8WoUfA2eSBkcKTf8Jk3BS9A48UK+hYohe9oC+YWOL8lear
         NM3Xw9WdUgrQFfN61Cy5RP/UbeRzdfC5hlxVaQvoDdX/nVUv2EWq0xKEAeV+CUmwamMx
         TBC3Jx5uroPspiUIt+yjDz6UTQdP5Ewr1HfGSL1cGw1ZeDBo8Rj1y3XqKglskHzgzrw8
         CCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735387819; x=1735992619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fA6eTDteXLTTcDUHaQ/HA6RP/xb4w/Mt2bZYijpFrSs=;
        b=alHaL6+pGwv5jUCM1MTmU5NZP4juyRTpVV//unUaOfrTKhTEmFW6nF0oNCfM/603vp
         TvAgbeFBKj57rteS+0BXC1BIItSbJyUWQnDbCatB57Jb6BS7DJwhlHnk6XDkXEmbUlpB
         UQkzUGf3Tqyss2xmKzPaRQsDYNtmVEvrPown4RbzE6zN8eY7N5/W+M3ToPNevsJmDchj
         U747SJHpApqxH4sbhCP3JORd5/oimcoV78RbIOub6Q9Vj7R+5oAHnGKZdVPdmzpCtdQ4
         iFYs3hieRIE4AVU9/4AvFpgEUSaqtdAIpY7d4Z1KWod1K2ksNUBnuFg7gA7Xp8m2uCb8
         iczA==
X-Forwarded-Encrypted: i=1; AJvYcCU+DTRelNumNuz1B/h34rlcC7cIWVyJBE1V0utc3KtX2Z8JlrEiiwN1nRmJF7d02BgmqkLo9SRVJ3tO@vger.kernel.org, AJvYcCU5eh2yXVNq/E6hEeD8vAO7ElI1BZ/NMti5RnMFYf7f0liL4y4BdyYINSY5FwshmFuHeHkKGOhM@vger.kernel.org, AJvYcCUyL6cptMPKoXtNh887jCO05VxZhWq4p5yieRNyZJLyEl1wIcrlZ1RLDVBPTh+iQb2CHgJPVgT+@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwz7uSJYDj+VxzPuL3250qJ14fvExf7oLNWJayhr7JEAb9cp5
	56i/d568k4tStcMcLMXL6sRQRvb+xcc+tjytSx8sdca7ZqPBZ0nG
X-Gm-Gg: ASbGncukkjY0cdt7/OQaM0IEawiA2ZENbV9w07Gp7TJu2Mh53a3S6hROL591x+PdHvV
	pJNnMOWDSUXUauR+fOlGT9ELpf8Rs4Xk6xJd9N83b/BRpifn/GVkINFxkGKivp4qxX8zKjA52wt
	dzA17yU+ZJsq7ojVWNSvLZNoL1fWartTmMJRpZqZ/hi9zhbdd0WvpkZN6RhPpjfnHua1GsxdCWW
	g7VAwjI+mtN8p5gFaZ+Q8izuryDfisIkiAxxt7wFHDjc7SWYEN3Zb5Az9mc2hcMQiNHTPQnXAYS
	vTfizb9SEh9DUCzRILjK+78=
X-Google-Smtp-Source: AGHT+IEK4q12r0ZW7JTwEPQZ6rfdXPvPurHXUgjNLPvHDQIcghOD4uO5VpbcPPeppibnu2nA+HUl/g==
X-Received: by 2002:a5d:6da4:0:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a223ffac3mr25789354f8f.39.1735387819342;
        Sat, 28 Dec 2024 04:10:19 -0800 (PST)
Received: from dsl-u17-10 (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6e19sm24601333f8f.100.2024.12.28.04.10.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2024 04:10:18 -0800 (PST)
Date: Sat, 28 Dec 2024 12:10:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-sctp@vger.kernel.org, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Xi Wang
 <xi.wang@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, Vlad Yasevich
 <vyasevich@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] net/sctp: Prevent autoclose integer overflow in
 sctp_association_init()
Message-ID: <20241228121018.6b4b78dc@dsl-u17-10>
In-Reply-To: <20241219162114.2863827-1-kniv@yandex-team.ru>
References: <20241219162114.2863827-1-kniv@yandex-team.ru>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 19:21:14 +0300
Nikolay Kuratov <kniv@yandex-team.ru> wrote:

> While by default max_autoclose equals to INT_MAX / HZ, one may set
> net.sctp.max_autoclose to UINT_MAX. There is code in
> sctp_association_init() that can consequently trigger overflow.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9f70f46bd4c7 ("sctp: properly latch and use autoclose value from sock to association")
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> ---
>  net/sctp/associola.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index c45c192b7878..0b0794f164cf 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -137,7 +137,8 @@ static struct sctp_association *sctp_association_init(
>  		= 5 * asoc->rto_max;
>  
>  	asoc->timeouts[SCTP_EVENT_TIMEOUT_SACK] = asoc->sackdelay;
> -	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] = sp->autoclose * HZ;
> +	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] =
> +		(unsigned long)sp->autoclose * HZ;

That doesn't fix 32bit systems.

Looking through sctp/structs.h there are a lot of 'long' used for
timeouts.
it can't be right that any of these change size between 32bit and 64bit.
So they should either be __u32 or __u64 (or similar).

	David

>  
>  	/* Initializes the timers */
>  	for (i = SCTP_EVENT_TIMEOUT_NONE; i < SCTP_NUM_TIMEOUT_TYPES; ++i)


