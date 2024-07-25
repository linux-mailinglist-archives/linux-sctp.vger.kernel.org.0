Return-Path: <linux-sctp+bounces-180-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1DD93C96A
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2024 22:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EC31F228BD
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jul 2024 20:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAFE47A5C;
	Thu, 25 Jul 2024 20:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D010/r2A"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A33224
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jul 2024 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938666; cv=none; b=tbzsf+aZR7f9ESWc3qIEdkWjUN5P7hkuUA5u31SWFWnQ+vxcngNQtG35s8HOuJIKvvUFmXlGq4MfXJ1D73IQrb8aF1ahYTTY0EAu7Kc1qnT9cNrawOWkgGZmIpz3g67hWkbYMDMqEPgANBhLnnUGV5efZlJXA2zUULF2BwUhpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938666; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0ryFAIj43kzqpeQDdUIgBvRflRS3wG8q2PWT6thx0KHDEuIBn7tXayOZzV8S72Cyai5upn02oMqFu1jad1Tk8GtRs0rHwiCKvzdQ+leV3gidWyYv+W/s/fpl3MuicMcMy7ItRWsygVi6FU11wMqWaQ6sUpSEwZn9BxEUSDbBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D010/r2A; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso115667866b.0
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jul 2024 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938663; x=1722543463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=D010/r2AHYzFlQ8u3NQgOYOf57N2p6jHRBpzCZKh7kSEtBJXC2dEV+Pf8vvUAZwSpN
         4esHm1qH5+uWRhuQMOD/w6Thc/NSwkG6Kof48d9Z2bdaeb2BOzwqXhid4MF1cSSJzcai
         6BsLUEiaNha+eiC3I+N3Afe/Jtp0OBFTxAOWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938663; x=1722543463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=fCdOx2BemqQjhhstIyZV/Dxu+IGrAbkWC+D4k71P85ra/xXpWqF4JSmL/OFkud+45q
         OUavHSeS0U7a/1V/qPGY0Rp41tXqtQrlKMMsQm6ShJhsXtpjq9ia3wNDDtNU7+Wo46hd
         MRpBU7fA0h+7WMnZid35M8/su50QN63DZI0eCMbNmQkiGVVQjNx6hG2hlTlUIeQ3/ajc
         wlj7+JbJcStKBGurOgqGGDT1mBM6mxTJ/GAVjsQclb/iEWcWxdPmrpaL3/vpz7qwQl1V
         FEGfPQO37sMU30Nn1rexZdF1ZSCdLNdYB3wHSiaSRYFgeztfp2fEddkNcQmpPFKl3rOp
         Y/5A==
X-Forwarded-Encrypted: i=1; AJvYcCWQB1JYpdNFM8dCzZ5goxwxUg5QzBUJhFCSXh/k5wCqHqAgoClOdmCJT0P0q4ifbQoO3LW3XN9L6fKu7xYDRUUQ/olLduzhtgDKkw==
X-Gm-Message-State: AOJu0Yw1Ih7M08Wcu8iCFlo6Is2CM4SZECkVq0J4QT8SNsZY4gDZkevU
	y5lIVdZRhAyNdZb3DkKMALvhNVKJp5yfx2iXwczZ1ud2fGT8MdLbh3sUjT995q2BojJLCwvUsaz
	ek34=
X-Google-Smtp-Source: AGHT+IHyj0Momm7yHHyUqGvFBqDIS6rYl7glG6tB0yYuTc+w2y03xWDTDmUQw5HYpKyDv7aaa98iPg==
X-Received: by 2002:a17:907:9802:b0:a6f:ddb3:bf2b with SMTP id a640c23a62f3a-a7acb4b33bcmr272335066b.41.1721938663125;
        Thu, 25 Jul 2024 13:17:43 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab28249sm104386366b.30.2024.07.25.13.17.42
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:17:42 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aac70e30dso114594666b.1
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jul 2024 13:17:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8v3XsSxxohQXlFEQ9sgfzA+pEhunkTYjQpp+HRqS2Y3HROyDIoekqRcKPHyKMmNY3vc4xldgcWsnsrHd0UnC1IYGK8i0zZHHJmg==
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

