Return-Path: <linux-sctp+bounces-337-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68129A3367D
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 05:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B11E188AE43
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Feb 2025 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA7157E88;
	Thu, 13 Feb 2025 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYOsHsIj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5798489;
	Thu, 13 Feb 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419221; cv=none; b=mAquhzSJASayWLvK7i0Jm9DixORDGtUATOaPl483VBzVInF6dpbyiFlqvpapSn3Lqhd0LucT6XvXn8d0YHb9AOz40UZuY9U4MnPkn/oUtdwkQStRWqtGWQAOEIrhnpEYXqeWGI8vTLmOXKo9TgSd5etCEgsAvVQkMAW5nSa0dmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419221; c=relaxed/simple;
	bh=dZNORGBz3NcDtpEB3uUrJg6ZoVJ22Z42t2Fey9GqA4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxjUKpIrpngSStwPy+xsv7JPtdFLNQPVfGCd5W0k7TInH8yf036WIntngUYlWFRw+/b91FQ5Otd3BU0bWtxN7q2bxew6WS94kHlvQJakJe1aLOrZ2UyecvwkQCfdDz44sSXfmcTEjaJr9VaCjNJDZdKv/QdrROu1BZ36FQMn7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYOsHsIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB4C4CED1;
	Thu, 13 Feb 2025 04:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419219;
	bh=dZNORGBz3NcDtpEB3uUrJg6ZoVJ22Z42t2Fey9GqA4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GYOsHsIjrXGynCIS2QowD495mj6B/Z9dD3XPNwwyL7QGauWtDceofN35FIkfyAKkM
	 hTqyDO+le74/yCZIt1RAP3RJ7l78PeE43989ypIez7V2Sd/Xcyni+jElqPz1Df7429
	 eKzBztCtKPythTeK0Jy8tyFxiC9Nk9/+YMQwkkIEoZSPTBL3mqwTU71di0adZ5Z3EI
	 FBKVQD3d9m1Kxc6uEqxRUBaWR7DLYtnJP1wE+x6Y9F4PSIBC/KfvDC4Axp/hAb0FHu
	 SzNzMXrG+tE0oWY2RZIPLybNk88XEDQ01mrMid06tqoVQn5biKg/o6iLi32Z+YlWbz
	 6NE1uDX/6I0zA==
Date: Wed, 12 Feb 2025 20:00:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 netdev@vger.kernel.org, linux-sctp@vger.kernel.org, thorsten.blum@linux.dev
Subject: Re: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev
 entry
Message-ID: <20250212200018.2fd04f45@kernel.org>
In-Reply-To: <CADvbK_dFoJ056xR2BW5eZeg_b7ZfHhM9_6iuGM8MbsUJSipm+A@mail.gmail.com>
References: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
	<CADvbK_dtrrU1w6DNyy_OxizNwx_Nv=mjs5xESR+mB8U6=LKXdA@mail.gmail.com>
	<Z6o49-Iv5kCdPwL8@t14s.localdomain>
	<CADvbK_dFoJ056xR2BW5eZeg_b7ZfHhM9_6iuGM8MbsUJSipm+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 14:18:43 -0500 Xin Long wrote:
> > You mean, "also" append, right? And not "instead". Because currently
> > the NET one includes all other files and it doesn't exclude stuff like
> > net/{mptcp,sctp}.  
> I'm thinking it should be "instead".
> 
> Yes, all files under include/net/ are included in the NET, but those files
> (belong to subcomponents/modules) under include/linux/, include/linux/uapi/
> or even include/trace/ are included in their own sections and not in the
> NET, such as:

No strong preference TBH, but I think code and headers should fall
under the same entries. And net/sctp is not X:'ed out of net right 
now.

