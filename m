Return-Path: <linux-sctp+bounces-612-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E7B2AF74
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C151963219
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487C3570B3;
	Mon, 18 Aug 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwETPAFY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EF32C33A;
	Mon, 18 Aug 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538321; cv=none; b=S35L8KKwUMJjOnVRy0AAJuCXSsR5cGOPWc+nTRcxRQEJUfW2pLTlvs6XqVOsgBIolF7n5sJ5pMK0Ad5s+iJDBecsey783OjW0WTWNsyJssLsxoo9ymltvYiSWSeBB/ki3GhBkAUgQjTh8a2fDZCTaX9UUfx1LFqS7SNw3wq2MTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538321; c=relaxed/simple;
	bh=H3XJRgaBuWjUxBvcJhn7lYFSzPn8j+APk5Bp+Ftotjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMfRJfai7kHvF05OLMAoJU2Fyeeclka0dz9SZKYtchrlR5wd8YV0hwTXe6sfAh/Vt/38D7GliwnWRwt85ZQ2o8buEdw25wq0p486kNWD6aabC79RNfgLm8M9hKmVIB31ygunVXldXfwF05ICSxNv1Lmnpp4WpJLIQ/FTpY9nzxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwETPAFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF044C4CEEB;
	Mon, 18 Aug 2025 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538321;
	bh=H3XJRgaBuWjUxBvcJhn7lYFSzPn8j+APk5Bp+Ftotjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwETPAFYPhRvHA187/GoNvTABpUAnbRv6KXL/RxddDuXvX3tdYzQnyw3MzAHcxAgQ
	 nUhw6LPTAS51HN7/RSmlSJY/PDGZzbs88EBbTlTUYrmUYUB6fhe9cS4ywWwYKLlNar
	 2uGDsa2+F9HucMyRKPeUSe5BSFldO2m++v4xTm+lbsEFFivyYj9YhcHxfPyqKFI7Jn
	 SQflTGv2e+oUYUDhi2GKMBCferFPHZwtvCxEQNOi/kzY+eJ0x9gwQW43FMdQC2Yc70
	 uKZRxPesTxEz26HYl9RE6vPfFETnGuquTpiwSZBN5uCS9rnva61UwLBcyUxbHPgiSg
	 /Fy2VCj4cypGw==
Date: Mon, 18 Aug 2025 17:31:58 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
Message-ID: <20250818173158.GA12939@google.com>
References: <20250813040121.90609-1-ebiggers@kernel.org>
 <20250813040121.90609-4-ebiggers@kernel.org>
 <20250815120910.1b65fbd6@kernel.org>
 <CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
 <20250815215009.GA2041@quark>
 <20250815180617.0bc1b974@kernel.org>
 <CADvbK_fmCRARc8VznH8cQa-QKaCOQZ6yFbF=1-VDK=zRqv_cXw@mail.gmail.com>
 <20250818084345.708ac796@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818084345.708ac796@kernel.org>

On Mon, Aug 18, 2025 at 08:43:45AM -0700, Jakub Kicinski wrote:
> On Sat, 16 Aug 2025 13:15:12 -0400 Xin Long wrote:
> > > > Ideally we'd just fail the write and remove the last mentions of md5 and
> > > > sha1 from the code.  But I'm concerned there could be a case where
> > > > userspace is enabling cookie authentication by setting
> > > > cookie_hmac_alg=md5 or cookie_hmac_alg=sha1, and by just failing the
> > > > write the system would end up with cookie authentication not enabled.
> > > >
> > > > It would have been nice if this sysctl had just been a boolean toggle.
> > > >
> > > > A deprecation warning might be a good idea.  How about the following on
> > > > top of this patch:  
> > >
> > > No strong opinion but I find the deprecation warnings futile.
> > > Chances are we'll be printing this until the end of time.
> > > Either someone hard-cares and we'll need to revert, or nobody
> > > does and we can deprecate today.  
> > Reviewing past network sysctl changes, several commits have simply
> > removed or renamed parameters:
> > 
> > 4a7f60094411 ("tcp: remove thin_dupack feature")
> > 4396e46187ca ("tcp: remove tcp_tw_recycle")
> > d8b81175e412 ("tcp: remove sk_{tr}x_skb_cache")
> > 3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolicited_na to
> > accept_untracked_na")
> > 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
> > 
> > It seems to me that if we deprecate something, it's okay to change the
> > sysctls, so I would prefer rejecting writes with md5 or sha1, or even
> > better following Eric’s suggestion and turn this into a simple boolean
> > toggle.
> 
> Slight preference towards reject. bool is worse in case we need to
> revert (if it takes a few releases for the regression report to appear
> we may have to maintain backward compat with both string and bool
> formats going forward).

To be clear, by "It would have been nice if this sysctl had just been a
boolean toggle", I meant it would have been nice if it had been that way
*originally*.  I wasn't suggesting making that change now.

It would be safest to continue to honor existing attempts to enable
cookie authentication (by writing md5 or sha1), as this patch does.

If you'd prefer that those attempts be rejected instead, I can do that,
but how about I do it as a separate patch on top of this one?  That way
if there's a problem with it, we can just revert that patch, instead of
the entire upgrade to the cookie auth.

- Eric

