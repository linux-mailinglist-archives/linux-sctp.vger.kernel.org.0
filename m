Return-Path: <linux-sctp+bounces-516-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED9AB8FDD
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 21:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9590450558A
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D58828C2C3;
	Thu, 15 May 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyMuVjVM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40165DDC1;
	Thu, 15 May 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336908; cv=none; b=Z91QuctkTyuh5dyy33w5M5UueZIJtWjBr3GwmxgaRhx7XaVjR2SaheTVzD3cMxjllBgraZVNeKYJ1zn+fXjJDDGFFg0RXI1MpIrkwR/Q19NfYslMvqDrBC7qpu6M+1NDFI/BBvyK0KVxyuxW/8nyGW9jDJQ/HBmprhDDkmH9El4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336908; c=relaxed/simple;
	bh=9Fovz36nZ5hdCxHe+hSpR4ZB5DBL38AjU+XU381hyz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uprcJJ74bW1yGfKLYXChrODJJF5iUv6lhelutYTLrW29+J1fBC/RtNPmpnbZpgOIQs7THApRWXMaFaOgbdfk66Owm44vI/DXofAuxWgiPybfHIfot2PeSIBateGH6+0F3vpdgGhlUdJSs8vFvmnmvVS9jpr1mKwXvFMr+BIU2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyMuVjVM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so1119450f8f.2;
        Thu, 15 May 2025 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747336904; x=1747941704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDgKha8Mvg0JAQ/SjGW3x+GqfdnE0RD9BNggcIcuKkc=;
        b=NyMuVjVM7caMZLMF5lgMPWARU/VrG3D7ddKMeBMhmOSOC1Xc05vzSFPrk+wACU9w64
         U0c9/R36iXeZrnZ3gInQJ6zAJ5va76cloNv/vGimMM7sFO7VonMylL9MTe0QSqvLT2OQ
         j9XsxdcLoRMLx75SnZmNZ79duiSqchqR9gRG4R61CLL+chQ9swuzn7k/qwpRymUqf2Zl
         ufW2pXYWgDBhny6sMzICCjXuUaD4Vv+y03CSasaC21O4LyzIF6hV4sgaczNIgCx/yit/
         LWvYYeI1baLu1TEZ02nUrTO0Qmcnlm39KSN8VUBkYVt9NsmLBYHfxaDHKNmfTpRHsO8V
         9Rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336904; x=1747941704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDgKha8Mvg0JAQ/SjGW3x+GqfdnE0RD9BNggcIcuKkc=;
        b=cdMOGE7SdywlKMLpGQsJoM7D1jKpBkqZAcdhcwc10JKPdob1sf74EaSAzRqxsWlQ2B
         QlrezEAsSwYCf27+XO/8G0rIKy1Hdi+AnKZ/r0/9McPelgCflsugrJ5P0zYgVqwBgg8/
         Rb4cElQwQSeTXcuv6Cf1p0MNwsr0WyRZwlA4ZZLzs9J07Qh2EImW5ZE/gAtgXYSg2x6s
         CTpBNjyodm0rVKyLtPUikVCUYZwU1MZGvjzt0J0qQ63Y3VKzvi1q2kdHeArvxVKrqbNd
         PKd/P6QJ4zuQKBaraynr7AAxo+tQ+mjLF92zJCGGVYq8G5fzFeEdMPQalHN8xFf/nc9Z
         1CSw==
X-Forwarded-Encrypted: i=1; AJvYcCU9SLNtytzlTLcDe6B6J5WwdXxfNJ5N1sRITPTiQ48bCRoyORP5YB+tvzE2z6z3arz+v4x+kYo8H+eB3oY=@vger.kernel.org, AJvYcCULao2lgvf7bySHvR+enuNRBkO9LfHbSlGzwx3MwU4amaUxoCsquxG/u29jHmX+/cMSGfu0C57U@vger.kernel.org, AJvYcCWVYKHDUi1Yhq9cYnJkJSRckQyDhgpnLevpggJnrkQoWNEXyejXRl+BgNJJPnhhqb59mlgGNJ0sM5gdfA==@vger.kernel.org, AJvYcCWiqgkfd/xtxiLXUgqJ9PogeCS0kR1HLFZ/0Jx2Jkmctg/rydZ+qmy/gVke98xzbUqYercNXuq1zNIK6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3RBRi0yPc0LntRr8IKAdkRTmmAlcov68h48pLj+x5ycPbKCa
	zAmtwu/WkLmVRT9yGqHEdNekuvGrslRFZZIXQ4JbMgpHZcbT3MluAQUgAa17Kg==
