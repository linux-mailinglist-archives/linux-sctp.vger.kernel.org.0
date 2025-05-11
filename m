Return-Path: <linux-sctp+bounces-506-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740DAB2C30
	for <lists+linux-sctp@lfdr.de>; Mon, 12 May 2025 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D61894052
	for <lists+linux-sctp@lfdr.de>; Sun, 11 May 2025 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E72609D7;
	Sun, 11 May 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3CfWdaU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6BA188A0E;
	Sun, 11 May 2025 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747004879; cv=none; b=hcdr/zNt+dGW698MyTTagIrCjrAbwd/CAvc0r1T49SbXT2zCO1fmU9237VPZF0ktmfeXqSWczp7Vgc03uiAPKn/VYp+WnED/2VpUbUCGakg2jGpJLjfQ22ZMO1kDxjaiWoo9gnUMd4L0JuB92Oe4AahPVLdiEJu+OYG6v/5i+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747004879; c=relaxed/simple;
	bh=fiuu/FAQbicG4pdW+3WAgdDwC1anxMimVItK7oW/vC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr+i5hV4I3cLyoGDmfG+vMMIZjQExuMaaA3hr5ygyI0I+GanZ6NRSl623EOWT2HYhTrxf31NBWywJh/vwjHFrZ3j3w2lhuaZGAy++iqgxHnmerAwF7P+FwQZUzvkX0k4dgqsr5dHJpm/UZPKonp7in4ePign2LHws0mBWO3EmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3CfWdaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DECFC4CEE4;
	Sun, 11 May 2025 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747004878;
	bh=fiuu/FAQbicG4pdW+3WAgdDwC1anxMimVItK7oW/vC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3CfWdaUa/SHoDzg4TcXAnERwVXpypQXogaXwYM5lOY2y39H91goJLk96QHhbLGkp
	 ljSDBxeGI49fJId8Tw+agR7ZDo5WPjA3EmU2ojOPkmx4/f5fVSv7CzFtsh3Jf4hCET
	 sgGOwE8+iAAQZ9Sk5szx0OhOcUIzZASVN8qoEoiVhvWF2MJYOEPq0z4c1o1UwzRtJs
	 zk/ddWU7qDv6eR1dvd4m9IReHzL6ioABxXB8wpR3Wck6/eeGXf7rQnOVoMfYtVL/QG
	 woW1DAsjjbS9dpYQLhQO/TZKQAXuRmUUTLAiR215LAELHXL/6DbcXX7XykTsY2K0b9
	 lfi34PmvbTiwQ==
Date: Sun, 11 May 2025 16:07:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250511230750.GA87326@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol>
 <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
 <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>

On Sun, May 11, 2025 at 11:45:14PM +0200, Ard Biesheuvel wrote:
> On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:
> > > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> > > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > > > > Update networking code that computes the CRC32C of packets to just call
> > > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > > and simpler code.
> > > >
> > > > Hi Eric
> > > >
> > > > Do you have some benchmarks for these changes?
> > > >
> > > >     Andrew
> > >
> > > Do you want benchmarks that show that removing the indirect calls makes things
> > > faster?  I think that should be fairly self-evident by now after dealing with
> > > retpoline for years, but I can provide more details if you need them.
> >
> > I was think more like iperf before/after? Show the CPU load has gone
> > down without the bandwidth also going down.
> >
> > Eric Dumazet has a T-Shirt with a commit message on the back which
> > increased network performance by X%. At the moment, there is nothing
> > T-Shirt quotable here.
> >
> 
> I think that removing layers of redundant code to ultimately call the
> same core CRC-32 implementation is a rather obvious win, especially
> when indirect calls are involved. The diffstat speaks for itself, so
> maybe you can print that on a T-shirt.

Agreed with Ard.  I did try doing some SCTP benchmarks with iperf3 earlier, but
they were very noisy and the CRC32C checksumming seemed to be lost in the noise.
There probably are some tricks to running reliable networking benchmarks; I'm
not a networking developer.  Regardless, this series is a clear win for the
CRC32C code, both from a simplicity and performance perspective.  It also fixes
the kconfig dependency issues.  That should be good enough, IMO.

In case it's helpful, here are some microbenchmarks of __skb_checksum (old) vs
skb_crc32c (new):

    Linear sk_buffs

        Length in bytes    __skb_checksum cycles    skb_crc32c cycles
        ===============    =====================    =================
                     64                       43                   18
                   1420                      204                  161
                  16384                     1735                 1642

    Nonlinear sk_buffs (even split between head and one fragment)

        Length in bytes    __skb_checksum cycles    skb_crc32c cycles
        ===============    =====================    =================
                     64                      579                   22
                   1420                     1506                  194
                  16384                     4365                 1682

So 1420-byte linear buffers (roughly the most common case) is 21% faster, but
other cases range from 5% to 2500% faster.  This was on an AMD Zen 5 processor,
where the kernel defaults to using IBRS instead of retpoline; I understand that
an even larger improvement may be seen when retpoline is enabled.

But again this is just the CRC32C checksumming performance.  I'm not claiming
measurable improvements to overall SCTP (or NVME-TLS) latency or throughput,
though it's possible that there are.

- Eric

