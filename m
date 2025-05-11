Return-Path: <linux-sctp+bounces-505-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D1AB2BAC
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 23:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D31D1892DD4
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 21:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E613635E;
	Sun, 11 May 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/ZRTasQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F054C8E;
	Sun, 11 May 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746999928; cv=none; b=Cqx9UIVGQc9G1vw94vfuQB8rX+bzON1+Dq6wOstN/pyzjjAA1LA79XkITA1Byju4hncywaYkqCVZY+TDJrDyP3xHOWEZXnQ+wkZKAfthOGTd6AkmdPfPDetvUhLDtRmbAi5dAjION4fERQS6JFJnOsJxLcreDROE7khrTDYpO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746999928; c=relaxed/simple;
	bh=n6VR74UUrkjd7Li7mn4MUpvTWHM+Fg3QJMysU96a2vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCH9LK0VW9ovaKYGDDHf0Sg+KDNVRkkamWzIFymbfK0E/YHGir7mRzZJMJ6TLMr+g6tJlHxBvOOQtJosnc+f2Q3ao0she9Z9zdYF5qESIdDqU12x76uVg0R/IZC8tc/kJzRAw9y+sGNZA8SvVu3Nq6cXJW5SedBmY4NrtPQ/X2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/ZRTasQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD08C4CEEF;
	Sun, 11 May 2025 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746999927;
	bh=n6VR74UUrkjd7Li7mn4MUpvTWHM+Fg3QJMysU96a2vU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D/ZRTasQquFXwKbPNKCYUM1NIuMwA6+YLiybYZawOMprx3ipPqVo6VWG2Ilfj52GF
	 Rr5XraDpe8fZyBTv3Noz21dBSrlpDmrQZd91yutike+MoWlDi4GxDIv2dKHWnYdlVC
	 4c8AsLyPsmHKuooiYd6PEd0mzGIo6qyWt/zFztGM79ib+cL5O6LqOvQvD/DKNUjVFn
	 O9smap/BiePuv1E1/pL7tAOcu/ws2OzMultORce4EgQ5aKaVfJAbjxOHtllEn/sDyH
	 RgYUbhjQsNpGB2FtShM4/G31GhUKnPZ+bTkBXxWFZs2TxVPOobN1ecSLXQodU+TONE
	 AV+k1my09wI0Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-326cf24aa35so21928681fa.2;
        Sun, 11 May 2025 14:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU47SderBtHetOpksGFVN2j3yXIO5OANDpBr1Lk0a/EUvaLo1xwLxCGy2cKEOvRpxHSRFbhmZI0tifBRXs=@vger.kernel.org, AJvYcCUqwqHwWXYyvkwXNHHhTF/bxO3aHGecFZ/yXNg+al4WQbGYOOjBZuSF58x8jRxSn03/BN4YPJrS@vger.kernel.org, AJvYcCV9EOJGZqASWbQUWSUYrCK+luli4m6K1AVTbn2WI+Vo9LL7MNJae8N7i8+E3xPDAEsazW9jZonjolmzIA==@vger.kernel.org, AJvYcCWVVMYMaCrdSV3FaH3lYEknB1lzyjCBtNpeuOpdY2IpA1ELbGROeVdh5/lzXda02Ds296WKWerj2itBdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeeDQwubM/y765nCocp4U80oZatKscfB/QAcZ9KJTMDnYTf2KX
	PHKi6L/PCnBPssDK9OQlVjQ6t0Pqo1VY6RYs6qw94oThr3j+ugQp5MrJOlwEJwDV71LkooFrErA
	wSbt4GZULfanWR9tHzOAbbgdaOCc=
X-Google-Smtp-Source: AGHT+IGXAKwBmsQgT+onQCTrcyVQm05O0hzEhnj9ZJ3lSI582XXe3FX+xmXCeVd+5a8Bm7iJP57f+ZUkw11acThSHag=
X-Received: by 2002:a2e:bc08:0:b0:31e:261a:f3e2 with SMTP id
 38308e7fff4ca-326c459db3amr41790571fa.1.1746999925705; Sun, 11 May 2025
 14:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511004110.145171-1-ebiggers@kernel.org> <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol> <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
In-Reply-To: <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 11 May 2025 23:45:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
X-Gm-Features: AX0GCFsoD-9jiD_NH_ReLAgqqMRiIecG31oMhtVBxXbocF6ZydM3nWnbvTXpTTA
Message-ID: <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:
> > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > > > Update networking code that computes the CRC32C of packets to just call
> > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > and simpler code.
> > >
> > > Hi Eric
> > >
> > > Do you have some benchmarks for these changes?
> > >
> > >     Andrew
> >
> > Do you want benchmarks that show that removing the indirect calls makes things
> > faster?  I think that should be fairly self-evident by now after dealing with
> > retpoline for years, but I can provide more details if you need them.
>
> I was think more like iperf before/after? Show the CPU load has gone
> down without the bandwidth also going down.
>
> Eric Dumazet has a T-Shirt with a commit message on the back which
> increased network performance by X%. At the moment, there is nothing
> T-Shirt quotable here.
>

I think that removing layers of redundant code to ultimately call the
same core CRC-32 implementation is a rather obvious win, especially
when indirect calls are involved. The diffstat speaks for itself, so
maybe you can print that on a T-shirt.

