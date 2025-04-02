Return-Path: <linux-sctp+bounces-471-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9395A79761
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 23:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2774918936E6
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29742A87;
	Wed,  2 Apr 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HUJxQwEw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71871EF08D
	for <linux-sctp@vger.kernel.org>; Wed,  2 Apr 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628443; cv=none; b=N2C6MjS87P/Fb/edaYTas9/CfUcI/RLfD6d0g4dTbi29cgHhyykYkfzYncvOG2QIjVIEG2+VhRfZvfonZee3Jqnb/sBEWSakuelXgk0gT6HjVFcQvN3XXCIA2D1MmEBpkMx2k7VOzjNIEBBzaWyKQR2c8CKBJpsCERtJ8BDCZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628443; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+goR0jP9D7esRSQvRpx2D78kw9N+GyQz2Zbe1HZSBA6VLigWsllUVGL2Rvfrw4KS84IENgghaxhR2DtmZuD80t5IqcjCgpdMrqrL3y5bnpXxL/Nw5WXpcfcQGXFmv6pRnpndp8kIpPADnuocuNwK8xJjKdI3p33ppRgBzY8vmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HUJxQwEw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bfcd2a70so29875166b.0
        for <linux-sctp@vger.kernel.org>; Wed, 02 Apr 2025 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628440; x=1744233240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=HUJxQwEwhK3ax9VRk2S0NT43QbeqpdeOIjh9g6AAA1POXtbR4vThMQwYZIlBGRNK7X
         9wSyPM4fZaHOWcimE0AFxoLe18mVC4k3O3klHL1csvfl0gW6SitQYyWYQZYbdh4OULzg
         Dtq1EH5QpFC3lrqyS8pWh77KSb7HYg8XJ80bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628440; x=1744233240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=LA+a03leXdW1cFdkk4essMvd3jFMivKnjuUZGAtDwATCWTJXY1PDPokCge3kiNZkyF
         X7sUNwh0ZdH7Cr7CyC2j5tAdb+ZFWASFYk+417jOCkmcip5GlllIfRcUQ6xfqIZ/N1lq
         6+cKe+0o9ty/CnehWOf+XK20XTRL43mAnDdELpmlaFOX8BJRB5+Bm5ujM6zU9wOQdjld
         cGRq2sYH9Zp7YSrH0oZZ2+sPtF15jgwqdRuIEQJv8Em0aGpWXcGeRTqeCTwI6GmRaLvB
         es0haMvXnNFW1JKirA9ZB/7NBV6mHu3ENFHzEtUk9CrajSirMOkWv8O/l6fCgeEpiK0y
         X2ig==
X-Forwarded-Encrypted: i=1; AJvYcCX7SH+gJzR3uVc3g9B5ocJUOHV45R1ndXR7VXC0jWaVJe3FPQQeb1N6/EUItK0LQrCYwPKLpuUrWqDS@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvtbPxV7ilI9LJrKUfGkM8hDN9xeBTU0ktHhipELKR93Ad61A
	42O88u7lQWaqrkrdqMw4mAnsM3nTIjexY6Uj75iMis9vIknRn9QY+3jiwmI9o/HJuH/8MAyC3V/
	VWnbqEw==
X-Gm-Gg: ASbGncu7/kPxBtQvdn8I+aVC0m9Sn0nOBY+7qGsII2Hzo0lw8yMKh0IPcghm9tpPipc
	lhSN4N91nj9eqRBUv2Fazw6gK4y+ZGr3i55qEQgpC169vXoMfKtDMsxkReRxZ/xSK3iQHTV0GKM
	xDTsEIqCSl8u1IEq2Oyf5fpGAHutMMP+HA97WtpiuwIvS7+D6X3wlgFB5gpu5A+d4dgRq1oR0Iw
	kdV3+kQTJPuA718/Oz0wuJDu9D54p0YwglWx7uPTAfSsJFib40Dc0EY+27f05wYDQMtbuf4ua+t
	9zOg6V2MRvzyWHRG+9xUJ5J3yWTvo2MDpGaAOe9PULm4te555ATIaZ4nwDcBBLvzd76fjwJK8dM
	UgpnNeGk6616gYztkjPE=
X-Google-Smtp-Source: AGHT+IETyBuCSBupUBt5a1D0EhmrrlKz8EkcG9kpQmFk8KvvZeyYZiJ6Q/vSRx9kOqQOK3fFPBGdUQ==
X-Received: by 2002:a17:907:2d8a:b0:ac3:45c0:6d08 with SMTP id a640c23a62f3a-ac7bbd1a0b6mr20854566b.0.1743628439796;
        Wed, 02 Apr 2025 14:13:59 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b742sm985370566b.65.2025.04.02.14.13.59
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:13:59 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso337670a12.2
        for <linux-sctp@vger.kernel.org>; Wed, 02 Apr 2025 14:13:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSeG52suHJKemb29QRd2SmRcII35h1BgFGTJCsXKooQZDgb1BFqWqiTpSE0Ss+NdheVx+9C6KL3YQx@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus

