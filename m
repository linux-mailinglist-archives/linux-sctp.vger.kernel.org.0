Return-Path: <linux-sctp+bounces-609-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A67B2898E
	for <lists+linux-sctp@lfdr.de>; Sat, 16 Aug 2025 03:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E729BAE36AD
	for <lists+linux-sctp@lfdr.de>; Sat, 16 Aug 2025 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03F127470;
	Sat, 16 Aug 2025 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4+AdEZh"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF6211C;
	Sat, 16 Aug 2025 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306379; cv=none; b=pFApCJpty+WQ0mXPrSdSGGR4WyyacliubTIwXh8HErPrIXzOFTlSMHiiTsmb+jN+o/L2amu6Yhu13ALaw14gi1wU+BNYdTrp8dRknIG011SRP4Q/0tzuMB3bScQkebiumJx79x+8Gcri4u7AMXwrHHInqNJicXFUQ9Pf0naiGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306379; c=relaxed/simple;
	bh=j8n2eSsd2AG/67MW4AiPWaVkcludccC/In5v2LGEuSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSo3qHIEpVXOz95k3r9Jh3N63s0UsbWWqwm9bINZUwjAqXw2PBRxg2rhDKzDtE/obNfmkRcO7fcWWypENQTrHHx48XkoubeitAeuThgd9yczXcMvylVtqUYh39ibqT0eJgo/zFWQLpeTt8EgQc1xG1EbP1vxP1UdGtB/NqWh6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4+AdEZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB34C4CEEB;
	Sat, 16 Aug 2025 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755306378;
	bh=j8n2eSsd2AG/67MW4AiPWaVkcludccC/In5v2LGEuSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R4+AdEZhyHCktIVzxpcmViMCZUbMWKUOuhnUHiAecdI7WMeFtLm4fRdmg78JppZ/8
	 44cdNOaBrIwS52niT3M749qqkK2MQMgPLfrBzQsDEPDblGmqrDHB1njbo3W96IwsZ4
	 k6KYPTqcfBksrMFlcWKPt5gBFW6Kr27TWJeJHb0uiBaxKYLRowadzqbqxiISNaV65C
	 aPpVkFIILL6cZ4I2dp+ksSNd0mAjbP2MJzr+ZaTq76UkpZvtTh0vqLmWw3Fmo1w2j9
	 fY/unQOfB6mDz9ezx3bJPniHUXr+qNh5kgCNJo89QvjNu7qf4yY37AM3/sSzXIT+lF
	 Q0QIl5cpl9VZw==
Date: Fri, 15 Aug 2025 18:06:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
Message-ID: <20250815180617.0bc1b974@kernel.org>
In-Reply-To: <20250815215009.GA2041@quark>
References: <20250813040121.90609-1-ebiggers@kernel.org>
	<20250813040121.90609-4-ebiggers@kernel.org>
	<20250815120910.1b65fbd6@kernel.org>
	<CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
	<20250815215009.GA2041@quark>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 14:50:09 -0700 Eric Biggers wrote:
> > > It'd be great to get an ack / review from SCTP maintainers, otherwise
> > > we'll apply by Monday..  
> > Other than that, LGTM.
> > Sorry for the late reply, I was running some SCTP-auth related tests
> > against the patchset.  
> 
> Ideally we'd just fail the write and remove the last mentions of md5 and
> sha1 from the code.  But I'm concerned there could be a case where
> userspace is enabling cookie authentication by setting
> cookie_hmac_alg=md5 or cookie_hmac_alg=sha1, and by just failing the
> write the system would end up with cookie authentication not enabled.
> 
> It would have been nice if this sysctl had just been a boolean toggle.
> 
> A deprecation warning might be a good idea.  How about the following on
> top of this patch:

No strong opinion but I find the deprecation warnings futile.
Chances are we'll be printing this until the end of time.
Either someone hard-cares and we'll need to revert, or nobody
does and we can deprecate today.

