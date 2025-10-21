Return-Path: <linux-sctp+bounces-643-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95200BF6D7F
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5446340051B
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4B31DDAE;
	Tue, 21 Oct 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qco9XJSn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2128643A
	for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054145; cv=none; b=ArjA21oymkHtAT2zSmqn5scyReZSbhi+ORvvGubWhmuN8UojONqTxQWGbtc989xRocFln+OBkyQqH0rOQX354L4xE6YDcIHVcC9XSadx+v9BPPtdonz8ZVGPkjp4XKKfgw4BD1k7vlvehG1A91aGdzcIbmPGiN5QF+UHgxzG6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054145; c=relaxed/simple;
	bh=bxHGLz+xlJewzMmRFIuIR23gQThD28fVSG7QUjGyY9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsZwkDdO2f1jvrvDOhlLUkfq8HPX73ScDwSuJuJqw+51NlPxrd6JiRcyNz5FvBbcPafLNfwKODnd0UopcJbJRMzWN/TtKnuz86KGKsJTMnVz/1yaHajD0qmGY9yZVr40h0aoBHZ1P2jySaEfjTiJ5gu1vF1fU/d05mWeJrjJxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qco9XJSn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3545257b3a.2
        for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054143; x=1761658943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgZPMxLu6X9wz+t1vCeUGO6rtKpKjgYYhFE+lvxINzo=;
        b=Qco9XJSn8o7aI7jdnej999Q66H4OF/VjuIKBTfCudYuafg1UVi1nseppeUfwH4ea1d
         Z2PPyBMozXJYzWqvNU4l0rULNb3p/5uCHR8Gp3vMbB3bcbFIwEzh3i1uen4r5Yp6lNC1
         n6F2gLb5kBy2K69Td+Y/5YJhsMX3JXhlTmmwMP3q3jd0Qz3MqMwLc9O+G5zm9P2FHRpZ
         +BuQSYEQeGs4VZb32Xu7d5yDMlSpQ8CQ+iTaQ2d3xkjToyqRtCJrELpHl0CFNImyY+Lg
         o49fjDhsO9Deed8OOfsouuVjvq2JnrijkquNucDx5HGx1gSUGPQ+c1KiRCGkR+c5F81x
         RcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054143; x=1761658943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgZPMxLu6X9wz+t1vCeUGO6rtKpKjgYYhFE+lvxINzo=;
        b=qwpX79vjEk0LJ3S7TSdMQs2mp6FhHzD0zaV6qWMuIkjyACT8oL6Ym9Cs211Ax1Lyvf
         /qveo9fxj9G1YXyNPXELai2D3/ICThVWpLzQr4jdCTzbXVFZok4JA7x/bEveYo9jHIb8
         184k1T/xCcNz5H3lcjGvtQ/eNXAxMDIC0Xr8AOM9hUNhyP+QO1vT3DlRc/j+EZhFEVc7
         /cbPV3h46ZPKt82ySMJyvI/CMpYgMl5ms5izfqKtFw70vcWaOP/mvDjYghTaPtBAJYx2
         fLO5mc1El8Tu1l15Q8bESUEi1mvBFEuypzg591sOrJimdqlwfJUQ6X0xAQvo1P2H32x6
         VdCg==
X-Forwarded-Encrypted: i=1; AJvYcCUZJODEfJFtP4nz0z1aA168IjySFLNzDXOFUBTmLFDq+9Ml25FveNurJEKZQUT428kHON5cnIQJbpHt@vger.kernel.org
X-Gm-Message-State: AOJu0YyHujEaV7srpDtMuf2X7jt0l0JCLPPZqpMQ6qm1SdfJOTRWTM/n
	b6LLAZSFGqBzNfGnBUkH4JVODtgGxUEn35wZKM3xT4UenC1GI7KwQlcK
X-Gm-Gg: ASbGncvLbHugdSWv5LKtmfTJ4kIPmj/D3jua3tI0EK98Hp1oa2tXfo3ELmADuLR6QUt
	QBEypb/P8WOK4XAedq4F25ZjIUYeSdzJZQRpJtNy5LfaM3leYsNgATIVKq8SwVmqk+CSWcnQROd
	nil9isUP9+m5kWXeMkALsZ3cLUVs0EI13U9FON8HzzPqB/rvbxmbrcFAhk/QOwPVj+OjZkGUija
	ZX7FweCj7uh5OcODMex/nIe4r7AK6smQX7mtz3QBITztlxBrqBm/C11kLHZTOjQkwvteveIq/xg
	xp5V81zVm5lscT/5QLwfs+iblH/o/o88EW129B2ZLDEZsK7RW3NYxNIvNLvN9bsXPD2ou7udORF
	0PRNW7+/ApZGslWgWocV3d6tQTZ650Ii75qdbWFPK+ypFkALOHzX8fhaEGnVE5q93kqZKuGOVf7
	ZTX6qqSd2iFFgfakWKfG5+e2hRhKVr
X-Google-Smtp-Source: AGHT+IEtBrPuQQUxw2bft59BW11T/7eOEgF3RMVKZ3jPGBy5mT6+NnW6S4WaVnFWlQfeAnAVDZwRzA==
X-Received: by 2002:a05:6a21:6daa:b0:32d:b924:ed87 with SMTP id adf61e73a8af0-334a854ac50mr21383426637.20.1761054142909;
        Tue, 21 Oct 2025 06:42:22 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537:573a:39d:6287:7ddf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e211sm11306341b3a.62.2025.10.21.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:42:22 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 60D4711CF92D; Tue, 21 Oct 2025 10:42:19 -0300 (-03)
Date: Tue, 21 Oct 2025 10:42:19 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 net] sctp: avoid NULL dereference when chunk data
 buffer is missing
Message-ID: <aPeNu7-COwBQS21U@t14s.localdomain>
References: <20251021130034.6333-1-bigalex934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021130034.6333-1-bigalex934@gmail.com>

On Tue, Oct 21, 2025 at 04:00:36PM +0300, Alexey Simakov wrote:
> chunk->skb pointer is dereferenced in the if-block where it's supposed
> to be NULL only.
> 
> chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
> instead and do it just before replacing chunk->skb. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Thx.

