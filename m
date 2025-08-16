Return-Path: <linux-sctp+bounces-610-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E06B28FB7
	for <lists+linux-sctp@lfdr.de>; Sat, 16 Aug 2025 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E167567A73
	for <lists+linux-sctp@lfdr.de>; Sat, 16 Aug 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A822FF15D;
	Sat, 16 Aug 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmuuzcEQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8251CAA79;
	Sat, 16 Aug 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755364526; cv=none; b=sVyXWLWUOFtexZkIFbCf5604Bo92ufdGz85PBIu16bhM4lrLoq4DLOLol+bsFKsymGv5kh5mFteC5rbQ5lADnX3umwO/8ZeqsTSD0wt6XopN94Gx9yJVcgeaM/9TqpjTO1/iRWRhKJnKTFk+wWGeDQlosEtSzHC1RzRPgYDN9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755364526; c=relaxed/simple;
	bh=K4A4fEFG9zaHp8aUB7/gVYJy4yr57+8iIHrrHhGBZyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii7iYmA7DTsIy4vnpNuMGMfnjgSxFyVBtV6i/9f98R5jRjAK9S/V5549W1ZTKg4LIUXOGB8tEu8LtCImTsXnD7C3XGKgnEqB5OuN9G/OPSSrLd1erBDvWsKbPUbq65YvkC5QSKT25uvO+/U995CxrJQYA6YzoevcN4lbq7pucOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmuuzcEQ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e57003ee3fso15091225ab.2;
        Sat, 16 Aug 2025 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755364524; x=1755969324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4Fcpgrewxt/uUiQmxZHN0QNTKqCvB9kxme0FcY+XSg=;
        b=YmuuzcEQJwcj2DigZkC05TQ0xJNiscpotsg7+bkOG14QxsDD6YPAwN9wFiOYaiSNOr
         YbCqFsqaFjDGQpz7rYBZPmmjgXup1EToY/h7WDt8y20ga5MjD2n1Ak8CKofW58rTxyjJ
         ele/3EC/Trm6Fh95E2Of5hdIRqOyYEuXtHg6/Gw0BItTirEPzA8NcJ48ibG+DuvWMghR
         LAl7HvP9kal6PEAMLzLrEa2bVq/w7385IOZokrmm/N/xsUZ0/GSnsxz21YyxCSD/HJdB
         r02qHKBmRVd7gYa3ZKPGO+mXNs2K/twKTSmShMTxwNq0TLygFD0pwpf4AKGH9csR6p9o
         WqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755364524; x=1755969324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4Fcpgrewxt/uUiQmxZHN0QNTKqCvB9kxme0FcY+XSg=;
        b=cuKk8mUrdPNthCXKKGmsGCEYXwoqoUpzWGeU/PxqUi+6eO4ZYMAcFrrjcycc+Qy0Oj
         n8NsMdKuEfexRW8n3UQSJHd58S4Sde0mfW26C429p6orAOXeSQ3pNMbTVnr/Q27GTnlU
         mFWF5FO0KreSgjr0VeMKrsqXks+Aw8WfPa0Qz05MeQM9hVsULsg/VBvRz7Tu/F6cC+B9
         470Yj2+WZK4A0McI4gA+fcbSfhR9bRrMy8DsEsV6ULcOn91IKDt7cjZIZgZU8JeiiWwP
         bL2wDko8lYN9lhFNLw5i0jhjaUPTMkqCAHAEkILthMcVvH+0W1DMd+oU5B8D4T62a0ob
         0v1A==