X-Gm-Gg: ASbGncuOMR123namNxO3wvL6hvLSwpTu2YuZjcjGK9Z2cEVJ95We9bM9dsqf0Agle7i
	FRTtP+zCMYoosc0Y4ydFY0C/wvgBOKC6UpG2b6K42jQ4f86JSBHZHWJaJ55MNBr7D4eGNy6bhD1
	+Qx6wHtyLU105GnTg2EtM+leTq0BmPw+9we2NecUHM/Lju1f7kam61z7zTppGz/m1d91vTxu5nd
	SWkFy4wesFo4PPxrEKt3gDywHdQdM+8oS7y+gixg9rUka+8d9JOG1YX16kI6FmzPV/H+cEZ0tUj
	bh1iIckJ+ec74craZf6gLgbnGto6O+5OZ/91sqI+QhhNbmi8v/TmnaqfnyAErMgpNk/3xrhy1b6
	IMe7eWPiNed273Q==
X-Google-Smtp-Source: AGHT+IEErv75ySz7SPIWQxReFuvVqrBn08S2Tj1lWQLN0bVqYJE1NAor3PrV0mVxMNg0j179PRXNjQ==
X-Received: by 2002:a05:6000:2af:b0:3a0:ad55:c9f2 with SMTP id ffacd0b85a97d-3a35c808d10mr1223950f8f.1.1747336904253;
        Thu, 15 May 2025 12:21:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583fb7sm6501185e9.32.2025.05.15.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:21:43 -0700 (PDT)
Date: Thu, 15 May 2025 20:21:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C
 computation
Message-ID: <20250515202136.32b4f456@pumpkin>
In-Reply-To: <20250511230750.GA87326@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
	<b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
	<20250511172929.GA1239@sol>
	<fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
	<CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
	<20250511230750.GA87326@sol>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 May 2025 16:07:50 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> On Sun, May 11, 2025 at 11:45:14PM +0200, Ard Biesheuvel wrote:
> > On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:  
> > >
> > > On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:  
> > > > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:  
> > > > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:  
> > > > > > Update networking code that computes the CRC32C of packets to just call
> > > > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > > > and simpler code.  
> > > > >
> > > > > Hi Eric
> > > > >
> > > > > Do you have some benchmarks for these changes?
> > > > >
> > > > >     Andrew  
> > > >
> > > > Do you want benchmarks that show that removing the indirect calls makes things
> > > > faster?  I think that should be fairly self-evident by now after dealing with
> > > > retpoline for years, but I can provide more details if you need them.  
> > >
> > > I was think more like iperf before/after? Show the CPU load has gone
> > > down without the bandwidth also going down.
> > >
> > > Eric Dumazet has a T-Shirt with a commit message on the back which
> > > increased network performance by X%. At the moment, there is nothing
> > > T-Shirt quotable here.
> > >  
> > 
> > I think that removing layers of redundant code to ultimately call the
> > same core CRC-32 implementation is a rather obvious win, especially
> > when indirect calls are involved. The diffstat speaks for itself, so
> > maybe you can print that on a T-shirt.  
> 
> Agreed with Ard.  I did try doing some SCTP benchmarks with iperf3 earlier, but
> they were very noisy and the CRC32C checksumming seemed to be lost in the noise.
> There probably are some tricks to running reliable networking benchmarks; I'm
> not a networking developer.  Regardless, this series is a clear win for the
> CRC32C code, both from a simplicity and performance perspective.  It also fixes
> the kconfig dependency issues.  That should be good enough, IMO.
> 
> In case it's helpful, here are some microbenchmarks of __skb_checksum (old) vs
> skb_crc32c (new):
> 
>     Linear sk_buffs
> 
>         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
>         ===============    =====================    =================
>                      64                       43                   18
>                    1420                      204                  161
>                   16384                     1735                 1642
> 
>     Nonlinear sk_buffs (even split between head and one fragment)
> 
>         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
>         ===============    =====================    =================
>                      64                      579                   22
>                    1420                     1506                  194
>                   16384                     4365                 1682
> 
> So 1420-byte linear buffers (roughly the most common case) is 21% faster,

1420 bytes is unlikely to be the most common case - at least for some users.
SCTP is message oriented so the checksum is over a 'user message'.
A non-uncommon use is carrying mobile network messages (eg SMS) over the IP
network (instead of TDM links).
In that case the maximum data chunk size (what is being checksummed) is limited
to not much over 256 bytes - and a lot of data chunks will be smaller.
The actual difficulty is getting multiple data chunks into a single ethernet
packet without adding significant delays.

But the changes definitely improve things.

	David


> but other cases range from 5% to 2500% faster.  This was on an AMD Zen 5 processor,
> where the kernel defaults to using IBRS instead of retpoline; I understand that
> an even larger improvement may be seen when retpoline is enabled.
> 
> But again this is just the CRC32C checksumming performance.  I'm not claiming
> measurable improvements to overall SCTP (or NVME-TLS) latency or throughput,
> though it's possible that there are.
> 
> - Eric
> 


