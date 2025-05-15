Return-Path: <linux-sctp+bounces-517-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47BAB9020
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF141BC374D
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE9A22D4C6;
	Thu, 15 May 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJCeGa03"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF31E480;
	Thu, 15 May 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338654; cv=none; b=dyHZ6rxPIzV3CkF4azKztPEU4/GBROZnidIDPgLwHH6Wd88IXdUXjIf2osYxUYQhcT4B/lNWQd9FAU+rMhx4u6vrKT+YbOl2onZFfb5l4zPAyX5y+1JFI9LxBCNc1CyDv6AxLXdIewgfteIQNvpW4JfkepPg9k3cIoN/ED6DDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338654; c=relaxed/simple;
	bh=kgfQ2FYbZjCZ/XYEQ8hsCXz1xRoSlsf5qPC9Zb25Quc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB6DPDEaRmxv1gHNBVmNgKiKbgJvow/ADPzsQKoEHfe3OsfmTTzLQf+9BSq440MVd+T3KCD18pqnAeh1gXNcDn1e47ssenUxMlT1dYgGp/fINW/1SfPqrUoRNvuzamDW+8UnuZiQx82Vrhp2Iq0q0vB/fl5eqffJKSnCesIAGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJCeGa03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066A2C4CEE7;
	Thu, 15 May 2025 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747338653;
	bh=kgfQ2FYbZjCZ/XYEQ8hsCXz1xRoSlsf5qPC9Zb25Quc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJCeGa03u+MXVXzYiYmzNrtGorUIgN+I8l+9BnFinR/vITYyXYIubK5Kngc0mb38l
	 7GNSrffkIG/TzhCgqLFYv5nlsDsXaQc4b6yI1esbaZRMFOnIqCxAqc3DsIlWvVdU4C
	 nUcD/bbgcll5ZALu3MLXl7eyzrBoiR5qUjU1zViVAiKDw9BAE0Qoigj0EE3YDuiLH5
	 rrhJnpvHfZcIBqZfWx0Eu1MTWmrC/UreYIh2/fwLkbrjsXurvvPL97ePeT6cs91MvV
	 X0N/2CNlUnuuZcAYnss/gPnJULUCnANZuEIGJq2ysIQj0uct/g8D4OGqFFcbxzCYpY
	 aeiWvnpn9MUoA==
Date: Thu, 15 May 2025 12:50:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250515195051.GK1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol>
 <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
 <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
 <20250511230750.GA87326@sol>
 <20250515202136.32b4f456@pumpkin>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515202136.32b4f456@pumpkin>

On Thu, May 15, 2025 at 08:21:36PM +0100, David Laight wrote:
> On Sun, 11 May 2025 16:07:50 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > On Sun, May 11, 2025 at 11:45:14PM +0200, Ard Biesheuvel wrote:
> > > On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:  
> > > >
> > > > On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:  
> > > > > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:  
> > > > > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:  
> > > > > > > Update networking code that computes the CRC32C of packets to just call
> > > > > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > > > > and simpler code.  
> > > > > >
> > > > > > Hi Eric
> > > > > >
> > > > > > Do you have some benchmarks for these changes?
> > > > > >
> > > > > >     Andrew  
> > > > >
> > > > > Do you want benchmarks that show that removing the indirect calls makes things
> > > > > faster?  I think that should be fairly self-evident by now after dealing with
> > > > > retpoline for years, but I can provide more details if you need them.  
> > > >
> > > > I was think more like iperf before/after? Show the CPU load has gone
> > > > down without the bandwidth also going down.
> > > >
> > > > Eric Dumazet has a T-Shirt with a commit message on the back which
> > > > increased network performance by X%. At the moment, there is nothing
> > > > T-Shirt quotable here.
> > > >  
> > > 
> > > I think that removing layers of redundant code to ultimately call the
> > > same core CRC-32 implementation is a rather obvious win, especially
> > > when indirect calls are involved. The diffstat speaks for itself, so
> > > maybe you can print that on a T-shirt.  
> > 
> > Agreed with Ard.  I did try doing some SCTP benchmarks with iperf3 earlier, but
> > they were very noisy and the CRC32C checksumming seemed to be lost in the noise.
> > There probably are some tricks to running reliable networking benchmarks; I'm
> > not a networking developer.  Regardless, this series is a clear win for the
> > CRC32C code, both from a simplicity and performance perspective.  It also fixes
> > the kconfig dependency issues.  That should be good enough, IMO.
> > 
> > In case it's helpful, here are some microbenchmarks of __skb_checksum (old) vs
> > skb_crc32c (new):
> > 
> >     Linear sk_buffs
> > 
> >         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
> >         ===============    =====================    =================
> >                      64                       43                   18
> >                    1420                      204                  161
> >                   16384                     1735                 1642
> > 
> >     Nonlinear sk_buffs (even split between head and one fragment)
> > 
> >         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
> >         ===============    =====================    =================
> >                      64                      579                   22
> >                    1420                     1506                  194
> >                   16384                     4365                 1682
> > 
> > So 1420-byte linear buffers (roughly the most common case) is 21% faster,
> 
> 1420 bytes is unlikely to be the most common case - at least for some users.
> SCTP is message oriented so the checksum is over a 'user message'.
> A non-uncommon use is carrying mobile network messages (eg SMS) over the IP
> network (instead of TDM links).
> In that case the maximum data chunk size (what is being checksummed) is limited
> to not much over 256 bytes - and a lot of data chunks will be smaller.
> The actual difficulty is getting multiple data chunks into a single ethernet
> packet without adding significant delays.
> 
> But the changes definitely improve things.

Interesting.  Of course, the data I gave shows that the proportional performance
increase is even greater on short packets than long ones.  I'll include those
tables when I resend the patchset and add a row for 256 bytes too.

- Eric

