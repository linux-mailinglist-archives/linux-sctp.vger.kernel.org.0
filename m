Return-Path: <linux-sctp+bounces-267-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFF9933B2
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Oct 2024 18:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242F2B23A60
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Oct 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F5E1DC19B;
	Mon,  7 Oct 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EenQEB6M"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9251DBB34;
	Mon,  7 Oct 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319554; cv=none; b=DXpfF1C1xqlqIjrS3R1nOG4AxsCOBf17ZRaSyLULrMQ1Ljau7WxFsKYWVdvMuTVfGb3ebauXOwKazfV/kJSNUwuu7Uzs4dHLBTi2sTdMib5clhbzRyNP7DNAV7wlexR4E1eecSa34G28trovTP0ywPtVYe8tnY1vRYP+DmITPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319554; c=relaxed/simple;
	bh=BgAzXsnEEKRQwvitKyWjU1l0Wgx9Sd96kF1zD5WHkgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/r99tEx6G4rLL4ZOgVlipsoVbNS+HmJT89bYvDWptdaG2OG4iM+2dHMxlm6lu+vO8A7xY7BS97QAEaMDsxgUiHRcyLYll2mi2KHsb8CfHhvbWo/fKBuxDNorQgkjYsH52YM7Icou72VAmzXjxSeU4Hmy6oKO1rAmt83HUOtTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EenQEB6M; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b7eb9e81eso55260415ad.2;
        Mon, 07 Oct 2024 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728319552; x=1728924352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IeYmUVwBVxlwmPjj95IXb679B79KuiflhfALQvPJY0w=;
        b=EenQEB6M7waCDQaepUF+kRyWLBPaYQa6Nl0troIR13DcCgLEOSZPaJYAXlbbU1y2nz
         BZuboYuVzAseB0Rc7lDj6CiagInRUO2KnaIejZJWDb3nkIHcWoo1mKXe1baiAMNaLj+x
         cny+hVZpxN2dS9IPcj4VuXRqC0oNEChtkWFktCJY7rlMIG0ywe7RHh/6x7TA6oYZUGRO
         5XJcE0gIYEkrgC8oWlr0vCJB3DhI/tQGTPdVz5dT4QTQPFj9DMpJM96EByEUw/CID7VW
         n9m/hfxZcQ496aMEmamYppedHXlfWrc4VwzxoQh4e6ega+uDCuqmDcISqOEEcWc3rJj1
         XCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319552; x=1728924352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeYmUVwBVxlwmPjj95IXb679B79KuiflhfALQvPJY0w=;
        b=DHsBwpnwUsKRXGp3IOAkTfkZzIySr3DC8bMkYX6R7rOZ+AKfHpTcgrS+WJo06GouNF
         pdlmQWQQcxc++t4jxnBsqgfEPdF10uyzv+xjyS+qx/G1JC9mpKo5OJkggPv6HoIo9QIr
         7MVAXwYNyDvtP8yOpmZxy0sTeRHYpZpQ4SRPipjv8NW9bshUjl1s30gPAHFI5bUj6sZP
         /YMNPhxz2HhUU2fT284Qcj597ldv1dqSsKZNGGQ30oKidb6DX12GGWcqgZLSC82cPWjF
         +MzS18yzPYwcRTx+hQ1dY05k/JGIx/mcvClixwAVVAeAQUT6hO5VtTZInzVftzkUTUWW
         jDmA==
X-Forwarded-Encrypted: i=1; AJvYcCW3XA8h9zK/n4zOx3h2Zq5v0r3Igp9SdycHPne1tDahETfA4tF6FBCEhKopZL6tRSjwfuLQ/7hJk9rw@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJfygsW+pdDR/EyLLHhVo4XsVLk6DYJ0c5QcigOeAkSJf7Sag
	PXhmVTUCeXLH8CWeztxmWaWEaQ+harizYTONPaVTWwiY/gkXr8as
X-Google-Smtp-Source: AGHT+IHbYaF0bngQYW38GSyYBpToTikA6ZSqcC2WBGhfSqoljmzKr24s6S0jfMtmhTiQQ2wbMICUjw==
X-Received: by 2002:a05:6a21:e8d:b0:1c4:f0e0:9ec with SMTP id adf61e73a8af0-1d6dfa3babbmr18346762637.20.1728319551719;
        Mon, 07 Oct 2024 09:45:51 -0700 (PDT)
Received: from t14s.localdomain ([177.37.172.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9a6sm4607276b3a.28.2024.10.07.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:45:51 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id D5B4BD2E48D; Mon,  7 Oct 2024 13:45:48 -0300 (-03)
Date: Mon, 7 Oct 2024 13:45:48 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] sctp: ensure sk_state is set to CLOSED if hashing
 fails in sctp_listen_start
Message-ID: <ZwQQPIzvln5sLYIt@t14s.localdomain>
References: <43b03d2daa303fee1995f6b16f5003a1fc0599bf.1728318311.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b03d2daa303fee1995f6b16f5003a1fc0599bf.1728318311.git.lucien.xin@gmail.com>

On Mon, Oct 07, 2024 at 12:25:11PM -0400, Xin Long wrote:
> If hashing fails in sctp_listen_start(), the socket remains in the
> LISTENING state, even though it was not added to the hash table.
> This can lead to a scenario where a socket appears to be listening
> without actually being accessible.
> 
> This patch ensures that if the hashing operation fails, the sk_state
> is set back to CLOSED before returning an error.
> 
> Note that there is no need to undo the autobind operation if hashing
> fails, as the bind port can still be used for next listen() call on
> the same socket.
> 
> Fixes: 76c6d988aeb3 ("sctp: add sock_reuseport for the sock in __sctp_hash_endpoint")
> Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