X-Forwarded-Encrypted: i=1; AJvYcCVeyPgSFIyjcN0TDFKfxV+j1jZi8R1ciT3QxiqlmUfHEYX8y2x2vgzxxVFSUym5fqTqPge1rtjCoCqLq2I=@vger.kernel.org, AJvYcCWt54np1JQQGeaCqaLWzHF3uIlfhlse/PAvp+Ow0XLTWe90TRaMnKrLire5rlb5hcKmCvEeEGMsWllrig==@vger.kernel.org, AJvYcCX7lhCykQ9d9kcwJ4WZtotsi9cify/k8I8VPCdUcpoD/qBUvQytWWyhLMMAOgZr6Ltbsxkto3MW@vger.kernel.org
X-Gm-Message-State: AOJu0YxLd0x5Pi+YDFzXb9Y+qZvyHfElktV4u1GhEk5g6tesDu91ljfx
	lYaK8NyXes3C/5OKWumFtG6S52je0dQUmZnNCo0s6ajHLpcieYodoryB7cbqM/tJEG4mMlYdTQJ
	FsxcOsNeDb0AairpFbWXIUhPLtcWug1c=
X-Gm-Gg: ASbGncsTr3FawJE1bk1BewhTEJK3SfJUmtQnwTCqHH278Lm2obO7i27Du1h5wrWrpQJ
	XXsw40BXroxjsgbWVX87LU6WNY8wC63C00vlwwOzAgZhy/dDSh1I/01F1w/qRNaKsslacx5EHBl
	OQITg1H0AxCZQAc0fQ+GeEHvdJJfuT0A2pV51HFQgvB7UgPJd6RBgoZanL1SZVagvCNciz/DCkN
	FwcBbLGqQ==
X-Google-Smtp-Source: AGHT+IFcT5ydlVbC3qjs6NpHcmiDBFj87k2/+lOTsyRL2Q9YmskIV1nfiYDGe0NN02mH7PFvU+P/c/hT2bV+052gXbY=
X-Received: by 2002:a05:6e02:1521:b0:3e5:58d7:98f6 with SMTP id
 e9e14a558f8ab-3e57e9c8c85mr93758295ab.14.1755364523704; Sat, 16 Aug 2025
 10:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813040121.90609-1-ebiggers@kernel.org> <20250813040121.90609-4-ebiggers@kernel.org>
 <20250815120910.1b65fbd6@kernel.org> <CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
 <20250815215009.GA2041@quark> <20250815180617.0bc1b974@kernel.org>
In-Reply-To: <20250815180617.0bc1b974@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 16 Aug 2025 13:15:12 -0400
X-Gm-Features: Ac12FXzEtqXxiDHsQLDzUx9WImMji4xRJnYnA1AWHKFaHYslPCywFMD3NJk13V4
Message-ID: <CADvbK_fmCRARc8VznH8cQa-QKaCOQZ6yFbF=1-VDK=zRqv_cXw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 15 Aug 2025 14:50:09 -0700 Eric Biggers wrote:
> > > > It'd be great to get an ack / review from SCTP maintainers, otherwi=
se
> > > > we'll apply by Monday..
> > > Other than that, LGTM.
> > > Sorry for the late reply, I was running some SCTP-auth related tests
> > > against the patchset.
> >
> > Ideally we'd just fail the write and remove the last mentions of md5 an=
d
> > sha1 from the code.  But I'm concerned there could be a case where
> > userspace is enabling cookie authentication by setting
> > cookie_hmac_alg=3Dmd5 or cookie_hmac_alg=3Dsha1, and by just failing th=
e
> > write the system would end up with cookie authentication not enabled.
> >
> > It would have been nice if this sysctl had just been a boolean toggle.
> >
> > A deprecation warning might be a good idea.  How about the following on
> > top of this patch:
>
> No strong opinion but I find the deprecation warnings futile.
> Chances are we'll be printing this until the end of time.
> Either someone hard-cares and we'll need to revert, or nobody
> does and we can deprecate today.
Reviewing past network sysctl changes, several commits have simply
removed or renamed parameters:

4a7f60094411 ("tcp: remove thin_dupack feature")
4396e46187ca ("tcp: remove tcp_tw_recycle")
d8b81175e412 ("tcp: remove sk_{tr}x_skb_cache")
3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolicited_na to
accept_untracked_na")
5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes=
")

It seems to me that if we deprecate something, it's okay to change the
sysctls, so I would prefer rejecting writes with md5 or sha1, or even
better following Eric=E2=80=99s suggestion and turn this into a simple bool=
ean
toggle.

Thanks.

