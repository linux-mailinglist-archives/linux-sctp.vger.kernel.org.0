Return-Path: <linux-sctp+bounces-525-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8747EABA93B
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 11:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BEC4A1F2D
	for <lists+linux-sctp@lfdr.de>; Sat, 17 May 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646F51E7648;
	Sat, 17 May 2025 09:58:40 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EC1C1F2F;
	Sat, 17 May 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747475920; cv=none; b=bflNdD3gC6VqiuTWlgQyeUHL/TRgQmyEX995JejNc5WNnrQBLu4Xp7EdLdTN6mRpIhsUIOZObC+DrzmWmUKf89ye0/rVlkQLfTWGAmmbap9OTCvhQ+aBQHkldf9YmmiapD3GHSeUaiT+6g7GDn2AHV0mPcqTOb7pjyOkJo2ScBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747475920; c=relaxed/simple;
	bh=VIs2OF54lqPLhmf74bUbL4CZ0VFfWopF/SaPWVXUFPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxfC+KOCK3SFYHK1iu40eyZ/onTJO3X4cEaZkubDonTltxfHCs6yB0kVD0FrBszov4gOnhCjNC3FFbktQfBhH/gamLHTamf9yvQWvpWU8p8TEiiTHouKXkRai2gcrbvhLBK8r8HpVBiFUeLmBWZlYXdLSMIgG/18OPafuiCiVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so30323025e9.3;
        Sat, 17 May 2025 02:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747475917; x=1748080717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1xybqkdxpFEj1EI8QA+pvcqPiyMXAo9agsU9POzFbs=;
        b=utSwGTDT3p5U+3zmB1XtEg9AzOUVqnA+t0+xCn9UjgkgaFLxEKFn0fQ2moF8Wc4zLw
         IJ1vcudo9Mi6xLqlEdSCKLKkyhJYhittfiTgInSXdbGMX7d72xamojtnT0AtocOkL2Aw
         oRMD4fUsahhdDdivRo2Uw8cSrgGnorFg4KBxoPEruliFe/9KzgXp+tMPvV9Le8UN+Ckw
         DrlJc7OK8JW39cfaKVrzs5BBBn43kkphoPG5h8NwFSYRpuqzizDTY9ASdE7f29xp7mQg
         wZrIMEBQoPfTieT3q041BOaVnZBGUhcxTvZC+9gK7apDQ06cuk6wb/Bu3TtU21tBnV1F
         r3oA==
X-Forwarded-Encrypted: i=1; AJvYcCV32CF7iWUa4FsNZ9kyhVFNkJljX3qA5AFxi+/8r5I8qoZrOuFh7d6UTyvTzbRMoUveY5L7UafgIdohHQ==@vger.kernel.org, AJvYcCWW9m3x3L4Fu7kR4rs0HyCPx/Yi7OXK2caq4sBT7FDMa0iqKlv8MdAxsBbIm4HzcrrB+UOhg2yQ@vger.kernel.org, AJvYcCX8YgDy2XUpOCqZMymsJdZdi5/X3k6lBX1C3U4A5R59App/D3qo2xS/vCXliZKlXy7roUISDbsXrJ5EzA==@vger.kernel.org, AJvYcCXyV+9btsAvhGGZTwpfwe3cqzIZ4KBNYYVPdoP0S2p+tmMjzJ10As8S/wp3pVJLaLbQ+19RTRxfr4ajFrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6fFjZ+KodxM8nSdQGLMv4UlbMLvqT0L7KOflks4Eo7PMH/xV
	IvsrdkTtIv9QEwUfO+Lj2k8UGLu8mPgHfR6ekUQwVfliZI+776msT4qh
X-Gm-Gg: ASbGncvtoyBCYQBBYrPorHliixxTww5IYcwyM8zJwhrFuchyG3FkA2ECm7P2GlQTCa9
	kVtGlLxvdIug/zu2yBithYrO0MvLK0JRPMhGoeKt5A7MLLuMYmQzMFQPZNY99baBUWRcrwmrkSp
	C75fDvriSu89/bknpuSP6BbcAXGdL+0rKgFPCqeEk/qrf058a6LUiOH7zwaOVCPRtvDtVsstyc2
	vInw7sJ3BmBHjNIa0ePIX4+KKOBsft7GmgI+mud5iIaH5NozqMChBsd5Gj2iCgqha+mh1Th4W4l
	KgijiYYA0ysCukELqpMbb+47nTDe2THGZQ1HBPK/ekhWd1A3PJScz2eQlpMrt/JyWmamUT9RPlz
	QByXodzvU
X-Google-Smtp-Source: AGHT+IEL1yy1dVgbHcGpQ/e6QxEBlTdRtwZtph6z/27chlWDRnOkl9UnAko5e06/JsZwHle1RrNcjQ==
X-Received: by 2002:a05:600c:1d82:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-442ff03bd03mr53445255e9.29.1747475916740;
        Sat, 17 May 2025 02:58:36 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50b983sm63604445e9.11.2025.05.17.02.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 02:58:36 -0700 (PDT)
Message-ID: <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
Date: Sat, 17 May 2025 12:58:35 +0300
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250511004110.145171-10-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   #include "nvme.h"
>   #include "fabrics.h"
> @@ -166,12 +166,12 @@ struct nvme_tcp_queue {
>   	bool			rd_enabled;
>   
>   	bool			hdr_digest;
>   	bool			data_digest;
>   	bool			tls_enabled;
> -	struct ahash_request	*rcv_hash;
> -	struct ahash_request	*snd_hash;
> +	u32			rcv_crc;
> +	u32			snd_crc;

Let's call it rcv_dgst (recv digest) and snd_dgst (send digest).
Other than that, looks good to me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

