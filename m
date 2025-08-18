Return-Path: <linux-sctp+bounces-611-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D917B2AD34
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF731B267B2
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 15:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AF261595;
	Mon, 18 Aug 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8wqW9o6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD01255F28;
	Mon, 18 Aug 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531826; cv=none; b=MxDadK4ZYWKI0rqWDHePpK5U9MrSEWmngf+1ubR2yypZkPsB1ikAH9VTBLrrLvQQmqj+nfpS4ooh5ESoM4MQLlDXClBvt0oFVsuN7wfEC4NRuIhEEOgQAy+x3OZt4YFDkPy76CLEhoe8VYBowmY7KzJrrjYMqRKBjT/AamyK2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531826; c=relaxed/simple;
	bh=VlQ//odG4TiaTTWUSfqhxg//RcOSrv0QF+ehSYeOgdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2X5zNute9ffrDOQtlWVTWGuQGm//QxwYQWrwDKwn+j6YI6LTz1JWlMpQ9iOtLBoRmonVVLNeJkE1+NYze7q6c5qQ39/lMY+vDH9LK207PN9iqKhZ2KM/Xe6pr2ArI11r9l1TqCHqUyoKQfKnHzhCCYg/i2wNgMHLGakLzHU5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8wqW9o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63055C4CEEB;
	Mon, 18 Aug 2025 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531826;
	bh=VlQ//odG4TiaTTWUSfqhxg//RcOSrv0QF+ehSYeOgdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8wqW9o6KU+Bd2HAfhnp6cNx+d92eM893fCVda3iZD4yNK78i579DGXb0uebMXaaM
	 xkDD58RsnPtrv8Vw7ruAYHY2lla44YIh+B+8oC1CQTmJxQW/5eS3Pg7AHN4sh1gHA7
	 7LIBWUxhJn1wJDiG/mr9WAahqVQ8GCwoLJLabKxEZzk9uC9qLLxuvp0R+ObBxpGBsL
	 4gC8kaYNBrTNl5srelFH+bEIBjDXIS7CcB2n/qItqM6WL9M42QZjJnme7srsWFCnyq
	 JkCtyVk03SXACQKeHtD88wcRvciUt+ga4NvghXZmGStgewd4DTpTLXcipgs3aogP3k
	 HdtVNFGcP5cww==
Date: Mon, 18 Aug 2025 08:43:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
Message-ID: <20250818084345.708ac796@kernel.org>
In-Reply-To: <CADvbK_fmCRARc8VznH8cQa-QKaCOQZ6yFbF=1-VDK=zRqv_cXw@mail.gmail.com>
References: <20250813040121.90609-1-ebiggers@kernel.org>
	<20250813040121.90609-4-ebiggers@kernel.org>
	<20250815120910.1b65fbd6@kernel.org>
	<CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
	<20250815215009.GA2041@quark>
	<20250815180617.0bc1b974@kernel.org>
	<CADvbK_fmCRARc8VznH8cQa-QKaCOQZ6yFbF=1-VDK=zRqv_cXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Aug 2025 13:15:12 -0400 Xin Long wrote:
> > > Ideally we'd just fail the write and remove the last mentions of md5 =
and
> > > sha1 from the code.  But I'm concerned there could be a case where
> > > userspace is enabling cookie authentication by setting
> > > cookie_hmac_alg=3Dmd5 or cookie_hmac_alg=3Dsha1, and by just failing =
the
> > > write the system would end up with cookie authentication not enabled.
> > >
> > > It would have been nice if this sysctl had just been a boolean toggle.
> > >
> > > A deprecation warning might be a good idea.  How about the following =
on
> > > top of this patch: =20
> >
> > No strong opinion but I find the deprecation warnings futile.
> > Chances are we'll be printing this until the end of time.
> > Either someone hard-cares and we'll need to revert, or nobody
> > does and we can deprecate today. =20
> Reviewing past network sysctl changes, several commits have simply
> removed or renamed parameters:
>=20
> 4a7f60094411 ("tcp: remove thin_dupack feature")
> 4396e46187ca ("tcp: remove tcp_tw_recycle")
> d8b81175e412 ("tcp: remove sk_{tr}x_skb_cache")
> 3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolicited_na to
> accept_untracked_na")
> 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetim=
es")
>=20
> It seems to me that if we deprecate something, it's okay to change the
> sysctls, so I would prefer rejecting writes with md5 or sha1, or even
> better following Eric=E2=80=99s suggestion and turn this into a simple bo=
olean
> toggle.

Slight preference towards reject. bool is worse in case we need to
revert (if it takes a few releases for the regression report to appear
we may have to maintain backward compat with both string and bool
formats going forward).

