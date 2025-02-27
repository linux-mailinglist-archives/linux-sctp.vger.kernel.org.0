Return-Path: <linux-sctp+bounces-366-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A12A478B6
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 10:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396583AFDC9
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B8226D06;
	Thu, 27 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZgyLCW7"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B82E1EB5F3;
	Thu, 27 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647342; cv=none; b=o1pHv6xB/jXWo+Y4sqXEKe0IRYGrtjvOu2yrN+sRlsTOFEQQyI6Ui6aTcvebJABwSMznolSzI4CFzoPPZ12JFbiFcs3C35R8O0CarUXZ5WE6/xMO9KW2mO3m7GRnPJiHmJo9pbhmSf3ik4pk6LC+sUIUvlq78WY9cYGSDkx9Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647342; c=relaxed/simple;
	bh=jVHp5b+f8Y6KpzJR7YUoxdZIpETxeOJJOXSWOkHqVBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L87XPWMsDi8TnW1x1guyzXBU3Ax9lyQ0ibz/2519x9GsxNhqiSy1LVN7z15z8AHEKL1UervZf/dcHOXuabXROG7IY8p29kBeBKGPmdXHMjdhreEIFx1PcscAT88O6EuvwmWgkYOc3Ync1twBcK6SaqZd+atRK3ojdS6qmjrPvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZgyLCW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7F2C4CEDD;
	Thu, 27 Feb 2025 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740647341;
	bh=jVHp5b+f8Y6KpzJR7YUoxdZIpETxeOJJOXSWOkHqVBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AZgyLCW7nkAb14L4flqHGiS153ZvrP0JT6q3c8W2XILS3/jweXLQQPWbG4DauGUOJ
	 6yX6EmQ0TfMYal4vgQYuhA7PlfMHWTljns4A8f4TGgJb6Bqc4DpYVMxTRLtsiZhfup
	 SwoJiwVPdTe3HYMIplkvHANLtEluZt1YYJUHBNoLjKuUGJBYTyiwTypdVdh0G05Z4n
	 mEwUo2Oq6S3UWLx0odtMkv9H8gLqXU4bm7pRIsXgez6KD3TIbA0pdDZGESW3/i3Gnt
	 71vNDIT2uDS8qxm99OkhGqrXciU2EkIGzOflZ3XFf+Yw3pLsIbBOksVS+Yh8P/oZ5F
	 rAyBHvnSpEz1w==
Message-ID: <61415314eec15410e42d31fd6d1a8411a937e747.camel@kernel.org>
Subject: Re: [PATCH net-next 1/4] sock: add sock_kmemdup helper
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, linux-sctp@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Mat Martineau <martineau@kernel.org>, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Date: Thu, 27 Feb 2025 17:05:54 +0800
In-Reply-To: <773003d9-bbee-4941-a3e7-3590ea80bdb2@kernel.org>
References: <cover.1740643844.git.tanggeliang@kylinos.cn>
	 <a26c04cba801be45ce01a41b6a14a871246177c5.1740643844.git.tanggeliang@kylinos.cn>
	 <773003d9-bbee-4941-a3e7-3590ea80bdb2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-02-27 at 09:45 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 27/02/2025 09:23, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds the sock version of kmemdup() helper, named
> > sock_kmemdup(),
> > to duplicate the input "src" memory block using the socket's option
> > memory
> > buffer.
> 
> Thank you for suggesting this series.
> 
> (...)
> 
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 5ac445f8244b..95e81d24f4cc 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2819,6 +2819,21 @@ void *sock_kmalloc(struct sock *sk, int
> > size, gfp_t priority)
> >  }
> >  EXPORT_SYMBOL(sock_kmalloc);
> >  
> > +/*
> > + * Duplicate the input "src" memory block using the socket's
> > + * option memory buffer.
> > + */
> > +void *sock_kmemdup(struct sock *sk, const void *src,
> > +		   int size, gfp_t priority)
> > +{
> > +	void *mem;
> > +
> > +	mem = sock_kmalloc(sk, size, priority);
> > +	if (mem)
> > +		memcpy(mem, src, size);
> > +	return mem;
> > +}
> 
> 
> I think you will need to add an EXPORT_SYMBOL() here, if you plan to
> use
> it in SCTP which can be compiled as a module.

Yes, indeed. I'll add this in v2.

Thanks,
-Geliang

> 
> Cheers,
> Matt


